// SPDX-FileCopyrightText: 2023 Aleksandr Mezin <mezin.alexander@gmail.com>
//
// SPDX-License-Identifier: GPL-3.0-or-later

'use strict';

const GLib = imports.gi.GLib;
const GObject = imports.gi.GObject;
const Meta = imports.gi.Meta;

const Me = imports.misc.extensionUtils.getCurrentExtension();
const { WindowMatchGeneric } = Me.imports.ddterm.shell.windowmatch;

function is_wlclipboard(win) {
    if (win.get_client_type() !== Meta.WindowClientType.WAYLAND)
        return false;

    if (win.title !== 'wl-clipboard')
        return false;

    const pid = win.get_pid();

    try {
        const [, bytes] = GLib.file_get_contents(`/proc/${pid}/cmdline`);
        const argv0_bytes = bytes.slice(0, bytes.indexOf(0));
        const argv0 = new TextDecoder().decode(argv0_bytes);
        return ['wl-copy', 'wl-paste'].includes(GLib.path_get_basename(argv0));
    } catch {
        return false;
    }
}

/* exported is_wlclipboard */

var WlClipboardActivator = GObject.registerClass({
}, class DDTermWlClipboardActivator extends WindowMatchGeneric {
    _init(params) {
        super._init({
            track_signals: [
                'notify::title',
                'shown',
            ],
            ...params,
        });
    }

    check_window(win) {
        if (win.get_client_type() !== Meta.WindowClientType.WAYLAND)
            return GLib.SOURCE_REMOVE;

        if (!win.title)
            return GLib.SOURCE_CONTINUE;

        if (!is_wlclipboard(win))
            return GLib.SOURCE_REMOVE;

        if (win.is_hidden())
            return GLib.SOURCE_CONTINUE;

        win.focus(global.get_current_time());
        return GLib.SOURCE_REMOVE;
    }
});

/* exported WlClipboardActivator */
