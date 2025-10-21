unit ActTurn;

interface

uses
  IcTypes, IcVariab, IcConv, NexVar, NexPath, TxtCut,
  SysUtils, IniFiles, Classes;

type
  TCasVal=array [0..9] of double;

  TActTurn = class
  private
    oUsrName:Str30;
    oActDate:TDateTime;
    oActTime:TDateTime;
    oIncVal:double;
    oCncVal:double;
    oClmVal:double;
    oNegVal:double;
    oDscVal:double;
    oBegVal:TCasVal;
    oTrnVal:TCasVal;
    oExpVal:TCasVal;
    oActVal:TCasVal;
    oCusCnt:integer;
    procedure ReadCasVal (var pCasVal:TCasVal;pData:string);
    function SumCasVal (pCasVal:TCasVal):double;

    function GetBegSum: double;
    function GetTrnSum: double;
    function GetExpSum: double;
    function GetActSum: double;

  public
    procedure ReadData (pCasNum:word); // Nacita udaje zadane pokladne
  published
    property UsrName:Str30 read oUsrName;
    property ActDate:TDateTime read oActDate;
    property ActTime:TDateTime read oActTime;
    property IncVal:double read oIncVal;
    property CncVal:double read oCncVal;
    property ClmVal:double read oClmVal;
    property NegVal:double read oNegVal;
    property DscVal:double read oDscVal;
//    property BegVal:double read GetBegVal;
//    property TrnVal:double read GetTrnVal;
//    property ExpVal:double read GetExpVal;
//    property ActVal:double read GetActVal;
    property BegSum:double read GetBegSum;
    property TrnSum:double read GetTrnSum;
    property ExpSum:double read GetExpSum;
    property ActSum:double read GetActSum;
    property CusCnt:integer read oCusCnt;
  end;

var
  gActTurn: TActTurn;

implementation

procedure TActTurn.ReadCasVal (var pCasVal:TCasVal;pData:string);
var mCut:TTxtCut; I:byte;
begin
  mCut := TTxtCut.Create;
  mCut.SetStr(pData);
  For I:=0 to 9 do
    pCasVal[I] := mCut.GetReal(I+1);
  FreeAndNil (mCut);
end;

function TActTurn.SumCasVal (pCasVal:TCasVal):double;
var I:byte;
begin
  Result := 0;
  For I:=0 to 9 do
    Result := Result+pCasVal[I];
end;

procedure TActTurn.ReadData (pCasNum:word); // Nacita udaje zadane pokladne
var mFile:TIniFile;
begin
  mFile := TIniFile.Create(gPath.CabPath+'ACTTURN.'+StrIntZero(pCasNum,3));
  oUsrName := mFile.ReadString ('INFO','UsrName','');
  oActDate := mFile.ReadDate ('INFO','ActDate',Date);
  oActTime := mFile.ReadTime ('INFO','ActTime',Time);
  oIncVal := ValDoub (mFile.ReadString ('INFO','IncVal','0'));
  oCncVal := ValDoub (mFile.ReadString ('INFO','CncVal','0'));
  oClmVal := ValDoub (mFile.ReadString ('INFO','ClmVal','0'));
  oNegVal := ValDoub (mFile.ReadString ('INFO','NegVal','0'));
  oDscVal := ValDoub (mFile.ReadString ('INFO','DscVal','0'));
  oCusCnt := mFile.ReadInteger ('INFO','CusCnt',0);
  ReadCasVal (oBegVal,mFile.ReadString ('INFO','BegVal',''));
  ReadCasVal (oTrnVal,mFile.ReadString ('INFO','TrnVal',''));
  ReadCasVal (oExpVal,mFile.ReadString ('INFO','ExpVal',''));
  ReadCasVal (oActVal,mFile.ReadString ('INFO','ActVal',''));
  FreeAndNil (mFile);
end;

// ************************* PROPERTY *****************************

function TActTurn.GetBegSum: double;
begin
  Result := SumCasVal (oBegVal);
end;

function TActTurn.GetTrnSum: double;
begin
  Result := SumCasVal (oTrnVal);
end;

function TActTurn.GetExpSum: double;
begin
  Result := SumCasVal (oExpVal);
end;

function TActTurn.GetActSum: double;
begin
  Result := SumCasVal (oActVal);
end;

end.
