unit bPMI;

interface

uses
  IcTypes, IcConv, IcDate, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoItSt = 'DoItSt';
  ixPayDate = 'PayDate';
  ixPaName = 'PaName';
  ixExtNum = 'ExtNum';
  ixPyPayVal = 'PyPayVal';
  ixConDoc = 'ConDoc';
  ixDoCo = 'DoCo';
  ixDoItCd = 'DoItCd';
  ixSended = 'Sended';
  ixDocNum = 'DocNum';

type
  TPmiBtr = class (TComponent)
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
    function  ReadExtNum:Str12;          procedure WriteExtNum (pValue:Str12);
    function  ReadPayDate:TDatetime;     procedure WritePayDate (pValue:TDatetime);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadPaName_:Str30;         procedure WritePaName_ (pValue:Str30);
    function  ReadConDoc:Str12;          procedure WriteConDoc (pValue:Str12);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadAcDvzName:Str3;        procedure WriteAcDvzName (pValue:Str3);
    function  ReadAcPayVal:double;       procedure WriteAcPayVal (pValue:double);
    function  ReadAcCrdVal:double;       procedure WriteAcCrdVal (pValue:double);
    function  ReadPyDvzName:Str3;        procedure WritePyDvzName (pValue:Str3);
    function  ReadPyCourse:double;       procedure WritePyCourse (pValue:double);
    function  ReadPyPayVal:double;       procedure WritePyPayVal (pValue:double);
    function  ReadPyPdfVal:double;       procedure WritePyPdfVal (pValue:double);
    function  ReadFgDvzName:Str3;        procedure WriteFgDvzName (pValue:Str3);
    function  ReadFgCourse:double;       procedure WriteFgCourse (pValue:double);
    function  ReadFgPayVal:double;       procedure WriteFgPayVal (pValue:double);
    function  ReadFgPdfVal:double;       procedure WriteFgPdfVal (pValue:double);
    function  ReadStatus:Str1;           procedure WriteStatus (pValue:Str1);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadCrtUser:str8;          procedure WriteCrtUser (pValue:str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateDoItSt (pDocNum:Str12;pItmNum:word;pStatus:Str1):boolean;
    function LocatePayDate (pPayDate:TDatetime):boolean;
    function LocatePaName (pPaName_:Str30):boolean;
    function LocateExtNum (pExtNum:Str12):boolean;
    function LocatePyPayVal (pPyPayVal:double):boolean;
    function LocateConDoc (pConDoc:Str12):boolean;
    function LocateDoCo (pDocNum:Str12;pConDoc:Str12):boolean;
    function LocateDoItCd (pDocNum:Str12;pItmNum:word;pConDoc:Str12):boolean;
    function LocateSended (pSended:byte):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function NearestDoItSt (pDocNum:Str12;pItmNum:word;pStatus:Str1):boolean;
    function NearestPayDate (pPayDate:TDatetime):boolean;
    function NearestPaName (pPaName_:Str30):boolean;
    function NearestExtNum (pExtNum:Str12):boolean;
    function NearestPyPayVal (pPyPayVal:double):boolean;
    function NearestConDoc (pConDoc:Str12):boolean;
    function NearestDoCo (pDocNum:Str12;pConDoc:Str12):boolean;
    function NearestDoItCd (pDocNum:Str12;pItmNum:word;pConDoc:Str12):boolean;
    function NearestSended (pSended:byte):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pBookNum:Str5);  overload;
    procedure Open (pDate:TDateTime);overload;
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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property ExtNum:Str12 read ReadExtNum write WriteExtNum;
    property PayDate:TDatetime read ReadPayDate write WritePayDate;
    property PaName:Str30 read ReadPaName write WritePaName;
    property PaName_:Str30 read ReadPaName_ write WritePaName_;
    property ConDoc:Str12 read ReadConDoc write WriteConDoc;
    property WriNum:word read ReadWriNum write WriteWriNum;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property AcDvzName:Str3 read ReadAcDvzName write WriteAcDvzName;
    property AcPayVal:double read ReadAcPayVal write WriteAcPayVal;
    property AcCrdVal:double read ReadAcCrdVal write WriteAcCrdVal;
    property PyDvzName:Str3 read ReadPyDvzName write WritePyDvzName;
    property PyCourse:double read ReadPyCourse write WritePyCourse;
    property PyPayVal:double read ReadPyPayVal write WritePyPayVal;
    property PyPdfVal:double read ReadPyPdfVal write WritePyPdfVal;
    property FgDvzName:Str3 read ReadFgDvzName write WriteFgDvzName;
    property FgCourse:double read ReadFgCourse write WriteFgCourse;
    property FgPayVal:double read ReadFgPayVal write WriteFgPayVal;
    property FgPdfVal:double read ReadFgPdfVal write WriteFgPdfVal;
    property Status:Str1 read ReadStatus write WriteStatus;
    property Sended:boolean read ReadSended write WriteSended;
    property CrtUser:str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
  end;

implementation

constructor TPmiBtr.Create;
begin
  oBtrTable := BtrInit ('PMI',gPath.LdgPath,Self);
end;

constructor TPmiBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('PMI',pPath,Self);
end;

destructor TPmiBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPmiBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPmiBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPmiBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TPmiBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TPmiBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TPmiBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TPmiBtr.ReadExtNum:Str12;
begin
  Result := oBtrTable.FieldByName('ExtNum').AsString;
end;

procedure TPmiBtr.WriteExtNum(pValue:Str12);
begin
  oBtrTable.FieldByName('ExtNum').AsString := pValue;
end;

function TPmiBtr.ReadPayDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('PayDate').AsDateTime;
end;

procedure TPmiBtr.WritePayDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('PayDate').AsDateTime := pValue;
end;

function TPmiBtr.ReadPaName:Str30;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TPmiBtr.WritePaName(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TPmiBtr.ReadPaName_:Str30;
begin
  Result := oBtrTable.FieldByName('PaName_').AsString;
end;

procedure TPmiBtr.WritePaName_(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName_').AsString := pValue;
end;

function TPmiBtr.ReadConDoc:Str12;
begin
  Result := oBtrTable.FieldByName('ConDoc').AsString;
end;

procedure TPmiBtr.WriteConDoc(pValue:Str12);
begin
  oBtrTable.FieldByName('ConDoc').AsString := pValue;
end;

function TPmiBtr.ReadWriNum:word;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TPmiBtr.WriteWriNum(pValue:word);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TPmiBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TPmiBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TPmiBtr.ReadAcDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('AcDvzName').AsString;
end;

procedure TPmiBtr.WriteAcDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('AcDvzName').AsString := pValue;
end;

function TPmiBtr.ReadAcPayVal:double;
begin
  Result := oBtrTable.FieldByName('AcPayVal').AsFloat;
end;

procedure TPmiBtr.WriteAcPayVal(pValue:double);
begin
  oBtrTable.FieldByName('AcPayVal').AsFloat := pValue;
end;

function TPmiBtr.ReadAcCrdVal:double;
begin
  Result := oBtrTable.FieldByName('AcCrdVal').AsFloat;
end;

procedure TPmiBtr.WriteAcCrdVal(pValue:double);
begin
  oBtrTable.FieldByName('AcCrdVal').AsFloat := pValue;
end;

function TPmiBtr.ReadPyDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('PyDvzName').AsString;
end;

procedure TPmiBtr.WritePyDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('PyDvzName').AsString := pValue;
end;

function TPmiBtr.ReadPyCourse:double;
begin
  Result := oBtrTable.FieldByName('PyCourse').AsFloat;
end;

procedure TPmiBtr.WritePyCourse(pValue:double);
begin
  oBtrTable.FieldByName('PyCourse').AsFloat := pValue;
end;

function TPmiBtr.ReadPyPayVal:double;
begin
  Result := oBtrTable.FieldByName('PyPayVal').AsFloat;
end;

procedure TPmiBtr.WritePyPayVal(pValue:double);
begin
  oBtrTable.FieldByName('PyPayVal').AsFloat := pValue;
end;

function TPmiBtr.ReadPyPdfVal:double;
begin
  Result := oBtrTable.FieldByName('PyPdfVal').AsFloat;
end;

procedure TPmiBtr.WritePyPdfVal(pValue:double);
begin
  oBtrTable.FieldByName('PyPdfVal').AsFloat := pValue;
end;

function TPmiBtr.ReadFgDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('FgDvzName').AsString;
end;

procedure TPmiBtr.WriteFgDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('FgDvzName').AsString := pValue;
end;

function TPmiBtr.ReadFgCourse:double;
begin
  Result := oBtrTable.FieldByName('FgCourse').AsFloat;
end;

procedure TPmiBtr.WriteFgCourse(pValue:double);
begin
  oBtrTable.FieldByName('FgCourse').AsFloat := pValue;
end;

function TPmiBtr.ReadFgPayVal:double;
begin
  Result := oBtrTable.FieldByName('FgPayVal').AsFloat;
end;

procedure TPmiBtr.WriteFgPayVal(pValue:double);
begin
  oBtrTable.FieldByName('FgPayVal').AsFloat := pValue;
end;

function TPmiBtr.ReadFgPdfVal:double;
begin
  Result := oBtrTable.FieldByName('FgPdfVal').AsFloat;
end;

procedure TPmiBtr.WriteFgPdfVal(pValue:double);
begin
  oBtrTable.FieldByName('FgPdfVal').AsFloat := pValue;
end;

function TPmiBtr.ReadStatus:Str1;
begin
  Result := oBtrTable.FieldByName('Status').AsString;
end;

procedure TPmiBtr.WriteStatus(pValue:Str1);
begin
  oBtrTable.FieldByName('Status').AsString := pValue;
end;

function TPmiBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TPmiBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TPmiBtr.ReadCrtUser:str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TPmiBtr.WriteCrtUser(pValue:str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TPmiBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TPmiBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TPmiBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TPmiBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPmiBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPmiBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TPmiBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPmiBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPmiBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPmiBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPmiBtr.LocateDoItSt (pDocNum:Str12;pItmNum:word;pStatus:Str1):boolean;
begin
  SetIndex (ixDoItSt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum,pStatus]);
end;

function TPmiBtr.LocatePayDate (pPayDate:TDatetime):boolean;
begin
  SetIndex (ixPayDate);
  Result := oBtrTable.FindKey([pPayDate]);
end;

function TPmiBtr.LocatePaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindKey([StrToAlias(pPaName_)]);
end;

function TPmiBtr.LocateExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindKey([pExtNum]);
end;

function TPmiBtr.LocatePyPayVal (pPyPayVal:double):boolean;
begin
  SetIndex (ixPyPayVal);
  Result := oBtrTable.FindKey([pPyPayVal]);
end;

function TPmiBtr.LocateConDoc (pConDoc:Str12):boolean;
begin
  SetIndex (ixConDoc);
  Result := oBtrTable.FindKey([pConDoc]);
end;

function TPmiBtr.LocateDoCo (pDocNum:Str12;pConDoc:Str12):boolean;
begin
  SetIndex (ixDoCo);
  Result := oBtrTable.FindKey([pDocNum,pConDoc]);
end;

function TPmiBtr.LocateDoItCd (pDocNum:Str12;pItmNum:word;pConDoc:Str12):boolean;
begin
  SetIndex (ixDoItCd);
  Result := oBtrTable.FindKey([pDocNum,pItmNum,pConDoc]);
end;

function TPmiBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

function TPmiBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TPmiBtr.NearestDoItSt (pDocNum:Str12;pItmNum:word;pStatus:Str1):boolean;
begin
  SetIndex (ixDoItSt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum,pStatus]);
end;

function TPmiBtr.NearestPayDate (pPayDate:TDatetime):boolean;
begin
  SetIndex (ixPayDate);
  Result := oBtrTable.FindNearest([pPayDate]);
end;

function TPmiBtr.NearestPaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindNearest([pPaName_]);
end;

function TPmiBtr.NearestExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindNearest([pExtNum]);
end;

function TPmiBtr.NearestPyPayVal (pPyPayVal:double):boolean;
begin
  SetIndex (ixPyPayVal);
  Result := oBtrTable.FindNearest([pPyPayVal]);
end;

function TPmiBtr.NearestConDoc (pConDoc:Str12):boolean;
begin
  SetIndex (ixConDoc);
  Result := oBtrTable.FindNearest([pConDoc]);
end;

function TPmiBtr.NearestDoCo (pDocNum:Str12;pConDoc:Str12):boolean;
begin
  SetIndex (ixDoCo);
  Result := oBtrTable.FindNearest([pDocNum,pConDoc]);
end;

function TPmiBtr.NearestDoItCd (pDocNum:Str12;pItmNum:word;pConDoc:Str12):boolean;
begin
  SetIndex (ixDoItCd);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum,pConDoc]);
end;

function TPmiBtr.NearestSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindNearest([pSended]);
end;

function TPmiBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

procedure TPmiBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPmiBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TPmiBtr.Open(pDate:TDateTime);
begin
  oBookNum := YearL(pDate);
  oBtrTable.Open(oBookNum);
end;

procedure TPmiBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPmiBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPmiBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPmiBtr.First;
begin
  oBtrTable.First;
end;

procedure TPmiBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPmiBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPmiBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPmiBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPmiBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPmiBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPmiBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPmiBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPmiBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPmiBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPmiBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
