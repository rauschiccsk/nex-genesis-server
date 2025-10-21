unit DirKey;

interface

uses
  IcTypes, IcConv, IcVariab, NexPath, NexGlob, NexIni, hKEYDEF,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

type
  TDirKey = class (TComponent)
    constructor Create(phKEYDEF:TKeydefHnd);
    destructor  Destroy; override;
  private
    ohKEYDEF:TKeydefHnd;
    function ReadCntNum:longint;   procedure WriteCntNum(pValue:longint);
  public
    property CntNum:longint read ReadCntNum write WriteCntNum; // Poradové èíslo kontaktnej karty
  end;

implementation

constructor TDirKey.Create(phKEYDEF:TKeydefHnd);
begin
  ohKEYDEF := phKEYDEF;
end;

destructor TDirKey.Destroy;
begin
end;

// ******************************** PRIVATE ************************************

function TDirKey.ReadCntNum:longint;
begin
  Result := ohKEYDEF.ReadInteger('DIR','','CntNum',0);
end;

procedure TDirKey.WriteCntNum(pValue:longint);
begin
  ohKEYDEF.WriteInteger('DIR','','CntNum',pValue)
end;

// ********************************* PUBLIC ************************************

end.


