unit bDPI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = 'DoIt';
  ixDocNum = 'DocNum';
  ixItmNum = 'ItmNum';
  ixInvDoc = 'InvDoc';
  ixInvExt = 'InvExt';
  ixPaCode = 'PaCode';
  ixPaName = 'PaName';

type
  TDpiBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadInvDoc:Str12;          procedure WriteInvDoc (pValue:Str12);
    function  ReadInvExt:Str12;          procedure WriteInvExt (pValue:Str12);
    function  ReadInvDate:TDatetime;     procedure WriteInvDate (pValue:TDatetime);
    function  ReadExpDate:TDatetime;     procedure WriteExpDate (pValue:TDatetime);
    function  ReadPayDate:TDatetime;     procedure WritePayDate (pValue:TDatetime);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadPaName_:Str30;         procedure WritePaName_ (pValue:Str30);
    function  ReadRegName:Str60;         procedure WriteRegName (pValue:Str60);
    function  ReadRegIno:Str15;          procedure WriteRegIno (pValue:Str15);
    function  ReadRegTin:Str15;          procedure WriteRegTin (pValue:Str15);
    function  ReadRegVin:Str15;          procedure WriteRegVin (pValue:Str15);
    function  ReadRegAddr:Str30;         procedure WriteRegAddr (pValue:Str30);
    function  ReadRegCty:Str3;           procedure WriteRegCty (pValue:Str3);
    function  ReadRegCtn:Str30;          procedure WriteRegCtn (pValue:Str30);
    function  ReadRegZip:Str15;          procedure WriteRegZip (pValue:Str15);
    function  ReadRegSta:Str2;           procedure WriteRegSta (pValue:Str2);
    function  ReadRegStn:Str30;          procedure WriteRegStn (pValue:Str30);
    function  ReadInvVal:double;         procedure WriteInvVal (pValue:double);
    function  ReadPayVal:double;         procedure WritePayVal (pValue:double);
    function  ReadEndVal:double;         procedure WriteEndVal (pValue:double);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateItmNum (pItmNum:word):boolean;
    function LocateInvDoc (pInvDoc:Str12):boolean;
    function LocateInvExt (pInvExt:Str12):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName (pPaName_:Str30):boolean;
    function NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestItmNum (pItmNum:word):boolean;
    function NearestInvDoc (pInvDoc:Str12):boolean;
    function NearestInvExt (pInvExt:Str12):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
    function NearestPaName (pPaName_:Str30):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pBookNum:Str5);
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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property InvDoc:Str12 read ReadInvDoc write WriteInvDoc;
    property InvExt:Str12 read ReadInvExt write WriteInvExt;
    property InvDate:TDatetime read ReadInvDate write WriteInvDate;
    property ExpDate:TDatetime read ReadExpDate write WriteExpDate;
    property PayDate:TDatetime read ReadPayDate write WritePayDate;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property PaName_:Str30 read ReadPaName_ write WritePaName_;
    property RegName:Str60 read ReadRegName write WriteRegName;
    property RegIno:Str15 read ReadRegIno write WriteRegIno;
    property RegTin:Str15 read ReadRegTin write WriteRegTin;
    property RegVin:Str15 read ReadRegVin write WriteRegVin;
    property RegAddr:Str30 read ReadRegAddr write WriteRegAddr;
    property RegCty:Str3 read ReadRegCty write WriteRegCty;
    property RegCtn:Str30 read ReadRegCtn write WriteRegCtn;
    property RegZip:Str15 read ReadRegZip write WriteRegZip;
    property RegSta:Str2 read ReadRegSta write WriteRegSta;
    property RegStn:Str30 read ReadRegStn write WriteRegStn;
    property InvVal:double read ReadInvVal write WriteInvVal;
    property PayVal:double read ReadPayVal write WritePayVal;
    property EndVal:double read ReadEndVal write WriteEndVal;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TDpiBtr.Create;
begin
  oBtrTable := BtrInit ('DPI',gPath.LdgPath,Self);
end;

constructor TDpiBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('DPI',pPath,Self);
end;

destructor TDpiBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TDpiBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TDpiBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TDpiBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TDpiBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TDpiBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TDpiBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TDpiBtr.ReadInvDoc:Str12;
begin
  Result := oBtrTable.FieldByName('InvDoc').AsString;
end;

procedure TDpiBtr.WriteInvDoc(pValue:Str12);
begin
  oBtrTable.FieldByName('InvDoc').AsString := pValue;
end;

function TDpiBtr.ReadInvExt:Str12;
begin
  Result := oBtrTable.FieldByName('InvExt').AsString;
end;

procedure TDpiBtr.WriteInvExt(pValue:Str12);
begin
  oBtrTable.FieldByName('InvExt').AsString := pValue;
end;

function TDpiBtr.ReadInvDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('InvDate').AsDateTime;
end;

procedure TDpiBtr.WriteInvDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('InvDate').AsDateTime := pValue;
end;

function TDpiBtr.ReadExpDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ExpDate').AsDateTime;
end;

procedure TDpiBtr.WriteExpDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ExpDate').AsDateTime := pValue;
end;

function TDpiBtr.ReadPayDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('PayDate').AsDateTime;
end;

procedure TDpiBtr.WritePayDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('PayDate').AsDateTime := pValue;
end;

function TDpiBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TDpiBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TDpiBtr.ReadPaName:Str30;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TDpiBtr.WritePaName(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TDpiBtr.ReadPaName_:Str30;
begin
  Result := oBtrTable.FieldByName('PaName_').AsString;
end;

procedure TDpiBtr.WritePaName_(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName_').AsString := pValue;
end;

function TDpiBtr.ReadRegName:Str60;
begin
  Result := oBtrTable.FieldByName('RegName').AsString;
end;

procedure TDpiBtr.WriteRegName(pValue:Str60);
begin
  oBtrTable.FieldByName('RegName').AsString := pValue;
end;

function TDpiBtr.ReadRegIno:Str15;
begin
  Result := oBtrTable.FieldByName('RegIno').AsString;
end;

procedure TDpiBtr.WriteRegIno(pValue:Str15);
begin
  oBtrTable.FieldByName('RegIno').AsString := pValue;
end;

function TDpiBtr.ReadRegTin:Str15;
begin
  Result := oBtrTable.FieldByName('RegTin').AsString;
end;

procedure TDpiBtr.WriteRegTin(pValue:Str15);
begin
  oBtrTable.FieldByName('RegTin').AsString := pValue;
end;

function TDpiBtr.ReadRegVin:Str15;
begin
  Result := oBtrTable.FieldByName('RegVin').AsString;
end;

procedure TDpiBtr.WriteRegVin(pValue:Str15);
begin
  oBtrTable.FieldByName('RegVin').AsString := pValue;
end;

function TDpiBtr.ReadRegAddr:Str30;
begin
  Result := oBtrTable.FieldByName('RegAddr').AsString;
end;

procedure TDpiBtr.WriteRegAddr(pValue:Str30);
begin
  oBtrTable.FieldByName('RegAddr').AsString := pValue;
end;

function TDpiBtr.ReadRegCty:Str3;
begin
  Result := oBtrTable.FieldByName('RegCty').AsString;
end;

procedure TDpiBtr.WriteRegCty(pValue:Str3);
begin
  oBtrTable.FieldByName('RegCty').AsString := pValue;
end;

function TDpiBtr.ReadRegCtn:Str30;
begin
  Result := oBtrTable.FieldByName('RegCtn').AsString;
end;

procedure TDpiBtr.WriteRegCtn(pValue:Str30);
begin
  oBtrTable.FieldByName('RegCtn').AsString := pValue;
end;

function TDpiBtr.ReadRegZip:Str15;
begin
  Result := oBtrTable.FieldByName('RegZip').AsString;
end;

procedure TDpiBtr.WriteRegZip(pValue:Str15);
begin
  oBtrTable.FieldByName('RegZip').AsString := pValue;
end;

function TDpiBtr.ReadRegSta:Str2;
begin
  Result := oBtrTable.FieldByName('RegSta').AsString;
end;

procedure TDpiBtr.WriteRegSta(pValue:Str2);
begin
  oBtrTable.FieldByName('RegSta').AsString := pValue;
end;

function TDpiBtr.ReadRegStn:Str30;
begin
  Result := oBtrTable.FieldByName('RegStn').AsString;
end;

procedure TDpiBtr.WriteRegStn(pValue:Str30);
begin
  oBtrTable.FieldByName('RegStn').AsString := pValue;
end;

function TDpiBtr.ReadInvVal:double;
begin
  Result := oBtrTable.FieldByName('InvVal').AsFloat;
end;

procedure TDpiBtr.WriteInvVal(pValue:double);
begin
  oBtrTable.FieldByName('InvVal').AsFloat := pValue;
end;

function TDpiBtr.ReadPayVal:double;
begin
  Result := oBtrTable.FieldByName('PayVal').AsFloat;
end;

procedure TDpiBtr.WritePayVal(pValue:double);
begin
  oBtrTable.FieldByName('PayVal').AsFloat := pValue;
end;

function TDpiBtr.ReadEndVal:double;
begin
  Result := oBtrTable.FieldByName('EndVal').AsFloat;
end;

procedure TDpiBtr.WriteEndVal(pValue:double);
begin
  oBtrTable.FieldByName('EndVal').AsFloat := pValue;
end;

function TDpiBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TDpiBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TDpiBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TDpiBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TDpiBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TDpiBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TDpiBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TDpiBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TDpiBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TDpiBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TDpiBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TDpiBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TDpiBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TDpiBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TDpiBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TDpiBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TDpiBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TDpiBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TDpiBtr.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TDpiBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TDpiBtr.LocateItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oBtrTable.FindKey([pItmNum]);
end;

function TDpiBtr.LocateInvDoc (pInvDoc:Str12):boolean;
begin
  SetIndex (ixInvDoc);
  Result := oBtrTable.FindKey([pInvDoc]);
end;

function TDpiBtr.LocateInvExt (pInvExt:Str12):boolean;
begin
  SetIndex (ixInvExt);
  Result := oBtrTable.FindKey([pInvExt]);
end;

function TDpiBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TDpiBtr.LocatePaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindKey([StrToAlias(pPaName_)]);
end;

function TDpiBtr.NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TDpiBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TDpiBtr.NearestItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oBtrTable.FindNearest([pItmNum]);
end;

function TDpiBtr.NearestInvDoc (pInvDoc:Str12):boolean;
begin
  SetIndex (ixInvDoc);
  Result := oBtrTable.FindNearest([pInvDoc]);
end;

function TDpiBtr.NearestInvExt (pInvExt:Str12):boolean;
begin
  SetIndex (ixInvExt);
  Result := oBtrTable.FindNearest([pInvExt]);
end;

function TDpiBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TDpiBtr.NearestPaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindNearest([pPaName_]);
end;

procedure TDpiBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TDpiBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TDpiBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TDpiBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TDpiBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TDpiBtr.First;
begin
  oBtrTable.First;
end;

procedure TDpiBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TDpiBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TDpiBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TDpiBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TDpiBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TDpiBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TDpiBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TDpiBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TDpiBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TDpiBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TDpiBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
