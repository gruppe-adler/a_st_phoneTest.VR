#include "..\..\..\config.hpp"

if (!isServer) exitWith {};

[] call GRAD_landline_fnc_distributePhones; // intensive, maybe preinit?