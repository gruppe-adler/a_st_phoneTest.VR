params ["_callerPhoneObject"];
private _receiverPhoneObject = player getVariable ["GRAD_landline_objReceiver", objNull];


player setVariable ["GRAD_landline_objReceiver", objNull];
player setVariable ["GRAD_landline_objCaller", objNull];


private _callerNumber = _callerPhoneObject getVariable ["GRAD_LANDLINE_NUMBER_ASSIGNED", "no number"];
[_callerPhoneObject, _callerNumber] call GRAD_landline_fnc_callPluginDeactivate;

if ([_receiverPhoneObject] call GRAD_landline_callGetStatus == "ringing") then {
    [_receiverPhoneObject, "idle"] call GRAD_landline_fnc_callSetStatus;
};

[_callerPhoneObject, "idle"] call GRAD_landline_fnc_callSetStatus;

[_callerPhoneObject, "GRAD_landline_phoneHangUp"] remoteExec ["say3D", [0,-2] select isDedicated];

systemChat "hanging up from waiting";