#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_statemachine_fnc_create

Description:
    Creates a state machine.

Parameters:
    _list           - list of anything over which the state machine will run
                      (type needs to support setVariable) <ARRAY>
                      OR
                      code that will generate this list, called once the list
                      has been cycled through <CODE>
    _skipNull       - skip list items that are null

Returns:
    _stateMachine   - a state machine <LOCATION>

Examples:
    (begin example)
        _stateMachine = call CBA_statemachine_fnc_create;
    (end)

Author:
    BaerMitUmlaut
---------------------------------------------------------------------------- */
SCRIPT(create);
params [
    ["_list", [], [[], {}]],
    ["_skipNull", false, [true]]
];

if (isNil QGVAR(stateMachines)) then {
    GVAR(stateMachines) = [];
    GVAR(nextUniqueID) = 0;
};

#ifdef STATEMACHINE_PERFORMANCE_COUNTERS
if (isNil QGVAR(performanceCounters)) then {GVAR(performanceCounters) = [];};
GVAR(performanceCounters) pushBack [];
#endif

private _updateCode = {};
if (_list isEqualType {}) then {
    _updateCode = _list;
    _list = [] call _updateCode;
} else {
    // Filter list in case null elements were passed
    if (_skipNull) then {
        _list = _list select {!isNull _x};
    };
};

private _stateMachine = call CBA_fnc_createNamespace;
_stateMachine setVariable [QGVAR(nextUniqueStateID), 0];    // Unique ID for autogenerated state names
_stateMachine setVariable [QGVAR(tick), 0];                 // List index ticker
_stateMachine setVariable [QGVAR(states), []];              // State machine states
_stateMachine setVariable [QGVAR(list), _list];             // List state machine iterates over
_stateMachine setVariable [QGVAR(skipNull), _skipNull];     // Skip items that are null
_stateMachine setVariable [QGVAR(updateCode), _updateCode]; // List update code
_stateMachine setVariable [QGVAR(ID), GVAR(nextUniqueID)];  // Unique state machine ID
INC(GVAR(nextUniqueID));

if (isNil QGVAR(efID)) then {
    GVAR(efID) = addMissionEventHandler ["EachFrame", {call FUNC(clockwork)}];
};

_stateMachine
