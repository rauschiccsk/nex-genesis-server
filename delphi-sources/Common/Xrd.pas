unit Xrd;
{$F+}

// *****************************************************************************
//                                  XLS Výkazy
// *****************************************************************************

interface

uses
  IcTypes, IcConst, IcConv, IcTools, IcVariab, DocHand,
  NexGlob, NexPath, NexIni, NexMsg, NexError,
  Rep, Key, Afc,
  hSYSTEM, hXRDLST, hXRCLST, hXRCDEF, hXRGLST, hXRGDEF, tXRGCLC,
  ComCtrls, SysUtils, Classes, Forms;

type
  TXrd=class(TComponent)
    constructor Create(AOwner:TComponent);
    destructor Destroy;override;
    private
      oFrmName:Str15;
    public
      ohXRDLST:TXrdlstHnd;
      ohXRCDEF:TXrcdefHnd;
      ohXRGDEF:TXrgdefHnd;
      ohXRCLST:TXrclstHnd;
      ohXRGLST:TXrglstHnd;
      otXRGCLC:TXrgclcTmp;
      procedure Open; // prepocita hlavicku zadaneho dokladu
      procedure NewDoc(pYear:Str2;pSerNum:word;pDocDat:TDateTime); // Vygeneruje novu hlavicku dokladu
      procedure ClcDoc(pDocNum:Str12); // prepocita hlavicku zadaneho dokladu
      procedure ResDel; // Zru39 systemom rezervovany doklad
    published
  end;

implementation

constructor TXrd.Create(AOwner: TComponent);
begin
  oFrmName:=AOwner.Name;
  ohXRCDEF:=TXrcdefHnd.Create;
  ohXRGDEF:=TXrgdefHnd.Create;
  ohXRDLST:=TXrdlstHnd.Create;
  ohXRCLST:=TXrclstHnd.Create;
  ohXRGLST:=TXrglstHnd.Create;
  otXRGCLC:=TXrgclcTmp.Create;
end;

destructor TXrd.Destroy;
begin
  FreeAndNil(otXRGCLC);
  FreeAndNil(ohXRGLST);
  FreeAndNil(ohXRCLST);
  FreeAndNil(ohXRDLST);
  FreeAndNil(ohXRGDEF);
  FreeAndNil(ohXRCDEF);
end;

// ********************************* PRIVATE ***********************************

// ********************************** PUBLIC ***********************************

procedure TXrd.Open;
begin
  ohXRDLST.Open;
  ohXRCLST.Open;
  ohXRGLST.Open;
end;

procedure TXrd.ResDel;
begin
  If ohXRDLST.DstLck=9 then ohXRDLST.Delete;
end;

procedure TXrd.NewDoc(pYear:Str2;pSerNum:word;pDocDat:TDateTime); // Vygeneruje novu hlavicku dokladu
var mSerNum:word;  mDocNum:Str12;  mDocDat:TDateTime;
begin
  If pYear='' then pYear:=gvSys.ActYear2;
  mSerNum:=pSerNum;
  mDocDat:=pDocDat;
  If mSerNum=0 then mSerNum:=ohXRDLST.NextSerNum(pYear); // Ak nie je zadane poradove cislo OD vygenerujeme nasledujuce
  If mDocDat=0 then mDocDat:=Date; // Ak nie je zadany datum nastavime aktualny den
  mDocNum:=ohXRDLST.GenDocNum(pYear,mSerNum);
  If not ohXRDLST.LocateDocNum(mDocNum) then begin // Ak neexistuje vyvorime hlacicku dokladu OD
    ohXRDLST.Insert;
    ohXRDLST.Year:=pYear;
    ohXRDLST.SerNum:=mSerNum;
    ohXRDLST.DocNum:=mDocNum;
    ohXRDLST.DocDat:=mDocDat;
    ohXRDLST.DstLck:=9;
    ohXRDLST.Post;
  end;
end;

procedure TXrd.ClcDoc(pDocNum:Str12); 
begin
end;

end.


