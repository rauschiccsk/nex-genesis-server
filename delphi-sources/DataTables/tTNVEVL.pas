unit tTNVEVL;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixViTnRn = '';
  ixVisName = 'VisName';
  ixStatus = 'Status';

type
  TTnvevlTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadVisNum:longint;        procedure WriteVisNum (pValue:longint);
    function  ReadTentNum:longint;       procedure WriteTentNum (pValue:longint);
    function  ReadRoomNum:longint;       procedure WriteRoomNum (pValue:longint);
    function  ReadDateI:TDatetime;       procedure WriteDateI (pValue:TDatetime);
    function  ReadDateO:TDatetime;       procedure WriteDateO (pValue:TDatetime);
    function  ReadGrpPay:Str1;           procedure WriteGrpPay (pValue:Str1);
    function  ReadStatus:Str1;           procedure WriteStatus (pValue:Str1);
    function  ReadVisName:Str50;         procedure WriteVisName (pValue:Str50);
    function  ReadVisName_:Str50;        procedure WriteVisName_ (pValue:Str50);
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
    function  ReadBirthPlace:Str30;      procedure WriteBirthPlace (pValue:Str30);
    function  ReadCitizenship:Str30;     procedure WriteCitizenship (pValue:Str30);
    function  ReadVisaType:Str50;        procedure WriteVisaType (pValue:Str50);
    function  ReadJourPurpose:Str50;     procedure WriteJourPurpose (pValue:Str50);
    function  ReadVisFName:Str20;        procedure WriteVisFName (pValue:Str20);
    function  ReadVisLName:Str30;        procedure WriteVisLName (pValue:Str30);
    function  ReadVisTName:Str15;        procedure WriteVisTName (pValue:Str15);
    function  ReadIdType:Str3;           procedure WriteIdType (pValue:Str3);
    function  ReadIdNum:Str30;           procedure WriteIdNum (pValue:Str30);
    function  ReadPlsNum:longint;        procedure WritePlsNum (pValue:longint);
    function  ReadPayType:Str1;          procedure WritePayType (pValue:Str1);
    function  ReadEmptStat:Str1;         procedure WriteEmptStat (pValue:Str1);
    function  ReadEmptDate:TDatetime;    procedure WriteEmptDate (pValue:TDatetime);
    function  ReadEmptTime:TDatetime;    procedure WriteEmptTime (pValue:TDatetime);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadTentCnt:longint;       procedure WriteTentCnt (pValue:longint);
    function  ReadTentLas:longint;       procedure WriteTentLas (pValue:longint);
    function  ReadDayLas:longint;        procedure WriteDayLas (pValue:longint);
    function  ReadDaySum:longint;        procedure WriteDaySum (pValue:longint);
    function  ReadSrvLas:double;         procedure WriteSrvLas (pValue:double);
    function  ReadSrvSum:double;         procedure WriteSrvSum (pValue:double);
    function  ReadGscLas:double;         procedure WriteGscLas (pValue:double);
    function  ReadGscSum:double;         procedure WriteGscSum (pValue:double);
    function  ReadPayVal:double;         procedure WritePayVal (pValue:double);
    function  ReadNPaVal:double;         procedure WriteNPaVal (pValue:double);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateViTnRn (pVisNum:longint;pTentNum:longint;pRoomNum:longint):boolean;
    function LocateVisName (pVisName_:Str50):boolean;
    function LocateStatus (pStatus:Str1):boolean;

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
    property VisNum:longint read ReadVisNum write WriteVisNum;
    property TentNum:longint read ReadTentNum write WriteTentNum;
    property RoomNum:longint read ReadRoomNum write WriteRoomNum;
    property DateI:TDatetime read ReadDateI write WriteDateI;
    property DateO:TDatetime read ReadDateO write WriteDateO;
    property GrpPay:Str1 read ReadGrpPay write WriteGrpPay;
    property Status:Str1 read ReadStatus write WriteStatus;
    property VisName:Str50 read ReadVisName write WriteVisName;
    property VisName_:Str50 read ReadVisName_ write WriteVisName_;
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
    property BirthPlace:Str30 read ReadBirthPlace write WriteBirthPlace;
    property Citizenship:Str30 read ReadCitizenship write WriteCitizenship;
    property VisaType:Str50 read ReadVisaType write WriteVisaType;
    property JourPurpose:Str50 read ReadJourPurpose write WriteJourPurpose;
    property VisFName:Str20 read ReadVisFName write WriteVisFName;
    property VisLName:Str30 read ReadVisLName write WriteVisLName;
    property VisTName:Str15 read ReadVisTName write WriteVisTName;
    property IdType:Str3 read ReadIdType write WriteIdType;
    property IdNum:Str30 read ReadIdNum write WriteIdNum;
    property PlsNum:longint read ReadPlsNum write WritePlsNum;
    property PayType:Str1 read ReadPayType write WritePayType;
    property EmptStat:Str1 read ReadEmptStat write WriteEmptStat;
    property EmptDate:TDatetime read ReadEmptDate write WriteEmptDate;
    property EmptTime:TDatetime read ReadEmptTime write WriteEmptTime;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property TentCnt:longint read ReadTentCnt write WriteTentCnt;
    property TentLas:longint read ReadTentLas write WriteTentLas;
    property DayLas:longint read ReadDayLas write WriteDayLas;
    property DaySum:longint read ReadDaySum write WriteDaySum;
    property SrvLas:double read ReadSrvLas write WriteSrvLas;
    property SrvSum:double read ReadSrvSum write WriteSrvSum;
    property GscLas:double read ReadGscLas write WriteGscLas;
    property GscSum:double read ReadGscSum write WriteGscSum;
    property PayVal:double read ReadPayVal write WritePayVal;
    property NPaVal:double read ReadNPaVal write WriteNPaVal;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TTnvevlTmp.Create;
begin
  oTmpTable := TmpInit ('TNVEVL',Self);
end;

destructor TTnvevlTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TTnvevlTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TTnvevlTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TTnvevlTmp.ReadVisNum:longint;
begin
  Result := oTmpTable.FieldByName('VisNum').AsInteger;
end;

procedure TTnvevlTmp.WriteVisNum(pValue:longint);
begin
  oTmpTable.FieldByName('VisNum').AsInteger := pValue;
end;

function TTnvevlTmp.ReadTentNum:longint;
begin
  Result := oTmpTable.FieldByName('TentNum').AsInteger;
end;

procedure TTnvevlTmp.WriteTentNum(pValue:longint);
begin
  oTmpTable.FieldByName('TentNum').AsInteger := pValue;
end;

function TTnvevlTmp.ReadRoomNum:longint;
begin
  Result := oTmpTable.FieldByName('RoomNum').AsInteger;
end;

procedure TTnvevlTmp.WriteRoomNum(pValue:longint);
begin
  oTmpTable.FieldByName('RoomNum').AsInteger := pValue;
end;

function TTnvevlTmp.ReadDateI:TDatetime;
begin
  Result := oTmpTable.FieldByName('DateI').AsDateTime;
end;

procedure TTnvevlTmp.WriteDateI(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DateI').AsDateTime := pValue;
end;

function TTnvevlTmp.ReadDateO:TDatetime;
begin
  Result := oTmpTable.FieldByName('DateO').AsDateTime;
end;

procedure TTnvevlTmp.WriteDateO(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DateO').AsDateTime := pValue;
end;

function TTnvevlTmp.ReadGrpPay:Str1;
begin
  Result := oTmpTable.FieldByName('GrpPay').AsString;
end;

procedure TTnvevlTmp.WriteGrpPay(pValue:Str1);
begin
  oTmpTable.FieldByName('GrpPay').AsString := pValue;
end;

function TTnvevlTmp.ReadStatus:Str1;
begin
  Result := oTmpTable.FieldByName('Status').AsString;
end;

procedure TTnvevlTmp.WriteStatus(pValue:Str1);
begin
  oTmpTable.FieldByName('Status').AsString := pValue;
end;

function TTnvevlTmp.ReadVisName:Str50;
begin
  Result := oTmpTable.FieldByName('VisName').AsString;
end;

procedure TTnvevlTmp.WriteVisName(pValue:Str50);
begin
  oTmpTable.FieldByName('VisName').AsString := pValue;
end;

function TTnvevlTmp.ReadVisName_:Str50;
begin
  Result := oTmpTable.FieldByName('VisName_').AsString;
end;

procedure TTnvevlTmp.WriteVisName_(pValue:Str50);
begin
  oTmpTable.FieldByName('VisName_').AsString := pValue;
end;

function TTnvevlTmp.ReadVisAdress:Str50;
begin
  Result := oTmpTable.FieldByName('VisAdress').AsString;
end;

procedure TTnvevlTmp.WriteVisAdress(pValue:Str50);
begin
  oTmpTable.FieldByName('VisAdress').AsString := pValue;
end;

function TTnvevlTmp.ReadVisCtyName:Str20;
begin
  Result := oTmpTable.FieldByName('VisCtyName').AsString;
end;

procedure TTnvevlTmp.WriteVisCtyName(pValue:Str20);
begin
  oTmpTable.FieldByName('VisCtyName').AsString := pValue;
end;

function TTnvevlTmp.ReadVisCtyCode:Str4;
begin
  Result := oTmpTable.FieldByName('VisCtyCode').AsString;
end;

procedure TTnvevlTmp.WriteVisCtyCode(pValue:Str4);
begin
  oTmpTable.FieldByName('VisCtyCode').AsString := pValue;
end;

function TTnvevlTmp.ReadVisCtyZIP:Str6;
begin
  Result := oTmpTable.FieldByName('VisCtyZIP').AsString;
end;

procedure TTnvevlTmp.WriteVisCtyZIP(pValue:Str6);
begin
  oTmpTable.FieldByName('VisCtyZIP').AsString := pValue;
end;

function TTnvevlTmp.ReadVisStaName:Str20;
begin
  Result := oTmpTable.FieldByName('VisStaName').AsString;
end;

procedure TTnvevlTmp.WriteVisStaName(pValue:Str20);
begin
  oTmpTable.FieldByName('VisStaName').AsString := pValue;
end;

function TTnvevlTmp.ReadVisStaCode:Str4;
begin
  Result := oTmpTable.FieldByName('VisStaCode').AsString;
end;

procedure TTnvevlTmp.WriteVisStaCode(pValue:Str4);
begin
  oTmpTable.FieldByName('VisStaCode').AsString := pValue;
end;

function TTnvevlTmp.ReadVisTelNum:Str30;
begin
  Result := oTmpTable.FieldByName('VisTelNum').AsString;
end;

procedure TTnvevlTmp.WriteVisTelNum(pValue:Str30);
begin
  oTmpTable.FieldByName('VisTelNum').AsString := pValue;
end;

function TTnvevlTmp.ReadVisfaxNum:Str30;
begin
  Result := oTmpTable.FieldByName('VisfaxNum').AsString;
end;

procedure TTnvevlTmp.WriteVisfaxNum(pValue:Str30);
begin
  oTmpTable.FieldByName('VisfaxNum').AsString := pValue;
end;

function TTnvevlTmp.ReadVisMobNum:Str30;
begin
  Result := oTmpTable.FieldByName('VisMobNum').AsString;
end;

procedure TTnvevlTmp.WriteVisMobNum(pValue:Str30);
begin
  oTmpTable.FieldByName('VisMobNum').AsString := pValue;
end;

function TTnvevlTmp.ReadVisEMail:Str30;
begin
  Result := oTmpTable.FieldByName('VisEMail').AsString;
end;

procedure TTnvevlTmp.WriteVisEMail(pValue:Str30);
begin
  oTmpTable.FieldByName('VisEMail').AsString := pValue;
end;

function TTnvevlTmp.ReadVisType:Str1;
begin
  Result := oTmpTable.FieldByName('VisType').AsString;
end;

procedure TTnvevlTmp.WriteVisType(pValue:Str1);
begin
  oTmpTable.FieldByName('VisType').AsString := pValue;
end;

function TTnvevlTmp.ReadVisDocType:Str1;
begin
  Result := oTmpTable.FieldByName('VisDocType').AsString;
end;

procedure TTnvevlTmp.WriteVisDocType(pValue:Str1);
begin
  oTmpTable.FieldByName('VisDocType').AsString := pValue;
end;

function TTnvevlTmp.ReadVisDocNum:Str30;
begin
  Result := oTmpTable.FieldByName('VisDocNum').AsString;
end;

procedure TTnvevlTmp.WriteVisDocNum(pValue:Str30);
begin
  oTmpTable.FieldByName('VisDocNum').AsString := pValue;
end;

function TTnvevlTmp.ReadBirthDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('BirthDate').AsDateTime;
end;

procedure TTnvevlTmp.WriteBirthDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('BirthDate').AsDateTime := pValue;
end;

function TTnvevlTmp.ReadBirthPlace:Str30;
begin
  Result := oTmpTable.FieldByName('BirthPlace').AsString;
end;

procedure TTnvevlTmp.WriteBirthPlace(pValue:Str30);
begin
  oTmpTable.FieldByName('BirthPlace').AsString := pValue;
end;

function TTnvevlTmp.ReadCitizenship:Str30;
begin
  Result := oTmpTable.FieldByName('Citizenship').AsString;
end;

procedure TTnvevlTmp.WriteCitizenship(pValue:Str30);
begin
  oTmpTable.FieldByName('Citizenship').AsString := pValue;
end;

function TTnvevlTmp.ReadVisaType:Str50;
begin
  Result := oTmpTable.FieldByName('VisaType').AsString;
end;

procedure TTnvevlTmp.WriteVisaType(pValue:Str50);
begin
  oTmpTable.FieldByName('VisaType').AsString := pValue;
end;

function TTnvevlTmp.ReadJourPurpose:Str50;
begin
  Result := oTmpTable.FieldByName('JourPurpose').AsString;
end;

procedure TTnvevlTmp.WriteJourPurpose(pValue:Str50);
begin
  oTmpTable.FieldByName('JourPurpose').AsString := pValue;
end;

function TTnvevlTmp.ReadVisFName:Str20;
begin
  Result := oTmpTable.FieldByName('VisFName').AsString;
end;

procedure TTnvevlTmp.WriteVisFName(pValue:Str20);
begin
  oTmpTable.FieldByName('VisFName').AsString := pValue;
end;

function TTnvevlTmp.ReadVisLName:Str30;
begin
  Result := oTmpTable.FieldByName('VisLName').AsString;
end;

procedure TTnvevlTmp.WriteVisLName(pValue:Str30);
begin
  oTmpTable.FieldByName('VisLName').AsString := pValue;
end;

function TTnvevlTmp.ReadVisTName:Str15;
begin
  Result := oTmpTable.FieldByName('VisTName').AsString;
end;

procedure TTnvevlTmp.WriteVisTName(pValue:Str15);
begin
  oTmpTable.FieldByName('VisTName').AsString := pValue;
end;

function TTnvevlTmp.ReadIdType:Str3;
begin
  Result := oTmpTable.FieldByName('IdType').AsString;
end;

procedure TTnvevlTmp.WriteIdType(pValue:Str3);
begin
  oTmpTable.FieldByName('IdType').AsString := pValue;
end;

function TTnvevlTmp.ReadIdNum:Str30;
begin
  Result := oTmpTable.FieldByName('IdNum').AsString;
end;

procedure TTnvevlTmp.WriteIdNum(pValue:Str30);
begin
  oTmpTable.FieldByName('IdNum').AsString := pValue;
end;

function TTnvevlTmp.ReadPlsNum:longint;
begin
  Result := oTmpTable.FieldByName('PlsNum').AsInteger;
end;

procedure TTnvevlTmp.WritePlsNum(pValue:longint);
begin
  oTmpTable.FieldByName('PlsNum').AsInteger := pValue;
end;

function TTnvevlTmp.ReadPayType:Str1;
begin
  Result := oTmpTable.FieldByName('PayType').AsString;
end;

procedure TTnvevlTmp.WritePayType(pValue:Str1);
begin
  oTmpTable.FieldByName('PayType').AsString := pValue;
end;

function TTnvevlTmp.ReadEmptStat:Str1;
begin
  Result := oTmpTable.FieldByName('EmptStat').AsString;
end;

procedure TTnvevlTmp.WriteEmptStat(pValue:Str1);
begin
  oTmpTable.FieldByName('EmptStat').AsString := pValue;
end;

function TTnvevlTmp.ReadEmptDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('EmptDate').AsDateTime;
end;

procedure TTnvevlTmp.WriteEmptDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('EmptDate').AsDateTime := pValue;
end;

function TTnvevlTmp.ReadEmptTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('EmptTime').AsDateTime;
end;

procedure TTnvevlTmp.WriteEmptTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('EmptTime').AsDateTime := pValue;
end;

function TTnvevlTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TTnvevlTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TTnvevlTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TTnvevlTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TTnvevlTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TTnvevlTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TTnvevlTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TTnvevlTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TTnvevlTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TTnvevlTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TTnvevlTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TTnvevlTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TTnvevlTmp.ReadTentCnt:longint;
begin
  Result := oTmpTable.FieldByName('TentCnt').AsInteger;
end;

procedure TTnvevlTmp.WriteTentCnt(pValue:longint);
begin
  oTmpTable.FieldByName('TentCnt').AsInteger := pValue;
end;

function TTnvevlTmp.ReadTentLas:longint;
begin
  Result := oTmpTable.FieldByName('TentLas').AsInteger;
end;

procedure TTnvevlTmp.WriteTentLas(pValue:longint);
begin
  oTmpTable.FieldByName('TentLas').AsInteger := pValue;
end;

function TTnvevlTmp.ReadDayLas:longint;
begin
  Result := oTmpTable.FieldByName('DayLas').AsInteger;
end;

procedure TTnvevlTmp.WriteDayLas(pValue:longint);
begin
  oTmpTable.FieldByName('DayLas').AsInteger := pValue;
end;

function TTnvevlTmp.ReadDaySum:longint;
begin
  Result := oTmpTable.FieldByName('DaySum').AsInteger;
end;

procedure TTnvevlTmp.WriteDaySum(pValue:longint);
begin
  oTmpTable.FieldByName('DaySum').AsInteger := pValue;
end;

function TTnvevlTmp.ReadSrvLas:double;
begin
  Result := oTmpTable.FieldByName('SrvLas').AsFloat;
end;

procedure TTnvevlTmp.WriteSrvLas(pValue:double);
begin
  oTmpTable.FieldByName('SrvLas').AsFloat := pValue;
end;

function TTnvevlTmp.ReadSrvSum:double;
begin
  Result := oTmpTable.FieldByName('SrvSum').AsFloat;
end;

procedure TTnvevlTmp.WriteSrvSum(pValue:double);
begin
  oTmpTable.FieldByName('SrvSum').AsFloat := pValue;
end;

function TTnvevlTmp.ReadGscLas:double;
begin
  Result := oTmpTable.FieldByName('GscLas').AsFloat;
end;

procedure TTnvevlTmp.WriteGscLas(pValue:double);
begin
  oTmpTable.FieldByName('GscLas').AsFloat := pValue;
end;

function TTnvevlTmp.ReadGscSum:double;
begin
  Result := oTmpTable.FieldByName('GscSum').AsFloat;
end;

procedure TTnvevlTmp.WriteGscSum(pValue:double);
begin
  oTmpTable.FieldByName('GscSum').AsFloat := pValue;
end;

function TTnvevlTmp.ReadPayVal:double;
begin
  Result := oTmpTable.FieldByName('PayVal').AsFloat;
end;

procedure TTnvevlTmp.WritePayVal(pValue:double);
begin
  oTmpTable.FieldByName('PayVal').AsFloat := pValue;
end;

function TTnvevlTmp.ReadNPaVal:double;
begin
  Result := oTmpTable.FieldByName('NPaVal').AsFloat;
end;

procedure TTnvevlTmp.WriteNPaVal(pValue:double);
begin
  oTmpTable.FieldByName('NPaVal').AsFloat := pValue;
end;

function TTnvevlTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TTnvevlTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTnvevlTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TTnvevlTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TTnvevlTmp.LocateViTnRn (pVisNum:longint;pTentNum:longint;pRoomNum:longint):boolean;
begin
  SetIndex (ixViTnRn);
  Result := oTmpTable.FindKey([pVisNum,pTentNum,pRoomNum]);
end;

function TTnvevlTmp.LocateVisName (pVisName_:Str50):boolean;
begin
  SetIndex (ixVisName);
  Result := oTmpTable.FindKey([pVisName_]);
end;

function TTnvevlTmp.LocateStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oTmpTable.FindKey([pStatus]);
end;

procedure TTnvevlTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TTnvevlTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TTnvevlTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TTnvevlTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TTnvevlTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TTnvevlTmp.First;
begin
  oTmpTable.First;
end;

procedure TTnvevlTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TTnvevlTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TTnvevlTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TTnvevlTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TTnvevlTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TTnvevlTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TTnvevlTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TTnvevlTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TTnvevlTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TTnvevlTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TTnvevlTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1905027}
