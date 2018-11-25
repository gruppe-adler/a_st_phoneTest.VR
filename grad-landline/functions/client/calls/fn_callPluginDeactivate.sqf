params ["_phoneObject", "_lineNumber"];

player setVariable ['GRAD_landline_isCalling', false];

private _encryptionKey = "tf_west_radio_code";

[_phoneObject, _lineNumber, _encryptionKey, false] call GRAD_landline_fnc_setTFARfakeRadio;

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
                                "TANGENT_LR RELEASED    %1%2    %3  %4",
                                _lineNumber,
                                _encryptionKey,
                                100000,
                                "phone"
							];

[_hintText,_pluginCommand, [0,nil] select TFAR_showTransmittingHint] call TFAR_fnc_processTangent;

TF_tangent_sw_pressed = false;

systemChat format ["grad-landline-debug: linenumber: %1, encryption: %2", _lineNumber, _encryptionKey];
diag_log format ["grad-landline-debug: linenumber: %1, encryption: %2", _lineNumber, _encryptionKey];