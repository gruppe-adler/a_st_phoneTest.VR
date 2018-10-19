/*

	can be called out of 3DEN init of object:

	[this] call GRAD_landline_fnc_addPhone;

*/


params ["_object"];


if (!isServer) exitWith {};


_object setVariable ["GRAD_landline_isPhone", true, true];#


[_object] call GRAD_landline_fnc_assignPhoneNumber;


[_object] remoteExec ["GRAD_landline_fnc_addAction", [0,-2] select isDedicated, true];