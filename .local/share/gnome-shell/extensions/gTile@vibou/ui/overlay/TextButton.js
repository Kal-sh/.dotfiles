import GObject from "gi://GObject";
import St from "gi://St";
export default GObject.registerClass({
    GTypeName: "GTileOverlayTextButton",
    Properties: {
        "active": GObject.ParamSpec.boolean("active", "Active", "Whether the button state is active", GObject.ParamFlags.READWRITE, false),
    }
}, class extends St.Button {
    _active;
    static new_themed({ theme, ...params }) {
        return this.new_styled({
            ...params,
            style_class: `${theme}__preset-button`,
        });
    }
    static new_styled({ active = false, ...params }) {
        const instance = new this({
            reactive: true,
            can_focus: true,
            track_hover: true,
            ...params,
        });
        instance.active = active;
        return instance;
    }
    set active(b) {
        this._active = b;
        this._updateState();
        this.notify("active");
    }
    get active() {
        return this._active;
    }
    _updateState() {
        if (this._active) {
            this.add_style_pseudo_class("activate");
        }
        else {
            this.remove_style_pseudo_class("activate");
        }
    }
});
