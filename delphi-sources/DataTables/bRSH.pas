unit bRSH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixResNum = 'ResNum';
  ixGrpDi = 'GrpDi';
  ixStatus = 'Status';
  ixTentNum = 'TentNum';
  ixGroup = 'Group';
  ixMdtCode = 'MdtCode';

type
  TRshBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
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
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateResNum (pResNum:longint):boolean;
    function LocateGrpDi (pGroup:longint;pDateI:TDatetime):boolean;
    function LocateStatus (pStatus:Str1):boolean;
    function LocateTentNum (pTentNum:longint):boolean;
    function LocateGroup (pGroup:longint):boolean;
    function LocateMdtCode (pMdtCode:longint):boolean;
    function NearestResNum (pResNum:longint):boolean;
    function NearestGrpDi (pGroup:longint;pDateI:TDatetime):boolean;
    function NearestStatus (pStatus:Str1):boolean;
    function NearestTentNum (pTentNum:longint):boolean;
    function NearestGroup (pGroup:longint):boolean;
    function NearestMdtCode (pMdtCode:longint):boolean;

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
    property ActPosM:longint read ReadActPos write WriteActPos;
    property DvzName:Str3 read ReadDvzName write WriteDvzName;
    property IncTime:TDatetime read ReadIncTime write WriteIncTime;
    property TentNum:longint read ReadTentNum write WriteTentNum;
    property MdtCode:longint read ReadMdtCode write WriteMdtCode;
    property PayCard:Str30 read ReadPayCard write WritePayCard;
  end;

implementation

constructor TRshBtr.Create;
begin
  oBtrTable := BtrInit ('RSH',gPath.HtlPath,Self);
end;

constructor TRshBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('RSH',pPath,Self);
end;

destructor TRshBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TRshBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TRshBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TRshBtr.ReadResNum:longint;
begin
  Result := oBtrTable.FieldByName('ResNum').AsInteger;
end;

procedure TRshBtr.WriteResNum(pValue:longint);
begin
  oBtrTable.FieldByName('ResNum').AsInteger := pValue;
end;

function TRshBtr.ReadRoomCnt:longint;
begin
  Result := oBtrTable.FieldByName('RoomCnt').AsInteger;
end;

procedure TRshBtr.WriteRoomCnt(pValue:longint);
begin
  oBtrTable.FieldByName('RoomCnt').AsInteger := pValue;
end;

function TRshBtr.ReadDateI:TDatetime;
begin
  Result := oBtrTable.FieldByName('DateI').AsDateTime;
end;

procedure TRshBtr.WriteDateI(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DateI').AsDateTime := pValue;
end;

function TRshBtr.ReadDateO:TDatetime;
begin
  Result := oBtrTable.FieldByName('DateO').AsDateTime;
end;

procedure TRshBtr.WriteDateO(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DateO').AsDateTime := pValue;
end;

function TRshBtr.ReadVisNum:longint;
begin
  Result := oBtrTable.FieldByName('VisNum').AsInteger;
end;

procedure TRshBtr.WriteVisNum(pValue:longint);
begin
  oBtrTable.FieldByName('VisNum').AsInteger := pValue;
end;

function TRshBtr.ReadGroup:longint;
begin
  Result := oBtrTable.FieldByName('Group').AsInteger;
end;

procedure TRshBtr.WriteGroup(pValue:longint);
begin
  oBtrTable.FieldByName('Group').AsInteger := pValue;
end;

function TRshBtr.ReadStatus:Str1;
begin
  Result := oBtrTable.FieldByName('Status').AsString;
end;

procedure TRshBtr.WriteStatus(pValue:Str1);
begin
  oBtrTable.FieldByName('Status').AsString := pValue;
end;

function TRshBtr.ReadRoomVal:double;
begin
  Result := oBtrTable.FieldByName('RoomVal').AsFloat;
end;

procedure TRshBtr.WriteRoomVal(pValue:double);
begin
  oBtrTable.FieldByName('RoomVal').AsFloat := pValue;
end;

function TRshBtr.ReadFoodVal:double;
begin
  Result := oBtrTable.FieldByName('FoodVal').AsFloat;
end;

procedure TRshBtr.WriteFoodVal(pValue:double);
begin
  oBtrTable.FieldByName('FoodVal').AsFloat := pValue;
end;

function TRshBtr.ReadSrvVal:double;
begin
  Result := oBtrTable.FieldByName('SrvVal').AsFloat;
end;

procedure TRshBtr.WriteSrvVal(pValue:double);
begin
  oBtrTable.FieldByName('SrvVal').AsFloat := pValue;
end;

function TRshBtr.ReadImpVal:double;
begin
  Result := oBtrTable.FieldByName('ImpVal').AsFloat;
end;

procedure TRshBtr.WriteImpVal(pValue:double);
begin
  oBtrTable.FieldByName('ImpVal').AsFloat := pValue;
end;

function TRshBtr.ReadImpPrc:double;
begin
  Result := oBtrTable.FieldByName('ImpPrc').AsFloat;
end;

procedure TRshBtr.WriteImpPrc(pValue:double);
begin
  oBtrTable.FieldByName('ImpPrc').AsFloat := pValue;
end;

function TRshBtr.ReadExpDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ExpDate').AsDateTime;
end;

procedure TRshBtr.WriteExpDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ExpDate').AsDateTime := pValue;
end;

function TRshBtr.ReadVisName:Str50;
begin
  Result := oBtrTable.FieldByName('VisName').AsString;
end;

procedure TRshBtr.WriteVisName(pValue:Str50);
begin
  oBtrTable.FieldByName('VisName').AsString := pValue;
end;

function TRshBtr.ReadVisAdress:Str50;
begin
  Result := oBtrTable.FieldByName('VisAdress').AsString;
end;

procedure TRshBtr.WriteVisAdress(pValue:Str50);
begin
  oBtrTable.FieldByName('VisAdress').AsString := pValue;
end;

function TRshBtr.ReadVisCtyName:Str20;
begin
  Result := oBtrTable.FieldByName('VisCtyName').AsString;
end;

procedure TRshBtr.WriteVisCtyName(pValue:Str20);
begin
  oBtrTable.FieldByName('VisCtyName').AsString := pValue;
end;

function TRshBtr.ReadVisCtyCode:Str4;
begin
  Result := oBtrTable.FieldByName('VisCtyCode').AsString;
end;

procedure TRshBtr.WriteVisCtyCode(pValue:Str4);
begin
  oBtrTable.FieldByName('VisCtyCode').AsString := pValue;
end;

function TRshBtr.ReadVisCtyZIP:Str6;
begin
  Result := oBtrTable.FieldByName('VisCtyZIP').AsString;
end;

procedure TRshBtr.WriteVisCtyZIP(pValue:Str6);
begin
  oBtrTable.FieldByName('VisCtyZIP').AsString := pValue;
end;

function TRshBtr.ReadVisStaName:Str20;
begin
  Result := oBtrTable.FieldByName('VisStaName').AsString;
end;

procedure TRshBtr.WriteVisStaName(pValue:Str20);
begin
  oBtrTable.FieldByName('VisStaName').AsString := pValue;
end;

function TRshBtr.ReadVisStaCode:Str4;
begin
  Result := oBtrTable.FieldByName('VisStaCode').AsString;
end;

procedure TRshBtr.WriteVisStaCode(pValue:Str4);
begin
  oBtrTable.FieldByName('VisStaCode').AsString := pValue;
end;

function TRshBtr.ReadVisType:Str1;
begin
  Result := oBtrTable.FieldByName('VisType').AsString;
end;

procedure TRshBtr.WriteVisType(pValue:Str1);
begin
  oBtrTable.FieldByName('VisType').AsString := pValue;
end;

function TRshBtr.ReadVisTelNum:Str30;
begin
  Result := oBtrTable.FieldByName('VisTelNum').AsString;
end;

procedure TRshBtr.WriteVisTelNum(pValue:Str30);
begin
  oBtrTable.FieldByName('VisTelNum').AsString := pValue;
end;

function TRshBtr.ReadVisfaxNum:Str30;
begin
  Result := oBtrTable.FieldByName('VisfaxNum').AsString;
end;

procedure TRshBtr.WriteVisfaxNum(pValue:Str30);
begin
  oBtrTable.FieldByName('VisfaxNum').AsString := pValue;
end;

function TRshBtr.ReadVisMobNum:Str30;
begin
  Result := oBtrTable.FieldByName('VisMobNum').AsString;
end;

procedure TRshBtr.WriteVisMobNum(pValue:Str30);
begin
  oBtrTable.FieldByName('VisMobNum').AsString := pValue;
end;

function TRshBtr.ReadVisEMail:Str30;
begin
  Result := oBtrTable.FieldByName('VisEMail').AsString;
end;

procedure TRshBtr.WriteVisEMail(pValue:Str30);
begin
  oBtrTable.FieldByName('VisEMail').AsString := pValue;
end;

function TRshBtr.ReadPayVal:double;
begin
  Result := oBtrTable.FieldByName('PayVal').AsFloat;
end;

procedure TRshBtr.WritePayVal(pValue:double);
begin
  oBtrTable.FieldByName('PayVal').AsFloat := pValue;
end;

function TRshBtr.ReadEndVal:double;
begin
  Result := oBtrTable.FieldByName('EndVal').AsFloat;
end;

procedure TRshBtr.WriteEndVal(pValue:double);
begin
  oBtrTable.FieldByName('EndVal').AsFloat := pValue;
end;

function TRshBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TRshBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TRshBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TRshBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TRshBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TRshBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TRshBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TRshBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TRshBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TRshBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TRshBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TRshBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TRshBtr.ReadExtNum:Str20;
begin
  Result := oBtrTable.FieldByName('ExtNum').AsString;
end;

procedure TRshBtr.WriteExtNum(pValue:Str20);
begin
  oBtrTable.FieldByName('ExtNum').AsString := pValue;
end;

function TRshBtr.ReadActPos:longint;
begin
  Result := oBtrTable.FieldByName('ActPos').AsInteger;
end;

procedure TRshBtr.WriteActPos(pValue:longint);
begin
  oBtrTable.FieldByName('ActPos').AsInteger := pValue;
end;

function TRshBtr.ReadDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('DvzName').AsString;
end;

procedure TRshBtr.WriteDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('DvzName').AsString := pValue;
end;

function TRshBtr.ReadIncTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('IncTime').AsDateTime;
end;

procedure TRshBtr.WriteIncTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('IncTime').AsDateTime := pValue;
end;

function TRshBtr.ReadTentNum:longint;
begin
  Result := oBtrTable.FieldByName('TentNum').AsInteger;
end;

procedure TRshBtr.WriteTentNum(pValue:longint);
begin
  oBtrTable.FieldByName('TentNum').AsInteger := pValue;
end;

function TRshBtr.ReadMdtCode:longint;
begin
  Result := oBtrTable.FieldByName('MdtCode').AsInteger;
end;

procedure TRshBtr.WriteMdtCode(pValue:longint);
begin
  oBtrTable.FieldByName('MdtCode').AsInteger := pValue;
end;

function TRshBtr.ReadPayCard:Str30;
begin
  Result := oBtrTable.FieldByName('PayCard').AsString;
end;

procedure TRshBtr.WritePayCard(pValue:Str30);
begin
  oBtrTable.FieldByName('PayCard').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TRshBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TRshBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TRshBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TRshBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TRshBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TRshBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TRshBtr.LocateResNum (pResNum:longint):boolean;
begin
  SetIndex (ixResNum);
  Result := oBtrTable.FindKey([pResNum]);
end;

function TRshBtr.LocateGrpDi (pGroup:longint;pDateI:TDatetime):boolean;
begin
  SetIndex (ixGrpDi);
  Result := oBtrTable.FindKey([pGroup,pDateI]);
end;

function TRshBtr.LocateStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oBtrTable.FindKey([pStatus]);
end;

function TRshBtr.LocateTentNum (pTentNum:longint):boolean;
begin
  SetIndex (ixTentNum);
  Result := oBtrTable.FindKey([pTentNum]);
end;

function TRshBtr.LocateGroup (pGroup:longint):boolean;
begin
  SetIndex (ixGroup);
  Result := oBtrTable.FindKey([pGroup]);
end;

function TRshBtr.LocateMdtCode (pMdtCode:longint):boolean;
begin
  SetIndex (ixMdtCode);
  Result := oBtrTable.FindKey([pMdtCode]);
end;

function TRshBtr.NearestResNum (pResNum:longint):boolean;
begin
  SetIndex (ixResNum);
  Result := oBtrTable.FindNearest([pResNum]);
end;

function TRshBtr.NearestGrpDi (pGroup:longint;pDateI:TDatetime):boolean;
begin
  SetIndex (ixGrpDi);
  Result := oBtrTable.FindNearest([pGroup,pDateI]);
end;

function TRshBtr.NearestStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oBtrTable.FindNearest([pStatus]);
end;

function TRshBtr.NearestTentNum (pTentNum:longint):boolean;
begin
  SetIndex (ixTentNum);
  Result := oBtrTable.FindNearest([pTentNum]);
end;

function TRshBtr.NearestGroup (pGroup:longint):boolean;
begin
  SetIndex (ixGroup);
  Result := oBtrTable.FindNearest([pGroup]);
end;

function TRshBtr.NearestMdtCode (pMdtCode:longint):boolean;
begin
  SetIndex (ixMdtCode);
  Result := oBtrTable.FindNearest([pMdtCode]);
end;

procedure TRshBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TRshBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TRshBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TRshBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TRshBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TRshBtr.First;
begin
  oBtrTable.First;
end;

procedure TRshBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TRshBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TRshBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TRshBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TRshBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TRshBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TRshBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TRshBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TRshBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TRshBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TRshBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1906001}
