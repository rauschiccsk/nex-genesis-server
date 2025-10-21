unit bPabacc;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPaCode = 'PaCode';
  ixPaDf = 'PaDf';
  ixContoNum = 'ContoNum';

type
  TPabaccBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadContoNum:Str30;        procedure WriteContoNum (pValue:Str30);
    function  ReadBankCode:Str4;         procedure WriteBankCode (pValue:Str4);
    function  ReadBankName:Str30;        procedure WriteBankName (pValue:Str30);
    function  ReadBankSeat:Str30;        procedure WriteBankSeat (pValue:Str30);
    function  ReadIbanCode:Str34;        procedure WriteIbanCode (pValue:Str34);
    function  ReadSwftCode:Str20;        procedure WriteSwftCode (pValue:Str20);
    function  ReadDefault:Str1;          procedure WriteDefault (pValue:Str1);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaDf (pPaCode:longint;pDefault:Str1):boolean;
    function LocateContoNum (pContoNum:Str30):boolean;

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
    procedure EnableControls;
    procedure DisableControls;
  published
    property BtrTable:TNexBtrTable read oBtrTable;
    property Count:integer read ReadCount;
    // Pristup k databazovym poliam
    property PaCode:longint read ReadPaCode write WritePaCode;
    property ContoNum:Str30 read ReadContoNum write WriteContoNum;
    property BankCode:Str4 read ReadBankCode write WriteBankCode;
    property BankName:Str30 read ReadBankName write WriteBankName;
    property BankSeat:Str30 read ReadBankSeat write WriteBankSeat;
    property IbanCode:Str34 read ReadIbanCode write WriteIbanCode;
    property SwftCode:Str20 read ReadSwftCode write WriteSwftCode;
    property Default:Str1 read ReadDefault write WriteDefault;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TPabaccBtr.Create;
begin
  oBtrTable := BtrInit ('PABACC',gPath.DlsPath,Self);
end;

constructor TPabaccBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('PABACC',pPath,Self);
end;

destructor TPabaccBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPabaccBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPabaccBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPabaccBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TPabaccBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TPabaccBtr.ReadContoNum:Str30;
begin
  Result := oBtrTable.FieldByName('ContoNum').AsString;
end;

procedure TPabaccBtr.WriteContoNum(pValue:Str30);
begin
  oBtrTable.FieldByName('ContoNum').AsString := pValue;
end;

function TPabaccBtr.ReadBankCode:Str4;
begin
  Result := oBtrTable.FieldByName('BankCode').AsString;
end;

procedure TPabaccBtr.WriteBankCode(pValue:Str4);
begin
  oBtrTable.FieldByName('BankCode').AsString := pValue;
end;

function TPabaccBtr.ReadBankName:Str30;
begin
  Result := oBtrTable.FieldByName('BankName').AsString;
end;

procedure TPabaccBtr.WriteBankName(pValue:Str30);
begin
  oBtrTable.FieldByName('BankName').AsString := pValue;
end;

function TPabaccBtr.ReadBankSeat:Str30;
begin
  Result := oBtrTable.FieldByName('BankSeat').AsString;
end;

procedure TPabaccBtr.WriteBankSeat(pValue:Str30);
begin
  oBtrTable.FieldByName('BankSeat').AsString := pValue;
end;

function TPabaccBtr.ReadIbanCode:Str34;
begin
  Result := oBtrTable.FieldByName('IbanCode').AsString;
end;

procedure TPabaccBtr.WriteIbanCode(pValue:Str34);
begin
  oBtrTable.FieldByName('IbanCode').AsString := pValue;
end;

function TPabaccBtr.ReadSwftCode:Str20;
begin
  Result := oBtrTable.FieldByName('SwftCode').AsString;
end;

procedure TPabaccBtr.WriteSwftCode(pValue:Str20);
begin
  oBtrTable.FieldByName('SwftCode').AsString := pValue;
end;

function TPabaccBtr.ReadDefault:Str1;
begin
  Result := oBtrTable.FieldByName('Default').AsString;
end;

procedure TPabaccBtr.WriteDefault(pValue:Str1);
begin
  oBtrTable.FieldByName('Default').AsString := pValue;
end;

function TPabaccBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TPabaccBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TPabaccBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TPabaccBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TPabaccBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TPabaccBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TPabaccBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TPabaccBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TPabaccBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TPabaccBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TPabaccBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TPabaccBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TPabaccBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TPabaccBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPabaccBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPabaccBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPabaccBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPabaccBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPabaccBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TPabaccBtr.LocatePaDf (pPaCode:longint;pDefault:Str1):boolean;
begin
  SetIndex (ixPaDf);
  Result := oBtrTable.FindKey([pPaCode,pDefault]);
end;

function TPabaccBtr.LocateContoNum (pContoNum:Str30):boolean;
begin
  SetIndex (ixContoNum);
  Result := oBtrTable.FindKey([pContoNum]);
end;

procedure TPabaccBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPabaccBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TPabaccBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPabaccBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPabaccBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPabaccBtr.First;
begin
  oBtrTable.First;
end;

procedure TPabaccBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPabaccBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPabaccBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPabaccBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPabaccBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPabaccBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPabaccBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPabaccBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPabaccBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPabaccBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPabaccBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
