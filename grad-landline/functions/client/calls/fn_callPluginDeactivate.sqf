params ["_phoneObject", "_lineNumber"];

player setVariable ['GRAD_landline_isCalling', false];


[_phoneObject, _lineNumber, false] call GRAD_landline_fnc_setTFARfakeRadio;

private _hintText = format[
							"Anruf beendet",
							format ["%1<img size='1.5' image='%2'/>",
									"Festnetz",
									""
									],
							1,
							_lineNumber
						];

private _pluginCommand = format[
								"TANGENT_LR	RELEASED	%1%2	%3	%4",
								_lineNumber,
								"grad_landline",
								100000,
								"phone"
							];

[_hintText,_pluginCommand, [0,nil] select TFAR_showTransmittingHint] call TFAR_fnc_processTangent;