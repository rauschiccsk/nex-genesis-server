unit bFXA;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSerNum = 'SerNum';
  ixDocNum = 'DocNum';
  ixFxaName = 'FxaName';
  ixWriNum = 'WriNum';
  ixBegDate = 'BegDate';
  ixExtNum = 'ExtNum';
  ixDocDate = 'DocDate';
  ixClasCode = 'ClasCode';
  ixPrvDoc = 'PrvDoc';
  ixPrvDate = 'PrvDate';
  ixPrvVal = 'PrvVal';
  ixPaCode = 'PaCode';

type
  TFxaBtr = class (TComponent)
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
    function  ReadFxaName:Str30;         procedure WriteFxaName (pValue:Str30);
    function  ReadFxaName_:Str30;        procedure WriteFxaName_ (pValue:Str30);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadWriNum:longint;        procedure WriteWriNum (pValue:longint);
    function  ReadClasCode:Str10;        procedure WriteClasCode (pValue:Str10);
    function  ReadPrvDoc:Str12;          procedure WritePrvDoc (pValue:Str12);
    function  ReadPrvMode:byte;          procedure WritePrvMode (pValue:byte);
    function  ReadPrvDate:TDatetime;     procedure WritePrvDate (pValue:TDatetime);
    function  ReadPrvVal:double;         procedure WritePrvVal (pValue:double);
    function  ReadBegDoc:Str12;          procedure WriteBegDoc (pValue:Str12);
    function  ReadBegDate:TDatetime;     procedure WriteBegDate (pValue:TDatetime);
    function  ReadAsdDoc:Str12;          procedure WriteAsdDoc (pValue:Str12);
    function  ReadAsdDate:TDatetime;     procedure WriteAsdDate (pValue:TDatetime);
    function  ReadAsdMode:integer;       procedure WriteAsdMode (pValue:integer);
    function  ReadChgVal:double;         procedure WriteChgVal (pValue:double);
    function  ReadModVal:double;         procedure WriteModVal (pValue:double);
    function  ReadSuVal:double;          procedure WriteSuVal (pValue:double);
    function  ReadTEndVal:double;        procedure WriteTEndVal (pValue:double);
    function  ReadLEndVal:double;        procedure WriteLEndVal (pValue:double);
    function  ReadFxaType:byte;          procedure WriteFxaType (pValue:byte);
    function  ReadTsuGrp:byte;           procedure WriteTsuGrp (pValue:byte);
    function  ReadTsuMode:byte;          procedure WriteTsuMode (pValue:byte);
    function  ReadTsuYear:byte;          procedure WriteTsuYear (pValue:byte);
    function  ReadTItmQnt:byte;          procedure WriteTItmQnt (pValue:byte);
    function  ReadLsuMode:byte;          procedure WriteLsuMode (pValue:byte);
    function  ReadLsuYear:byte;          procedure WriteLsuYear (pValue:byte);
    function  ReadLItmQnt:word;          procedure WriteLItmQnt (pValue:word);
    function  ReadFxaGrp:longint;        procedure WriteFxaGrp (pValue:longint);
    function  ReadStatus:Str1;           procedure WriteStatus (pValue:Str1);
    function  ReadCrtName:Str8;          procedure WriteCrtName (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadUseName:Str30;         procedure WriteUseName (pValue:Str30);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateSerNum (pSerNum:longint):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateFxaName (pFxaName_:Str30):boolean;
    function LocateWriNum (pWriNum:longint):boolean;
    function LocateBegDate (pBegDate:TDatetime):boolean;
    function LocateExtNum (pExtNum:Str12):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateClasCode (pClasCode:Str10):boolean;
    function LocatePrvDoc (pPrvDoc:Str12):boolean;
    function LocatePrvDate (pPrvDate:TDatetime):boolean;
    function LocatePrvVal (pPrvVal:double):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function NearestSerNum (pSerNum:longint):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestFxaName (pFxaName_:Str30):boolean;
    function NearestWriNum (pWriNum:longint):boolean;
    function NearestBegDate (pBegDate:TDatetime):boolean;
    function NearestExtNum (pExtNum:Str12):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;
    function NearestClasCode (pClasCode:Str10):boolean;
    function NearestPrvDoc (pPrvDoc:Str12):boolean;
    function NearestPrvDate (pPrvDate:TDatetime):boolean;
    function NearestPrvVal (pPrvVal:double):boolean;
    function NearestPaCode (pPaCode:longint):boolean;

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
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ExtNum:Str12 read ReadExtNum write WriteExtNum;
    property FxaName:Str30 read ReadFxaName write WriteFxaName;
    property FxaName_:Str30 read ReadFxaName_ write WriteFxaName_;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property WriNum:longint read ReadWriNum write WriteWriNum;
    property ClasCode:Str10 read ReadClasCode write WriteClasCode;
    property PrvDoc:Str12 read ReadPrvDoc write WritePrvDoc;
    property PrvMode:byte read ReadPrvMode write WritePrvMode;
    property PrvDate:TDatetime read ReadPrvDate write WritePrvDate;
    property PrvVal:double read ReadPrvVal write WritePrvVal;
    property BegDoc:Str12 read ReadBegDoc write WriteBegDoc;
    property BegDate:TDatetime read ReadBegDate write WriteBegDate;
    property AsdDoc:Str12 read ReadAsdDoc write WriteAsdDoc;
    property AsdDate:TDatetime read ReadAsdDate write WriteAsdDate;
    property AsdMode:integer read ReadAsdMode write WriteAsdMode;
    property ChgVal:double read ReadChgVal write WriteChgVal;
    property ModVal:double read ReadModVal write WriteModVal;
    property SuVal:double read ReadSuVal write WriteSuVal;
    property TEndVal:double read ReadTEndVal write WriteTEndVal;
    property LEndVal:double read ReadLEndVal write WriteLEndVal;
    property FxaType:byte read ReadFxaType write WriteFxaType;
    property TsuGrp:byte read ReadTsuGrp write WriteTsuGrp;
    property TsuMode:byte read ReadTsuMode write WriteTsuMode;
    property TsuYear:byte read ReadTsuYear write WriteTsuYear;
    property TItmQnt:byte read ReadTItmQnt write WriteTItmQnt;
    property LsuMode:byte read ReadLsuMode write WriteLsuMode;
    property LsuYear:byte read ReadLsuYear write WriteLsuYear;
    property LItmQnt:word read ReadLItmQnt write WriteLItmQnt;
    property FxaGrp:longint read ReadFxaGrp write WriteFxaGrp;
    property Status:Str1 read ReadStatus write WriteStatus;
    property CrtName:Str8 read ReadCrtName write WriteCrtName;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property UseName:Str30 read ReadUseName write WriteUseName;
  end;

implementation

constructor TFxaBtr.Create;
begin
  oBtrTable := BtrInit ('FXA',gPath.LdgPath,Self);
end;

constructor TFxaBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('FXA',pPath,Self);
end;

destructor TFxaBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TFxaBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TFxaBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TFxaBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TFxaBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TFxaBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TFxaBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TFxaBtr.ReadExtNum:Str12;
begin
  Result := oBtrTable.FieldByName('ExtNum').AsString;
end;

procedure TFxaBtr.WriteExtNum(pValue:Str12);
begin
  oBtrTable.FieldByName('ExtNum').AsString := pValue;
end;

function TFxaBtr.ReadFxaName:Str30;
begin
  Result := oBtrTable.FieldByName('FxaName').AsString;
end;

procedure TFxaBtr.WriteFxaName(pValue:Str30);
begin
  oBtrTable.FieldByName('FxaName').AsString := pValue;
end;

function TFxaBtr.ReadFxaName_:Str30;
begin
  Result := oBtrTable.FieldByName('FxaName_').AsString;
end;

procedure TFxaBtr.WriteFxaName_(pValue:Str30);
begin
  oBtrTable.FieldByName('FxaName_').AsString := pValue;
end;

function TFxaBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TFxaBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TFxaBtr.ReadWriNum:longint;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TFxaBtr.WriteWriNum(pValue:longint);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TFxaBtr.ReadClasCode:Str10;
begin
  Result := oBtrTable.FieldByName('ClasCode').AsString;
end;

procedure TFxaBtr.WriteClasCode(pValue:Str10);
begin
  oBtrTable.FieldByName('ClasCode').AsString := pValue;
end;

function TFxaBtr.ReadPrvDoc:Str12;
begin
  Result := oBtrTable.FieldByName('PrvDoc').AsString;
end;

procedure TFxaBtr.WritePrvDoc(pValue:Str12);
begin
  oBtrTable.FieldByName('PrvDoc').AsString := pValue;
end;

function TFxaBtr.ReadPrvMode:byte;
begin
  Result := oBtrTable.FieldByName('PrvMode').AsInteger;
end;

procedure TFxaBtr.WritePrvMode(pValue:byte);
begin
  oBtrTable.FieldByName('PrvMode').AsInteger := pValue;
end;

function TFxaBtr.ReadPrvDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('PrvDate').AsDateTime;
end;

procedure TFxaBtr.WritePrvDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('PrvDate').AsDateTime := pValue;
end;

function TFxaBtr.ReadPrvVal:double;
begin
  Result := oBtrTable.FieldByName('PrvVal').AsFloat;
end;

procedure TFxaBtr.WritePrvVal(pValue:double);
begin
  oBtrTable.FieldByName('PrvVal').AsFloat := pValue;
end;

function TFxaBtr.ReadBegDoc:Str12;
begin
  Result := oBtrTable.FieldByName('BegDoc').AsString;
end;

procedure TFxaBtr.WriteBegDoc(pValue:Str12);
begin
  oBtrTable.FieldByName('BegDoc').AsString := pValue;
end;

function TFxaBtr.ReadBegDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegDate').AsDateTime;
end;

procedure TFxaBtr.WriteBegDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegDate').AsDateTime := pValue;
end;

function TFxaBtr.ReadAsdDoc:Str12;
begin
  Result := oBtrTable.FieldByName('AsdDoc').AsString;
end;

procedure TFxaBtr.WriteAsdDoc(pValue:Str12);
begin
  oBtrTable.FieldByName('AsdDoc').AsString := pValue;
end;

function TFxaBtr.ReadAsdDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('AsdDate').AsDateTime;
end;

procedure TFxaBtr.WriteAsdDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('AsdDate').AsDateTime := pValue;
end;

function TFxaBtr.ReadAsdMode:integer;
begin
  Result := oBtrTable.FieldByName('AsdMode').AsVariant;
end;

procedure TFxaBtr.WriteAsdMode(pValue:integer);
begin
  oBtrTable.FieldByName('AsdMode').AsVariant := pValue;
end;

function TFxaBtr.ReadChgVal:double;
begin
  Result := oBtrTable.FieldByName('ChgVal').AsFloat;
end;

procedure TFxaBtr.WriteChgVal(pValue:double);
begin
  oBtrTable.FieldByName('ChgVal').AsFloat := pValue;
end;

function TFxaBtr.ReadModVal:double;
begin
  Result := oBtrTable.FieldByName('ModVal').AsFloat;
end;

procedure TFxaBtr.WriteModVal(pValue:double);
begin
  oBtrTable.FieldByName('ModVal').AsFloat := pValue;
end;

function TFxaBtr.ReadSuVal:double;
begin
  Result := oBtrTable.FieldByName('SuVal').AsFloat;
end;

procedure TFxaBtr.WriteSuVal(pValue:double);
begin
  oBtrTable.FieldByName('SuVal').AsFloat := pValue;
end;

function TFxaBtr.ReadTEndVal:double;
begin
  Result := oBtrTable.FieldByName('TEndVal').AsFloat;
end;

procedure TFxaBtr.WriteTEndVal(pValue:double);
begin
  oBtrTable.FieldByName('TEndVal').AsFloat := pValue;
end;

function TFxaBtr.ReadLEndVal:double;
begin
  Result := oBtrTable.FieldByName('LEndVal').AsFloat;
end;

procedure TFxaBtr.WriteLEndVal(pValue:double);
begin
  oBtrTable.FieldByName('LEndVal').AsFloat := pValue;
end;

function TFxaBtr.ReadFxaType:byte;
begin
  Result := oBtrTable.FieldByName('FxaType').AsInteger;
end;

procedure TFxaBtr.WriteFxaType(pValue:byte);
begin
  oBtrTable.FieldByName('FxaType').AsInteger := pValue;
end;

function TFxaBtr.ReadTsuGrp:byte;
begin
  Result := oBtrTable.FieldByName('TsuGrp').AsInteger;
end;

procedure TFxaBtr.WriteTsuGrp(pValue:byte);
begin
  oBtrTable.FieldByName('TsuGrp').AsInteger := pValue;
end;

function TFxaBtr.ReadTsuMode:byte;
begin
  Result := oBtrTable.FieldByName('TsuMode').AsInteger;
end;

procedure TFxaBtr.WriteTsuMode(pValue:byte);
begin
  oBtrTable.FieldByName('TsuMode').AsInteger := pValue;
end;

function TFxaBtr.ReadTsuYear:byte;
begin
  Result := oBtrTable.FieldByName('TsuYear').AsInteger;
end;

procedure TFxaBtr.WriteTsuYear(pValue:byte);
begin
  oBtrTable.FieldByName('TsuYear').AsInteger := pValue;
end;

function TFxaBtr.ReadTItmQnt:byte;
begin
  Result := oBtrTable.FieldByName('TItmQnt').AsInteger;
end;

procedure TFxaBtr.WriteTItmQnt(pValue:byte);
begin
  oBtrTable.FieldByName('TItmQnt').AsInteger := pValue;
end;

function TFxaBtr.ReadLsuMode:byte;
begin
  Result := oBtrTable.FieldByName('LsuMode').AsInteger;
end;

procedure TFxaBtr.WriteLsuMode(pValue:byte);
begin
  oBtrTable.FieldByName('LsuMode').AsInteger := pValue;
end;

function TFxaBtr.ReadLsuYear:byte;
begin
  Result := oBtrTable.FieldByName('LsuYear').AsInteger;
end;

procedure TFxaBtr.WriteLsuYear(pValue:byte);
begin
  oBtrTable.FieldByName('LsuYear').AsInteger := pValue;
end;

function TFxaBtr.ReadLItmQnt:word;
begin
  Result := oBtrTable.FieldByName('LItmQnt').AsInteger;
end;

procedure TFxaBtr.WriteLItmQnt(pValue:word);
begin
  oBtrTable.FieldByName('LItmQnt').AsInteger := pValue;
end;

function TFxaBtr.ReadFxaGrp:longint;
begin
  Result := oBtrTable.FieldByName('FxaGrp').AsInteger;
end;

procedure TFxaBtr.WriteFxaGrp(pValue:longint);
begin
  oBtrTable.FieldByName('FxaGrp').AsInteger := pValue;
end;

function TFxaBtr.ReadStatus:Str1;
begin
  Result := oBtrTable.FieldByName('Status').AsString;
end;

procedure TFxaBtr.WriteStatus(pValue:Str1);
begin
  oBtrTable.FieldByName('Status').AsString := pValue;
end;

function TFxaBtr.ReadCrtName:Str8;
begin
  Result := oBtrTable.FieldByName('CrtName').AsString;
end;

procedure TFxaBtr.WriteCrtName(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtName').AsString := pValue;
end;

function TFxaBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TFxaBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TFxaBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TFxaBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TFxaBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TFxaBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TFxaBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TFxaBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TFxaBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TFxaBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TFxaBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TFxaBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TFxaBtr.ReadPaName:Str30;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TFxaBtr.WritePaName(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TFxaBtr.ReadUseName:Str30;
begin
  Result := oBtrTable.FieldByName('UseName').AsString;
end;

procedure TFxaBtr.WriteUseName(pValue:Str30);
begin
  oBtrTable.FieldByName('UseName').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TFxaBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TFxaBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TFxaBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TFxaBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TFxaBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TFxaBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TFxaBtr.LocateSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindKey([pSerNum]);
end;

function TFxaBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TFxaBtr.LocateFxaName (pFxaName_:Str30):boolean;
begin
  SetIndex (ixFxaName);
  Result := oBtrTable.FindKey([StrToAlias(pFxaName_)]);
end;

function TFxaBtr.LocateWriNum (pWriNum:longint):boolean;
begin
  SetIndex (ixWriNum);
  Result := oBtrTable.FindKey([pWriNum]);
end;

function TFxaBtr.LocateBegDate (pBegDate:TDatetime):boolean;
begin
  SetIndex (ixBegDate);
  Result := oBtrTable.FindKey([pBegDate]);
end;

function TFxaBtr.LocateExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindKey([pExtNum]);
end;

function TFxaBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TFxaBtr.LocateClasCode (pClasCode:Str10):boolean;
begin
  SetIndex (ixClasCode);
  Result := oBtrTable.FindKey([pClasCode]);
end;

function TFxaBtr.LocatePrvDoc (pPrvDoc:Str12):boolean;
begin
  SetIndex (ixPrvDoc);
  Result := oBtrTable.FindKey([pPrvDoc]);
end;

function TFxaBtr.LocatePrvDate (pPrvDate:TDatetime):boolean;
begin
  SetIndex (ixPrvDate);
  Result := oBtrTable.FindKey([pPrvDate]);
end;

function TFxaBtr.LocatePrvVal (pPrvVal:double):boolean;
begin
  SetIndex (ixPrvVal);
  Result := oBtrTable.FindKey([pPrvVal]);
end;

function TFxaBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TFxaBtr.NearestSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindNearest([pSerNum]);
end;

function TFxaBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TFxaBtr.NearestFxaName (pFxaName_:Str30):boolean;
begin
  SetIndex (ixFxaName);
  Result := oBtrTable.FindNearest([pFxaName_]);
end;

function TFxaBtr.NearestWriNum (pWriNum:longint):boolean;
begin
  SetIndex (ixWriNum);
  Result := oBtrTable.FindNearest([pWriNum]);
end;

function TFxaBtr.NearestBegDate (pBegDate:TDatetime):boolean;
begin
  SetIndex (ixBegDate);
  Result := oBtrTable.FindNearest([pBegDate]);
end;

function TFxaBtr.NearestExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindNearest([pExtNum]);
end;

function TFxaBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TFxaBtr.NearestClasCode (pClasCode:Str10):boolean;
begin
  SetIndex (ixClasCode);
  Result := oBtrTable.FindNearest([pClasCode]);
end;

function TFxaBtr.NearestPrvDoc (pPrvDoc:Str12):boolean;
begin
  SetIndex (ixPrvDoc);
  Result := oBtrTable.FindNearest([pPrvDoc]);
end;

function TFxaBtr.NearestPrvDate (pPrvDate:TDatetime):boolean;
begin
  SetIndex (ixPrvDate);
  Result := oBtrTable.FindNearest([pPrvDate]);
end;

function TFxaBtr.NearestPrvVal (pPrvVal:double):boolean;
begin
  SetIndex (ixPrvVal);
  Result := oBtrTable.FindNearest([pPrvVal]);
end;

function TFxaBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

procedure TFxaBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TFxaBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TFxaBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TFxaBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TFxaBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TFxaBtr.First;
begin
  oBtrTable.First;
end;

procedure TFxaBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TFxaBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TFxaBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TFxaBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TFxaBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TFxaBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TFxaBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TFxaBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TFxaBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TFxaBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TFxaBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
