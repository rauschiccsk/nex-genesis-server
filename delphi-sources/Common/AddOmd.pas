unit AddOmd;

interface

uses
  IcVariab, IcTypes, IcConv, IcDate, IcTools, NexPath, NexIni, DocHand, NexGlob,
  LangForm, NexMsg, NexMsgs, IcStand, IcButtons, IcEditors, CmpTools,
  Controls, ExtCtrls, Classes, StdCtrls, Buttons, Windows, Messages,
  SysUtils, Graphics, Forms, Dialogs, ComCtrls, IcLabels, IcInfoFields,
  AdvGrid, SrchGrid, TableView, IcProgressBar, ActnList, NexEditors,
  NwEditors, NwInfoFields, DB, BtrTable, NexBtrTable;

type
  TAddOmdF = class(TLangForm)
    btGSCAT: TNexBtrTable;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
      // Hlavicka skladovej vydajky
      oSerNum:word;
      oDocNum:Str12;
      oStkNum:word;
      oPlsNum:word;
      oSmCode:word;
      oDocDate:TDateTime;
      oDescribe:Str30;
      // Polozky skladovej vydajky
      oItmNum:word;
      oMgCode:word;
      oGsCode:longint;
      oGsName:Str30;
      oBarCode:Str15;
      oStkCode:Str15;
      oMsName:Str10;
      oGsQnt:double;
      oVatPrc:word;
      oCPrice:double;
      oBPrice:double;
      oNotice:Str30;
      oStkStat:Str1;
      oOcdNum:Str12;
      oOcdItm:word;
      oSrcDoc:Str12;
      oSrcItm:word;
  public
      procedure ClearHead; // Vynuluje udaje hlavicky
      procedure ClearItem;   // Vynuluje udaje polozky
      procedure LoadGscData; // Nacita zadane PLU z evidencii tovaru
      procedure AddDocToOmh; // Prida novu skladovu vydajku
      procedure AddItmToOmi; // Prida nove polozky do dodacieho listu
      procedure OutputOmItm; // Vydaj aktualnej polozky zo skladu
    published
      // Hlavicka skladovej vydajky
      property DocNum:Str12 read oDocNum write oDocNum;
      property SerNum:word write oSerNum;
      property StkNum:word write oStkNum;
      property PlsNum:word write oPlsNum;
      property SmCode:word write oSmCode;
      property DocDate:TDateTime write oDocDate;
      property Describe:Str30 write oDescribe;
      // Polozky skladovej vydajky
      property ItmNum:word read oItmNum write oItmNum;
      property MgCode:word write oMgCode;
      property GsCode:longint write oGsCode;
      property GsName:Str30 write oGsName;
      property BarCode:Str15 write oBarCode;
      property StkCode:Str15 write oStkCode;
      property MsName:Str10 write oMsName;
      property GsQnt:double write oGsQnt;
      property VatPrc:word write oVatPrc;
      property CPrice:double read oCPrice write oCPrice;
      property BPrice:double write oBPrice;
      property Notice:Str30 write oNotice;
      property StkStat:Str1 write oStkStat;
      property OcdNum:Str12 write oOcdNum;
      property OcdItm:word write oOcdItm;
      property SrcDoc:Str12 write oSrcDoc;
      property SrcItm:word write oSrcItm;
  end;

var
  AddOmdF: TAddOmdF;

implementation

uses
  DM_DLSDAT, DM_STKDAT;

{$R *.DFM}

procedure TAddOmdF.FormCreate(Sender: TObject);
begin
  F_DocHand := TF_DocHand.Create(nil);
  btGSCAT.Open;
end;

procedure TAddOmdF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil (F_DocHand);
end;

procedure TAddOmdF.ClearHead; // Vynuluje udaje hlavicky
begin
  oSerNum := 0;
  oDocNum := '';
  oStkNum := 0;
  oPlsNum := 0;
  oSmCode := 0;
  oDocDate := Date;
  oDescribe := '';
end;

procedure TAddOmdF.ClearItem; // Vynuluje udaje polozky
begin
  oItmNum := 0;   oMgCode := 0;
  oGsCode := 0;   oGsName := '';
  oBarCode := ''; oStkCode := '';
  oGsQnt := 0;    oMsName := '';
  oVatPrc := 0;   oBPrice := 0;     oCPrice := 0;
  oNotice := '';  oStkStat := '';
  oOcdNum := '';  oOcdItm := 0;
  oSrcDoc := '';  oSrcItm := 0;
end;

procedure TAddOmdF.LoadGscData; // Nacita zadane PLU z evidencii tovaru
begin
  btGSCAT.IndexName := 'GsCode';
  If btGSCAT.FindKey ([oGsCode]) then begin
    oMgCode := btGSCAT.FieldByName ('MgCode').AsInteger;
    oGsName := btGSCAT.FieldByName ('GsName').AsString;
    oBarCode := btGSCAT.FieldByName ('BarCode').AsString;
    oStkCode := btGSCAT.FieldByName ('StkCode').AsString;
    oMsName := btGSCAT.FieldByName ('MsName').AsString;
    oVatPrc := btGSCAT.FieldByName ('VatPrc').AsInteger;
  end;
end;

procedure TAddOmdF.AddDocToOmh; // Prida novu skladovu vydajku
begin
  If dmSTK.btOMH.IndexName<>'DocNum' then dmSTK.btOMH.IndexName:='DocNum';
  If oSerNum=0 then begin // Vygenerujeme nove cislo dokladu
    oSerNum := GetDocNextYearSerNum(dmSTK.btOMH,'');
    oDocNum := GenOmDocNum ('',dmSTK.btOMH.BookNum,oSerNum);
  end;
  If dmSTK.btOMH.FindKey ([oDocNum])
    then dmSTK.btOMH.Edit     // Uprava hlavicky dokladu
    else dmSTK.btOMH.Insert;  // Novy doklad
  dmSTK.btOMH.FieldByName('SerNum').AsInteger := oSerNum;
  dmSTK.btOMH.FieldByName('DocNum').AsString := oDocNum;
  dmSTK.btOMH.FieldByName('StkNum').AsInteger := oStkNum;
  dmSTK.btOMH.FieldByName('DocDate').AsDateTime := oDocDate;
  dmSTK.btOMH.FieldByName('Describe').AsString := oDescribe;
  dmSTK.btOMH.FieldByName('PlsNum').AsInteger := oPlsNum;
  dmSTK.btOMH.FieldByName('SmCode').AsInteger := oSmCode;
  dmSTK.btOMH.FieldByName('VatPrc1').AsFloat := gIni.GetVatPrc(1);
  dmSTK.btOMH.FieldByName('VatPrc2').AsFloat := gIni.GetVatPrc(2);
  dmSTK.btOMH.FieldByName('VatPrc3').AsFloat := gIni.GetVatPrc(3);
  dmSTK.btOMH.FieldByName('VatPrc4').AsFloat := gIni.GetVatPrc(4);
  dmSTK.btOMH.FieldByName('VatPrc5').AsFloat := gIni.GetVatPrc(5);
  dmSTK.btOMH.Post;
end;

procedure TAddOmdF.AddItmToOmi; // Prida nove polozky do dodacieho listu
begin
  If oItmNum=0 then oItmNum := OmiNextItmNum (oDocNum);
  If not dmSTK.btOMI.FindKey ([oDocNum,oItmNum]) then begin
    dmSTK.btOMI.Insert;
    dmSTK.btOMI.FieldByName ('DocNum').AsString := oDocNum;
    dmSTK.btOMI.FieldByName ('ItmNum').AsInteger := oItmNum;
    dmSTK.btOMI.FieldByName ('MgCode').AsInteger := oMgCode;
    dmSTK.btOMI.FieldByName ('GsCode').AsInteger := oGsCode;
    dmSTK.btOMI.FieldByName ('GsName').AsString := oGsName;
    dmSTK.btOMI.FieldByName ('BarCode').AsString := oBarCode;
    dmSTK.btOMI.FieldByName ('StkCode').AsString := oStkCode;
    dmSTK.btOMI.FieldByName ('StkNum').AsInteger := oStkNum;
    dmSTK.btOMI.FieldByName ('MsName').AsString := oMsName;
    dmSTK.btOMI.FieldByName ('GsQnt').AsFloat := oGsQnt;
    dmSTK.btOMI.FieldByName ('VatPrc').AsInteger := oVatPrc;
    dmSTK.btOMI.FieldByName ('CPrice').AsFloat := oCPrice;
    dmSTK.btOMI.FieldByName ('CValue').AsFloat := Rd2(oCPrice*oGsQnt);
    dmSTK.btOMI.FieldByName ('EValue').AsFloat := Rd2(dmSTK.btOMI.FieldByName ('CValue').AsFloat*(1+oVatPrc/100));
    dmSTK.btOMI.FieldByName ('BPrice').AsFloat := oBPrice;
    dmSTK.btOMI.FieldByName ('StkStat').AsString := 'N';
    dmSTK.btOMI.FieldByName ('OcdNum').AsString := oOcdNum;
    dmSTK.btOMI.FieldByName ('OcdItm').AsInteger := oOcdItm;
    dmSTK.btOMI.FieldByName ('SrcDoc').AsString := oSrcDoc;
    dmSTK.btOMI.FieldByName ('SrcItm').AsInteger := oSrcItm;
    dmSTK.btOMI.FieldByName ('DocDate').AsDateTime := oDocDate;
    dmSTK.btOMI.Post;
  end
end;

procedure TAddOmdF.OutputOmItm; // Vydaj aktualnej polozky zo skladu
begin
  F_DocHand.OutputOmItm;
  oCPrice := dmSTK.btOMI.FieldByName ('CPrice').AsFloat;
end;


end.
