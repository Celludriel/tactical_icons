#include "\a3\editor_f\Data\Scripts\dikCodes.h"

if (!isDedicated) then {
	toggle_icons = 0;

	if (!isnil "tac_icons") then {
		diag_log format ["Removing tac_icons eventHandler currently running %1", running_eventHandlers];
		removeMissionEventHandler ["Draw3D",tac_icons];
		running_eventHandlers = running_eventHandlers - 1;
	};

	tacticalIconsFunction = {	
		if(toggle_icons == 0) exitWith {
			diag_log format ["Adding tac_icons eventHandler currently running %1", running_eventHandlers];
			tac_icons = addMissionEventHandler ["Draw3D", {
				_this call {
					call MGI_fnc_tacIcons;
				};
			}];
			running_eventHandlers = running_eventHandlers + 1;		
			toggle_icons = 1;
		};

		if(toggle_icons == 1) exitWith {
			if (!isnil "tac_icons") then {
				diag_log format ["Removing tac_icons eventHandler currently running %1", running_eventHandlers];
				removeMissionEventHandler ["Draw3D",tac_icons];
				running_eventHandlers = running_eventHandlers - 1;
			};
			toggle_icons = 0;	
		};
	};
	
	["TacticalIcons","tactical_icons_key", "Show Tactical Icons", {_this call tacticalIconsFunction}, "", [DIK_T, [true, true, false]]] call CBA_fnc_addKeybind;
};