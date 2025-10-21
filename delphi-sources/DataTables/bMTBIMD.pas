unit bMTBIMD;

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
  ixInQnt = 'InQnt';
  ixCPrice = 'CPrice';
  ixStkStat = 'StkStat';
  ixGrpNum = 'GrpNum';

type
  TMtbimdBtr = class (TComponent)
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
    function  ReadInQnt:double;          procedure WriteInQnt (pValue:double);
    function  ReadOuQnt:double;          procedure WriteOuQnt (pValue:double);
    function  ReadCPrice:double;         procedure WriteCPrice (pValue:double);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadCinSnt:Str3;           procedure WriteCinSnt (pValue:Str3);
    function  ReadCinAnl:Str6;           procedure WriteCinAnl (pValue:Str6);
    function  ReadDinSnt:Str3;           procedure WriteDinSnt (pValue:Str3);
    function  ReadDinAnl:Str6;           procedure WriteDinAnl (pValue:Str6);
    function  ReadNotice:Str30;          procedure WriteNotice (pValue:Str30);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadStkStat:Str1;          procedure WriteStkStat (pValue:Str1);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadGrpNum:word;           procedure WriteGrpNum (pValue:word);
    function  ReadBegStat:byte;          procedure WriteBegStat (pValue:byte);
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
    function LocateInQnt (pInQnt:double):boolean;
    function LocateCPrice (pCPrice:double):boolean;
    function LocateStkStat (pStkStat:Str1):boolean;
    function LocateGrpNum (pGrpNum:word):boolean;
    function NearestSerNum (pSerNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestMtCode (pMtCode:longint):boolean;
    function NearestGsName (pMtName_:Str30):boolean;
    function NearestBarCode (pBarCode:Str15):boolean;
    function NearestInQnt (pInQnt:double):boolean;
    function NearestCPrice (pCPrice:double):boolean;
    function NearestStkStat (pStkStat:Str1):boolean;
    function NearestGrpNum (pGrpNum:word):boolean;

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
    property InQnt:double read ReadInQnt write WriteInQnt;
    property OuQnt:double read ReadOuQnt write WriteOuQnt;
    property CPrice:double read ReadCPrice write WriteCPrice;
    property CValue:double read ReadCValue write WriteCValue;
    property CinSnt:Str3 read ReadCinSnt write WriteCinSnt;
    property CinAnl:Str6 read ReadCinAnl write WriteCinAnl;
    property DinSnt:Str3 read ReadDinSnt write WriteDinSnt;
    property DinAnl:Str6 read ReadDinAnl write WriteDinAnl;
    property Notice:Str30 read ReadNotice write WriteNotice;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property StkStat:Str1 read ReadStkStat write WriteStkStat;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property GrpNum:word read ReadGrpNum write WriteGrpNum;
    property BegStat:byte read ReadBegStat write WriteBegStat;
  end;

implementation

constructor TMtbimdBtr.Create;
begin
  oBtrTable := BtrInit ('MTBIMD',gPath.LdgPath,Self);
end;

constructor TMtbimdBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('MTBIMD',pPath,Self);
end;

destructor TMtbimdBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TMtbimdBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TMtbimdBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TMtbimdBtr.ReadSerNum:word;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TMtbimdBtr.WriteSerNum(pValue:word);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TMtbimdBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TMtbimdBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TMtbimdBtr.ReadMtCode:longint;
begin
  Result := oBtrTable.FieldByName('MtCode').AsInteger;
end;

procedure TMtbimdBtr.WriteMtCode(pValue:longint);
begin
  oBtrTable.FieldByName('MtCode').AsInteger := pValue;
end;

function TMtbimdBtr.ReadMtName:Str30;
begin
  Result := oBtrTable.FieldByName('MtName').AsString;
end;

procedure TMtbimdBtr.WriteMtName(pValue:Str30);
begin
  oBtrTable.FieldByName('MtName').AsString := pValue;
end;

function TMtbimdBtr.ReadMtName_:Str30;
begin
  Result := oBtrTable.FieldByName('MtName_').AsString;
end;

procedure TMtbimdBtr.WriteMtName_(pValue:Str30);
begin
  oBtrTable.FieldByName('MtName_').AsString := pValue;
end;

function TMtbimdBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TMtbimdBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TMtbimdBtr.ReadMsName:Str10;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TMtbimdBtr.WriteMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TMtbimdBtr.ReadInQnt:double;
begin
  Result := oBtrTable.FieldByName('InQnt').AsFloat;
end;

procedure TMtbimdBtr.WriteInQnt(pValue:double);
begin
  oBtrTable.FieldByName('InQnt').AsFloat := pValue;
end;

function TMtbimdBtr.ReadOuQnt:double;
begin
  Result := oBtrTable.FieldByName('OuQnt').AsFloat;
end;

procedure TMtbimdBtr.WriteOuQnt(pValue:double);
begin
  oBtrTable.FieldByName('OuQnt').AsFloat := pValue;
end;

function TMtbimdBtr.ReadCPrice:double;
begin
  Result := oBtrTable.FieldByName('CPrice').AsFloat;
end;

procedure TMtbimdBtr.WriteCPrice(pValue:double);
begin
  oBtrTable.FieldByName('CPrice').AsFloat := pValue;
end;

function TMtbimdBtr.ReadCValue:double;
begin
  Result := oBtrTable.FieldByName('CValue').AsFloat;
end;

procedure TMtbimdBtr.WriteCValue(pValue:double);
begin
  oBtrTable.FieldByName('CValue').AsFloat := pValue;
end;

function TMtbimdBtr.ReadCinSnt:Str3;
begin
  Result := oBtrTable.FieldByName('CinSnt').AsString;
end;

procedure TMtbimdBtr.WriteCinSnt(pValue:Str3);
begin
  oBtrTable.FieldByName('CinSnt').AsString := pValue;
end;

function TMtbimdBtr.ReadCinAnl:Str6;
begin
  Result := oBtrTable.FieldByName('CinAnl').AsString;
end;

procedure TMtbimdBtr.WriteCinAnl(pValue:Str6);
begin
  oBtrTable.FieldByName('CinAnl').AsString := pValue;
end;

function TMtbimdBtr.ReadDinSnt:Str3;
begin
  Result := oBtrTable.FieldByName('DinSnt').AsString;
end;

procedure TMtbimdBtr.WriteDinSnt(pValue:Str3);
begin
  oBtrTable.FieldByName('DinSnt').AsString := pValue;
end;

function TMtbimdBtr.ReadDinAnl:Str6;
begin
  Result := oBtrTable.FieldByName('DinAnl').AsString;
end;

procedure TMtbimdBtr.WriteDinAnl(pValue:Str6);
begin
  oBtrTable.FieldByName('DinAnl').AsString := pValue;
end;

function TMtbimdBtr.ReadNotice:Str30;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TMtbimdBtr.WriteNotice(pValue:Str30);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

function TMtbimdBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TMtbimdBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TMtbimdBtr.ReadStkStat:Str1;
begin
  Result := oBtrTable.FieldByName('StkStat').AsString;
end;

procedure TMtbimdBtr.WriteStkStat(pValue:Str1);
begin
  oBtrTable.FieldByName('StkStat').AsString := pValue;
end;

function TMtbimdBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TMtbimdBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TMtbimdBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TMtbimdBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TMtbimdBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TMtbimdBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TMtbimdBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TMtbimdBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TMtbimdBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TMtbimdBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TMtbimdBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TMtbimdBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TMtbimdBtr.ReadGrpNum:word;
begin
  Result := oBtrTable.FieldByName('GrpNum').AsInteger;
end;

procedure TMtbimdBtr.WriteGrpNum(pValue:word);
begin
  oBtrTable.FieldByName('GrpNum').AsInteger := pValue;
end;

function TMtbimdBtr.ReadBegStat:byte;
begin
  Result := oBtrTable.FieldByName('BegStat').AsInteger;
end;

procedure TMtbimdBtr.WriteBegStat(pValue:byte);
begin
  oBtrTable.FieldByName('BegStat').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TMtbimdBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TMtbimdBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TMtbimdBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TMtbimdBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TMtbimdBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TMtbimdBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TMtbimdBtr.LocateSerNum (pSerNum:word):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindKey([pSerNum]);
end;

function TMtbimdBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TMtbimdBtr.LocateMtCode (pMtCode:longint):boolean;
begin
  SetIndex (ixMtCode);
  Result := oBtrTable.FindKey([pMtCode]);
end;

function TMtbimdBtr.LocateGsName (pMtName_:Str30):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindKey([StrToAlias(pMtName_)]);
end;

function TMtbimdBtr.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindKey([pBarCode]);
end;

function TMtbimdBtr.LocateInQnt (pInQnt:double):boolean;
begin
  SetIndex (ixInQnt);
  Result := oBtrTable.FindKey([pInQnt]);
end;

function TMtbimdBtr.LocateCPrice (pCPrice:double):boolean;
begin
  SetIndex (ixCPrice);
  Result := oBtrTable.FindKey([pCPrice]);
end;

function TMtbimdBtr.LocateStkStat (pStkStat:Str1):boolean;
begin
  SetIndex (ixStkStat);
  Result := oBtrTable.FindKey([pStkStat]);
end;

function TMtbimdBtr.LocateGrpNum (pGrpNum:word):boolean;
begin
  SetIndex (ixGrpNum);
  Result := oBtrTable.FindKey([pGrpNum]);
end;

function TMtbimdBtr.NearestSerNum (pSerNum:word):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindNearest([pSerNum]);
end;

function TMtbimdBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TMtbimdBtr.NearestMtCode (pMtCode:longint):boolean;
begin
  SetIndex (ixMtCode);
  Result := oBtrTable.FindNearest([pMtCode]);
end;

function TMtbimdBtr.NearestGsName (pMtName_:Str30):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindNearest([pMtName_]);
end;

function TMtbimdBtr.NearestBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindNearest([pBarCode]);
end;

function TMtbimdBtr.NearestInQnt (pInQnt:double):boolean;
begin
  SetIndex (ixInQnt);
  Result := oBtrTable.FindNearest([pInQnt]);
end;

function TMtbimdBtr.NearestCPrice (pCPrice:double):boolean;
begin
  SetIndex (ixCPrice);
  Result := oBtrTable.FindNearest([pCPrice]);
end;

function TMtbimdBtr.NearestStkStat (pStkStat:Str1):boolean;
begin
  SetIndex (ixStkStat);
  Result := oBtrTable.FindNearest([pStkStat]);
end;

function TMtbimdBtr.NearestGrpNum (pGrpNum:word):boolean;
begin
  SetIndex (ixGrpNum);
  Result := oBtrTable.FindNearest([pGrpNum]);
end;

procedure TMtbimdBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TMtbimdBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TMtbimdBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TMtbimdBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TMtbimdBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TMtbimdBtr.First;
begin
  oBtrTable.First;
end;

procedure TMtbimdBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TMtbimdBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TMtbimdBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TMtbimdBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TMtbimdBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TMtbimdBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TMtbimdBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TMtbimdBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TMtbimdBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TMtbimdBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TMtbimdBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
