unit NxpDef;

interface

uses
  IcTypes, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, BtrTable, NexBtrTable, DBTables, NexPxTable;

type
  TNxp = class(TForm)
    btNXPDEF: TNexBtrTable;
    ptNXPDEF: TNexPxTable;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    function ReadCount:integer;
    function ReadPmdMark:Str6;
    procedure WritePmdMark(pValue:Str6);
    function ReadPmdName:Str30;
    procedure WritePmdName(pValue:Str30);
  public
    function Eof: boolean;
    function Locate (pPmdMark:Str6):boolean;
    function GetPmdName (pPmdMark:Str6):Str30;
    procedure DataToTemp;
    procedure Prior;
    procedure Next;
    procedure First;
    procedure Last;
    procedure Insert;
    procedure Edit;
    procedure Post;
    procedure SwapIndex;
    procedure RestoreIndex;
  published
    property DataSet:TNexBtrTable read btNXPDEF;
    property TempSet:TNexPxTable read ptNXPDEF write ptNXPDEF;
    property Count:integer read ReadCount;
    property PmdMark:Str6 read ReadPmdMark write WritePmdMark;
    property PmdName:Str30 read ReadPmdName write WritePmdName;
  end;

implementation

{$R *.dfm}

procedure TNxp.FormCreate(Sender: TObject);
begin
  btNXPDEF.Open;
end;

procedure TNxp.FormDestroy(Sender: TObject);
begin
  btNXPDEF.Close;
end;

// *************************************** PRIVATE ********************************************

function TNxp.ReadCount:integer;
begin
  Result := btNXPDEF.RecordCount;
end;

function TNxp.ReadPmdMark:Str6;
begin
  Result := btNXPDEF.FieldByName('PmdMark').AsString;
end;

procedure TNxp.WritePmdMark(pValue:Str6);
begin
  btNXPDEF.FieldByName('PmdMark').AsString := pValue;
end;

function TNxp.ReadPmdName:Str30;
begin
  Result := btNXPDEF.FieldByName('PmdName').AsString;
end;

procedure TNxp.WritePmdName(pValue:Str30);
begin
  btNXPDEF.FieldByName('PmdName').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TNxp.Eof: boolean;
begin
  Result := btNXPDEF.Eof;
end;

function TNxp.Locate (pPmdMark:Str6):boolean;
begin
  If btNXPDEF.IndexName<>'PmdMark' then btNXPDEF.IndexName := 'PmdMark';
  Result := btNXPDEF.FindKey([pPmdMark]);
end;

function TNxp.GetPmdName (pPmdMark:Str6):Str30;
begin
  Result := '';
  btNXPDEF.SwapIndex;
  If Locate (pPmdMark) then Result := PmdName;
  btNXPDEF.RestoreIndex
end;

procedure TNxp.DataToTemp;
begin
  ptNXPDEF.Insert;
  Btr_To_Px (btNXPDEF,ptNXPDEF);
  ptNXPDEF.Post;
end;

procedure TNxp.Prior;
begin
  btNXPDEF.Prior;
end;

procedure TNxp.Next;
begin
  btNXPDEF.Next;
end;

procedure TNxp.First;
begin
  btNXPDEF.First;
end;

procedure TNxp.Last;
begin
  btNXPDEF.Last;
end;

procedure TNxp.Insert;
begin
  btNXPDEF.Insert;
end;

procedure TNxp.Edit;
begin
  btNXPDEF.Edit;
end;

procedure TNxp.Post;
begin
  btNXPDEF.Post;
end;

procedure TNxp.SwapIndex;
begin
  btNXPDEF.SwapIndex;
end;

procedure TNxp.RestoreIndex;
begin
  btNXPDEF.RestoreIndex;
end;

end.
