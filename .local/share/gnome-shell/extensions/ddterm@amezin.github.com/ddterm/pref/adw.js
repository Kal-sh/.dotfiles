// SPDX-FileCopyrightText: 2023 Aleksandr Mezin <mezin.alexander@gmail.com>
//
// SPDX-License-Identifier: GPL-3.0-or-later

'use strict';

const GObject = imports.gi.GObject;
const Gio = imports.gi.Gio;
const Adw = imports.gi.Adw;

const Me = imports.misc.extensionUtils.getCurrentExtension();
const { AnimationWidget } = Me.imports.ddterm.pref.animation;
const { BehaviorWidget } = Me.imports.ddterm.pref.behavior;
const { ColorsWidget } = Me.imports.ddterm.pref.colors;
const { CommandWidget } = Me.imports.ddterm.pref.command;
const { CompatibilityWidget } = Me.imports.ddterm.pref.compatibility;
const { PanelIconWidget } = Me.imports.ddterm.pref.panelicon;
const { PositionSizeWidget } = Me.imports.ddterm.pref.positionsize;
const { ScrollingWidget } = Me.imports.ddterm.pref.scrolling;
const { ShortcutsWidget } = Me.imports.ddterm.pref.shortcuts;
const { TabsWidget } = Me.imports.ddterm.pref.tabs;
const { TextWidget } = Me.imports.ddterm.pref.text;

const Page = GObject.registerClass({
    Properties: {
        'settings': GObject.ParamSpec.object(
            'settings',
            '',
            '',
            GObject.ParamFlags.READWRITE | GObject.ParamFlags.CONSTRUCT_ONLY,
            Gio.Settings
        ),
        'gettext-context': GObject.ParamSpec.jsobject(
            'gettext-context',
            '',
            '',
            GObject.ParamFlags.READWRITE | GObject.ParamFlags.CONSTRUCT_ONLY
        ),
    },
}, class DDTermPrefsPage extends Adw.PreferencesPage {
    add_widget(widget_type) {
        const widget = new widget_type({
            settings: this.settings,
            gettext_context: this.gettext_context,
        });

        const group = new Adw.PreferencesGroup({
            title: widget.title,
        });

        group.add(widget);
        this.add(group);

        return widget;
    }
});

var WindowPage = GObject.registerClass({
    Properties: {
        'monitors': GObject.ParamSpec.object(
            'monitors',
            '',
            '',
            GObject.ParamFlags.READWRITE | GObject.ParamFlags.EXPLICIT_NOTIFY,
            Gio.ListModel
        ),
    },
}, class DDTermWindowPrefsPage extends Page {
    _init(params) {
        super._init({
            name: 'window',
            icon_name: 'preferences-desktop-display',
            ...params,
        });

        this.title = this.gettext_context.gettext('Window');

        this.bind_property(
            'monitors',
            this.add_widget(PositionSizeWidget),
            'monitors',
            GObject.BindingFlags.SYNC_CREATE
        );

        [
            BehaviorWidget,
            AnimationWidget,
            TabsWidget,
        ].forEach(widget_type => this.add_widget(widget_type));
    }
});

/* exported WindowPage */

var TerminalPage = GObject.registerClass({
}, class DDTermTerminalPrefsPage extends Page {
    _init(params) {
        super._init({
            name: 'terminal',
            icon_name: 'utilities-terminal',
            ...params,
        });

        this.title = this.gettext_context.gettext('Terminal');

        [
            TextWidget,
            ColorsWidget,
            CommandWidget,
            ScrollingWidget,
            CompatibilityWidget,
        ].forEach(widget_type => this.add_widget(widget_type));
    }
});

/* exported TerminalPage */

var ShortcutsPage = GObject.registerClass({
}, class DDTermShortcutsPrefsPage extends Page {
    _init(params) {
        super._init({
            name: 'shortcuts',
            icon_name: 'preferences-desktop-keyboard-shortcuts',
            ...params,
        });

        this.title = this.gettext_context.gettext('Keyboard Shortcuts');

        this.add_widget(ShortcutsWidget);
    }
});

/* exported ShortcutsPage */

var MiscPage = GObject.registerClass({
}, class DDTermMiscPrefsPage extends Page {
    _init(params) {
        super._init({
            name: 'misc',
            icon_name: 'preferences-other',
            ...params,
        });

        this.title = this.gettext_context.gettext('Miscellaneous');

        this.add_widget(PanelIconWidget);
    }
});

/* exported MiscPage */
