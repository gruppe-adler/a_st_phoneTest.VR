# a_st_phoneTest.VR

This project is heavily WIP. Please come back later.

## Requirements
1.0-PreRelease-1.0-dev.303 (!)



## How to

### add an object as a phone
```
/*
 object // this object will become a phone
 string <optional> // hardcode a number - else its auto generated 
 boolean <optional>  // if not rotary, its keypad
 boolean <optional> // this phone can only call this hardcoded number without visible dialing
*/
[this, "0123456789", false, false] call GRAD_landline_fnc_addPhone;
```
