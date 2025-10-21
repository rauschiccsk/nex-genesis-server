unit tSTKPDN;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRowNum = '';

type
  TStkpdnTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRowNum:word;           procedure WriteRowNum (pValue:word);
    function  ReadPrdNum:Str30;          procedure WritePrdNum (pValue:Str30);
    function  ReadStatus:Str1;           procedure WriteStatus (pValue:Str1);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadInpDoc:Str12;          procedure WriteInpDoc (pValue:Str12);
    function  ReadInpItm:word;           procedure WriteInpItm (pValue:word);
    function  ReadInpDat:TDatetime;      procedure WriteInpDat (pValue:TDatetime);
    function  ReadInpFif:longint;        procedure WriteInpFif (pValue:longint);
    function  ReadOutDoc:Str12;          procedure WriteOutDoc (pValue:Str12);
    function  ReadOutItm:word;           procedure WriteOutItm (pValue:word);
    function  ReadOutDat:TDatetime;      procedure WriteOutDat (pValue:TDatetime);
    function  ReadCrtUsr:Str8;           procedure WriteCrtUsr (pValue:Str8);
    function  ReadCrtDat:TDatetime;      procedure WriteCrtDat (pValue:TDatetime);
    function  ReadCrtTim:TDatetime;      procedure WriteCrtTim (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateRowNum (pRowNum:word):boolean;

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
    property RowNum:word read ReadRowNum write WriteRowNum;
    property PrdNum:Str30 read ReadPrdNum write WritePrdNum;
    property Status:Str1 read ReadStatus write WriteStatus;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property InpDoc:Str12 read ReadInpDoc write WriteInpDoc;
    property InpItm:word read ReadInpItm write WriteInpItm;
    property InpDat:TDatetime read ReadInpDat write WriteInpDat;
    property InpFif:longint read ReadInpFif write WriteInpFif;
    property OutDoc:Str12 read ReadOutDoc write WriteOutDoc;
    property OutItm:word read ReadOutItm write WriteOutItm;
    property OutDat:TDatetime read ReadOutDat write WriteOutDat;
    property CrtUsr:Str8 read ReadCrtUsr write WriteCrtUsr;
    property CrtDat:TDatetime read ReadCrtDat write WriteCrtDat;
    property CrtTim:TDatetime read ReadCrtTim write WriteCrtTim;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TStkpdnTmp.Create;
begin
  oTmpTable := TmpInit ('STKPDN',Self);
end;

destructor TStkpdnTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TStkpdnTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TStkpdnTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TStkpdnTmp.ReadRowNum:word;
begin
  Result := oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TStkpdnTmp.WriteRowNum(pValue:word);
begin
  oTmpTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TStkpdnTmp.ReadPrdNum:Str30;
begin
  Result := oTmpTable.FieldByName('PrdNum').AsString;
end;

procedure TStkpdnTmp.WritePrdNum(pValue:Str30);
begin
  oTmpTable.FieldByName('PrdNum').AsString := pValue;
end;

function TStkpdnTmp.ReadStatus:Str1;
begin
  Result := oTmpTable.FieldByName('Status').AsString;
end;

procedure TStkpdnTmp.WriteStatus(pValue:Str1);
begin
  oTmpTable.FieldByName('Status').AsString := pValue;
end;

function TStkpdnTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TStkpdnTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TStkpdnTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TStkpdnTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TStkpdnTmp.ReadInpDoc:Str12;
begin
  Result := oTmpTable.FieldByName('InpDoc').AsString;
end;

procedure TStkpdnTmp.WriteInpDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('InpDoc').AsString := pValue;
end;

function TStkpdnTmp.ReadInpItm:word;
begin
  Result := oTmpTable.FieldByName('InpItm').AsInteger;
end;

procedure TStkpdnTmp.WriteInpItm(pValue:word);
begin
  oTmpTable.FieldByName('InpItm').AsInteger := pValue;
end;

function TStkpdnTmp.ReadInpDat:TDatetime;
begin
  Result := oTmpTable.FieldByName('InpDat').AsDateTime;
end;

procedure TStkpdnTmp.WriteInpDat(pValue:TDatetime);
begin
  oTmpTable.FieldByName('InpDat').AsDateTime := pValue;
end;

function TStkpdnTmp.ReadInpFif:longint;
begin
  Result := oTmpTable.FieldByName('InpFif').AsInteger;
end;

procedure TStkpdnTmp.WriteInpFif(pValue:longint);
begin
  oTmpTable.FieldByName('InpFif').AsInteger := pValue;
end;

function TStkpdnTmp.ReadOutDoc:Str12;
begin
  Result := oTmpTable.FieldByName('OutDoc').AsString;
end;

procedure TStkpdnTmp.WriteOutDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('OutDoc').AsString := pValue;
end;

function TStkpdnTmp.ReadOutItm:word;
begin
  Result := oTmpTable.FieldByName('OutItm').AsInteger;
end;

procedure TStkpdnTmp.WriteOutItm(pValue:word);
begin
  oTmpTable.FieldByName('OutItm').AsInteger := pValue;
end;

function TStkpdnTmp.ReadOutDat:TDatetime;
begin
  Result := oTmpTable.FieldByName('OutDat').AsDateTime;
end;

procedure TStkpdnTmp.WriteOutDat(pValue:TDatetime);
begin
  oTmpTable.FieldByName('OutDat').AsDateTime := pValue;
end;

function TStkpdnTmp.ReadCrtUsr:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUsr').AsString;
end;

procedure TStkpdnTmp.WriteCrtUsr(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUsr').AsString := pValue;
end;

function TStkpdnTmp.ReadCrtDat:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDat').AsDateTime;
end;

procedure TStkpdnTmp.WriteCrtDat(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDat').AsDateTime := pValue;
end;

function TStkpdnTmp.ReadCrtTim:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TStkpdnTmp.WriteCrtTim(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTim').AsDateTime := pValue;
end;

function TStkpdnTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TStkpdnTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TStkpdnTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TStkpdnTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TStkpdnTmp.LocateRowNum (pRowNum:word):boolean;
begin
  SetIndex (ixRowNum);
  Result := oTmpTable.FindKey([pRowNum]);
end;

procedure TStkpdnTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TStkpdnTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TStkpdnTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TStkpdnTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TStkpdnTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TStkpdnTmp.First;
begin
  oTmpTable.First;
end;

procedure TStkpdnTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TStkpdnTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TStkpdnTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TStkpdnTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TStkpdnTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TStkpdnTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TStkpdnTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TStkpdnTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TStkpdnTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TStkpdnTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TStkpdnTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1918001}
