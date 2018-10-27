params ["_control", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];

private _position = _control ctrlMapScreenToWorld [_xPos, _yPos];

private _nearestPhone = objNull;
private _nearestPhoneIndex = 0;
private _allNumbers = missionNamespace getVariable ["GRAD_LANDLINE_ALLNUMBERS", []];
{
    private _phoneObject = _x select 0;
    private _positionPhoneObject = position _phoneObject;

    if (isNull _nearestPhone) then {
        _nearestPhone = _phoneObject;
    };

    if (_positionPhoneObject distance2D _position < (position _nearestPhone) distance2D _position) then {
        _nearestPhone = _phoneObject;
        _nearestPhoneIndex = _forEachIndex;
    };
} forEach _allNumbers;

private _dialog = uiNamespace getVariable ['grad_landline_rscPhoneBook',controlNull];

if (isNull _dialog) exitWith { hint "something went wrong"; };

private _phoneList = _dialog displayCtrl 1000;
_phoneList lbSetCurSel _nearestPhoneIndex;