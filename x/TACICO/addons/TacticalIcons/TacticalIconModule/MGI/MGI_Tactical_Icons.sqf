if (!alive player or (toggle_icons == 0) or {cameraView != "internal" && cameraView != "gunner"}) exitWith {}; // switch off icons display if not 1st person
if(!isnull (findDisplay 602) or !isnull (findDisplay 314) or !isnull (findDisplay 49)) exitWith {}; // switch off icons display (inventry opened, camera mode, game paused)

private ["_dist_x","_stance_coef"];

_player_side = getNumber (configfile >> "CfgVehicles" >> typeOf player >> "side"); // true side of player
_total_entities = 0;

_range = 300;
_parentObject = objectParent player;
if (!isNull _parentObject) then {
    if(_parentObject isKindOf "Air") then {
        _range = 1500;
    };
};

_totalEntitiesInRange = (getPosATL player) nearEntities [["CAManBase", "Air", "Car", "Motorcycle", "Tank"], _range];

{	
  if(_total_entities >= 30) exitWith { true };

	_true_side = getNumber (configfile >> "CfgVehicles" >> typeOf (crew _x select 0) >> "side");
	
	_positionPlayer = eyePos player;
	_positionTarget = eyePos _x;
	_crew = crew _x;
	if(count _crew > 0) then {
		_positionTarget = eyePos (_crew select 0);
	};
	
	_visibility = [objNull, "VIEW"] checkVisibility [_positionPlayer, _positionTarget];

	if ((_true_side != _player_side ) && (_visibility > 0.5)) then {
  
	  if ( !(_x isKindOf "animal")
            && {_x != vehicle player}
            && {((worldToScreen (visiblePosition _x)) select 0 > (0 * safezoneW + safezoneX))
            && ((worldToScreen (visiblePosition _x)) select 0 <(1 * safezoneW + safezoneX))} ) then {
       
		_dist_x = round(player distance _x);
        [_x] call MGI_Stance;
        d = _stance_coef + (0.006 * _dist_x / coef_zoom);
        d_gr = _stance_coef + (0.025*_dist_x / coef_zoom);

        _uispace = 0.6 * coef_uiSpace;        

        if(_true_side != _player_side) then {
            call {
                if (getText (configfile >> "CfgVehicles" >> typeOf _x >> "displayName") == "Combat Life Saver" or getText (configfile >> "CfgVehicles" >> typeOf _x >> "displayName") == "Recon Paramedic") exitWith {icontype = "med"};
                if (getText (configfile >> "CfgVehicles" >> typeOf _x >> "displayName") == "Engineer" or getText (configfile >> "CfgVehicles" >> typeOf _x >> "displayName") == "Repair Specialist") exitWith {icontype = "maint"};
                if (_x isKindOf "man") exitWith {icontype = "inf"};
                if (_x isKindOf "tank") exitWith {icontype = "armor"};
                if (_x isKindOf "car") exitWith {icontype = "motor_inf"};
                if (_x isKindOf "staticweapon") exitWith {icontype = "art"};
                if (_x isKindOf "UAV") exitWith {icontype = "uav"};
                if (_x isKindOf "air") exitWith {icontype = "air"};
                if (_x isKindOf "ship") exitWith {icontype = "naval"};
            };
						
            call {
                if(_true_side != 2) exitWith {
                    drawIcon3D [tostring (toarray("A3\ui_f\data\map\Markers\NATO\o_")) + icontype + ".paa", [1,0.3,0.3,0.1+brit*(0.2+_dist_x*0.012)], [visiblePosition _x select 0, visiblePosition _x select 1, (getPosATL _x select 2 )+ d],_uispace*coef_ratio,_uispace,360,"",1, 0.03,"EtelkaMonospacePro"];
                    _total_entities = _total_entities + 1;
                };

                if (_true_side == 2 && (resistance getfriend (side player) >= 0.6)) exitWith {
                    drawIcon3D [tostring (toarray("A3\ui_f\data\map\Markers\NATO\n_")) + icontype + ".paa", [0.1,0.8,0.1,0.1+brit*(0.2+_dist_x*0.012)], [visiblePosition _x select 0, visiblePosition _x select 1, (getPosATL _x select 2 )+ d],_uispace*coef_ratio,_uispace,360,"",1, 0.03,"EtelkaMonospacePro"];
                    _total_entities = _total_entities + 1;
                }; //green

                if (_true_side == 2 && (resistance getfriend (side player) < 0.6)) exitWith {
                    drawIcon3D [tostring (toarray("A3\ui_f\data\map\Markers\NATO\n_")) + icontype + ".paa", [1,1,0,0.1+brit*(0.2+_dist_x*0.012)], [visiblePosition _x select 0, visiblePosition _x select 1, (getPosATL _x select 2 )+ d],_uispace*coef_ratio,_uispace,360,"",1, 0.03,"EtelkaMonospacePro"];
                    _total_entities = _total_entities + 1;
                }; //yellow
            };
        };
    }; // end !animal && me
  }; // end LoS
} foreach (_totalEntitiesInRange);