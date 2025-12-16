export var PinchGestureType;

(function (PinchGestureType) {
    PinchGestureType[PinchGestureType["NONE"] = 0] = "NONE";
    PinchGestureType[PinchGestureType["SHOW_DESKTOP"] = 1] = "SHOW_DESKTOP";
    PinchGestureType[PinchGestureType["CLOSE_WINDOW"] = 2] = "CLOSE_WINDOW";
    PinchGestureType[PinchGestureType["CLOSE_DOCUMENT"] = 3] = "CLOSE_DOCUMENT";
})(PinchGestureType || (PinchGestureType = {}));

export var SwipeGestureType;

(function (SwipeGestureType) {
    SwipeGestureType[SwipeGestureType["NONE"] = 0] = "NONE";
    SwipeGestureType[SwipeGestureType["OVERVIEW_NAVIGATION"] = 1] = "OVERVIEW_NAVIGATION";
    SwipeGestureType[SwipeGestureType["WORKSPACE_SWITCHING"] = 2] = "WORKSPACE_SWITCHING";
    SwipeGestureType[SwipeGestureType["WINDOW_SWITCHING"] = 3] = "WINDOW_SWITCHING";
    SwipeGestureType[SwipeGestureType["VOLUME_CONTROL"] = 4] = "VOLUME_CONTROL";
    SwipeGestureType[SwipeGestureType["BRIGHTNESS_CONTROL"] = 5] = "BRIGHTNESS_CONTROL";
    SwipeGestureType[SwipeGestureType["WINDOW_MANIPULATION"] = 6] = "WINDOW_MANIPULATION";
})(SwipeGestureType || (SwipeGestureType = {}));

export var OverviewNavigationState;

(function (OverviewNavigationState) {
    OverviewNavigationState[OverviewNavigationState["CYCLIC"] = 0] = "CYCLIC";
    OverviewNavigationState[OverviewNavigationState["GNOME"] = 1] = "GNOME";
    OverviewNavigationState[OverviewNavigationState["WINDOW_PICKER_ONLY"] = 2] = "WINDOW_PICKER_ONLY";
})(OverviewNavigationState || (OverviewNavigationState = {}));

export var ForwardBackKeyBinds;

(function (ForwardBackKeyBinds) {
    ForwardBackKeyBinds[ForwardBackKeyBinds["Default"] = 0] = "Default";
    ForwardBackKeyBinds[ForwardBackKeyBinds["Forward/Backward"] = 1] = "Forward/Backward";
    ForwardBackKeyBinds[ForwardBackKeyBinds["Page Up/Down"] = 2] = "Page Up/Down";
    ForwardBackKeyBinds[ForwardBackKeyBinds["Right/Left"] = 3] = "Right/Left";
    ForwardBackKeyBinds[ForwardBackKeyBinds["Audio Next/Prev"] = 4] = "Audio Next/Prev";
    ForwardBackKeyBinds[ForwardBackKeyBinds["Tab Next/Prev"] = 5] = "Tab Next/Prev";
})(ForwardBackKeyBinds || (ForwardBackKeyBinds = {}));
