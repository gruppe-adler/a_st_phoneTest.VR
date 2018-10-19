

// todo: prefilter for static objects
private _allObjects = nearestTerrainObjects 
	[
		[worldSize/2, worldSize/2], 
		[], 
		worldSize, 
		false
	];


{
	if (GRAD_LANDLINE_CLASSNAMES find (typeOf _x) >= 0) then {
		[_x] call GRAD_landline_fnc_addPhone;
	};
} forEach _allObjects;