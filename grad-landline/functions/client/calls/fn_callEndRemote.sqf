/*
    
    called by external partner hanging up

*/

params ["_callerPhoneObject"];

private _receiverPhoneObject = player getVariable ["GRAD_landline_objReceiver", objNull];

private _callerNumber = _callerPhoneObject getVariable ["GRAD_LANDLINE_NUMBER_ASSIGNED", "no number"];
private _receiverNumber = _receiverPhoneObject getVariable ["GRAD_LANDLINE_NUMBER_ASSIGNED", "no number"];

// if no number is assigned
if (count _callerNumber isEqualTo 0) exitWith { diag_log "error, no number"; };

[_callerPhoneObject, _callerNumber] call GRAD_landline_fnc_callPluginDeactivate;

player setVariable ["GRAD_landline_objReceiver", objNull];

[_callerPhoneObject, "idle"] call GRAD_landline_fnc_callSetStatus;
[_receiverPhoneObject, "ending"] call GRAD_landline_fnc_callSetStatus;

[_callerPhoneObject, "GRAD_landline_phoneHangUp"] remoteExec ["say3D", [0,-2] select isDedicated];
systemChat "hanging up from calling";