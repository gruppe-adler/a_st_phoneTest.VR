waitUntil {dialog};

private _dialog = uiNamespace getVariable ['grad_landline_rscRotary',controlNull];
private _ctrl = _dialog displayCtrl 5000;

[{
    params ["_args", "_handle"];
    _args params ["_ctrl"];

    private _currentAngle = ctrlAngle _ctrl;
    _currentAngle params ["_angle", "_centerX", "_centerY"];
    _ctrl ctrlSetAngle [_angle + 1, _centerX, _centerY, true];

}, 0, [_ctrl]] call CBA_fnc_addPerFrameHandler;



// _ctrl ctrlSetAngle [angle, centerX, centerY, now];