unit tTRDCPR;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixTnGs = '';
  ixGsName_ = 'GsName_';
  ixBarCode = 'BarCode';
  ixDocDate = 'DocDate';
  ixOutDoc = 'OutDoc';

type
  TTrdcprTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadTrdNum:Str12;          procedure WriteTrdNum (pValue:Str12);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadOutDoc:Str12;          procedure WriteOutDoc (pValue:Str12);
    function  ReadGsQnt_T:double;        procedure WriteGsQnt_T (pValue:double);
    function  ReadGsQnt_D:double;        procedure WriteGsQnt_D (pValue:double);
    function  ReadDifQnt:double;         procedure WriteDifQnt (pValue:double);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateTnGs (pTrdNum:Str12;pGsCode:longint):boolean;
    function LocateGsName_ (pGsName_:Str30):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateOutDoc (pOutDoc:Str12):boolean;

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
    property TrdNum:Str12 read ReadTrdNum write WriteTrdNum;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property OutDoc:Str12 read ReadOutDoc write WriteOutDoc;
    property GsQnt_T:double read ReadGsQnt_T write WriteGsQnt_T;
    property GsQnt_D:double read ReadGsQnt_D write WriteGsQnt_D;
    property DifQnt:double read ReadDifQnt write WriteDifQnt;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TTrdcprTmp.Create;
begin
  oTmpTable := TmpInit ('TRDCPR',Self);
end;

destructor TTrdcprTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TTrdcprTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TTrdcprTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TTrdcprTmp.ReadTrdNum:Str12;
begin
  Result := oTmpTable.FieldByName('TrdNum').AsString;
end;

procedure TTrdcprTmp.WriteTrdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('TrdNum').AsString := pValue;
end;

function TTrdcprTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TTrdcprTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TTrdcprTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TTrdcprTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TTrdcprTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TTrdcprTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TTrdcprTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TTrdcprTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TTrdcprTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TTrdcprTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TTrdcprTmp.ReadOutDoc:Str12;
begin
  Result := oTmpTable.FieldByName('OutDoc').AsString;
end;

procedure TTrdcprTmp.WriteOutDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('OutDoc').AsString := pValue;
end;

function TTrdcprTmp.ReadGsQnt_T:double;
begin
  Result := oTmpTable.FieldByName('GsQnt_T').AsFloat;
end;

procedure TTrdcprTmp.WriteGsQnt_T(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt_T').AsFloat := pValue;
end;

function TTrdcprTmp.ReadGsQnt_D:double;
begin
  Result := oTmpTable.FieldByName('GsQnt_D').AsFloat;
end;

procedure TTrdcprTmp.WriteGsQnt_D(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt_D').AsFloat := pValue;
end;

function TTrdcprTmp.ReadDifQnt:double;
begin
  Result := oTmpTable.FieldByName('DifQnt').AsFloat;
end;

procedure TTrdcprTmp.WriteDifQnt(pValue:double);
begin
  oTmpTable.FieldByName('DifQnt').AsFloat := pValue;
end;

function TTrdcprTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TTrdcprTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTrdcprTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TTrdcprTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TTrdcprTmp.LocateTnGs (pTrdNum:Str12;pGsCode:longint):boolean;
begin
  SetIndex (ixTnGs);
  Result := oTmpTable.FindKey([pTrdNum,pGsCode]);
end;

function TTrdcprTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

function TTrdcprTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

function TTrdcprTmp.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oTmpTable.FindKey([pDocDate]);
end;

function TTrdcprTmp.LocateOutDoc (pOutDoc:Str12):boolean;
begin
  SetIndex (ixOutDoc);
  Result := oTmpTable.FindKey([pOutDoc]);
end;

procedure TTrdcprTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TTrdcprTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TTrdcprTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TTrdcprTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TTrdcprTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TTrdcprTmp.First;
begin
  oTmpTable.First;
end;

procedure TTrdcprTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TTrdcprTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TTrdcprTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TTrdcprTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TTrdcprTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TTrdcprTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TTrdcprTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TTrdcprTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TTrdcprTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TTrdcprTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TTrdcprTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
