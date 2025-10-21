unit ApmDef;
// APMDEF.BDF
interface

uses
  IcTypes, RegDat,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, BtrTable, NexBtrTable;

type
  TApm = class(TForm)
    btAPMDEF: TNexBtrTable;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    oReg: TReg;
    function ReadCount:integer;
    function ReadGrpNum:word;    procedure WriteGrpNum(pValue:word);
    function ReadPmdMark:Str6;    procedure WritePmdMark(pValue:Str6);
    function ReadPmdName:Str30;
  public
    function Eof: boolean;
    function Locate (pGrpNum:word):boolean; overload;
    function Locate (pGrpNum:word;pPmdMark:Str6):boolean; overload;
    function Add (pGrpNum:word;pPmdMark:Str6):boolean;
    procedure Del (pGrpNum:word); overload;
    procedure Del (pGrpNum:word;pPmdMark:Str6); overload;
    procedure IndGrpNum; // Nastavi index na GrpNum
    procedure IndGrpPm;    // nastavi index na GrpNum PmdMark
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
    property DataSet:TNexBtrTable read btAPMDEF;
    property Count:integer read ReadCount;
    property GrpNum:word read ReadGrpNum write WriteGrpNum;
    property PmdMark:Str6 read ReadPmdMark write WritePmdMark;
    property PmdName:Str30 read ReadPmdName;
  end;

implementation

{$R *.dfm}

procedure TApm.FormCreate(Sender: TObject);
begin
  btAPMDEF.Open;
  oReg := TReg.Create;
end;

procedure TApm.FormDestroy(Sender: TObject);
begin
  FreeAndNil (oReg);
  btAPMDEF.Close;
end;

// *************************************** PRIVATE ********************************************

function TApm.ReadCount:integer;
begin
  Result := btAPMDEF.RecordCount;
end;

function TApm.ReadGrpNum:word;
begin
  Result := btAPMDEF.FieldByName('GrpNum').AsInteger;
end;

procedure TApm.WriteGrpNum(pValue:word);
begin
  btAPMDEF.FieldByName('GrpNum').AsInteger := pValue;
end;

function TApm.ReadPmdMark:Str6;
begin
  Result := btAPMDEF.FieldByName('PmdMark').AsString;
end;

procedure TApm.WritePmdMark(pValue:Str6);
begin
  btAPMDEF.FieldByName('PmdMark').AsString := pValue;
end;

function TApm.ReadPmdName:Str30;
begin
  Result := oReg.GetPmdName(PmdMark);
end;

// **************************************** PUBLIC ********************************************

function TApm.Eof: boolean;
begin
  Result := btAPMDEF.Eof;
end;

function TApm.Locate (pGrpNum:word):boolean; // Nastavi databazovy kurzor na zadaneho uzivatela
begin
  IndGrpNum;
  Result := btAPMDEF.FindKey([pGrpNum]);
end;

function TApm.Locate (pGrpNum:word;pPmdMark:Str6):boolean;
begin
  IndGrpPm;
  Result := btAPMDEF.FindKey([pGrpNum,pPmdMark]);
end;

function TApm.Add (pGrpNum:word;pPmdMark:Str6):boolean;
begin
  Result := FALSE;
  SwapIndex;
  If not Locate (pGrpNum,pPmdMark) then begin
    Result := TRUE;
    Insert;
    GrpNum := pGrpNum;
    PmdMark := pPmdMark;
    Post;
  end;
  RestoreIndex;
end;

procedure TApm.Del (pGrpNum:word);
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

procedure TApm.Del (pGrpNum:word;pPmdMark:Str6);
begin
  SwapIndex;
  If Locate (pGrpNum,pPmdMark) then Delete;
  RestoreIndex;
end;

procedure TApm.Prior;
begin
  btAPMDEF.Prior;
end;

procedure TApm.Next;
begin
  btAPMDEF.Next;
end;

procedure TApm.First;
begin
  btAPMDEF.First;
end;

procedure TApm.Last;
begin
  btAPMDEF.Last;
end;

procedure TApm.Insert;
begin
  btAPMDEF.Insert;
end;

procedure TApm.Edit;
begin
  btAPMDEF.Edit;
end;

procedure TApm.Post;
begin
  btAPMDEF.Post;
end;

procedure TApm.Delete;
begin
  btAPMDEF.Delete;
end;

procedure TApm.SwapIndex;
begin
  btAPMDEF.SwapIndex;
end;

procedure TApm.RestoreIndex;
begin
  btAPMDEF.RestoreIndex;
end;

procedure TApm.IndGrpNum; // Nastavi index na GrpNum
begin
  If btAPMDEF.IndexName<>'GrpNum' then btAPMDEF.IndexName := 'GrpNum';
end;

procedure TApm.IndGrpPm;    // nastavi index na GrpNum PmdMark
begin
  If btAPMDEF.IndexName<>'GrPm' then btAPMDEF.IndexName := 'GrPm';
end;

end.
