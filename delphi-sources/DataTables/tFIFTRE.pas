unit tFIFTRE;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixLnDoItFn = '';

type
  TFiftreTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadLevNum:word;           procedure WriteLevNum (pValue:word);
    function  ReadOutDoc:Str12;          procedure WriteOutDoc (pValue:Str12);
    function  ReadOutItm:word;           procedure WriteOutItm (pValue:word);
    function  ReadFifNum:longint;        procedure WriteFifNum (pValue:longint);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadOutQnt:double;         procedure WriteOutQnt (pValue:double);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadPrvVal:double;         procedure WritePrvVal (pValue:double);
    function  ReadActVal:double;         procedure WriteActVal (pValue:double);
    function  ReadInpDoc:Str12;          procedure WriteInpDoc (pValue:Str12);
    function  ReadInpItm:word;           procedure WriteInpItm (pValue:word);
    function  ReadInpSmc:word;           procedure WriteInpSmc (pValue:word);
    function  ReadCPrice:double;         procedure WriteCPrice (pValue:double);
    function  ReadStatus:Str1;           procedure WriteStatus (pValue:Str1);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateLnDoItFn (pLevNum:word;pOutDoc:Str12;pOutItm:word;pFifNum:longint):boolean;

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
    property LevNum:word read ReadLevNum write WriteLevNum;
    property OutDoc:Str12 read ReadOutDoc write WriteOutDoc;
    property OutItm:word read ReadOutItm write WriteOutItm;
    property FifNum:longint read ReadFifNum write WriteFifNum;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property OutQnt:double read ReadOutQnt write WriteOutQnt;
    property CValue:double read ReadCValue write WriteCValue;
    property PrvVal:double read ReadPrvVal write WritePrvVal;
    property ActVal:double read ReadActVal write WriteActVal;
    property InpDoc:Str12 read ReadInpDoc write WriteInpDoc;
    property InpItm:word read ReadInpItm write WriteInpItm;
    property InpSmc:word read ReadInpSmc write WriteInpSmc;
    property CPrice:double read ReadCPrice write WriteCPrice;
    property Status:Str1 read ReadStatus write WriteStatus;
  end;

implementation

constructor TFiftreTmp.Create;
begin
  oTmpTable := TmpInit ('FIFTRE',Self);
end;

destructor TFiftreTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TFiftreTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TFiftreTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TFiftreTmp.ReadLevNum:word;
begin
  Result := oTmpTable.FieldByName('LevNum').AsInteger;
end;

procedure TFiftreTmp.WriteLevNum(pValue:word);
begin
  oTmpTable.FieldByName('LevNum').AsInteger := pValue;
end;

function TFiftreTmp.ReadOutDoc:Str12;
begin
  Result := oTmpTable.FieldByName('OutDoc').AsString;
end;

procedure TFiftreTmp.WriteOutDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('OutDoc').AsString := pValue;
end;

function TFiftreTmp.ReadOutItm:word;
begin
  Result := oTmpTable.FieldByName('OutItm').AsInteger;
end;

procedure TFiftreTmp.WriteOutItm(pValue:word);
begin
  oTmpTable.FieldByName('OutItm').AsInteger := pValue;
end;

function TFiftreTmp.ReadFifNum:longint;
begin
  Result := oTmpTable.FieldByName('FifNum').AsInteger;
end;

procedure TFiftreTmp.WriteFifNum(pValue:longint);
begin
  oTmpTable.FieldByName('FifNum').AsInteger := pValue;
end;

function TFiftreTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TFiftreTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TFiftreTmp.ReadOutQnt:double;
begin
  Result := oTmpTable.FieldByName('OutQnt').AsFloat;
end;

procedure TFiftreTmp.WriteOutQnt(pValue:double);
begin
  oTmpTable.FieldByName('OutQnt').AsFloat := pValue;
end;

function TFiftreTmp.ReadCValue:double;
begin
  Result := oTmpTable.FieldByName('CValue').AsFloat;
end;

procedure TFiftreTmp.WriteCValue(pValue:double);
begin
  oTmpTable.FieldByName('CValue').AsFloat := pValue;
end;

function TFiftreTmp.ReadPrvVal:double;
begin
  Result := oTmpTable.FieldByName('PrvVal').AsFloat;
end;

procedure TFiftreTmp.WritePrvVal(pValue:double);
begin
  oTmpTable.FieldByName('PrvVal').AsFloat := pValue;
end;

function TFiftreTmp.ReadActVal:double;
begin
  Result := oTmpTable.FieldByName('ActVal').AsFloat;
end;

procedure TFiftreTmp.WriteActVal(pValue:double);
begin
  oTmpTable.FieldByName('ActVal').AsFloat := pValue;
end;

function TFiftreTmp.ReadInpDoc:Str12;
begin
  Result := oTmpTable.FieldByName('InpDoc').AsString;
end;

procedure TFiftreTmp.WriteInpDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('InpDoc').AsString := pValue;
end;

function TFiftreTmp.ReadInpItm:word;
begin
  Result := oTmpTable.FieldByName('InpItm').AsInteger;
end;

procedure TFiftreTmp.WriteInpItm(pValue:word);
begin
  oTmpTable.FieldByName('InpItm').AsInteger := pValue;
end;

function TFiftreTmp.ReadInpSmc:word;
begin
  Result := oTmpTable.FieldByName('InpSmc').AsInteger;
end;

procedure TFiftreTmp.WriteInpSmc(pValue:word);
begin
  oTmpTable.FieldByName('InpSmc').AsInteger := pValue;
end;

function TFiftreTmp.ReadCPrice:double;
begin
  Result := oTmpTable.FieldByName('CPrice').AsFloat;
end;

procedure TFiftreTmp.WriteCPrice(pValue:double);
begin
  oTmpTable.FieldByName('CPrice').AsFloat := pValue;
end;

function TFiftreTmp.ReadStatus:Str1;
begin
  Result := oTmpTable.FieldByName('Status').AsString;
end;

procedure TFiftreTmp.WriteStatus(pValue:Str1);
begin
  oTmpTable.FieldByName('Status').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TFiftreTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TFiftreTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TFiftreTmp.LocateLnDoItFn (pLevNum:word;pOutDoc:Str12;pOutItm:word;pFifNum:longint):boolean;
begin
  SetIndex (ixLnDoItFn);
  Result := oTmpTable.FindKey([pLevNum,pOutDoc,pOutItm,pFifNum]);
end;

procedure TFiftreTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TFiftreTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TFiftreTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TFiftreTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TFiftreTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TFiftreTmp.First;
begin
  oTmpTable.First;
end;

procedure TFiftreTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TFiftreTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TFiftreTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TFiftreTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TFiftreTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TFiftreTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TFiftreTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TFiftreTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TFiftreTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TFiftreTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TFiftreTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
