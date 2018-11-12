params [["_phone1", objNull], ["_phone2", objNull], ["_player1", objNull], ["_player2", objNull]];

private _number1 = _phone1 getVariable ["GRAD_LANDLINE_NUMBER_ASSIGNED", "no number"];
private _number2 = _phone2 getVariable ["GRAD_LANDLINE_NUMBER_ASSIGNED", "no number"];

private _id = _number1 + _number2;

private _identifier = format ["GRAD_landline_runningCall_%1", _id];

missionNamespace setVariable [
    _identifier, 
    [_phone1, _phone2, _player1, _player2], 
    true
];