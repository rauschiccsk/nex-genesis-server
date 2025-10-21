unit tSTM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixStSm = '';
  ixStkNum = 'StkNum';
  ixStmNum = 'StmNum';
  ixDoIt = 'DoIt';
  ixGsCode = 'GsCode';
  ixDocDate = 'DocDate';
  ixSmCode = 'SmCode';
  ixFifNum = 'FifNum';
  ixOdOi = 'OdOi';
  ixPaCode = 'PaCode';
  ixActPos = 'ActPos';

type
  TStmTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadStmNum:longint;        procedure WriteStmNum (pValue:longint);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:longint;        procedure WriteItmNum (pValue:longint);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadSmCode:word;           procedure WriteSmCode (pValue:word);
    function  ReadFifNum:longint;        procedure WriteFifNum (pValue:longint);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadEndQnt:double;         procedure WriteEndQnt (pValue:double);
    function  ReadCPrice:double;         procedure WriteCPrice (pValue:double);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadOcdNum:Str12;          procedure WriteOcdNum (pValue:Str12);
    function  ReadOcdItm:longint;        procedure WriteOcdItm (pValue:longint);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadSpaCode:longint;       procedure WriteSpaCode (pValue:longint);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadAcqStat:Str1;          procedure WriteAcqStat (pValue:Str1);
    function  ReadScStkNum:word;         procedure WriteScStkNum (pValue:word);
    function  ReadTgStkNum:word;         procedure WriteTgStkNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateStSm (pStkNum:word;pStmNum:longint):boolean;
    function LocateStkNum (pStkNum:word):boolean;
    function LocateStmNum (pStmNum:longint):boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:longint):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateSmCode (pSmCode:word):boolean;
    function LocateFifNum (pFifNum:longint):boolean;
    function LocateOdOi (pOcdNum:Str12;pOcdItm:longint):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocateActPos (pActPos:longint):boolean;

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
    property StkNum:word read ReadStkNum write WriteStkNum;
    property StmNum:longint read ReadStmNum write WriteStmNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:longint read ReadItmNum write WriteItmNum;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property SmCode:word read ReadSmCode write WriteSmCode;
    property FifNum:longint read ReadFifNum write WriteFifNum;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property EndQnt:double read ReadEndQnt write WriteEndQnt;
    property CPrice:double read ReadCPrice write WriteCPrice;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property CValue:double read ReadCValue write WriteCValue;
    property BValue:double read ReadBValue write WriteBValue;
    property OcdNum:Str12 read ReadOcdNum write WriteOcdNum;
    property OcdItm:longint read ReadOcdItm write WriteOcdItm;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property SpaCode:longint read ReadSpaCode write WriteSpaCode;
    property Sended:boolean read ReadSended write WriteSended;
    property AcqStat:Str1 read ReadAcqStat write WriteAcqStat;
    property ScStkNum:word read ReadScStkNum write WriteScStkNum;
    property TgStkNum:word read ReadTgStkNum write WriteTgStkNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TStmTmp.Create;
begin
  oTmpTable := TmpInit ('STM',Self);
end;

destructor TStmTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TStmTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TStmTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TStmTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TStmTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TStmTmp.ReadStmNum:longint;
begin
  Result := oTmpTable.FieldByName('StmNum').AsInteger;
end;

procedure TStmTmp.WriteStmNum(pValue:longint);
begin
  oTmpTable.FieldByName('StmNum').AsInteger := pValue;
end;

function TStmTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TStmTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TStmTmp.ReadItmNum:longint;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TStmTmp.WriteItmNum(pValue:longint);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TStmTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TStmTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TStmTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TStmTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TStmTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TStmTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TStmTmp.ReadSmCode:word;
begin
  Result := oTmpTable.FieldByName('SmCode').AsInteger;
end;

procedure TStmTmp.WriteSmCode(pValue:word);
begin
  oTmpTable.FieldByName('SmCode').AsInteger := pValue;
end;

function TStmTmp.ReadFifNum:longint;
begin
  Result := oTmpTable.FieldByName('FifNum').AsInteger;
end;

procedure TStmTmp.WriteFifNum(pValue:longint);
begin
  oTmpTable.FieldByName('FifNum').AsInteger := pValue;
end;

function TStmTmp.ReadGsQnt:double;
begin
  Result := oTmpTable.FieldByName('GsQnt').AsFloat;
end;

procedure TStmTmp.WriteGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TStmTmp.ReadEndQnt:double;
begin
  Result := oTmpTable.FieldByName('EndQnt').AsFloat;
end;

procedure TStmTmp.WriteEndQnt(pValue:double);
begin
  oTmpTable.FieldByName('EndQnt').AsFloat := pValue;
end;

function TStmTmp.ReadCPrice:double;
begin
  Result := oTmpTable.FieldByName('CPrice').AsFloat;
end;

procedure TStmTmp.WriteCPrice(pValue:double);
begin
  oTmpTable.FieldByName('CPrice').AsFloat := pValue;
end;

function TStmTmp.ReadBPrice:double;
begin
  Result := oTmpTable.FieldByName('BPrice').AsFloat;
end;

procedure TStmTmp.WriteBPrice(pValue:double);
begin
  oTmpTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TStmTmp.ReadCValue:double;
begin
  Result := oTmpTable.FieldByName('CValue').AsFloat;
end;

procedure TStmTmp.WriteCValue(pValue:double);
begin
  oTmpTable.FieldByName('CValue').AsFloat := pValue;
end;

function TStmTmp.ReadBValue:double;
begin
  Result := oTmpTable.FieldByName('BValue').AsFloat;
end;

procedure TStmTmp.WriteBValue(pValue:double);
begin
  oTmpTable.FieldByName('BValue').AsFloat := pValue;
end;

function TStmTmp.ReadOcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('OcdNum').AsString;
end;

procedure TStmTmp.WriteOcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OcdNum').AsString := pValue;
end;

function TStmTmp.ReadOcdItm:longint;
begin
  Result := oTmpTable.FieldByName('OcdItm').AsInteger;
end;

procedure TStmTmp.WriteOcdItm(pValue:longint);
begin
  oTmpTable.FieldByName('OcdItm').AsInteger := pValue;
end;

function TStmTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TStmTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TStmTmp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TStmTmp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TStmTmp.ReadSpaCode:longint;
begin
  Result := oTmpTable.FieldByName('SpaCode').AsInteger;
end;

procedure TStmTmp.WriteSpaCode(pValue:longint);
begin
  oTmpTable.FieldByName('SpaCode').AsInteger := pValue;
end;

function TStmTmp.ReadSended:boolean;
begin
  Result := ByteToBool(oTmpTable.FieldByName('Sended').AsInteger);
end;

procedure TStmTmp.WriteSended(pValue:boolean);
begin
  oTmpTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TStmTmp.ReadAcqStat:Str1;
begin
  Result := oTmpTable.FieldByName('AcqStat').AsString;
end;

procedure TStmTmp.WriteAcqStat(pValue:Str1);
begin
  oTmpTable.FieldByName('AcqStat').AsString := pValue;
end;

function TStmTmp.ReadScStkNum:word;
begin
  Result := oTmpTable.FieldByName('ScStkNum').AsInteger;
end;

procedure TStmTmp.WriteScStkNum(pValue:word);
begin
  oTmpTable.FieldByName('ScStkNum').AsInteger := pValue;
end;

function TStmTmp.ReadTgStkNum:word;
begin
  Result := oTmpTable.FieldByName('TgStkNum').AsInteger;
end;

procedure TStmTmp.WriteTgStkNum(pValue:word);
begin
  oTmpTable.FieldByName('TgStkNum').AsInteger := pValue;
end;

function TStmTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TStmTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TStmTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TStmTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TStmTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TStmTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TStmTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TStmTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TStmTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TStmTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TStmTmp.LocateStSm (pStkNum:word;pStmNum:longint):boolean;
begin
  SetIndex (ixStSm);
  Result := oTmpTable.FindKey([pStkNum,pStmNum]);
end;

function TStmTmp.LocateStkNum (pStkNum:word):boolean;
begin
  SetIndex (ixStkNum);
  Result := oTmpTable.FindKey([pStkNum]);
end;

function TStmTmp.LocateStmNum (pStmNum:longint):boolean;
begin
  SetIndex (ixStmNum);
  Result := oTmpTable.FindKey([pStmNum]);
end;

function TStmTmp.LocateDoIt (pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex (ixDoIt);
  Result := oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TStmTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TStmTmp.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oTmpTable.FindKey([pDocDate]);
end;

function TStmTmp.LocateSmCode (pSmCode:word):boolean;
begin
  SetIndex (ixSmCode);
  Result := oTmpTable.FindKey([pSmCode]);
end;

function TStmTmp.LocateFifNum (pFifNum:longint):boolean;
begin
  SetIndex (ixFifNum);
  Result := oTmpTable.FindKey([pFifNum]);
end;

function TStmTmp.LocateOdOi (pOcdNum:Str12;pOcdItm:longint):boolean;
begin
  SetIndex (ixOdOi);
  Result := oTmpTable.FindKey([pOcdNum,pOcdItm]);
end;

function TStmTmp.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oTmpTable.FindKey([pPaCode]);
end;

function TStmTmp.LocateActPos (pActPos:longint):boolean;
begin
  SetIndex (ixActPos);
  Result := oTmpTable.FindKey([pActPos]);
end;

procedure TStmTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TStmTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TStmTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TStmTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TStmTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TStmTmp.First;
begin
  oTmpTable.First;
end;

procedure TStmTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TStmTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TStmTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TStmTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TStmTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TStmTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TStmTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TStmTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TStmTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TStmTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TStmTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
