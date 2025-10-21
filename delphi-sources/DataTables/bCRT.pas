unit bCRT;

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
  TCrtBtr = class (TComponent)
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

constructor TCrtBtr.Create;
begin
  oBtrTable := BtrInit ('CRT',gPath.DlsPath,Self);
end;

constructor TCrtBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('CRT',pPath,Self);
end;

destructor TCrtBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TCrtBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TCrtBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TCrtBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TCrtBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TCrtBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TCrtBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TCrtBtr.ReadTxtTyp:Str1;
begin
  Result := oBtrTable.FieldByName('TxtTyp').AsString;
end;

procedure TCrtBtr.WriteTxtTyp(pValue:Str1);
begin
  oBtrTable.FieldByName('TxtTyp').AsString := pValue;
end;

function TCrtBtr.ReadLinNum:word;
begin
  Result := oBtrTable.FieldByName('LinNum').AsInteger;
end;

procedure TCrtBtr.WriteLinNum(pValue:word);
begin
  oBtrTable.FieldByName('LinNum').AsInteger := pValue;
end;

function TCrtBtr.ReadLinTxt:Str250;
begin
  Result := oBtrTable.FieldByName('LinTxt').AsString;
end;

procedure TCrtBtr.WriteLinTxt(pValue:Str250);
begin
  oBtrTable.FieldByName('LinTxt').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCrtBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCrtBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TCrtBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCrtBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TCrtBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TCrtBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TCrtBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TCrtBtr.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TCrtBtr.LocateDoItTy (pDocNum:Str12;pItmNum:word;pTxtTyp:Str1):boolean;
begin
  SetIndex (ixDoItTy);
  Result := oBtrTable.FindKey([pDocNum,pItmNum,pTxtTyp]);
end;

function TCrtBtr.LocateDnItTyLn (pDocNum:Str12;pItmNum:word;pTxtTyp:Str1;pLinNum:word):boolean;
begin
  SetIndex (ixDnItTyLn);
  Result := oBtrTable.FindKey([pDocNum,pItmNum,pTxtTyp,pLinNum]);
end;

function TCrtBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TCrtBtr.NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TCrtBtr.NearestDoItTy (pDocNum:Str12;pItmNum:word;pTxtTyp:Str1):boolean;
begin
  SetIndex (ixDoItTy);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum,pTxtTyp]);
end;

function TCrtBtr.NearestDnItTyLn (pDocNum:Str12;pItmNum:word;pTxtTyp:Str1;pLinNum:word):boolean;
begin
  SetIndex (ixDnItTyLn);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum,pTxtTyp,pLinNum]);
end;

procedure TCrtBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TCrtBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TCrtBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TCrtBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TCrtBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TCrtBtr.First;
begin
  oBtrTable.First;
end;

procedure TCrtBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TCrtBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TCrtBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TCrtBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TCrtBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TCrtBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TCrtBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TCrtBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TCrtBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TCrtBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TCrtBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1901005}
