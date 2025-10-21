unit bCRH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixYearSerNum = 'YearSerNum';
  ixDocNum = 'DocNum';
  ixExtNum = 'ExtNum';
  ixReqSub = 'ReqSub';
  ixPrgMod = 'PrgMod';

type
  TCrhBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadYear:Str2;             procedure WriteYear (pValue:Str2);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadExtNum:Str20;          procedure WriteExtNum (pValue:Str20);
    function  ReadSerNum:word;           procedure WriteSerNum (pValue:word);
    function  ReadReqSub:Str120;         procedure WriteReqSub (pValue:Str120);
    function  ReadReqSub_:Str120;        procedure WriteReqSub_ (pValue:Str120);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadBegDate:TDatetime;     procedure WriteBegDate (pValue:TDatetime);
    function  ReadEndDate:TDatetime;     procedure WriteEndDate (pValue:TDatetime);
    function  ReadPlnDate:TDatetime;     procedure WritePlnDate (pValue:TDatetime);
    function  ReadRegNum:word;           procedure WriteRegNum (pValue:word);
    function  ReadRegNam:Str30;          procedure WriteRegNam (pValue:Str30);
    function  ReadRspNum:word;           procedure WriteRspNum (pValue:word);
    function  ReadRspNam:Str30;          procedure WriteRspNam (pValue:Str30);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str60;          procedure WritePaName (pValue:Str60);
    function  ReadCntNam:Str40;          procedure WriteCntNam (pValue:Str40);
    function  ReadWrkTel:Str20;          procedure WriteWrkTel (pValue:Str20);
    function  ReadWrkEml:Str30;          procedure WriteWrkEml (pValue:Str30);
    function  ReadReqTyp:Str1;           procedure WriteReqTyp (pValue:Str1);
    function  ReadReqSta:Str1;           procedure WriteReqSta (pValue:Str1);
    function  ReadFndVer:Str5;           procedure WriteFndVer (pValue:Str5);
    function  ReadSolVer:Str5;           procedure WriteSolVer (pValue:Str5);
    function  ReadPriSta:Str1;           procedure WritePriSta (pValue:Str1);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadPrgMod:Str3;           procedure WritePrgMod (pValue:Str3);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateYearSerNum (pYear:Str2;pSerNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateExtNum (pExtNum:Str20):boolean;
    function LocateReqSub (pReqSub_:Str120):boolean;
    function LocatePrgMod (pPrgMod:Str3):boolean;
    function NearestYearSerNum (pYear:Str2;pSerNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestExtNum (pExtNum:Str20):boolean;
    function NearestReqSub (pReqSub_:Str120):boolean;
    function NearestPrgMod (pPrgMod:Str3):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pBookNum:Str5);
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
    property Year:Str2 read ReadYear write WriteYear;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ExtNum:Str20 read ReadExtNum write WriteExtNum;
    property SerNum:word read ReadSerNum write WriteSerNum;
    property ReqSub:Str120 read ReadReqSub write WriteReqSub;
    property ReqSub_:Str120 read ReadReqSub_ write WriteReqSub_;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property BegDate:TDatetime read ReadBegDate write WriteBegDate;
    property EndDate:TDatetime read ReadEndDate write WriteEndDate;
    property PlnDate:TDatetime read ReadPlnDate write WritePlnDate;
    property RegNum:word read ReadRegNum write WriteRegNum;
    property RegNam:Str30 read ReadRegNam write WriteRegNam;
    property RspNum:word read ReadRspNum write WriteRspNum;
    property RspNam:Str30 read ReadRspNam write WriteRspNam;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str60 read ReadPaName write WritePaName;
    property CntNam:Str40 read ReadCntNam write WriteCntNam;
    property WrkTel:Str20 read ReadWrkTel write WriteWrkTel;
    property WrkEml:Str30 read ReadWrkEml write WriteWrkEml;
    property ReqTyp:Str1 read ReadReqTyp write WriteReqTyp;
    property ReqSta:Str1 read ReadReqSta write WriteReqSta;
    property FndVer:Str5 read ReadFndVer write WriteFndVer;
    property SolVer:Str5 read ReadSolVer write WriteSolVer;
    property PriSta:Str1 read ReadPriSta write WritePriSta;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property PrgMod:Str3 read ReadPrgMod write WritePrgMod;
  end;

implementation

constructor TCrhBtr.Create;
begin
  oBtrTable := BtrInit ('CRH',gPath.DlsPath,Self);
end;

constructor TCrhBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('CRH',pPath,Self);
end;

destructor TCrhBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TCrhBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TCrhBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TCrhBtr.ReadYear:Str2;
begin
  Result := oBtrTable.FieldByName('Year').AsString;
end;

procedure TCrhBtr.WriteYear(pValue:Str2);
begin
  oBtrTable.FieldByName('Year').AsString := pValue;
end;

function TCrhBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TCrhBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TCrhBtr.ReadExtNum:Str20;
begin
  Result := oBtrTable.FieldByName('ExtNum').AsString;
end;

procedure TCrhBtr.WriteExtNum(pValue:Str20);
begin
  oBtrTable.FieldByName('ExtNum').AsString := pValue;
end;

function TCrhBtr.ReadSerNum:word;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TCrhBtr.WriteSerNum(pValue:word);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TCrhBtr.ReadReqSub:Str120;
begin
  Result := oBtrTable.FieldByName('ReqSub').AsString;
end;

procedure TCrhBtr.WriteReqSub(pValue:Str120);
begin
  oBtrTable.FieldByName('ReqSub').AsString := pValue;
end;

function TCrhBtr.ReadReqSub_:Str120;
begin
  Result := oBtrTable.FieldByName('ReqSub_').AsString;
end;

procedure TCrhBtr.WriteReqSub_(pValue:Str120);
begin
  oBtrTable.FieldByName('ReqSub_').AsString := pValue;
end;

function TCrhBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TCrhBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TCrhBtr.ReadBegDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegDate').AsDateTime;
end;

procedure TCrhBtr.WriteBegDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegDate').AsDateTime := pValue;
end;

function TCrhBtr.ReadEndDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndDate').AsDateTime;
end;

procedure TCrhBtr.WriteEndDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndDate').AsDateTime := pValue;
end;

function TCrhBtr.ReadPlnDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('PlnDate').AsDateTime;
end;

procedure TCrhBtr.WritePlnDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('PlnDate').AsDateTime := pValue;
end;

function TCrhBtr.ReadRegNum:word;
begin
  Result := oBtrTable.FieldByName('RegNum').AsInteger;
end;

procedure TCrhBtr.WriteRegNum(pValue:word);
begin
  oBtrTable.FieldByName('RegNum').AsInteger := pValue;
end;

function TCrhBtr.ReadRegNam:Str30;
begin
  Result := oBtrTable.FieldByName('RegNam').AsString;
end;

procedure TCrhBtr.WriteRegNam(pValue:Str30);
begin
  oBtrTable.FieldByName('RegNam').AsString := pValue;
end;

function TCrhBtr.ReadRspNum:word;
begin
  Result := oBtrTable.FieldByName('RspNum').AsInteger;
end;

procedure TCrhBtr.WriteRspNum(pValue:word);
begin
  oBtrTable.FieldByName('RspNum').AsInteger := pValue;
end;

function TCrhBtr.ReadRspNam:Str30;
begin
  Result := oBtrTable.FieldByName('RspNam').AsString;
end;

procedure TCrhBtr.WriteRspNam(pValue:Str30);
begin
  oBtrTable.FieldByName('RspNam').AsString := pValue;
end;

function TCrhBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TCrhBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TCrhBtr.ReadPaName:Str60;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TCrhBtr.WritePaName(pValue:Str60);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TCrhBtr.ReadCntNam:Str40;
begin
  Result := oBtrTable.FieldByName('CntNam').AsString;
end;

procedure TCrhBtr.WriteCntNam(pValue:Str40);
begin
  oBtrTable.FieldByName('CntNam').AsString := pValue;
end;

function TCrhBtr.ReadWrkTel:Str20;
begin
  Result := oBtrTable.FieldByName('WrkTel').AsString;
end;

procedure TCrhBtr.WriteWrkTel(pValue:Str20);
begin
  oBtrTable.FieldByName('WrkTel').AsString := pValue;
end;

function TCrhBtr.ReadWrkEml:Str30;
begin
  Result := oBtrTable.FieldByName('WrkEml').AsString;
end;

procedure TCrhBtr.WriteWrkEml(pValue:Str30);
begin
  oBtrTable.FieldByName('WrkEml').AsString := pValue;
end;

function TCrhBtr.ReadReqTyp:Str1;
begin
  Result := oBtrTable.FieldByName('ReqTyp').AsString;
end;

procedure TCrhBtr.WriteReqTyp(pValue:Str1);
begin
  oBtrTable.FieldByName('ReqTyp').AsString := pValue;
end;

function TCrhBtr.ReadReqSta:Str1;
begin
  Result := oBtrTable.FieldByName('ReqSta').AsString;
end;

procedure TCrhBtr.WriteReqSta(pValue:Str1);
begin
  oBtrTable.FieldByName('ReqSta').AsString := pValue;
end;

function TCrhBtr.ReadFndVer:Str5;
begin
  Result := oBtrTable.FieldByName('FndVer').AsString;
end;

procedure TCrhBtr.WriteFndVer(pValue:Str5);
begin
  oBtrTable.FieldByName('FndVer').AsString := pValue;
end;

function TCrhBtr.ReadSolVer:Str5;
begin
  Result := oBtrTable.FieldByName('SolVer').AsString;
end;

procedure TCrhBtr.WriteSolVer(pValue:Str5);
begin
  oBtrTable.FieldByName('SolVer').AsString := pValue;
end;

function TCrhBtr.ReadPriSta:Str1;
begin
  Result := oBtrTable.FieldByName('PriSta').AsString;
end;

procedure TCrhBtr.WritePriSta(pValue:Str1);
begin
  oBtrTable.FieldByName('PriSta').AsString := pValue;
end;

function TCrhBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TCrhBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TCrhBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TCrhBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TCrhBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TCrhBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TCrhBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TCrhBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TCrhBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TCrhBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TCrhBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TCrhBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TCrhBtr.ReadPrgMod:Str3;
begin
  Result := oBtrTable.FieldByName('PrgMod').AsString;
end;

procedure TCrhBtr.WritePrgMod(pValue:Str3);
begin
  oBtrTable.FieldByName('PrgMod').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCrhBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCrhBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TCrhBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCrhBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TCrhBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TCrhBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TCrhBtr.LocateYearSerNum (pYear:Str2;pSerNum:word):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindKey([pYear,pSerNum]);
end;

function TCrhBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TCrhBtr.LocateExtNum (pExtNum:Str20):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindKey([pExtNum]);
end;

function TCrhBtr.LocateReqSub (pReqSub_:Str120):boolean;
begin
  SetIndex (ixReqSub);
  Result := oBtrTable.FindKey([StrToAlias(pReqSub_)]);
end;

function TCrhBtr.LocatePrgMod (pPrgMod:Str3):boolean;
begin
  SetIndex (ixPrgMod);
  Result := oBtrTable.FindKey([pPrgMod]);
end;

function TCrhBtr.NearestYearSerNum (pYear:Str2;pSerNum:word):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindNearest([pYear,pSerNum]);
end;

function TCrhBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TCrhBtr.NearestExtNum (pExtNum:Str20):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindNearest([pExtNum]);
end;

function TCrhBtr.NearestReqSub (pReqSub_:Str120):boolean;
begin
  SetIndex (ixReqSub);
  Result := oBtrTable.FindNearest([pReqSub_]);
end;

function TCrhBtr.NearestPrgMod (pPrgMod:Str3):boolean;
begin
  SetIndex (ixPrgMod);
  Result := oBtrTable.FindNearest([pPrgMod]);
end;

procedure TCrhBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TCrhBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TCrhBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TCrhBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TCrhBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TCrhBtr.First;
begin
  oBtrTable.First;
end;

procedure TCrhBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TCrhBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TCrhBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TCrhBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TCrhBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TCrhBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TCrhBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TCrhBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TCrhBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TCrhBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TCrhBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1918001}
