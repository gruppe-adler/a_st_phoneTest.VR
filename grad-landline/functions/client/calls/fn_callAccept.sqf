params ["_object"];

[player, _object] call GRAD_landline_fnc_callSetOwner;
private _calledPhoneObject = [_object] call GRAD_landline_fnc_callGetCallerObject;

[_object, "calling"] call GRAD_landline_fnc_callSetStatus;


private _receiverNumber = _object getVariable ["GRAD_LANDLINE_NUMBER_ASSIGNED", "no number"];
private _callerNumber = _calledPhoneObject getVariable ["GRAD_LANDLINE_NUMBER_ASSIGNED", "no number"];


// activate tfar
[_calledPhoneObject, _callerNumber, _object] call GRAD_landline_fnc_callPluginActivate;

// register call
[_object, _calledPhoneObject] remoteExec ["GRAD_landline_fnc_callRegister", 2];