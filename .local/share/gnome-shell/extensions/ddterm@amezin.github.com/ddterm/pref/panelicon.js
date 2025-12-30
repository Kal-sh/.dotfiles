// SPDX-FileCopyrightText: 2022 Aleksandr Mezin <mezin.alexander@gmail.com>
//
// SPDX-License-Identifier: GPL-3.0-or-later

'use strict';

const GObject = imports.gi.GObject;
const Gio = imports.gi.Gio;
const Gtk = imports.gi.Gtk;

const Me = imports.misc.extensionUtils.getCurrentExtension();
const { insert_settings_actions, ui_file_uri } = Me.imports.ddterm.pref.util;

var PanelIconWidget = GObject.registerClass({
    GTypeName: 'DDTermPrefsPanelIcon',
    Template: ui_file_uri('prefs-panel-icon.ui'),
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
}, class PrefsPanelIcon extends Gtk.Box {
    _init(params) {
        super._init(params);

        insert_settings_actions(this, this.settings, ['panel-icon-type']);
    }

    get title() {
        return this.gettext_context.gettext('Panel Icon');
    }
});

/* exported PanelIconWidget */
