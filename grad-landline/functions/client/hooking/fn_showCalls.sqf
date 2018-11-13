/*
    
    lists all calls currently taken

*/

createDialog "grad_landline_rscPhoneBook";
waitUntil {dialog};

private _dialog = uiNamespace getVariable ['grad_landline_rscPhoneBook',controlNull];

if (isNull _dialog) exitWith { hint "something went wrong"; };



// fill phonelist
private _phoneList = _dialog displayCtrl 1000;
private _allCalls = missionNamespace getVariable ["GRAD_LANDLINE_CALLS_RUNNING", []];
private _allMarkerLines = [];
private _map = _dialog displayCtrl 2000;
{
    private _phone1 = _x select 0;
    private _phone2 = _x select 1;

    private _phoneNumber1 = _phone1 getVariable ["GRAD_LANDLINE_NUMBER_ASSIGNED", "0123456789"];
    private _phoneNumber2 = _phone2 getVariable ["GRAD_LANDLINE_NUMBER_ASSIGNED", "0123456789"];

    private _identifier = _phoneList lbAdd (_phoneNumber1 + " calling " + _phoneNumber2);
    // _phoneList lbSetValue [_forEachIndex, _identifier];
    
    

    
   

    _allMarkerLines pushBack [_phone1, _phone2];

} forEach _allCalls;

missionNamespace setVariable ["GRAD_LANDLINE_CALLS_RUNNING_PHONES", _allMarkerLines];


_map ctrlAddEventHandler ["Draw","
    private _map = (_this select 0);
    private _lines = missionNamespace getVariable ['GRAD_LANDLINE_CALLS_RUNNING_PHONES', []];


    {
        private _pos1 = getPos (_x select 0);
        private _pos2 = getPos (_x select 1);
    _map drawLine [
        _pos1,
        _pos2,
        [1,0,0,1]
    ];
    } forEach _lines;
    "
];

{
    private _pos1 = getPos (_x select 0);
    private _pos2 = getPos (_x select 1);

    private _marker = createMarkerLocal [format ['mrk_grad_landlinePhoneHook_%1', _pos1],_pos1];
    _marker setMarkerShapeLocal 'ICON';
    _marker setMarkerTypeLocal 'mil_dot';
    _marker setMarkerColorLocal 'ColorRed';

    private _marker2 = createMarkerLocal [format ['mrk_grad_landlinePhoneHook_%1', _pos2],_pos2];
    _marker2 setMarkerShapeLocal 'ICON';
    _marker2 setMarkerTypeLocal 'mil_dot';
    _marker2 setMarkerColorLocal 'ColorRed';
} forEach _allMarkerLines;




private _listBox = _dialog displayCtrl 1000;
lbSetCurSel [_listBox, 0];



private _button = _dialog displayCtrl 3000;
_button ctrlSetText "Einklinken";


_button ctrlAddEventHandler ["ButtonClick", {
        params ["_ctrl"];

        private _dialog = uiNamespace getVariable ['grad_landline_rscPhoneBook',controlNull];
        private _listBox = _dialog displayCtrl 1000;

        private _objIndex = lbCurSel _listBox;
        systemChat format ["%1", _objIndex];

        private _allPhones = missionNamespace getVariable ["GRAD_LANDLINE_ALLPHONES", []];
        private _objReceiver = _allPhones select _objIndex;
        private _receiverNumber = _objReceiver getVariable ["GRAD_LANDLINE_NUMBER_ASSIGNED", "none"];

        private _objCaller = player getVariable ["GRAD_landline_objCaller", objNull];

        
        [_objCaller, _objReceiver, _receiverNumber] spawn GRAD_landline_fnc_callStart;

        player setVariable ["GRAD_landline_objCaller", objNull];

        closeDialog 0;
}];