params ["_callerPhoneObject", "_receiverPhoneObject"];

private _callerNumber = _callerPhoneObject getVariable ["GRAD_LANDLINE_NUMBER_ASSIGNED", []];
private _receiverNumber = _receiverPhoneObject getVariable ["GRAD_LANDLINE_NUMBER_ASSIGNED", []];

// if no number is assigned
if (count _callerNumber isEqualTo 0) exitWith { diag_log "error, no number"; };


[_callerPhoneObject, _callerNumber] call GRAD_landline_fnc_callPluginDeactivate;

[_callerNumber, _receiverNumber] remoteExec ["GRAD_landline_fnc_callUnregister", 2];