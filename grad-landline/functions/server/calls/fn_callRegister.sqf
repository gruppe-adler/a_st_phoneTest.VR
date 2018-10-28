/*

    logik: 

    player schreiben sich selbst ins phoneobjekt (owner)
    schicken statusänderungen sowie involvierte objekte an server
    server schickt anweisungen zurück

*/

params ["_callerPhoneObject", "_receiverPhoneObject", "_status"];


private _receiverNumber = _receiverPhoneObject getVariable ["GRAD_LANDLINE_NUMBER_ASSIGNED", "no number"];
private _callerNumber = _callerPhoneObject getVariable ["GRAD_LANDLINE_NUMBER_ASSIGNED", "no number"];
private _caller = [_callerPhoneObject] call GRAD_landline_fnc_callGetOwner;
private _receiver = [_receiverPhoneObject] call GRAD_landline_fnc_callGetOwner;

GRAD_LANDLINE_CALLS_RUNNING append [_callerNumber + _receiverNumber];

switch (_status) do { 


    case "idle" : {

    };


    case "waiting" : { 
    
    };


    case "accept" : {

    };


    case "calling" : {  
        // prevent calling yourself
        if (_callerPhoneObject isEqualTo _receiverPhoneObject) exitWith {

            [_callerPhoneObject, "waiting"] call GRAD_landline_fnc_callSetStatus;
            [_callerPhoneObject] remoteExec ["GRAD_landline_fnc_soundWaiting", _caller];
        };


        private _callerNumber = _callerPhoneObject getVariable ["GRAD_LANDLINE_NUMBER_ASSIGNED", "no number"];
        // if no number is assigned
        if (count _callerNumber isEqualTo 0) exitWith { diag_log "error, no number"; };


        // go to calling, if receiver can receive
        if ([_receiverPhoneObject, "idle"] call GRAD_landline_fnc_callGetStatus) then {
            // assign status to player
            [_callerPhoneObject, "calling"] call GRAD_landline_fnc_callSetStatus;

            // activate tfar stuff
            [_callerPhoneObject, _callerNumber] remoteExec ["GRAD_landline_fnc_callPluginActivate", _caller];
        } else {
            [_callerPhoneObject, "waiting"] call GRAD_landline_fnc_callSetStatus;
            [_callerPhoneObject] remoteExec ["GRAD_landline_fnc_soundWaiting", _caller];
        };
    };


    case "callRunning" : {

    };


    case "interrupt" : { 
    
    };


    default {
        diag_log "grad_landline: dont know what to do";
    }; 
};