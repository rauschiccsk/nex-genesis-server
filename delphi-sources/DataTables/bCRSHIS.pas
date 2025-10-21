unit bCRSHIS;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixCrsDate = 'CrsDate';
  ixSended = 'Sended';

type
  TCrshisBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    // Pristup k databazovym poliam
    function  ReadCrsDate:TDatetime;     procedure WriteCrsDate (pValue:TDatetime);
    function  ReadEUR:double;            procedure WriteEUR (pValue:double);
    function  ReadUSD:double;            procedure WriteUSD (pValue:double);
    function  ReadCZK:double;            procedure WriteCZK (pValue:double);
    function  ReadAUD:double;            procedure WriteAUD (pValue:double);
    function  ReadCYP:double;            procedure WriteCYP (pValue:double);
    function  ReadDKK:double;            procedure WriteDKK (pValue:double);
    function  ReadEEK:double;            procedure WriteEEK (pValue:double);
    function  ReadJPY:double;            procedure WriteJPY (pValue:double);
    function  ReadCAD:double;            procedure WriteCAD (pValue:double);
    function  ReadLTL:double;            procedure WriteLTL (pValue:double);
    function  ReadLVL:double;            procedure WriteLVL (pValue:double);
    function  ReadHUF:double;            procedure WriteHUF (pValue:double);
    function  ReadMTL:double;            procedure WriteMTL (pValue:double);
    function  ReadNOK:double;            procedure WriteNOK (pValue:double);
    function  ReadPLN:double;            procedure WritePLN (pValue:double);
    function  ReadSIT:double;            procedure WriteSIT (pValue:double);
    function  ReadCHF:double;            procedure WriteCHF (pValue:double);
    function  ReadSEK:double;            procedure WriteSEK (pValue:double);
    function  ReadGBP:double;            procedure WriteGBP (pValue:double);
    function  ReadXDR:double;            procedure WriteXDR (pValue:double);
    function  ReadRes1:double;           procedure WriteRes1 (pValue:double);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
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
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateCrsDate (pCrsDate:TDatetime):boolean;
    function LocateSended (pSended:byte):boolean;
    function NearestCrsDate (pCrsDate:TDatetime):boolean;
    function NearestSended (pSended:byte):boolean;
    function FieldExist (pFieldName:ShortString): boolean;

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
    property CrsDate:TDatetime read ReadCrsDate write WriteCrsDate;
    property EUR:double read ReadEUR write WriteEUR;
    property USD:double read ReadUSD write WriteUSD;
    property CZK:double read ReadCZK write WriteCZK;
    property AUD:double read ReadAUD write WriteAUD;
    property CYP:double read ReadCYP write WriteCYP;
    property DKK:double read ReadDKK write WriteDKK;
    property EEK:double read ReadEEK write WriteEEK;
    property JPY:double read ReadJPY write WriteJPY;
    property CAD:double read ReadCAD write WriteCAD;
    property LTL:double read ReadLTL write WriteLTL;
    property LVL:double read ReadLVL write WriteLVL;
    property HUF:double read ReadHUF write WriteHUF;
    property MTL:double read ReadMTL write WriteMTL;
    property NOK:double read ReadNOK write WriteNOK;
    property PLN:double read ReadPLN write WritePLN;
    property SIT:double read ReadSIT write WriteSIT;
    property CHF:double read ReadCHF write WriteCHF;
    property SEK:double read ReadSEK write WriteSEK;
    property GBP:double read ReadGBP write WriteGBP;
    property XDR:double read ReadXDR write WriteXDR;
    property Res1:double read ReadRes1 write WriteRes1;
    property Sended:boolean read ReadSended write WriteSended;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TCrshisBtr.Create;
begin
  oBtrTable := BtrInit ('CRSHIS',gPath.LdgPath,Self);
end;

constructor TCrshisBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('CRSHIS',pPath,Self);
end;

destructor TCrshisBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TCrshisBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TCrshisBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TCrshisBtr.ReadCrsDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrsDate').AsDateTime;
end;

procedure TCrshisBtr.WriteCrsDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrsDate').AsDateTime := pValue;
end;

function TCrshisBtr.ReadEUR:double;
begin
  Result := oBtrTable.FieldByName('EUR').AsFloat;
end;

procedure TCrshisBtr.WriteEUR(pValue:double);
begin
  oBtrTable.FieldByName('EUR').AsFloat := pValue;
end;

function TCrshisBtr.ReadUSD:double;
begin
  Result := oBtrTable.FieldByName('USD').AsFloat;
end;

procedure TCrshisBtr.WriteUSD(pValue:double);
begin
  oBtrTable.FieldByName('USD').AsFloat := pValue;
end;

function TCrshisBtr.ReadCZK:double;
begin
  Result := oBtrTable.FieldByName('CZK').AsFloat;
end;

procedure TCrshisBtr.WriteCZK(pValue:double);
begin
  oBtrTable.FieldByName('CZK').AsFloat := pValue;
end;

function TCrshisBtr.ReadAUD:double;
begin
  Result := oBtrTable.FieldByName('AUD').AsFloat;
end;

procedure TCrshisBtr.WriteAUD(pValue:double);
begin
  oBtrTable.FieldByName('AUD').AsFloat := pValue;
end;

function TCrshisBtr.ReadCYP:double;
begin
  Result := oBtrTable.FieldByName('CYP').AsFloat;
end;

procedure TCrshisBtr.WriteCYP(pValue:double);
begin
  oBtrTable.FieldByName('CYP').AsFloat := pValue;
end;

function TCrshisBtr.ReadDKK:double;
begin
  Result := oBtrTable.FieldByName('DKK').AsFloat;
end;

procedure TCrshisBtr.WriteDKK(pValue:double);
begin
  oBtrTable.FieldByName('DKK').AsFloat := pValue;
end;

function TCrshisBtr.ReadEEK:double;
begin
  Result := oBtrTable.FieldByName('EEK').AsFloat;
end;

procedure TCrshisBtr.WriteEEK(pValue:double);
begin
  oBtrTable.FieldByName('EEK').AsFloat := pValue;
end;

function TCrshisBtr.ReadJPY:double;
begin
  Result := oBtrTable.FieldByName('JPY').AsFloat;
end;

procedure TCrshisBtr.WriteJPY(pValue:double);
begin
  oBtrTable.FieldByName('JPY').AsFloat := pValue;
end;

function TCrshisBtr.ReadCAD:double;
begin
  Result := oBtrTable.FieldByName('CAD').AsFloat;
end;

procedure TCrshisBtr.WriteCAD(pValue:double);
begin
  oBtrTable.FieldByName('CAD').AsFloat := pValue;
end;

function TCrshisBtr.ReadLTL:double;
begin
  Result := oBtrTable.FieldByName('LTL').AsFloat;
end;

procedure TCrshisBtr.WriteLTL(pValue:double);
begin
  oBtrTable.FieldByName('LTL').AsFloat := pValue;
end;

function TCrshisBtr.ReadLVL:double;
begin
  Result := oBtrTable.FieldByName('LVL').AsFloat;
end;

procedure TCrshisBtr.WriteLVL(pValue:double);
begin
  oBtrTable.FieldByName('LVL').AsFloat := pValue;
end;

function TCrshisBtr.ReadHUF:double;
begin
  Result := oBtrTable.FieldByName('HUF').AsFloat;
end;

procedure TCrshisBtr.WriteHUF(pValue:double);
begin
  oBtrTable.FieldByName('HUF').AsFloat := pValue;
end;

function TCrshisBtr.ReadMTL:double;
begin
  Result := oBtrTable.FieldByName('MTL').AsFloat;
end;

procedure TCrshisBtr.WriteMTL(pValue:double);
begin
  oBtrTable.FieldByName('MTL').AsFloat := pValue;
end;

function TCrshisBtr.ReadNOK:double;
begin
  Result := oBtrTable.FieldByName('NOK').AsFloat;
end;

procedure TCrshisBtr.WriteNOK(pValue:double);
begin
  oBtrTable.FieldByName('NOK').AsFloat := pValue;
end;

function TCrshisBtr.ReadPLN:double;
begin
  Result := oBtrTable.FieldByName('PLN').AsFloat;
end;

procedure TCrshisBtr.WritePLN(pValue:double);
begin
  oBtrTable.FieldByName('PLN').AsFloat := pValue;
end;

function TCrshisBtr.ReadSIT:double;
begin
  Result := oBtrTable.FieldByName('SIT').AsFloat;
end;

procedure TCrshisBtr.WriteSIT(pValue:double);
begin
  oBtrTable.FieldByName('SIT').AsFloat := pValue;
end;

function TCrshisBtr.ReadCHF:double;
begin
  Result := oBtrTable.FieldByName('CHF').AsFloat;
end;

procedure TCrshisBtr.WriteCHF(pValue:double);
begin
  oBtrTable.FieldByName('CHF').AsFloat := pValue;
end;

function TCrshisBtr.ReadSEK:double;
begin
  Result := oBtrTable.FieldByName('SEK').AsFloat;
end;

procedure TCrshisBtr.WriteSEK(pValue:double);
begin
  oBtrTable.FieldByName('SEK').AsFloat := pValue;
end;

function TCrshisBtr.ReadGBP:double;
begin
  Result := oBtrTable.FieldByName('GBP').AsFloat;
end;

procedure TCrshisBtr.WriteGBP(pValue:double);
begin
  oBtrTable.FieldByName('GBP').AsFloat := pValue;
end;

function TCrshisBtr.ReadXDR:double;
begin
  Result := oBtrTable.FieldByName('XDR').AsFloat;
end;

procedure TCrshisBtr.WriteXDR(pValue:double);
begin
  oBtrTable.FieldByName('XDR').AsFloat := pValue;
end;

function TCrshisBtr.ReadRes1:double;
begin
  Result := oBtrTable.FieldByName('Res1').AsFloat;
end;

procedure TCrshisBtr.WriteRes1(pValue:double);
begin
  oBtrTable.FieldByName('Res1').AsFloat := pValue;
end;

function TCrshisBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TCrshisBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TCrshisBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TCrshisBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TCrshisBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TCrshisBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TCrshisBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TCrshisBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TCrshisBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TCrshisBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TCrshisBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TCrshisBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TCrshisBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TCrshisBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TCrshisBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TCrshisBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCrshisBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCrshisBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TCrshisBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCrshisBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TCrshisBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TCrshisBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TCrshisBtr.LocateCrsDate (pCrsDate:TDatetime):boolean;
begin
  SetIndex (ixCrsDate);
  Result := oBtrTable.FindKey([pCrsDate]);
end;

function TCrshisBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

function TCrshisBtr.NearestCrsDate (pCrsDate:TDatetime):boolean;
begin
  SetIndex (ixCrsDate);
  Result := oBtrTable.FindNearest([pCrsDate]);
end;

function TCrshisBtr.NearestSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindNearest([pSended]);
end;

procedure TCrshisBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TCrshisBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TCrshisBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TCrshisBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TCrshisBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TCrshisBtr.First;
begin
  oBtrTable.First;
end;

procedure TCrshisBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TCrshisBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TCrshisBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TCrshisBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TCrshisBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TCrshisBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TCrshisBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TCrshisBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TCrshisBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TCrshisBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TCrshisBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
