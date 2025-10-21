unit bMTBSTC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixMtCode = 'MtCode';
  ixMtName = 'MtName';
  ixBarCode = 'BarCode';
  ixActQnt = 'ActQnt';
  ixActVal = 'ActVal';
  ixGrpNum = 'GrpNum';

type
  TMtbstcBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadMtCode:longint;        procedure WriteMtCode (pValue:longint);
    function  ReadMtName:Str30;          procedure WriteMtName (pValue:Str30);
    function  ReadMtName_:Str30;         procedure WriteMtName_ (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadInQnt:double;          procedure WriteInQnt (pValue:double);
    function  ReadOuQnt:double;          procedure WriteOuQnt (pValue:double);
    function  ReadActQnt:double;         procedure WriteActQnt (pValue:double);
    function  ReadInVal:double;          procedure WriteInVal (pValue:double);
    function  ReadOuVal:double;          procedure WriteOuVal (pValue:double);
    function  ReadActVal:double;         procedure WriteActVal (pValue:double);
    function  ReadLPrice:double;         procedure WriteLPrice (pValue:double);
    function  ReadCPrice:double;         procedure WriteCPrice (pValue:double);
    function  ReadCinSnt:Str3;           procedure WriteCinSnt (pValue:Str3);
    function  ReadCinAnl:Str6;           procedure WriteCinAnl (pValue:Str6);
    function  ReadDinSnt:Str3;           procedure WriteDinSnt (pValue:Str3);
    function  ReadDinAnl:Str6;           procedure WriteDinAnl (pValue:Str6);
    function  ReadCouSnt:Str3;           procedure WriteCouSnt (pValue:Str3);
    function  ReadCouAnl:Str6;           procedure WriteCouAnl (pValue:Str6);
    function  ReadDouSnt:Str3;           procedure WriteDouSnt (pValue:Str3);
    function  ReadDouAnl:Str6;           procedure WriteDouAnl (pValue:Str6);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadGrpNum:word;           procedure WriteGrpNum (pValue:word);
    function  ReadBegQnt:double;         procedure WriteBegQnt (pValue:double);
    function  ReadBegVal:double;         procedure WriteBegVal (pValue:double);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateMtCode (pMtCode:longint):boolean;
    function LocateMtName (pMtName_:Str30):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateActQnt (pActQnt:double):boolean;
    function LocateActVal (pActVal:double):boolean;
    function LocateGrpNum (pGrpNum:word):boolean;
    function NearestMtCode (pMtCode:longint):boolean;
    function NearestMtName (pMtName_:Str30):boolean;
    function NearestBarCode (pBarCode:Str15):boolean;
    function NearestActQnt (pActQnt:double):boolean;
    function NearestActVal (pActVal:double):boolean;
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
    property MtCode:longint read ReadMtCode write WriteMtCode;
    property MtName:Str30 read ReadMtName write WriteMtName;
    property MtName_:Str30 read ReadMtName_ write WriteMtName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property InQnt:double read ReadInQnt write WriteInQnt;
    property OuQnt:double read ReadOuQnt write WriteOuQnt;
    property ActQnt:double read ReadActQnt write WriteActQnt;
    property InVal:double read ReadInVal write WriteInVal;
    property OuVal:double read ReadOuVal write WriteOuVal;
    property ActVal:double read ReadActVal write WriteActVal;
    property LPrice:double read ReadLPrice write WriteLPrice;
    property CPrice:double read ReadCPrice write WriteCPrice;
    property CinSnt:Str3 read ReadCinSnt write WriteCinSnt;
    property CinAnl:Str6 read ReadCinAnl write WriteCinAnl;
    property DinSnt:Str3 read ReadDinSnt write WriteDinSnt;
    property DinAnl:Str6 read ReadDinAnl write WriteDinAnl;
    property CouSnt:Str3 read ReadCouSnt write WriteCouSnt;
    property CouAnl:Str6 read ReadCouAnl write WriteCouAnl;
    property DouSnt:Str3 read ReadDouSnt write WriteDouSnt;
    property DouAnl:Str6 read ReadDouAnl write WriteDouAnl;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property GrpNum:word read ReadGrpNum write WriteGrpNum;
    property BegQnt:double read ReadBegQnt write WriteBegQnt;
    property BegVal:double read ReadBegVal write WriteBegVal;
  end;

implementation

constructor TMtbstcBtr.Create;
begin
  oBtrTable := BtrInit ('MTBSTC',gPath.LdgPath,Self);
end;

constructor TMtbstcBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('MTBSTC',pPath,Self);
end;

destructor TMtbstcBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TMtbstcBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TMtbstcBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TMtbstcBtr.ReadMtCode:longint;
begin
  Result := oBtrTable.FieldByName('MtCode').AsInteger;
end;

procedure TMtbstcBtr.WriteMtCode(pValue:longint);
begin
  oBtrTable.FieldByName('MtCode').AsInteger := pValue;
end;

function TMtbstcBtr.ReadMtName:Str30;
begin
  Result := oBtrTable.FieldByName('MtName').AsString;
end;

procedure TMtbstcBtr.WriteMtName(pValue:Str30);
begin
  oBtrTable.FieldByName('MtName').AsString := pValue;
end;

function TMtbstcBtr.ReadMtName_:Str30;
begin
  Result := oBtrTable.FieldByName('MtName_').AsString;
end;

procedure TMtbstcBtr.WriteMtName_(pValue:Str30);
begin
  oBtrTable.FieldByName('MtName_').AsString := pValue;
end;

function TMtbstcBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TMtbstcBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TMtbstcBtr.ReadMsName:Str10;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TMtbstcBtr.WriteMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TMtbstcBtr.ReadInQnt:double;
begin
  Result := oBtrTable.FieldByName('InQnt').AsFloat;
end;

procedure TMtbstcBtr.WriteInQnt(pValue:double);
begin
  oBtrTable.FieldByName('InQnt').AsFloat := pValue;
end;

function TMtbstcBtr.ReadOuQnt:double;
begin
  Result := oBtrTable.FieldByName('OuQnt').AsFloat;
end;

procedure TMtbstcBtr.WriteOuQnt(pValue:double);
begin
  oBtrTable.FieldByName('OuQnt').AsFloat := pValue;
end;

function TMtbstcBtr.ReadActQnt:double;
begin
  Result := oBtrTable.FieldByName('ActQnt').AsFloat;
end;

procedure TMtbstcBtr.WriteActQnt(pValue:double);
begin
  oBtrTable.FieldByName('ActQnt').AsFloat := pValue;
end;

function TMtbstcBtr.ReadInVal:double;
begin
  Result := oBtrTable.FieldByName('InVal').AsFloat;
end;

procedure TMtbstcBtr.WriteInVal(pValue:double);
begin
  oBtrTable.FieldByName('InVal').AsFloat := pValue;
end;

function TMtbstcBtr.ReadOuVal:double;
begin
  Result := oBtrTable.FieldByName('OuVal').AsFloat;
end;

procedure TMtbstcBtr.WriteOuVal(pValue:double);
begin
  oBtrTable.FieldByName('OuVal').AsFloat := pValue;
end;

function TMtbstcBtr.ReadActVal:double;
begin
  Result := oBtrTable.FieldByName('ActVal').AsFloat;
end;

procedure TMtbstcBtr.WriteActVal(pValue:double);
begin
  oBtrTable.FieldByName('ActVal').AsFloat := pValue;
end;

function TMtbstcBtr.ReadLPrice:double;
begin
  Result := oBtrTable.FieldByName('LPrice').AsFloat;
end;

procedure TMtbstcBtr.WriteLPrice(pValue:double);
begin
  oBtrTable.FieldByName('LPrice').AsFloat := pValue;
end;

function TMtbstcBtr.ReadCPrice:double;
begin
  Result := oBtrTable.FieldByName('CPrice').AsFloat;
end;

procedure TMtbstcBtr.WriteCPrice(pValue:double);
begin
  oBtrTable.FieldByName('CPrice').AsFloat := pValue;
end;

function TMtbstcBtr.ReadCinSnt:Str3;
begin
  Result := oBtrTable.FieldByName('CinSnt').AsString;
end;

procedure TMtbstcBtr.WriteCinSnt(pValue:Str3);
begin
  oBtrTable.FieldByName('CinSnt').AsString := pValue;
end;

function TMtbstcBtr.ReadCinAnl:Str6;
begin
  Result := oBtrTable.FieldByName('CinAnl').AsString;
end;

procedure TMtbstcBtr.WriteCinAnl(pValue:Str6);
begin
  oBtrTable.FieldByName('CinAnl').AsString := pValue;
end;

function TMtbstcBtr.ReadDinSnt:Str3;
begin
  Result := oBtrTable.FieldByName('DinSnt').AsString;
end;

procedure TMtbstcBtr.WriteDinSnt(pValue:Str3);
begin
  oBtrTable.FieldByName('DinSnt').AsString := pValue;
end;

function TMtbstcBtr.ReadDinAnl:Str6;
begin
  Result := oBtrTable.FieldByName('DinAnl').AsString;
end;

procedure TMtbstcBtr.WriteDinAnl(pValue:Str6);
begin
  oBtrTable.FieldByName('DinAnl').AsString := pValue;
end;

function TMtbstcBtr.ReadCouSnt:Str3;
begin
  Result := oBtrTable.FieldByName('CouSnt').AsString;
end;

procedure TMtbstcBtr.WriteCouSnt(pValue:Str3);
begin
  oBtrTable.FieldByName('CouSnt').AsString := pValue;
end;

function TMtbstcBtr.ReadCouAnl:Str6;
begin
  Result := oBtrTable.FieldByName('CouAnl').AsString;
end;

procedure TMtbstcBtr.WriteCouAnl(pValue:Str6);
begin
  oBtrTable.FieldByName('CouAnl').AsString := pValue;
end;

function TMtbstcBtr.ReadDouSnt:Str3;
begin
  Result := oBtrTable.FieldByName('DouSnt').AsString;
end;

procedure TMtbstcBtr.WriteDouSnt(pValue:Str3);
begin
  oBtrTable.FieldByName('DouSnt').AsString := pValue;
end;

function TMtbstcBtr.ReadDouAnl:Str6;
begin
  Result := oBtrTable.FieldByName('DouAnl').AsString;
end;

procedure TMtbstcBtr.WriteDouAnl(pValue:Str6);
begin
  oBtrTable.FieldByName('DouAnl').AsString := pValue;
end;

function TMtbstcBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TMtbstcBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TMtbstcBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TMtbstcBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TMtbstcBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TMtbstcBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TMtbstcBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TMtbstcBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TMtbstcBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TMtbstcBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TMtbstcBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TMtbstcBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TMtbstcBtr.ReadGrpNum:word;
begin
  Result := oBtrTable.FieldByName('GrpNum').AsInteger;
end;

procedure TMtbstcBtr.WriteGrpNum(pValue:word);
begin
  oBtrTable.FieldByName('GrpNum').AsInteger := pValue;
end;

function TMtbstcBtr.ReadBegQnt:double;
begin
  Result := oBtrTable.FieldByName('BegQnt').AsFloat;
end;

procedure TMtbstcBtr.WriteBegQnt(pValue:double);
begin
  oBtrTable.FieldByName('BegQnt').AsFloat := pValue;
end;

function TMtbstcBtr.ReadBegVal:double;
begin
  Result := oBtrTable.FieldByName('BegVal').AsFloat;
end;

procedure TMtbstcBtr.WriteBegVal(pValue:double);
begin
  oBtrTable.FieldByName('BegVal').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TMtbstcBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TMtbstcBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TMtbstcBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TMtbstcBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TMtbstcBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TMtbstcBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TMtbstcBtr.LocateMtCode (pMtCode:longint):boolean;
begin
  SetIndex (ixMtCode);
  Result := oBtrTable.FindKey([pMtCode]);
end;

function TMtbstcBtr.LocateMtName (pMtName_:Str30):boolean;
begin
  SetIndex (ixMtName);
  Result := oBtrTable.FindKey([StrToAlias(pMtName_)]);
end;

function TMtbstcBtr.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindKey([pBarCode]);
end;

function TMtbstcBtr.LocateActQnt (pActQnt:double):boolean;
begin
  SetIndex (ixActQnt);
  Result := oBtrTable.FindKey([pActQnt]);
end;

function TMtbstcBtr.LocateActVal (pActVal:double):boolean;
begin
  SetIndex (ixActVal);
  Result := oBtrTable.FindKey([pActVal]);
end;

function TMtbstcBtr.LocateGrpNum (pGrpNum:word):boolean;
begin
  SetIndex (ixGrpNum);
  Result := oBtrTable.FindKey([pGrpNum]);
end;

function TMtbstcBtr.NearestMtCode (pMtCode:longint):boolean;
begin
  SetIndex (ixMtCode);
  Result := oBtrTable.FindNearest([pMtCode]);
end;

function TMtbstcBtr.NearestMtName (pMtName_:Str30):boolean;
begin
  SetIndex (ixMtName);
  Result := oBtrTable.FindNearest([pMtName_]);
end;

function TMtbstcBtr.NearestBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindNearest([pBarCode]);
end;

function TMtbstcBtr.NearestActQnt (pActQnt:double):boolean;
begin
  SetIndex (ixActQnt);
  Result := oBtrTable.FindNearest([pActQnt]);
end;

function TMtbstcBtr.NearestActVal (pActVal:double):boolean;
begin
  SetIndex (ixActVal);
  Result := oBtrTable.FindNearest([pActVal]);
end;

function TMtbstcBtr.NearestGrpNum (pGrpNum:word):boolean;
begin
  SetIndex (ixGrpNum);
  Result := oBtrTable.FindNearest([pGrpNum]);
end;

procedure TMtbstcBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TMtbstcBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TMtbstcBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TMtbstcBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TMtbstcBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TMtbstcBtr.First;
begin
  oBtrTable.First;
end;

procedure TMtbstcBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TMtbstcBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TMtbstcBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TMtbstcBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TMtbstcBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TMtbstcBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TMtbstcBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TMtbstcBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TMtbstcBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TMtbstcBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TMtbstcBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
