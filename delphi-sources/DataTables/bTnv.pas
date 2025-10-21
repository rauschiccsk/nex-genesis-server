unit bTNV;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixTentNum = 'TentNum';
  ixTnRn = 'TnRn';
  ixTnRnVi = 'TnRnVi';
  ixVisName = 'VisName';
  ixStatus = 'Status';

type
  TTnvBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadTentNum:longint;       procedure WriteTentNum (pValue:longint);
    function  ReadRoomNum:longint;       procedure WriteRoomNum (pValue:longint);
    function  ReadVisNum:longint;        procedure WriteVisNum (pValue:longint);
    function  ReadDateI:TDatetime;       procedure WriteDateI (pValue:TDatetime);
    function  ReadDateO:TDatetime;       procedure WriteDateO (pValue:TDatetime);
    function  ReadGrpPay:Str1;           procedure WriteGrpPay (pValue:Str1);
    function  ReadStatus:Str1;           procedure WriteStatus (pValue:Str1);
    function  ReadVisName:Str50;         procedure WriteVisName (pValue:Str50);
    function  ReadVisAdress:Str50;       procedure WriteVisAdress (pValue:Str50);
    function  ReadVisCtyName:Str20;      procedure WriteVisCtyName (pValue:Str20);
    function  ReadVisCtyCode:Str4;       procedure WriteVisCtyCode (pValue:Str4);
    function  ReadVisCtyZIP:Str6;        procedure WriteVisCtyZIP (pValue:Str6);
    function  ReadVisStaName:Str20;      procedure WriteVisStaName (pValue:Str20);
    function  ReadVisStaCode:Str4;       procedure WriteVisStaCode (pValue:Str4);
    function  ReadVisTelNum:Str30;       procedure WriteVisTelNum (pValue:Str30);
    function  ReadVisfaxNum:Str30;       procedure WriteVisfaxNum (pValue:Str30);
    function  ReadVisMobNum:Str30;       procedure WriteVisMobNum (pValue:Str30);
    function  ReadVisEMail:Str30;        procedure WriteVisEMail (pValue:Str30);
    function  ReadVisType:Str1;          procedure WriteVisType (pValue:Str1);
    function  ReadVisDocType:Str1;       procedure WriteVisDocType (pValue:Str1);
    function  ReadVisDocNum:Str30;       procedure WriteVisDocNum (pValue:Str30);
    function  ReadBirthDate:TDatetime;   procedure WriteBirthDate (pValue:TDatetime);
    function  ReadPayment1:Str1;         procedure WritePayment1 (pValue:Str1);
    function  ReadPayment2:Str1;         procedure WritePayment2 (pValue:Str1);
    function  ReadPayment3:Str1;         procedure WritePayment3 (pValue:Str1);
    function  ReadPayment4:Str1;         procedure WritePayment4 (pValue:Str1);
    function  ReadPayment5:Str1;         procedure WritePayment5 (pValue:Str1);
    function  ReadIdType:Str3;           procedure WriteIdType (pValue:Str3);
    function  ReadIdNum:Str30;           procedure WriteIdNum (pValue:Str30);
    function  ReadPlsNum:longint;        procedure WritePlsNum (pValue:longint);
    function  ReadPayType:Str1;          procedure WritePayType (pValue:Str1);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadVisName_:Str20;        procedure WriteVisName_ (pValue:Str20);
    function  ReadBirthPlace:Str30;      procedure WriteBirthPlace (pValue:Str30);
    function  ReadCitizenship:Str30;     procedure WriteCitizenship (pValue:Str30);
    function  ReadVisaType:Str50;        procedure WriteVisaType (pValue:Str50);
    function  ReadJourPurpose:Str50;     procedure WriteJourPurpose (pValue:Str50);
    function  ReadEmptStat:Str1;         procedure WriteEmptStat (pValue:Str1);
    function  ReadEmptDate:TDatetime;    procedure WriteEmptDate (pValue:TDatetime);
    function  ReadEmptTime:TDatetime;    procedure WriteEmptTime (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateTentNum (pTentNum:longint):boolean;
    function LocateTnRn (pTentNum:longint;pRoomNum:longint):boolean;
    function LocateTnRnVi (pTentNum:longint;pRoomNum:longint;pVisNum:longint):boolean;
    function LocateVisName (pVisName_:Str20):boolean;
    function LocateStatus (pStatus:Str1):boolean;
    function NearestTentNum (pTentNum:longint):boolean;
    function NearestTnRn (pTentNum:longint;pRoomNum:longint):boolean;
    function NearestTnRnVi (pTentNum:longint;pRoomNum:longint;pVisNum:longint):boolean;
    function NearestVisName (pVisName_:Str20):boolean;
    function NearestStatus (pStatus:Str1):boolean;

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
    property TentNum:longint read ReadTentNum write WriteTentNum;
    property RoomNum:longint read ReadRoomNum write WriteRoomNum;
    property VisNum:longint read ReadVisNum write WriteVisNum;
    property DateI:TDatetime read ReadDateI write WriteDateI;
    property DateO:TDatetime read ReadDateO write WriteDateO;
    property GrpPay:Str1 read ReadGrpPay write WriteGrpPay;
    property Status:Str1 read ReadStatus write WriteStatus;
    property VisName:Str50 read ReadVisName write WriteVisName;
    property VisAdress:Str50 read ReadVisAdress write WriteVisAdress;
    property VisCtyName:Str20 read ReadVisCtyName write WriteVisCtyName;
    property VisCtyCode:Str4 read ReadVisCtyCode write WriteVisCtyCode;
    property VisCtyZIP:Str6 read ReadVisCtyZIP write WriteVisCtyZIP;
    property VisStaName:Str20 read ReadVisStaName write WriteVisStaName;
    property VisStaCode:Str4 read ReadVisStaCode write WriteVisStaCode;
    property VisTelNum:Str30 read ReadVisTelNum write WriteVisTelNum;
    property VisfaxNum:Str30 read ReadVisfaxNum write WriteVisfaxNum;
    property VisMobNum:Str30 read ReadVisMobNum write WriteVisMobNum;
    property VisEMail:Str30 read ReadVisEMail write WriteVisEMail;
    property VisType:Str1 read ReadVisType write WriteVisType;
    property VisDocType:Str1 read ReadVisDocType write WriteVisDocType;
    property VisDocNum:Str30 read ReadVisDocNum write WriteVisDocNum;
    property BirthDate:TDatetime read ReadBirthDate write WriteBirthDate;
    property Payment1:Str1 read ReadPayment1 write WritePayment1;
    property Payment2:Str1 read ReadPayment2 write WritePayment2;
    property Payment3:Str1 read ReadPayment3 write WritePayment3;
    property Payment4:Str1 read ReadPayment4 write WritePayment4;
    property Payment5:Str1 read ReadPayment5 write WritePayment5;
    property IdType:Str3 read ReadIdType write WriteIdType;
    property IdNum:Str30 read ReadIdNum write WriteIdNum;
    property PlsNum:longint read ReadPlsNum write WritePlsNum;
    property PayType:Str1 read ReadPayType write WritePayType;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property VisName_:Str20 read ReadVisName_ write WriteVisName_;
    property BirthPlace:Str30 read ReadBirthPlace write WriteBirthPlace;
    property Citizenship:Str30 read ReadCitizenship write WriteCitizenship;
    property VisaType:Str50 read ReadVisaType write WriteVisaType;
    property JourPurpose:Str50 read ReadJourPurpose write WriteJourPurpose;
    property EmptStat:Str1 read ReadEmptStat write WriteEmptStat;
    property EmptDate:TDatetime read ReadEmptDate write WriteEmptDate;
    property EmptTime:TDatetime read ReadEmptTime write WriteEmptTime;
    property ActPosM:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TTnvBtr.Create;
begin
  oBtrTable := BtrInit ('TNV',gPath.HtlPath,Self);
end;

constructor TTnvBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('TNV',pPath,Self);
end;

destructor TTnvBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TTnvBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TTnvBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TTnvBtr.ReadTentNum:longint;
begin
  Result := oBtrTable.FieldByName('TentNum').AsInteger;
end;

procedure TTnvBtr.WriteTentNum(pValue:longint);
begin
  oBtrTable.FieldByName('TentNum').AsInteger := pValue;
end;

function TTnvBtr.ReadRoomNum:longint;
begin
  Result := oBtrTable.FieldByName('RoomNum').AsInteger;
end;

procedure TTnvBtr.WriteRoomNum(pValue:longint);
begin
  oBtrTable.FieldByName('RoomNum').AsInteger := pValue;
end;

function TTnvBtr.ReadVisNum:longint;
begin
  Result := oBtrTable.FieldByName('VisNum').AsInteger;
end;

procedure TTnvBtr.WriteVisNum(pValue:longint);
begin
  oBtrTable.FieldByName('VisNum').AsInteger := pValue;
end;

function TTnvBtr.ReadDateI:TDatetime;
begin
  Result := oBtrTable.FieldByName('DateI').AsDateTime;
end;

procedure TTnvBtr.WriteDateI(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DateI').AsDateTime := pValue;
end;

function TTnvBtr.ReadDateO:TDatetime;
begin
  Result := oBtrTable.FieldByName('DateO').AsDateTime;
end;

procedure TTnvBtr.WriteDateO(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DateO').AsDateTime := pValue;
end;

function TTnvBtr.ReadGrpPay:Str1;
begin
  Result := oBtrTable.FieldByName('GrpPay').AsString;
end;

procedure TTnvBtr.WriteGrpPay(pValue:Str1);
begin
  oBtrTable.FieldByName('GrpPay').AsString := pValue;
end;

function TTnvBtr.ReadStatus:Str1;
begin
  Result := oBtrTable.FieldByName('Status').AsString;
end;

procedure TTnvBtr.WriteStatus(pValue:Str1);
begin
  oBtrTable.FieldByName('Status').AsString := pValue;
end;

function TTnvBtr.ReadVisName:Str50;
begin
  Result := oBtrTable.FieldByName('VisName').AsString;
end;

procedure TTnvBtr.WriteVisName(pValue:Str50);
begin
  oBtrTable.FieldByName('VisName').AsString := pValue;
end;

function TTnvBtr.ReadVisAdress:Str50;
begin
  Result := oBtrTable.FieldByName('VisAdress').AsString;
end;

procedure TTnvBtr.WriteVisAdress(pValue:Str50);
begin
  oBtrTable.FieldByName('VisAdress').AsString := pValue;
end;

function TTnvBtr.ReadVisCtyName:Str20;
begin
  Result := oBtrTable.FieldByName('VisCtyName').AsString;
end;

procedure TTnvBtr.WriteVisCtyName(pValue:Str20);
begin
  oBtrTable.FieldByName('VisCtyName').AsString := pValue;
end;

function TTnvBtr.ReadVisCtyCode:Str4;
begin
  Result := oBtrTable.FieldByName('VisCtyCode').AsString;
end;

procedure TTnvBtr.WriteVisCtyCode(pValue:Str4);
begin
  oBtrTable.FieldByName('VisCtyCode').AsString := pValue;
end;

function TTnvBtr.ReadVisCtyZIP:Str6;
begin
  Result := oBtrTable.FieldByName('VisCtyZIP').AsString;
end;

procedure TTnvBtr.WriteVisCtyZIP(pValue:Str6);
begin
  oBtrTable.FieldByName('VisCtyZIP').AsString := pValue;
end;

function TTnvBtr.ReadVisStaName:Str20;
begin
  Result := oBtrTable.FieldByName('VisStaName').AsString;
end;

procedure TTnvBtr.WriteVisStaName(pValue:Str20);
begin
  oBtrTable.FieldByName('VisStaName').AsString := pValue;
end;

function TTnvBtr.ReadVisStaCode:Str4;
begin
  Result := oBtrTable.FieldByName('VisStaCode').AsString;
end;

procedure TTnvBtr.WriteVisStaCode(pValue:Str4);
begin
  oBtrTable.FieldByName('VisStaCode').AsString := pValue;
end;

function TTnvBtr.ReadVisTelNum:Str30;
begin
  Result := oBtrTable.FieldByName('VisTelNum').AsString;
end;

procedure TTnvBtr.WriteVisTelNum(pValue:Str30);
begin
  oBtrTable.FieldByName('VisTelNum').AsString := pValue;
end;

function TTnvBtr.ReadVisfaxNum:Str30;
begin
  Result := oBtrTable.FieldByName('VisfaxNum').AsString;
end;

procedure TTnvBtr.WriteVisfaxNum(pValue:Str30);
begin
  oBtrTable.FieldByName('VisfaxNum').AsString := pValue;
end;

function TTnvBtr.ReadVisMobNum:Str30;
begin
  Result := oBtrTable.FieldByName('VisMobNum').AsString;
end;

procedure TTnvBtr.WriteVisMobNum(pValue:Str30);
begin
  oBtrTable.FieldByName('VisMobNum').AsString := pValue;
end;

function TTnvBtr.ReadVisEMail:Str30;
begin
  Result := oBtrTable.FieldByName('VisEMail').AsString;
end;

procedure TTnvBtr.WriteVisEMail(pValue:Str30);
begin
  oBtrTable.FieldByName('VisEMail').AsString := pValue;
end;

function TTnvBtr.ReadVisType:Str1;
begin
  Result := oBtrTable.FieldByName('VisType').AsString;
end;

procedure TTnvBtr.WriteVisType(pValue:Str1);
begin
  oBtrTable.FieldByName('VisType').AsString := pValue;
end;

function TTnvBtr.ReadVisDocType:Str1;
begin
  Result := oBtrTable.FieldByName('VisDocType').AsString;
end;

procedure TTnvBtr.WriteVisDocType(pValue:Str1);
begin
  oBtrTable.FieldByName('VisDocType').AsString := pValue;
end;

function TTnvBtr.ReadVisDocNum:Str30;
begin
  Result := oBtrTable.FieldByName('VisDocNum').AsString;
end;

procedure TTnvBtr.WriteVisDocNum(pValue:Str30);
begin
  oBtrTable.FieldByName('VisDocNum').AsString := pValue;
end;

function TTnvBtr.ReadBirthDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('BirthDate').AsDateTime;
end;

procedure TTnvBtr.WriteBirthDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BirthDate').AsDateTime := pValue;
end;

function TTnvBtr.ReadPayment1:Str1;
begin
  Result := oBtrTable.FieldByName('Payment1').AsString;
end;

procedure TTnvBtr.WritePayment1(pValue:Str1);
begin
  oBtrTable.FieldByName('Payment1').AsString := pValue;
end;

function TTnvBtr.ReadPayment2:Str1;
begin
  Result := oBtrTable.FieldByName('Payment2').AsString;
end;

procedure TTnvBtr.WritePayment2(pValue:Str1);
begin
  oBtrTable.FieldByName('Payment2').AsString := pValue;
end;

function TTnvBtr.ReadPayment3:Str1;
begin
  Result := oBtrTable.FieldByName('Payment3').AsString;
end;

procedure TTnvBtr.WritePayment3(pValue:Str1);
begin
  oBtrTable.FieldByName('Payment3').AsString := pValue;
end;

function TTnvBtr.ReadPayment4:Str1;
begin
  Result := oBtrTable.FieldByName('Payment4').AsString;
end;

procedure TTnvBtr.WritePayment4(pValue:Str1);
begin
  oBtrTable.FieldByName('Payment4').AsString := pValue;
end;

function TTnvBtr.ReadPayment5:Str1;
begin
  Result := oBtrTable.FieldByName('Payment5').AsString;
end;

procedure TTnvBtr.WritePayment5(pValue:Str1);
begin
  oBtrTable.FieldByName('Payment5').AsString := pValue;
end;

function TTnvBtr.ReadIdType:Str3;
begin
  Result := oBtrTable.FieldByName('IdType').AsString;
end;

procedure TTnvBtr.WriteIdType(pValue:Str3);
begin
  oBtrTable.FieldByName('IdType').AsString := pValue;
end;

function TTnvBtr.ReadIdNum:Str30;
begin
  Result := oBtrTable.FieldByName('IdNum').AsString;
end;

procedure TTnvBtr.WriteIdNum(pValue:Str30);
begin
  oBtrTable.FieldByName('IdNum').AsString := pValue;
end;

function TTnvBtr.ReadPlsNum:longint;
begin
  Result := oBtrTable.FieldByName('PlsNum').AsInteger;
end;

procedure TTnvBtr.WritePlsNum(pValue:longint);
begin
  oBtrTable.FieldByName('PlsNum').AsInteger := pValue;
end;

function TTnvBtr.ReadPayType:Str1;
begin
  Result := oBtrTable.FieldByName('PayType').AsString;
end;

procedure TTnvBtr.WritePayType(pValue:Str1);
begin
  oBtrTable.FieldByName('PayType').AsString := pValue;
end;

function TTnvBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TTnvBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TTnvBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TTnvBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TTnvBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TTnvBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TTnvBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TTnvBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TTnvBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TTnvBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TTnvBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TTnvBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TTnvBtr.ReadVisName_:Str20;
begin
  Result := oBtrTable.FieldByName('VisName_').AsString;
end;

procedure TTnvBtr.WriteVisName_(pValue:Str20);
begin
  oBtrTable.FieldByName('VisName_').AsString := pValue;
end;

function TTnvBtr.ReadBirthPlace:Str30;
begin
  Result := oBtrTable.FieldByName('BirthPlace').AsString;
end;

procedure TTnvBtr.WriteBirthPlace(pValue:Str30);
begin
  oBtrTable.FieldByName('BirthPlace').AsString := pValue;
end;

function TTnvBtr.ReadCitizenship:Str30;
begin
  Result := oBtrTable.FieldByName('Citizenship').AsString;
end;

procedure TTnvBtr.WriteCitizenship(pValue:Str30);
begin
  oBtrTable.FieldByName('Citizenship').AsString := pValue;
end;

function TTnvBtr.ReadVisaType:Str50;
begin
  Result := oBtrTable.FieldByName('VisaType').AsString;
end;

procedure TTnvBtr.WriteVisaType(pValue:Str50);
begin
  oBtrTable.FieldByName('VisaType').AsString := pValue;
end;

function TTnvBtr.ReadJourPurpose:Str50;
begin
  Result := oBtrTable.FieldByName('JourPurpose').AsString;
end;

procedure TTnvBtr.WriteJourPurpose(pValue:Str50);
begin
  oBtrTable.FieldByName('JourPurpose').AsString := pValue;
end;

function TTnvBtr.ReadEmptStat:Str1;
begin
  Result := oBtrTable.FieldByName('EmptStat').AsString;
end;

procedure TTnvBtr.WriteEmptStat(pValue:Str1);
begin
  oBtrTable.FieldByName('EmptStat').AsString := pValue;
end;

function TTnvBtr.ReadEmptDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('EmptDate').AsDateTime;
end;

procedure TTnvBtr.WriteEmptDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EmptDate').AsDateTime := pValue;
end;

function TTnvBtr.ReadEmptTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('EmptTime').AsDateTime;
end;

procedure TTnvBtr.WriteEmptTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EmptTime').AsDateTime := pValue;
end;

function TTnvBtr.ReadActPos:longint;
begin
  Result := oBtrTable.FieldByName('ActPos').AsInteger;
end;

procedure TTnvBtr.WriteActPos(pValue:longint);
begin
  oBtrTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTnvBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTnvBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TTnvBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTnvBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TTnvBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TTnvBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TTnvBtr.LocateTentNum (pTentNum:longint):boolean;
begin
  SetIndex (ixTentNum);
  Result := oBtrTable.FindKey([pTentNum]);
end;

function TTnvBtr.LocateTnRn (pTentNum:longint;pRoomNum:longint):boolean;
begin
  SetIndex (ixTnRn);
  Result := oBtrTable.FindKey([pTentNum,pRoomNum]);
end;

function TTnvBtr.LocateTnRnVi (pTentNum:longint;pRoomNum:longint;pVisNum:longint):boolean;
begin
  SetIndex (ixTnRnVi);
  Result := oBtrTable.FindKey([pTentNum,pRoomNum,pVisNum]);
end;

function TTnvBtr.LocateVisName (pVisName_:Str20):boolean;
begin
  SetIndex (ixVisName);
  Result := oBtrTable.FindKey([StrToAlias(pVisName_)]);
end;

function TTnvBtr.LocateStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oBtrTable.FindKey([pStatus]);
end;

function TTnvBtr.NearestTentNum (pTentNum:longint):boolean;
begin
  SetIndex (ixTentNum);
  Result := oBtrTable.FindNearest([pTentNum]);
end;

function TTnvBtr.NearestTnRn (pTentNum:longint;pRoomNum:longint):boolean;
begin
  SetIndex (ixTnRn);
  Result := oBtrTable.FindNearest([pTentNum,pRoomNum]);
end;

function TTnvBtr.NearestTnRnVi (pTentNum:longint;pRoomNum:longint;pVisNum:longint):boolean;
begin
  SetIndex (ixTnRnVi);
  Result := oBtrTable.FindNearest([pTentNum,pRoomNum,pVisNum]);
end;

function TTnvBtr.NearestVisName (pVisName_:Str20):boolean;
begin
  SetIndex (ixVisName);
  Result := oBtrTable.FindNearest([pVisName_]);
end;

function TTnvBtr.NearestStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oBtrTable.FindNearest([pStatus]);
end;

procedure TTnvBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TTnvBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TTnvBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TTnvBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TTnvBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TTnvBtr.First;
begin
  oBtrTable.First;
end;

procedure TTnvBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TTnvBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TTnvBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TTnvBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TTnvBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TTnvBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TTnvBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TTnvBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TTnvBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TTnvBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TTnvBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
