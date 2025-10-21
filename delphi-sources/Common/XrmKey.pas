unit XrmKey;

interface

uses
  IcTypes, IcConv, IcVariab, NexPath, NexGlob, NexIni, hKEYDEF,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

type
  TXrmKey=class(TComponent)
    constructor Create(phKEYDEF:TKeydefHnd);
    destructor  Destroy; override;
  private
    ohKEYDEF:TKeydefHnd;
    function ReadYerDef(pPerNum:byte):integer;   procedure WriteYerDef(pPerNum:byte;pValue:integer);
    function ReadBegDef(pPerNum:byte):byte;      procedure WriteBegDef(pPerNum:byte;pValue:byte);

  public
    property YerDef[pPerNum:byte]:integer  read ReadYerDef write WriteYerDef;  // Rok: 0-aktualny; (-1)-predchádzajúci
    property BegDef[pPerNum:byte]:byte     read ReadBegDef write WriteBegDef;  // Za4iatok: 0-zaèiatok roka; 1-zaèiatok mesiaca
  end;

implementation

constructor TXrmKey.Create(phKEYDEF:TKeydefHnd);
begin
  ohKEYDEF:=phKEYDEF;
end;

destructor TXrmKey.Destroy;
begin
end;

// ******************************** PRIVATE ************************************

function TXrmKey.ReadYerDef(pPerNum:byte):integer;
begin
  Result:=ohKEYDEF.ReadInteger('XRM','','YerDef'+StrInt(pPerNum,0),0);
end;

procedure TXrmKey.WriteYerDef(pPerNum:byte;pValue:integer);
begin
  ohKEYDEF.Writeinteger('XRM','','YerDef'+StrInt(pPerNum,0),pValue);
end;

function TXrmKey.ReadBegDef(pPerNum:byte):byte;
begin
  Result:=ohKEYDEF.ReadInteger('XRM','','BegDef'+StrInt(pPerNum,0),0);
end;

procedure TXrmKey.WriteBegDef(pPerNum:byte;pValue:byte);
begin
  ohKEYDEF.Writeinteger('XRM','','BegDef'+StrInt(pPerNum,0),pValue);
end;

end.

