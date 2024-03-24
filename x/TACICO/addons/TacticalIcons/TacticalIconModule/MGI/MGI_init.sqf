MGI_fnc_tacIcons = compile preprocessFileLineNumbers "\x\TACICO\addons\TacticalIcons\TacticalIconModule\MGI\MGI_Tactical_Icons.sqf";
MGI_Stance = compile preprocessFileLineNumbers "\x\TACICO\addons\TacticalIcons\TacticalIconModule\MGI\MGI_stance_coef.sqf";

brit = 0.6;
coef_ratio = (getResolution select 4)/ 1.77778;
coef_uiSpace = 0.55/(getResolution select 5);
coef_zoom = ([0.5,0.5] distance worldToScreen positionCameraToWorld [0,10,10])* (getResolution select 5);
running_eventHandlers = 0;

if (!isDedicated) then {
	waitUntil {!isNull player};

	systemChat str ["Adding Tactical Icons action to player"];
	diag_log format ["Adding Tactical Icons action to player"];
	[] execVM "\x\TACICO\addons\TacticalIcons\TacticalIconModule\MGI\MGI_add_actions.sqf";
	player addEventHandler ["Respawn", {_this execVM "\x\TACICO\addons\TacticalIcons\TacticalIconModule\MGI\MGI_add_actions.sqf"}];
};