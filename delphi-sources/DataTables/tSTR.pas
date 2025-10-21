unit tSTR;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = '';
  ixGsOrSt = 'GsOrSt';
  ixGsCode = 'GsCode';
  ixGsOrStPa = 'GsOrStPa';

type
  TStrTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:longint;        procedure WriteItmNum (pValue:longint);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str60;          procedure WritePaName (pValue:Str60);
    function  ReadOrdQnt:double;         procedure WriteOrdQnt (pValue:double);
    function  ReadResQnt:double;         procedure WriteResQnt (pValue:double);
    function  ReadResDoc:Str12;          procedure WriteResDoc (pValue:Str12);
    function  ReadResItm:longint;        procedure WriteResItm (pValue:longint);
    function  ReadResSta:Str1;           procedure WriteResSta (pValue:Str1);
    function  ReadReqDat:TDatetime;      procedure WriteReqDat (pValue:TDatetime);
    function  ReadCtmDat:TDatetime;      procedure WriteCtmDat (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:longint):boolean;
    function LocateGsOrSt (pGsCode:longint;pOrdType:;pStkStat:):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsOrStPa (pGsCode:longint;pOrdType:;pStkStat:;pPaCode:longint):boolean;

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
    property ItmNum:longint read ReadItmNum write WriteItmNum;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str60 read ReadPaName write WritePaName;
    property OrdQnt:double read ReadOrdQnt write WriteOrdQnt;
    property ResQnt:double read ReadResQnt write WriteResQnt;
    property ResDoc:Str12 read ReadResDoc write WriteResDoc;
    property ResItm:longint read ReadResItm write WriteResItm;
    property ResSta:Str1 read ReadResSta write WriteResSta;
    property ReqDat:TDatetime read ReadReqDat write WriteReqDat;
    property CtmDat:TDatetime read ReadCtmDat write WriteCtmDat;
  end;

implementation

constructor TStrTmp.Create;
begin
  oTmpTable := TmpInit ('STR',Self);
end;

destructor TStrTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TStrTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TStrTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TStrTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TStrTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TStrTmp.ReadItmNum:longint;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TStrTmp.WriteItmNum(pValue:longint);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TStrTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TStrTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TStrTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TStrTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TStrTmp.ReadPaName:Str60;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TStrTmp.WritePaName(pValue:Str60);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TStrTmp.ReadOrdQnt:double;
begin
  Result := oTmpTable.FieldByName('OrdQnt').AsFloat;
end;

procedure TStrTmp.WriteOrdQnt(pValue:double);
begin
  oTmpTable.FieldByName('OrdQnt').AsFloat := pValue;
end;

function TStrTmp.ReadResQnt:double;
begin
  Result := oTmpTable.FieldByName('ResQnt').AsFloat;
end;

procedure TStrTmp.WriteResQnt(pValue:double);
begin
  oTmpTable.FieldByName('ResQnt').AsFloat := pValue;
end;

function TStrTmp.ReadResDoc:Str12;
begin
  Result := oTmpTable.FieldByName('ResDoc').AsString;
end;

procedure TStrTmp.WriteResDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('ResDoc').AsString := pValue;
end;

function TStrTmp.ReadResItm:longint;
begin
  Result := oTmpTable.FieldByName('ResItm').AsInteger;
end;

procedure TStrTmp.WriteResItm(pValue:longint);
begin
  oTmpTable.FieldByName('ResItm').AsInteger := pValue;
end;

function TStrTmp.ReadResSta:Str1;
begin
  Result := oTmpTable.FieldByName('ResSta').AsString;
end;

procedure TStrTmp.WriteResSta(pValue:Str1);
begin
  oTmpTable.FieldByName('ResSta').AsString := pValue;
end;

function TStrTmp.ReadReqDat:TDatetime;
begin
  Result := oTmpTable.FieldByName('ReqDat').AsDateTime;
end;

procedure TStrTmp.WriteReqDat(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ReqDat').AsDateTime := pValue;
end;

function TStrTmp.ReadCtmDat:TDatetime;
begin
  Result := oTmpTable.FieldByName('CtmDat').AsDateTime;
end;

procedure TStrTmp.WriteCtmDat(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CtmDat').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TStrTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TStrTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TStrTmp.LocateDoIt (pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex (ixDoIt);
  Result := oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TStrTmp.LocateGsOrSt (pGsCode:longint;pOrdType:;pStkStat:):boolean;
begin
  SetIndex (ixGsOrSt);
  Result := oTmpTable.FindKey([pGsCode,pOrdType,pStkStat]);
end;

function TStrTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TStrTmp.LocateGsOrStPa (pGsCode:longint;pOrdType:;pStkStat:;pPaCode:longint):boolean;
begin
  SetIndex (ixGsOrStPa);
  Result := oTmpTable.FindKey([pGsCode,pOrdType,pStkStat,pPaCode]);
end;

procedure TStrTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TStrTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TStrTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TStrTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TStrTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TStrTmp.First;
begin
  oTmpTable.First;
end;

procedure TStrTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TStrTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TStrTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TStrTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TStrTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TStrTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TStrTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TStrTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TStrTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TStrTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TStrTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1921001}
