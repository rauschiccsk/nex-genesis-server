unit PlsHand;

// *************************************************************************
//                     Modul na pracu s perdajnym cennikom
// *************************************************************************
// Programovy modul v pripade modifikacie polozky v predajnom cenniku vykona
// nalsledovne operacie>
// - ak bola zmenena cena ulozi zaznam do historie zmeny pedajnych cien
// - ulozi zaznam pre registracne pokladne
// - ak je definovany internetovy prenos udajov vytvori prenosovy subor
// *************************************************************************

interface

uses
  IcTypes, IcTools, IcConv, IcVariab, NexPath, NexMsg, NexError, NexGlob, BtrHand, RefFile, Pls,
  IniFiles, Forms, Classes, SysUtils, NexBtrTable, NexPxTable;

type
  TPlsHand=class
    constructor Create;
    destructor Destroy; override;
  private
    btPLS: TNexBtrTable;
    btPLH: TNexBtrTable;
    btGSCAT: TNexBtrTable;
    oPlsNum: word;
    oStkNum: word;
    oGsCode: longint;
    oAPrice: double;
    oProfit: double;
    oBPrice: double;
    oOpenGs: boolean;
    oModPrg: Str3;
    oChgPrc: boolean; // TRUE ak bola zmenena predajna cena tovaru
    procedure GscToPls;  // V pripade noveho tovaru ulozi zakladne udaje z bazovej evidencii
    procedure SaveToPls; // Ulozi zmeny do cennika
    procedure SaveToPlh; // Ulozi zmeny do historie zmeny PC
    procedure SaveToCas; // Ulozi zmeny pre registracne pokladne
    procedure SaveToOip; // Ulozi zmeny pre internetovy prenos
  public
    procedure SaveData; // Ulozi udaje do cennika a prislusnych suborov
  published
    property PLS: TNexBtrTable write btPLS;
    property PLH: TNexBtrTable write btPLH;
    property GSCAT: TNexBtrTable write btGSCAT;

    property PlsNum:word write oPlsNum;
    property StkNum:word write oStkNum;
    property GsCode:longint write oGsCode;
    property APrice:double write oAPrice;
    property Profit:double write oProfit;
    property BPrice:double write oBPrice;
    property OpenGs:boolean write oOpenGs;
    property ModPrg:Str3 write oModPrg;
  end;

implementation

uses DM_STKDAT;

constructor TPlsHand.Create;
begin
  //
end;

destructor TPlsHand.Destroy;
begin
  //
end;

// ************************* PRIVATE METHODS *************************

procedure TPlsHand.GscToPls;  // V pripade noveho tovaru ulozi zakladne udaje z bazovej evidencii
var mMyOp,mFind:boolean;
begin
  mMyOp:=btGSCAT=nil;
  If mMyOp then begin // Ak bazova evidencia nie je otvorena otvorime
    btGSCAT:=TNexBtrTable.Create(Application);
    btGSCAT.Name:='btGSCAT';
    dmSTK.OpenBase(btGSCAT);
    btGSCAT.IndexName:='GsCode';
  end;
  // Prekontrolujeme ci databazovy kurzor stoji na danom tovare - ak nie nastavime
  mFind:=btGSCAT.FieldByName('GsCode').AsInteger=oGsCode;
  If not mFind then mFind:=btGSCAT.FindKey([oGsCode]);
  // Prepiseme udaje z bazovej evidencii do cenniku
  If mFind then begin
    BTR_To_BTR (btGSCAT,btPLS);
  end;
  If mMyOp then begin // Aj databazovy subor sme otvorili tu tak aj zatvorime
    btGSCAT.Close;
    FreeAndNil (btGSCAT);
  end;
end;

procedure TPlsHand.SaveToPls; // Ulozi zmeny do cennika
begin
  GscToPls;  // V pripade noveho tovaru ulozi zakladne udaje z bazovej evidencii
  If not Eq2(btPLS.FieldByName('BPrice').AsFloat,oBPrice) then begin
    btPLS.FieldByName('OvsUser').AsString:=gvSys.LoginName;
    btPLS.FieldByName('OvsDate').AsDateTime:=Date;
  end;
  btPLS.FieldByName('StkNum').AsInteger:=oStkNum;
  btPLS.FieldByName('Profit').AsFloat:=oProfit;
  btPLS.FieldByName('APrice').AsFloat:=oAPrice;
  btPLS.FieldByName('BPrice').AsFloat:=oBPrice;
  btPLS.FieldByName('OpenGs').Asinteger:=Integer(oOpenGs);
  If oChgPrc then btPLS.FieldByName('ChgItm').AsString:='';
end;

procedure TPlsHand.SaveToPlh; // Ulozi zmeny do historie zmeny PC
var mMyOp:boolean;
begin
  If oChgPrc then begin  // Bola zmenena predajna cena preto ulozime zaznam do historie zmien predajnych cien
    btPLH.Insert;
    btPLH.FieldByName('GsCode').AsInteger:=btPLS.FieldByName('GsCode').AsInteger;
    btPLH.FieldByName('OProfit').AsFloat:=btPLS.FieldByName('Profit').AsFloat;
    btPLH.FieldByName('OAPrice').AsFloat:=btPLS.FieldByName('APrice').AsFloat;
    btPLH.FieldByName('OBPrice').AsFloat:=btPLS.FieldByName('BPrice').AsFloat;
    btPLH.FieldByName('NProfit').AsFloat:=oProfit;
    btPLH.FieldByName('NAPrice').AsFloat:=oAPrice;
    btPLH.FieldByName('NBPrice').AsFloat:=oBPrice;
    btPLH.FieldByName('ModPrg').AsString:=oModPrg;
    btPLH.Post
  end;
end;

procedure TPlsHand.SaveToCas; // Ulozi zmeny pre registracne pokladne
begin
  gPlsRef:=TPlsRef.Create;
  gPlsRef.AddToRefData ('M',btPLS); // Ulozi zaznam z PLS kde stoji kurzor do vsetkych pokladnic, ktore pouzivaju dany cennik
  gPlsRef.SaveToRefFile(btPLS.BookNum,nil);
  FreeAndNil (gPlsRef);
end;

procedure TPlsHand.SaveToOip; // Ulozi zmeny pre internetovy prenos
begin
end;

// ************************* PUBLIC METHODS *************************

procedure TPlsHand.SaveData; // Ulozi udaje do cennika a prislusnych suborov
var mMyOpPls,mMyOpPlh,mFind,mModify:boolean;
begin
  mMyOpPls:=btPLS=nil;    mMyOpPlh:=btPLH=nil;
  If mMyOpPls then begin // Ak bazova evidencia nie je otvorena otvorime
    btPLS:=TNexBtrTable.Create(Application);
    btPLS.Name:='btPLS';
    dmSTK.OpenBase(btPLS);  btPLS.IndexName:='GsCode';
  end;
  If mMyOpPlh then begin // Ak bazova evidencia nie je otvorena otvorime
    btPLH:=TNexBtrTable.Create(Application);
    btPLH.Name:='btPLH';
    dmSTK.OpenBase(btPLH);
  end;
  // Prekontrolujeme ci databazovy kurzor stoji na danom tovare - ak nie nastavime
  mFind:=btPLS.FieldByName('GsCode').AsInteger=oGsCode;
  If not mFind then mFind:=btPLS.FindKey([oGsCode]);
  If mFind then begin
    mModify:=btPLS.FieldByName('Action').AsString<>'A';
    If mModify then begin
      oChgPrc:=not Eq2(btPLS.FieldByName('BPrice').AsFloat,oBPrice);
      try BtrBegTrans;
        SaveToPlh; // Ulozi zmeny do historie zmeny PC
        btPLS.Edit;
        SaveToPls; // Ulozi zmeny do cennika
        btPLS.Post;
      BtrEndTrans;
      except BtrAbortTrans; end;
      SaveToCas; // Ulozi zmeny pre registracne pokladne
      SaveToOip; // Ulozi zmeny pre internetovy prenos
    end
    else ShowMsg (ecPlsThisGsIsInAction,'');
  end
  else begin  // Zalozime novu polozku do cennika
    btPLS.Insert;
    SaveToPls; // Ulozi zmeny do cennika
    btPLS.Post;
    SaveToCas; // Ulozi zmeny pre registracne pokladne
    SaveToOip; // Ulozi zmeny pre internetovy prenos
  end;
  If mMyOpPlh then begin // Aj databazovy subor sme otvorili tu tak aj zatvorime
    btPLH.Close;
    FreeAndNil (btPLH);
  end;
  If mMyOpPls then begin // Aj databazovy subor sme otvorili tu tak aj zatvorime
    btPLS.Close;
    FreeAndNil (btPLS);
  end;
end;

end.
