params ["_receiverPhoneObject"];

[player, _receiverPhoneObject] call GRAD_landline_fnc_callSetOwner;

private _callerPhoneObject = _receiverPhoneObject getVariable ["GRAD_landline_calledBy", objNull];
_receiverPhoneObject setVariable ["GRAD_landline_isCalled", false, true];
[_receiverPhoneObject, "calling"] call GRAD_landline_fnc_callSetStatus;

private _receiverNumber = _receiverPhoneObject getVariable ["GRAD_LANDLINE_NUMBER_ASSIGNED", "no number"];
private _callerNumber = _callerPhoneObject getVariable ["GRAD_LANDLINE_NUMBER_ASSIGNED", "no number"];

// register call
[_callerNumber, _receiverNumber] remoteExec ["GRAD_landline_fnc_callRegister", 2];