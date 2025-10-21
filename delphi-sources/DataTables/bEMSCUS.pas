unit bEMSCUS;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixWnSn = 'WnSn';
  ixWnOnMsMt = 'WnOnMsMt';
  ixSerNum = 'SerNum';
  ixOcdNum = 'OcdNum';
  ixPaCode = 'PaCode';
  ixMsgDate = 'MsgDate';
  ixPaName = 'PaName';
  ixMsgStat = 'MsgStat';

type
  TEmscusBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadWriNum:longint;        procedure WriteWriNum (pValue:longint);
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
    function  ReadEmlNum:Str12;          procedure WriteEmlNum (pValue:Str12);
    function  ReadMsgMode:Str30;         procedure WriteMsgMode (pValue:Str30);
    function  ReadMsgDate:TDatetime;     procedure WriteMsgDate (pValue:TDatetime);
    function  ReadMsgType:Str1;          procedure WriteMsgType (pValue:Str1);
    function  ReadMsgStat:Str1;          procedure WriteMsgStat (pValue:Str1);
    function  ReadSndStat:Str1;          procedure WriteSndStat (pValue:Str1);
    function  ReadOcdNum:Str12;          procedure WriteOcdNum (pValue:Str12);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadPaName_:Str30;         procedure WritePaName_ (pValue:Str30);
    function  ReadRegName:Str60;         procedure WriteRegName (pValue:Str60);
    function  ReadRegIno:Str15;          procedure WriteRegIno (pValue:Str15);
    function  ReadRegTin:Str15;          procedure WriteRegTin (pValue:Str15);
    function  ReadRegVin:Str15;          procedure WriteRegVin (pValue:Str15);
    function  ReadRegAddr:Str30;         procedure WriteRegAddr (pValue:Str30);
    function  ReadRegSta:Str2;           procedure WriteRegSta (pValue:Str2);
    function  ReadRegCty:Str3;           procedure WriteRegCty (pValue:Str3);
    function  ReadRegCtn:Str30;          procedure WriteRegCtn (pValue:Str30);
    function  ReadRegZip:Str15;          procedure WriteRegZip (pValue:Str15);
    function  ReadRegTel:Str20;          procedure WriteRegTel (pValue:Str20);
    function  ReadRegFax:Str20;          procedure WriteRegFax (pValue:Str20);
    function  ReadRegEml:Str30;          procedure WriteRegEml (pValue:Str30);
    function  ReadMsgTxt:Str160;         procedure WriteMsgTxt (pValue:Str160);
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
    function LocateWnSn (pWriNum:longint;pSerNum:longint):boolean;
    function LocateWnOnMsMt (pWriNum:longint;pOcdNum:Str12;pMsgStat:Str1;pMsgType:Str1):boolean;
    function LocateSerNum (pSerNum:longint):boolean;
    function LocateOcdNum (pOcdNum:Str12):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocateMsgDate (pMsgDate:TDatetime):boolean;
    function LocatePaName (pPaName_:Str30):boolean;
    function LocateMsgStat (pMsgStat:Str1):boolean;
    function NearestWnSn (pWriNum:longint;pSerNum:longint):boolean;
    function NearestWnOnMsMt (pWriNum:longint;pOcdNum:Str12;pMsgStat:Str1;pMsgType:Str1):boolean;
    function NearestSerNum (pSerNum:longint):boolean;
    function NearestOcdNum (pOcdNum:Str12):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
    function NearestMsgDate (pMsgDate:TDatetime):boolean;
    function NearestPaName (pPaName_:Str30):boolean;
    function NearestMsgStat (pMsgStat:Str1):boolean;

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
    property WriNum:longint read ReadWriNum write WriteWriNum;
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property EmlNum:Str12 read ReadEmlNum write WriteEmlNum;
    property MsgMode:Str30 read ReadMsgMode write WriteMsgMode;
    property MsgDate:TDatetime read ReadMsgDate write WriteMsgDate;
    property MsgType:Str1 read ReadMsgType write WriteMsgType;
    property MsgStat:Str1 read ReadMsgStat write WriteMsgStat;
    property SndStat:Str1 read ReadSndStat write WriteSndStat;
    property OcdNum:Str12 read ReadOcdNum write WriteOcdNum;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property PaName_:Str30 read ReadPaName_ write WritePaName_;
    property RegName:Str60 read ReadRegName write WriteRegName;
    property RegIno:Str15 read ReadRegIno write WriteRegIno;
    property RegTin:Str15 read ReadRegTin write WriteRegTin;
    property RegVin:Str15 read ReadRegVin write WriteRegVin;
    property RegAddr:Str30 read ReadRegAddr write WriteRegAddr;
    property RegSta:Str2 read ReadRegSta write WriteRegSta;
    property RegCty:Str3 read ReadRegCty write WriteRegCty;
    property RegCtn:Str30 read ReadRegCtn write WriteRegCtn;
    property RegZip:Str15 read ReadRegZip write WriteRegZip;
    property RegTel:Str20 read ReadRegTel write WriteRegTel;
    property RegFax:Str20 read ReadRegFax write WriteRegFax;
    property RegEml:Str30 read ReadRegEml write WriteRegEml;
    property MsgTxt:Str160 read ReadMsgTxt write WriteMsgTxt;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TEmscusBtr.Create;
begin
  oBtrTable := BtrInit ('EMSCUS',gPath.SysPath,Self);
end;

constructor TEmscusBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('EMSCUS',pPath,Self);
end;

destructor TEmscusBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TEmscusBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TEmscusBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TEmscusBtr.ReadWriNum:longint;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TEmscusBtr.WriteWriNum(pValue:longint);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TEmscusBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TEmscusBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TEmscusBtr.ReadEmlNum:Str12;
begin
  Result := oBtrTable.FieldByName('EmlNum').AsString;
end;

procedure TEmscusBtr.WriteEmlNum(pValue:Str12);
begin
  oBtrTable.FieldByName('EmlNum').AsString := pValue;
end;

function TEmscusBtr.ReadMsgMode:Str30;
begin
  Result := oBtrTable.FieldByName('MsgMode').AsString;
end;

procedure TEmscusBtr.WriteMsgMode(pValue:Str30);
begin
  oBtrTable.FieldByName('MsgMode').AsString := pValue;
end;

function TEmscusBtr.ReadMsgDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('MsgDate').AsDateTime;
end;

procedure TEmscusBtr.WriteMsgDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('MsgDate').AsDateTime := pValue;
end;

function TEmscusBtr.ReadMsgType:Str1;
begin
  Result := oBtrTable.FieldByName('MsgType').AsString;
end;

procedure TEmscusBtr.WriteMsgType(pValue:Str1);
begin
  oBtrTable.FieldByName('MsgType').AsString := pValue;
end;

function TEmscusBtr.ReadMsgStat:Str1;
begin
  Result := oBtrTable.FieldByName('MsgStat').AsString;
end;

procedure TEmscusBtr.WriteMsgStat(pValue:Str1);
begin
  oBtrTable.FieldByName('MsgStat').AsString := pValue;
end;

function TEmscusBtr.ReadSndStat:Str1;
begin
  Result := oBtrTable.FieldByName('SndStat').AsString;
end;

procedure TEmscusBtr.WriteSndStat(pValue:Str1);
begin
  oBtrTable.FieldByName('SndStat').AsString := pValue;
end;

function TEmscusBtr.ReadOcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('OcdNum').AsString;
end;

procedure TEmscusBtr.WriteOcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('OcdNum').AsString := pValue;
end;

function TEmscusBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TEmscusBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TEmscusBtr.ReadPaName:Str30;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TEmscusBtr.WritePaName(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TEmscusBtr.ReadPaName_:Str30;
begin
  Result := oBtrTable.FieldByName('PaName_').AsString;
end;

procedure TEmscusBtr.WritePaName_(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName_').AsString := pValue;
end;

function TEmscusBtr.ReadRegName:Str60;
begin
  Result := oBtrTable.FieldByName('RegName').AsString;
end;

procedure TEmscusBtr.WriteRegName(pValue:Str60);
begin
  oBtrTable.FieldByName('RegName').AsString := pValue;
end;

function TEmscusBtr.ReadRegIno:Str15;
begin
  Result := oBtrTable.FieldByName('RegIno').AsString;
end;

procedure TEmscusBtr.WriteRegIno(pValue:Str15);
begin
  oBtrTable.FieldByName('RegIno').AsString := pValue;
end;

function TEmscusBtr.ReadRegTin:Str15;
begin
  Result := oBtrTable.FieldByName('RegTin').AsString;
end;

procedure TEmscusBtr.WriteRegTin(pValue:Str15);
begin
  oBtrTable.FieldByName('RegTin').AsString := pValue;
end;

function TEmscusBtr.ReadRegVin:Str15;
begin
  Result := oBtrTable.FieldByName('RegVin').AsString;
end;

procedure TEmscusBtr.WriteRegVin(pValue:Str15);
begin
  oBtrTable.FieldByName('RegVin').AsString := pValue;
end;

function TEmscusBtr.ReadRegAddr:Str30;
begin
  Result := oBtrTable.FieldByName('RegAddr').AsString;
end;

procedure TEmscusBtr.WriteRegAddr(pValue:Str30);
begin
  oBtrTable.FieldByName('RegAddr').AsString := pValue;
end;

function TEmscusBtr.ReadRegSta:Str2;
begin
  Result := oBtrTable.FieldByName('RegSta').AsString;
end;

procedure TEmscusBtr.WriteRegSta(pValue:Str2);
begin
  oBtrTable.FieldByName('RegSta').AsString := pValue;
end;

function TEmscusBtr.ReadRegCty:Str3;
begin
  Result := oBtrTable.FieldByName('RegCty').AsString;
end;

procedure TEmscusBtr.WriteRegCty(pValue:Str3);
begin
  oBtrTable.FieldByName('RegCty').AsString := pValue;
end;

function TEmscusBtr.ReadRegCtn:Str30;
begin
  Result := oBtrTable.FieldByName('RegCtn').AsString;
end;

procedure TEmscusBtr.WriteRegCtn(pValue:Str30);
begin
  oBtrTable.FieldByName('RegCtn').AsString := pValue;
end;

function TEmscusBtr.ReadRegZip:Str15;
begin
  Result := oBtrTable.FieldByName('RegZip').AsString;
end;

procedure TEmscusBtr.WriteRegZip(pValue:Str15);
begin
  oBtrTable.FieldByName('RegZip').AsString := pValue;
end;

function TEmscusBtr.ReadRegTel:Str20;
begin
  Result := oBtrTable.FieldByName('RegTel').AsString;
end;

procedure TEmscusBtr.WriteRegTel(pValue:Str20);
begin
  oBtrTable.FieldByName('RegTel').AsString := pValue;
end;

function TEmscusBtr.ReadRegFax:Str20;
begin
  Result := oBtrTable.FieldByName('RegFax').AsString;
end;

procedure TEmscusBtr.WriteRegFax(pValue:Str20);
begin
  oBtrTable.FieldByName('RegFax').AsString := pValue;
end;

function TEmscusBtr.ReadRegEml:Str30;
begin
  Result := oBtrTable.FieldByName('RegEml').AsString;
end;

procedure TEmscusBtr.WriteRegEml(pValue:Str30);
begin
  oBtrTable.FieldByName('RegEml').AsString := pValue;
end;

function TEmscusBtr.ReadMsgTxt:Str160;
begin
  Result := oBtrTable.FieldByName('MsgTxt').AsString;
end;

procedure TEmscusBtr.WriteMsgTxt(pValue:Str160);
begin
  oBtrTable.FieldByName('MsgTxt').AsString := pValue;
end;

function TEmscusBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TEmscusBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TEmscusBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TEmscusBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TEmscusBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TEmscusBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TEmscusBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TEmscusBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TEmscusBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TEmscusBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TEmscusBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TEmscusBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TEmscusBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TEmscusBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TEmscusBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TEmscusBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TEmscusBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TEmscusBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TEmscusBtr.LocateWnSn (pWriNum:longint;pSerNum:longint):boolean;
begin
  SetIndex (ixWnSn);
  Result := oBtrTable.FindKey([pWriNum,pSerNum]);
end;

function TEmscusBtr.LocateWnOnMsMt (pWriNum:longint;pOcdNum:Str12;pMsgStat:Str1;pMsgType:Str1):boolean;
begin
  SetIndex (ixWnOnMsMt);
  Result := oBtrTable.FindKey([pWriNum,pOcdNum,pMsgStat,pMsgType]);
end;

function TEmscusBtr.LocateSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindKey([pSerNum]);
end;

function TEmscusBtr.LocateOcdNum (pOcdNum:Str12):boolean;
begin
  SetIndex (ixOcdNum);
  Result := oBtrTable.FindKey([pOcdNum]);
end;

function TEmscusBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TEmscusBtr.LocateMsgDate (pMsgDate:TDatetime):boolean;
begin
  SetIndex (ixMsgDate);
  Result := oBtrTable.FindKey([pMsgDate]);
end;

function TEmscusBtr.LocatePaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindKey([StrToAlias(pPaName_)]);
end;

function TEmscusBtr.LocateMsgStat (pMsgStat:Str1):boolean;
begin
  SetIndex (ixMsgStat);
  Result := oBtrTable.FindKey([pMsgStat]);
end;

function TEmscusBtr.NearestWnSn (pWriNum:longint;pSerNum:longint):boolean;
begin
  SetIndex (ixWnSn);
  Result := oBtrTable.FindNearest([pWriNum,pSerNum]);
end;

function TEmscusBtr.NearestWnOnMsMt (pWriNum:longint;pOcdNum:Str12;pMsgStat:Str1;pMsgType:Str1):boolean;
begin
  SetIndex (ixWnOnMsMt);
  Result := oBtrTable.FindNearest([pWriNum,pOcdNum,pMsgStat,pMsgType]);
end;

function TEmscusBtr.NearestSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindNearest([pSerNum]);
end;

function TEmscusBtr.NearestOcdNum (pOcdNum:Str12):boolean;
begin
  SetIndex (ixOcdNum);
  Result := oBtrTable.FindNearest([pOcdNum]);
end;

function TEmscusBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TEmscusBtr.NearestMsgDate (pMsgDate:TDatetime):boolean;
begin
  SetIndex (ixMsgDate);
  Result := oBtrTable.FindNearest([pMsgDate]);
end;

function TEmscusBtr.NearestPaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindNearest([pPaName_]);
end;

function TEmscusBtr.NearestMsgStat (pMsgStat:Str1):boolean;
begin
  SetIndex (ixMsgStat);
  Result := oBtrTable.FindNearest([pMsgStat]);
end;

procedure TEmscusBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TEmscusBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TEmscusBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TEmscusBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TEmscusBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TEmscusBtr.First;
begin
  oBtrTable.First;
end;

procedure TEmscusBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TEmscusBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TEmscusBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TEmscusBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TEmscusBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TEmscusBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TEmscusBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TEmscusBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TEmscusBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TEmscusBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TEmscusBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
