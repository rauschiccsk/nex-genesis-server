unit tTNV;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixTnRnVi = '';
  ixTentNum = 'TentNum';
  ixTnRn = 'TnRn';
  ixVisName = 'VisName';
  ixStatus = 'Status';

type
  TTnvTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
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
    function  ReadVisFName:Str20;        procedure WriteVisFName (pValue:Str20);
    function  ReadVisLName:Str30;        procedure WriteVisLName (pValue:Str30);
    function  ReadVisTName:Str15;        procedure WriteVisTName (pValue:Str15);
    function  ReadEmptStat:Str1;         procedure WriteEmptStat (pValue:Str1);
    function  ReadEmptDate:TDatetime;    procedure WriteEmptDate (pValue:TDatetime);
    function  ReadEmptTime:TDatetime;    procedure WriteEmptTime (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
    function  ReadRoomCode:Str15;        procedure WriteRoomCode (pValue:Str15);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateTnRnVi (pTentNum:longint;pRoomNum:longint;pVisNum:longint):boolean;
    function LocateTentNum (pTentNum:longint):boolean;
    function LocateTnRn (pTentNum:longint;pRoomNum:longint):boolean;
    function LocateVisName (pVisName_:Str20):boolean;
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
    property VisFName:Str20 read ReadVisFName write WriteVisFName;
    property VisLName:Str30 read ReadVisLName write WriteVisLName;
    property VisTName:Str15 read ReadVisTName write WriteVisTName;
    property EmptStat:Str1 read ReadEmptStat write WriteEmptStat;
    property EmptDate:TDatetime read ReadEmptDate write WriteEmptDate;
    property EmptTime:TDatetime read ReadEmptTime write WriteEmptTime;
    property ActPos:longint read ReadActPos write WriteActPos;
    property RoomCode:Str15 read ReadRoomCode write WriteRoomCode;
  end;

implementation

constructor TTnvTmp.Create;
begin
  oTmpTable := TmpInit ('TNV',Self);
end;

destructor TTnvTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TTnvTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TTnvTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TTnvTmp.ReadTentNum:longint;
begin
  Result := oTmpTable.FieldByName('TentNum').AsInteger;
end;

procedure TTnvTmp.WriteTentNum(pValue:longint);
begin
  oTmpTable.FieldByName('TentNum').AsInteger := pValue;
end;

function TTnvTmp.ReadRoomNum:longint;
begin
  Result := oTmpTable.FieldByName('RoomNum').AsInteger;
end;

procedure TTnvTmp.WriteRoomNum(pValue:longint);
begin
  oTmpTable.FieldByName('RoomNum').AsInteger := pValue;
end;

function TTnvTmp.ReadVisNum:longint;
begin
  Result := oTmpTable.FieldByName('VisNum').AsInteger;
end;

procedure TTnvTmp.WriteVisNum(pValue:longint);
begin
  oTmpTable.FieldByName('VisNum').AsInteger := pValue;
end;

function TTnvTmp.ReadDateI:TDatetime;
begin
  Result := oTmpTable.FieldByName('DateI').AsDateTime;
end;

procedure TTnvTmp.WriteDateI(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DateI').AsDateTime := pValue;
end;

function TTnvTmp.ReadDateO:TDatetime;
begin
  Result := oTmpTable.FieldByName('DateO').AsDateTime;
end;

procedure TTnvTmp.WriteDateO(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DateO').AsDateTime := pValue;
end;

function TTnvTmp.ReadGrpPay:Str1;
begin
  Result := oTmpTable.FieldByName('GrpPay').AsString;
end;

procedure TTnvTmp.WriteGrpPay(pValue:Str1);
begin
  oTmpTable.FieldByName('GrpPay').AsString := pValue;
end;

function TTnvTmp.ReadStatus:Str1;
begin
  Result := oTmpTable.FieldByName('Status').AsString;
end;

procedure TTnvTmp.WriteStatus(pValue:Str1);
begin
  oTmpTable.FieldByName('Status').AsString := pValue;
end;

function TTnvTmp.ReadVisName:Str50;
begin
  Result := oTmpTable.FieldByName('VisName').AsString;
end;

procedure TTnvTmp.WriteVisName(pValue:Str50);
begin
  oTmpTable.FieldByName('VisName').AsString := pValue;
end;

function TTnvTmp.ReadVisAdress:Str50;
begin
  Result := oTmpTable.FieldByName('VisAdress').AsString;
end;

procedure TTnvTmp.WriteVisAdress(pValue:Str50);
begin
  oTmpTable.FieldByName('VisAdress').AsString := pValue;
end;

function TTnvTmp.ReadVisCtyName:Str20;
begin
  Result := oTmpTable.FieldByName('VisCtyName').AsString;
end;

procedure TTnvTmp.WriteVisCtyName(pValue:Str20);
begin
  oTmpTable.FieldByName('VisCtyName').AsString := pValue;
end;

function TTnvTmp.ReadVisCtyCode:Str4;
begin
  Result := oTmpTable.FieldByName('VisCtyCode').AsString;
end;

procedure TTnvTmp.WriteVisCtyCode(pValue:Str4);
begin
  oTmpTable.FieldByName('VisCtyCode').AsString := pValue;
end;

function TTnvTmp.ReadVisCtyZIP:Str6;
begin
  Result := oTmpTable.FieldByName('VisCtyZIP').AsString;
end;

procedure TTnvTmp.WriteVisCtyZIP(pValue:Str6);
begin
  oTmpTable.FieldByName('VisCtyZIP').AsString := pValue;
end;

function TTnvTmp.ReadVisStaName:Str20;
begin
  Result := oTmpTable.FieldByName('VisStaName').AsString;
end;

procedure TTnvTmp.WriteVisStaName(pValue:Str20);
begin
  oTmpTable.FieldByName('VisStaName').AsString := pValue;
end;

function TTnvTmp.ReadVisStaCode:Str4;
begin
  Result := oTmpTable.FieldByName('VisStaCode').AsString;
end;

procedure TTnvTmp.WriteVisStaCode(pValue:Str4);
begin
  oTmpTable.FieldByName('VisStaCode').AsString := pValue;
end;

function TTnvTmp.ReadVisTelNum:Str30;
begin
  Result := oTmpTable.FieldByName('VisTelNum').AsString;
end;

procedure TTnvTmp.WriteVisTelNum(pValue:Str30);
begin
  oTmpTable.FieldByName('VisTelNum').AsString := pValue;
end;

function TTnvTmp.ReadVisfaxNum:Str30;
begin
  Result := oTmpTable.FieldByName('VisfaxNum').AsString;
end;

procedure TTnvTmp.WriteVisfaxNum(pValue:Str30);
begin
  oTmpTable.FieldByName('VisfaxNum').AsString := pValue;
end;

function TTnvTmp.ReadVisMobNum:Str30;
begin
  Result := oTmpTable.FieldByName('VisMobNum').AsString;
end;

procedure TTnvTmp.WriteVisMobNum(pValue:Str30);
begin
  oTmpTable.FieldByName('VisMobNum').AsString := pValue;
end;

function TTnvTmp.ReadVisEMail:Str30;
begin
  Result := oTmpTable.FieldByName('VisEMail').AsString;
end;

procedure TTnvTmp.WriteVisEMail(pValue:Str30);
begin
  oTmpTable.FieldByName('VisEMail').AsString := pValue;
end;

function TTnvTmp.ReadVisType:Str1;
begin
  Result := oTmpTable.FieldByName('VisType').AsString;
end;

procedure TTnvTmp.WriteVisType(pValue:Str1);
begin
  oTmpTable.FieldByName('VisType').AsString := pValue;
end;

function TTnvTmp.ReadVisDocType:Str1;
begin
  Result := oTmpTable.FieldByName('VisDocType').AsString;
end;

procedure TTnvTmp.WriteVisDocType(pValue:Str1);
begin
  oTmpTable.FieldByName('VisDocType').AsString := pValue;
end;

function TTnvTmp.ReadVisDocNum:Str30;
begin
  Result := oTmpTable.FieldByName('VisDocNum').AsString;
end;

procedure TTnvTmp.WriteVisDocNum(pValue:Str30);
begin
  oTmpTable.FieldByName('VisDocNum').AsString := pValue;
end;

function TTnvTmp.ReadBirthDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('BirthDate').AsDateTime;
end;

procedure TTnvTmp.WriteBirthDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('BirthDate').AsDateTime := pValue;
end;

function TTnvTmp.ReadPayment1:Str1;
begin
  Result := oTmpTable.FieldByName('Payment1').AsString;
end;

procedure TTnvTmp.WritePayment1(pValue:Str1);
begin
  oTmpTable.FieldByName('Payment1').AsString := pValue;
end;

function TTnvTmp.ReadPayment2:Str1;
begin
  Result := oTmpTable.FieldByName('Payment2').AsString;
end;

procedure TTnvTmp.WritePayment2(pValue:Str1);
begin
  oTmpTable.FieldByName('Payment2').AsString := pValue;
end;

function TTnvTmp.ReadPayment3:Str1;
begin
  Result := oTmpTable.FieldByName('Payment3').AsString;
end;

procedure TTnvTmp.WritePayment3(pValue:Str1);
begin
  oTmpTable.FieldByName('Payment3').AsString := pValue;
end;

function TTnvTmp.ReadPayment4:Str1;
begin
  Result := oTmpTable.FieldByName('Payment4').AsString;
end;

procedure TTnvTmp.WritePayment4(pValue:Str1);
begin
  oTmpTable.FieldByName('Payment4').AsString := pValue;
end;

function TTnvTmp.ReadPayment5:Str1;
begin
  Result := oTmpTable.FieldByName('Payment5').AsString;
end;

procedure TTnvTmp.WritePayment5(pValue:Str1);
begin
  oTmpTable.FieldByName('Payment5').AsString := pValue;
end;

function TTnvTmp.ReadIdType:Str3;
begin
  Result := oTmpTable.FieldByName('IdType').AsString;
end;

procedure TTnvTmp.WriteIdType(pValue:Str3);
begin
  oTmpTable.FieldByName('IdType').AsString := pValue;
end;

function TTnvTmp.ReadIdNum:Str30;
begin
  Result := oTmpTable.FieldByName('IdNum').AsString;
end;

procedure TTnvTmp.WriteIdNum(pValue:Str30);
begin
  oTmpTable.FieldByName('IdNum').AsString := pValue;
end;

function TTnvTmp.ReadPlsNum:longint;
begin
  Result := oTmpTable.FieldByName('PlsNum').AsInteger;
end;

procedure TTnvTmp.WritePlsNum(pValue:longint);
begin
  oTmpTable.FieldByName('PlsNum').AsInteger := pValue;
end;

function TTnvTmp.ReadPayType:Str1;
begin
  Result := oTmpTable.FieldByName('PayType').AsString;
end;

procedure TTnvTmp.WritePayType(pValue:Str1);
begin
  oTmpTable.FieldByName('PayType').AsString := pValue;
end;

function TTnvTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TTnvTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TTnvTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TTnvTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TTnvTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TTnvTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TTnvTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TTnvTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TTnvTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TTnvTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TTnvTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TTnvTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TTnvTmp.ReadVisName_:Str20;
begin
  Result := oTmpTable.FieldByName('VisName_').AsString;
end;

procedure TTnvTmp.WriteVisName_(pValue:Str20);
begin
  oTmpTable.FieldByName('VisName_').AsString := pValue;
end;

function TTnvTmp.ReadBirthPlace:Str30;
begin
  Result := oTmpTable.FieldByName('BirthPlace').AsString;
end;

procedure TTnvTmp.WriteBirthPlace(pValue:Str30);
begin
  oTmpTable.FieldByName('BirthPlace').AsString := pValue;
end;

function TTnvTmp.ReadCitizenship:Str30;
begin
  Result := oTmpTable.FieldByName('Citizenship').AsString;
end;

procedure TTnvTmp.WriteCitizenship(pValue:Str30);
begin
  oTmpTable.FieldByName('Citizenship').AsString := pValue;
end;

function TTnvTmp.ReadVisaType:Str50;
begin
  Result := oTmpTable.FieldByName('VisaType').AsString;
end;

procedure TTnvTmp.WriteVisaType(pValue:Str50);
begin
  oTmpTable.FieldByName('VisaType').AsString := pValue;
end;

function TTnvTmp.ReadJourPurpose:Str50;
begin
  Result := oTmpTable.FieldByName('JourPurpose').AsString;
end;

procedure TTnvTmp.WriteJourPurpose(pValue:Str50);
begin
  oTmpTable.FieldByName('JourPurpose').AsString := pValue;
end;

function TTnvTmp.ReadVisFName:Str20;
begin
  Result := oTmpTable.FieldByName('VisFName').AsString;
end;

procedure TTnvTmp.WriteVisFName(pValue:Str20);
begin
  oTmpTable.FieldByName('VisFName').AsString := pValue;
end;

function TTnvTmp.ReadVisLName:Str30;
begin
  Result := oTmpTable.FieldByName('VisLName').AsString;
end;

procedure TTnvTmp.WriteVisLName(pValue:Str30);
begin
  oTmpTable.FieldByName('VisLName').AsString := pValue;
end;

function TTnvTmp.ReadVisTName:Str15;
begin
  Result := oTmpTable.FieldByName('VisTName').AsString;
end;

procedure TTnvTmp.WriteVisTName(pValue:Str15);
begin
  oTmpTable.FieldByName('VisTName').AsString := pValue;
end;

function TTnvTmp.ReadEmptStat:Str1;
begin
  Result := oTmpTable.FieldByName('EmptStat').AsString;
end;

procedure TTnvTmp.WriteEmptStat(pValue:Str1);
begin
  oTmpTable.FieldByName('EmptStat').AsString := pValue;
end;

function TTnvTmp.ReadEmptDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('EmptDate').AsDateTime;
end;

procedure TTnvTmp.WriteEmptDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('EmptDate').AsDateTime := pValue;
end;

function TTnvTmp.ReadEmptTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('EmptTime').AsDateTime;
end;

procedure TTnvTmp.WriteEmptTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('EmptTime').AsDateTime := pValue;
end;

function TTnvTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TTnvTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

function TTnvTmp.ReadRoomCode:Str15;
begin
  Result := oTmpTable.FieldByName('RoomCode').AsString;
end;

procedure TTnvTmp.WriteRoomCode(pValue:Str15);
begin
  oTmpTable.FieldByName('RoomCode').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTnvTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TTnvTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TTnvTmp.LocateTnRnVi (pTentNum:longint;pRoomNum:longint;pVisNum:longint):boolean;
begin
  SetIndex (ixTnRnVi);
  Result := oTmpTable.FindKey([pTentNum,pRoomNum,pVisNum]);
end;

function TTnvTmp.LocateTentNum (pTentNum:longint):boolean;
begin
  SetIndex (ixTentNum);
  Result := oTmpTable.FindKey([pTentNum]);
end;

function TTnvTmp.LocateTnRn (pTentNum:longint;pRoomNum:longint):boolean;
begin
  SetIndex (ixTnRn);
  Result := oTmpTable.FindKey([pTentNum,pRoomNum]);
end;

function TTnvTmp.LocateVisName (pVisName_:Str20):boolean;
begin
  SetIndex (ixVisName);
  Result := oTmpTable.FindKey([pVisName_]);
end;

function TTnvTmp.LocateStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oTmpTable.FindKey([pStatus]);
end;

procedure TTnvTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TTnvTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TTnvTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TTnvTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TTnvTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TTnvTmp.First;
begin
  oTmpTable.First;
end;

procedure TTnvTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TTnvTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TTnvTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TTnvTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TTnvTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TTnvTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TTnvTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TTnvTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TTnvTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TTnvTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TTnvTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
