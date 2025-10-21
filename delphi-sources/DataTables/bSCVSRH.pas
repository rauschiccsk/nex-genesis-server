unit bSCVSRH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixEquNum = 'EquNum';
  ixSrhKey = 'SrhKey';
  ixSkKt = 'SkKt';

type
  TScvsrhBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadEquNum:Str20;          procedure WriteEquNum (pValue:Str20);
    function  ReadSrhKey:Str30;          procedure WriteSrhKey (pValue:Str30);
    function  ReadKeyTyp:Str1;           procedure WriteKeyTyp (pValue:Str1);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateEquNum (pEquNum:Str20):boolean;
    function LocateSrhKey (pSrhKey:Str30):boolean;
    function LocateSkKt (pSrhKey:Str30;pKeyTyp:Str1):boolean;
    function NearestEquNum (pEquNum:Str20):boolean;
    function NearestSrhKey (pSrhKey:Str30):boolean;
    function NearestSkKt (pSrhKey:Str30;pKeyTyp:Str1):boolean;

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
    property EquNum:Str20 read ReadEquNum write WriteEquNum;
    property SrhKey:Str30 read ReadSrhKey write WriteSrhKey;
    property KeyTyp:Str1 read ReadKeyTyp write WriteKeyTyp;
  end;

implementation

constructor TScvsrhBtr.Create;
begin
  oBtrTable := BtrInit ('SCVSRH',gPath.StkPath,Self);
end;

constructor TScvsrhBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('SCVSRH',pPath,Self);
end;

destructor TScvsrhBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TScvsrhBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TScvsrhBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TScvsrhBtr.ReadEquNum:Str20;
begin
  Result := oBtrTable.FieldByName('EquNum').AsString;
end;

procedure TScvsrhBtr.WriteEquNum(pValue:Str20);
begin
  oBtrTable.FieldByName('EquNum').AsString := pValue;
end;

function TScvsrhBtr.ReadSrhKey:Str30;
begin
  Result := oBtrTable.FieldByName('SrhKey').AsString;
end;

procedure TScvsrhBtr.WriteSrhKey(pValue:Str30);
begin
  oBtrTable.FieldByName('SrhKey').AsString := pValue;
end;

function TScvsrhBtr.ReadKeyTyp:Str1;
begin
  Result := oBtrTable.FieldByName('KeyTyp').AsString;
end;

procedure TScvsrhBtr.WriteKeyTyp(pValue:Str1);
begin
  oBtrTable.FieldByName('KeyTyp').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TScvsrhBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TScvsrhBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TScvsrhBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TScvsrhBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TScvsrhBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TScvsrhBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TScvsrhBtr.LocateEquNum (pEquNum:Str20):boolean;
begin
  SetIndex (ixEquNum);
  Result := oBtrTable.FindKey([pEquNum]);
end;

function TScvsrhBtr.LocateSrhKey (pSrhKey:Str30):boolean;
begin
  SetIndex (ixSrhKey);
  Result := oBtrTable.FindKey([pSrhKey]);
end;

function TScvsrhBtr.LocateSkKt (pSrhKey:Str30;pKeyTyp:Str1):boolean;
begin
  SetIndex (ixSkKt);
  Result := oBtrTable.FindKey([pSrhKey,pKeyTyp]);
end;

function TScvsrhBtr.NearestEquNum (pEquNum:Str20):boolean;
begin
  SetIndex (ixEquNum);
  Result := oBtrTable.FindNearest([pEquNum]);
end;

function TScvsrhBtr.NearestSrhKey (pSrhKey:Str30):boolean;
begin
  SetIndex (ixSrhKey);
  Result := oBtrTable.FindNearest([pSrhKey]);
end;

function TScvsrhBtr.NearestSkKt (pSrhKey:Str30;pKeyTyp:Str1):boolean;
begin
  SetIndex (ixSkKt);
  Result := oBtrTable.FindNearest([pSrhKey,pKeyTyp]);
end;

procedure TScvsrhBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TScvsrhBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TScvsrhBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TScvsrhBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TScvsrhBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TScvsrhBtr.First;
begin
  oBtrTable.First;
end;

procedure TScvsrhBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TScvsrhBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TScvsrhBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TScvsrhBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TScvsrhBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TScvsrhBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TScvsrhBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TScvsrhBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TScvsrhBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TScvsrhBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TScvsrhBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1916001}
