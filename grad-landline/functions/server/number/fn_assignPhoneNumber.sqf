params ["_object", "_number"];

private _newNumber = [GRAD_LANDLINE_ALLNUMBERS] call GRAD_landline_fnc_generatePhoneNumber;

if (_number != "none") then {
    _newNumber = _number;
};

private _currentNumbers = missionNamespace getVariable ["GRAD_LANDLINE_ALLNUMBERS", []];
_currentNumbers pushback [_object, _newNumber];
missionNamespace setVariable ["GRAD_LANDLINE_ALLNUMBERS", _currentNumbers, true];


_object setVariable ["GRAD_LANDLINE_NUMBER_ASSIGNED", _newNumber, true];