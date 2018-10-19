params ["_object"];


private _newNumber = [GRAD_LANDLINE_ALLNUMBERS] call GRAD_landline_fnc_generatePhoneNumber;

GRAD_LANDLINE_ALLNUMBERS append _newNumber;
publicVariable "GRAD_LANDLINE_ALLNUMBERS";


_object setVariable ["GRAD_LANDLINE_NUMBER_ASSIGNED", _newNumber, true];