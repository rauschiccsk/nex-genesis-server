unit CwdHand;
// ***************************************************************************
//           Objekt na pracu s dokladmi kontroly vahoveho preaja
// ***************************************************************************

interface

uses
  IcTypes, IcConv, IcValue, IcTools, IcVariab,
  NexSys, NexText, NexGlob, // CwiHand,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, BtrTable, NexBtrTable, DBTables, NexPxTable;

type
  TCwd = class(TForm)
    btCWH: TNexBtrTable;
    btCWBLST: TNexBtrTable;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    function GetBookNum:Str5; // Cislo otvorenej knihy
    function GetBookName:Str30; // Nazov otvorenej knihy
    function GetBookCount:word; // Pocet knih
  public
    function Locate (pDocDate:TDateTime):boolean; // Nastavi kurzor na zadanu polozku a nacita udaje do bufferu
    function Count:longint; // Pocet poloziek dokladu
    function Open (pBookNum:Str5):boolean; // Otvori zadanu knihu dokladov a poloziek
    procedure OpenLastBook; // Otvori knihu, ktora bola naposledy otvorena
    procedure SaveLastBook; // Ulozi cislo naposledy pouzitej knihy
    procedure Delete; // Vymaze zadany polozku spolu so suvstaznymi udajmi
  published
    property BookNum:Str5 read GetBookNum;
    property BookName:Str30 read GetBookName;
    property BookCount:word read GetBookCount;
  end;

var gCwd:TCwd;
  
implementation

{$R *.dfm}

procedure TCwd.FormCreate(Sender: TObject);
begin
  btCWBLST.Open;
end;

procedure TCwd.FormDestroy(Sender: TObject);
begin
  btCWBLST.Close;
  If btCWH.Active then btCWH.Close;
end;

// *************************** PRIVATE METHODS *******************************

// *************************** PUBLIC METHODS *******************************

function TCwd.Locate (pDocDate:TDateTime):boolean; // Nastavi kurzor na zadanu polozku a nacita udaje do bufferu
begin
  btCWH.SwapIndex;
  btCWH.IndexName := 'DocDate';
  Result := btCWH.FindKey([pDocDate]);
  btCWH.RestoreIndex;
end;

function TCwd.Count;
begin
  Result := btCWH.RecordCount;
end;

function TCwd.Open (pBookNum:Str5):boolean; // Otvori zadanu knihu dokladov a poloziek
begin
  Result := btCWBLST.FindKey([pBookNum]);
  If Result then begin
    btCWH.Open (pBookNum);

  end;
end;

procedure TCwd.OpenLastBook; // Otvori knihu, ktora bola naposledy otvorena
begin
  Open (GetLastBook('CWB',BookNum));
end;

procedure TCwd.SaveLastBook; // Ulozi cislo naposledy pouzitej knihy
begin
  NexSys.SaveLastBook ('CWB',BookNum);
end;

procedure TCwd.Delete; // Vymaze zadany polozku spolu so suvstaznymi udajmi
begin
end;

function TCwd.GetBookNum:Str5; // Cislo knihy na zaklade zadaneho cisladokladu
begin
  Result := btCWH.BookNum;
end;

function TCwd.GetBookName:Str30; // Nazov otvorenej knihy
begin
  Result := btCWBLST.FieldByName('BookName').AsString;
end;

function TCwd.GetBookCount:word; // Pocet knih
begin
  Result := btCWBLST.RecordCount;
end;

end.
