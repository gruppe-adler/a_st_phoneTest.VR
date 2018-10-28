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
    
    };


    case "interrupt" : { 
    
    };


    default {
        diag_log "grad_landline: dont know what to do";
    }; 
};