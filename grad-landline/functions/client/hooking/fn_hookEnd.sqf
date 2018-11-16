params ["_object"];

// storedData
private _storedData = [_object] call GRAD_landline_fnc_callGetInfo;

_storedData params [
    ["_phone1", objNull], 
    ["_phone2", objNull], 
    ["_number1", "undefined"], 
    ["_number2", "undefined"], 
    ["_player1", objNull], 
    ["_player2", objNull]
];



// tfar
[_object, _number1 + _number2] call GRAD_landline_fnc_callPluginDeactivate;

// debug whats happening
systemChat "hanging up from hooking";
player setVariable ['GRAD_landline_hooking', false];