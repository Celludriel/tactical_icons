if (!isDedicated) then {
	waitUntil {!isNull player}; // waitUntil the player variable exists
	toggle_icons = 0;

	if (!isnil "tac_icons") then {
		diag_log format ["Removing tac_icons eventHandler currently running %1", running_eventHandlers];
		removeMissionEventHandler ["Draw3D",tac_icons];
		running_eventHandlers = running_eventHandlers - 1;
	};

	icons_on = player addAction ["<t color='#11ff11'>Tactical icons On</t>", {
		toggle_icons = 1;
		tac_icons = addMissionEventHandler ["Draw3D", {
			_this call {
				call MGI_fnc_tacIcons;
			};
		}];
		running_eventHandlers = running_eventHandlers + 1;
	},nil,4.06,false,true,"", "toggle_icons == 0"];

	icons_off = player addAction ["<t color='#ff1111'>Tactical icons Off</t>",{
		if (!isnil "tac_icons") then {
			diag_log format ["Removing tac_icons eventHandler currently running %1", running_eventHandlers];
			removeMissionEventHandler ["Draw3D",tac_icons];
			running_eventHandlers = running_eventHandlers - 1;
		};
		toggle_icons = 0;
	},nil,4.06,false,true,"", "toggle_icons == 1"];
};