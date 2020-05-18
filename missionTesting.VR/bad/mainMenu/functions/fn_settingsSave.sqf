#include "script_component.hpp"
GVAR(checklist) = [];
FUNC(storeResults) = {
  if (count GVAR(checklist) == 0) exitWith {[] call FUNC(createChecklist)};
  {
    private _contents = _x select 0;
    private _idc = _x select 1;
    private _type = _x select 2;
    private _ctrl = MENU_DISPLAY displayCtrl _idc;
    TRACE_1("In",_x);
    switch (_type) do {
      case "RscCombo": {
        _contents = lbCurSel _idc;
      };
      case "RscCheckBox": {
        _contents = cbChecked _ctrl;
      };
      case "RscStructuredText": {
        _contents;
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

FUNC(passFail) = {
  private _subSection1 = GVAR(checklist) select 30 select 0;
  private _subSection2 = GVAR(checklist) select 44 select 0;
  private _subSection3 = GVAR(checklist) select 52 select 0;
  private _subSection4 = GVAR(checklist) select 62 select 0;
  private _subSection5 = GVAR(checklist) select 66 select 0;
  private _output = BBFAIL;
  if (_subSection1 in [1,2] && _subSection2 in [1,2] && _subSection3 in [1,2] && _subSection4 in [1,2] && _subSection5 in [1,2]) then {_output = BBPASS};
  _output;
};

FUNC(updateResults) = {
  {
    private _contents = _x select 0;
    private _idc = _x select 1;
    private _class = _x select 2;
    private _ctrl = MENU_DISPLAY displayCtrl _idc;
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
  private _parentCtrl = MENU_DISPLAY displayCtrl 9991;
  private _ctrls = allControls MENU_DISPLAY select {ctrlParentControlsGroup _x isEqualTo _parentCtrl && (ctrlClassName _x isEqualTo "RscStructuredText" || ctrlClassName _x isEqualTo "RscCombo" || ctrlClassName _x isEqualTo "RscCheckBox" ||  ctrlClassName _x isEqualTo "RscEdit" ||  ctrlClassName _x isEqualTo "RscEditMulti");};
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

  private _premissionChecklistIDCs = [14,16,18,20,22,24,26,28];
  private _gearChecklistIDCs = [32,34,36,38,40,42];
  private _vehiclesChecklistIDCs = [46,48,50];
  private _coopChecklistIDCs = [54,56,58,60];
  private _otherConsiderationsChecklistIDCs = [64];

  _trueFalse = {
    params["_cbValue"];
        if (_cbValue) then {BBTRUE;} else {BBFALSE};
  };
  _passFail = {
    params["_value"];
      switch (_value) do {
        case 0 : {_value = BBFAIL};
        case 1 : {_value = BBPASS};
        case 2 : {_value = BBNA};
      };
    _value;
  };

  _checkBoxes = {
    params["_textIndex"];
    private _cbText = GVAR(checklist) select _textIndex select 0;
    private _cbValue = GVAR(checklist) select (_textIndex + 1) select 0;
    _cbValue = [_cbValue] call _trueFalse;
    S_NEWTEXTLINE_FORMATTEXT ["[*]%1 : %2",_cbText,_cbValue];
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
  private _cb1Text = GVAR(checklist) select 6 select 0;
  private _cb1Value = [GVAR(checklist) select 7 select 0] call _trueFalse;
  private _cb2Text = GVAR(checklist) select 8 select 0;
  private _cb2Value = [GVAR(checklist) select 9 select 0] call _trueFalse;
  private _cb3Text = GVAR(checklist) select 10 select 0;
  private _cb3Value = [GVAR(checklist) select 11 select 0] call _trueFalse;
  private _cb4Text = GVAR(checklist) select 12 select 0;
  private _cb4Value = [GVAR(checklist) select 13 select 0] call _trueFalse;
  // Mission as a whole CBs
  S_NEWTEXTLINE_FORMATTEXT ["[size=150]%1 : %2 %3 : %4 %5 : %6  %7 : %8[/size]",_cb1Text,_cb1Value,_cb2Text,_cb2Value,_cb3Text,_cb3Value,_cb4Text,_cb4Value];
  //PASS FAIL state from FUNC(passFail)
  private _missionOverallPassFail = [] call FUNC(passFail);
  S_NEWTEXTLINE ["[size=200]Test Result : %1[/size]",_missionOverallPassFail];
  //New Sub Section [Pre-mission Checklist]
  private _premissionPF = [GVAR(checklist) select 30 select 0] call _passFail;
  S_NEWTEXTLINE ["[size=150][u][color=#00BFFF]Pre-mission Checklist[/color][/u] : %1[/size]",_premissionPF];
  S_NEWTEXTLINE ["[spoiler=Pre-mission Checklist + Notes]"];
  S_NEWTEXTLINE ["[list]"];
  {[_x] call _checkBoxes;} forEach _premissionChecklistIDCs;
  S_NEWTEXTLINE ["[/list]"];
  private _premissionNotes = GVAR(checklist) select 31 select 0;
  S_NEWTEXTLINE ["[u][color=#FF4000][size=150]NOTES From Tester :[/size][/color][/u] %1",_premissionNotes];
  S_NEWTEXTLINE ["[/spoiler]"];

  //New Sub Section [Gear Checklist]
  private _gearPF = [GVAR(checklist) select 44 select 0] call _passFail;
  S_NEWTEXTLINE ["[size=150][u][color=#00BFFF]Gear Checklist[/color][/u] : %1[/size]",_gearPF];
  S_NEWTEXTLINE ["[spoiler=Pre-mission Checklist + Notes]"];
  S_NEWTEXTLINE ["[list]"];
  {[_x] call _checkBoxes;} forEach _gearChecklistIDCs;
  S_NEWTEXTLINE ["[/list]"];
  private _gearNotes = GVAR(checklist) select 45 select 0;
  S_NEWTEXTLINE ["[u][color=#FF4000][size=150]NOTES From Tester :[/size][/color][/u] %1",_gearNotes];
  S_NEWTEXTLINE ["[/spoiler]"];

  //New Sub Section [Vehicles Checklist]
  private _vicPF = [GVAR(checklist) select 52 select 0] call _passFail;
  S_NEWTEXTLINE ["[size=150][u][color=#00BFFF]Vehicles Checklist[/color][/u] : %1[/size]",_vicPF];
  S_NEWTEXTLINE ["[spoiler=Pre-mission Checklist + Notes]"];
  S_NEWTEXTLINE ["[list]"];
  {[_x] call _checkBoxes;} forEach _vehiclesChecklistIDCs;
  S_NEWTEXTLINE ["[/list]"];
  private _vicNotes = GVAR(checklist) select 53 select 0;
  S_NEWTEXTLINE ["[u][color=#FF4000][size=150]NOTES From Tester :[/size][/color][/u] %1",_vicNotes];
  S_NEWTEXTLINE ["[/spoiler]"];

  //New Sub Section [COOP Checklist]
  private _coopPF = [GVAR(checklist) select 62 select 0] call _passFail;
  S_NEWTEXTLINE ["[size=150][u][color=#00BFFF]COOP Checklist[/color][/u] : %1[/size]",_coopPF];
  S_NEWTEXTLINE ["[spoiler=Pre-mission Checklist + Notes]"];
  S_NEWTEXTLINE ["[list]"];
  {[_x] call _checkBoxes;} forEach _coopChecklistIDCs;
  S_NEWTEXTLINE ["[/list]"];
  private _coopNotes = GVAR(checklist) select 63 select 0;
  S_NEWTEXTLINE ["[u][color=#FF4000][size=150]NOTES From Tester :[/size][/color][/u] %1",_coopNotes];
  S_NEWTEXTLINE ["[/spoiler]"];

  //New Sub Section [Other Considerations Checklist]
  private _ocsPF = [GVAR(checklist) select 66 select 0] call _passFail;
  S_NEWTEXTLINE ["[size=150][u][color=#00BFFF]Other Considerations Checklist[/color][/u] : %1[/size]",_ocsPF];
  S_NEWTEXTLINE ["[spoiler=Pre-mission Checklist + Notes]"];
  S_NEWTEXTLINE ["[list]"];
  {[_x] call _checkBoxes;} forEach _otherConsiderationsChecklistIDCs;
  S_NEWTEXTLINE ["[/list]"];
  private _ocsNotes = GVAR(checklist) select 67 select 0;
  S_NEWTEXTLINE ["[u][color=#FF4000][size=150]NOTES From Tester :[/size][/color][/u] %1",_ocsNotes];
  S_NEWTEXTLINE ["[/spoiler]"];

  //General Notes For Mission Maker 

  S_NEWTEXTLINE["[size=150][b][u]General Feedback from Mission Tester[/u][/b][/size] :"];
  private _generalMissionNotes = GVAR(checklist) select 68 select 0;
  S_NEWTEXTLINE["%1",_generalMissionNotes];

  // Create String and output
  private _text = _textArray joinString (endl + endl);
  private _parentCtrl = MENU_DISPLAY displayCtrl 9991;
  private _reportCtrl = MENU_DISPLAY displayCtrl 6900;
  if (isNull _reportCtrl) then {
    private _reportCtrlNew = MENU_DISPLAY ctrlCreate ["RscEditMulti",6900,_parentCtrl];
    _reportCtrlNew ctrlSetPosition [0,(GVAR(groupHeight) + 0.01),0.98,0.3];
    _reportCtrlNew ctrlCommit 0;
    _reportCtrlNew ctrlSetText _text;
  } else {
    _reportCtrl ctrlSetText _text;
  };
  hint "Report Generated, Scroll down to view below the Generate button and copy past into a reply on the missions forum thread.";
};
