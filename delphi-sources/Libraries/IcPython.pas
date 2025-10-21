unit IcPython;

interface

uses SysUtils, Windows, ShellAPI, IcTypes, NexPath;

const
  PY_WAITING = 0;
  PY_NOWAITING = 1;

function PythonScriptExecute(pPhytonFileName:string; pWaitForFinish:byte):integer;

implementation

function PythonScriptExecute(pPhytonFileName:string; pWaitForFinish:byte):integer;
var mPythonPath,mScriptPath:string;
begin
  mPythonPath := gPath.SysPath + '\python.exe';
  mScriptPath := gPath.SysPath + '\PYSCRIPTS\' + pPhytonFileName;
  ShellExecute(0, 'open', PChar(mPythonPath), PChar(Format('"%s" "%s"', [mScriptPath, 'Parameterben atadott text'])), nil, SW_HIDE);
end;

end.
