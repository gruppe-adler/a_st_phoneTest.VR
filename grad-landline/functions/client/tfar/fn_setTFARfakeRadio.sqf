params ["_phoneObject", "_frequency", "_status"];


private _TFAR_MAX_LR_CHANNELS = 4;



_frequencies = [];

for "_i" from 0 to _TFAR_MAX_LR_CHANNELS step 1 do {
        _frequencies set [_i, _frequency];
};

private _settings = [0, TFAR_default_radioVolume, _frequencies, 0, nil, -1, 0, nil, false, true];





TFAR_OverrideActiveLRRadio = if (_status) then { [_phoneObject, _settings] } else { [] };