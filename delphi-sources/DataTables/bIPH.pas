unit bIPH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixYearSerNum = 'YearSerNum';
  ixDocNum = 'DocNum';
  ixDocDate = 'DocDate';
  ixPaName = 'PaName';

type
  TIphBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadExtNum:Str12;          procedure WriteExtNum (pValue:Str12);
    function  ReadRegNum:Str12;          procedure WriteRegNum (pValue:Str12);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadPaName_:Str30;         procedure WritePaName_ (pValue:Str30);
    function  ReadRegName:Str60;         procedure WriteRegName (pValue:Str60);
    function  ReadSndAddr:Str30;         procedure WriteSndAddr (pValue:Str30);
    function  ReadSndSta:Str2;           procedure WriteSndSta (pValue:Str2);
    function  ReadSndStn:Str30;          procedure WriteSndStn (pValue:Str30);
    function  ReadSndCty:Str3;           procedure WriteSndCty (pValue:Str3);
    function  ReadSndCtn:Str30;          procedure WriteSndCtn (pValue:Str30);
    function  ReadSndZip:Str15;          procedure WriteSndZip (pValue:Str15);
    function  ReadCntName:Str30;         procedure WriteCntName (pValue:Str30);
    function  ReadCntMob:Str20;          procedure WriteCntMob (pValue:Str20);
    function  ReadCntTel:Str20;          procedure WriteCntTel (pValue:Str20);
    function  ReadCntFnc:Str30;          procedure WriteCntFnc (pValue:Str30);
    function  ReadCntEml:Str30;          procedure WriteCntEml (pValue:Str30);
    function  ReadDesTxt:Str90;          procedure WriteDesTxt (pValue:Str90);
    function  ReadPagQnt:word;           procedure WritePagQnt (pValue:word);
    function  ReadDocSpc:Str1;           procedure WriteDocSpc (pValue:Str1);
    function  ReadOthSpc:Str15;          procedure WriteOthSpc (pValue:Str15);
    function  ReadImpLev:byte;           procedure WriteImpLev (pValue:byte);
    function  ReadAcsLev:byte;           procedure WriteAcsLev (pValue:byte);
    function  ReadStatus:Str1;           procedure WriteStatus (pValue:Str1);
    function  ReadDlvMode:Str1;          procedure WriteDlvMode (pValue:Str1);
    function  ReadIpdType:Str1;          procedure WriteIpdType (pValue:Str1);
    function  ReadOthType:Str15;         procedure WriteOthType (pValue:Str15);
    function  ReadCodType:Str1;          procedure WriteCodType (pValue:Str1);
    function  ReadSigUser:Str8;          procedure WriteSigUser (pValue:Str8);
    function  ReadSigName:Str30;         procedure WriteSigName (pValue:Str30);
    function  ReadSigTerm:TDatetime;     procedure WriteSigTerm (pValue:TDatetime);
    function  ReadSigDate:TDatetime;     procedure WriteSigDate (pValue:TDatetime);
    function  ReadSigTime:TDatetime;     procedure WriteSigTime (pValue:TDatetime);
    function  ReadSigCode:Str40;         procedure WriteSigCode (pValue:Str40);
    function  ReadSolUser:Str8;          procedure WriteSolUser (pValue:Str8);
    function  ReadSolName:Str30;         procedure WriteSolName (pValue:Str30);
    function  ReadSolTerm:TDatetime;     procedure WriteSolTerm (pValue:TDatetime);
    function  ReadSolDate:TDatetime;     procedure WriteSolDate (pValue:TDatetime);
    function  ReadSolTime:TDatetime;     procedure WriteSolTime (pValue:TDatetime);
    function  ReadSolCode:Str40;         procedure WriteSolCode (pValue:Str40);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtName:Str30;         procedure WriteCrtName (pValue:Str30);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadYear:Str2;             procedure WriteYear (pValue:Str2);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocatePaName (pPaName_:Str30):boolean;
    function NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;
    function NearestPaName (pPaName_:Str30):boolean;

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
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ExtNum:Str12 read ReadExtNum write WriteExtNum;
    property RegNum:Str12 read ReadRegNum write WriteRegNum;
    property WriNum:word read ReadWriNum write WriteWriNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property PaName_:Str30 read ReadPaName_ write WritePaName_;
    property RegName:Str60 read ReadRegName write WriteRegName;
    property SndAddr:Str30 read ReadSndAddr write WriteSndAddr;
    property SndSta:Str2 read ReadSndSta write WriteSndSta;
    property SndStn:Str30 read ReadSndStn write WriteSndStn;
    property SndCty:Str3 read ReadSndCty write WriteSndCty;
    property SndCtn:Str30 read ReadSndCtn write WriteSndCtn;
    property SndZip:Str15 read ReadSndZip write WriteSndZip;
    property CntName:Str30 read ReadCntName write WriteCntName;
    property CntMob:Str20 read ReadCntMob write WriteCntMob;
    property CntTel:Str20 read ReadCntTel write WriteCntTel;
    property CntFnc:Str30 read ReadCntFnc write WriteCntFnc;
    property CntEml:Str30 read ReadCntEml write WriteCntEml;
    property DesTxt:Str90 read ReadDesTxt write WriteDesTxt;
    property PagQnt:word read ReadPagQnt write WritePagQnt;
    property DocSpc:Str1 read ReadDocSpc write WriteDocSpc;
    property OthSpc:Str15 read ReadOthSpc write WriteOthSpc;
    property ImpLev:byte read ReadImpLev write WriteImpLev;
    property AcsLev:byte read ReadAcsLev write WriteAcsLev;
    property Status:Str1 read ReadStatus write WriteStatus;
    property DlvMode:Str1 read ReadDlvMode write WriteDlvMode;
    property IpdType:Str1 read ReadIpdType write WriteIpdType;
    property OthType:Str15 read ReadOthType write WriteOthType;
    property CodType:Str1 read ReadCodType write WriteCodType;
    property SigUser:Str8 read ReadSigUser write WriteSigUser;
    property SigName:Str30 read ReadSigName write WriteSigName;
    property SigTerm:TDatetime read ReadSigTerm write WriteSigTerm;
    property SigDate:TDatetime read ReadSigDate write WriteSigDate;
    property SigTime:TDatetime read ReadSigTime write WriteSigTime;
    property SigCode:Str40 read ReadSigCode write WriteSigCode;
    property SolUser:Str8 read ReadSolUser write WriteSolUser;
    property SolName:Str30 read ReadSolName write WriteSolName;
    property SolTerm:TDatetime read ReadSolTerm write WriteSolTerm;
    property SolDate:TDatetime read ReadSolDate write WriteSolDate;
    property SolTime:TDatetime read ReadSolTime write WriteSolTime;
    property SolCode:Str40 read ReadSolCode write WriteSolCode;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtName:Str30 read ReadCrtName write WriteCrtName;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property Year:Str2 read ReadYear write WriteYear;
  end;

implementation

constructor TIphBtr.Create;
begin
  oBtrTable := BtrInit ('IPH',gPath.StkPath,Self);
end;

constructor TIphBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('IPH',pPath,Self);
end;

destructor TIphBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TIphBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TIphBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TIphBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TIphBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TIphBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TIphBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TIphBtr.ReadExtNum:Str12;
begin
  Result := oBtrTable.FieldByName('ExtNum').AsString;
end;

procedure TIphBtr.WriteExtNum(pValue:Str12);
begin
  oBtrTable.FieldByName('ExtNum').AsString := pValue;
end;

function TIphBtr.ReadRegNum:Str12;
begin
  Result := oBtrTable.FieldByName('RegNum').AsString;
end;

procedure TIphBtr.WriteRegNum(pValue:Str12);
begin
  oBtrTable.FieldByName('RegNum').AsString := pValue;
end;

function TIphBtr.ReadWriNum:word;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TIphBtr.WriteWriNum(pValue:word);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TIphBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TIphBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TIphBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TIphBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TIphBtr.ReadPaName:Str30;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TIphBtr.WritePaName(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TIphBtr.ReadPaName_:Str30;
begin
  Result := oBtrTable.FieldByName('PaName_').AsString;
end;

procedure TIphBtr.WritePaName_(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName_').AsString := pValue;
end;

function TIphBtr.ReadRegName:Str60;
begin
  Result := oBtrTable.FieldByName('RegName').AsString;
end;

procedure TIphBtr.WriteRegName(pValue:Str60);
begin
  oBtrTable.FieldByName('RegName').AsString := pValue;
end;

function TIphBtr.ReadSndAddr:Str30;
begin
  Result := oBtrTable.FieldByName('SndAddr').AsString;
end;

procedure TIphBtr.WriteSndAddr(pValue:Str30);
begin
  oBtrTable.FieldByName('SndAddr').AsString := pValue;
end;

function TIphBtr.ReadSndSta:Str2;
begin
  Result := oBtrTable.FieldByName('SndSta').AsString;
end;

procedure TIphBtr.WriteSndSta(pValue:Str2);
begin
  oBtrTable.FieldByName('SndSta').AsString := pValue;
end;

function TIphBtr.ReadSndStn:Str30;
begin
  Result := oBtrTable.FieldByName('SndStn').AsString;
end;

procedure TIphBtr.WriteSndStn(pValue:Str30);
begin
  oBtrTable.FieldByName('SndStn').AsString := pValue;
end;

function TIphBtr.ReadSndCty:Str3;
begin
  Result := oBtrTable.FieldByName('SndCty').AsString;
end;

procedure TIphBtr.WriteSndCty(pValue:Str3);
begin
  oBtrTable.FieldByName('SndCty').AsString := pValue;
end;

function TIphBtr.ReadSndCtn:Str30;
begin
  Result := oBtrTable.FieldByName('SndCtn').AsString;
end;

procedure TIphBtr.WriteSndCtn(pValue:Str30);
begin
  oBtrTable.FieldByName('SndCtn').AsString := pValue;
end;

function TIphBtr.ReadSndZip:Str15;
begin
  Result := oBtrTable.FieldByName('SndZip').AsString;
end;

procedure TIphBtr.WriteSndZip(pValue:Str15);
begin
  oBtrTable.FieldByName('SndZip').AsString := pValue;
end;

function TIphBtr.ReadCntName:Str30;
begin
  Result := oBtrTable.FieldByName('CntName').AsString;
end;

procedure TIphBtr.WriteCntName(pValue:Str30);
begin
  oBtrTable.FieldByName('CntName').AsString := pValue;
end;

function TIphBtr.ReadCntMob:Str20;
begin
  Result := oBtrTable.FieldByName('CntMob').AsString;
end;

procedure TIphBtr.WriteCntMob(pValue:Str20);
begin
  oBtrTable.FieldByName('CntMob').AsString := pValue;
end;

function TIphBtr.ReadCntTel:Str20;
begin
  Result := oBtrTable.FieldByName('CntTel').AsString;
end;

procedure TIphBtr.WriteCntTel(pValue:Str20);
begin
  oBtrTable.FieldByName('CntTel').AsString := pValue;
end;

function TIphBtr.ReadCntFnc:Str30;
begin
  Result := oBtrTable.FieldByName('CntFnc').AsString;
end;

procedure TIphBtr.WriteCntFnc(pValue:Str30);
begin
  oBtrTable.FieldByName('CntFnc').AsString := pValue;
end;

function TIphBtr.ReadCntEml:Str30;
begin
  Result := oBtrTable.FieldByName('CntEml').AsString;
end;

procedure TIphBtr.WriteCntEml(pValue:Str30);
begin
  oBtrTable.FieldByName('CntEml').AsString := pValue;
end;

function TIphBtr.ReadDesTxt:Str90;
begin
  Result := oBtrTable.FieldByName('DesTxt').AsString;
end;

procedure TIphBtr.WriteDesTxt(pValue:Str90);
begin
  oBtrTable.FieldByName('DesTxt').AsString := pValue;
end;

function TIphBtr.ReadPagQnt:word;
begin
  Result := oBtrTable.FieldByName('PagQnt').AsInteger;
end;

procedure TIphBtr.WritePagQnt(pValue:word);
begin
  oBtrTable.FieldByName('PagQnt').AsInteger := pValue;
end;

function TIphBtr.ReadDocSpc:Str1;
begin
  Result := oBtrTable.FieldByName('DocSpc').AsString;
end;

procedure TIphBtr.WriteDocSpc(pValue:Str1);
begin
  oBtrTable.FieldByName('DocSpc').AsString := pValue;
end;

function TIphBtr.ReadOthSpc:Str15;
begin
  Result := oBtrTable.FieldByName('OthSpc').AsString;
end;

procedure TIphBtr.WriteOthSpc(pValue:Str15);
begin
  oBtrTable.FieldByName('OthSpc').AsString := pValue;
end;

function TIphBtr.ReadImpLev:byte;
begin
  Result := oBtrTable.FieldByName('ImpLev').AsInteger;
end;

procedure TIphBtr.WriteImpLev(pValue:byte);
begin
  oBtrTable.FieldByName('ImpLev').AsInteger := pValue;
end;

function TIphBtr.ReadAcsLev:byte;
begin
  Result := oBtrTable.FieldByName('AcsLev').AsInteger;
end;

procedure TIphBtr.WriteAcsLev(pValue:byte);
begin
  oBtrTable.FieldByName('AcsLev').AsInteger := pValue;
end;

function TIphBtr.ReadStatus:Str1;
begin
  Result := oBtrTable.FieldByName('Status').AsString;
end;

procedure TIphBtr.WriteStatus(pValue:Str1);
begin
  oBtrTable.FieldByName('Status').AsString := pValue;
end;

function TIphBtr.ReadDlvMode:Str1;
begin
  Result := oBtrTable.FieldByName('DlvMode').AsString;
end;

procedure TIphBtr.WriteDlvMode(pValue:Str1);
begin
  oBtrTable.FieldByName('DlvMode').AsString := pValue;
end;

function TIphBtr.ReadIpdType:Str1;
begin
  Result := oBtrTable.FieldByName('IpdType').AsString;
end;

procedure TIphBtr.WriteIpdType(pValue:Str1);
begin
  oBtrTable.FieldByName('IpdType').AsString := pValue;
end;

function TIphBtr.ReadOthType:Str15;
begin
  Result := oBtrTable.FieldByName('OthType').AsString;
end;

procedure TIphBtr.WriteOthType(pValue:Str15);
begin
  oBtrTable.FieldByName('OthType').AsString := pValue;
end;

function TIphBtr.ReadCodType:Str1;
begin
  Result := oBtrTable.FieldByName('CodType').AsString;
end;

procedure TIphBtr.WriteCodType(pValue:Str1);
begin
  oBtrTable.FieldByName('CodType').AsString := pValue;
end;

function TIphBtr.ReadSigUser:Str8;
begin
  Result := oBtrTable.FieldByName('SigUser').AsString;
end;

procedure TIphBtr.WriteSigUser(pValue:Str8);
begin
  oBtrTable.FieldByName('SigUser').AsString := pValue;
end;

function TIphBtr.ReadSigName:Str30;
begin
  Result := oBtrTable.FieldByName('SigName').AsString;
end;

procedure TIphBtr.WriteSigName(pValue:Str30);
begin
  oBtrTable.FieldByName('SigName').AsString := pValue;
end;

function TIphBtr.ReadSigTerm:TDatetime;
begin
  Result := oBtrTable.FieldByName('SigTerm').AsDateTime;
end;

procedure TIphBtr.WriteSigTerm(pValue:TDatetime);
begin
  oBtrTable.FieldByName('SigTerm').AsDateTime := pValue;
end;

function TIphBtr.ReadSigDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('SigDate').AsDateTime;
end;

procedure TIphBtr.WriteSigDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('SigDate').AsDateTime := pValue;
end;

function TIphBtr.ReadSigTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('SigTime').AsDateTime;
end;

procedure TIphBtr.WriteSigTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('SigTime').AsDateTime := pValue;
end;

function TIphBtr.ReadSigCode:Str40;
begin
  Result := oBtrTable.FieldByName('SigCode').AsString;
end;

procedure TIphBtr.WriteSigCode(pValue:Str40);
begin
  oBtrTable.FieldByName('SigCode').AsString := pValue;
end;

function TIphBtr.ReadSolUser:Str8;
begin
  Result := oBtrTable.FieldByName('SolUser').AsString;
end;

procedure TIphBtr.WriteSolUser(pValue:Str8);
begin
  oBtrTable.FieldByName('SolUser').AsString := pValue;
end;

function TIphBtr.ReadSolName:Str30;
begin
  Result := oBtrTable.FieldByName('SolName').AsString;
end;

procedure TIphBtr.WriteSolName(pValue:Str30);
begin
  oBtrTable.FieldByName('SolName').AsString := pValue;
end;

function TIphBtr.ReadSolTerm:TDatetime;
begin
  Result := oBtrTable.FieldByName('SolTerm').AsDateTime;
end;

procedure TIphBtr.WriteSolTerm(pValue:TDatetime);
begin
  oBtrTable.FieldByName('SolTerm').AsDateTime := pValue;
end;

function TIphBtr.ReadSolDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('SolDate').AsDateTime;
end;

procedure TIphBtr.WriteSolDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('SolDate').AsDateTime := pValue;
end;

function TIphBtr.ReadSolTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('SolTime').AsDateTime;
end;

procedure TIphBtr.WriteSolTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('SolTime').AsDateTime := pValue;
end;

function TIphBtr.ReadSolCode:Str40;
begin
  Result := oBtrTable.FieldByName('SolCode').AsString;
end;

procedure TIphBtr.WriteSolCode(pValue:Str40);
begin
  oBtrTable.FieldByName('SolCode').AsString := pValue;
end;

function TIphBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TIphBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TIphBtr.ReadCrtName:Str30;
begin
  Result := oBtrTable.FieldByName('CrtName').AsString;
end;

procedure TIphBtr.WriteCrtName(pValue:Str30);
begin
  oBtrTable.FieldByName('CrtName').AsString := pValue;
end;

function TIphBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TIphBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TIphBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TIphBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TIphBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TIphBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TIphBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TIphBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TIphBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TIphBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TIphBtr.ReadYear:Str2;
begin
  Result := oBtrTable.FieldByName('Year').AsString;
end;

procedure TIphBtr.WriteYear(pValue:Str2);
begin
  oBtrTable.FieldByName('Year').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TIphBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIphBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TIphBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIphBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TIphBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TIphBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TIphBtr.LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindKey([pYear,pSerNum]);
end;

function TIphBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TIphBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TIphBtr.LocatePaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindKey([StrToAlias(pPaName_)]);
end;

function TIphBtr.NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindNearest([pYear,pSerNum]);
end;

function TIphBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TIphBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TIphBtr.NearestPaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindNearest([pPaName_]);
end;

procedure TIphBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TIphBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TIphBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TIphBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TIphBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TIphBtr.First;
begin
  oBtrTable.First;
end;

procedure TIphBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TIphBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TIphBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TIphBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TIphBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TIphBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TIphBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TIphBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TIphBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TIphBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TIphBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
