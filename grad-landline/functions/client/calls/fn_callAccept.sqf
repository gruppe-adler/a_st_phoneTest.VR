params ["_receiverPhoneObject"];

private _callerPhoneObject = _receiverPhoneObject getVariable ["GRAD_landline_calledBy", objNull];
[_receiverPhoneObject, "calling"] call GRAD_landline_fnc_callSetStatus;

// register call
[_callerPhoneObject, _receiverPhoneObject] remoteExec ["GRAD_landline_fnc_callRegister", 2];