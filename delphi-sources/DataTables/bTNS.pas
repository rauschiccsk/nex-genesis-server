unit bTNS;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSerNum = 'SerNum';
  ixTentNum = 'TentNum';
  ixTnRn = 'TnRn';
  ixTnRnVi = 'TnRnVi';
  ixGsCode = 'GsCode';
  ixSrvCode = 'SrvCode';
  ixStatus = 'Status';
  ixTnTi = 'TnTi';

type
  TTnsBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
    function  ReadTentNum:longint;       procedure WriteTentNum (pValue:longint);
    function  ReadRoomNum:longint;       procedure WriteRoomNum (pValue:longint);
    function  ReadVisNum:longint;        procedure WriteVisNum (pValue:longint);
    function  ReadGroup:longint;         procedure WriteGroup (pValue:longint);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str15;         procedure WriteGsName_ (pValue:Str15);
    function  ReadVatPrc:double;         procedure WriteVatPrc (pValue:double);
    function  ReadAPrice:double;         procedure WriteAPrice (pValue:double);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadDaily:Str1;            procedure WriteDaily (pValue:Str1);
    function  ReadQuant:double;          procedure WriteQuant (pValue:double);
    function  ReadAValue:double;         procedure WriteAValue (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadStatus:Str1;           procedure WriteStatus (pValue:Str1);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:longint;        procedure WriteItmNum (pValue:longint);
    function  ReadTnpNum:longint;        procedure WriteTnpNum (pValue:longint);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadSrvCode:longint;       procedure WriteSrvCode (pValue:longint);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadNotice:Str30;          procedure WriteNotice (pValue:Str30);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
    function  ReadStkNum:longint;        procedure WriteStkNum (pValue:longint);
    function  ReadCasNum:longint;        procedure WriteCasNum (pValue:longint);
    function  ReadCasUser:Str20;         procedure WriteCasUser (pValue:Str20);
    function  ReadCasDate:TDatetime;     procedure WriteCasDate (pValue:TDatetime);
    function  ReadCasTime:TDatetime;     procedure WriteCasTime (pValue:TDatetime);
    function  ReadWriNum:longint;        procedure WriteWriNum (pValue:longint);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadTcdNum:Str12;          procedure WriteTcdNum (pValue:Str12);
    function  ReadTcdItm:longint;        procedure WriteTcdItm (pValue:longint);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateSerNum (pSerNum:longint):boolean;
    function LocateTentNum (pTentNum:longint):boolean;
    function LocateTnRn (pTentNum:longint;pRoomNum:longint):boolean;
    function LocateTnRnVi (pTentNum:longint;pRoomNum:longint;pVisNum:longint):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateSrvCode (pSrvCode:longint):boolean;
    function LocateStatus (pStatus:Str1):boolean;
    function LocateTnTi (pTcdNum:Str12;pTcdItm:longint):boolean;
    function NearestSerNum (pSerNum:longint):boolean;
    function NearestTentNum (pTentNum:longint):boolean;
    function NearestTnRn (pTentNum:longint;pRoomNum:longint):boolean;
    function NearestTnRnVi (pTentNum:longint;pRoomNum:longint;pVisNum:longint):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestSrvCode (pSrvCode:longint):boolean;
    function NearestStatus (pStatus:Str1):boolean;
    function NearestTnTi (pTcdNum:Str12;pTcdItm:longint):boolean;

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
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property TentNum:longint read ReadTentNum write WriteTentNum;
    property RoomNum:longint read ReadRoomNum write WriteRoomNum;
    property VisNum:longint read ReadVisNum write WriteVisNum;
    property Group:longint read ReadGroup write WriteGroup;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str15 read ReadGsName_ write WriteGsName_;
    property VatPrc:double read ReadVatPrc write WriteVatPrc;
    property APrice:double read ReadAPrice write WriteAPrice;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property Daily:Str1 read ReadDaily write WriteDaily;
    property Quant:double read ReadQuant write WriteQuant;
    property AValue:double read ReadAValue write WriteAValue;
    property BValue:double read ReadBValue write WriteBValue;
    property Status:Str1 read ReadStatus write WriteStatus;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:longint read ReadItmNum write WriteItmNum;
    property TnpNum:longint read ReadTnpNum write WriteTnpNum;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property SrvCode:longint read ReadSrvCode write WriteSrvCode;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property Notice:Str30 read ReadNotice write WriteNotice;
    property ActPosM:longint read ReadActPos write WriteActPos;
    property StkNum:longint read ReadStkNum write WriteStkNum;
    property CasNum:longint read ReadCasNum write WriteCasNum;
    property CasUser:Str20 read ReadCasUser write WriteCasUser;
    property CasDate:TDatetime read ReadCasDate write WriteCasDate;
    property CasTime:TDatetime read ReadCasTime write WriteCasTime;
    property WriNum:longint read ReadWriNum write WriteWriNum;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property TcdNum:Str12 read ReadTcdNum write WriteTcdNum;
    property TcdItm:longint read ReadTcdItm write WriteTcdItm;
  end;

implementation

constructor TTnsBtr.Create;
begin
  oBtrTable := BtrInit ('TNS',gPath.HtlPath,Self);
end;

constructor TTnsBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('TNS',pPath,Self);
end;

destructor TTnsBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TTnsBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TTnsBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TTnsBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TTnsBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TTnsBtr.ReadTentNum:longint;
begin
  Result := oBtrTable.FieldByName('TentNum').AsInteger;
end;

procedure TTnsBtr.WriteTentNum(pValue:longint);
begin
  oBtrTable.FieldByName('TentNum').AsInteger := pValue;
end;

function TTnsBtr.ReadRoomNum:longint;
begin
  Result := oBtrTable.FieldByName('RoomNum').AsInteger;
end;

procedure TTnsBtr.WriteRoomNum(pValue:longint);
begin
  oBtrTable.FieldByName('RoomNum').AsInteger := pValue;
end;

function TTnsBtr.ReadVisNum:longint;
begin
  Result := oBtrTable.FieldByName('VisNum').AsInteger;
end;

procedure TTnsBtr.WriteVisNum(pValue:longint);
begin
  oBtrTable.FieldByName('VisNum').AsInteger := pValue;
end;

function TTnsBtr.ReadGroup:longint;
begin
  Result := oBtrTable.FieldByName('Group').AsInteger;
end;

procedure TTnsBtr.WriteGroup(pValue:longint);
begin
  oBtrTable.FieldByName('Group').AsInteger := pValue;
end;

function TTnsBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TTnsBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TTnsBtr.ReadMgCode:longint;
begin
  Result := oBtrTable.FieldByName('MgCode').AsInteger;
end;

procedure TTnsBtr.WriteMgCode(pValue:longint);
begin
  oBtrTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TTnsBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TTnsBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TTnsBtr.ReadGsName_:Str15;
begin
  Result := oBtrTable.FieldByName('GsName_').AsString;
end;

procedure TTnsBtr.WriteGsName_(pValue:Str15);
begin
  oBtrTable.FieldByName('GsName_').AsString := pValue;
end;

function TTnsBtr.ReadVatPrc:double;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsFloat;
end;

procedure TTnsBtr.WriteVatPrc(pValue:double);
begin
  oBtrTable.FieldByName('VatPrc').AsFloat := pValue;
end;

function TTnsBtr.ReadAPrice:double;
begin
  Result := oBtrTable.FieldByName('APrice').AsFloat;
end;

procedure TTnsBtr.WriteAPrice(pValue:double);
begin
  oBtrTable.FieldByName('APrice').AsFloat := pValue;
end;

function TTnsBtr.ReadBPrice:double;
begin
  Result := oBtrTable.FieldByName('BPrice').AsFloat;
end;

procedure TTnsBtr.WriteBPrice(pValue:double);
begin
  oBtrTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TTnsBtr.ReadDaily:Str1;
begin
  Result := oBtrTable.FieldByName('Daily').AsString;
end;

procedure TTnsBtr.WriteDaily(pValue:Str1);
begin
  oBtrTable.FieldByName('Daily').AsString := pValue;
end;

function TTnsBtr.ReadQuant:double;
begin
  Result := oBtrTable.FieldByName('Quant').AsFloat;
end;

procedure TTnsBtr.WriteQuant(pValue:double);
begin
  oBtrTable.FieldByName('Quant').AsFloat := pValue;
end;

function TTnsBtr.ReadAValue:double;
begin
  Result := oBtrTable.FieldByName('AValue').AsFloat;
end;

procedure TTnsBtr.WriteAValue(pValue:double);
begin
  oBtrTable.FieldByName('AValue').AsFloat := pValue;
end;

function TTnsBtr.ReadBValue:double;
begin
  Result := oBtrTable.FieldByName('BValue').AsFloat;
end;

procedure TTnsBtr.WriteBValue(pValue:double);
begin
  oBtrTable.FieldByName('BValue').AsFloat := pValue;
end;

function TTnsBtr.ReadStatus:Str1;
begin
  Result := oBtrTable.FieldByName('Status').AsString;
end;

procedure TTnsBtr.WriteStatus(pValue:Str1);
begin
  oBtrTable.FieldByName('Status').AsString := pValue;
end;

function TTnsBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TTnsBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TTnsBtr.ReadItmNum:longint;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TTnsBtr.WriteItmNum(pValue:longint);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TTnsBtr.ReadTnpNum:longint;
begin
  Result := oBtrTable.FieldByName('TnpNum').AsInteger;
end;

procedure TTnsBtr.WriteTnpNum(pValue:longint);
begin
  oBtrTable.FieldByName('TnpNum').AsInteger := pValue;
end;

function TTnsBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TTnsBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TTnsBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TTnsBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TTnsBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TTnsBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TTnsBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TTnsBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TTnsBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TTnsBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TTnsBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TTnsBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TTnsBtr.ReadSrvCode:longint;
begin
  Result := oBtrTable.FieldByName('SrvCode').AsInteger;
end;

procedure TTnsBtr.WriteSrvCode(pValue:longint);
begin
  oBtrTable.FieldByName('SrvCode').AsInteger := pValue;
end;

function TTnsBtr.ReadMsName:Str10;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TTnsBtr.WriteMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TTnsBtr.ReadNotice:Str30;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TTnsBtr.WriteNotice(pValue:Str30);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

function TTnsBtr.ReadActPos:longint;
begin
  Result := oBtrTable.FieldByName('ActPos').AsInteger;
end;

procedure TTnsBtr.WriteActPos(pValue:longint);
begin
  oBtrTable.FieldByName('ActPos').AsInteger := pValue;
end;

function TTnsBtr.ReadStkNum:longint;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TTnsBtr.WriteStkNum(pValue:longint);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TTnsBtr.ReadCasNum:longint;
begin
  Result := oBtrTable.FieldByName('CasNum').AsInteger;
end;

procedure TTnsBtr.WriteCasNum(pValue:longint);
begin
  oBtrTable.FieldByName('CasNum').AsInteger := pValue;
end;

function TTnsBtr.ReadCasUser:Str20;
begin
  Result := oBtrTable.FieldByName('CasUser').AsString;
end;

procedure TTnsBtr.WriteCasUser(pValue:Str20);
begin
  oBtrTable.FieldByName('CasUser').AsString := pValue;
end;

function TTnsBtr.ReadCasDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CasDate').AsDateTime;
end;

procedure TTnsBtr.WriteCasDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CasDate').AsDateTime := pValue;
end;

function TTnsBtr.ReadCasTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CasTime').AsDateTime;
end;

procedure TTnsBtr.WriteCasTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CasTime').AsDateTime := pValue;
end;

function TTnsBtr.ReadWriNum:longint;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TTnsBtr.WriteWriNum(pValue:longint);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TTnsBtr.ReadDscPrc:double;
begin
  Result := oBtrTable.FieldByName('DscPrc').AsFloat;
end;

procedure TTnsBtr.WriteDscPrc(pValue:double);
begin
  oBtrTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TTnsBtr.ReadTcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('TcdNum').AsString;
end;

procedure TTnsBtr.WriteTcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('TcdNum').AsString := pValue;
end;

function TTnsBtr.ReadTcdItm:longint;
begin
  Result := oBtrTable.FieldByName('TcdItm').AsInteger;
end;

procedure TTnsBtr.WriteTcdItm(pValue:longint);
begin
  oBtrTable.FieldByName('TcdItm').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTnsBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTnsBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TTnsBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTnsBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TTnsBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TTnsBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TTnsBtr.LocateSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindKey([pSerNum]);
end;

function TTnsBtr.LocateTentNum (pTentNum:longint):boolean;
begin
  SetIndex (ixTentNum);
  Result := oBtrTable.FindKey([pTentNum]);
end;

function TTnsBtr.LocateTnRn (pTentNum:longint;pRoomNum:longint):boolean;
begin
  SetIndex (ixTnRn);
  Result := oBtrTable.FindKey([pTentNum,pRoomNum]);
end;

function TTnsBtr.LocateTnRnVi (pTentNum:longint;pRoomNum:longint;pVisNum:longint):boolean;
begin
  SetIndex (ixTnRnVi);
  Result := oBtrTable.FindKey([pTentNum,pRoomNum,pVisNum]);
end;

function TTnsBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TTnsBtr.LocateSrvCode (pSrvCode:longint):boolean;
begin
  SetIndex (ixSrvCode);
  Result := oBtrTable.FindKey([pSrvCode]);
end;

function TTnsBtr.LocateStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oBtrTable.FindKey([pStatus]);
end;

function TTnsBtr.LocateTnTi (pTcdNum:Str12;pTcdItm:longint):boolean;
begin
  SetIndex (ixTnTi);
  Result := oBtrTable.FindKey([pTcdNum,pTcdItm]);
end;

function TTnsBtr.NearestSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindNearest([pSerNum]);
end;

function TTnsBtr.NearestTentNum (pTentNum:longint):boolean;
begin
  SetIndex (ixTentNum);
  Result := oBtrTable.FindNearest([pTentNum]);
end;

function TTnsBtr.NearestTnRn (pTentNum:longint;pRoomNum:longint):boolean;
begin
  SetIndex (ixTnRn);
  Result := oBtrTable.FindNearest([pTentNum,pRoomNum]);
end;

function TTnsBtr.NearestTnRnVi (pTentNum:longint;pRoomNum:longint;pVisNum:longint):boolean;
begin
  SetIndex (ixTnRnVi);
  Result := oBtrTable.FindNearest([pTentNum,pRoomNum,pVisNum]);
end;

function TTnsBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TTnsBtr.NearestSrvCode (pSrvCode:longint):boolean;
begin
  SetIndex (ixSrvCode);
  Result := oBtrTable.FindNearest([pSrvCode]);
end;

function TTnsBtr.NearestStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oBtrTable.FindNearest([pStatus]);
end;

function TTnsBtr.NearestTnTi (pTcdNum:Str12;pTcdItm:longint):boolean;
begin
  SetIndex (ixTnTi);
  Result := oBtrTable.FindNearest([pTcdNum,pTcdItm]);
end;

procedure TTnsBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TTnsBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TTnsBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TTnsBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TTnsBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TTnsBtr.First;
begin
  oBtrTable.First;
end;

procedure TTnsBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TTnsBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TTnsBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TTnsBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TTnsBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TTnsBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TTnsBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TTnsBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TTnsBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TTnsBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TTnsBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
