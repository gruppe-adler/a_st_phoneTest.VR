params ["_object"];

createDialog "grad_landline_rscPhoneBook";
waitUntil {dialog};

private _dialog = uiNamespace getVariable ['grad_landline_rscPhoneBook',controlNull];

if (isNull _dialog) exitWith { hint "something went wrong"; };



private _phoneList = _dialog displayCtrl 1000;



private _allNumbers = missionNamespace getVariable ["GRAD_LANDLINE_ALLNUMBERS", []];
private _allMarkers = [];
{
    private _phoneObject = _x select 0;
    private _phoneNumber = _x select 1;

    private _identifier = _phoneList lbAdd _phoneNumber;
    _phoneList lbSetValue [_identifier, _forEachIndex];


    (getPos _phoneObject) params ["_xPos", "_yPos"];
    private _marker = createMarkerLocal [format ["mrk_grad_landlinePhone_%1", [_xPos,_yPos]],[_xPos,_yPos]];
    _marker setMarkerShapeLocal "ICON";
    _marker setMarkerTypeLocal "loc_CivilDefense";

    _allMarkers pushBack _marker;


} forEach _allNumbers;

(getPos (_allNumbers select 0 select 0)) params ["_xPos", "_yPos"];
private _selectionMarker = createMarkerLocal ["mrk_grad_landlinePhoneSelect",[_xPos,_yPos]];
_selectionMarker setMarkerShapeLocal "ICON";
_selectionMarker setMarkerTypeLocal "Select";


private _button = _dialog displayCtrl 3000;

player setVariable ["GRAD_landline_phoneList", [_phoneList, _button]];
player setVariable ["GRAD_landline_markerList", _allMarkers];
player setVariable ["GRAD_landline_phoneListDialog", _dialog];

_selectionMarker setMarkerPosLocal (getMarkerPos (_allMarkers select (lbValue [ 2000, ( lbCurSel 2000 ) ])));

_button ctrlAddEventHandler ["ButtonClick", {
        params ["_ctrl"];

        private _objIndex = lbValue [ 2000, ( lbCurSel 2000 ) ];
        private _allNumbers = missionNamespace getVariable ["GRAD_LANDLINE_ALLNUMBERS", []];
        private _objReceiver = (_allNumbers select _objIndex) select 0;

        hint format ['%1', _objReceiver];

        private _objCaller = player getVariable ["GRAD_landline_objCaller", objNull];
        [_objCaller, _objReceiver] call GRAD_landline_fnc_callStart;

        player setVariable ["GRAD_landline_objCaller", objNull];

        closeDialog 0;
}];

/*
// cache caller nr
player setVariable ["GRAD_landline_objCaller", _object];

disableSerialization;

private _display = (findDisplay 46) createDisplay "RscDisplayEmpty";

private _listHeader = _display ctrlCreate ["RscText", 1499];
_listHeader ctrlSetPosition [0,-0.1,1,0.1];
_listHeader ctrlSetFontHeight 1;
_listHeader ctrlsetFont "RobotoCondensedBold";
_listHeader ctrlSetTextColor [1,1,1,0.5];
_listHeader ctrlSetText "Telefonbuch";
_listHeader ctrlSetBackgroundColor [0,0,0,1];
_listHeader ctrlCommit 0;


private _phoneList = _display ctrlCreate ["RscListbox", 1500];

_phoneList ctrlSetPosition [0,0,1,0.9];
_phoneList ctrlCommit 0;
_phoneList ctrlSetFontHeight 0.05;
_phoneList ctrlsetFont "RobotoCondensedBold";
_phoneList ctrlSetTextColor [1,1,1,1];


lbClear _phoneList;

_phoneList lnbAddColumn 0.5;

private _allNumbers = missionNamespace getVariable ["GRAD_LANDLINE_ALLNUMBERS", []];

{
    private _phoneObject = _x select 0;
    private _phoneNumber = _x select 1;

    private _identifier = _phoneList lbAdd _phoneNumber;
    _phoneList lbSetValue [_identifier, _forEachIndex];

} forEach _allNumbers;


private _button = _display ctrlCreate ["RscButton", -1];

_button ctrlSetPosition [0,0.9,1,0.1];
_button ctrlsetFont "PuristaLight";
_button ctrlSetText "Anrufen";
_button ctrlSetFontHeight 0.05;
_button ctrlCommit 0;

player setVariable ["GRAD_landline_phoneList", [_listHeader, _phoneList, _button]];
player setVariable ["GRAD_landline_phoneListDialog", _display];


_button ctrlAddEventHandler ["ButtonClick", {
        params ["_ctrl"];

        private _objIndex = lbValue [ 1500, ( lbCurSel 1500 ) ];
        private _allNumbers = missionNamespace getVariable ["GRAD_LANDLINE_ALLNUMBERS", []];
        private _objReceiver = (_allNumbers select _objIndex) select 0;

        hint format ['%1', _objReceiver];

        private _objCaller = player getVariable ["GRAD_landline_objCaller", objNull];
        [_objCaller, _objReceiver] call GRAD_landline_fnc_callStart;

        player setVariable ["GRAD_landline_objCaller", objNull];

        { ctrlDelete _x; } forEach (player getVariable ["GRAD_landline_phoneList",[]]);

        
       
}];
*/