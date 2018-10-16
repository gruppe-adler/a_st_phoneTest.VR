/*
		A T T E N T I O N 

		pluginCommand needs TAB Intendation! (quote dedmen, as its used a determinator in TS code)

		A T T E N T I O N



		pluginCommand takes the following params after format:
		_currentFrequency, // any String - if they dont match, you cant transmit - in normal use its sth like "55.5" but could be anything really
		tf_encryptionCode, // any String - if they dont match, you cant transmit - in normal use its sth like "tf_east_radio_code"
		tf_range, // Number - should be something between 500 and 100000 (meters)
		tf_subtype, // String - MUST be either of "digital" (sw), "digital_lr" (lr), "airborne" (air), "phone" (phone) - determines radio effect
		classname // classname of radio - in normal use its sth like "tf_fadak", not necessary to be real (NOT SURE)
							
*/


params ["_phone", "_lineNumber"];

player setVariable ['GRAD_landline_isCalling', true];

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
								"digital_lr",
								"tf_mr3000"
							];

[_hintText, _pluginCommand, [0,-1] select TFAR_showTransmittingHint] call TFAR_fnc_processTangent;

[{
	params ["_object"];
	_object distance player > 3 || (!(player getVariable ['GRAD_landline_isCalling', false]))
}, 
{
	["1337"] call GRAD_landline_fnc_endCall;
}, [_target]] call CBA_fnc_waitUntilAndExecute;