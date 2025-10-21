unit tHEDVER;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = '';
  ixDocDat = 'DocDat';
  ixPaName_ = 'PaName_';

type
  THedverTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadDocDat:TDatetime;      procedure WriteDocDat (pValue:TDatetime);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadPaName_:Str30;         procedure WritePaName_ (pValue:Str30);
    function  ReadDocVal:double;         procedure WriteDocVal (pValue:double);
    function  ReadItmVal:double;         procedure WriteItmVal (pValue:double);
    function  ReadDocWgh:double;         procedure WriteDocWgh (pValue:double);
    function  ReadItmWgh:double;         procedure WriteItmWgh (pValue:double);
    function  ReadDocVol:double;         procedure WriteDocVol (pValue:double);
    function  ReadItmVol:double;         procedure WriteItmVol (pValue:double);
    function  ReadDocQnt:double;         procedure WriteDocQnt (pValue:double);
    function  ReadItmQnt:double;         procedure WriteItmQnt (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDocDat (pDocDat:TDatetime):boolean;
    function LocatePaName_ (pPaName_:Str30):boolean;

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
    property DocDat:TDatetime read ReadDocDat write WriteDocDat;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property PaName_:Str30 read ReadPaName_ write WritePaName_;
    property DocVal:double read ReadDocVal write WriteDocVal;
    property ItmVal:double read ReadItmVal write WriteItmVal;
    property DocWgh:double read ReadDocWgh write WriteDocWgh;
    property ItmWgh:double read ReadItmWgh write WriteItmWgh;
    property DocVol:double read ReadDocVol write WriteDocVol;
    property ItmVol:double read ReadItmVol write WriteItmVol;
    property DocQnt:double read ReadDocQnt write WriteDocQnt;
    property ItmQnt:double read ReadItmQnt write WriteItmQnt;
  end;

implementation

constructor THedverTmp.Create;
begin
  oTmpTable := TmpInit ('HEDVER',Self);
end;

destructor THedverTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function THedverTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function THedverTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function THedverTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure THedverTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function THedverTmp.ReadDocDat:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDat').AsDateTime;
end;

procedure THedverTmp.WriteDocDat(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDat').AsDateTime := pValue;
end;

function THedverTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure THedverTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function THedverTmp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure THedverTmp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function THedverTmp.ReadPaName_:Str30;
begin
  Result := oTmpTable.FieldByName('PaName_').AsString;
end;

procedure THedverTmp.WritePaName_(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName_').AsString := pValue;
end;

function THedverTmp.ReadDocVal:double;
begin
  Result := oTmpTable.FieldByName('DocVal').AsFloat;
end;

procedure THedverTmp.WriteDocVal(pValue:double);
begin
  oTmpTable.FieldByName('DocVal').AsFloat := pValue;
end;

function THedverTmp.ReadItmVal:double;
begin
  Result := oTmpTable.FieldByName('ItmVal').AsFloat;
end;

procedure THedverTmp.WriteItmVal(pValue:double);
begin
  oTmpTable.FieldByName('ItmVal').AsFloat := pValue;
end;

function THedverTmp.ReadDocWgh:double;
begin
  Result := oTmpTable.FieldByName('DocWgh').AsFloat;
end;

procedure THedverTmp.WriteDocWgh(pValue:double);
begin
  oTmpTable.FieldByName('DocWgh').AsFloat := pValue;
end;

function THedverTmp.ReadItmWgh:double;
begin
  Result := oTmpTable.FieldByName('ItmWgh').AsFloat;
end;

procedure THedverTmp.WriteItmWgh(pValue:double);
begin
  oTmpTable.FieldByName('ItmWgh').AsFloat := pValue;
end;

function THedverTmp.ReadDocVol:double;
begin
  Result := oTmpTable.FieldByName('DocVol').AsFloat;
end;

procedure THedverTmp.WriteDocVol(pValue:double);
begin
  oTmpTable.FieldByName('DocVol').AsFloat := pValue;
end;

function THedverTmp.ReadItmVol:double;
begin
  Result := oTmpTable.FieldByName('ItmVol').AsFloat;
end;

procedure THedverTmp.WriteItmVol(pValue:double);
begin
  oTmpTable.FieldByName('ItmVol').AsFloat := pValue;
end;

function THedverTmp.ReadDocQnt:double;
begin
  Result := oTmpTable.FieldByName('DocQnt').AsFloat;
end;

procedure THedverTmp.WriteDocQnt(pValue:double);
begin
  oTmpTable.FieldByName('DocQnt').AsFloat := pValue;
end;

function THedverTmp.ReadItmQnt:double;
begin
  Result := oTmpTable.FieldByName('ItmQnt').AsFloat;
end;

procedure THedverTmp.WriteItmQnt(pValue:double);
begin
  oTmpTable.FieldByName('ItmQnt').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function THedverTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function THedverTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function THedverTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function THedverTmp.LocateDocDat (pDocDat:TDatetime):boolean;
begin
  SetIndex (ixDocDat);
  Result := oTmpTable.FindKey([pDocDat]);
end;

function THedverTmp.LocatePaName_ (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName_);
  Result := oTmpTable.FindKey([pPaName_]);
end;

procedure THedverTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure THedverTmp.Open;
begin
  oTmpTable.Open;
end;

procedure THedverTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure THedverTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure THedverTmp.Next;
begin
  oTmpTable.Next;
end;

procedure THedverTmp.First;
begin
  oTmpTable.First;
end;

procedure THedverTmp.Last;
begin
  oTmpTable.Last;
end;

procedure THedverTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure THedverTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure THedverTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure THedverTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure THedverTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure THedverTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure THedverTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure THedverTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure THedverTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure THedverTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1922001}
