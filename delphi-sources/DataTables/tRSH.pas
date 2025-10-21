unit tRSH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixResNum = '';
  ixGrpDi = 'GrpDi';
  ixStatus = 'Status';
  ixTentNum = 'TentNum';
  ixGroup = 'Group';
  ixMdtCode = 'MdtCode';

type
  TRshTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadResNum:longint;        procedure WriteResNum (pValue:longint);
    function  ReadRoomCnt:longint;       procedure WriteRoomCnt (pValue:longint);
    function  ReadDateI:TDatetime;       procedure WriteDateI (pValue:TDatetime);
    function  ReadDateO:TDatetime;       procedure WriteDateO (pValue:TDatetime);
    function  ReadVisNum:longint;        procedure WriteVisNum (pValue:longint);
    function  ReadGroup:longint;         procedure WriteGroup (pValue:longint);
    function  ReadStatus:Str1;           procedure WriteStatus (pValue:Str1);
    function  ReadRoomVal:double;        procedure WriteRoomVal (pValue:double);
    function  ReadFoodVal:double;        procedure WriteFoodVal (pValue:double);
    function  ReadSrvVal:double;         procedure WriteSrvVal (pValue:double);
    function  ReadImpVal:double;         procedure WriteImpVal (pValue:double);
    function  ReadImpPrc:double;         procedure WriteImpPrc (pValue:double);
    function  ReadExpDate:TDatetime;     procedure WriteExpDate (pValue:TDatetime);
    function  ReadVisName:Str50;         procedure WriteVisName (pValue:Str50);
    function  ReadVisAdress:Str50;       procedure WriteVisAdress (pValue:Str50);
    function  ReadVisCtyName:Str20;      procedure WriteVisCtyName (pValue:Str20);
    function  ReadVisCtyCode:Str4;       procedure WriteVisCtyCode (pValue:Str4);
    function  ReadVisCtyZIP:Str6;        procedure WriteVisCtyZIP (pValue:Str6);
    function  ReadVisStaName:Str20;      procedure WriteVisStaName (pValue:Str20);
    function  ReadVisStaCode:Str4;       procedure WriteVisStaCode (pValue:Str4);
    function  ReadVisType:Str1;          procedure WriteVisType (pValue:Str1);
    function  ReadVisTelNum:Str30;       procedure WriteVisTelNum (pValue:Str30);
    function  ReadVisfaxNum:Str30;       procedure WriteVisfaxNum (pValue:Str30);
    function  ReadVisMobNum:Str30;       procedure WriteVisMobNum (pValue:Str30);
    function  ReadVisEMail:Str30;        procedure WriteVisEMail (pValue:Str30);
    function  ReadPayVal:double;         procedure WritePayVal (pValue:double);
    function  ReadEndVal:double;         procedure WriteEndVal (pValue:double);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadExtNum:Str20;          procedure WriteExtNum (pValue:Str20);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
    function  ReadDvzName:Str3;          procedure WriteDvzName (pValue:Str3);
    function  ReadIncTime:TDatetime;     procedure WriteIncTime (pValue:TDatetime);
    function  ReadTentNum:longint;       procedure WriteTentNum (pValue:longint);
    function  ReadMdtCode:longint;       procedure WriteMdtCode (pValue:longint);
    function  ReadPayCard:Str30;         procedure WritePayCard (pValue:Str30);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateResNum (pResNum:longint):boolean;
    function LocateGrpDi (pGroup:longint;pDateI:TDatetime):boolean;
    function LocateStatus (pStatus:Str1):boolean;
    function LocateTentNum (pTentNum:longint):boolean;
    function LocateGroup (pGroup:longint):boolean;
    function LocateMdtCode (pMdtCode:longint):boolean;

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
    property ResNum:longint read ReadResNum write WriteResNum;
    property RoomCnt:longint read ReadRoomCnt write WriteRoomCnt;
    property DateI:TDatetime read ReadDateI write WriteDateI;
    property DateO:TDatetime read ReadDateO write WriteDateO;
    property VisNum:longint read ReadVisNum write WriteVisNum;
    property Group:longint read ReadGroup write WriteGroup;
    property Status:Str1 read ReadStatus write WriteStatus;
    property RoomVal:double read ReadRoomVal write WriteRoomVal;
    property FoodVal:double read ReadFoodVal write WriteFoodVal;
    property SrvVal:double read ReadSrvVal write WriteSrvVal;
    property ImpVal:double read ReadImpVal write WriteImpVal;
    property ImpPrc:double read ReadImpPrc write WriteImpPrc;
    property ExpDate:TDatetime read ReadExpDate write WriteExpDate;
    property VisName:Str50 read ReadVisName write WriteVisName;
    property VisAdress:Str50 read ReadVisAdress write WriteVisAdress;
    property VisCtyName:Str20 read ReadVisCtyName write WriteVisCtyName;
    property VisCtyCode:Str4 read ReadVisCtyCode write WriteVisCtyCode;
    property VisCtyZIP:Str6 read ReadVisCtyZIP write WriteVisCtyZIP;
    property VisStaName:Str20 read ReadVisStaName write WriteVisStaName;
    property VisStaCode:Str4 read ReadVisStaCode write WriteVisStaCode;
    property VisType:Str1 read ReadVisType write WriteVisType;
    property VisTelNum:Str30 read ReadVisTelNum write WriteVisTelNum;
    property VisfaxNum:Str30 read ReadVisfaxNum write WriteVisfaxNum;
    property VisMobNum:Str30 read ReadVisMobNum write WriteVisMobNum;
    property VisEMail:Str30 read ReadVisEMail write WriteVisEMail;
    property PayVal:double read ReadPayVal write WritePayVal;
    property EndVal:double read ReadEndVal write WriteEndVal;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ExtNum:Str20 read ReadExtNum write WriteExtNum;
    property ActPos:longint read ReadActPos write WriteActPos;
    property DvzName:Str3 read ReadDvzName write WriteDvzName;
    property IncTime:TDatetime read ReadIncTime write WriteIncTime;
    property TentNum:longint read ReadTentNum write WriteTentNum;
    property MdtCode:longint read ReadMdtCode write WriteMdtCode;
    property PayCard:Str30 read ReadPayCard write WritePayCard;
  end;

implementation

constructor TRshTmp.Create;
begin
  oTmpTable := TmpInit ('RSH',Self);
end;

destructor TRshTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TRshTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TRshTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TRshTmp.ReadResNum:longint;
begin
  Result := oTmpTable.FieldByName('ResNum').AsInteger;
end;

procedure TRshTmp.WriteResNum(pValue:longint);
begin
  oTmpTable.FieldByName('ResNum').AsInteger := pValue;
end;

function TRshTmp.ReadRoomCnt:longint;
begin
  Result := oTmpTable.FieldByName('RoomCnt').AsInteger;
end;

procedure TRshTmp.WriteRoomCnt(pValue:longint);
begin
  oTmpTable.FieldByName('RoomCnt').AsInteger := pValue;
end;

function TRshTmp.ReadDateI:TDatetime;
begin
  Result := oTmpTable.FieldByName('DateI').AsDateTime;
end;

procedure TRshTmp.WriteDateI(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DateI').AsDateTime := pValue;
end;

function TRshTmp.ReadDateO:TDatetime;
begin
  Result := oTmpTable.FieldByName('DateO').AsDateTime;
end;

procedure TRshTmp.WriteDateO(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DateO').AsDateTime := pValue;
end;

function TRshTmp.ReadVisNum:longint;
begin
  Result := oTmpTable.FieldByName('VisNum').AsInteger;
end;

procedure TRshTmp.WriteVisNum(pValue:longint);
begin
  oTmpTable.FieldByName('VisNum').AsInteger := pValue;
end;

function TRshTmp.ReadGroup:longint;
begin
  Result := oTmpTable.FieldByName('Group').AsInteger;
end;

procedure TRshTmp.WriteGroup(pValue:longint);
begin
  oTmpTable.FieldByName('Group').AsInteger := pValue;
end;

function TRshTmp.ReadStatus:Str1;
begin
  Result := oTmpTable.FieldByName('Status').AsString;
end;

procedure TRshTmp.WriteStatus(pValue:Str1);
begin
  oTmpTable.FieldByName('Status').AsString := pValue;
end;

function TRshTmp.ReadRoomVal:double;
begin
  Result := oTmpTable.FieldByName('RoomVal').AsFloat;
end;

procedure TRshTmp.WriteRoomVal(pValue:double);
begin
  oTmpTable.FieldByName('RoomVal').AsFloat := pValue;
end;

function TRshTmp.ReadFoodVal:double;
begin
  Result := oTmpTable.FieldByName('FoodVal').AsFloat;
end;

procedure TRshTmp.WriteFoodVal(pValue:double);
begin
  oTmpTable.FieldByName('FoodVal').AsFloat := pValue;
end;

function TRshTmp.ReadSrvVal:double;
begin
  Result := oTmpTable.FieldByName('SrvVal').AsFloat;
end;

procedure TRshTmp.WriteSrvVal(pValue:double);
begin
  oTmpTable.FieldByName('SrvVal').AsFloat := pValue;
end;

function TRshTmp.ReadImpVal:double;
begin
  Result := oTmpTable.FieldByName('ImpVal').AsFloat;
end;

procedure TRshTmp.WriteImpVal(pValue:double);
begin
  oTmpTable.FieldByName('ImpVal').AsFloat := pValue;
end;

function TRshTmp.ReadImpPrc:double;
begin
  Result := oTmpTable.FieldByName('ImpPrc').AsFloat;
end;

procedure TRshTmp.WriteImpPrc(pValue:double);
begin
  oTmpTable.FieldByName('ImpPrc').AsFloat := pValue;
end;

function TRshTmp.ReadExpDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ExpDate').AsDateTime;
end;

procedure TRshTmp.WriteExpDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ExpDate').AsDateTime := pValue;
end;

function TRshTmp.ReadVisName:Str50;
begin
  Result := oTmpTable.FieldByName('VisName').AsString;
end;

procedure TRshTmp.WriteVisName(pValue:Str50);
begin
  oTmpTable.FieldByName('VisName').AsString := pValue;
end;

function TRshTmp.ReadVisAdress:Str50;
begin
  Result := oTmpTable.FieldByName('VisAdress').AsString;
end;

procedure TRshTmp.WriteVisAdress(pValue:Str50);
begin
  oTmpTable.FieldByName('VisAdress').AsString := pValue;
end;

function TRshTmp.ReadVisCtyName:Str20;
begin
  Result := oTmpTable.FieldByName('VisCtyName').AsString;
end;

procedure TRshTmp.WriteVisCtyName(pValue:Str20);
begin
  oTmpTable.FieldByName('VisCtyName').AsString := pValue;
end;

function TRshTmp.ReadVisCtyCode:Str4;
begin
  Result := oTmpTable.FieldByName('VisCtyCode').AsString;
end;

procedure TRshTmp.WriteVisCtyCode(pValue:Str4);
begin
  oTmpTable.FieldByName('VisCtyCode').AsString := pValue;
end;

function TRshTmp.ReadVisCtyZIP:Str6;
begin
  Result := oTmpTable.FieldByName('VisCtyZIP').AsString;
end;

procedure TRshTmp.WriteVisCtyZIP(pValue:Str6);
begin
  oTmpTable.FieldByName('VisCtyZIP').AsString := pValue;
end;

function TRshTmp.ReadVisStaName:Str20;
begin
  Result := oTmpTable.FieldByName('VisStaName').AsString;
end;

procedure TRshTmp.WriteVisStaName(pValue:Str20);
begin
  oTmpTable.FieldByName('VisStaName').AsString := pValue;
end;

function TRshTmp.ReadVisStaCode:Str4;
begin
  Result := oTmpTable.FieldByName('VisStaCode').AsString;
end;

procedure TRshTmp.WriteVisStaCode(pValue:Str4);
begin
  oTmpTable.FieldByName('VisStaCode').AsString := pValue;
end;

function TRshTmp.ReadVisType:Str1;
begin
  Result := oTmpTable.FieldByName('VisType').AsString;
end;

procedure TRshTmp.WriteVisType(pValue:Str1);
begin
  oTmpTable.FieldByName('VisType').AsString := pValue;
end;

function TRshTmp.ReadVisTelNum:Str30;
begin
  Result := oTmpTable.FieldByName('VisTelNum').AsString;
end;

procedure TRshTmp.WriteVisTelNum(pValue:Str30);
begin
  oTmpTable.FieldByName('VisTelNum').AsString := pValue;
end;

function TRshTmp.ReadVisfaxNum:Str30;
begin
  Result := oTmpTable.FieldByName('VisfaxNum').AsString;
end;

procedure TRshTmp.WriteVisfaxNum(pValue:Str30);
begin
  oTmpTable.FieldByName('VisfaxNum').AsString := pValue;
end;

function TRshTmp.ReadVisMobNum:Str30;
begin
  Result := oTmpTable.FieldByName('VisMobNum').AsString;
end;

procedure TRshTmp.WriteVisMobNum(pValue:Str30);
begin
  oTmpTable.FieldByName('VisMobNum').AsString := pValue;
end;

function TRshTmp.ReadVisEMail:Str30;
begin
  Result := oTmpTable.FieldByName('VisEMail').AsString;
end;

procedure TRshTmp.WriteVisEMail(pValue:Str30);
begin
  oTmpTable.FieldByName('VisEMail').AsString := pValue;
end;

function TRshTmp.ReadPayVal:double;
begin
  Result := oTmpTable.FieldByName('PayVal').AsFloat;
end;

procedure TRshTmp.WritePayVal(pValue:double);
begin
  oTmpTable.FieldByName('PayVal').AsFloat := pValue;
end;

function TRshTmp.ReadEndVal:double;
begin
  Result := oTmpTable.FieldByName('EndVal').AsFloat;
end;

procedure TRshTmp.WriteEndVal(pValue:double);
begin
  oTmpTable.FieldByName('EndVal').AsFloat := pValue;
end;

function TRshTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TRshTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TRshTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TRshTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TRshTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TRshTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TRshTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TRshTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TRshTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TRshTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TRshTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TRshTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TRshTmp.ReadExtNum:Str20;
begin
  Result := oTmpTable.FieldByName('ExtNum').AsString;
end;

procedure TRshTmp.WriteExtNum(pValue:Str20);
begin
  oTmpTable.FieldByName('ExtNum').AsString := pValue;
end;

function TRshTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TRshTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

function TRshTmp.ReadDvzName:Str3;
begin
  Result := oTmpTable.FieldByName('DvzName').AsString;
end;

procedure TRshTmp.WriteDvzName(pValue:Str3);
begin
  oTmpTable.FieldByName('DvzName').AsString := pValue;
end;

function TRshTmp.ReadIncTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('IncTime').AsDateTime;
end;

procedure TRshTmp.WriteIncTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('IncTime').AsDateTime := pValue;
end;

function TRshTmp.ReadTentNum:longint;
begin
  Result := oTmpTable.FieldByName('TentNum').AsInteger;
end;

procedure TRshTmp.WriteTentNum(pValue:longint);
begin
  oTmpTable.FieldByName('TentNum').AsInteger := pValue;
end;

function TRshTmp.ReadMdtCode:longint;
begin
  Result := oTmpTable.FieldByName('MdtCode').AsInteger;
end;

procedure TRshTmp.WriteMdtCode(pValue:longint);
begin
  oTmpTable.FieldByName('MdtCode').AsInteger := pValue;
end;

function TRshTmp.ReadPayCard:Str30;
begin
  Result := oTmpTable.FieldByName('PayCard').AsString;
end;

procedure TRshTmp.WritePayCard(pValue:Str30);
begin
  oTmpTable.FieldByName('PayCard').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TRshTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TRshTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TRshTmp.LocateResNum (pResNum:longint):boolean;
begin
  SetIndex (ixResNum);
  Result := oTmpTable.FindKey([pResNum]);
end;

function TRshTmp.LocateGrpDi (pGroup:longint;pDateI:TDatetime):boolean;
begin
  SetIndex (ixGrpDi);
  Result := oTmpTable.FindKey([pGroup,pDateI]);
end;

function TRshTmp.LocateStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oTmpTable.FindKey([pStatus]);
end;

function TRshTmp.LocateTentNum (pTentNum:longint):boolean;
begin
  SetIndex (ixTentNum);
  Result := oTmpTable.FindKey([pTentNum]);
end;

function TRshTmp.LocateGroup (pGroup:longint):boolean;
begin
  SetIndex (ixGroup);
  Result := oTmpTable.FindKey([pGroup]);
end;

function TRshTmp.LocateMdtCode (pMdtCode:longint):boolean;
begin
  SetIndex (ixMdtCode);
  Result := oTmpTable.FindKey([pMdtCode]);
end;

procedure TRshTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TRshTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TRshTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TRshTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TRshTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TRshTmp.First;
begin
  oTmpTable.First;
end;

procedure TRshTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TRshTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TRshTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TRshTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TRshTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TRshTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TRshTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TRshTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TRshTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TRshTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TRshTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1906001}
