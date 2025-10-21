unit tACC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRowNum = '';
  ixDocNum = 'DocNum';
  ixDoIt = 'DoIt';
  ixItmNum = 'ItmNum';
  ixExtNum = 'ExtNum';
  ixDocDate = 'DocDate';
  ixSnAn = 'SnAn';
  ixItWrSnAn = 'ItWrSnAn';
  ixPaCode = 'PaCode';

type
  TAccTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRowNum:longint;        procedure WriteRowNum (pValue:longint);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadExtNum:Str12;          procedure WriteExtNum (pValue:Str12);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadAccSnt:str3;           procedure WriteAccSnt (pValue:str3);
    function  ReadAccAnl:str6;           procedure WriteAccAnl (pValue:str6);
    function  ReadDescribe:str30;        procedure WriteDescribe (pValue:str30);
    function  ReadCredVal:double;        procedure WriteCredVal (pValue:double);
    function  ReadDebVal:double;         procedure WriteDebVal (pValue:double);
    function  ReadOcdNum:Str12;          procedure WriteOcdNum (pValue:Str12);
    function  ReadOceNum:Str12;          procedure WriteOceNum (pValue:Str12);
    function  ReadConDoc:Str12;          procedure WriteConDoc (pValue:Str12);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadCentNum:word;          procedure WriteCentNum (pValue:word);
    function  ReadSmCode:word;           procedure WriteSmCode (pValue:word);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadSpaCode:longint;       procedure WriteSpaCode (pValue:longint);
    function  ReadBegRec:byte;           procedure WriteBegRec (pValue:byte);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateRowNum (pRowNum:longint):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateItmNum (pItmNum:word):boolean;
    function LocateExtNum (pExtNum:Str12):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateSnAn (pAccSnt:str3;pAccAnl:str6):boolean;
    function LocateItWrSnAn (pItmNum:word;pWriNum:word;pAccSnt:str3;pAccAnl:str6):boolean;
    function LocatePaCode (pPaCode:longint):boolean;

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
    property RowNum:longint read ReadRowNum write WriteRowNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property ExtNum:Str12 read ReadExtNum write WriteExtNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property AccSnt:str3 read ReadAccSnt write WriteAccSnt;
    property AccAnl:str6 read ReadAccAnl write WriteAccAnl;
    property Describe:str30 read ReadDescribe write WriteDescribe;
    property CredVal:double read ReadCredVal write WriteCredVal;
    property DebVal:double read ReadDebVal write WriteDebVal;
    property OcdNum:Str12 read ReadOcdNum write WriteOcdNum;
    property OceNum:Str12 read ReadOceNum write WriteOceNum;
    property ConDoc:Str12 read ReadConDoc write WriteConDoc;
    property WriNum:word read ReadWriNum write WriteWriNum;
    property CentNum:word read ReadCentNum write WriteCentNum;
    property SmCode:word read ReadSmCode write WriteSmCode;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property SpaCode:longint read ReadSpaCode write WriteSpaCode;
    property BegRec:byte read ReadBegRec write WriteBegRec;
    property PaName:Str30 read ReadPaName write WritePaName;
  end;

implementation

constructor TAccTmp.Create;
begin
  oTmpTable := TmpInit ('ACC',Self);
end;

destructor TAccTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TAccTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TAccTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TAccTmp.ReadRowNum:longint;
begin
  Result := oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TAccTmp.WriteRowNum(pValue:longint);
begin
  oTmpTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TAccTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TAccTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TAccTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TAccTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TAccTmp.ReadExtNum:Str12;
begin
  Result := oTmpTable.FieldByName('ExtNum').AsString;
end;

procedure TAccTmp.WriteExtNum(pValue:Str12);
begin
  oTmpTable.FieldByName('ExtNum').AsString := pValue;
end;

function TAccTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TAccTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TAccTmp.ReadAccSnt:str3;
begin
  Result := oTmpTable.FieldByName('AccSnt').AsString;
end;

procedure TAccTmp.WriteAccSnt(pValue:str3);
begin
  oTmpTable.FieldByName('AccSnt').AsString := pValue;
end;

function TAccTmp.ReadAccAnl:str6;
begin
  Result := oTmpTable.FieldByName('AccAnl').AsString;
end;

procedure TAccTmp.WriteAccAnl(pValue:str6);
begin
  oTmpTable.FieldByName('AccAnl').AsString := pValue;
end;

function TAccTmp.ReadDescribe:str30;
begin
  Result := oTmpTable.FieldByName('Describe').AsString;
end;

procedure TAccTmp.WriteDescribe(pValue:str30);
begin
  oTmpTable.FieldByName('Describe').AsString := pValue;
end;

function TAccTmp.ReadCredVal:double;
begin
  Result := oTmpTable.FieldByName('CredVal').AsFloat;
end;

procedure TAccTmp.WriteCredVal(pValue:double);
begin
  oTmpTable.FieldByName('CredVal').AsFloat := pValue;
end;

function TAccTmp.ReadDebVal:double;
begin
  Result := oTmpTable.FieldByName('DebVal').AsFloat;
end;

procedure TAccTmp.WriteDebVal(pValue:double);
begin
  oTmpTable.FieldByName('DebVal').AsFloat := pValue;
end;

function TAccTmp.ReadOcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('OcdNum').AsString;
end;

procedure TAccTmp.WriteOcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OcdNum').AsString := pValue;
end;

function TAccTmp.ReadOceNum:Str12;
begin
  Result := oTmpTable.FieldByName('OceNum').AsString;
end;

procedure TAccTmp.WriteOceNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OceNum').AsString := pValue;
end;

function TAccTmp.ReadConDoc:Str12;
begin
  Result := oTmpTable.FieldByName('ConDoc').AsString;
end;

procedure TAccTmp.WriteConDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('ConDoc').AsString := pValue;
end;

function TAccTmp.ReadWriNum:word;
begin
  Result := oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TAccTmp.WriteWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TAccTmp.ReadCentNum:word;
begin
  Result := oTmpTable.FieldByName('CentNum').AsInteger;
end;

procedure TAccTmp.WriteCentNum(pValue:word);
begin
  oTmpTable.FieldByName('CentNum').AsInteger := pValue;
end;

function TAccTmp.ReadSmCode:word;
begin
  Result := oTmpTable.FieldByName('SmCode').AsInteger;
end;

procedure TAccTmp.WriteSmCode(pValue:word);
begin
  oTmpTable.FieldByName('SmCode').AsInteger := pValue;
end;

function TAccTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TAccTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TAccTmp.ReadSpaCode:longint;
begin
  Result := oTmpTable.FieldByName('SpaCode').AsInteger;
end;

procedure TAccTmp.WriteSpaCode(pValue:longint);
begin
  oTmpTable.FieldByName('SpaCode').AsInteger := pValue;
end;

function TAccTmp.ReadBegRec:byte;
begin
  Result := oTmpTable.FieldByName('BegRec').AsInteger;
end;

procedure TAccTmp.WriteBegRec(pValue:byte);
begin
  oTmpTable.FieldByName('BegRec').AsInteger := pValue;
end;

function TAccTmp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TAccTmp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAccTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TAccTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TAccTmp.LocateRowNum (pRowNum:longint):boolean;
begin
  SetIndex (ixRowNum);
  Result := oTmpTable.FindKey([pRowNum]);
end;

function TAccTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TAccTmp.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TAccTmp.LocateItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oTmpTable.FindKey([pItmNum]);
end;

function TAccTmp.LocateExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oTmpTable.FindKey([pExtNum]);
end;

function TAccTmp.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oTmpTable.FindKey([pDocDate]);
end;

function TAccTmp.LocateSnAn (pAccSnt:str3;pAccAnl:str6):boolean;
begin
  SetIndex (ixSnAn);
  Result := oTmpTable.FindKey([pAccSnt,pAccAnl]);
end;

function TAccTmp.LocateItWrSnAn (pItmNum:word;pWriNum:word;pAccSnt:str3;pAccAnl:str6):boolean;
begin
  SetIndex (ixItWrSnAn);
  Result := oTmpTable.FindKey([pItmNum,pWriNum,pAccSnt,pAccAnl]);
end;

function TAccTmp.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oTmpTable.FindKey([pPaCode]);
end;

procedure TAccTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TAccTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TAccTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TAccTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TAccTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TAccTmp.First;
begin
  oTmpTable.First;
end;

procedure TAccTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TAccTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TAccTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TAccTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TAccTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TAccTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TAccTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TAccTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TAccTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TAccTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TAccTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
