unit bCRDMOV;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixCnIn = 'CnIn';
  ixCrdNum = 'CrdNum';
  ixCnDd = 'CnDd';
  ixDocNum = 'DocNum';
  ixExtNum = 'ExtNum';

type
  TCrdmovBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadCrdNum:Str20;          procedure WriteCrdNum (pValue:Str20);
    function  ReadItmNum:longint;        procedure WriteItmNum (pValue:longint);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadExtNum:Str12;          procedure WriteExtNum (pValue:Str12);
    function  ReadDocDat:TDatetime;      procedure WriteDocDat (pValue:TDatetime);
    function  ReadDocTim:TDatetime;      procedure WriteDocTim (pValue:TDatetime);
    function  ReadBegVal:double;         procedure WriteBegVal (pValue:double);
    function  ReadDocVal:double;         procedure WriteDocVal (pValue:double);
    function  ReadBonTrn:double;         procedure WriteBonTrn (pValue:double);
    function  ReadBonQnt:longint;        procedure WriteBonQnt (pValue:longint);
    function  ReadDocTyp:Str1;           procedure WriteDocTyp (pValue:Str1);
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
    function LocateCnIn (pCrdNum:Str20;pItmNum:longint):boolean;
    function LocateCrdNum (pCrdNum:Str20):boolean;
    function LocateCnDd (pCrdNum:Str20;pDocDat:TDatetime):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateExtNum (pExtNum:Str12):boolean;
    function NearestCnIn (pCrdNum:Str20;pItmNum:longint):boolean;
    function NearestCrdNum (pCrdNum:Str20):boolean;
    function NearestCnDd (pCrdNum:Str20;pDocDat:TDatetime):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestExtNum (pExtNum:Str12):boolean;

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
    property CrdNum:Str20 read ReadCrdNum write WriteCrdNum;
    property ItmNum:longint read ReadItmNum write WriteItmNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ExtNum:Str12 read ReadExtNum write WriteExtNum;
    property DocDat:TDatetime read ReadDocDat write WriteDocDat;
    property DocTim:TDatetime read ReadDocTim write WriteDocTim;
    property BegVal:double read ReadBegVal write WriteBegVal;
    property DocVal:double read ReadDocVal write WriteDocVal;
    property BonTrn:double read ReadBonTrn write WriteBonTrn;
    property BonQnt:longint read ReadBonQnt write WriteBonQnt;
    property DocTyp:Str1 read ReadDocTyp write WriteDocTyp;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
  end;

implementation

constructor TCrdmovBtr.Create;
begin
  oBtrTable := BtrInit ('CRDMOV',gPath.DlsPath,Self);
end;

constructor TCrdmovBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('CRDMOV',pPath,Self);
end;

destructor TCrdmovBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TCrdmovBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TCrdmovBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TCrdmovBtr.ReadCrdNum:Str20;
begin
  Result := oBtrTable.FieldByName('CrdNum').AsString;
end;

procedure TCrdmovBtr.WriteCrdNum(pValue:Str20);
begin
  oBtrTable.FieldByName('CrdNum').AsString := pValue;
end;

function TCrdmovBtr.ReadItmNum:longint;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TCrdmovBtr.WriteItmNum(pValue:longint);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TCrdmovBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TCrdmovBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TCrdmovBtr.ReadExtNum:Str12;
begin
  Result := oBtrTable.FieldByName('ExtNum').AsString;
end;

procedure TCrdmovBtr.WriteExtNum(pValue:Str12);
begin
  oBtrTable.FieldByName('ExtNum').AsString := pValue;
end;

function TCrdmovBtr.ReadDocDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDat').AsDateTime;
end;

procedure TCrdmovBtr.WriteDocDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDat').AsDateTime := pValue;
end;

function TCrdmovBtr.ReadDocTim:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocTim').AsDateTime;
end;

procedure TCrdmovBtr.WriteDocTim(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocTim').AsDateTime := pValue;
end;

function TCrdmovBtr.ReadBegVal:double;
begin
  Result := oBtrTable.FieldByName('BegVal').AsFloat;
end;

procedure TCrdmovBtr.WriteBegVal(pValue:double);
begin
  oBtrTable.FieldByName('BegVal').AsFloat := pValue;
end;

function TCrdmovBtr.ReadDocVal:double;
begin
  Result := oBtrTable.FieldByName('DocVal').AsFloat;
end;

procedure TCrdmovBtr.WriteDocVal(pValue:double);
begin
  oBtrTable.FieldByName('DocVal').AsFloat := pValue;
end;

function TCrdmovBtr.ReadBonTrn:double;
begin
  Result := oBtrTable.FieldByName('BonTrn').AsFloat;
end;

procedure TCrdmovBtr.WriteBonTrn(pValue:double);
begin
  oBtrTable.FieldByName('BonTrn').AsFloat := pValue;
end;

function TCrdmovBtr.ReadBonQnt:longint;
begin
  Result := oBtrTable.FieldByName('BonQnt').AsInteger;
end;

procedure TCrdmovBtr.WriteBonQnt(pValue:longint);
begin
  oBtrTable.FieldByName('BonQnt').AsInteger := pValue;
end;

function TCrdmovBtr.ReadDocTyp:Str1;
begin
  Result := oBtrTable.FieldByName('DocTyp').AsString;
end;

procedure TCrdmovBtr.WriteDocTyp(pValue:Str1);
begin
  oBtrTable.FieldByName('DocTyp').AsString := pValue;
end;

function TCrdmovBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TCrdmovBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TCrdmovBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TCrdmovBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TCrdmovBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TCrdmovBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCrdmovBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCrdmovBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TCrdmovBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCrdmovBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TCrdmovBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TCrdmovBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TCrdmovBtr.LocateCnIn (pCrdNum:Str20;pItmNum:longint):boolean;
begin
  SetIndex (ixCnIn);
  Result := oBtrTable.FindKey([pCrdNum,pItmNum]);
end;

function TCrdmovBtr.LocateCrdNum (pCrdNum:Str20):boolean;
begin
  SetIndex (ixCrdNum);
  Result := oBtrTable.FindKey([pCrdNum]);
end;

function TCrdmovBtr.LocateCnDd (pCrdNum:Str20;pDocDat:TDatetime):boolean;
begin
  SetIndex (ixCnDd);
  Result := oBtrTable.FindKey([pCrdNum,pDocDat]);
end;

function TCrdmovBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TCrdmovBtr.LocateExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindKey([pExtNum]);
end;

function TCrdmovBtr.NearestCnIn (pCrdNum:Str20;pItmNum:longint):boolean;
begin
  SetIndex (ixCnIn);
  Result := oBtrTable.FindNearest([pCrdNum,pItmNum]);
end;

function TCrdmovBtr.NearestCrdNum (pCrdNum:Str20):boolean;
begin
  SetIndex (ixCrdNum);
  Result := oBtrTable.FindNearest([pCrdNum]);
end;

function TCrdmovBtr.NearestCnDd (pCrdNum:Str20;pDocDat:TDatetime):boolean;
begin
  SetIndex (ixCnDd);
  Result := oBtrTable.FindNearest([pCrdNum,pDocDat]);
end;

function TCrdmovBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TCrdmovBtr.NearestExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindNearest([pExtNum]);
end;

procedure TCrdmovBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TCrdmovBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TCrdmovBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TCrdmovBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TCrdmovBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TCrdmovBtr.First;
begin
  oBtrTable.First;
end;

procedure TCrdmovBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TCrdmovBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TCrdmovBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TCrdmovBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TCrdmovBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TCrdmovBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TCrdmovBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TCrdmovBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TCrdmovBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TCrdmovBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TCrdmovBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1920001}
