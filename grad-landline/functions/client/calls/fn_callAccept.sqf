/*
    
    callAccept is always executed by player2

*/

params ["_object"];

private _storedData = [_object] call GRAD_landline_fnc_callGetInfo;

_storedData params [
    ["_phone1", objNull], 
    ["_phone2", _object], 
    ["_number1", "undefined"], 
    ["_number2", "undefined"], 
    ["_player1", objNull], 
    ["_player2", player]
];

[player, _phone2] call GRAD_landline_fnc_callSetOwner;

[_phone2, "calling"] call GRAD_landline_fnc_callSetStatus;

// activate tfar
[_phone2, _number1 + _number2] call GRAD_landline_fnc_callPluginActivate;

// register call
[_object, _calledPhoneObject] remoteExec ["GRAD_landline_fnc_callRegister", 2];