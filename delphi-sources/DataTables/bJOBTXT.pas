unit bJOBTXT;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDnInTtTl = 'DnInTtTl';
  ixDnInTt = 'DnInTt';
  ixDnIn = 'DnIn';
  ixDocNum = 'DocNum';

type
  TJobtxtBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
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
    function LocateDnInTtTl (pDocNum:Str12;pItmNum:word;pTxtTyp:Str1;pTxtLin:word):boolean;
    function LocateDnInTt (pDocNum:Str12;pItmNum:word;pTxtTyp:Str1):boolean;
    function LocateDnIn (pDocNum:Str12;pItmNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function NearestDnInTtTl (pDocNum:Str12;pItmNum:word;pTxtTyp:Str1;pTxtLin:word):boolean;
    function NearestDnInTt (pDocNum:Str12;pItmNum:word;pTxtTyp:Str1):boolean;
    function NearestDnIn (pDocNum:Str12;pItmNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;

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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property TxtTyp:Str1 read ReadTxtTyp write WriteTxtTyp;
    property TxtLin:word read ReadTxtLin write WriteTxtLin;
    property TxtVal:Str250 read ReadTxtVal write WriteTxtVal;
  end;

implementation

constructor TJobtxtBtr.Create;
begin
  oBtrTable := BtrInit ('JOBTXT',gPath.DlsPath,Self);
end;

constructor TJobtxtBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('JOBTXT',pPath,Self);
end;

destructor TJobtxtBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TJobtxtBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TJobtxtBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TJobtxtBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TJobtxtBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TJobtxtBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TJobtxtBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TJobtxtBtr.ReadTxtTyp:Str1;
begin
  Result := oBtrTable.FieldByName('TxtTyp').AsString;
end;

procedure TJobtxtBtr.WriteTxtTyp(pValue:Str1);
begin
  oBtrTable.FieldByName('TxtTyp').AsString := pValue;
end;

function TJobtxtBtr.ReadTxtLin:word;
begin
  Result := oBtrTable.FieldByName('TxtLin').AsInteger;
end;

procedure TJobtxtBtr.WriteTxtLin(pValue:word);
begin
  oBtrTable.FieldByName('TxtLin').AsInteger := pValue;
end;

function TJobtxtBtr.ReadTxtVal:Str250;
begin
  Result := oBtrTable.FieldByName('TxtVal').AsString;
end;

procedure TJobtxtBtr.WriteTxtVal(pValue:Str250);
begin
  oBtrTable.FieldByName('TxtVal').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TJobtxtBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TJobtxtBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TJobtxtBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TJobtxtBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TJobtxtBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TJobtxtBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TJobtxtBtr.LocateDnInTtTl (pDocNum:Str12;pItmNum:word;pTxtTyp:Str1;pTxtLin:word):boolean;
begin
  SetIndex (ixDnInTtTl);
  Result := oBtrTable.FindKey([pDocNum,pItmNum,pTxtTyp,pTxtLin]);
end;

function TJobtxtBtr.LocateDnInTt (pDocNum:Str12;pItmNum:word;pTxtTyp:Str1):boolean;
begin
  SetIndex (ixDnInTt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum,pTxtTyp]);
end;

function TJobtxtBtr.LocateDnIn (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDnIn);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TJobtxtBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TJobtxtBtr.NearestDnInTtTl (pDocNum:Str12;pItmNum:word;pTxtTyp:Str1;pTxtLin:word):boolean;
begin
  SetIndex (ixDnInTtTl);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum,pTxtTyp,pTxtLin]);
end;

function TJobtxtBtr.NearestDnInTt (pDocNum:Str12;pItmNum:word;pTxtTyp:Str1):boolean;
begin
  SetIndex (ixDnInTt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum,pTxtTyp]);
end;

function TJobtxtBtr.NearestDnIn (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDnIn);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TJobtxtBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

procedure TJobtxtBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TJobtxtBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TJobtxtBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TJobtxtBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TJobtxtBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TJobtxtBtr.First;
begin
  oBtrTable.First;
end;

procedure TJobtxtBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TJobtxtBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TJobtxtBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TJobtxtBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TJobtxtBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TJobtxtBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TJobtxtBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TJobtxtBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TJobtxtBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TJobtxtBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TJobtxtBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
