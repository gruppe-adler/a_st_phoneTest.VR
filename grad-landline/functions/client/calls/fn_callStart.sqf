params ["_callerPhoneObject", "_receiverPhoneObject"];

[_callerPhoneObject, _receiverPhoneObject, "calling"] remoteExec ["GRAD_landline_fnc_callRegister", 2];