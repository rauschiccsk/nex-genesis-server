unit bBRGBAC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixBtBi = 'BtBi';

type
  TBrgbacBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadBrgTyp:Str1;           procedure WriteBrgTyp (pValue:Str1);
    function  ReadBacImp:Str30;          procedure WriteBacImp (pValue:Str30);
    function  ReadBacOut:Str30;          procedure WriteBacOut (pValue:Str30);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateBtBi (pBrgTyp:Str1;pBacImp:Str30):boolean;
    function NearestBtBi (pBrgTyp:Str1;pBacImp:Str30):boolean;

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
    property BrgTyp:Str1 read ReadBrgTyp write WriteBrgTyp;
    property BacImp:Str30 read ReadBacImp write WriteBacImp;
    property BacOut:Str30 read ReadBacOut write WriteBacOut;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
  end;

implementation

constructor TBrgbacBtr.Create;
begin
  oBtrTable := BtrInit ('BRGBAC',gPath.StkPath,Self);
end;

constructor TBrgbacBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('BRGBAC',pPath,Self);
end;

destructor TBrgbacBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TBrgbacBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TBrgbacBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TBrgbacBtr.ReadBrgTyp:Str1;
begin
  Result := oBtrTable.FieldByName('BrgTyp').AsString;
end;

procedure TBrgbacBtr.WriteBrgTyp(pValue:Str1);
begin
  oBtrTable.FieldByName('BrgTyp').AsString := pValue;
end;

function TBrgbacBtr.ReadBacImp:Str30;
begin
  Result := oBtrTable.FieldByName('BacImp').AsString;
end;

procedure TBrgbacBtr.WriteBacImp(pValue:Str30);
begin
  oBtrTable.FieldByName('BacImp').AsString := pValue;
end;

function TBrgbacBtr.ReadBacOut:Str30;
begin
  Result := oBtrTable.FieldByName('BacOut').AsString;
end;

procedure TBrgbacBtr.WriteBacOut(pValue:Str30);
begin
  oBtrTable.FieldByName('BacOut').AsString := pValue;
end;

function TBrgbacBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TBrgbacBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TBrgbacBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TBrgbacBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TBrgbacBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TBrgbacBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TBrgbacBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TBrgbacBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TBrgbacBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TBrgbacBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TBrgbacBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TBrgbacBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TBrgbacBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TBrgbacBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TBrgbacBtr.LocateBtBi (pBrgTyp:Str1;pBacImp:Str30):boolean;
begin
  SetIndex (ixBtBi);
  Result := oBtrTable.FindKey([pBrgTyp,pBacImp]);
end;

function TBrgbacBtr.NearestBtBi (pBrgTyp:Str1;pBacImp:Str30):boolean;
begin
  SetIndex (ixBtBi);
  Result := oBtrTable.FindNearest([pBrgTyp,pBacImp]);
end;

procedure TBrgbacBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TBrgbacBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TBrgbacBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TBrgbacBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TBrgbacBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TBrgbacBtr.First;
begin
  oBtrTable.First;
end;

procedure TBrgbacBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TBrgbacBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TBrgbacBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TBrgbacBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TBrgbacBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TBrgbacBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TBrgbacBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TBrgbacBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TBrgbacBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TBrgbacBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TBrgbacBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1920001}
