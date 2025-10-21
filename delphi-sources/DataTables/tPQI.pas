unit tPQI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = '';
  ixItmNum = 'ItmNum';
  ixDocDate = 'DocDate';
  ixDescribe_ = 'Describe_';
  ixIsDocNum = 'IsDocNum';
  ixIsExtNum = 'IsExtNum';

type
  TPqiTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
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
    function  ReadBankSeat:Str30;        procedure WriteBankSeat (pValue:Str30);
    function  ReadIbanCode:Str30;        procedure WriteIbanCode (pValue:Str30);
    function  ReadSwftCode:Str11;        procedure WriteSwftCode (pValue:Str11);
    function  ReadCsyCode:Str4;          procedure WriteCsyCode (pValue:Str4);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadMark:Str1;             procedure WriteMark (pValue:Str1);
    function  ReadSpcSymb:Str12;         procedure WriteSpcSymb (pValue:Str12);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateItmNum (pItmNum:word):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateDescribe_ (pDescribe_:Str30):boolean;
    function LocateIsDocNum (pIsDocNum:Str12):boolean;
    function LocateIsExtNum (pIsExtNum:Str12):boolean;

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
    property BankSeat:Str30 read ReadBankSeat write WriteBankSeat;
    property IbanCode:Str30 read ReadIbanCode write WriteIbanCode;
    property SwftCode:Str11 read ReadSwftCode write WriteSwftCode;
    property CsyCode:Str4 read ReadCsyCode write WriteCsyCode;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property Mark:Str1 read ReadMark write WriteMark;
    property SpcSymb:Str12 read ReadSpcSymb write WriteSpcSymb;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TPqiTmp.Create;
begin
  oTmpTable := TmpInit ('PQI',Self);
end;

destructor TPqiTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TPqiTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TPqiTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TPqiTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TPqiTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TPqiTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TPqiTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TPqiTmp.ReadSerNum:longint;
begin
  Result := oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TPqiTmp.WriteSerNum(pValue:longint);
begin
  oTmpTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TPqiTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TPqiTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TPqiTmp.ReadIsDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('IsDocNum').AsString;
end;

procedure TPqiTmp.WriteIsDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('IsDocNum').AsString := pValue;
end;

function TPqiTmp.ReadIsExtNum:Str12;
begin
  Result := oTmpTable.FieldByName('IsExtNum').AsString;
end;

procedure TPqiTmp.WriteIsExtNum(pValue:Str12);
begin
  oTmpTable.FieldByName('IsExtNum').AsString := pValue;
end;

function TPqiTmp.ReadDescribe:Str30;
begin
  Result := oTmpTable.FieldByName('Describe').AsString;
end;

procedure TPqiTmp.WriteDescribe(pValue:Str30);
begin
  oTmpTable.FieldByName('Describe').AsString := pValue;
end;

function TPqiTmp.ReadDescribe_:Str30;
begin
  Result := oTmpTable.FieldByName('Describe_').AsString;
end;

procedure TPqiTmp.WriteDescribe_(pValue:Str30);
begin
  oTmpTable.FieldByName('Describe_').AsString := pValue;
end;

function TPqiTmp.ReadPayVal:double;
begin
  Result := oTmpTable.FieldByName('PayVal').AsFloat;
end;

procedure TPqiTmp.WritePayVal(pValue:double);
begin
  oTmpTable.FieldByName('PayVal').AsFloat := pValue;
end;

function TPqiTmp.ReadContoNum:Str20;
begin
  Result := oTmpTable.FieldByName('ContoNum').AsString;
end;

procedure TPqiTmp.WriteContoNum(pValue:Str20);
begin
  oTmpTable.FieldByName('ContoNum').AsString := pValue;
end;

function TPqiTmp.ReadBankName:Str35;
begin
  Result := oTmpTable.FieldByName('BankName').AsString;
end;

procedure TPqiTmp.WriteBankName(pValue:Str35);
begin
  oTmpTable.FieldByName('BankName').AsString := pValue;
end;

function TPqiTmp.ReadBankCode:Str4;
begin
  Result := oTmpTable.FieldByName('BankCode').AsString;
end;

procedure TPqiTmp.WriteBankCode(pValue:Str4);
begin
  oTmpTable.FieldByName('BankCode').AsString := pValue;
end;

function TPqiTmp.ReadBankSeat:Str30;
begin
  Result := oTmpTable.FieldByName('BankSeat').AsString;
end;

procedure TPqiTmp.WriteBankSeat(pValue:Str30);
begin
  oTmpTable.FieldByName('BankSeat').AsString := pValue;
end;

function TPqiTmp.ReadIbanCode:Str30;
begin
  Result := oTmpTable.FieldByName('IbanCode').AsString;
end;

procedure TPqiTmp.WriteIbanCode(pValue:Str30);
begin
  oTmpTable.FieldByName('IbanCode').AsString := pValue;
end;

function TPqiTmp.ReadSwftCode:Str11;
begin
  Result := oTmpTable.FieldByName('SwftCode').AsString;
end;

procedure TPqiTmp.WriteSwftCode(pValue:Str11);
begin
  oTmpTable.FieldByName('SwftCode').AsString := pValue;
end;

function TPqiTmp.ReadCsyCode:Str4;
begin
  Result := oTmpTable.FieldByName('CsyCode').AsString;
end;

procedure TPqiTmp.WriteCsyCode(pValue:Str4);
begin
  oTmpTable.FieldByName('CsyCode').AsString := pValue;
end;

function TPqiTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TPqiTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TPqiTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TPqiTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TPqiTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TPqiTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TPqiTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TPqiTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TPqiTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TPqiTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TPqiTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TPqiTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TPqiTmp.ReadMark:Str1;
begin
  Result := oTmpTable.FieldByName('Mark').AsString;
end;

procedure TPqiTmp.WriteMark(pValue:Str1);
begin
  oTmpTable.FieldByName('Mark').AsString := pValue;
end;

function TPqiTmp.ReadSpcSymb:Str12;
begin
  Result := oTmpTable.FieldByName('SpcSymb').AsString;
end;

procedure TPqiTmp.WriteSpcSymb(pValue:Str12);
begin
  oTmpTable.FieldByName('SpcSymb').AsString := pValue;
end;

function TPqiTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TPqiTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPqiTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TPqiTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TPqiTmp.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TPqiTmp.LocateItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oTmpTable.FindKey([pItmNum]);
end;

function TPqiTmp.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oTmpTable.FindKey([pDocDate]);
end;

function TPqiTmp.LocateDescribe_ (pDescribe_:Str30):boolean;
begin
  SetIndex (ixDescribe_);
  Result := oTmpTable.FindKey([pDescribe_]);
end;

function TPqiTmp.LocateIsDocNum (pIsDocNum:Str12):boolean;
begin
  SetIndex (ixIsDocNum);
  Result := oTmpTable.FindKey([pIsDocNum]);
end;

function TPqiTmp.LocateIsExtNum (pIsExtNum:Str12):boolean;
begin
  SetIndex (ixIsExtNum);
  Result := oTmpTable.FindKey([pIsExtNum]);
end;

procedure TPqiTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TPqiTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TPqiTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TPqiTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TPqiTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TPqiTmp.First;
begin
  oTmpTable.First;
end;

procedure TPqiTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TPqiTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TPqiTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TPqiTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TPqiTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TPqiTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TPqiTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TPqiTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TPqiTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TPqiTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TPqiTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2005001}
