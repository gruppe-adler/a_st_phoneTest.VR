params ["_object"];

[player, _object] call GRAD_landline_fnc_callSetOwner;
private _callerPhoneObject = [_object] call GRAD_landline_fnc_callGetCallerObject;

[_object, "calling"] call GRAD_landline_fnc_callSetStatus;


private _receiverNumber = _object getVariable ["GRAD_LANDLINE_NUMBER_ASSIGNED", "no number"];
private _callerNumber = _callerPhoneObject getVariable ["GRAD_LANDLINE_NUMBER_ASSIGNED", "no number"];


// activate tfar
[_callerPhoneObject, _callerNumber] call GRAD_landline_fnc_callPluginActivate;

// register call
[_callerNumber, _receiverNumber] remoteExec ["GRAD_landline_fnc_callRegister", 2];