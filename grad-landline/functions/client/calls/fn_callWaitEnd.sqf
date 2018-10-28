params ["_callerPhoneObject"];

player setVariable ["GRAD_landline_objReceiver", objNull];
player setVariable ["GRAD_landline_objCaller", objNull];


private _callerNumber = _callerPhoneObject getVariable ["GRAD_LANDLINE_NUMBER_ASSIGNED", "no number"];
[_callerPhoneObject, _callerNumber] call GRAD_landline_fnc_callPluginDeactivate;

_callerPhoneObject setVariable ['GRAD_landline_phoneStatus', 'idle'];

[player, "phoneHangUp"] remoteExec ["say3D", [0,-2] select isDedicated];

systemChat "hanging up";