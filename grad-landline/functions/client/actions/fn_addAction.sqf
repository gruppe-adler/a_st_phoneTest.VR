/*
private _callAction = ["startCall", "Call someone", "", {
    [] call GRAD_landline_fnc_startCall;
},
{true}] call ace_interact_menu_fnc_createAction;

["Land_PhoneBooth_02_F", 0, ["ACE_MainActions"], _callAction, true] call ace_interact_menu_fnc_addActionToClass;
["Land_PhoneBooth_02_malden_F", 0, ["ACE_MainActions"], _callAction, true] call ace_interact_menu_fnc_addActionToClass;
*/

params ["_object"];

if (isNull _object) exitWith { diag_log format ["GRAD_landline: cant add action to deleted object %1", _object]; };


// todo make ace interact instead of mousewheel menu
_object addAction [
    "Call Number",
    {
        params ["_target", "_caller", "_actionId", "_arguments"];

            [_target] call GRAD_landline_fnc_createPhoneList;
    },
    [],1.5,true,true,"",
    "_this distance _target < 2 && 
    (_target getVariable ['GRAD_landline_phoneStatus', 'idle'] == 'idle') && 
    (!(player getVariable ['GRAD_landline_isCalling', false]))"
];

_object addAction [
    "Accept Call",
    {
        params ["_target", "_caller", "_actionId", "_arguments"];

            [_target] call GRAD_landline_fnc_callAccept;
    },
    [],1.5,true,true,"",
    "_this distance _target < 2 && 
    (_target getVariable ['GRAD_landline_phoneStatus', 'idle'] == 'ringing')"
];

_object addAction [
    "End Call",
    {
        params ["_target", "_caller", "_actionId", "_arguments"];
            if (_target getVariable ['GRAD_landline_phoneStatus', 'idle'] == 'calling') then {
                [_target] call GRAD_landline_fnc_callEnd;
            } else {
                [_target] call GRAD_landline_fnc_callWaitEnd;
            };
    },
    [],1.5,true,true,"",
    "_this distance _target < 2 &&
    (_target getVariable ['GRAD_landline_phoneStatus', 'idle'] == 'calling') ||
    _this distance _target < 2 &&
    (_target getVariable ['GRAD_landline_phoneStatus', 'idle'] == 'waiting')"
];

_object addAction [
    "Show Number",
    {
        params ["_target", "_caller", "_actionId", "_arguments"];

            hint format ["%1", _target getVariable ["GRAD_LANDLINE_NUMBER_ASSIGNED","no Number"]];
    },
    [],1.5,true,true,"",
    "_this distance _target < 2"
];