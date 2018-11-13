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
		if (isNull _recipient) then {
			[_receiverPhoneObject, "idle"] call GRAD_landline_fnc_callSetStatus;
		};

		// play sound
		[_object, "GRAD_landline_phoneHangUp"] remoteExec ["say3D", [0,-2] select isDedicated];

		// tfar
		[_object, _callerNumber + _receiverNumber] call GRAD_landline_fnc_callPluginDeactivate;

		// delete partner reference
		[objNull] call GRAD_landline_fnc_callSetCurrentPartnerObject;

		// debug whats happening
		systemChat "hanging up from waiting";
	};


	case "calling" : {
		// set self to idle state
		[_object, "idle"] call GRAD_landline_fnc_callSetStatus;

		// if there is no other owner, take command of other phone as well
		if (isNull _recipient) then {
			[_receiverPhoneObject, "idle"] call GRAD_landline_fnc_callSetStatus;
		} else {
			// player aborting the call initiates interruption on other end
			[_receiverPhoneObject, "remoteEnding"] remoteExec ["GRAD_landline_fnc_callEnd", _recipient]; // _object
		};
		
		// play sound
		[_object, "GRAD_landline_phoneHangUp"] remoteExec ["say3D", [0,-2] select isDedicated];

		// tell server there is no transmission left
		[_callerNumber, _receiverNumber] remoteExec ["GRAD_landline_fnc_callUnregister", 2];

		// tfar
		[_object, _callerNumber + _receiverNumber] call GRAD_landline_fnc_callPluginDeactivate;

		// delete partner reference
		[objNull] call GRAD_landline_fnc_callSetCurrentPartnerObject;

		// debug whats happening
		systemChat "hanging up from calling";
		player setVariable ['GRAD_landline_isCalling', false];
	};


	case "remoteEnding" : {
		// set self to ending state
		[_object, "ending"] call GRAD_landline_fnc_callSetStatus;

		// initiate beep beep..
		[_object] call GRAD_landline_fnc_soundInterrupted;

		// tfar
		[_object, _callerNumber + _receiverNumber] call GRAD_landline_fnc_callPluginDeactivate;

		// debug whats happening
		systemChat "other side hung up";
		player setVariable ['GRAD_landline_isCalling', false];
	};
	

	default { diag_log "grad-landline: error code 1337"; };
};