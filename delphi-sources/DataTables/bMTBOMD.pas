unit bMTBOMD;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSerNum = 'SerNum';
  ixDocNum = 'DocNum';
  ixMtCode = 'MtCode';
  ixGsName = 'GsName';
  ixBarCode = 'BarCode';
  ixOuQnt = 'OuQnt';
  ixCPrice = 'CPrice';
  ixGrpNum = 'GrpNum';
  ixImdNum = 'ImdNum';

type
  TMtbomdBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSerNum:word;           procedure WriteSerNum (pValue:word);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadMtCode:longint;        procedure WriteMtCode (pValue:longint);
    function  ReadMtName:Str30;          procedure WriteMtName (pValue:Str30);
    function  ReadMtName_:Str30;         procedure WriteMtName_ (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadOuQnt:double;          procedure WriteOuQnt (pValue:double);
    function  ReadCPrice:double;         procedure WriteCPrice (pValue:double);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadCouSnt:Str3;           procedure WriteCouSnt (pValue:Str3);
    function  ReadCouAnl:Str6;           procedure WriteCouAnl (pValue:Str6);
    function  ReadDouSnt:Str3;           procedure WriteDouSnt (pValue:Str3);
    function  ReadDouAnl:Str6;           procedure WriteDouAnl (pValue:Str6);
    function  ReadNotice:Str30;          procedure WriteNotice (pValue:Str30);
    function  ReadImdNum:Str12;          procedure WriteImdNum (pValue:Str12);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadStkStat:Str1;          procedure WriteStkStat (pValue:Str1);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadGrpNum:word;           procedure WriteGrpNum (pValue:word);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateSerNum (pSerNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateMtCode (pMtCode:longint):boolean;
    function LocateGsName (pMtName_:Str30):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateOuQnt (pOuQnt:double):boolean;
    function LocateCPrice (pCPrice:double):boolean;
    function LocateGrpNum (pGrpNum:word):boolean;
    function LocateImdNum (pImdNum:Str12):boolean;
    function NearestSerNum (pSerNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestMtCode (pMtCode:longint):boolean;
    function NearestGsName (pMtName_:Str30):boolean;
    function NearestBarCode (pBarCode:Str15):boolean;
    function NearestOuQnt (pOuQnt:double):boolean;
    function NearestCPrice (pCPrice:double):boolean;
    function NearestGrpNum (pGrpNum:word):boolean;
    function NearestImdNum (pImdNum:Str12):boolean;

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
    property SerNum:word read ReadSerNum write WriteSerNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property MtCode:longint read ReadMtCode write WriteMtCode;
    property MtName:Str30 read ReadMtName write WriteMtName;
    property MtName_:Str30 read ReadMtName_ write WriteMtName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property OuQnt:double read ReadOuQnt write WriteOuQnt;
    property CPrice:double read ReadCPrice write WriteCPrice;
    property CValue:double read ReadCValue write WriteCValue;
    property CouSnt:Str3 read ReadCouSnt write WriteCouSnt;
    property CouAnl:Str6 read ReadCouAnl write WriteCouAnl;
    property DouSnt:Str3 read ReadDouSnt write WriteDouSnt;
    property DouAnl:Str6 read ReadDouAnl write WriteDouAnl;
    property Notice:Str30 read ReadNotice write WriteNotice;
    property ImdNum:Str12 read ReadImdNum write WriteImdNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property StkStat:Str1 read ReadStkStat write WriteStkStat;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property GrpNum:word read ReadGrpNum write WriteGrpNum;
  end;

implementation

constructor TMtbomdBtr.Create;
begin
  oBtrTable := BtrInit ('MTBOMD',gPath.LdgPath,Self);
end;

constructor TMtbomdBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('MTBOMD',pPath,Self);
end;

destructor TMtbomdBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TMtbomdBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TMtbomdBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TMtbomdBtr.ReadSerNum:word;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TMtbomdBtr.WriteSerNum(pValue:word);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TMtbomdBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TMtbomdBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TMtbomdBtr.ReadMtCode:longint;
begin
  Result := oBtrTable.FieldByName('MtCode').AsInteger;
end;

procedure TMtbomdBtr.WriteMtCode(pValue:longint);
begin
  oBtrTable.FieldByName('MtCode').AsInteger := pValue;
end;

function TMtbomdBtr.ReadMtName:Str30;
begin
  Result := oBtrTable.FieldByName('MtName').AsString;
end;

procedure TMtbomdBtr.WriteMtName(pValue:Str30);
begin
  oBtrTable.FieldByName('MtName').AsString := pValue;
end;

function TMtbomdBtr.ReadMtName_:Str30;
begin
  Result := oBtrTable.FieldByName('MtName_').AsString;
end;

procedure TMtbomdBtr.WriteMtName_(pValue:Str30);
begin
  oBtrTable.FieldByName('MtName_').AsString := pValue;
end;

function TMtbomdBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TMtbomdBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TMtbomdBtr.ReadMsName:Str10;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TMtbomdBtr.WriteMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TMtbomdBtr.ReadOuQnt:double;
begin
  Result := oBtrTable.FieldByName('OuQnt').AsFloat;
end;

procedure TMtbomdBtr.WriteOuQnt(pValue:double);
begin
  oBtrTable.FieldByName('OuQnt').AsFloat := pValue;
end;

function TMtbomdBtr.ReadCPrice:double;
begin
  Result := oBtrTable.FieldByName('CPrice').AsFloat;
end;

procedure TMtbomdBtr.WriteCPrice(pValue:double);
begin
  oBtrTable.FieldByName('CPrice').AsFloat := pValue;
end;

function TMtbomdBtr.ReadCValue:double;
begin
  Result := oBtrTable.FieldByName('CValue').AsFloat;
end;

procedure TMtbomdBtr.WriteCValue(pValue:double);
begin
  oBtrTable.FieldByName('CValue').AsFloat := pValue;
end;

function TMtbomdBtr.ReadCouSnt:Str3;
begin
  Result := oBtrTable.FieldByName('CouSnt').AsString;
end;

procedure TMtbomdBtr.WriteCouSnt(pValue:Str3);
begin
  oBtrTable.FieldByName('CouSnt').AsString := pValue;
end;

function TMtbomdBtr.ReadCouAnl:Str6;
begin
  Result := oBtrTable.FieldByName('CouAnl').AsString;
end;

procedure TMtbomdBtr.WriteCouAnl(pValue:Str6);
begin
  oBtrTable.FieldByName('CouAnl').AsString := pValue;
end;

function TMtbomdBtr.ReadDouSnt:Str3;
begin
  Result := oBtrTable.FieldByName('DouSnt').AsString;
end;

procedure TMtbomdBtr.WriteDouSnt(pValue:Str3);
begin
  oBtrTable.FieldByName('DouSnt').AsString := pValue;
end;

function TMtbomdBtr.ReadDouAnl:Str6;
begin
  Result := oBtrTable.FieldByName('DouAnl').AsString;
end;

procedure TMtbomdBtr.WriteDouAnl(pValue:Str6);
begin
  oBtrTable.FieldByName('DouAnl').AsString := pValue;
end;

function TMtbomdBtr.ReadNotice:Str30;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TMtbomdBtr.WriteNotice(pValue:Str30);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

function TMtbomdBtr.ReadImdNum:Str12;
begin
  Result := oBtrTable.FieldByName('ImdNum').AsString;
end;

procedure TMtbomdBtr.WriteImdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('ImdNum').AsString := pValue;
end;

function TMtbomdBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TMtbomdBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TMtbomdBtr.ReadStkStat:Str1;
begin
  Result := oBtrTable.FieldByName('StkStat').AsString;
end;

procedure TMtbomdBtr.WriteStkStat(pValue:Str1);
begin
  oBtrTable.FieldByName('StkStat').AsString := pValue;
end;

function TMtbomdBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TMtbomdBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TMtbomdBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TMtbomdBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TMtbomdBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TMtbomdBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TMtbomdBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TMtbomdBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TMtbomdBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TMtbomdBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TMtbomdBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TMtbomdBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TMtbomdBtr.ReadGrpNum:word;
begin
  Result := oBtrTable.FieldByName('GrpNum').AsInteger;
end;

procedure TMtbomdBtr.WriteGrpNum(pValue:word);
begin
  oBtrTable.FieldByName('GrpNum').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TMtbomdBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TMtbomdBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TMtbomdBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TMtbomdBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TMtbomdBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TMtbomdBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TMtbomdBtr.LocateSerNum (pSerNum:word):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindKey([pSerNum]);
end;

function TMtbomdBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TMtbomdBtr.LocateMtCode (pMtCode:longint):boolean;
begin
  SetIndex (ixMtCode);
  Result := oBtrTable.FindKey([pMtCode]);
end;

function TMtbomdBtr.LocateGsName (pMtName_:Str30):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindKey([StrToAlias(pMtName_)]);
end;

function TMtbomdBtr.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindKey([pBarCode]);
end;

function TMtbomdBtr.LocateOuQnt (pOuQnt:double):boolean;
begin
  SetIndex (ixOuQnt);
  Result := oBtrTable.FindKey([pOuQnt]);
end;

function TMtbomdBtr.LocateCPrice (pCPrice:double):boolean;
begin
  SetIndex (ixCPrice);
  Result := oBtrTable.FindKey([pCPrice]);
end;

function TMtbomdBtr.LocateGrpNum (pGrpNum:word):boolean;
begin
  SetIndex (ixGrpNum);
  Result := oBtrTable.FindKey([pGrpNum]);
end;

function TMtbomdBtr.LocateImdNum (pImdNum:Str12):boolean;
begin
  SetIndex (ixImdNum);
  Result := oBtrTable.FindKey([pImdNum]);
end;

function TMtbomdBtr.NearestSerNum (pSerNum:word):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindNearest([pSerNum]);
end;

function TMtbomdBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TMtbomdBtr.NearestMtCode (pMtCode:longint):boolean;
begin
  SetIndex (ixMtCode);
  Result := oBtrTable.FindNearest([pMtCode]);
end;

function TMtbomdBtr.NearestGsName (pMtName_:Str30):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindNearest([pMtName_]);
end;

function TMtbomdBtr.NearestBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindNearest([pBarCode]);
end;

function TMtbomdBtr.NearestOuQnt (pOuQnt:double):boolean;
begin
  SetIndex (ixOuQnt);
  Result := oBtrTable.FindNearest([pOuQnt]);
end;

function TMtbomdBtr.NearestCPrice (pCPrice:double):boolean;
begin
  SetIndex (ixCPrice);
  Result := oBtrTable.FindNearest([pCPrice]);
end;

function TMtbomdBtr.NearestGrpNum (pGrpNum:word):boolean;
begin
  SetIndex (ixGrpNum);
  Result := oBtrTable.FindNearest([pGrpNum]);
end;

function TMtbomdBtr.NearestImdNum (pImdNum:Str12):boolean;
begin
  SetIndex (ixImdNum);
  Result := oBtrTable.FindNearest([pImdNum]);
end;

procedure TMtbomdBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TMtbomdBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TMtbomdBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TMtbomdBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TMtbomdBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TMtbomdBtr.First;
begin
  oBtrTable.First;
end;

procedure TMtbomdBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TMtbomdBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TMtbomdBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TMtbomdBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TMtbomdBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TMtbomdBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TMtbomdBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TMtbomdBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TMtbomdBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TMtbomdBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TMtbomdBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
