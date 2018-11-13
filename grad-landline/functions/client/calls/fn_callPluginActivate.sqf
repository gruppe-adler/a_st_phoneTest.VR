params ["_phoneObject", "_lineNumber"];

player setVariable ['GRAD_landline_isCalling', true];

private _encryptionKey = "grad_landline";


[_phoneObject, _lineNumber, _encryptionKey, true] call GRAD_landline_fnc_setTFARfakeRadio;

private _hintText = format[
							"Anruf läuft",
							format ["%1<img size='1.5' image='%2'/>",
									"Festnetz",
									""
									],
							1,
							_lineNumber
						];

/*

 tabs are important here for correctly working in TS plugin!
 _lineNumber - frequency
 grad_landline - encryption
 100000 - range
 phone - tf_subtype
 tf_mr3000 fake classname // not sure if important

*/
private _pluginCommand = format[
								"TANGENT_LR	PRESSED	%1%2	%3	%4	%5",
								_lineNumber,
								_encryptionKey,
								100000,
								"digital_lr",
								"tf_mr3000"
							];

[_hintText, _pluginCommand, [0,-1] select TFAR_showTransmittingHint] call TFAR_fnc_processTangent;


systemChat format ["grad-landline-debug: linenumber: %1, encryption: %2", _lineNumber, _encryptionKey];
diag_log format ["grad-landline-debug: linenumber: %1, encryption: %2", _lineNumber, _encryptionKey];



// its actually important phone object is the phone you are standing next to
[{
	params ["_phoneObject"];
	(_phoneObject distance player > 3)
},
{
	params ["_phoneObject"];
	[_phoneObject, "calling"] call GRAD_landline_fnc_callEnd;
	systemChat "ending call because too far away";
}, [_phoneObject]] call CBA_fnc_waitUntilAndExecute;