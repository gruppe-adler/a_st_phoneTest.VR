params ["_callerPhoneNumber"];

private _display = findDisplay 46 createDisplay "RscDisplayEmpty";

 

private _phoneList = _display ctrlCreate ["RscListbox", 1500];

_phoneList ctrlSetPosition [-0.3,0.02,0.48793,0.744756];
_phoneList ctrlCommit 0.26;
_phoneList ctrlSetFontHeight 0.028;
_phoneList ctrlsetFont "PuristaLight";
_phoneList ctrlSetTextColor [1,1,1,1];

 

lbClear _phoneList;

{

_index = lbAdd [ 1500, str _x ];

	lbSetData [ 1500, _index, str _x ];

} forEach GRAD_LANDLINE_ALLNUMBERS;


button = _display ctrlCreate ["RscButton", -1];

button ctrlSetPosition [0.625,0.2,0.423497,0.276817];
button ctrlsetFont "PuristaLight";
button ctrlSetText "hint selected!";
button ctrlSetFontHeight 0.03;
button ctrlCommit 0.26;
button buttonSetAction "

	private _data = lbData [ 1500, ( lbCurSel 1500 ) ];

	HINT FORMAT ['%1',_data];

	[_callerPhoneNumber, parseNumber _data] call GRAD_landline_fnc_callStart;

";