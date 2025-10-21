unit pFGPADSC;

interface

uses
  IcTypes, NexPath, NexGlob, DocHand, bFGPADSC,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, DBTables, NexPxTable;

const
  ixFgCode = '';

type
  TFgpadscTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    // Pristup k databazovym poliam
    function  ReadFgCode:longint;        procedure WriteFgCode (pValue:longint);
    function  ReadFgName:Str30;          procedure WriteFgName (pValue:Str30);
    function  ReadDescribe:Str150;       procedure WriteDescribe (pValue:Str150);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateFgCode (pFgCode:longint):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open;
    procedure Close;
    procedure Prior;
    procedure Next;
    procedure First;
    procedure Last;
    procedure Insert;
    procedure Edit;
    procedure Post;
    procedure Delete;
    procedure SwapIndex;
    procedure RestoreIndex;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read ReadCount;
    property FgCode:longint read ReadFgCode write WriteFgCode;
    property FgName:Str30 read ReadFgName write WriteFgName;
    property Describe:Str150 read ReadDescribe write WriteDescribe;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TFgpadscTmp.Create;
begin
  oTmpTable := TmpInit ('FGPADSC',Self);
end;

destructor  TFgpadscTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TFgpadscTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TFgpadscTmp.ReadFgCode:longint;
begin
  Result := oTmpTable.FieldByName('FgCode').AsInteger;
end;

procedure TFgpadscTmp.WriteFgCode(pValue:longint);
begin
  oTmpTable.FieldByName('FgCode').AsInteger := pValue;
end;

function TFgpadscTmp.ReadFgName:Str30;
begin
  Result := oTmpTable.FieldByName('FgName').AsString;
end;

procedure TFgpadscTmp.WriteFgName(pValue:Str30);
begin
  oTmpTable.FieldByName('FgName').AsString := pValue;
end;

function TFgpadscTmp.ReadDescribe:Str150;
begin
  Result := oTmpTable.FieldByName('Describe').AsString;
end;

procedure TFgpadscTmp.WriteDescribe(pValue:Str150);
begin
  oTmpTable.FieldByName('Describe').AsString := pValue;
end;

function TFgpadscTmp.ReadDscPrc:double;
begin
  Result := oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TFgpadscTmp.WriteDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TFgpadscTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TFgpadscTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TFgpadscTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TFgpadscTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TFgpadscTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TFgpadscTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TFgpadscTmp.LocateFgCode (pFgCode:longint):boolean;
begin
  SetIndex (ixFgCode);
  Result := oTmpTable.FindKey([pFgCode]);
end;

procedure TFgpadscTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TFgpadscTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TFgpadscTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TFgpadscTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TFgpadscTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TFgpadscTmp.First;
begin
  oTmpTable.First;
end;

procedure TFgpadscTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TFgpadscTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TFgpadscTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TFgpadscTmp.Post;
begin
  oTmpTable.Post;
end;

procedure TFgpadscTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TFgpadscTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TFgpadscTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

end.
