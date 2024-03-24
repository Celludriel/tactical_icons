/* Pierre MGI - stance_coef.sqf - August 2014

for icons drawn above units
________________________________________*/
_guy = _this select 0;

call{
	if (_guy isKindOf "tank" or _guy isKindOf "air" or _guy isKindOf "ship") exitWith {_stance_coef = 4};
	if (_guy isKindOf "car") exitWith {_stance_coef = 3.5};

    if  (stance _guy == "STAND") exitWith { _stance_coef = 2.2};
    if  (stance _guy == "CROUCH") exitWith { _stance_coef = 1.5};
    if  (stance _guy == "PRONE") exitWith { _stance_coef = 0.5};
    if  (stance _guy == "UNDEDINED") exitWith { _stance_coef = 0.5};
     _stance_coef = 2;
    };
_stance_coef

