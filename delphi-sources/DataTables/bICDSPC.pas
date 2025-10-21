unit bICDSPC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocSpc = 'DocSpc';

type
  TIcdspcBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocSpc:word;           procedure WriteDocSpc (pValue:word);
    function  ReadSpcName:Str60;         procedure WriteSpcName (pValue:Str60);
    function  ReadPrnTxt1:Str100;        procedure WritePrnTxt1 (pValue:Str100);
    function  ReadPrnTxt2:Str100;        procedure WritePrnTxt2 (pValue:Str100);
    function  ReadPrnTxt3:Str100;        procedure WritePrnTxt3 (pValue:Str100);
    function  ReadPrnTxt4:Str100;        procedure WritePrnTxt4 (pValue:Str100);
    function  ReadPrnTxt5:Str100;        procedure WritePrnTxt5 (pValue:Str100);
    function  ReadVatSpc:byte;           procedure WriteVatSpc (pValue:byte);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateDocSpc (pDocSpc:word):boolean;
    function NearestDocSpc (pDocSpc:word):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open;
    procedure Close;
    procedure Prior; virtual;
    procedure Next; virtual;
    procedure First; virtual;
    procedure Last; virtual;
    procedure Insert; virtual;
    procedure Edit; virtual;
    procedure Post; virtual;
    procedure Delete; virtual;
    procedure SwapIndex;
    procedure RestoreIndex;
    procedure SwapStatus;
    procedure RestoreStatus;
    procedure EnableControls;
    procedure DisableControls;
  published
    property BtrTable:TNexBtrTable read oBtrTable;
    property Count:integer read ReadCount;
    // Pristup k databazovym poliam
    property DocSpc:word read ReadDocSpc write WriteDocSpc;
    property SpcName:Str60 read ReadSpcName write WriteSpcName;
    property PrnTxt1:Str100 read ReadPrnTxt1 write WritePrnTxt1;
    property PrnTxt2:Str100 read ReadPrnTxt2 write WritePrnTxt2;
    property PrnTxt3:Str100 read ReadPrnTxt3 write WritePrnTxt3;
    property PrnTxt4:Str100 read ReadPrnTxt4 write WritePrnTxt4;
    property PrnTxt5:Str100 read ReadPrnTxt5 write WritePrnTxt5;
    property VatSpc:byte read ReadVatSpc write WriteVatSpc;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TIcdspcBtr.Create;
begin
  oBtrTable := BtrInit ('ICDSPC',gPath.LdgPath,Self);
end;

constructor TIcdspcBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('ICDSPC',pPath,Self);
end;

destructor TIcdspcBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TIcdspcBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TIcdspcBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TIcdspcBtr.ReadDocSpc:word;
begin
  Result := oBtrTable.FieldByName('DocSpc').AsInteger;
end;

procedure TIcdspcBtr.WriteDocSpc(pValue:word);
begin
  oBtrTable.FieldByName('DocSpc').AsInteger := pValue;
end;

function TIcdspcBtr.ReadSpcName:Str60;
begin
  Result := oBtrTable.FieldByName('SpcName').AsString;
end;

procedure TIcdspcBtr.WriteSpcName(pValue:Str60);
begin
  oBtrTable.FieldByName('SpcName').AsString := pValue;
end;

function TIcdspcBtr.ReadPrnTxt1:Str100;
begin
  Result := oBtrTable.FieldByName('PrnTxt1').AsString;
end;

procedure TIcdspcBtr.WritePrnTxt1(pValue:Str100);
begin
  oBtrTable.FieldByName('PrnTxt1').AsString := pValue;
end;

function TIcdspcBtr.ReadPrnTxt2:Str100;
begin
  Result := oBtrTable.FieldByName('PrnTxt2').AsString;
end;

procedure TIcdspcBtr.WritePrnTxt2(pValue:Str100);
begin
  oBtrTable.FieldByName('PrnTxt2').AsString := pValue;
end;

function TIcdspcBtr.ReadPrnTxt3:Str100;
begin
  Result := oBtrTable.FieldByName('PrnTxt3').AsString;
end;

procedure TIcdspcBtr.WritePrnTxt3(pValue:Str100);
begin
  oBtrTable.FieldByName('PrnTxt3').AsString := pValue;
end;

function TIcdspcBtr.ReadPrnTxt4:Str100;
begin
  Result := oBtrTable.FieldByName('PrnTxt4').AsString;
end;

procedure TIcdspcBtr.WritePrnTxt4(pValue:Str100);
begin
  oBtrTable.FieldByName('PrnTxt4').AsString := pValue;
end;

function TIcdspcBtr.ReadPrnTxt5:Str100;
begin
  Result := oBtrTable.FieldByName('PrnTxt5').AsString;
end;

procedure TIcdspcBtr.WritePrnTxt5(pValue:Str100);
begin
  oBtrTable.FieldByName('PrnTxt5').AsString := pValue;
end;

function TIcdspcBtr.ReadVatSpc:byte;
begin
  Result := oBtrTable.FieldByName('VatSpc').AsInteger;
end;

procedure TIcdspcBtr.WriteVatSpc(pValue:byte);
begin
  oBtrTable.FieldByName('VatSpc').AsInteger := pValue;
end;

function TIcdspcBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TIcdspcBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TIcdspcBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TIcdspcBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TIcdspcBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TIcdspcBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TIcdspcBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TIcdspcBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TIcdspcBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TIcdspcBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TIcdspcBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TIcdspcBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TIcdspcBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TIcdspcBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TIcdspcBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIcdspcBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TIcdspcBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIcdspcBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TIcdspcBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TIcdspcBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TIcdspcBtr.LocateDocSpc (pDocSpc:word):boolean;
begin
  SetIndex (ixDocSpc);
  Result := oBtrTable.FindKey([pDocSpc]);
end;

function TIcdspcBtr.NearestDocSpc (pDocSpc:word):boolean;
begin
  SetIndex (ixDocSpc);
  Result := oBtrTable.FindNearest([pDocSpc]);
end;

procedure TIcdspcBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TIcdspcBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TIcdspcBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TIcdspcBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TIcdspcBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TIcdspcBtr.First;
begin
  oBtrTable.First;
end;

procedure TIcdspcBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TIcdspcBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TIcdspcBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TIcdspcBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TIcdspcBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TIcdspcBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TIcdspcBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TIcdspcBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TIcdspcBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TIcdspcBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TIcdspcBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
