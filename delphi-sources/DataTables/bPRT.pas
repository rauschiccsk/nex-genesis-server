unit bPRT;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = 'DocNum';
  ixDoIt = 'DoIt';
  ixDoItTy = 'DoItTy';
  ixDnItTyLn = 'DnItTyLn';

type
  TPrtBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadTxtTyp:Str1;           procedure WriteTxtTyp (pValue:Str1);
    function  ReadLinNum:word;           procedure WriteLinNum (pValue:word);
    function  ReadLinTxt:Str250;         procedure WriteLinTxt (pValue:Str250);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateDoItTy (pDocNum:Str12;pItmNum:word;pTxtTyp:Str1):boolean;
    function LocateDnItTyLn (pDocNum:Str12;pItmNum:word;pTxtTyp:Str1;pLinNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function NearestDoItTy (pDocNum:Str12;pItmNum:word;pTxtTyp:Str1):boolean;
    function NearestDnItTyLn (pDocNum:Str12;pItmNum:word;pTxtTyp:Str1;pLinNum:word):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pBookNum:Str5);
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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property TxtTyp:Str1 read ReadTxtTyp write WriteTxtTyp;
    property LinNum:word read ReadLinNum write WriteLinNum;
    property LinTxt:Str250 read ReadLinTxt write WriteLinTxt;
  end;

implementation

constructor TPrtBtr.Create;
begin
  oBtrTable := BtrInit ('PRT',gPath.DlsPath,Self);
end;

constructor TPrtBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('PRT',pPath,Self);
end;

destructor TPrtBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPrtBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPrtBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPrtBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TPrtBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TPrtBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TPrtBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TPrtBtr.ReadTxtTyp:Str1;
begin
  Result := oBtrTable.FieldByName('TxtTyp').AsString;
end;

procedure TPrtBtr.WriteTxtTyp(pValue:Str1);
begin
  oBtrTable.FieldByName('TxtTyp').AsString := pValue;
end;

function TPrtBtr.ReadLinNum:word;
begin
  Result := oBtrTable.FieldByName('LinNum').AsInteger;
end;

procedure TPrtBtr.WriteLinNum(pValue:word);
begin
  oBtrTable.FieldByName('LinNum').AsInteger := pValue;
end;

function TPrtBtr.ReadLinTxt:Str250;
begin
  Result := oBtrTable.FieldByName('LinTxt').AsString;
end;

procedure TPrtBtr.WriteLinTxt(pValue:Str250);
begin
  oBtrTable.FieldByName('LinTxt').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPrtBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPrtBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TPrtBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPrtBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPrtBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPrtBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPrtBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TPrtBtr.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TPrtBtr.LocateDoItTy (pDocNum:Str12;pItmNum:word;pTxtTyp:Str1):boolean;
begin
  SetIndex (ixDoItTy);
  Result := oBtrTable.FindKey([pDocNum,pItmNum,pTxtTyp]);
end;

function TPrtBtr.LocateDnItTyLn (pDocNum:Str12;pItmNum:word;pTxtTyp:Str1;pLinNum:word):boolean;
begin
  SetIndex (ixDnItTyLn);
  Result := oBtrTable.FindKey([pDocNum,pItmNum,pTxtTyp,pLinNum]);
end;

function TPrtBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TPrtBtr.NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TPrtBtr.NearestDoItTy (pDocNum:Str12;pItmNum:word;pTxtTyp:Str1):boolean;
begin
  SetIndex (ixDoItTy);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum,pTxtTyp]);
end;

function TPrtBtr.NearestDnItTyLn (pDocNum:Str12;pItmNum:word;pTxtTyp:Str1;pLinNum:word):boolean;
begin
  SetIndex (ixDnItTyLn);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum,pTxtTyp,pLinNum]);
end;

procedure TPrtBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPrtBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TPrtBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPrtBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPrtBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPrtBtr.First;
begin
  oBtrTable.First;
end;

procedure TPrtBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPrtBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPrtBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPrtBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPrtBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPrtBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPrtBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPrtBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPrtBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPrtBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPrtBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1810004}
