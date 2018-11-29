params ["_phoneObject", "_lineNumber"];

private _encryptionKey = ""; // must be nothing



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


// [parseText "Anruf beendet", 3] call TFAR_fnc_showHint;

// set tfar fake radio stuff AFTER tangent release?
[_phoneObject, _lineNumber, _encryptionKey, false] call GRAD_landline_fnc_setTFARfakeRadio;

TF_tangent_lr_pressed = false; // necessary?

// workaround for constant activation?
"task_force_radio_pipe" callExtension (format ["RELEASE_ALL_TANGENTS	%1~", name player]);

systemChat format ["grad-landline-debug: linenumber: %1, encryption: %2", _lineNumber, _encryptionKey];
diag_log format ["grad-landline-debug: linenumber: %1, encryption: %2", _lineNumber, _encryptionKey];