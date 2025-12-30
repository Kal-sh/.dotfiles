const {
	      gi  : { GLib },
	      ui  : {
		      main     : {
			      sessionMode,
			      panel: { statusArea: { aggregateMenu } }
		      },
		      popupMenu: { PopupSeparatorMenuItem, PopupSwitchMenuItem }
	      },
	      misc: { extensionUtils }
      } = imports;

const { common } = extensionUtils.getCurrentExtension().imports;

let mySeparator;
let mySwitch;
let myMenuConnection;
let mySwitchConnection;
let myTimeout;
let myCpuType = common.CPU_NOT_SUPPORTED;
let initial   = true;
let menu;

function init()
{
	extensionUtils.initTranslations();
}

function enable()
{
	// GNOME calls enable on every unlock. This code here needs to run only the first time, on user log-in
	if ( initial )
	{
		// Give time for Power Profiles menu to appear. Also, the same timeout is used for persistent boost set
		myTimeout = GLib.timeout_add( GLib.PRIORITY_DEFAULT, 5000, _ =>
		{
			// Support systems without power-profiles-daemon. Good example is Pop!_OS 22.04 which introduced its own
			// power profiles switcher, located inside the Power menu
			menu      = aggregateMenu._powerProfiles?._item.visible ? aggregateMenu._powerProfiles._item.menu : aggregateMenu._power._item.menu;
			// Things depend on CPU type, so get it before everything else
			myCpuType = common.getMyCpuType();

			if ( myCpuType !== common.CPU_NOT_SUPPORTED )
			{
				const state    = common.getBoostState( myCpuType );
				const settings = extensionUtils.getSettings();

				// Make sure we do not come here this session
				initial = false;

				// Turn off if it is on now, user has opted-in for persistence and the last time he turned off Boost
				if ( state && settings.get_boolean( 'persist' ) && !settings.get_boolean( 'boost' ) )
				{
					setBoostState( false );
				}
				else
				{
					// Always set state. This clears use cases of this sort:
					// 1. Disable Boost
					// 2. Reboot (this will enable Boost)
					// 3. Enable Persist (while Boost is on)
					// 4. Reboot
					// User will be prompted to disable Boost since setting is remembered from the last time he clicked
					// the switch. Clear it here, so that doesn't happen.
					settings.set_boolean( 'boost', state );
				}
			}

			setupMenu();
		} );
	}

	setupMenu();
}

function disable()
{
	// Redundancy. Items are destroyed when menu closes, but still...
	destroyMyItems();

	if ( myMenuConnection )
	{
		menu.disconnect( myMenuConnection );
	}

	GLib.Source.remove( myTimeout );

	myMenuConnection = myTimeout = null;

	// If user disabled the extension, bring back Boost to on (and save boolean)
	if ( myCpuType !== common.CPU_NOT_SUPPORTED && sessionMode.currentMode === 'user' && !common.getBoostState( myCpuType ) )
	{
		setBoostState( true );
	}
}

function setBoostState( state )
{
	const settings = extensionUtils.getSettings();
	// Moved to the set_boost file. Reason - more meaningful pkexec message
	/*const [ setting, value ] = [
	 [ 'intel_pstate/no_turbo', Number( !state ) ],
	 [ 'cpufreq/boost', Number( state ) ]
	 ][ myCpuType ];

	 GLib.spawn_command_line_async( `pkexec bash -c "echo ${value} > /sys/devices/system/cpu/${setting}"` );*/

	common.pkexecCommand(
		[
			extensionUtils.getCurrentExtension().dir.get_child( 'set_boost' ).get_path(),
			// Subprocess is not happy if we leave those as numbers
			myCpuType.toString(),
			Number( state ).toString(),
			settings.get_string( `epp-${state ? 'on' : 'off'}` ),
			settings.get_int( `epb-${state ? 'on' : 'off'}` ).toString()
		] )
		.then( _ => settings.set_boolean( 'boost', state ) )
		// We come here if something goes wrong inside the set_boost - we now have 3 things going on there
		// for Intel CPUs. Setting the Boost is actually last, so if any error occurs, boost will not be changed.
		// Reflect that on the UI (which is still visible if Polkit rules are added and no dialog appeared)
		.catch( _ => mySwitch?.setToggleState( !mySwitch.state ) );

	// Destroy init timeout
	return false;
}

function setupMenu()
{
	if ( myCpuType !== common.CPU_NOT_SUPPORTED )
	{
		myMenuConnection = menu.connect( 'open-state-changed', ( { box }, open ) =>
		{
			if ( open )
			{
				const state = common.getBoostState( myCpuType );

				// Do not add switch if CPU not supported
				if ( state !== null )
				{
					mySeparator = new PopupSeparatorMenuItem;
					mySwitch    = new PopupSwitchMenuItem( extensionUtils.gettext( 'Frequency Boost' ), state );

					mySwitchConnection = mySwitch.connect( 'toggled', ( { _switch: { state } } ) => setBoostState( state ) );

					box.insert_child_at_index( mySeparator, 0 );
					box.insert_child_at_index( mySwitch, 0 );
				}
			}
			else
			{
				destroyMyItems();
			}
		} );
	}
}

function destroyMyItems()
{
	mySwitch?.disconnect( mySwitchConnection );

	mySeparator?.destroy();
	mySwitch?.destroy();

	mySeparator = mySwitch = mySwitchConnection = null;
}