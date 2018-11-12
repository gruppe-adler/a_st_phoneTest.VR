params ["_id"];

private _identifier = format ["GRAD_landline_runningCall_%1", _id];

private _storedData = missionNamespace getVariable [
    _identifier, 
    []
];

_storedData params ["_phone1", "_phone2", "_player1", "_player2"];