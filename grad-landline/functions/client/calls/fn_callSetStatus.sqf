params ["_object", "_status"];

_object setVariable ["GRAD_landline_phoneStatus", _status, true];

if (_status == "calling") then {
    _object setVariable ["GRAD_landline_phoneCaller", player];
};