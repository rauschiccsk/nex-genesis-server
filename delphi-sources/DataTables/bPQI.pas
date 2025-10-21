unit bPQI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = 'DocNum';
  ixDoIt = 'DoIt';
  ixSerNum = 'SerNum';
  ixDocDate = 'DocDate';
  ixDescribe = 'Describe';
  ixIsDocNum = 'IsDocNum';
  ixIsExtNum = 'IsExtNum';

type
  TPqiBtr = class (TComponent)
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
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadIsDocNum:Str12;        procedure WriteIsDocNum (pValue:Str12);
    function  ReadIsExtNum:Str12;        procedure WriteIsExtNum (pValue:Str12);
    function  ReadDescribe:Str30;        procedure WriteDescribe (pValue:Str30);
    function  ReadDescribe_:Str30;       procedure WriteDescribe_ (pValue:Str30);
    function  ReadPayVal:double;         procedure WritePayVal (pValue:double);
    function  ReadContoNum:Str20;        procedure WriteContoNum (pValue:Str20);
    function  ReadBankName:Str35;        procedure WriteBankName (pValue:Str35);
    function  ReadBankCode:Str4;         procedure WriteBankCode (pValue:Str4);
    function  ReadCsyCode:Str4;          procedure WriteCsyCode (pValue:Str4);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadMark:Str1;             procedure WriteMark (pValue:Str1);
    function  ReadSpcSymb:Str12;         procedure WriteSpcSymb (pValue:Str12);
    function  ReadBankSeat:Str30;        procedure WriteBankSeat (pValue:Str30);
    function  ReadIbanCode:Str30;        procedure WriteIbanCode (pValue:Str30);
    function  ReadSwftCode:Str11;        procedure WriteSwftCode (pValue:Str11);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateSerNum (pSerNum:longint):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateDescribe (pDescribe_:Str30):boolean;
    function LocateIsDocNum (pIsDocNum:Str12):boolean;
    function LocateIsExtNum (pIsExtNum:Str12):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function NearestSerNum (pSerNum:longint):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;
    function NearestDescribe (pDescribe_:Str30):boolean;
    function NearestIsDocNum (pIsDocNum:Str12):boolean;
    function NearestIsExtNum (pIsExtNum:Str12):boolean;

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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property IsDocNum:Str12 read ReadIsDocNum write WriteIsDocNum;
    property IsExtNum:Str12 read ReadIsExtNum write WriteIsExtNum;
    property Describe:Str30 read ReadDescribe write WriteDescribe;
    property Describe_:Str30 read ReadDescribe_ write WriteDescribe_;
    property PayVal:double read ReadPayVal write WritePayVal;
    property ContoNum:Str20 read ReadContoNum write WriteContoNum;
    property BankName:Str35 read ReadBankName write WriteBankName;
    property BankCode:Str4 read ReadBankCode write WriteBankCode;
    property CsyCode:Str4 read ReadCsyCode write WriteCsyCode;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property Mark:Str1 read ReadMark write WriteMark;
    property SpcSymb:Str12 read ReadSpcSymb write WriteSpcSymb;
    property BankSeat:Str30 read ReadBankSeat write WriteBankSeat;
    property IbanCode:Str30 read ReadIbanCode write WriteIbanCode;
    property SwftCode:Str11 read ReadSwftCode write WriteSwftCode;
  end;

implementation

constructor TPqiBtr.Create;
begin
  oBtrTable := BtrInit ('PQI',gPath.LdgPath,Self);
end;

constructor TPqiBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('PQI',pPath,Self);
end;

destructor TPqiBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPqiBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPqiBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPqiBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TPqiBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TPqiBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TPqiBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TPqiBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TPqiBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TPqiBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TPqiBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TPqiBtr.ReadIsDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('IsDocNum').AsString;
end;

procedure TPqiBtr.WriteIsDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('IsDocNum').AsString := pValue;
end;

function TPqiBtr.ReadIsExtNum:Str12;
begin
  Result := oBtrTable.FieldByName('IsExtNum').AsString;
end;

procedure TPqiBtr.WriteIsExtNum(pValue:Str12);
begin
  oBtrTable.FieldByName('IsExtNum').AsString := pValue;
end;

function TPqiBtr.ReadDescribe:Str30;
begin
  Result := oBtrTable.FieldByName('Describe').AsString;
end;

procedure TPqiBtr.WriteDescribe(pValue:Str30);
begin
  oBtrTable.FieldByName('Describe').AsString := pValue;
end;

function TPqiBtr.ReadDescribe_:Str30;
begin
  Result := oBtrTable.FieldByName('Describe_').AsString;
end;

procedure TPqiBtr.WriteDescribe_(pValue:Str30);
begin
  oBtrTable.FieldByName('Describe_').AsString := pValue;
end;

function TPqiBtr.ReadPayVal:double;
begin
  Result := oBtrTable.FieldByName('PayVal').AsFloat;
end;

procedure TPqiBtr.WritePayVal(pValue:double);
begin
  oBtrTable.FieldByName('PayVal').AsFloat := pValue;
end;

function TPqiBtr.ReadContoNum:Str20;
begin
  Result := oBtrTable.FieldByName('ContoNum').AsString;
end;

procedure TPqiBtr.WriteContoNum(pValue:Str20);
begin
  oBtrTable.FieldByName('ContoNum').AsString := pValue;
end;

function TPqiBtr.ReadBankName:Str35;
begin
  Result := oBtrTable.FieldByName('BankName').AsString;
end;

procedure TPqiBtr.WriteBankName(pValue:Str35);
begin
  oBtrTable.FieldByName('BankName').AsString := pValue;
end;

function TPqiBtr.ReadBankCode:Str4;
begin
  Result := oBtrTable.FieldByName('BankCode').AsString;
end;

procedure TPqiBtr.WriteBankCode(pValue:Str4);
begin
  oBtrTable.FieldByName('BankCode').AsString := pValue;
end;

function TPqiBtr.ReadCsyCode:Str4;
begin
  Result := oBtrTable.FieldByName('CsyCode').AsString;
end;

procedure TPqiBtr.WriteCsyCode(pValue:Str4);
begin
  oBtrTable.FieldByName('CsyCode').AsString := pValue;
end;

function TPqiBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TPqiBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TPqiBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TPqiBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TPqiBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TPqiBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TPqiBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TPqiBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TPqiBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TPqiBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TPqiBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TPqiBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TPqiBtr.ReadMark:Str1;
begin
  Result := oBtrTable.FieldByName('Mark').AsString;
end;

procedure TPqiBtr.WriteMark(pValue:Str1);
begin
  oBtrTable.FieldByName('Mark').AsString := pValue;
end;

function TPqiBtr.ReadSpcSymb:Str12;
begin
  Result := oBtrTable.FieldByName('SpcSymb').AsString;
end;

procedure TPqiBtr.WriteSpcSymb(pValue:Str12);
begin
  oBtrTable.FieldByName('SpcSymb').AsString := pValue;
end;

function TPqiBtr.ReadBankSeat:Str30;
begin
  Result := oBtrTable.FieldByName('BankSeat').AsString;
end;

procedure TPqiBtr.WriteBankSeat(pValue:Str30);
begin
  oBtrTable.FieldByName('BankSeat').AsString := pValue;
end;

function TPqiBtr.ReadIbanCode:Str30;
begin
  Result := oBtrTable.FieldByName('IbanCode').AsString;
end;

procedure TPqiBtr.WriteIbanCode(pValue:Str30);
begin
  oBtrTable.FieldByName('IbanCode').AsString := pValue;
end;

function TPqiBtr.ReadSwftCode:Str11;
begin
  Result := oBtrTable.FieldByName('SwftCode').AsString;
end;

procedure TPqiBtr.WriteSwftCode(pValue:Str11);
begin
  oBtrTable.FieldByName('SwftCode').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPqiBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPqiBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TPqiBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPqiBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPqiBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPqiBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPqiBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TPqiBtr.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TPqiBtr.LocateSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindKey([pSerNum]);
end;

function TPqiBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TPqiBtr.LocateDescribe (pDescribe_:Str30):boolean;
begin
  SetIndex (ixDescribe);
  Result := oBtrTable.FindKey([StrToAlias(pDescribe_)]);
end;

function TPqiBtr.LocateIsDocNum (pIsDocNum:Str12):boolean;
begin
  SetIndex (ixIsDocNum);
  Result := oBtrTable.FindKey([pIsDocNum]);
end;

function TPqiBtr.LocateIsExtNum (pIsExtNum:Str12):boolean;
begin
  SetIndex (ixIsExtNum);
  Result := oBtrTable.FindKey([pIsExtNum]);
end;

function TPqiBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TPqiBtr.NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TPqiBtr.NearestSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindNearest([pSerNum]);
end;

function TPqiBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TPqiBtr.NearestDescribe (pDescribe_:Str30):boolean;
begin
  SetIndex (ixDescribe);
  Result := oBtrTable.FindNearest([pDescribe_]);
end;

function TPqiBtr.NearestIsDocNum (pIsDocNum:Str12):boolean;
begin
  SetIndex (ixIsDocNum);
  Result := oBtrTable.FindNearest([pIsDocNum]);
end;

function TPqiBtr.NearestIsExtNum (pIsExtNum:Str12):boolean;
begin
  SetIndex (ixIsExtNum);
  Result := oBtrTable.FindNearest([pIsExtNum]);
end;

procedure TPqiBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPqiBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TPqiBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPqiBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPqiBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPqiBtr.First;
begin
  oBtrTable.First;
end;

procedure TPqiBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPqiBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPqiBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPqiBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPqiBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPqiBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPqiBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPqiBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPqiBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPqiBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPqiBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 2005001}
