params ["_callerPhoneObject"];

[{
    params ["_args", "_handle"];
    _args params ["_callerPhoneObject"];

    if (!([_callerPhoneObject, "waiting"] call GRAD_landline_fnc_callGetStatus)) exitWith { 
        [_handle] call CBA_fnc_removePerFrameHandler; 
    };

    player say (selectRandom ["GRAD_landline_phoneBusy1", "GRAD_landline_phoneBusy2", "GRAD_landline_phoneBusy3"]);
    systemChat "busybeep";

}, 1, [_callerPhoneObject]] call CBA_fnc_addPerFrameHandler;