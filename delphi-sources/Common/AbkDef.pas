unit AbkDef;
// abkdef.bdf
interface

uses
  IcTypes, NxbDef,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, BtrTable, NexBtrTable;

type
  TAbk = class(TForm)
    btABKDEF: TNexBtrTable;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    oNxb: TNxb;
    function ReadCount:integer;
    function ReadGrpNum:word;        procedure WriteGrpNum(pValue:word);
    function ReadPmdMark:Str6;        procedure WritePmdMark(pValue:Str6);
    function ReadBookNum:Str5;        procedure WriteBookNum(pValue:Str5);
    function ReadBookName:Str30;
  public
    function Eof: boolean;
    function Locate (pGrpNum:word):boolean; overload;
    function Locate (pGrpNum:word;pPmdMark:Str6):boolean; overload;
    function Locate (pGrpNum:word;pPmdMark:Str6;pBookNum:Str5):boolean; overload;
    function Nearest (pGrpNum:word):boolean; overload;
    function Nearest (pGrpNum:word;pPmdMark:Str6):boolean; overload;
    function Nearest (pGrpNum:word;pPmdMark:Str6;pBookNum:Str5):boolean; overload;
    function Add (pGrpNum:word;pPmdMark:Str6;pBookNum:Str5):boolean;
    procedure Del (pGrpNum:word); overload;
    procedure Del (pGrpNum:word;pPmdMark:Str6); overload;
    procedure Del (pGrpNum:word;pPmdMark:Str6;pBookNum:Str5); overload;
    procedure DelBok (pPmdMark:Str6;pBookNum:Str5);
    procedure IndGrpNum; // Nastavi index na GrpNum
    procedure IndGrPm;    // nastavi index na GrpNum PmdMark
    procedure IndGrPmBn;  // nastavi index na GrpNum PmdMark BookNum
    procedure Prior;
    procedure Next;
    procedure First;
    procedure Last;
    procedure Insert;
    procedure Edit;
    procedure Post;
    procedure Delete;
    procedure SwapIndex;
    procedure RestoreIndex;
  published
    property DataSet:TNexBtrTable read btABKDEF;
    property Count:integer read ReadCount;
    property GrpNum:word read ReadGrpNum write WriteGrpNum;
    property PmdMark:Str6 read ReadPmdMark write WritePmdMark;
    property BookNum:Str5 read ReadBookNum write WriteBookNum;
    property BookName:Str30 read ReadBookName;
  end;

implementation

{$R *.dfm}

procedure TAbk.FormCreate(Sender: TObject);
begin
  btABKDEF.Open;
  oNxb := TNxb.Create(Self);
end;

procedure TAbk.FormDestroy(Sender: TObject);
begin
  FreeAndNil (oNxb);
  btABKDEF.Close;
end;

// *************************************** PRIVATE ********************************************

function TAbk.ReadCount:integer;
begin
  Result := btABKDEF.RecordCount;
end;

function TAbk.ReadGrpNum:word;
begin
  Result := btABKDEF.FieldByName('GrpNum').AsInteger;
end;

procedure TAbk.WriteGrpNum(pValue:word);
begin
  btABKDEF.FieldByName('GrpNum').AsInteger := pValue;
end;

function TAbk.ReadPmdMark:Str6;
begin
  Result := btABKDEF.FieldByName('PmdMark').AsString;
end;

procedure TAbk.WritePmdMark(pValue:Str6);
begin
  btABKDEF.FieldByName('PmdMark').AsString := pValue;
end;

function TAbk.ReadBookNum:Str5;
begin
  Result := btABKDEF.FieldByName('BookNum').AsString;
end;

procedure TAbk.WriteBookNum(pValue:Str5);
begin
  btABKDEF.FieldByName('BookNum').AsString := pValue;
end;

function TAbk.ReadBookName:Str30;
begin
  Result := oNxb.GetBookName(PmdMark,BookNum);
end;

// **************************************** PUBLIC ********************************************

function TAbk.Eof: boolean;
begin
  Result := btABKDEF.Eof;
end;

function TAbk.Locate (pGrpNum:word):boolean;
begin
  IndGrpNum;
  Result := btABKDEF.FindKey([pGrpNum]);
end;

function TAbk.Locate (pGrpNum:word;pPmdMark:Str6):boolean;
begin
  IndGrPm;
  Result := btABKDEF.FindKey([pGrpNum,pPmdMark]);
end;

function TAbk.Locate (pGrpNum:word;pPmdMark:Str6;pBookNum:Str5):boolean;
begin
  IndGrPmBn;
  Result := btABKDEF.FindKey([pGrpNum,pPmdMark,pBookNum]);
end;

function TAbk.Nearest (pGrpNum:word):boolean;
begin
  IndGrpNum;
  Result := btABKDEF.FindNearest([pGrpNum]);
end;

function TAbk.Nearest (pGrpNum:word;pPmdMark:Str6):boolean;
begin
  IndGrPm;
  Result := btABKDEF.FindNearest([pGrpNum,pPmdMark]);
end;

function TAbk.Nearest (pGrpNum:word;pPmdMark:Str6;pBookNum:Str5):boolean;
begin
  IndGrPmBn;
  Result := btABKDEF.FindNearest([pGrpNum,pPmdMark,pBookNum]);
end;

function TAbk.Add (pGrpNum:word;pPmdMark:Str6;pBookNum:Str5):boolean;
begin
  Result := FALSE;
  SwapIndex;
  If not Locate (pGrpNum,pPmdMark,pBookNum) then begin
    Result := TRUE;
    Insert;
    GrpNum := pGrpNum;
    PmdMark := pPmdMark;
    BookNum := pBookNum;
    Post;
  end;
  RestoreIndex;
end;

procedure TAbk.Del (pGrpNum:word);
begin
  If Count>0 then begin
    First;
    Repeat
      Application.ProcessMessages;
      If GrpNum=pGrpNum
        then Delete
        else Next;
    until Eof or (Count=0);
  end;
end;

procedure TAbk.Del (pGrpNum:word;pPmdMark:Str6);
begin
  SwapIndex;
  If Locate (pGrpNum,pPmdMark) then begin
    Repeat
      Application.ProcessMessages;
      Delete;
    until Eof or (GrpNum<>pGrpNum) or (PmdMark<>pPmdMark);
  end;
  RestoreIndex;
end;

procedure TAbk.Del (pGrpNum:word;pPmdMark:Str6;pBookNum:Str5);
begin
  SwapIndex;
  If Locate (pGrpNum,pPmdMark,pBookNum) then Delete;
  RestoreIndex;
end;

procedure TAbk.DelBok (pPmdMark:Str6;pBookNum:Str5);
begin
  If Count>0 then begin
    First;
    Repeat
      Application.ProcessMessages;
      If (BookNum=pBookNum) and (PmdMark=pPmdMark)
        then Delete
        else Next;
    until Eof or (Count=0);
  end;
end;

procedure TAbk.Prior;
begin
  btABKDEF.Prior;
end;

procedure TAbk.Delete;
begin
  btABKDEF.Delete;
end;

procedure TAbk.Next;
begin
  btABKDEF.Next;
end;

procedure TAbk.First;
begin
  btABKDEF.First;
end;

procedure TAbk.Last;
begin
  btABKDEF.Last;
end;

procedure TAbk.Insert;
begin
  btABKDEF.Insert;
end;

procedure TAbk.Edit;
begin
  btABKDEF.Edit;
end;

procedure TAbk.Post;
begin
  btABKDEF.Post;
end;

procedure TAbk.SwapIndex;
begin
  btABKDEF.SwapIndex;
end;

procedure TAbk.RestoreIndex;
begin
  btABKDEF.RestoreIndex;
end;

procedure TAbk.IndGrpNum; // Nastavi index na GrpNum
begin
  If btABKDEF.IndexName<>'GrpNum' then btABKDEF.IndexName := 'GrpNum';
end;

procedure TAbk.IndGrPm;    // nastavi index na GrpNum PmdMark
begin
  If btABKDEF.IndexName<>'GrPm' then btABKDEF.IndexName := 'GrPm';
end;

procedure TAbk.IndGrPmBn;  // nastavi index na GrpNum PmdMark BookNum
begin
  If btABKDEF.IndexName<>'GrPmBn' then btABKDEF.IndexName := 'GrPmBn';
end;

end.
