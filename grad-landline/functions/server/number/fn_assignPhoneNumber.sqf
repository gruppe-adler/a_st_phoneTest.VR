params ["_object"];

private _newNumber = [GRAD_LANDLINE_ALLNUMBERS] call GRAD_landline_fnc_generatePhoneNumber;

private _currentNumber = missionNamespace getVariable ["GRAD_LANDLINE_ALLNUMBERS", []];
_currentNumber append [_object, _newNumber];
missionNamespace setVariable ["GRAD_LANDLINE_ALLNUMBERS", _currentNumber, true];


_object setVariable ["GRAD_LANDLINE_NUMBER_ASSIGNED", _newNumber, true];