params ["_phoneObject"];

private _lineNumber = _phoneObject getVariable ["GRAD_LANDLINE_NUMBER_ASSIGNED", []];

if (count _lineNumber isEqualTo 0) exitWith {
	diag_log "error, no number";
};