#include "script_component.hpp"
GVAR(groupHeight) = nil;
GVAR(yStartCoord) = nil;
GVAR(idcIndex) = nil;
/*
FUNCTION :
DESCRIPTION :
INPUTS :
OUTPUTS :
 */
FUNC(uiTile) = {
	params["_array","_xStartPos","_yStartPos","_index","_hozVert","_group"];
	TRACE_1("",_this);
  TRACE_1("Start of Loop",GVAR(groupHeight));
  private _display = findDisplay 9999;
	private _yCoord = nil;
  private _groupHeight = 0;
  if (!isNil "_yStartPos") then {
  _yCoord = _yStartPos;
  GVAR(groupHeight) = 0;
  GVAR(yStartCoord) = _yStartPos;
  } else {
    _yCoord = GVAR(yStartCoord) + GVAR(groupHeight);
  };
  if(!isNil "_index") then {
    GVAR(idcIndex) = _index;
  } else {
    GVAR(idcIndex) = GVAR(idcIndex) + 1;
  };
  TRACE_1("",_yCoord);
	private _xCoord = _xStartPos;
	{
		_ctrlName = _x select 0;
		_ctrlType = _x select 1;
		_ctrlWidth = _x select 2;
		_ctrlHeight = _x select 3;
		_ctrltext = _x select 4;
		_ctrlfunction = _x select 5;
    _eh = _x select 6;
    _ctrlGroup = nil;
    TRACE_1("Creating Ctrl",_ctrlName);
		_idc = _forEachIndex + (10 * GVAR(idcIndex)) + 1000;
      if(_hozVert == 1) then {
        _xCoord;
        _xCoord = _xStartPos;
      };
    if(_group > 0) then {
      _ctrlGroup = _display displayCtrl (9990 + _group);
    };
		_ctrlCreate = _display ctrlCreate [_ctrlType,_idc,_ctrlGroup];
		_ctrlCreate ctrlSetPosition [_xCoord,_yCoord,_ctrlWidth,_ctrlHeight];
		[_ctrlType,_ctrlCreate,_ctrltext,_ctrlfunction,_idc,_eh] call FUNC(ctrlSwitch);
		_ctrlPosition = ctrlPosition _ctrlCreate;
		_stridc = str _idc + " at Position " + str _ctrlPosition;
		UITOOLTIP(_ctrlCreate,_stridc);
		_ctrlCreate ctrlCommit 0;
    if(_hozVert == 1) then {
      _yCoord = _yCoord + _ctrlHeight + 0.01;
      _groupHeight = _groupHeight + _ctrlHeight + 0.01;
    } else {
		_xCoord = _xCoord + _ctrlWidth + 0.01;
      if(_groupHeight<_ctrlHeight) then {
        _groupHeight = _ctrlHeight + 0.01;
      };
    };
    TRACE_1("",_groupHeight);
	} forEach _array;
  GVAR(groupHeight) = GVAR(groupHeight) + _groupHeight;
  TRACE_1("End of Loop",GVAR(groupHeight));
  TRACE_1("",GVAR(idcIndex));
};
/*
FUNCTION :
DESCRIPTION :
INPUTS :
OUTPUTS :
 */
FUNC(ctrlSwitch) = {
	params["_ctrlType","_ctrlCreate","_ctrltext","_ctrlfunction","_idc","_eh"];
	switch _ctrlType do {
		case "RscButton": {
			[_ctrlCreate,_ctrltext,_ctrlfunction,_idc,_eh] call FUNC(BadButton);
		};
		case "RscText": {
			[_ctrlCreate,_ctrltext,_ctrlfunction,_idc,_eh] call FUNC(BadText);
		};
		case "RscStructuredText": {
			[_ctrlCreate,_ctrltext,_ctrlfunction,_idc,_eh] call FUNC(BadTextStructured);
		};
		case "RscListBox": {
			[_ctrlCreate,_ctrltext,_ctrlfunction,_idc,_eh] call FUNC(BadListbox);
		};
		case "RscPictureKeepAspect": {
			[_ctrlCreate,_ctrltext,_ctrlfunction,_idc,_eh] call FUNC(BadPicture);
		};
		case "RscCombo": {
			[_ctrlCreate,_ctrltext,_ctrlfunction,_idc,_eh] call FUNC(BadCombo);
		};
		case "RscEdit": {
			[_ctrlCreate,_ctrltext,_ctrlfunction,_idc,_eh] call FUNC(BadEdit);
		};
		case "RscCheckBox": {
			[_ctrlCreate,_ctrltext,_ctrlfunction,_idc,_eh] call FUNC(BadCheckBox);
		};
		case "RscSlider": {
			[_ctrlCreate,_ctrltext,_ctrlfunction,_idc,_eh] call FUNC(BadCheckBox);
		};
		case "RscFrame": {
			[_ctrlCreate,_ctrltext,_ctrlfunction,_idc,_eh] call FUNC(BadFrame);
		};
		case "RscXListBox": {
			[_ctrlCreate,_ctrltext,_ctrlfunction,_idc,_eh] call FUNC(BadXListBox);
		};
		case "RscListBoxMulti": {
			[_ctrlCreate,_ctrltext,_ctrlfunction,_idc,_eh] call FUNC(BadListBoxMulti);
		};
		case "RscHTML": {
			[_ctrlCreate,_ctrltext,_ctrlfunction,_idc,_eh] call FUNC(BadHTML);
		};
		case "RscLine": {
			[_ctrlCreate,_ctrltext,_ctrlfunction,_idc,_eh] call FUNC(BadLine);
		};
		case "RscEditMulti": {
			[_ctrlCreate,_ctrltext,_ctrlfunction,_idc,_eh] call FUNC(BadEditMulti);
		};
	};
};
/*
FUNCTION :
DESCRIPTION :
INPUTS :
OUTPUTS :
 */
FUNC(BadButton) = {
	params["_ctrlCreate","_ctrltext","_ctrlfunction","_idc","_eh"];
	_ctrlCreate ctrlSetText _ctrltext;
	_ctrlCreate buttonSetAction _ctrlfunction;
  if(count _eh > 0) then {
  _ctrlCreate ctrlAddEventHandler _eh;
  };
};
/*
FUNCTION :
DESCRIPTION :
INPUTS :
OUTPUTS :
 */
FUNC(BadText) = {
	params["_ctrlCreate","_ctrltext","_ctrlfunction","_idc","_eh"];
	_ctrlCreate ctrlSetText _ctrltext;
  if (count _ctrlfunction == 4) then {
  _ctrlCreate ctrlSetTextColor _ctrlfunction;
  };
  if(count _eh > 0) then {
  _ctrlCreate ctrlAddEventHandler _eh;
  };
};
/*
FUNCTION :
DESCRIPTION :
INPUTS :
OUTPUTS :
 */
FUNC(BadTextStructured) = {
	params["_ctrlCreate","_ctrltext","_ctrlfunction","_idc","_eh"];
	_ctrlCreate ctrlSetStructuredText parseText _ctrltext;
	_ctrlCreate ctrlSetBackgroundColor [1, 1, 1, 0.25];
  if(count _eh > 0) then {
  _ctrlCreate ctrlAddEventHandler _eh;
  };
};
/*
FUNCTION :
DESCRIPTION :
INPUTS :
OUTPUTS :
 */
FUNC(BadListbox) = {
	params["_ctrlCreate","_ctrltext","_ctrlfunction","_idc","_eh"];
	lbCLear _ctrlCreate;
	{
		_ctrlCreate lbAdd _x;
	} forEach _ctrltext;
	_ctrlCreate lbSetCurSel 0;
  if(count _eh > 0) then {
  _ctrlCreate ctrlAddEventHandler _eh;
  };
};
/*
FUNCTION :
DESCRIPTION :
INPUTS :
OUTPUTS :
 */
FUNC(BadPicture) = {
	params["_ctrlCreate","_ctrltext","_ctrlfunction","_idc","_eh"];
  if(count _eh > 0) then {
  _ctrlCreate ctrlAddEventHandler _eh;
  };
};
/*
FUNCTION :
DESCRIPTION :
INPUTS :
OUTPUTS :
 */
FUNC(BadCombo) = {
	params["_ctrlCreate","_ctrltext","_ctrlfunction","_idc","_eh"];
	lbCLear _ctrlCreate;
	{
		_ctrlCreate lbAdd _x;
	} forEach _ctrltext;
	_ctrlCreate lbSetCurSel 0;
  if(count _eh > 0) then {
  _ctrlCreate ctrlAddEventHandler _eh;
  };
};
/*
FUNCTION :
DESCRIPTION :
INPUTS :
OUTPUTS :
 */
FUNC(BadEdit) = {
	params["_ctrlCreate","_ctrltext","_ctrlfunction","_idc","_eh"];
	_ctrlCreate ctrlSetText _ctrltext;
  if(count _eh > 0) then {
  _ctrlCreate ctrlAddEventHandler _eh;
  };
};
/*
FUNCTION :
DESCRIPTION :
INPUTS :
OUTPUTS :
 */
FUNC(BadCheckBox) = {
	params["_ctrlCreate","_ctrltext","_ctrlfunction","_idc","_eh"];
  if(count _eh > 0) then {
  _ctrlCreate ctrlAddEventHandler _eh;
  };

};
/*
FUNCTION :
DESCRIPTION :
INPUTS :
OUTPUTS :
 */
FUNC(BadSlider) = {
	params["_ctrlCreate","_ctrltext","_ctrlfunction","_idc","_eh"];
  if(count _eh > 0) then {
  _ctrlCreate ctrlAddEventHandler _eh;
  };
};
/*
FUNCTION :
DESCRIPTION :
INPUTS :
OUTPUTS :
 */
FUNC(BadFrame) = {
	params["_ctrlCreate","_ctrltext","_ctrlfunction","_idc","_eh"];
  if(count _eh > 0) then {
  _ctrlCreate ctrlAddEventHandler _eh;
  };
};
/*
FUNCTION :
DESCRIPTION :
INPUTS :
OUTPUTS :
 */
FUNC(BadXListBox) = {
	params["_ctrlCreate","_ctrltext","_ctrlfunction","_idc","_eh"];
	lbCLear _ctrlCreate;
	{
		_ctrlCreate lbAdd _x;
	} forEach _ctrltext;
	_ctrlCreate lbSetCurSel 0;
  if(count _eh > 0) then {
  _ctrlCreate ctrlAddEventHandler _eh;
  };
};
/*
FUNCTION :
DESCRIPTION :
INPUTS :
OUTPUTS :
 */
FUNC(BadListBoxMulti) = {
	params["_ctrlCreate","_ctrltext","_ctrlfunction","_idc","_eh"];
	lbCLear _ctrlCreate;
	{
		_ctrlCreate lbAdd _x;
	} forEach _ctrltext;
	_ctrlCreate lbSetCurSel 0;
  if(count _eh > 0) then {
  _ctrlCreate ctrlAddEventHandler _eh;
  };
};
/*
FUNCTION :
DESCRIPTION :
INPUTS :
OUTPUTS :
 */
FUNC(BadHTML) = {
	params["_ctrlCreate","_ctrltext","_ctrlfunction","_idc","_eh"];
  _ctrlCreate htmlLoad _ctrltext;
  if(count _eh > 0) then {
  _ctrlCreate ctrlAddEventHandler _eh;
  };
};
/*
FUNCTION :
DESCRIPTION :
INPUTS :
OUTPUTS :
 */
FUNC(BadLine) = {
	params["_ctrlCreate","_ctrltext","_ctrlfunction","_idc","_eh"];
  if(count _eh > 0) then {
  _ctrlCreate ctrlAddEventHandler _eh;
  };
};
/*
FUNCTION :
DESCRIPTION :
INPUTS :
OUTPUTS :
 */
FUNC(BadEditMulti) = {
	params["_ctrlCreate","_ctrltext","_ctrlfunction","_idc","_eh"];
  _ctrlCreate ctrlSetText _ctrltext;
  _ctrlCreate ctrlSetBackgroundColor [1, 1, 1, 0.25];
  _ctrlCreate ctrlSetTextColor TEXT_BLUE;
  if(count _eh > 0) then {
  _ctrlCreate ctrlAddEventHandler _eh;
  };
};
