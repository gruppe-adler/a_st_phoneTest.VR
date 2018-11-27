params ["_object", "_state"];

// storedData
private _storedData = [_object] call GRAD_landline_fnc_callGetInfo;

_storedData params [
    ["_phone1", objNull], 
    ["_phone2", objNull], 
    ["_number1", "undefined"], 
    ["_number2", "undefined"], 
    ["_player1", objNull], 
    ["_player2", objNull]
];

private _isCaller = player isEqualTo _player1;


// execute state stuff
switch (_state) do { 
	case "waiting": {
		// set self to idle state
		[_object, "idle"] call GRAD_landline_fnc_callSetStatus;

		// if there is no other owner, take command of other phone as well
		if (_isCaller && isNull _player2) then {
			[_phone2, "idle"] call GRAD_landline_fnc_callSetStatus;
		};

		// play sound
		if (_isCaller) then {
			[_phone1, "GRAD_landline_phoneHangUp"] remoteExec ["say3D", [0,-2] select isDedicated];
		} else {
			[_phone2, "GRAD_landline_phoneHangUp"] remoteExec ["say3D", [0,-2] select isDedicated];
		};

		// tfar
		// todo: careful to set if busy state
		[_object, _number1 + _number2] call GRAD_landline_fnc_callPluginDeactivate;

		// delete partner reference
		[_phone1, _phone2] call GRAD_landline_fnc_callDeleteInfo;

		// debug whats happening
		systemChat "hanging up from waiting";
		player setVariable ['GRAD_landline_isCalling', false];
	};


	case "busy": {
		// set self to idle state
		[_object, "idle"] call GRAD_landline_fnc_callSetStatus;

		
		[_object, "GRAD_landline_phoneHangUp"] remoteExec ["say3D", [0,-2] select isDedicated];

		// debug whats happening
		systemChat "hanging up from busy";
		player setVariable ['GRAD_landline_isCalling', false];
	};


	case "calling" : {
		// set self to idle state
		[_object, "idle"] call GRAD_landline_fnc_callSetStatus;

		// if there is no other owner, take command of other phone as well
		if (isNull _player1) then {
			[_phone1, "idle"] call GRAD_landline_fnc_callSetStatus;
			// delete partner reference
			[_phone1, _phone2] call GRAD_landline_fnc_callDeleteInfo;
		};
		if (isNull _player2) then {
			[_phone2, "idle"] call GRAD_landline_fnc_callSetStatus;
			// delete partner reference
			[_phone1, _phone2] call GRAD_landline_fnc_callDeleteInfo;
		};

		if (!isNull _player2 && _isCaller) then {
			[_phone2, "remoteEnd"] remoteExec ["GRAD_landline_fnc_callEnd", _player2];
		};

		if (!_isCaller) then {
			[_phone1, "remoteEnd"] remoteExec ["GRAD_landline_fnc_callEnd", _player1];
		};
		
		// play sound
		[_object, "GRAD_landline_phoneHangUp"] remoteExec ["say3D", [0,-2] select isDedicated];

		// tell server there is no transmission left
		[_number1, _number2] remoteExec ["GRAD_landline_fnc_callUnregister", 2];

		// tfar
		[_object, _number1 + _number2] call GRAD_landline_fnc_callPluginDeactivate;

		// debug whats happening
		systemChat "hanging up from calling";
		player setVariable ['GRAD_landline_isCalling', false];
	};


	case "remoteEnd" : {
		// set self to ending state
		[_object, "ending"] call GRAD_landline_fnc_callSetStatus;

		// initiate beep beep..
		[_object] call GRAD_landline_fnc_soundInterrupted;

		// tfar
		[_object, _number1 + _number2] call GRAD_landline_fnc_callPluginDeactivate;

		// delete partner reference
		[_phone1, _phone2] call GRAD_landline_fnc_callDeleteInfo;

		// debug whats happening
		systemChat "other side hung up";
		player setVariable ['GRAD_landline_isCalling', false];
	};
	

	default { diag_log "grad-landline: error code 1337"; };
};