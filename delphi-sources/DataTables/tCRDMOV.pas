unit tCRDMOV;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixItmNum = '';
  ixDocNum = 'DocNum';
  ixExtNum = 'ExtNum';
  ixDocDat = 'DocDat';
  ixDocVal = 'DocVal';
  ixBonQnt = 'BonQnt';

type
  TCrdmovTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadItmNum:longint;        procedure WriteItmNum (pValue:longint);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadExtNum:Str12;          procedure WriteExtNum (pValue:Str12);
    function  ReadDocDat:TDatetime;      procedure WriteDocDat (pValue:TDatetime);
    function  ReadDocTim:TDatetime;      procedure WriteDocTim (pValue:TDatetime);
    function  ReadBegVal:double;         procedure WriteBegVal (pValue:double);
    function  ReadDocVal:double;         procedure WriteDocVal (pValue:double);
    function  ReadBonTrn:double;         procedure WriteBonTrn (pValue:double);
    function  ReadBonQnt:longint;        procedure WriteBonQnt (pValue:longint);
    function  ReadBonVal:double;         procedure WriteBonVal (pValue:double);
    function  ReadNouVal:double;         procedure WriteNouVal (pValue:double);
    function  ReadNebVal:double;         procedure WriteNebVal (pValue:double);
    function  ReadDocTyp:Str1;           procedure WriteDocTyp (pValue:Str1);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateItmNum (pItmNum:longint):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateExtNum (pExtNum:Str12):boolean;
    function LocateDocDat (pDocDat:TDatetime):boolean;
    function LocateDocVal (pDocVal:double):boolean;
    function LocateBonQnt (pBonQnt:longint):boolean;

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
    procedure DisableControls;
    procedure EnableControls;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read ReadCount;
    property ItmNum:longint read ReadItmNum write WriteItmNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ExtNum:Str12 read ReadExtNum write WriteExtNum;
    property DocDat:TDatetime read ReadDocDat write WriteDocDat;
    property DocTim:TDatetime read ReadDocTim write WriteDocTim;
    property BegVal:double read ReadBegVal write WriteBegVal;
    property DocVal:double read ReadDocVal write WriteDocVal;
    property BonTrn:double read ReadBonTrn write WriteBonTrn;
    property BonQnt:longint read ReadBonQnt write WriteBonQnt;
    property BonVal:double read ReadBonVal write WriteBonVal;
    property NouVal:double read ReadNouVal write WriteNouVal;
    property NebVal:double read ReadNebVal write WriteNebVal;
    property DocTyp:Str1 read ReadDocTyp write WriteDocTyp;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
  end;

implementation

constructor TCrdmovTmp.Create;
begin
  oTmpTable := TmpInit ('CRDMOV',Self);
end;

destructor TCrdmovTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TCrdmovTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TCrdmovTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TCrdmovTmp.ReadItmNum:longint;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TCrdmovTmp.WriteItmNum(pValue:longint);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TCrdmovTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TCrdmovTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TCrdmovTmp.ReadExtNum:Str12;
begin
  Result := oTmpTable.FieldByName('ExtNum').AsString;
end;

procedure TCrdmovTmp.WriteExtNum(pValue:Str12);
begin
  oTmpTable.FieldByName('ExtNum').AsString := pValue;
end;

function TCrdmovTmp.ReadDocDat:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDat').AsDateTime;
end;

procedure TCrdmovTmp.WriteDocDat(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDat').AsDateTime := pValue;
end;

function TCrdmovTmp.ReadDocTim:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocTim').AsDateTime;
end;

procedure TCrdmovTmp.WriteDocTim(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocTim').AsDateTime := pValue;
end;

function TCrdmovTmp.ReadBegVal:double;
begin
  Result := oTmpTable.FieldByName('BegVal').AsFloat;
end;

procedure TCrdmovTmp.WriteBegVal(pValue:double);
begin
  oTmpTable.FieldByName('BegVal').AsFloat := pValue;
end;

function TCrdmovTmp.ReadDocVal:double;
begin
  Result := oTmpTable.FieldByName('DocVal').AsFloat;
end;

procedure TCrdmovTmp.WriteDocVal(pValue:double);
begin
  oTmpTable.FieldByName('DocVal').AsFloat := pValue;
end;

function TCrdmovTmp.ReadBonTrn:double;
begin
  Result := oTmpTable.FieldByName('BonTrn').AsFloat;
end;

procedure TCrdmovTmp.WriteBonTrn(pValue:double);
begin
  oTmpTable.FieldByName('BonTrn').AsFloat := pValue;
end;

function TCrdmovTmp.ReadBonQnt:longint;
begin
  Result := oTmpTable.FieldByName('BonQnt').AsInteger;
end;

procedure TCrdmovTmp.WriteBonQnt(pValue:longint);
begin
  oTmpTable.FieldByName('BonQnt').AsInteger := pValue;
end;

function TCrdmovTmp.ReadBonVal:double;
begin
  Result := oTmpTable.FieldByName('BonVal').AsFloat;
end;

procedure TCrdmovTmp.WriteBonVal(pValue:double);
begin
  oTmpTable.FieldByName('BonVal').AsFloat := pValue;
end;

function TCrdmovTmp.ReadNouVal:double;
begin
  Result := oTmpTable.FieldByName('NouVal').AsFloat;
end;

procedure TCrdmovTmp.WriteNouVal(pValue:double);
begin
  oTmpTable.FieldByName('NouVal').AsFloat := pValue;
end;

function TCrdmovTmp.ReadNebVal:double;
begin
  Result := oTmpTable.FieldByName('NebVal').AsFloat;
end;

procedure TCrdmovTmp.WriteNebVal(pValue:double);
begin
  oTmpTable.FieldByName('NebVal').AsFloat := pValue;
end;

function TCrdmovTmp.ReadDocTyp:Str1;
begin
  Result := oTmpTable.FieldByName('DocTyp').AsString;
end;

procedure TCrdmovTmp.WriteDocTyp(pValue:Str1);
begin
  oTmpTable.FieldByName('DocTyp').AsString := pValue;
end;

function TCrdmovTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TCrdmovTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TCrdmovTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TCrdmovTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TCrdmovTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TCrdmovTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCrdmovTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TCrdmovTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TCrdmovTmp.LocateItmNum (pItmNum:longint):boolean;
begin
  SetIndex (ixItmNum);
  Result := oTmpTable.FindKey([pItmNum]);
end;

function TCrdmovTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TCrdmovTmp.LocateExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oTmpTable.FindKey([pExtNum]);
end;

function TCrdmovTmp.LocateDocDat (pDocDat:TDatetime):boolean;
begin
  SetIndex (ixDocDat);
  Result := oTmpTable.FindKey([pDocDat]);
end;

function TCrdmovTmp.LocateDocVal (pDocVal:double):boolean;
begin
  SetIndex (ixDocVal);
  Result := oTmpTable.FindKey([pDocVal]);
end;

function TCrdmovTmp.LocateBonQnt (pBonQnt:longint):boolean;
begin
  SetIndex (ixBonQnt);
  Result := oTmpTable.FindKey([pBonQnt]);
end;

procedure TCrdmovTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TCrdmovTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TCrdmovTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TCrdmovTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TCrdmovTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TCrdmovTmp.First;
begin
  oTmpTable.First;
end;

procedure TCrdmovTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TCrdmovTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TCrdmovTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TCrdmovTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TCrdmovTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TCrdmovTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TCrdmovTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TCrdmovTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TCrdmovTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TCrdmovTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TCrdmovTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1920001}
