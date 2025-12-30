// SPDX-FileCopyrightText: 2022 Aleksandr Mezin <mezin.alexander@gmail.com>
//
// SPDX-License-Identifier: GPL-3.0-or-later

'use strict';

const GObject = imports.gi.GObject;
const Gio = imports.gi.Gio;
const Gtk = imports.gi.Gtk;

const Me = imports.misc.extensionUtils.getCurrentExtension();
const {
    bind_sensitive,
    bind_widget,
    insert_settings_actions,
    ui_file_uri,
} = Me.imports.ddterm.pref.util;

var ScrollingWidget = GObject.registerClass({
    GTypeName: 'DDTermPrefsScrolling',
    Template: ui_file_uri('prefs-scrolling.ui'),
    Children: [
        'scrollback_spin',
        'limit_scrollback_check',
    ],
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
}, class PrefsScrolling extends Gtk.Grid {
    _init(params) {
        super._init(params);

        insert_settings_actions(this, this.settings, [
            'show-scrollbar',
            'scroll-on-output',
            'scroll-on-keystroke',
        ]);

        bind_widget(
            this.settings,
            'scrollback-unlimited',
            this.limit_scrollback_check,
            Gio.SettingsBindFlags.INVERT_BOOLEAN
        );

        bind_widget(this.settings, 'scrollback-lines', this.scrollback_spin);

        bind_sensitive(
            this.settings,
            'scrollback-unlimited',
            this.scrollback_spin.parent,
            true
        );
    }

    get title() {
        return this.gettext_context.gettext('Scrolling');
    }
});

/* exported ScrollingWidget */
