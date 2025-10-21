unit tTNS;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSerNum = '';
  ixTentNum = 'TentNum';
  ixTnRn = 'TnRn';
  ixTnRnVi = 'TnRnVi';
  ixGsCode = 'GsCode';
  ixSrvCode = 'SrvCode';
  ixStatus = 'Status';
  ixTnTi = 'TnTi';

type
  TTnsTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
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
    function  ReadTNPNum:longint;        procedure WriteTNPNum (pValue:longint);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadSrvCode:longint;       procedure WriteSrvCode (pValue:longint);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadNotice:Str30;          procedure WriteNotice (pValue:Str30);
    function  ReadSlctQnt:double;        procedure WriteSlctQnt (pValue:double);
    function  ReadSlctAVal:double;       procedure WriteSlctAVal (pValue:double);
    function  ReadSlctBVal:double;       procedure WriteSlctBVal (pValue:double);
    function  ReadSelect:boolean;        procedure WriteSelect (pValue:boolean);
    function  ReadStkNum:longint;        procedure WriteStkNum (pValue:longint);
    function  ReadCasNum:longint;        procedure WriteCasNum (pValue:longint);
    function  ReadCasUser:Str20;         procedure WriteCasUser (pValue:Str20);
    function  ReadCasDate:TDatetime;     procedure WriteCasDate (pValue:TDatetime);
    function  ReadCasTime:TDatetime;     procedure WriteCasTime (pValue:TDatetime);
    function  ReadWriNum:longint;        procedure WriteWriNum (pValue:longint);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadTcdNum:Str12;          procedure WriteTcdNum (pValue:Str12);
    function  ReadTcdItm:longint;        procedure WriteTcdItm (pValue:longint);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateSerNum (pSerNum:longint):boolean;
    function LocateTentNum (pTentNum:longint):boolean;
    function LocateTnRn (pTentNum:longint;pRoomNum:longint):boolean;
    function LocateTnRnVi (pTentNum:longint;pRoomNum:longint;pVisNum:longint):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateSrvCode (pSrvCode:longint):boolean;
    function LocateStatus (pStatus:Str1):boolean;
    function LocateTnTi (pTcdNum:Str12;pTcdItm:longint):boolean;

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
    property TNPNum:longint read ReadTNPNum write WriteTNPNum;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property SrvCode:longint read ReadSrvCode write WriteSrvCode;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property Notice:Str30 read ReadNotice write WriteNotice;
    property SlctQnt:double read ReadSlctQnt write WriteSlctQnt;
    property SlctAVal:double read ReadSlctAVal write WriteSlctAVal;
    property SlctBVal:double read ReadSlctBVal write WriteSlctBVal;
    property Select:boolean read ReadSelect write WriteSelect;
    property StkNum:longint read ReadStkNum write WriteStkNum;
    property CasNum:longint read ReadCasNum write WriteCasNum;
    property CasUser:Str20 read ReadCasUser write WriteCasUser;
    property CasDate:TDatetime read ReadCasDate write WriteCasDate;
    property CasTime:TDatetime read ReadCasTime write WriteCasTime;
    property WriNum:longint read ReadWriNum write WriteWriNum;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property TcdNum:Str12 read ReadTcdNum write WriteTcdNum;
    property TcdItm:longint read ReadTcdItm write WriteTcdItm;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TTnsTmp.Create;
begin
  oTmpTable := TmpInit ('TNS',Self);
end;

destructor TTnsTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TTnsTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TTnsTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TTnsTmp.ReadSerNum:longint;
begin
  Result := oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TTnsTmp.WriteSerNum(pValue:longint);
begin
  oTmpTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TTnsTmp.ReadTentNum:longint;
begin
  Result := oTmpTable.FieldByName('TentNum').AsInteger;
end;

procedure TTnsTmp.WriteTentNum(pValue:longint);
begin
  oTmpTable.FieldByName('TentNum').AsInteger := pValue;
end;

function TTnsTmp.ReadRoomNum:longint;
begin
  Result := oTmpTable.FieldByName('RoomNum').AsInteger;
end;

procedure TTnsTmp.WriteRoomNum(pValue:longint);
begin
  oTmpTable.FieldByName('RoomNum').AsInteger := pValue;
end;

function TTnsTmp.ReadVisNum:longint;
begin
  Result := oTmpTable.FieldByName('VisNum').AsInteger;
end;

procedure TTnsTmp.WriteVisNum(pValue:longint);
begin
  oTmpTable.FieldByName('VisNum').AsInteger := pValue;
end;

function TTnsTmp.ReadGroup:longint;
begin
  Result := oTmpTable.FieldByName('Group').AsInteger;
end;

procedure TTnsTmp.WriteGroup(pValue:longint);
begin
  oTmpTable.FieldByName('Group').AsInteger := pValue;
end;

function TTnsTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TTnsTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TTnsTmp.ReadMgCode:longint;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TTnsTmp.WriteMgCode(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TTnsTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TTnsTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TTnsTmp.ReadGsName_:Str15;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TTnsTmp.WriteGsName_(pValue:Str15);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TTnsTmp.ReadVatPrc:double;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsFloat;
end;

procedure TTnsTmp.WriteVatPrc(pValue:double);
begin
  oTmpTable.FieldByName('VatPrc').AsFloat := pValue;
end;

function TTnsTmp.ReadAPrice:double;
begin
  Result := oTmpTable.FieldByName('APrice').AsFloat;
end;

procedure TTnsTmp.WriteAPrice(pValue:double);
begin
  oTmpTable.FieldByName('APrice').AsFloat := pValue;
end;

function TTnsTmp.ReadBPrice:double;
begin
  Result := oTmpTable.FieldByName('BPrice').AsFloat;
end;

procedure TTnsTmp.WriteBPrice(pValue:double);
begin
  oTmpTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TTnsTmp.ReadDaily:Str1;
begin
  Result := oTmpTable.FieldByName('Daily').AsString;
end;

procedure TTnsTmp.WriteDaily(pValue:Str1);
begin
  oTmpTable.FieldByName('Daily').AsString := pValue;
end;

function TTnsTmp.ReadQuant:double;
begin
  Result := oTmpTable.FieldByName('Quant').AsFloat;
end;

procedure TTnsTmp.WriteQuant(pValue:double);
begin
  oTmpTable.FieldByName('Quant').AsFloat := pValue;
end;

function TTnsTmp.ReadAValue:double;
begin
  Result := oTmpTable.FieldByName('AValue').AsFloat;
end;

procedure TTnsTmp.WriteAValue(pValue:double);
begin
  oTmpTable.FieldByName('AValue').AsFloat := pValue;
end;

function TTnsTmp.ReadBValue:double;
begin
  Result := oTmpTable.FieldByName('BValue').AsFloat;
end;

procedure TTnsTmp.WriteBValue(pValue:double);
begin
  oTmpTable.FieldByName('BValue').AsFloat := pValue;
end;

function TTnsTmp.ReadStatus:Str1;
begin
  Result := oTmpTable.FieldByName('Status').AsString;
end;

procedure TTnsTmp.WriteStatus(pValue:Str1);
begin
  oTmpTable.FieldByName('Status').AsString := pValue;
end;

function TTnsTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TTnsTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TTnsTmp.ReadItmNum:longint;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TTnsTmp.WriteItmNum(pValue:longint);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TTnsTmp.ReadTNPNum:longint;
begin
  Result := oTmpTable.FieldByName('TNPNum').AsInteger;
end;

procedure TTnsTmp.WriteTNPNum(pValue:longint);
begin
  oTmpTable.FieldByName('TNPNum').AsInteger := pValue;
end;

function TTnsTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TTnsTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TTnsTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TTnsTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TTnsTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TTnsTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TTnsTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TTnsTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TTnsTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TTnsTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TTnsTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TTnsTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TTnsTmp.ReadSrvCode:longint;
begin
  Result := oTmpTable.FieldByName('SrvCode').AsInteger;
end;

procedure TTnsTmp.WriteSrvCode(pValue:longint);
begin
  oTmpTable.FieldByName('SrvCode').AsInteger := pValue;
end;

function TTnsTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TTnsTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TTnsTmp.ReadNotice:Str30;
begin
  Result := oTmpTable.FieldByName('Notice').AsString;
end;

procedure TTnsTmp.WriteNotice(pValue:Str30);
begin
  oTmpTable.FieldByName('Notice').AsString := pValue;
end;

function TTnsTmp.ReadSlctQnt:double;
begin
  Result := oTmpTable.FieldByName('SlctQnt').AsFloat;
end;

procedure TTnsTmp.WriteSlctQnt(pValue:double);
begin
  oTmpTable.FieldByName('SlctQnt').AsFloat := pValue;
end;

function TTnsTmp.ReadSlctAVal:double;
begin
  Result := oTmpTable.FieldByName('SlctAVal').AsFloat;
end;

procedure TTnsTmp.WriteSlctAVal(pValue:double);
begin
  oTmpTable.FieldByName('SlctAVal').AsFloat := pValue;
end;

function TTnsTmp.ReadSlctBVal:double;
begin
  Result := oTmpTable.FieldByName('SlctBVal').AsFloat;
end;

procedure TTnsTmp.WriteSlctBVal(pValue:double);
begin
  oTmpTable.FieldByName('SlctBVal').AsFloat := pValue;
end;

function TTnsTmp.ReadSelect:boolean;
begin
  Result := oTmpTable.FieldByName('Select').AsVariant;
end;

procedure TTnsTmp.WriteSelect(pValue:boolean);
begin
  oTmpTable.FieldByName('Select').AsVariant := pValue;
end;

function TTnsTmp.ReadStkNum:longint;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TTnsTmp.WriteStkNum(pValue:longint);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TTnsTmp.ReadCasNum:longint;
begin
  Result := oTmpTable.FieldByName('CasNum').AsInteger;
end;

procedure TTnsTmp.WriteCasNum(pValue:longint);
begin
  oTmpTable.FieldByName('CasNum').AsInteger := pValue;
end;

function TTnsTmp.ReadCasUser:Str20;
begin
  Result := oTmpTable.FieldByName('CasUser').AsString;
end;

procedure TTnsTmp.WriteCasUser(pValue:Str20);
begin
  oTmpTable.FieldByName('CasUser').AsString := pValue;
end;

function TTnsTmp.ReadCasDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CasDate').AsDateTime;
end;

procedure TTnsTmp.WriteCasDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CasDate').AsDateTime := pValue;
end;

function TTnsTmp.ReadCasTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CasTime').AsDateTime;
end;

procedure TTnsTmp.WriteCasTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CasTime').AsDateTime := pValue;
end;

function TTnsTmp.ReadWriNum:longint;
begin
  Result := oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TTnsTmp.WriteWriNum(pValue:longint);
begin
  oTmpTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TTnsTmp.ReadDscPrc:double;
begin
  Result := oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TTnsTmp.WriteDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TTnsTmp.ReadTcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('TcdNum').AsString;
end;

procedure TTnsTmp.WriteTcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('TcdNum').AsString := pValue;
end;

function TTnsTmp.ReadTcdItm:longint;
begin
  Result := oTmpTable.FieldByName('TcdItm').AsInteger;
end;

procedure TTnsTmp.WriteTcdItm(pValue:longint);
begin
  oTmpTable.FieldByName('TcdItm').AsInteger := pValue;
end;

function TTnsTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TTnsTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTnsTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TTnsTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TTnsTmp.LocateSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oTmpTable.FindKey([pSerNum]);
end;

function TTnsTmp.LocateTentNum (pTentNum:longint):boolean;
begin
  SetIndex (ixTentNum);
  Result := oTmpTable.FindKey([pTentNum]);
end;

function TTnsTmp.LocateTnRn (pTentNum:longint;pRoomNum:longint):boolean;
begin
  SetIndex (ixTnRn);
  Result := oTmpTable.FindKey([pTentNum,pRoomNum]);
end;

function TTnsTmp.LocateTnRnVi (pTentNum:longint;pRoomNum:longint;pVisNum:longint):boolean;
begin
  SetIndex (ixTnRnVi);
  Result := oTmpTable.FindKey([pTentNum,pRoomNum,pVisNum]);
end;

function TTnsTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TTnsTmp.LocateSrvCode (pSrvCode:longint):boolean;
begin
  SetIndex (ixSrvCode);
  Result := oTmpTable.FindKey([pSrvCode]);
end;

function TTnsTmp.LocateStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oTmpTable.FindKey([pStatus]);
end;

function TTnsTmp.LocateTnTi (pTcdNum:Str12;pTcdItm:longint):boolean;
begin
  SetIndex (ixTnTi);
  Result := oTmpTable.FindKey([pTcdNum,pTcdItm]);
end;

procedure TTnsTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TTnsTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TTnsTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TTnsTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TTnsTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TTnsTmp.First;
begin
  oTmpTable.First;
end;

procedure TTnsTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TTnsTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TTnsTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TTnsTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TTnsTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TTnsTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TTnsTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TTnsTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TTnsTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TTnsTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TTnsTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
