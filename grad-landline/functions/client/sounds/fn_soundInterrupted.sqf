params ["_object"];

[{
    params ["_args", "_handle"];
    _args params ["_object"];

    if ([_object] call GRAD_landline_fnc_callGetStatus != "ending") exitWith { 
        [_handle] call CBA_fnc_removePerFrameHandler; 
    };

    player say (selectRandom ["GRAD_landline_phoneBusy1", "GRAD_landline_phoneBusy2", "GRAD_landline_phoneBusy3"]);
    systemChat "ending beep";

}, 0.5, [_object]] call CBA_fnc_addPerFrameHandler;