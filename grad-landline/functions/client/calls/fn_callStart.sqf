params ["_callerPhoneObject", "_receiverPhoneObject", "_callerNumber", "_receiverNumber"];

// if no number is assigned
// if (count _callerNumber isEqualTo 0) exitWith { diag_log "error, no number"; };


private _dialing = [_receiverNumber] spawn GRAD_landline_fnc_rotaryDialNumber;

waitUntil { scriptDone _dialing };

[player, _callerPhoneObject] call GRAD_landline_fnc_callSetOwner; // set self to owner of current phone

// prevent calling yourself
if (_callerPhoneObject isEqualTo _receiverPhoneObject) exitWith {
    hint "cant call yourself, dumbass";

    [_callerPhoneObject, "waiting"] call GRAD_landline_fnc_callSetStatus;
    [_callerPhoneObject] call GRAD_landline_fnc_soundWaiting;

    systemChat "callStart - wait";
};

[
    _callerPhoneObject, _receiverPhoneObject,
    player, objNull
] call GRAD_landline_fnc_callSaveInfo;


// go to calling, if receiver can receive
if ([_receiverPhoneObject, "idle"] call GRAD_landline_fnc_callGetStatus) then {
    // self assign status
    [_callerPhoneObject, "calling"] call GRAD_landline_fnc_callSetStatus;

    // let server handle receiver status
    [_receiverPhoneObject] remoteExec ["GRAD_landline_fnc_callRinging", 2];
    waitUntil { ([_receiverPhoneObject, "ringing"] call GRAD_landline_fnc_callGetStatus) };
    [_receiverPhoneObject] call GRAD_landline_fnc_soundWaiting;

    systemChat "callStart - calling";

    // activate tfar stuff
    [_callerPhoneObject, _callerNumber + _receiverNumber] call GRAD_landline_fnc_callPluginActivate;
} else {
    [_callerPhoneObject, "busy"] call GRAD_landline_fnc_callSetStatus;
    [_receiverPhoneObject] call GRAD_landline_fnc_soundBusy;

    systemChat "callStart - wait";
};
