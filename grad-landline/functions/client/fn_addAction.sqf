/*
private _callAction = ["startCall", "Call someone", "", {
    [] call GRAD_landline_fnc_startCall;
},
{true}] call ace_interact_menu_fnc_createAction;

["Land_PhoneBooth_02_F", 0, ["ACE_MainActions"], _callAction, true] call ace_interact_menu_fnc_addActionToClass;
["Land_PhoneBooth_02_malden_F", 0, ["ACE_MainActions"], _callAction, true] call ace_interact_menu_fnc_addActionToClass;
*/

params ["_object"];

_object addAction [
    "Call Number",
    {
        params ["_target", "_caller", "_actionId", "_arguments"];

            [_target] call GRAD_landline_fnc_callStart;
    },
    [],1.5,true,true,"",
    "_this distance _target < 2 && (!(player getVariable ['GRAD_landline_isCalling', false]))"
];

_object addAction [
    "End Call",
    {
        params ["_target", "_caller", "_actionId", "_arguments"];
            [_target] call GRAD_landline_fnc_callEnd;   
    },
    [],1.5,true,true,"",
    "_this distance _target < 2 && (player getVariable ['GRAD_landline_isCalling', false])"
];