params ["_callerPhoneObject", "_receiverPhoneObject"];

// if no number is assigned
// if (count _callerNumber isEqualTo 0) exitWith { diag_log "error, no number"; };

private _callerNumber = _callerPhoneObject getVariable ["GRAD_LANDLINE_NUMBER_ASSIGNED", "none"];
private _receiverNumber = _receiverPhoneObject getVariable ["GRAD_LANDLINE_NUMBER_ASSIGNED", "none"];

private _dialing = [_receiverNumber] spawn GRAD_landline_fnc_rotaryDialNumber;



[{
    params ["_dialing"];
    scriptDone _dialing
}, {
    params ["_dialing", "_callerPhoneObject", "_receiverPhoneObject", "_callerNumber", "_receiverNumber"];

        [player, _callerPhoneObject] call GRAD_landline_fnc_callSetOwner; // set self to owner of current phone

        // prevent calling yourself
        if (_callerPhoneObject isEqualTo _receiverPhoneObject) exitWith {
            hint "cant call yourself, dumbass";

            [_callerPhoneObject, "busy"] call GRAD_landline_fnc_callSetStatus;
            player setVariable ['GRAD_landline_isCalling', true];
            [_callerPhoneObject] call GRAD_landline_fnc_soundBusy;

            systemChat "callStart - busy";
        };

        systemChat format ["callStart - saveInfo %1 %2", _callerPhoneObject, _receiverPhoneObject];

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

            systemChat format ["callStart - calling %1 from %2", _receiverNumber, _callerNumber];
            private _storedData = [_callerPhoneObject] call GRAD_landline_fnc_callGetInfo;

            _storedData params [
                ["_phone1", objNull], 
                ["_phone2", _callerPhoneObject], 
                ["_number1", "undefined"], 
                ["_number2", "undefined"], 
                ["_player1", objNull], 
                ["_player2", player]
            ];
            systemChat format ["callStart - calling %1 from %2", _number2, _number1];

            // activate tfar stuff
            [_callerPhoneObject, _callerNumber + _receiverNumber] call GRAD_landline_fnc_callPluginActivate;
        } else {
            [_callerPhoneObject, "busy"] call GRAD_landline_fnc_callSetStatus;
            [_receiverPhoneObject] call GRAD_landline_fnc_soundBusy;

            systemChat "callStart - busy";
        };


        // its actually important phone object is the phone you are standing next to
        [{
            params ["_callerPhoneObject"];
            // (_phoneObject distance player > 3) || 
            [player, _callerPhoneObject] call GRAD_landline_fnc_conditionEnd
        },
        {
            params ["_callerPhoneObject"];
            if (!([player, _callerPhoneObject] call GRAD_landline_fnc_conditionEnd)) then {
                [_callerPhoneObject, _callerPhoneObject getVariable ["GRAD_landline_phoneStatus", "none"]] call GRAD_landline_fnc_callEnd;
                systemChat "ending call because too far away";
            };
        }, [_callerPhoneObject]] call CBA_fnc_waitUntilAndExecute;


}, [_dialing, _callerPhoneObject, _receiverPhoneObject, _callerNumber, _receiverNumber]] call CBA_fnc_waitUntilAndExecute;