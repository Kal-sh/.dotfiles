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
    bind_widgets,
    insert_settings_actions,
    ui_file_uri,
} = Me.imports.ddterm.pref.util;

var TextWidget = GObject.registerClass({
    GTypeName: 'DDTermPrefsText',
    Template: ui_file_uri('prefs-text.ui'),
    Children: [
        'custom_font_check',
        'font_chooser',
        'text_blink_mode_combo',
        'cursor_blink_mode_combo',
        'cursor_shape_combo',
        'detect_urls_container',
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
}, class PrefsText extends Gtk.Grid {
    _init(params) {
        super._init(params);

        bind_widget(
            this.settings,
            'use-system-font',
            this.custom_font_check,
            Gio.SettingsBindFlags.INVERT_BOOLEAN
        );

        bind_widget(this.settings, 'custom-font', this.font_chooser);

        bind_sensitive(
            this.settings,
            'use-system-font',
            this.font_chooser.parent,
            true
        );

        bind_widgets(this.settings, {
            'text-blink-mode': this.text_blink_mode_combo,
            'cursor-shape': this.cursor_shape_combo,
            'cursor-blink-mode': this.cursor_blink_mode_combo,
        });

        insert_settings_actions(this, this.settings, [
            'allow-hyperlink',
            'audible-bell',
            'detect-urls',
            'detect-urls-as-is',
            'detect-urls-file',
            'detect-urls-http',
            'detect-urls-voip',
            'detect-urls-email',
            'detect-urls-news-man',
        ]);

        bind_sensitive(this.settings, 'detect-urls', this.detect_urls_container);
    }

    get title() {
        return this.gettext_context.gettext('Text');
    }
});

/* exported TextWidget */
