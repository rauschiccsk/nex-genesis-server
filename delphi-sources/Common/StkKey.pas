unit StkKey;

interface

uses
  IcTypes, IcConv, IcVariab, NexPath, NexGlob, NexIni, hKEYDEF, hSTKLST,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

type
  TStkKey=class (TComponent)
    constructor Create(phKEYDEF:TKeydefHnd);
    destructor Destroy; override;
  private
    ohKEYDEF:TKeydefHnd;
    function ReadMaiStk:word;       procedure WriteMaiStk(pValue:word);
  public
    property MaiStk:word read ReadMaiStk write WriteMaiStk;      // Hlavný sklad firmy
  end;

implementation

uses bStklst;

constructor TStkKey.Create(phKEYDEF:TKeydefHnd);
begin
  ohKEYDEF:=phKEYDEF;
end;

destructor TStkKey.Destroy;
begin
end;

// ******************************** PRIVATE ************************************

function TStkKey.ReadMaiStk:word;
var mhSTKLST:TStklstHnd;
begin
  Result:=ohKEYDEF.ReadInteger('STK','','MaiStk',0);
  If Result=0 then begin // Nastavíme prvý sklad
    mhSTKLST:=TStklstHnd.Create; mhSTKLST.Open;
    mhSTKLST.First;
    Result:=mhSTKLST.StkNum;
    WriteMaiStk(mhSTKLST.StkNum);
    FreeAndNil(mhSTKLST);
  end;
end;

procedure TStkKey.WriteMaiStk(pValue:word);
begin
  ohKEYDEF.Writeinteger('STK','','MaiStk',pValue);
end;
// ********************************* PUBLIC ************************************

end.

