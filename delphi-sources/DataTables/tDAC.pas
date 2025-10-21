unit tDAC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPrimary = '';

type
  TDacTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadItmNum:longint;        procedure WriteItmNum (pValue:longint);
    function  ReadCntNum:word;           procedure WriteCntNum (pValue:word);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadOcdNum:Str12;          procedure WriteOcdNum (pValue:Str12);
    function  ReadConDoc:Str12;          procedure WriteConDoc (pValue:Str12);
    function  ReadAccSnt:str3;           procedure WriteAccSnt (pValue:str3);
    function  ReadAccAnl:str6;           procedure WriteAccAnl (pValue:str6);
    function  ReadCrdVal:double;         procedure WriteCrdVal (pValue:double);
    function  ReadDebVal:double;         procedure WriteDebVal (pValue:double);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadDescribe:str30;        procedure WriteDescribe (pValue:str30);
    function  ReadExtNum:Str12;          procedure WriteExtNum (pValue:Str12);
    function  ReadOceNum:Str12;          procedure WriteOceNum (pValue:Str12);
    function  ReadBegRec:byte;           procedure WriteBegRec (pValue:byte);
    function  ReadSmCode:word;           procedure WriteSmCode (pValue:word);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadSpaCode:longint;       procedure WriteSpaCode (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocatePrimary (pItmNum:longint;pStkNum:word;pWriNum:word;pCntNum:word;pOcdNum:Str12;pConDoc:Str12;pAccSnt:str3;pAccAnl:str6):boolean;

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
    procedure DisableControls;
    procedure EnableControls;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read ReadCount;
    property ItmNum:longint read ReadItmNum write WriteItmNum;
    property CntNum:word read ReadCntNum write WriteCntNum;
    property WriNum:word read ReadWriNum write WriteWriNum;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property OcdNum:Str12 read ReadOcdNum write WriteOcdNum;
    property ConDoc:Str12 read ReadConDoc write WriteConDoc;
    property AccSnt:str3 read ReadAccSnt write WriteAccSnt;
    property AccAnl:str6 read ReadAccAnl write WriteAccAnl;
    property CrdVal:double read ReadCrdVal write WriteCrdVal;
    property DebVal:double read ReadDebVal write WriteDebVal;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property Describe:str30 read ReadDescribe write WriteDescribe;
    property ExtNum:Str12 read ReadExtNum write WriteExtNum;
    property OceNum:Str12 read ReadOceNum write WriteOceNum;
    property BegRec:byte read ReadBegRec write WriteBegRec;
    property SmCode:word read ReadSmCode write WriteSmCode;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property SpaCode:longint read ReadSpaCode write WriteSpaCode;
  end;

implementation

constructor TDacTmp.Create;
begin
  oTmpTable := TmpInit ('DAC',Self);
end;

destructor TDacTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TDacTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TDacTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TDacTmp.ReadItmNum:longint;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TDacTmp.WriteItmNum(pValue:longint);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TDacTmp.ReadCntNum:word;
begin
  Result := oTmpTable.FieldByName('CntNum').AsInteger;
end;

procedure TDacTmp.WriteCntNum(pValue:word);
begin
  oTmpTable.FieldByName('CntNum').AsInteger := pValue;
end;

function TDacTmp.ReadWriNum:word;
begin
  Result := oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TDacTmp.WriteWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TDacTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TDacTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TDacTmp.ReadOcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('OcdNum').AsString;
end;

procedure TDacTmp.WriteOcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OcdNum').AsString := pValue;
end;

function TDacTmp.ReadConDoc:Str12;
begin
  Result := oTmpTable.FieldByName('ConDoc').AsString;
end;

procedure TDacTmp.WriteConDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('ConDoc').AsString := pValue;
end;

function TDacTmp.ReadAccSnt:str3;
begin
  Result := oTmpTable.FieldByName('AccSnt').AsString;
end;

procedure TDacTmp.WriteAccSnt(pValue:str3);
begin
  oTmpTable.FieldByName('AccSnt').AsString := pValue;
end;

function TDacTmp.ReadAccAnl:str6;
begin
  Result := oTmpTable.FieldByName('AccAnl').AsString;
end;

procedure TDacTmp.WriteAccAnl(pValue:str6);
begin
  oTmpTable.FieldByName('AccAnl').AsString := pValue;
end;

function TDacTmp.ReadCrdVal:double;
begin
  Result := oTmpTable.FieldByName('CrdVal').AsFloat;
end;

procedure TDacTmp.WriteCrdVal(pValue:double);
begin
  oTmpTable.FieldByName('CrdVal').AsFloat := pValue;
end;

function TDacTmp.ReadDebVal:double;
begin
  Result := oTmpTable.FieldByName('DebVal').AsFloat;
end;

procedure TDacTmp.WriteDebVal(pValue:double);
begin
  oTmpTable.FieldByName('DebVal').AsFloat := pValue;
end;

function TDacTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TDacTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TDacTmp.ReadDescribe:str30;
begin
  Result := oTmpTable.FieldByName('Describe').AsString;
end;

procedure TDacTmp.WriteDescribe(pValue:str30);
begin
  oTmpTable.FieldByName('Describe').AsString := pValue;
end;

function TDacTmp.ReadExtNum:Str12;
begin
  Result := oTmpTable.FieldByName('ExtNum').AsString;
end;

procedure TDacTmp.WriteExtNum(pValue:Str12);
begin
  oTmpTable.FieldByName('ExtNum').AsString := pValue;
end;

function TDacTmp.ReadOceNum:Str12;
begin
  Result := oTmpTable.FieldByName('OceNum').AsString;
end;

procedure TDacTmp.WriteOceNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OceNum').AsString := pValue;
end;

function TDacTmp.ReadBegRec:byte;
begin
  Result := oTmpTable.FieldByName('BegRec').AsInteger;
end;

procedure TDacTmp.WriteBegRec(pValue:byte);
begin
  oTmpTable.FieldByName('BegRec').AsInteger := pValue;
end;

function TDacTmp.ReadSmCode:word;
begin
  Result := oTmpTable.FieldByName('SmCode').AsInteger;
end;

procedure TDacTmp.WriteSmCode(pValue:word);
begin
  oTmpTable.FieldByName('SmCode').AsInteger := pValue;
end;

function TDacTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TDacTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TDacTmp.ReadSpaCode:longint;
begin
  Result := oTmpTable.FieldByName('SpaCode').AsInteger;
end;

procedure TDacTmp.WriteSpaCode(pValue:longint);
begin
  oTmpTable.FieldByName('SpaCode').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TDacTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TDacTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TDacTmp.LocatePrimary (pItmNum:longint;pStkNum:word;pWriNum:word;pCntNum:word;pOcdNum:Str12;pConDoc:Str12;pAccSnt:str3;pAccAnl:str6):boolean;
begin
  SetIndex (ixPrimary);
  Result := oTmpTable.FindKey([pItmNum,pStkNum,pWriNum,pCntNum,pOcdNum,pConDoc,pAccSnt,pAccAnl]);
end;

procedure TDacTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TDacTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TDacTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TDacTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TDacTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TDacTmp.First;
begin
  oTmpTable.First;
end;

procedure TDacTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TDacTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TDacTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TDacTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TDacTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TDacTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TDacTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TDacTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TDacTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TDacTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TDacTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
