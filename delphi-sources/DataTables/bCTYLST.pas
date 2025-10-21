unit bCTYLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixCtyCode = 'CtyCode';
  ixCcSc = 'CcSc';
  ixCtyName = 'CtyName';
  ixZipCode = 'ZipCode';
  ixCtyTel = 'CtyTel';

type
  TCtylstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadCtyCode:Str3;          procedure WriteCtyCode (pValue:Str3);
    function  ReadStaCode:Str2;          procedure WriteStaCode (pValue:Str2);
    function  ReadCtyName:Str30;         procedure WriteCtyName (pValue:Str30);
    function  ReadCtyName_:Str30;        procedure WriteCtyName_ (pValue:Str30);
    function  ReadZipCode:Str15;         procedure WriteZipCode (pValue:Str15);
    function  ReadCtyTel:Str6;           procedure WriteCtyTel (pValue:Str6);
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
    function LocateCtyCode (pCtyCode:Str3):boolean;
    function LocateCcSc (pCtyCode:Str3;pStaCode:Str2):boolean;
    function LocateCtyName (pCtyName_:Str30):boolean;
    function LocateZipCode (pZipCode:Str15):boolean;
    function LocateCtyTel (pCtyTel:Str6):boolean;
    function NearestCtyCode (pCtyCode:Str3):boolean;
    function NearestCcSc (pCtyCode:Str3;pStaCode:Str2):boolean;
    function NearestCtyName (pCtyName_:Str30):boolean;
    function NearestZipCode (pZipCode:Str15):boolean;
    function NearestCtyTel (pCtyTel:Str6):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open;
    procedure Close;
    procedure Prior;
    procedure Next;
    procedure First;
    procedure Last;
    procedure Insert;
    procedure Edit;
    procedure Post; virtual;
    procedure Delete;
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
    property CtyCode:Str3 read ReadCtyCode write WriteCtyCode;
    property StaCode:Str2 read ReadStaCode write WriteStaCode;
    property CtyName:Str30 read ReadCtyName write WriteCtyName;
    property CtyName_:Str30 read ReadCtyName_ write WriteCtyName_;
    property ZipCode:Str15 read ReadZipCode write WriteZipCode;
    property CtyTel:Str6 read ReadCtyTel write WriteCtyTel;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TCtylstBtr.Create;
begin
  oBtrTable := BtrInit ('CTYLST',gPath.DlsPath,Self);
end;

constructor TCtylstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('CTYLST',pPath,Self);
end;

destructor TCtylstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TCtylstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TCtylstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TCtylstBtr.ReadCtyCode:Str3;
begin
  Result := oBtrTable.FieldByName('CtyCode').AsString;
end;

procedure TCtylstBtr.WriteCtyCode(pValue:Str3);
begin
  oBtrTable.FieldByName('CtyCode').AsString := pValue;
end;

function TCtylstBtr.ReadStaCode:Str2;
begin
  Result := oBtrTable.FieldByName('StaCode').AsString;
end;

procedure TCtylstBtr.WriteStaCode(pValue:Str2);
begin
  oBtrTable.FieldByName('StaCode').AsString := pValue;
end;

function TCtylstBtr.ReadCtyName:Str30;
begin
  Result := oBtrTable.FieldByName('CtyName').AsString;
end;

procedure TCtylstBtr.WriteCtyName(pValue:Str30);
begin
  oBtrTable.FieldByName('CtyName').AsString := pValue;
end;

function TCtylstBtr.ReadCtyName_:Str30;
begin
  Result := oBtrTable.FieldByName('CtyName_').AsString;
end;

procedure TCtylstBtr.WriteCtyName_(pValue:Str30);
begin
  oBtrTable.FieldByName('CtyName_').AsString := pValue;
end;

function TCtylstBtr.ReadZipCode:Str15;
begin
  Result := oBtrTable.FieldByName('ZipCode').AsString;
end;

procedure TCtylstBtr.WriteZipCode(pValue:Str15);
begin
  oBtrTable.FieldByName('ZipCode').AsString := pValue;
end;

function TCtylstBtr.ReadCtyTel:Str6;
begin
  Result := oBtrTable.FieldByName('CtyTel').AsString;
end;

procedure TCtylstBtr.WriteCtyTel(pValue:Str6);
begin
  oBtrTable.FieldByName('CtyTel').AsString := pValue;
end;

function TCtylstBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TCtylstBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TCtylstBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TCtylstBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TCtylstBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TCtylstBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TCtylstBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TCtylstBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TCtylstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TCtylstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TCtylstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TCtylstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TCtylstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TCtylstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCtylstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCtylstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TCtylstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCtylstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TCtylstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TCtylstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TCtylstBtr.LocateCtyCode (pCtyCode:Str3):boolean;
begin
  SetIndex (ixCtyCode);
  Result := oBtrTable.FindKey([pCtyCode]);
end;

function TCtylstBtr.LocateCcSc (pCtyCode:Str3;pStaCode:Str2):boolean;
begin
  SetIndex (ixCcSc);
  Result := oBtrTable.FindKey([pCtyCode,pStaCode]);
end;

function TCtylstBtr.LocateCtyName (pCtyName_:Str30):boolean;
begin
  SetIndex (ixCtyName);
  Result := oBtrTable.FindKey([StrToAlias(pCtyName_)]);
end;

function TCtylstBtr.LocateZipCode (pZipCode:Str15):boolean;
begin
  SetIndex (ixZipCode);
  Result := oBtrTable.FindKey([pZipCode]);
end;

function TCtylstBtr.LocateCtyTel (pCtyTel:Str6):boolean;
begin
  SetIndex (ixCtyTel);
  Result := oBtrTable.FindKey([pCtyTel]);
end;

function TCtylstBtr.NearestCtyCode (pCtyCode:Str3):boolean;
begin
  SetIndex (ixCtyCode);
  Result := oBtrTable.FindNearest([pCtyCode]);
end;

function TCtylstBtr.NearestCcSc (pCtyCode:Str3;pStaCode:Str2):boolean;
begin
  SetIndex (ixCcSc);
  Result := oBtrTable.FindNearest([pCtyCode,pStaCode]);
end;

function TCtylstBtr.NearestCtyName (pCtyName_:Str30):boolean;
begin
  SetIndex (ixCtyName);
  Result := oBtrTable.FindNearest([pCtyName_]);
end;

function TCtylstBtr.NearestZipCode (pZipCode:Str15):boolean;
begin
  SetIndex (ixZipCode);
  Result := oBtrTable.FindNearest([pZipCode]);
end;

function TCtylstBtr.NearestCtyTel (pCtyTel:Str6):boolean;
begin
  SetIndex (ixCtyTel);
  Result := oBtrTable.FindNearest([pCtyTel]);
end;

procedure TCtylstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TCtylstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TCtylstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TCtylstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TCtylstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TCtylstBtr.First;
begin
  oBtrTable.First;
end;

procedure TCtylstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TCtylstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TCtylstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TCtylstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TCtylstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TCtylstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TCtylstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TCtylstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TCtylstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TCtylstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TCtylstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
