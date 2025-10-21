unit CwcHand;
// ***************************************************************************
//           Objekt na pracu s polozkami dokladu kontroly vahoveho preaja,
//             ktore pochadzaju z elektronickych registracnych pokladnic
// ***************************************************************************
// ***************************************************************************

interface

uses
  IcTypes, IcConv, IcValue, IcTools, IcVariab, DocHand, StkHand,
  NexSys, NexText, NexIni, NexGlob, StkGlob, StcHand, BtrHand,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, BtrTable, NexBtrTable, DBTables, NexPxTable;

type
  TCwcRec = record
    DocDate:DateType; // Datum kontrolneho dokladu
    GsCode:longint;   // Tovarove cislo (PLU)
    MgCode:longint;   // Cislo tovarovej skupiny
    GsName:Str30;     // Nazov tovaru
    BarCode:Str15;    // Prvotnø identifikaÀnø k¡d tovaru
    GsQnt:double;     // Hmotnost predaneho tovaru
    BValue:double;    // Hodnota predaného tovaru v PC s DPH
    CasNum:byte;      // Cislo vahy
    BlkNum:longint;   // Poradove cislo etikety
    SaTime:Str8;      // Cas nacitania etikety do PC
  end;

  TCwc = class(TForm)
    btCWC: TNexBtrTable;
    ptCWC: TNexPxTable;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    oItem:TCwcRec;
    function GetBookNum:Str5; // Cislo knihy na zaklade zadaneho cisladokladu
    procedure ReadItem;  // Nacita zaznam do oItm udaje aktualnej polozky dokladu z prechodnej tabulky PX
    procedure WriteItem;  // Nacita zaznam do oItm udaje aktualnej polozky dokladu z prechodnej tabulky PX
  public
    function Bof:boolean; // Koniec poloziek dokladu
    function Eof:boolean; // Koniec poloziek dokladu
    function Locate (pItmNum:longint):boolean; // Nastavi kurzor na zadanu polozku a nacita udaje do bufferu
    function Count:longint; // Pocet poloziek dokladu
    function NewItm:longint; // Poradove cislo novej nasledujucej polozky
    procedure Clear; // Vymze buffer zaznamu polozky dokladu
    procedure Insert; // Prida novu polozku
    procedure Edit;   // Upravuje existujucu polozku
    procedure Post;   // Ulozi udaje polozky do docasneho suboru
    procedure Prior;  // Predchadzaj[ca polozka dokladu
    procedure Next;   // Nasledujuca polozka dokladu
    procedure Delete; // Vymaze zadany polozku spolu so suvstaznymi udajmi

    procedure LoadFrBtr(pDocNum:Str12); // Nacita polozku aktualneho dokladu do docasnej databaze
    procedure AddToBtr; // Ulozi obsah docasneho suboru do BTR
  published
    property DocDate:TDateTime read oItem.DocDate write oItem.DocDate;
    property GsCode:longint read oItem.GsCode write oItem.GsCode;
    property MgCode:longint read oItem.MgCode write oItem.MgCode;
    property GsName:Str30 read oItem.GsName write oItem.GsName;
    property BarCode:Str15 read oItem.BarCode write oItem.BarCode;
    property GsQnt:double read oItem.GsQnt write oItem.GsQnt;
    property BValue:double read oItem.BValue write oItem.BValue;
    property CasNum:longint read oItem.CasNum write oItem.CasNum;
    property BlkNum:longint read oItem.BlkNum write oItem.BlkNum;
    property SaTime:Str8 read oItem.SaTime write oItem.SaTime;
  end;

implementation

{$R *.dfm}

procedure TCwc.FormCreate(Sender: TObject);
begin
  btCWC := nil;
end;

procedure TCwc.FormDestroy(Sender: TObject);
begin
  If ptCWC.Active then ptCWC.Close;
  If btCWI.Active then btCWI.Close;
end;

// *************************** PRIVATE METHODS *******************************

// *************************** PUBLIC METHODS *******************************

function TCwc.Bof:boolean; // Koniec poloziek dokladu
begin
  Result := ptCWC.Bof;
end;

function TCwc.Eof:boolean; // Koniec poloziek dokladu
begin
  Result := ptCWC.Eof;
end;

function TCwc.Locate (pItmNum:longint):boolean; // Nastavi kurzor na zadanu polozku a nacita udaje do bufferu
begin
  ptCWC.SwapIndex;
  ptCWC.IndexName := '';
  Result := ptCWC.FindKey([DocNum,pItmNum]);
  ReadItem;
  ptCWC.RestoreIndex;
end;

function TCwc.Count;
begin
  Result := ptCWC.RecordCount;
end;

function TCwc.NewItm:longint; // Poradove cislo novej nasledujucej polozky
begin
  Clear;
  ptCWC.SwapIndex;
  ptCWC.IndexName := '';
  ptCWC.Last;
  Result := ptCWC.FieldByName('ItmNum').AsInteger+1;
  ptCWC.RestoreIndex;
  oItem.ItmNum := Result;
end;

procedure TCwc.Clear;
begin
  FillChar (oItem,SizeOf(TOmiRec),#0);
end;

procedure TCwc.Insert; // Prida novu polozku
begin
  ptCWC.Insert;
end;

procedure TCwc.Edit;   // Upravuje existujucu polozku
begin
  ptCWC.Edit;
end;

procedure TCwc.Post;   // Ulozi udaje polozky do docasneho suboru
begin
  ptCWC.Post;
end;

procedure TCwc.Prior;  // Predchadzaj[ca polozka dokladu
begin
  ptCWC.Prior;
  ReadItem;
end;

procedure TCwc.Next;   // Nasledujuca polozka dokladu
begin
  ptCWC.Next;
  ReadItem;
end;

procedure TCwc.LoadFrBtr(pDocNum:Str12); // nacita polozku aktualneho dokladu do docasnej databaze
begin
  oDocNum := pDocNum;
  try
    If ptCWC.Active then ptCWC.Close;
    ptCWC.Open;
    If not btOMI.Active then btOMI.Open (BookNum);
    btOMI.SwapStatus;
    btOMI.IndexName := 'DocNum';
    oDocCVal := 0;   oDocEVal := 0;
    If btOMI.FindKey ([oDocNum]) then begin
      Repeat
        Insert;
        BTR_To_PX (btOMI,ptCWC);
        Post;
        ReadItem;  // Nacita zaznam do oItm udaje aktualnej polozky dokladu z prechodnej tabulky PX
        btOMI.Next;
      until (btOMI.Eof) or (btOMI.FieldByName('DocNum').AsString<>oDocNum);
    end;
  finally
    btOMI.RestoreStatus;
  end;
end;

procedure TCwc.AddToBtr; // Ulozi obsah docasneho suboru do BTR
begin
  If not btOMI.Active then btOMI.Open (BookNum);
  btOMI.Insert;
  PX_To_BTR (ptCWC,btOMI);
  btOMI.Post;
end;

procedure TCwc.Delete; // Vymaze zadany polozku spolu so suvstaznymi udajmi
begin
end;

function TCwc.GetBookNum:Str5; // Cislo knihy na zaklade zadaneho cisladokladu
begin
  Result := BookNumFromDocNum(oDocNum);
end;

procedure TCwc.ReadItem;  // Nacita zaznam do oItm udaje aktualnej polozky dokladu z prechodnej tabulky PX
begin
  oItem.DocDate := ptCWC.FieldByName ('DocDate').AsDateTime;
  oItem.GsCode := ptCWC.FieldByName ('GsCode').AsInteger;
  oItem.MgCode := ptCWC.FieldByName ('MgCode').AsInteger;
  oItem.GsName := ptCWC.FieldByName ('GsName').AsString;
  oItem.BarCode := ptCWC.FieldByName ('BarCode').AsString;
  oItem.GsQnt := ptCWC.FieldByName ('GsQnt').AsFloat;
  oItem.AcBValue := ptCWC.FieldByName ('BValue').AsFloat;
  oItem.CasNum := ptCWC.FieldByName ('CasNum').AsInteger;
  oItem.BlkNum := ptCWC.FieldByName ('BlkNum').AsInteger;
  oItem.SaTime := ptCWC.FieldByName ('SaTime').AsString;
end;

procedure TCwc.WriteItem; // Zapise zaznam z oItm do prechodnej tabulky (PX) poloziek dokladu
begin
  ptCWC.FieldByName ('DocDate').AsDateTime := oItem.DocDate;
  ptCWC.FieldByName ('GsCode').AsInteger := oItem.GsCode;
  ptCWC.FieldByName ('MgCode').AsInteger := oItem.MgCode;
  ptCWC.FieldByName ('GsName').AsString := oItem.GsName;
  ptCWC.FieldByName ('BarCode').AsString := oItem.BarCode;
  ptCWC.FieldByName ('GsQnt').AsFloat := oItem.GsQnt;
  ptCWC.FieldByName ('BValue').AsFloat := oItem.AcBValue;
  ptCWC.FieldByName ('CasNum').AsInteger := oItem.CasNum;
  ptCWC.FieldByName ('BlkNum').AsInteger := oItem.BlkNum;
  ptCWC.FieldByName ('SaTime').AsString := oItem.SaTime;
end;

end.
