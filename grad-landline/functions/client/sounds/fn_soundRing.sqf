params ["_object"];

[{
    params ["_args", "_handle"];
    _args params ["_object"];

    if (isNull _object) exitWith { [_handle] call CBA_fnc_removePerFrameHandler; };

    _object say3D [(selectRandom ["GRAD_landline_phoneRing1", "GRAD_landline_phoneRing2"]), 50];
    systemChat "ring";

}, 3, [_object]] call CBA_fnc_addPerFrameHandler;