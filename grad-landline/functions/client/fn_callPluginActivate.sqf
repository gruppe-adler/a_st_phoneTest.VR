params ["_phoneObject", "_lineNumber"];

player setVariable ['GRAD_landline_isCalling', true];


[_phoneObject, _lineNumber, true] call GRAD_landline_fnc_setTFARfakeRadio;

private _hintText = format[
							"Anruf läuft",
							format ["%1<img size='1.5' image='%2'/>",
									"Festnetz",
									""
									],
							1,
							_lineNumber
						];
private _pluginCommand = format[
								"TANGENT_LR	PRESSED	%1%2	%3	%4	%5",
								_lineNumber,
								"grad_landline",
								100000,
								"phone",
								"tf_mr3000"
							];

[_hintText, _pluginCommand, [0,-1] select TFAR_showTransmittingHint] call TFAR_fnc_processTangent;

[{
	params ["_phoneObject"];
	_phoneObject distance player > 3 || (!(player getVariable ['GRAD_landline_isCalling', false]))
},
{
	[_phoneObject, _lineNumber] call GRAD_landline_fnc_endCall;
}, [_target]] call CBA_fnc_waitUntilAndExecute;