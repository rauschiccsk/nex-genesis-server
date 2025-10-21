unit bAPT;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDnTtTl = 'DnTtTl';
  ixDnTt = 'DnTt';
  ixDocNum = 'DocNum';

type
  TAptBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadTxtTyp:Str1;           procedure WriteTxtTyp (pValue:Str1);
    function  ReadTxtLin:word;           procedure WriteTxtLin (pValue:word);
    function  ReadTxtVal:Str250;         procedure WriteTxtVal (pValue:Str250);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateDnTtTl (pDocNum:Str12;pTxtTyp:Str1;pTxtLin:word):boolean;
    function LocateDnTt (pDocNum:Str12;pTxtTyp:Str1):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function NearestDnTtTl (pDocNum:Str12;pTxtTyp:Str1;pTxtLin:word):boolean;
    function NearestDnTt (pDocNum:Str12;pTxtTyp:Str1):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;

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
    property TxtTyp:Str1 read ReadTxtTyp write WriteTxtTyp;
    property TxtLin:word read ReadTxtLin write WriteTxtLin;
    property TxtVal:Str250 read ReadTxtVal write WriteTxtVal;
  end;

implementation

constructor TAptBtr.Create;
begin
  oBtrTable := BtrInit ('APT',gPath.DlsPath,Self);
end;

constructor TAptBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('APT',pPath,Self);
end;

destructor TAptBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TAptBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TAptBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TAptBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TAptBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TAptBtr.ReadTxtTyp:Str1;
begin
  Result := oBtrTable.FieldByName('TxtTyp').AsString;
end;

procedure TAptBtr.WriteTxtTyp(pValue:Str1);
begin
  oBtrTable.FieldByName('TxtTyp').AsString := pValue;
end;

function TAptBtr.ReadTxtLin:word;
begin
  Result := oBtrTable.FieldByName('TxtLin').AsInteger;
end;

procedure TAptBtr.WriteTxtLin(pValue:word);
begin
  oBtrTable.FieldByName('TxtLin').AsInteger := pValue;
end;

function TAptBtr.ReadTxtVal:Str250;
begin
  Result := oBtrTable.FieldByName('TxtVal').AsString;
end;

procedure TAptBtr.WriteTxtVal(pValue:Str250);
begin
  oBtrTable.FieldByName('TxtVal').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAptBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAptBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TAptBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAptBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TAptBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TAptBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TAptBtr.LocateDnTtTl (pDocNum:Str12;pTxtTyp:Str1;pTxtLin:word):boolean;
begin
  SetIndex (ixDnTtTl);
  Result := oBtrTable.FindKey([pDocNum,pTxtTyp,pTxtLin]);
end;

function TAptBtr.LocateDnTt (pDocNum:Str12;pTxtTyp:Str1):boolean;
begin
  SetIndex (ixDnTt);
  Result := oBtrTable.FindKey([pDocNum,pTxtTyp]);
end;

function TAptBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TAptBtr.NearestDnTtTl (pDocNum:Str12;pTxtTyp:Str1;pTxtLin:word):boolean;
begin
  SetIndex (ixDnTtTl);
  Result := oBtrTable.FindNearest([pDocNum,pTxtTyp,pTxtLin]);
end;

function TAptBtr.NearestDnTt (pDocNum:Str12;pTxtTyp:Str1):boolean;
begin
  SetIndex (ixDnTt);
  Result := oBtrTable.FindNearest([pDocNum,pTxtTyp]);
end;

function TAptBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

procedure TAptBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TAptBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TAptBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TAptBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TAptBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TAptBtr.First;
begin
  oBtrTable.First;
end;

procedure TAptBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TAptBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TAptBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TAptBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TAptBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TAptBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TAptBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TAptBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TAptBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TAptBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TAptBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
