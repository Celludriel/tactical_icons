#include "script_component.hpp"

class CfgPatches {
	class ADDON {
			// Meta information for editor
			name = "Tactical Icons";
			author = "Celludriel";
			url = "http://github.com/celludriel";
	
			// Minimum compatible version. When the game's version is lower, pop-up warning will appear when launching the game.
			requiredVersion = 2.14; 
			// Required addons, used for setting load order.
			// When any of the addons is missing, pop-up warning will appear when launching the game.
			requiredAddons[] = { "CBA_main" };
			// List of objects (CfgVehicles classes) contained in the addon. Important also for Zeus content (units and groups) unlocking.
			units[] = {};
			// List of weapons (CfgWeapons classes) contained in the addon.
			weapons[] = {};
	};
};

#include "CfgEventhandlers.hpp"