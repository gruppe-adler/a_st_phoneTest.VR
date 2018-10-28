/*

	can be called out of 3DEN init of object:

	[this] call GRAD_landline_fnc_addPhone;

*/


params ["_object", ["_number", "none"]];


if (!isServer) exitWith {};


_object setVariable ["GRAD_landline_isPhone", true, true];


[_object, _number] call GRAD_landline_fnc_assignPhoneNumber;
[_object, "idle"] call GRAD_landline_fnc_callSetStatus;

[_object] remoteExec ["GRAD_landline_fnc_addAction", [0,-2] select isDedicated, true];