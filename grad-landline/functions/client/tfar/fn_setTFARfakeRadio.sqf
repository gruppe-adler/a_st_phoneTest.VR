params ["_phoneObject", "_frequency", "_encryptionKey", "_status"];


private _TFAR_MAX_LR_CHANNELS = 4;



_frequencies = [];

for "_i" from 0 to _TFAR_MAX_LR_CHANNELS step 1 do {
        _frequencies set [_i, _frequency];
};

//  private _lr_settings = [0, TFAR_default_radioVolume, [], 0, nil, -1, 0, nil, false, true];
/*
ARRAY: Settings [
            0: NUMBER - Active channel,
            1: NUMBER - Volume,
            2: ARRAY - Frequencies for channels,
            3: NUMBER - Stereo setting,
            4: STRING - Encryption code,
            5: NUMBER - Additional active channel,
            6: NUMBER - Additional active channel stereo mode,
            7: NIL
            8: NUMBER - Speaker mode,
            9: BOOLEAN - On
        ]
*/
// channel, volume, frequencies, STEREO, encryption, additional active channel, additional active stereo, empty, speaker mode, turned on
private _settings = [0, TFAR_default_radioVolume, _frequencies, 2, _encryptionKey, -1, 0, nil, false, true];
private _settingsID = "radio_settings";
_phoneObject setVariable [_settingsID, _settings, true];
TFAR_OverrideActiveLRRadio = if (_status) then { [_phoneObject, _settingsID] } else { [] };


systemChat format ["grad-landline-debug: TFAR_OverrideActiveLRRadio: %1", TFAR_OverrideActiveLRRadio];
diag_log format ["grad-landline-debug: TFAR_OverrideActiveLRRadio: %1", TFAR_OverrideActiveLRRadio];