params ["_object"];

player setVariable ["GRAD_landline_objCaller", _object];

createDialog "grad_landline_rscPhoneBook";
waitUntil {dialog};

private _dialog = uiNamespace getVariable ['grad_landline_rscPhoneBook',controlNull];

if (isNull _dialog) exitWith { hint "something went wrong"; };



// fill phonelist
private _phoneList = _dialog displayCtrl 1000;
private _allNumbers = missionNamespace getVariable ["GRAD_LANDLINE_ALLNUMBERS", []];
private _allMarkers = [];
{
    private _phoneObject = _x select 0;
    private _phoneNumber = _x select 1;

    private _identifier = _phoneList lbAdd _phoneNumber;
    _phoneList lbSetValue [_identifier, _forEachIndex];
    _phoneList lbSetTooltip [_forEachIndex, str _identifier]; // more debug than anything else currently


    (getPos _phoneObject) params ["_xPos", "_yPos"];
    private _marker = createMarkerLocal [format ["mrk_grad_landlinePhone_%1", [_xPos,_yPos]],[_xPos,_yPos]];
    _marker setMarkerShapeLocal "ICON";
    _marker setMarkerTypeLocal "loc_CivilDefense";

    _allMarkers pushBack _marker;

} forEach _allNumbers;



// set initial position of selection marker
(getPos (_allNumbers select 0 select 0)) params ["_xPos", "_yPos"];
private _selectionMarker = createMarkerLocal ["mrk_grad_landlinePhoneSelect",[_xPos,_yPos]];
_selectionMarker setMarkerShapeLocal "ICON";
_selectionMarker setMarkerTypeLocal "Select";


private _button = _dialog displayCtrl 3000;

// store elements to delete them later on
player setVariable ["GRAD_landline_phoneList", [_phoneList, _button]];
player setVariable ["GRAD_landline_markerList", _allMarkers];


_selectionMarker setMarkerPosLocal (getMarkerPos (_allMarkers select (lbValue [ 2000, ( lbCurSel 2000 ) ])));

_button ctrlAddEventHandler ["ButtonClick", {
        params ["_ctrl"];

        private _objIndex = lbValue [ 2000, ( lbCurSel 2000 ) ];
        private _allNumbers = missionNamespace getVariable ["GRAD_LANDLINE_ALLNUMBERS", []];
        private _objReceiver = (_allNumbers select _objIndex) select 0;

        // hint format ['%1', _objReceiver];

        private _objCaller = player getVariable ["GRAD_landline_objCaller", objNull];
        [_objCaller, _objReceiver] call GRAD_landline_fnc_callStart;

        // debug
        private _selectionMarker = createMarkerLocal ["mrk_grad_landlinePhoneCaller", position _objCaller];
        _selectionMarker setMarkerShapeLocal "ICON";
        _selectionMarker setMarkerTypeLocal "mil_dot";
        _selectionMarker setMarkerColorLocal "ColorGreen";

        private _selectionMarker = createMarkerLocal ["mrk_grad_landlinePhoneReceiver", position _objReceiver];
        _selectionMarker setMarkerShapeLocal "ICON";
        _selectionMarker setMarkerTypeLocal "mil_dot";
        _selectionMarker setMarkerColorLocal "ColorRed";




        player setVariable ["GRAD_landline_objCaller", objNull];

        closeDialog 0;
}];