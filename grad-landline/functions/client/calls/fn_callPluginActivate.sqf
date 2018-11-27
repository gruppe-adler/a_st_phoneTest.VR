params ["_phoneObject", "_lineNumber"];

player setVariable ['GRAD_landline_isCalling', true];

private _encryptionKey = ""; // must be nothing

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

NO ENCRYPTION NOW

*/
private _id = _phoneObject getVariable ["GRAD_landline_phoneID", 0];
private _classname = "tf_fadak_" + str _id;

private _pluginCommand = format[
                                "TANGENT_LR	PRESSED	%1%2	%3	%4	%5",
                                _lineNumber,
                                _encryptionKey,
                                100000,
                                "phone",
                                _classname
							];

[_hintText, _pluginCommand, [0,-1] select TFAR_showTransmittingHint] call TFAR_fnc_processTangent;

TF_tangent_sw_pressed = true;

systemChat format ["grad-landline-debug: linenumber: %1, encryption: %2, classname: %3", _lineNumber, _encryptionKey, _classname];
diag_log format ["grad-landline-debug: linenumber: %1, encryption: %2, classname: %3", _lineNumber, _encryptionKey, _classname];
