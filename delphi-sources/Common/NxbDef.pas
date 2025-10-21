unit NxbDef;

interface

uses
  IcTypes, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, BtrTable, NexBtrTable, DBTables, NexPxTable;

type
  TNxb = class(TForm)
    btNXBDEF: TNexBtrTable;
    ptNXBDEF: TNexPxTable;
    btMCBLST: TNexBtrTable;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    procedure LoadBooks(pPmdMark:Str3;pTable:TNexBtrTable); // Nacita knihy do centralnej databaze

    function ReadCount:integer;
    function ReadPmdMark:Str6;      procedure WritePmdMark(pValue:Str6);
    function ReadBookNum:Str5;      procedure WriteBookNum(pValue:Str5);
    function ReadBookName:Str30;    procedure WriteBookName(pValue:Str30);
  public
    function Eof: boolean;
    function Locate (pPmdMark:Str6):boolean; overload;
    function Locate (pPmdMark:Str6;pBookNum:Str5):boolean; overload;
    function GetBookName (pPmdMark:Str6;pBookNum:Str5):Str30;
    procedure DataToTemp;
    procedure BtrToPx (pPmdMark:Str6);
    procedure IndPmdMark; // Nastavi index na PmdMark
    procedure IndPmBn;    // nastavi index na PmdMark,BookNum
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
    property DataSet:TNexBtrTable read btNXBDEF;
    property TempSet:TNexPxTable read ptNXBDEF write ptNXBDEF;
    property Count:integer read ReadCount;
    property PmdMark:Str6 read ReadPmdMark write WritePmdMark;
    property BookNum:Str5 read ReadBookNum write WriteBookNum;
    property BookName:Str30 read ReadBookName write WriteBookName;
  end;

implementation

{$R *.dfm}

procedure TNxb.FormCreate(Sender: TObject);
begin
  btNXBDEF.Open;
  If btNXBDEF.RecordCount=0 then begin
    LoadBooks('MCB',btMCBLST);
  end;
end;

procedure TNxb.FormDestroy(Sender: TObject);
begin
  If ptNXBDEF.Active then ptNXBDEF.Close;
  btNXBDEF.Close;
end;

// *************************************** PRIVATE ********************************************

procedure TNxb.LoadBooks(pPmdMark:Str3;pTable:TNexBtrTable); // Nacita knihy do centralnej databaze
begin
  pTable.Open;
  If pTable.RecordCount>0 then begin
    pTable.First;
    Repeat
      btNXBDEF.Insert;
      btNXBDEF.FieldByName('PmdMark').AsString := pPmdMark;
      btNXBDEF.FieldByName('BookNum').AsString := pTable.FieldByName('BookNum').AsString;
      btNXBDEF.FieldByName('BookName').AsString := pTable.FieldByName('BookName').AsString;
      btNXBDEF.Post;
      Application.ProcessMessages;
      pTable.Next;
    until pTable.Eof;
  end;
  pTable.Close;
end;

function TNxb.ReadCount:integer;
begin
  Result := btNXBDEF.RecordCount;
end;

function TNxb.ReadPmdMark:Str6;
begin
  Result := btNXBDEF.FieldByName('PmdMark').AsString;
end;

procedure TNxb.WritePmdMark(pValue:Str6);
begin
  btNXBDEF.FieldByName('PmdMark').AsString := pValue;
end;

function TNxb.ReadBookNum:Str5;
begin
  Result := btNXBDEF.FieldByName('BookNum').AsString;
end;

procedure TNxb.WriteBookNum(pValue:Str5);
begin
  btNXBDEF.FieldByName('BookNum').AsString := pValue;
end;

function TNxb.ReadBookName:Str30;
begin
  Result := btNXBDEF.FieldByName('BookName').AsString;
end;

procedure TNxb.WriteBookName(pValue:Str30);
begin
  btNXBDEF.FieldByName('BookName').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TNxb.Eof: boolean;
begin
  Result := btNXBDEF.Eof;
end;

function TNxb.Locate (pPmdMark:Str6):boolean;
begin
  IndPmdMark;
  Result := btNXBDEF.FindKey([pPmdMark]);
end;

function TNxb.Locate (pPmdMark:Str6;pBookNum:Str5):boolean;
begin
  IndPmBn;
  Result := btNXBDEF.FindKey([pPmdMark,pBookNum]);
end;

function TNxb.GetBookName (pPmdMark:Str6;pBookNum:Str5):Str30;
begin
  Result := '';
  If Locate (pPmdMark,pBookNum) then Result := BookName;
end;

procedure TNxb.DataToTemp;
begin
  ptNXBDEF.Insert;
  Btr_To_Px (btNXBDEF,ptNXBDEF);
  ptNXBDEF.Post;
end;

procedure TNxb.BtrToPx (pPmdMark:Str6);
begin
  If Locate (pPmdMark) then begin
    Repeat
      DataToTemp;
      Application.ProcessMessages;
      Next;
    until Eof or (PmdMark<>pPmdMark);
  end;
end;

procedure TNxb.Prior;
begin
  btNXBDEF.Prior;
end;

procedure TNxb.Next;
begin
  btNXBDEF.Next;
end;

procedure TNxb.First;
begin
  btNXBDEF.First;
end;

procedure TNxb.Last;
begin
  btNXBDEF.Last;
end;

procedure TNxb.Insert;
begin
  btNXBDEF.Insert;
end;

procedure TNxb.Edit;
begin
  btNXBDEF.Edit;
end;

procedure TNxb.Post;
begin
  btNXBDEF.Post;
end;

procedure TNxb.Delete;
begin
  btNXBDEF.Delete;
end;

procedure TNxb.SwapIndex;
begin
  btNXBDEF.SwapIndex;
end;

procedure TNxb.RestoreIndex;
begin
  btNXBDEF.RestoreIndex;
end;

procedure TNxb.IndPmdMark; // Nastavi index na PmdMark
begin
  If btNXBDEF.IndexName<>'PmdMark' then btNXBDEF.IndexName := 'PmdMark';
end;

procedure TNxb.IndPmBn;    // nastavi index na PmdMark,BookNum
begin
  If btNXBDEF.IndexName<>'PmBn' then btNXBDEF.IndexName := 'PmBn';
end;


end.
