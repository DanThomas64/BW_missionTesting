#include "script_component.hpp"
GVAR(checklist) = [];
FUNC(storeResults) = {
  if (count GVAR(checklist) == 0) exitWith {[] call FUNC(createChecklist)};
  private _display = findDisplay 9999;
  {
    private _contents = _x select 0;
    private _idc = _x select 1;
    private _type = _x select 2;
    private _ctrl = _display displayCtrl _idc;
    TRACE_1("In",_x);
    switch (_type) do {
      case "RscCombo": {
        _contents = lbCurSel _idc;
      };
      case "RscCheckBox": {
        _contents = cbChecked _ctrl;
      };
      default {
        _contents = ctrlText _idc;
      };
    };
    _x set [0,_contents];
    GVAR(checklist) set [_forEachIndex,_x];
    TRACE_1("Out",_x);
  } forEach GVAR(checklist);
};
FUNC(updateResults) = {
  private _display = findDisplay 9999;
  {
    private _contents = _x select 0;
    private _idc = _x select 1;
    private _class = _x select 2;
    private _ctrl = _display displayCtrl _idc;
    switch (_class) do {
      case "RscCombo": {
      TRACE_1("RscCombo",_class);
        _ctrl lbSetCurSel _contents;
      };
      case "RscCheckBox": {
      TRACE_1("RscCheckBox",_class);
        _ctrl cbSetChecked _contents;
      };
      default {
      TRACE_1("default",_class);
        ctrlSetText [_idc,_contents];
      };
    };
  } forEach GVAR(checklist);
};

FUNC(createChecklist) = {
  private _display = findDisplay 9999;
  private _parentCtrl = _display displayCtrl 9991;
  private _ctrls = allControls _display select {ctrlParentControlsGroup _x isEqualTo _parentCtrl && (ctrlClassName _x isEqualTo "RscStructuredText" || ctrlClassName _x isEqualTo "RscCombo" || ctrlClassName _x isEqualTo "RscCheckBox" ||  ctrlClassName _x isEqualTo "RscEdit" ||  ctrlClassName _x isEqualTo "RscEditMulti");};
  private _contents = nil;
  {
    private _class = ctrlClassName _x;
    private _idc = ctrlIDC _x;
    switch (_class) do {
      case "RscCheckBox": {
        _contents = cbChecked _x;
      };
      case "RscCombo": {
        _contents = lbCurSel _x;
      };
      default {
        _contents = ctrlText _x;
      };
    };
  GVAR(checklist) pushBack [_contents,_idc,_class];
  }forEach _ctrls;
};

FUNC(generateTestReport) = {
  [] call FUNC(storeResults);

  _checkBoxesNewLine = {
    params = ["_startIndex","_endIndex"];
    for _startIndex to _endIndex do {

    };
  };

  private _textArray = [];
  private _masterChecklistArray = ["Pre-mission","Gear","Vehicles","COOP","Other Considerations"];
  // Header
  private _missionName = getMissionConfigValue ["onLoadName", getMissionConfigValue ["briefingName","????"]];
  private _missionType = A_MISSION_TYPE select (GVAR(checklist) select 0 select 0);
  S_NEWTEXTLINE ["[size=200][u][b]Mission : [color=#FF4000]%1[/color][/b][/u]   [b][u]Type : [color=#FF4000]%2[/color][/u][/b]", _missionName, _missionType];
  private _missionVersion = GVAR(checklist) select 1 select 0;
  S_NEWTEXTLINE ["[u][b]Version : [color=#FF4000]%1[/color][/b][/u][/size]",_missionVersion];
  private _missionMaker = getMissionConfigValue ["author","????"];
  S_NEWTEXTLINE ["[size=150]Mission Maker : [color=#FF4000]%1[/color] Mission Tester : [color=#FF4000]%2[/color][/size]",_missionMaker,name player];
  private _tag1 = A_MISSION_TAGS select (GVAR(checklist) select 2 select 0);
  private _tag2 = A_MISSION_TAGS select (GVAR(checklist) select 3 select 0);
  private _tag3 = A_MISSION_TAGS select (GVAR(checklist) select 4 select 0);
  private _playerCount = GVAR(checklist) select 5 select 0;
  S_NEWTEXTLINE ["[size=150]Mission Tags : [color=#FF4000]%1,%2,%3[/color] Player Count : [color=#FF4000]%4[/color][/size]",_tag1,_tag2,_tag3,_playerCount];


  // Create String and output
  private _text = _textArray joinString (endl + endl);
  findDisplay 9999 displayCtrl 1550 ctrlSetText _text;
};
