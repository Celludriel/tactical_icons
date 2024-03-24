if(!hasInterface) exitWith {};

systemChat str ["Initializing Tactical Icons"];
diag_log format ["Initializing Tactical Icons"];
[] execVM "\x\TACICO\addons\TacticalIcons\TacticalIconModule\MGI\MGI_init.sqf";
