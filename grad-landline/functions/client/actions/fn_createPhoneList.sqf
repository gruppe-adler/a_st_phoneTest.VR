params ["_object"];

// cache caller nr
player setVariable ["GRAD_landline_objCaller", _object];

disableSerialization;

private _display = findDisplay 46 createDisplay "RscDisplayEmpty";
private _phoneList = _display ctrlCreate ["RscListbox", 1500];

_phoneList ctrlSetPosition [0,0,1,0.9];
_phoneList ctrlCommit 0;
_phoneList ctrlSetFontHeight 0.06;
_phoneList ctrlsetFont "RobotoCondensedBold";
_phoneList ctrlSetTextColor [1,1,1,1];

lbClear _phoneList;

_phoneList lnbAddColumn 0.5; 

private _allNumbers = missionNamespace getVariable ["GRAD_LANDLINE_ALLNUMBERS", []];

{
    _x params ["_phoneObject", "_phoneNumber"];

    private _identifier = _phoneList lbAdd _phoneNumber;
    _phoneList lbSetData [_identifier, _phoneObject];

    systemChat format ["_identifier %1, _data %2", _identifier, _x];

} forEach _allNumbers;


private _button = _display ctrlCreate ["RscButton", -1];

_button ctrlSetPosition [0,0.9,1,0.1];
_button ctrlsetFont "PuristaLight";
_button ctrlSetText "hint selected!";
_button ctrlSetFontHeight 0.06;
_button ctrlCommit 0;

_button ctrlAddEventHandler ["ButtonClick", {
        params ["_ctrl"];

        private _objReceiver = lbData [ 1500, ( lbCurSel 1500 ) ];

        hint format ['%1', _objReceiver];

        private _objCaller = player getVariable ["GRAD_landline_objCaller", objNull];
        [_objCaller, _objReceiver] call GRAD_landline_fnc_callStart;
}];