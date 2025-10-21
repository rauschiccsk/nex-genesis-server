unit tDPI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = '';
  ixItmNum = 'ItmNum';
  ixInvDoc = 'InvDoc';
  ixInvExt = 'InvExt';
  ixPaCode = 'PaCode';
  ixPaName_ = 'PaName_';

type
  TDpiTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
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
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateItmNum (pItmNum:word):boolean;
    function LocateInvDoc (pInvDoc:Str12):boolean;
    function LocateInvExt (pInvExt:Str12):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName_ (pPaName_:Str30):boolean;

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
    procedure DisableControls;
    procedure EnableControls;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read ReadCount;
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
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TDpiTmp.Create;
begin
  oTmpTable := TmpInit ('DPI',Self);
end;

destructor TDpiTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TDpiTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TDpiTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TDpiTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TDpiTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TDpiTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TDpiTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TDpiTmp.ReadInvDoc:Str12;
begin
  Result := oTmpTable.FieldByName('InvDoc').AsString;
end;

procedure TDpiTmp.WriteInvDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('InvDoc').AsString := pValue;
end;

function TDpiTmp.ReadInvExt:Str12;
begin
  Result := oTmpTable.FieldByName('InvExt').AsString;
end;

procedure TDpiTmp.WriteInvExt(pValue:Str12);
begin
  oTmpTable.FieldByName('InvExt').AsString := pValue;
end;

function TDpiTmp.ReadInvDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('InvDate').AsDateTime;
end;

procedure TDpiTmp.WriteInvDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('InvDate').AsDateTime := pValue;
end;

function TDpiTmp.ReadExpDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ExpDate').AsDateTime;
end;

procedure TDpiTmp.WriteExpDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ExpDate').AsDateTime := pValue;
end;

function TDpiTmp.ReadPayDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('PayDate').AsDateTime;
end;

procedure TDpiTmp.WritePayDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('PayDate').AsDateTime := pValue;
end;

function TDpiTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TDpiTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TDpiTmp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TDpiTmp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TDpiTmp.ReadPaName_:Str30;
begin
  Result := oTmpTable.FieldByName('PaName_').AsString;
end;

procedure TDpiTmp.WritePaName_(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName_').AsString := pValue;
end;

function TDpiTmp.ReadRegName:Str60;
begin
  Result := oTmpTable.FieldByName('RegName').AsString;
end;

procedure TDpiTmp.WriteRegName(pValue:Str60);
begin
  oTmpTable.FieldByName('RegName').AsString := pValue;
end;

function TDpiTmp.ReadRegIno:Str15;
begin
  Result := oTmpTable.FieldByName('RegIno').AsString;
end;

procedure TDpiTmp.WriteRegIno(pValue:Str15);
begin
  oTmpTable.FieldByName('RegIno').AsString := pValue;
end;

function TDpiTmp.ReadRegTin:Str15;
begin
  Result := oTmpTable.FieldByName('RegTin').AsString;
end;

procedure TDpiTmp.WriteRegTin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegTin').AsString := pValue;
end;

function TDpiTmp.ReadRegVin:Str15;
begin
  Result := oTmpTable.FieldByName('RegVin').AsString;
end;

procedure TDpiTmp.WriteRegVin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegVin').AsString := pValue;
end;

function TDpiTmp.ReadRegAddr:Str30;
begin
  Result := oTmpTable.FieldByName('RegAddr').AsString;
end;

procedure TDpiTmp.WriteRegAddr(pValue:Str30);
begin
  oTmpTable.FieldByName('RegAddr').AsString := pValue;
end;

function TDpiTmp.ReadRegCty:Str3;
begin
  Result := oTmpTable.FieldByName('RegCty').AsString;
end;

procedure TDpiTmp.WriteRegCty(pValue:Str3);
begin
  oTmpTable.FieldByName('RegCty').AsString := pValue;
end;

function TDpiTmp.ReadRegCtn:Str30;
begin
  Result := oTmpTable.FieldByName('RegCtn').AsString;
end;

procedure TDpiTmp.WriteRegCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('RegCtn').AsString := pValue;
end;

function TDpiTmp.ReadRegZip:Str15;
begin
  Result := oTmpTable.FieldByName('RegZip').AsString;
end;

procedure TDpiTmp.WriteRegZip(pValue:Str15);
begin
  oTmpTable.FieldByName('RegZip').AsString := pValue;
end;

function TDpiTmp.ReadRegSta:Str2;
begin
  Result := oTmpTable.FieldByName('RegSta').AsString;
end;

procedure TDpiTmp.WriteRegSta(pValue:Str2);
begin
  oTmpTable.FieldByName('RegSta').AsString := pValue;
end;

function TDpiTmp.ReadRegStn:Str30;
begin
  Result := oTmpTable.FieldByName('RegStn').AsString;
end;

procedure TDpiTmp.WriteRegStn(pValue:Str30);
begin
  oTmpTable.FieldByName('RegStn').AsString := pValue;
end;

function TDpiTmp.ReadInvVal:double;
begin
  Result := oTmpTable.FieldByName('InvVal').AsFloat;
end;

procedure TDpiTmp.WriteInvVal(pValue:double);
begin
  oTmpTable.FieldByName('InvVal').AsFloat := pValue;
end;

function TDpiTmp.ReadPayVal:double;
begin
  Result := oTmpTable.FieldByName('PayVal').AsFloat;
end;

procedure TDpiTmp.WritePayVal(pValue:double);
begin
  oTmpTable.FieldByName('PayVal').AsFloat := pValue;
end;

function TDpiTmp.ReadEndVal:double;
begin
  Result := oTmpTable.FieldByName('EndVal').AsFloat;
end;

procedure TDpiTmp.WriteEndVal(pValue:double);
begin
  oTmpTable.FieldByName('EndVal').AsFloat := pValue;
end;

function TDpiTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TDpiTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TDpiTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TDpiTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TDpiTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TDpiTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TDpiTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TDpiTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TDpiTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TDpiTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TDpiTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TDpiTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TDpiTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TDpiTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TDpiTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TDpiTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TDpiTmp.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TDpiTmp.LocateItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oTmpTable.FindKey([pItmNum]);
end;

function TDpiTmp.LocateInvDoc (pInvDoc:Str12):boolean;
begin
  SetIndex (ixInvDoc);
  Result := oTmpTable.FindKey([pInvDoc]);
end;

function TDpiTmp.LocateInvExt (pInvExt:Str12):boolean;
begin
  SetIndex (ixInvExt);
  Result := oTmpTable.FindKey([pInvExt]);
end;

function TDpiTmp.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oTmpTable.FindKey([pPaCode]);
end;

function TDpiTmp.LocatePaName_ (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName_);
  Result := oTmpTable.FindKey([pPaName_]);
end;

procedure TDpiTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TDpiTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TDpiTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TDpiTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TDpiTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TDpiTmp.First;
begin
  oTmpTable.First;
end;

procedure TDpiTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TDpiTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TDpiTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TDpiTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TDpiTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TDpiTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TDpiTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TDpiTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TDpiTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TDpiTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TDpiTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
