unit EdiDat;
// =============================================================================
//                      VIRTUÁLNE DÁTA ELEKTRONICKEJ FAKTÚRY
// -----------------------------------------------------------------------------
//
//
// -----------------------------------------------------------------------------
// ************************* POUŽITÉ DATABÁZOVÉ SÚBORY *************************
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ********************* PARAMETRE, KTORÉ POUŽÍVA FUNKCIA **********************
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ********************************* POZNÁMKY **********************************
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ****************************** HISTÓRIA ZMIEN *******************************
// -----------------------------------------------------------------------------
// 21.01[17.08.18] - Nová funkcia (RZ)
// =============================================================================

interface

uses
  IcTools, IcTypes, NexPath, EncodeIni, Forms, ExtCtrls, Classes, SysUtils, Controls;

type
  // ---------------------------------------------------------------------------
  // ********************************* HLAVIÈKA ********************************
  // ---------------------------------------------------------------------------
  TDocRec=record // Údaje hlavièky elektronického dokumentu
    DocVer:byte;
    ExdNum:Str12;
    IseNum:Str12;
    OriIse:Str20;
    OrdNum:Str12;
    SupIno:Str8;
    SupTin:Str10;
    SupVin:Str12;
    SupNam:Str60;
    SupEml:Str30;
    DocTyp:Str1;
    SndDte:TDate;
    ExpDte:TDate;
    DlvDte:TDate;
    DvzNam:Str3;
    DocBva:double;
    ItmQnt:word;
    ItmFld:Str200;
  end;
  TDocDat=class
    constructor Create;
    destructor Destroy; override;
  private
    oDocRec:TDocRec;
    function GetDocVer:byte;     procedure SetDocVer(pValue:byte);
    function GetExdNum:Str12;    procedure SetExdNum(pValue:Str12);
    function GetIseNum:Str12;    procedure SetIseNum(pValue:Str12);
    function GetOriIse:Str20;    procedure SetOriIse(pValue:Str20);
    function GetOrdNum:Str12;    procedure SetOrdNum(pValue:Str12);
    function GetSupIno:Str8;     procedure SetSupIno(pValue:Str8);
    function GetSupTin:Str10;    procedure SetSupTin(pValue:Str10);
    function GetSupVin:Str12;    procedure SetSupVin(pValue:Str12);
    function GetSupNam:Str60;    procedure SetSupNam(pValue:Str60);
    function GetSupEml:Str30;    procedure SetSupEml(pValue:Str30);
    function GetDocTyp:Str1;     procedure SetDocTyp(pValue:Str1);
    function GetSndDte:TDate;    procedure SetSndDte(pValue:TDate);
    function GetExpDte:TDate;    procedure SetExpDte(pValue:TDate);
    function GetDlvDte:TDate;    procedure SetDlvDte(pValue:TDate);
    function GetDvzNam:Str3;     procedure SetDvzNam(pValue:Str3);
    function GetDocBva:double;   procedure SetDocBva(pValue:double);
    function GetItmQnt:word;     procedure SetItmQnt(pValue:word);
    function GetItmFld:Str200;   procedure SetItmFld(pValue:Str200);
  public
    procedure Clear;
  published
    property DocVer:byte read GetDocVer write SetDocVer;
    property ExdNum:Str12 read GetExdNum write SetExdNum;
    property IseNum:Str12 read GetIseNum write SetIseNum;
    property OriIse:Str20 read GetOriIse write SetOriIse;
    property OrdNum:Str12 read GetOrdNum write SetOrdNum;
    property SupIno:Str8 read GetSupIno write SetSupIno;
    property SupTin:Str10 read GetSupTin write SetSupTin;
    property SupVin:Str12 read GetSupVin write SetSupVin;
    property SupNam:Str60 read GetSupNam write SetSupNam;
    property SupEml:Str30 read GetSupEml write SetSupEml;
    property DocTyp:Str1 read GetDocTyp write SetDocTyp;
    property SndDte:TDate read GetSndDte write SetSndDte;
    property ExpDte:TDate read GetExpDte write SetExpDte;
    property DlvDte:TDate read GetDlvDte write SetDlvDte;
    property DvzNam:Str3 read GetDvzNam write SetDvzNam;
    property DocBva:double read GetDocBva write SetDocBva;
    property ItmQnt:word read GetItmQnt write SetItmQnt;
    property ItmFld:Str200 read GetItmFld write SetItmFld;
  end;

  // ---------------------------------------------------------------------------
  // ********************************* POLOŽKY *********************************
  // ---------------------------------------------------------------------------
  PItmRec=^TItmRec;
  TItmRec=record // Údaje položky elektronického dokumentu
    ItmNum:word;
    OrdCod:Str30;
    BarCod:Str15;
    ProNam:Str60;
    MsuNam:Str10;
    VatPrc:byte;
    ProQnt:double;
    CusBpc:double;
    ProBva:double;
    ProWgh:double;
  end;
  TItmDat=class
    constructor Create;
    destructor Destroy; override;
  private
    oItmRec:TItmRec;
    oItmLst:TList;
    oIndex:integer;
    function GetItmNum:word;     procedure SetItmNum(pValue:word);
    function GetOrdCod:Str30;    procedure SetOrdCod(pValue:Str30);
    function GetBarCod:Str15;    procedure SetBarCod(pValue:Str15);
    function GetProNam:Str60;    procedure SetProNam(pValue:Str60);
    function GetMsuNam:Str10;    procedure SetMsuNam(pValue:Str10);
    function GetVatPrc:byte;     procedure SetVatPrc(pValue:byte);
    function GetProQnt:double;   procedure SetProQnt(pValue:double);
    function GetCusBpc:double;   procedure SetCusBpc(pValue:double);
    function GetProBva:double;   procedure SetProBva(pValue:double);
    function GetProWgh:double;   procedure SetProWgh(pValue:double);
  public
    procedure Clear;
    procedure Insert;
    procedure Post;
    procedure First;
    procedure Last;
    procedure Next;
    procedure Prior;
  published
    property ItmNum:word read GetItmNum write SetItmNum;
    property OrdCod:Str30 read GetOrdCod write SetOrdCod;
    property BarCod:Str15 read GetBarCod write SetBarCod;
    property ProNam:Str60 read GetProNam write SetProNam;
    property MsuNam:Str10 read GetMsuNam write SetMsuNam;
    property VatPrc:byte read GetVatPrc write SetVatPrc;
    property ProQnt:double read GetProQnt write SetProQnt;
    property CusBpc:double read GetCusBpc write SetCusBpc;
    property ProBva:double read GetProBva write SetProBva;
    property ProWgh:double read GetProWgh write SetProWgh;
  end;

  // ---------------------------------------------------------------------------
  // ****************************** VÝROBNÉ ÈÍSLA ******************************
  // ---------------------------------------------------------------------------
  PPsnRec=^TPsnRec;
  TPsnRec=record // Údaje priradených výrobných èísiel
    ItmNum:word;
    PseNum:Str30;
  end;
  TPsnDat=class
    constructor Create;
    destructor Destroy; override;
  private
    oPsnRec:TItmRec;
    oPsnLst:TList;
    oIndex:integer;
  public
  published
  end;

  // ---------------------------------------------------------------------------
  // ******************************** DATABÁZA *********************************
  // ---------------------------------------------------------------------------
  TEdiDat=class
  private
    constructor Create;
    destructor Destroy; override;
  public
    ovDOCDAT:TDocDat;
    ovITMDAT:TItmDat;
    ovPSNDAT:TPsnDat;
  end;

implementation

// -----------------------------------------------------------------------------
// ********************************* DATABÁZA **********************************
// -----------------------------------------------------------------------------

constructor TEdiDat.Create;
begin
  ovDOCDAT:=TDocDat.Create;
  ovITMDAT:=TItmDat.Create;
  ovPSNDAT:=TPsnDat.Create;
end;

destructor TEdiDat.Destroy;
begin
  FreeAndNil(ovDOCDAT);
  FreeAndNil(ovITMDAT);
  FreeAndNil(ovPSNDAT);
end;

// -----------------------------------------------------------------------------
// ********************************** HLAVIÈKA *********************************
// -----------------------------------------------------------------------------

constructor TDocDat.Create;
begin
  Clear;
end;

destructor TDocDat.Destroy;
begin
end;

// ******************************** PRIVATE ************************************

function TDocDat.GetDocVer:byte;
begin
  Result:=oDocRec.DocVer;
end;

function TDocDat.GetSupIno:Str8;
begin
  Result:=oDocRec.SupIno;
end;

function TDocDat.GetSupTin:Str10;
begin
  Result:=oDocRec.SupTin;
end;

function TDocDat.GetSupVin:Str12;
begin
  Result:=oDocRec.SupVin;
end;

function TDocDat.GetSupNam:Str60;
begin
  Result:=oDocRec.SupNam;
end;

function TDocDat.GetSupEml:Str30;
begin
  Result:=oDocRec.SupEml;
end;

function TDocDat.GetDocTyp:Str1;
begin
  Result:=oDocRec.DocTyp;
end;

function TDocDat.GetExdNum:Str12;
begin
  Result:=oDocRec.ExdNum;
end;

function TDocDat.GetIseNum:Str12;
begin
  Result:=oDocRec.IseNum;
end;

function TDocDat.GetOriIse:Str20;
begin
  Result:=oDocRec.OriIse;
end;

function TDocDat.GetOrdNum:Str12;
begin
  Result:=oDocRec.OrdNum;
end;

function TDocDat.GetSndDte:TDate;
begin
  Result:=oDocRec.SndDte;
end;

function TDocDat.GetExpDte:TDate;
begin
  Result:=oDocRec.ExpDte;
end;

function TDocDat.GetDlvDte:TDate;
begin
  Result:=oDocRec.DlvDte;
end;

function TDocDat.GetDvzNam:Str3;
begin
  Result:=oDocRec.DvzNam;
end;

function TDocDat.GetDocBva:double;
begin
  Result:=oDocRec.DocBva;
end;

function TDocDat.GetItmQnt:word;
begin
  Result:=oDocRec.ItmQnt;
end;

function TDocDat.GetItmFld:Str200;
begin
  Result:=oDocRec.ItmFld;
end;

procedure TDocDat.SetDocVer(pValue:byte);
begin
  oDocRec.DocVer:=pValue;
end;

procedure TDocDat.SetSupIno(pValue:Str8);
begin
  oDocRec.SupIno:=pValue;
end;

procedure TDocDat.SetSupTin(pValue:Str10);
begin
  oDocRec.SupTin:=pValue;
end;

procedure TDocDat.SetSupVin(pValue:Str12);
begin
  oDocRec.SupVin:=pValue;
end;

procedure TDocDat.SetSupNam(pValue:Str60);
begin
  oDocRec.SupNam:=pValue;
end;

procedure TDocDat.SetSupEml(pValue:Str30);
begin
  oDocRec.SupEml:=pValue;
end;

procedure TDocDat.SetDocTyp(pValue:Str1);
begin
  oDocRec.DocTyp:=pValue;
end;

procedure TDocDat.SetExdNum(pValue:Str12);
begin
  oDocRec.ExdNum:=pValue;
end;

procedure TDocDat.SetIseNum(pValue:Str12);
begin
  oDocRec.IseNum:=pValue;
end;

procedure TDocDat.SetOriIse(pValue:Str20);
begin
  oDocRec.OriIse:=pValue;
end;

procedure TDocDat.SetOrdNum(pValue:Str12);
begin
  oDocRec.OrdNum:=pValue;
end;

procedure TDocDat.SetSndDte(pValue:TDate);
begin
  oDocRec.SndDte:=pValue;
end;

procedure TDocDat.SetExpDte(pValue:TDate);
begin
  oDocRec.ExpDte:=pValue;
end;

procedure TDocDat.SetDlvDte(pValue:TDate);
begin
  oDocRec.DlvDte:=pValue;
end;

procedure TDocDat.SetDvzNam(pValue:Str3);
begin
  oDocRec.DvzNam:=pValue;
end;

procedure TDocDat.SetDocBva(pValue:double);
begin
  oDocRec.DocBva:=pValue;
end;

procedure TDocDat.SetItmQnt(pValue:word);
begin
  oDocRec.ItmQnt:=pValue;
end;

procedure TDocDat.SetItmFld(pValue:Str200);
begin
  oDocRec.ItmFld:=pValue;
end;

// ********************************* PUBLIC ************************************

procedure TDocDat.Clear;
begin
  FillChar(oDocRec,SizeOf(TDocRec),#0);
end;

// -----------------------------------------------------------------------------
// ********************************** POLOŽKY **********************************
// -----------------------------------------------------------------------------

constructor TItmDat.Create;
begin
  Clear;
  oItmLst:=TList.Create;  oItmLst.Clear;
end;

destructor TItmDat.Destroy;
begin
  FreeAndNil(oItmLst);
end;


// ******************************** PRIVATE ************************************

function TItmDat.GetItmNum:word;
begin
  Result:=oItmRec.ItmNum;
end;

function TItmDat.GetOrdCod:Str30;
begin
  Result:=oItmRec.OrdCod;
end;

function TItmDat.GetBarCod:Str15;
begin
  Result:=oItmRec.BarCod;
end;

function TItmDat.GetProNam:Str60;
begin
  Result:=oItmRec.ProNam;
end;

function TItmDat.GetMsuNam:Str10;
begin
  Result:=oItmRec.MsuNam;
end;

function TItmDat.GetVatPrc:byte;
begin
  Result:=oItmRec.VatPrc;
end;

function TItmDat.GetProQnt:double;
begin
  Result:=oItmRec.ProQnt;
end;

function TItmDat.GetCusBpc:double;
begin
  Result:=oItmRec.CusBpc;
end;

function TItmDat.GetProBva:double;
begin
  Result:=oItmRec.ProBva;
end;

function TItmDat.GetProWgh:double;
begin
  Result:=oItmRec.ProWgh;
end;

procedure TItmDat.SetItmNum(pValue:word);
begin
  oItmRec.ItmNum:=pValue;
end;

procedure TItmDat.SetOrdCod(pValue:Str30);
begin
  oItmRec.OrdCod:=pValue;
end;

procedure TItmDat.SetBarCod(pValue:Str15);
begin
  oItmRec.BarCod:=pValue;
end;

procedure TItmDat.SetProNam(pValue:Str60);
begin
  oItmRec.ProNam:=pValue;
end;

procedure TItmDat.SetMsuNam(pValue:Str10);
begin
  oItmRec.MsuNam:=pValue;
end;

procedure TItmDat.SetVatPrc(pValue:byte);
begin
  oItmRec.VatPrc:=pValue;
end;

procedure TItmDat.SetProQnt(pValue:double);
begin
  oItmRec.ProQnt:=pValue;
end;

procedure TItmDat.SetCusBpc(pValue:double);
begin
  oItmRec.CusBpc:=pValue;
end;

procedure TItmDat.SetProBva(pValue:double);
begin
  oItmRec.ProBva:=pValue;
end;

procedure TItmDat.SetProWgh(pValue:double);
begin
  oItmRec.ProWgh:=pValue;
end;

// ******************************** PUBLIC *************************************

procedure TItmDat.Clear;
begin
  FillChar(oItmRec,SizeOf(TItmRec),#0);
end;

procedure TItmDat.Insert;
begin
end;

procedure TItmDat.Post;
begin
end;

procedure TItmDat.First;
begin
  oIndex:=0;
end;

procedure TItmDat.Last;
begin
end;

procedure TItmDat.Next;
begin
end;

procedure TItmDat.Prior;
begin
end;

// -----------------------------------------------------------------------------
// ******************************* VÝROBNÉ ÈÍSLA *******************************
// -----------------------------------------------------------------------------

constructor TPsnDat.Create;
begin
  oPsnLst:=TList.Create;  oPsnLst.Clear;
end;

destructor TPsnDat.Destroy;
begin
  FreeAndNil(oPsnLst);
end;

end.
