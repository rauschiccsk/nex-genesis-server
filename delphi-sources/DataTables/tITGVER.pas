unit tITGVER;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixTciDI = '';
  ixItgDI = 'ItgDI';

type
  TItgverTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadTDocNum:Str12;         procedure WriteTDocNum (pValue:Str12);
    function  ReadTItmNum:longint;       procedure WriteTItmNum (pValue:longint);
    function  ReadTIcdDoc:Str12;         procedure WriteTIcdDoc (pValue:Str12);
    function  ReadTIcdItm:longint;       procedure WriteTIcdItm (pValue:longint);
    function  ReadIDocNum:Str12;         procedure WriteIDocNum (pValue:Str12);
    function  ReadIItmNum:longint;       procedure WriteIItmNum (pValue:longint);
    function  ReadIIcdDoc:Str12;         procedure WriteIIcdDoc (pValue:Str12);
    function  ReadIIcdItm:longint;       procedure WriteIIcdItm (pValue:longint);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadStkStat:Str1;          procedure WriteStkStat (pValue:Str1);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateTciDI (pTDocNum:Str12;pTItmNum:longint):boolean;
    function LocateItgDI (pIDocNum:Str12;pIItmNum:longint):boolean;

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
    property TDocNum:Str12 read ReadTDocNum write WriteTDocNum;
    property TItmNum:longint read ReadTItmNum write WriteTItmNum;
    property TIcdDoc:Str12 read ReadTIcdDoc write WriteTIcdDoc;
    property TIcdItm:longint read ReadTIcdItm write WriteTIcdItm;
    property IDocNum:Str12 read ReadIDocNum write WriteIDocNum;
    property IItmNum:longint read ReadIItmNum write WriteIItmNum;
    property IIcdDoc:Str12 read ReadIIcdDoc write WriteIIcdDoc;
    property IIcdItm:longint read ReadIIcdItm write WriteIIcdItm;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property StkStat:Str1 read ReadStkStat write WriteStkStat;
  end;

implementation

constructor TItgverTmp.Create;
begin
  oTmpTable := TmpInit ('ITGVER',Self);
end;

destructor TItgverTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TItgverTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TItgverTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TItgverTmp.ReadTDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('TDocNum').AsString;
end;

procedure TItgverTmp.WriteTDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('TDocNum').AsString := pValue;
end;

function TItgverTmp.ReadTItmNum:longint;
begin
  Result := oTmpTable.FieldByName('TItmNum').AsInteger;
end;

procedure TItgverTmp.WriteTItmNum(pValue:longint);
begin
  oTmpTable.FieldByName('TItmNum').AsInteger := pValue;
end;

function TItgverTmp.ReadTIcdDoc:Str12;
begin
  Result := oTmpTable.FieldByName('TIcdDoc').AsString;
end;

procedure TItgverTmp.WriteTIcdDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('TIcdDoc').AsString := pValue;
end;

function TItgverTmp.ReadTIcdItm:longint;
begin
  Result := oTmpTable.FieldByName('TIcdItm').AsInteger;
end;

procedure TItgverTmp.WriteTIcdItm(pValue:longint);
begin
  oTmpTable.FieldByName('TIcdItm').AsInteger := pValue;
end;

function TItgverTmp.ReadIDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('IDocNum').AsString;
end;

procedure TItgverTmp.WriteIDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('IDocNum').AsString := pValue;
end;

function TItgverTmp.ReadIItmNum:longint;
begin
  Result := oTmpTable.FieldByName('IItmNum').AsInteger;
end;

procedure TItgverTmp.WriteIItmNum(pValue:longint);
begin
  oTmpTable.FieldByName('IItmNum').AsInteger := pValue;
end;

function TItgverTmp.ReadIIcdDoc:Str12;
begin
  Result := oTmpTable.FieldByName('IIcdDoc').AsString;
end;

procedure TItgverTmp.WriteIIcdDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('IIcdDoc').AsString := pValue;
end;

function TItgverTmp.ReadIIcdItm:longint;
begin
  Result := oTmpTable.FieldByName('IIcdItm').AsInteger;
end;

procedure TItgverTmp.WriteIIcdItm(pValue:longint);
begin
  oTmpTable.FieldByName('IIcdItm').AsInteger := pValue;
end;

function TItgverTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TItgverTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TItgverTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TItgverTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TItgverTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TItgverTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TItgverTmp.ReadGsQnt:double;
begin
  Result := oTmpTable.FieldByName('GsQnt').AsFloat;
end;

procedure TItgverTmp.WriteGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TItgverTmp.ReadStkStat:Str1;
begin
  Result := oTmpTable.FieldByName('StkStat').AsString;
end;

procedure TItgverTmp.WriteStkStat(pValue:Str1);
begin
  oTmpTable.FieldByName('StkStat').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TItgverTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TItgverTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TItgverTmp.LocateTciDI (pTDocNum:Str12;pTItmNum:longint):boolean;
begin
  SetIndex (ixTciDI);
  Result := oTmpTable.FindKey([pTDocNum,pTItmNum]);
end;

function TItgverTmp.LocateItgDI (pIDocNum:Str12;pIItmNum:longint):boolean;
begin
  SetIndex (ixItgDI);
  Result := oTmpTable.FindKey([pIDocNum,pIItmNum]);
end;

procedure TItgverTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TItgverTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TItgverTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TItgverTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TItgverTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TItgverTmp.First;
begin
  oTmpTable.First;
end;

procedure TItgverTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TItgverTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TItgverTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TItgverTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TItgverTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TItgverTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TItgverTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TItgverTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TItgverTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TItgverTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TItgverTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
