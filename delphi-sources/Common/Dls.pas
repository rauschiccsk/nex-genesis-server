unit Dls;

{$F+}

interface

uses
  IcTypes, IcConst, IcConv, IcTools, IcVariab,
  hSTALST,
  NexBtrTable, NexPxTable, NexGlob, NexPath, NexIni, NexMsg, NexError,
  StkGlob, DocHand, LinLst,  SavClc, TxtDoc, TxtWrap,
  DB, SysUtils, Classes, Graphics, ExtCtrls, Jpeg, Forms;

type
  TDls = class(TComponent)
    constructor Create;
    destructor  Destroy; override;
    private
    public
      ohSTALST:TStalstHnd;
      function GetStaName(pStaCode:Str2):Str30;
    published
  end;

implementation

uses bStalst;

constructor TDls.Create;
begin
  ohSTALST:=TStalstHnd.Create;
end;

destructor TDls.Destroy;
begin
  FreeAndNil (ohSTALST);
end;

// ********************************* PUBLIC ************************************

function TDls.GetStaName(pStaCode:Str2):Str30;
begin
  Result:='';
  If not ohSTALST.Active then ohSTALST.Open;
  If ohSTALST.LocateStaCode(pStaCode) then Result:=ohSTALST.StaName;
end;

// ********************************* PRIVATE ***********************************

end.
{MOD 1907001}
