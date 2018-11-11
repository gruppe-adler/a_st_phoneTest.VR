params ["_object", "_state"];

// objects and partner
private _receiverPhoneObject = [] call GRAD_landline_fnc_callGetCurrentPartnerObject;

// get other side client
private _recipient = objNull;
if (!isNull _receiverPhoneObject) then {
	_recipient = [_receiverPhoneObject] call GRAD_landline_fnc_callGetOwner;
};

// numbers
private _callerNumber = _object getVariable ["GRAD_LANDLINE_NUMBER_ASSIGNED", "no number"];
private _receiverNumber = _receiverPhoneObject getVariable ["GRAD_LANDLINE_NUMBER_ASSIGNED", "no number"];


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
		[_object, _callerNumber] call GRAD_landline_fnc_callPluginDeactivate;

		// delete partner reference
		[objNull] call GRAD_landline_fnc_callSetCurrentPartnerObject;

		// debug whats happening
		systemChat "hanging up from waiting";
	};


	case "calling" : {
		// set self to idle state
		[_object, "idle"] call GRAD_landline_fnc_callSetStatus;

		// player aborting the call initiates interruption on other end
		[_object, "remoteEnding"] remoteExec ["GRAD_landline_fnc_callEnd", _recipient];

		// if there is no other owner, take command of other phone as well
		if (isNull _recipient) then {
			[_receiverPhoneObject, "idle"] call GRAD_landline_fnc_callSetStatus;
		};
		
		// play sound
		[_object, "GRAD_landline_phoneHangUp"] remoteExec ["say3D", [0,-2] select isDedicated];

		// tell server there is no transmission left
		[_callerNumber, _receiverNumber] remoteExec ["GRAD_landline_fnc_callUnregister", 2];

		// tfar
		[_object, _callerNumber] call GRAD_landline_fnc_callPluginDeactivate;

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
		[_object, _callerNumber] call GRAD_landline_fnc_callPluginDeactivate;

		// debug whats happening
		systemChat "other side hung up";
		player setVariable ['GRAD_landline_isCalling', false];
	};
	

	default { diag_log "grad-landline: error code 1337"; };
};