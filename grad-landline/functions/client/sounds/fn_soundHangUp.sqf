
private _sound = "";

[{
	params ["_args", "_handle"];
	_args params ["_sound"];


	if (!(player getVariable ["GRAD_landline_isCalling", false])) exitWith {
		[_handle] call CBA_fnc_removePerFrameHandler;
	};

	playSound _sound;

}, 1, [_sound]] call CBA_fnc_addPerFrameHandler;