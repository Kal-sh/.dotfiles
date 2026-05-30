export var PinchGestureType;

(function (PinchGestureType) {
    PinchGestureType[PinchGestureType["NONE"] = 0] = "NONE";
    PinchGestureType[PinchGestureType["SHOW_DESKTOP"] = 1] = "SHOW_DESKTOP";
    PinchGestureType[PinchGestureType["OPEN_CLOSE_WINDOW"] = 2] = "OPEN_CLOSE_WINDOW";
    PinchGestureType[PinchGestureType["OPEN_CLOSE_DOCUMENT"] = 3] = "OPEN_CLOSE_DOCUMENT";
    PinchGestureType[PinchGestureType["SHOW_NOTIFICATION_LIST"] = 4] = "SHOW_NOTIFICATION_LIST";
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

export var WorkspaceSwitchingState;

(function (WorkspaceSwitchingState) {
    WorkspaceSwitchingState[WorkspaceSwitchingState["DEFAULT"] = 0] = "DEFAULT";
    WorkspaceSwitchingState[WorkspaceSwitchingState["CYCLIC"] = 1] = "CYCLIC";
})(WorkspaceSwitchingState || (WorkspaceSwitchingState = {}));

export var ForwardBackKeyBinds;

(function (ForwardBackKeyBinds) {
    ForwardBackKeyBinds[ForwardBackKeyBinds["Default"] = 0] = "Default";
    ForwardBackKeyBinds[ForwardBackKeyBinds["Forward/Backward"] = 1] = "Forward/Backward";
    ForwardBackKeyBinds[ForwardBackKeyBinds["Page Up/Down"] = 2] = "Page Up/Down";
    ForwardBackKeyBinds[ForwardBackKeyBinds["Right/Left"] = 3] = "Right/Left";
    ForwardBackKeyBinds[ForwardBackKeyBinds["Audio Next/Prev"] = 4] = "Audio Next/Prev";
    ForwardBackKeyBinds[ForwardBackKeyBinds["Tab Next/Prev"] = 5] = "Tab Next/Prev";
})(ForwardBackKeyBinds || (ForwardBackKeyBinds = {}));
