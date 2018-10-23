#include "..\..\..\config.hpp"

if (!isServer) exitWith {};

missionNamespace setVariable ["GRAD_LANDLINE_ALLNUMBERS", [], true];
missionNamespace setVariable ["GRAD_LANDLINE_CALLS_RUNNING", [], true];

[] call GRAD_landline_fnc_distributePhones; // intensive, maybe preinit?