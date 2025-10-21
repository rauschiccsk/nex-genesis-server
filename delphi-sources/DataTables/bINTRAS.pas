unit bINTRAS;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixUlAn = 'UlAn';

type
  TIntrasBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadUrsLan:Str2;           procedure WriteUrsLan (pValue:Str2);
    function  ReadArtNum:Str10;          procedure WriteArtNum (pValue:Str10);
    function  ReadArtNam:Str50;          procedure WriteArtNam (pValue:Str50);
    function  ReadArtDes:Str50;          procedure WriteArtDes (pValue:Str50);
    function  ReadArtNot:Str50;          procedure WriteArtNot (pValue:Str50);
    function  ReadArtQnt:double;         procedure WriteArtQnt (pValue:double);
    function  ReadArtPce:double;         procedure WriteArtPce (pValue:double);
    function  ReadArtVal:double;         procedure WriteArtVal (pValue:double);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateUlAn (pUrsLan:Str2;pArtNum:Str10):boolean;
    function NearestUlAn (pUrsLan:Str2;pArtNum:Str10):boolean;

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
    procedure EnableControls;
    procedure DisableControls;
  published
    property BtrTable:TNexBtrTable read oBtrTable;
    property Count:integer read ReadCount;
    // Pristup k databazovym poliam
    property UrsLan:Str2 read ReadUrsLan write WriteUrsLan;
    property ArtNum:Str10 read ReadArtNum write WriteArtNum;
    property ArtNam:Str50 read ReadArtNam write WriteArtNam;
    property ArtDes:Str50 read ReadArtDes write WriteArtDes;
    property ArtNot:Str50 read ReadArtNot write WriteArtNot;
    property ArtQnt:double read ReadArtQnt write WriteArtQnt;
    property ArtPce:double read ReadArtPce write WriteArtPce;
    property ArtVal:double read ReadArtVal write WriteArtVal;
  end;

implementation

constructor TIntrasBtr.Create;
begin
  oBtrTable := BtrInit ('INTRAS',gPath.StkPath,Self);
end;

constructor TIntrasBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('INTRAS',pPath,Self);
end;

destructor TIntrasBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TIntrasBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TIntrasBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TIntrasBtr.ReadUrsLan:Str2;
begin
  Result := oBtrTable.FieldByName('UrsLan').AsString;
end;

procedure TIntrasBtr.WriteUrsLan(pValue:Str2);
begin
  oBtrTable.FieldByName('UrsLan').AsString := pValue;
end;

function TIntrasBtr.ReadArtNum:Str10;
begin
  Result := oBtrTable.FieldByName('ArtNum').AsString;
end;

procedure TIntrasBtr.WriteArtNum(pValue:Str10);
begin
  oBtrTable.FieldByName('ArtNum').AsString := pValue;
end;

function TIntrasBtr.ReadArtNam:Str50;
begin
  Result := oBtrTable.FieldByName('ArtNam').AsString;
end;

procedure TIntrasBtr.WriteArtNam(pValue:Str50);
begin
  oBtrTable.FieldByName('ArtNam').AsString := pValue;
end;

function TIntrasBtr.ReadArtDes:Str50;
begin
  Result := oBtrTable.FieldByName('ArtDes').AsString;
end;

procedure TIntrasBtr.WriteArtDes(pValue:Str50);
begin
  oBtrTable.FieldByName('ArtDes').AsString := pValue;
end;

function TIntrasBtr.ReadArtNot:Str50;
begin
  Result := oBtrTable.FieldByName('ArtNot').AsString;
end;

procedure TIntrasBtr.WriteArtNot(pValue:Str50);
begin
  oBtrTable.FieldByName('ArtNot').AsString := pValue;
end;

function TIntrasBtr.ReadArtQnt:double;
begin
  Result := oBtrTable.FieldByName('ArtQnt').AsFloat;
end;

procedure TIntrasBtr.WriteArtQnt(pValue:double);
begin
  oBtrTable.FieldByName('ArtQnt').AsFloat := pValue;
end;

function TIntrasBtr.ReadArtPce:double;
begin
  Result := oBtrTable.FieldByName('ArtPce').AsFloat;
end;

procedure TIntrasBtr.WriteArtPce(pValue:double);
begin
  oBtrTable.FieldByName('ArtPce').AsFloat := pValue;
end;

function TIntrasBtr.ReadArtVal:double;
begin
  Result := oBtrTable.FieldByName('ArtVal').AsFloat;
end;

procedure TIntrasBtr.WriteArtVal(pValue:double);
begin
  oBtrTable.FieldByName('ArtVal').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TIntrasBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIntrasBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TIntrasBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIntrasBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TIntrasBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TIntrasBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TIntrasBtr.LocateUlAn (pUrsLan:Str2;pArtNum:Str10):boolean;
begin
  SetIndex (ixUlAn);
  Result := oBtrTable.FindKey([pUrsLan,pArtNum]);
end;

function TIntrasBtr.NearestUlAn (pUrsLan:Str2;pArtNum:Str10):boolean;
begin
  SetIndex (ixUlAn);
  Result := oBtrTable.FindNearest([pUrsLan,pArtNum]);
end;

procedure TIntrasBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TIntrasBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TIntrasBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TIntrasBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TIntrasBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TIntrasBtr.First;
begin
  oBtrTable.First;
end;

procedure TIntrasBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TIntrasBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TIntrasBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TIntrasBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TIntrasBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TIntrasBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TIntrasBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TIntrasBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TIntrasBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TIntrasBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TIntrasBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1921001}
