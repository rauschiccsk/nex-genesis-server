unit RefFile;

interface

uses
  IcTypes, IcVariab, IcConv, IcTools, IcFiles, NexVar, TxtWrap, NexIni, NexPath, Key, eCCTDEF,
  DB, IniFiles, Classes, NexBtrTable, ComCtrls, SysUtils, Forms;

type
  TPlsRef = class
    constructor Create;
    destructor Destroy; override;
  private
    oWrap: TTxtWrap;
    oRefFile : TStrings;
    oOpenGS  : boolean;
    oOpenGN  : boolean;
    oDivSet  : byte;    // Priznak delitelnosti tovaru(0-volne delitelny;1-nedelitelny;2-1/2;...)
    oDescr1  : Str60;   // Popis1
    oDescr2  : Str60;   // Popis2
    oDescr3  : Str60;   // Popis3
    oOsdCode : Str15;   // Objedn·vacÌ kÛd
    oSpcCode : Str30;   // SpecifikaËn˝ kÛd polozky
    oMsuQnt  : double;  // Mnozstvo tovaru v z·kladnej mernej jednotke
    oMsuName : Str10;   // N·zov z·kladnej mernej jednotky
    oCPrice  : double;  // NC tovaru zo skaldovej karty
    oCctVat  : byte;    // Prenesen· daÚov· povinnosù
    ohCCTDEF:TCctdefHne;
  public
  published
    procedure ClearRefData;
    procedure LoadGscData(pGsCode:longint);  // nacita zakladne udaje z bazovej evidencii
    procedure LoadStkData(pGsCode,pStkNum:longint);  // nacita zakladne udaje zo skladovej karty
    procedure AddToRefData(pCommand:Str1;btPLS:TNexBtrTable); // Prida aktualnu polozku zadaneho cennika do REF udajov
    procedure AddToRefData_ (pCommand:Str1;btPLS,btPlsLst:TNexBtrTable); // Prida aktualnu polozku zddaneho cennika do REF udajov
    procedure SaveToRefFile (pPlsNum:Str5;pIndicator:TProgressBar); // Uloi udaje do REF suborov pre jednotlivych pokladnic
    procedure SaveToRefFileCas (pPlsNum:Str5;pCasNum:string;pIndicator:TProgressBar); // Uloi udaje do REF suborov pre jednotlivych pokladnic
  end;

  TGscRef = class
    constructor Create;
    destructor Destroy; override;
  private
    oWrap: TTxtWrap;
    oRefFile: TStrings;
  public
  published
    procedure AddToRefData  (pCommand:Str1;btGsc:TDataSet); // Prida aktualnu polozku zddaneho cennika do REF udajov
    procedure SaveToRefFile (pIndicator:TProgressBar);          // Ulozi udaje do REF suborov pre jednotlivych pokladnic
    procedure SaveToRefFilePath (pPath:Str60);          // Ulozi udaje do REF suboru do zadaneho adresara
  end;

  TMglRef = class
    constructor Create;
    destructor Destroy; override;
  private
    oWrap: TTxtWrap;
    oRefFile: TStrings;
  public
  published
    procedure AddToRefData  (pCommand:Str1;btMglst:TDataSet); // Prida aktualnu polozku zddaneho cennika do REF udajov
    procedure SaveToRefFile (pIndicator:TProgressBar);          // Ulozi udaje do REF suborov pre jednotlivych pokladnic
    procedure SaveToRefFilePath (pPath:Str60);          // Ulozi udaje do REF suboru do zadaneho adresara
  end;

var gPlsRef:TPlsRef;
var gGscRef:TGscRef;
var gMglRef:TMglRef;

implementation

uses DM_CABDAT, DM_STKDAT;

constructor TPlsRef.Create;
begin
  oWrap:=TTxtWrap.Create;
  oRefFile:=TStringList.Create;
  oOpenGS:=dmSTK.btGSCAT.Active;
  oOpenGN:=dmSTK.btGSNOTI.Active;
  If not oOpenGS then dmSTK.OpenBase(dmSTK.btGSCAT);
  If not oOpenGN then dmSTK.OpenBase(dmSTK.btGSNOTI);
  ohCCTDEF:=TCctdefHne.Create;
end;

destructor TPlsRef.Destroy;
begin
  FreeAndNil(ohCCTDEF);
  If not oOpenGS then dmSTK.btGSCAT.Close;
  If not oOpenGN then dmSTK.btGSNOTI.Close;
  FreeAndNil (oRefFile);
  FreeAndNil (oWrap);
  inherited Destroy;
end;

procedure TPlsRef.LoadGscData(pGSCode:longint);  // V pripade noveho tovaru ulozi zakladne udaje z bazovej evidencii
var mFind,mGS:boolean;btGSCat:TNexBtrTable;
begin
  oDivSet:=0; oDescr1:=''; oDescr2:=''; oDescr3:=''; oOsdCode:=''; oSpcCode:=''; oMsuQnt:=0; oMsuName:=''; oCctVat:=0;
  If (dmStk.btGSCAT=nil) or not  dmStk.btGSCAT.Active then begin // Ak bazova evidencia nie je otvorena otvorime
    btGSCAT:=TNexBtrTable.Create(NIL);
    btGSCAT.Name:='btGSCAT';
    dmSTK.OpenBase(btGSCAT);
    btGSCAT.IndexName:='GsCode';
    // Prekontrolujeme ci databazovy kurzor stoji na danom tovare - ak nie nastavime
    mFind:=btGSCAT.FieldByName('GsCode').AsInteger=pGsCode;
    If not mFind then mFind:=btGSCAT.FindKey([pGsCode]);
    If mFind then begin
      oDivSet :=btGSCAT.fieldbyname('DivSet').AsInteger;
//      oDescr1 :=btGSCAT.fieldbyname('Descr1').AsString;
//      oDescr2 :=btGSCAT.fieldbyname('Descr2').AsString;
//      oDescr3 :=btGSCAT.fieldbyname('Descr3').AsString;
      oOsdCode:=btGSCAT.fieldbyname('OsdCode').AsString;
      oSpcCode:=btGSCAT.fieldbyname('SpcCode').AsString;
      oMsuQnt :=btGSCAT.fieldbyname('MsuQnt').AsFloat;
      oMsuName:=btGSCAT.fieldbyname('MsuName').AsString;
      If ohCCTDEF.LocBasCod(copy(btGSCAT.fieldbyname('CctCod').AsString,1,4)) then oCctVat:=1;
    end;
    btGSCAT.Close;
    FreeAndNil (btGSCAT);
  end else begin
    // Prekontrolujeme ci databazovy kurzor stoji na danom tovare - ak nie nastavime
    mGS:=dmStk.btGSCAT.FieldByName('GsCode').AsInteger=pGsCode;
    If not mGS then begin
      dmstk.btGSCAT.SwapStatus;
      dmstk.btGSCAT.IndexName:='GsCode';
    end;
    mFind:=mGS or dmStk.btGSCAT.FindKey([pGsCode]);
    If mFind then begin
      oDivSet :=dmStk.btGSCAT.fieldbyname('DivSet').AsInteger;
//      oDescr1 :=dmStk.btGSCAT.fieldbyname('Descr1').AsString;
//      oDescr2 :=dmStk.btGSCAT.fieldbyname('Descr2').AsString;
//      oDescr3 :=dmStk.btGSCAT.fieldbyname('Descr3').AsString;
      oOsdCode:=dmStk.btGSCAT.fieldbyname('OsdCode').AsString;
      oSpcCode:=dmStk.btGSCAT.fieldbyname('SpcCode').AsString;
      oMsuQnt :=dmStk.btGSCAT.fieldbyname('MsuQnt').AsFloat;
      oMsuName:=dmStk.btGSCAT.fieldbyname('MsuName').AsString;
      If ohCCTDEF.LocBasCod(copy(dmStk.btGSCAT.fieldbyname('CctCod').AsString,1,4)) then oCctVat:=1;
    end;
    If not mGS then dmStk.btGSCat.RestoreStatus;
  end;
  If (dmStk.btGSNOTI<>nil) and dmStk.btGSNOTI.Active then begin // Nacitame poznamky
    mFind:=dmStk.btGSNOTI.FieldByName('GsCode').AsInteger=pGsCode;
    If not mFind then mFind:=dmStk.btGSNOTI.FindKey([pGsCode]);
    If mFind then begin
      oDescr1 :=dmStk.btGSNOTI.fieldbyname('Notice').AsString;
      dmStk.btGSNOTI.Next;
      If not dmStk.btGSNOTI.Eof and (dmStk.btGSNOTI.FieldByName('GsCode').AsInteger=pGsCode) then oDescr2 :=dmStk.btGSNOTI.fieldbyname('Notice').AsString;
      dmStk.btGSNOTI.Next;
      If not dmStk.btGSNOTI.Eof and (dmStk.btGSNOTI.FieldByName('GsCode').AsInteger=pGsCode) then oDescr3 :=dmStk.btGSNOTI.fieldbyname('Notice').AsString;
    end;
  end;
end;

procedure TPlsRef.LoadStkData(pGSCode,pStkNum:longint);  // V pripade noveho tovaru ulozi zakladne udaje zo skaldovej karty
var mFind,mGS:boolean;
begin
  oCPrice:=0;
  If (dmStk.btSTK<>nil) and dmStk.btSTK.Active and (dmStk.btSTK.ListNum=pStkNum) then begin // Ak bazova evidencia nie je otvorena otvorime
    // Prekontrolujeme ci databazovy kurzor stoji na danom tovare - ak nie nastavime
    mGS:=dmStk.btSTK.FieldByName('GsCode').AsInteger=pGsCode;
    If not mGS then begin
      dmstk.btSTK.SwapStatus;
      dmstk.btSTK.IndexName:='GsCode';
      mFind:=dmStk.btSTK.FindKey([pGsCode]);
    end else mFind:=True;
    If mFind then begin
      oCPrice:=dmStk.btSTK.fieldbyname('AvgPrice').AsFloat;
    end;
    If not mGS then dmStk.btSTK.RestoreStatus;
  end;
end;

procedure TPlsRef.AddToRefData (pCommand:Str1;btPLS:TNexBtrTable); // Prida aktualnu polozku zddaneho cennika do REF udajov
begin
  AddToRefData_(pCommand,btPLS,dmSTK.btPLSLST);
end;

procedure TPlsRef.AddToRefData_ (pCommand:Str1;btPLS,btPlsLst:TNexBtrTable); // Prida aktualnu polozku zddaneho cennika do REF udajov
begin
  LoadGscData(btPLS.FieldByName('GsCode').AsInteger);
  If (btPLSLST<>NIL) and btPLSLST.Active
    then LoadStkData(btPLS.FieldByName('GsCode').AsInteger,btPLSLST.FieldByName('StkNum').AsInteger);
  oWrap.ClearWrap;
  oWrap.SetText(pCommand,1);                                     //  1
  oWrap.SetNum(btPLS.FieldByName('GsCode').AsInteger,0);         //  2
  If gkey.PlsRefDia[btPLS.ListNum]
    then oWrap.SetText(btPLS.FieldByName('GsName').AsString,0)   //  3
    else oWrap.SetText(ConvToNoDiakr(btPLS.FieldByName('GsName').AsString),0);   //  3
  oWrap.SetNum(btPLS.FieldByName('MgCode').AsInteger,0);         //  4
  oWrap.SetNum(btPLS.FieldByName('FgCode').AsInteger,0);         //  5
  oWrap.SetText(btPLS.FieldByName('BarCode').AsString,0);        //  6
  oWrap.SetText(btPLS.FieldByName('StkCode').AsString,0);        //  7
  oWrap.SetText(btPLS.FieldByName('MsName').AsString,0);         //  8
  oWrap.SetNum(btPLS.FieldByName('PackGs').AsInteger,0);         //  9
  oWrap.SetNum(btPLS.FieldByName('StkNum').AsInteger,0);         // 10
  oWrap.SetNum(btPLS.FieldByName('VatPrc').AsInteger,0);         // 11
  oWrap.SetNum(btPLS.FieldByName('PdnMust').AsInteger,0);        // 12
  oWrap.SetNum(btPLS.FieldByName('GrcMth').AsInteger,0);         // 13
  oWrap.SetReal(btPLS.FieldByName('Profit').AsFloat,0,2);        // 14
  oWrap.SetReal(btPLS.FieldByName('APrice').AsFloat,0,3);        // 15
  oWrap.SetReal(btPLS.FieldByName('BPrice').AsFloat,0,3);        // 16
  oWrap.SetNum(btPLS.FieldByName('OrdPrn').AsInteger,0);         // 17
  oWrap.SetNum(btPLS.FieldByName('OpenGs').AsInteger,0);         // 18
  oWrap.SetNum(oDivSet,0);                                       // 19
  oWrap.SetText(oDescr1,0);                                      // 20
  oWrap.SetText(oDescr2,0);                                      // 21
  oWrap.SetText(oDescr3,0);                                      // 22
  oWrap.SetText(oOsdCode,0);                                     // 23
  oWrap.SetText(oSpcCode,0);                                     // 24
  If btPLS.FieldByName('MgCode').AsInteger>=gvSys.SecMgc
    then oWrap.SetText('S', 0)                                   // 25
    else oWrap.SetText(btPLS.FieldByName('GsType').AsString, 0); // 25
  oWrap.SetReal(oMsuQnt,0,3);                                    // 26
  oWrap.SetText(oMsuName,0);                                     // 27
  oWrap.SetNum(btPLS.FieldByName('DisFlag').AsInteger,0);        // 28
  oWrap.SetReal(oCPrice,0,3);                                    // 29
  oWrap.SetNum(oCctVat,0);                                       // 30
  oRefFile.Add(oWrap.GetWrapText);
end;

procedure TPlsRef.SaveToRefFile (pPlsNum:Str5;pIndicator:TProgressBar); // Uloi udaje do REF suborov pre jednotlivych pokladnic
var mRef:TStrings; mPath,mFileName:ShortString;  mCnt,mPlsNum:word;  mFileExt:Str4; mFind:boolean;
begin
  mPlsNum:=ValInt (pPlsNum);
  dmCAB.btCABLST.Open;
  If dmCAB.btCABLST.RecordCount>0 then begin
    If pIndicator<> nil then begin
      pIndicator.Max:=dmCAB.btCABLST.RecordCount;
      pIndicator.Position:=0;
    end;
    mRef:=TStringList.Create;
    dmCAB.btCABLST.First;
    Repeat
    If pIndicator<> nil  then pIndicator.StepBy(1);
      mRef.Clear;
      If (dmCAB.btCABLST.FieldByName('PlsNum').AsInteger=mPlsNum) or (dmCAB.btCABLST.FieldByName('PlsNum').AsInteger=0) then begin
        mPath:=gPath.CasPath(dmCAB.btCABLST.FieldByname('CasNum').AsInteger);
        If gIni.PosRefFile then begin
          mFileName:='PLS'+StrIntZero(mPlsNum,5);
          If FileExistsI (mPath+mFileName+'.REF') then RenameFile (mPath+mFileName+'.REF',mPath+mFileName+'.TMP');
          If FileExistsI (mPath+mFileName+'.TMP') then mRef.LoadFromFile (mPath+mFileName+'.TMP');
          mRef.AddStrings (oRefFile);
          mRef.SaveToFile (mPath+mFileName+'.TMP');
          RenameFile (mPath+mFileName+'.TMP',mPath+mFileName+'.REF');
        end
        else begin // Po urcitom case zrusit - napr. po zavedeni ERU
          mFileName:='PLS'+StrIntZero(mPlsNum,5);   mFileExt:='.REF';
          mCnt:=0;
          Repeat
            mFileExt:='.'+StrIntZero(mCnt,3);
            mFind:=FileExistsI (mPath+mFileName+mFileExt);
            If mFind then Inc (mCnt);
          until not mFind;
          mRef.AddStrings (oRefFile);
          mRef.SaveToFile (mPath+'PLS.TMP');
          RenameFile (mPath+'PLS.TMP',mPath+mFileName+mFileExt);
        end;
      end;
      Application.ProcessMessages;
      dmCAB.btCABLST.Next;
    until (dmCAB.btCABLST.Eof);
    FreeAndNil(mRef);
 //   mRef.Free;
  end;
  dmCAB.btCABLST.Close;
end;

procedure TPlsRef.ClearRefData;
begin
  oRefFile.Clear;
end;

// **************** GSCAT.REF **************

constructor TGscRef.Create;
begin
  oWrap:=TTxtWrap.Create;
  oRefFile:=TStringList.Create
end;

destructor TGscRef.Destroy;
begin
  oRefFile.Free;
  oWrap.Free;
  inherited Destroy;
end;

procedure TGscRef.AddToRefData (pCommand:Str1;btGsc:TDataSet); // Prida aktualnu polozku zddaneho cennika do REF udajov
begin
  // gscat.bdf
  oWrap.ClearWrap;
  oWrap.SetText (pCommand,1);                                //  1
  oWrap.SetNum  (btGsc.FieldByName('GsCode').AsInteger,0);   //  2
  oWrap.SetText (btGsc.FieldByName('GsName').AsString,0);    //  3
  oWrap.SetNum  (btGsc.FieldByName('MgCode').AsInteger,0);   //  4
  oWrap.SetNum  (btGsc.FieldByName('FgCode').AsInteger,0);   //  5
  oWrap.SetText (btGsc.FieldByName('BarCode').AsString,0);   //  6
  oWrap.SetText (btGsc.FieldByName('StkCode').AsString,0);   //  7
  oWrap.SetText (btGsc.FieldByName('MsName').AsString,0);    //  8
  oWrap.SetNum  (btGsc.FieldByName('PackGs').AsInteger,0);   //  9
  oWrap.SetText (btGsc.FieldByName('GsType').AsString,0);    // 10
  oWrap.SetNum  (btGsc.FieldByName('DrbMust').AsInteger,0);  // 11
  oWrap.SetNum  (btGsc.FieldByName('PdnMust').AsInteger,0);  // 12
  oWrap.SetNum  (btGsc.FieldByName('GrcMth').AsInteger,0);   // 13
  oWrap.SetNum  (btGsc.FieldByName('VatPrc').AsInteger,0);   // 14
  oWrap.SetReal (btGsc.FieldByName('Volume').AsFloat,0,5);   // 15
  oWrap.SetReal (btGsc.FieldByName('Weight').AsFloat,0,5);   // 16
  oWrap.SetReal (btGsc.FieldByName('MsuQnt').AsFloat,0,5);   // 17
  oWrap.SetText (btGsc.FieldByName('MsuName').AsString,0);   // 18
  oWrap.SetNum  (btGsc.FieldByName('SbcCnt').AsInteger,0);   // 19
  oWrap.SetNum  (btGsc.FieldByName('DisFlag').AsInteger,0);  // 20
  oWrap.SetReal (btGsc.FieldByName('LinPrice').AsFloat,0,5); // 21
  oWrap.SetDate (btGsc.FieldByName('LinDate').AsDateTime);   // 22
  oWrap.SetNum  (btGsc.FieldByName('LinStk').AsInteger,0);   // 23
  oWrap.SetNum  (btGsc.FieldByName('LinPac').AsInteger,0);   // 24
  oWrap.SetNum  (0,0);   // 25   // btGsc.FieldByName('SecNum').AsInteger
  oWrap.SetNum  (0,0);   // 26   // btGsc.FieldByName('WgCode').AsInteger
  oWrap.SetNum  (btGsc.FieldByName('BasGsc').AsInteger,0);   // 27
  oWrap.SetNum  (btGsc.FieldByName('GscKfc').AsInteger,0);   // 28
  oWrap.SetNum  (btGsc.FieldByName('GspKfc').AsInteger,0);   // 29
  oWrap.SetReal (btGsc.FieldByName('QliKfc').AsFloat,0,5);   // 30
  oWrap.SetNum  (btGsc.FieldByName('DrbDay').AsInteger,0);   // 31
  oWrap.SetText (btGsc.FieldByName('OsdCode').AsString,0);   // 32
  oWrap.SetReal (btGsc.FieldByName('MinOsq').AsFloat,0,5);   // 33
  oWrap.SetText (btGsc.FieldByName('SpcCode').AsString,0);   // 34
  oWrap.SetNum  (btGsc.FieldByName('PrdPac').AsInteger,0);   // 35
  oWrap.SetNum  (btGsc.FieldByName('SupPac').AsInteger,0);   // 36
  oWrap.SetNum  (btGsc.FieldByName('SpirGs').AsInteger,0);   // 37
  oWrap.SetText (btGsc.FieldByName('GaName').AsString,0);    // 38
  oWrap.SetNum  (btGsc.FieldByName('DivSet').AsInteger,0);   // 39
//  oWrap.SetText (ConvToNoDiakr(btGsc.FieldByName('GsName').AsString),0);   //  3
  oRefFile.Add (oWrap.GetWrapText);
end;

procedure TGscRef.SaveToRefFile (pIndicator:TProgressBar); // Uloi udaje do REF suborov pre jednotlivych pokladnic
var mRef:TStrings; mPath,mFileName:ShortString;  mCnt:word;  mFileExt:Str4; mFind:boolean;
begin
  dmCAB.btCABLST.Open;
  If dmCAB.btCABLST.RecordCount>0 then begin
    If pIndicator<> nil then begin
      pIndicator.Max:=dmCAB.btCABLST.RecordCount;
      pIndicator.Position:=0;
    end;
    mRef:=TStringList.Create;
    dmCAB.btCABLST.First;
    Repeat
      If pIndicator<> nil  then pIndicator.StepBy(1);
      mRef.Clear;
      mPath:=gPath.CasPath(dmCAB.btCABLST.FieldByname('CasNum').AsInteger);
      If gIni.PosRefFile then begin
        mFileName:='GSCAT';
        If FileExistsI (mPath+mFileName+'.REF') then RenameFile (mPath+mFileName+'.REF',mPath+mFileName+'.TMP');
        If FileExistsI (mPath+mFileName+'.TMP') then mRef.LoadFromFile (mPath+mFileName+'.TMP');
        mRef.AddStrings (oRefFile);
        mRef.SaveToFile (mPath+mFileName+'.TMP');
        RenameFile (mPath+mFileName+'.TMP',mPath+mFileName+'.REF');
      end
      else begin // Po urcitom case zrusit - napr. po zavedeni ERU
        mFileName:='GSCAT';   mFileExt:='.REF';
        mCnt:=0;
        Repeat
          mFileExt:='.'+StrIntZero(mCnt,3);
          mFind:=FileExistsI (mPath+mFileName+mFileExt);
          If mFind then Inc (mCnt);
        until not mFind;
        mRef.AddStrings (oRefFile);
        mRef.SaveToFile (mPath+'GSCAT.TMP');
        RenameFile (mPath+'GSCAT.TMP',mPath+mFileName+mFileExt);
      end;
      dmCAB.btCABLST.Next;
    until (dmCAB.btCABLST.Eof);
//      FreeAndNil (mRef);
    mRef.Free;
  end;
  dmCAB.btCABLST.Close;
end;

procedure TGscRef.SaveToRefFilePath (pPath:Str60);          // Ulozi udaje do REF suboru do zadaneho adresara
var mRef:TStrings; mPath,mFileName:ShortString;  mCnt:word;  mFileExt:Str4; mFind:boolean;
begin
  mRef:=TStringList.Create;
  mRef.Clear;
  mPath:=pPath;
  If gIni.PosRefFile then begin
    mFileName:='GSCAT';
    If FileExistsI (mPath+mFileName+'.REF') then RenameFile (mPath+mFileName+'.REF',mPath+mFileName+'.TMP');
    If FileExistsI (mPath+mFileName+'.TMP') then mRef.LoadFromFile (mPath+mFileName+'.TMP');
    mRef.AddStrings (oRefFile);
    mRef.SaveToFile (mPath+mFileName+'.TMP');
    RenameFile (mPath+mFileName+'.TMP',mPath+mFileName+'.REF');
  end
  else begin // Po urcitom case zrusit - napr. po zavedeni ERU
    mFileName:='GSCAT';   mFileExt:='.REF';
    mCnt:=0;
    Repeat
      mFileExt:='.'+StrIntZero(mCnt,3);
      mFind:=FileExistsI (mPath+mFileName+mFileExt);
      If mFind then Inc (mCnt);
    until not mFind;
    mRef.AddStrings (oRefFile);
    mRef.SaveToFile (mPath+'GSCAT.TMP');
    RenameFile (mPath+'GSCAT.TMP',mPath+mFileName+mFileExt);
  end;
  mRef.Free;
end;

// **************** MGLST.REF **************

constructor TMglRef.Create;
begin
  oWrap:=TTxtWrap.Create;
  oRefFile:=TStringList.Create
end;

destructor TMglRef.Destroy;
begin
  oRefFile.Free;
  oWrap.Free;
  inherited Destroy;
end;

procedure TMglRef.AddToRefData (pCommand:Str1;btMgLst:TDataSet); // Prida aktualnu polozku zdaneho cennika do REF udajov
begin
  // MgLst.bdf
  oWrap.ClearWrap;
  oWrap.SetText(pCommand,1);                                 //  1
  oWrap.SetNum(btMGLST.FieldByName('MgCode').AsInteger,0);   //  2
  oWrap.SetText(btMGLST.FieldByName('MgName').AsString,0);   //  3
  oWrap.SetReal(btMGLST.FieldByName('Profit').AsFloat,0,3);  //  4
  oWrap.SetNum(btMGLST.FieldByName('Parent').AsInteger,0);   //  5
  oWrap.SetReal(btMGLST.FieldByName('PrfPrc1').AsFloat,0,3); //  6
  oWrap.SetReal(btMGLST.FieldByName('PrfPrc2').AsFloat,0,3); //  7
  oWrap.SetReal(btMGLST.FieldByName('PrfPrc3').AsFloat,0,3); //  8
  oWrap.SetReal(btMGLST.FieldByName('DscPrc1').AsFloat,0,3); //  9
  oWrap.SetReal(btMGLST.FieldByName('DscPrc2').AsFloat,0,3); // 10
  oWrap.SetReal(btMGLST.FieldByName('DscPrc3').AsFloat,0,3); // 11
  {
  oWrap.SetNum  (btMgLst.FieldByName('FrcQnt').AsInteger,0);   //  2
  oWrap.SetNum  (btMgLst.FieldByName('Coupon').AsInteger,0);   //  2
  oWrap.SetNum  (btMgLst.FieldByName('AgeVer').AsInteger,0);   //  2
  oWrap.SetNum  (btMgLst.FieldByName('OrdPrn').AsInteger,0);   //  2
  oWrap.SetNum  (btMgLst.FieldByName('OpenGs').AsInteger,0);   //  2
  oWrap.SetReal (btMgLst.FieldByName('PrfPrc4').AsFloat,0);    //  6
  oWrap.SetReal (btMgLst.FieldByName('PrfPrc5').AsFloat,0);    //  6
  oWrap.SetReal (btMgLst.FieldByName('DscPrc4').AsFloat,0);    //  6
  oWrap.SetReal (btMgLst.FieldByName('DscPrc5').AsFloat,0);    //  6
  }
  oRefFile.Add(oWrap.GetWrapText);
end;

procedure TMglRef.SaveToRefFile (pIndicator:TProgressBar); // Uloi udaje do REF suborov pre jednotlivych pokladnic
var mRef:TStrings; mPath,mFileName:ShortString;  mCnt:word;  mFileExt:Str4; mFind:boolean;
begin
  dmCAB.btCABLST.Open;
  If dmCAB.btCABLST.RecordCount>0 then begin
    If pIndicator<> nil then begin
      pIndicator.Max:=dmCAB.btCABLST.RecordCount;
      pIndicator.Position:=0;
    end;
    mRef:=TStringList.Create;
    dmCAB.btCABLST.First;
    Repeat
      If pIndicator<> nil  then pIndicator.StepBy(1);
      mRef.Clear;
      mPath:=gPath.CasPath(dmCAB.btCABLST.FieldByname('CasNum').AsInteger);
      If gIni.PosRefFile then begin
        mFileName:='MGLST';
        If FileExistsI (mPath+mFileName+'.REF') then RenameFile (mPath+mFileName+'.REF',mPath+mFileName+'.TMP');
        If FileExistsI (mPath+mFileName+'.TMP') then mRef.LoadFromFile (mPath+mFileName+'.TMP');
        mRef.AddStrings (oRefFile);
        mRef.SaveToFile (mPath+mFileName+'.TMP');
        RenameFile (mPath+mFileName+'.TMP',mPath+mFileName+'.REF');
      end
      else begin // Po urcitom case zrusit - napr. po zavedeni ERU
        mFileName:='MGLST';   mFileExt:='.REF';
        mCnt:=0;
        Repeat
          mFileExt:='.'+StrIntZero(mCnt,3);
          mFind:=FileExistsI (mPath+mFileName+mFileExt);
          If mFind then Inc (mCnt);
        until not mFind;
        mRef.AddStrings (oRefFile);
        mRef.SaveToFile (mPath+'MGLST.TMP');
        RenameFile (mPath+'MGLST.TMP',mPath+mFileName+mFileExt);
      end;
      dmCAB.btCABLST.Next;
    until (dmCAB.btCABLST.Eof);
//      FreeAndNil (mRef);
    mRef.Free;
  end;
  dmCAB.btCABLST.Close;
end;

procedure TMglRef.SaveToRefFilePath (pPath:Str60);          // Ulozi udaje do REF suboru do zadaneho adresara
var mRef:TStrings; mPath,mFileName:ShortString;  mCnt:word;  mFileExt:Str4; mFind:boolean;
begin
  mRef:=TStringList.Create;
  mRef.Clear;
  mPath:=pPath;
  If gIni.PosRefFile then begin
    mFileName:='MGLST';
    If FileExistsI (mPath+mFileName+'.REF') then RenameFile (mPath+mFileName+'.REF',mPath+mFileName+'.TMP');
    If FileExistsI (mPath+mFileName+'.TMP') then mRef.LoadFromFile (mPath+mFileName+'.TMP');
    mRef.AddStrings (oRefFile);
    mRef.SaveToFile (mPath+mFileName+'.TMP');
    RenameFile (mPath+mFileName+'.TMP',mPath+mFileName+'.REF');
  end
  else begin // Po urcitom case zrusit - napr. po zavedeni ERU
    mFileName:='MGLST';   mFileExt:='.REF';
    mCnt:=0;
    Repeat
      mFileExt:='.'+StrIntZero(mCnt,3);
      mFind:=FileExistsI (mPath+mFileName+mFileExt);
      If mFind then Inc (mCnt);
    until not mFind;
    mRef.AddStrings (oRefFile);
    mRef.SaveToFile (mPath+'MGLST.TMP');
    RenameFile (mPath+'MGLST.TMP',mPath+mFileName+mFileExt);
  end;
  mRef.Free;
end;

procedure TPlsRef.SaveToRefFileCas(pPlsNum:Str5;pCasNum:string;pIndicator:TProgressBar);
var mRef:TStrings; mPath,mFileName:ShortString;  mCnt,mPlsNum:word;  mFileExt:Str4; mFind:boolean;
begin
  mPlsNum:=ValInt (pPlsNum);
  dmCAB.btCABLST.Open;
  If dmCAB.btCABLST.RecordCount>0 then begin
    If pIndicator<> nil then begin
      pIndicator.Max:=dmCAB.btCABLST.RecordCount;
      pIndicator.Position:=0;
    end;
    mRef:=TStringList.Create;
    dmCAB.btCABLST.First;
    Repeat
      If pIndicator<> nil  then pIndicator.StepBy(1);
      mRef.Clear;
      If LongInInterval (dmCAB.btCABLST.FieldByName('CasNum').AsInteger,pCasNum) then begin
        mPath:=gPath.CasPath(dmCAB.btCABLST.FieldByname('CasNum').AsInteger);
        If gIni.PosRefFile then begin
          mFileName:='PLS'+StrIntZero(mPlsNum,5);
          If FileExistsI (mPath+mFileName+'.REF') then RenameFile (mPath+mFileName+'.REF',mPath+mFileName+'.TMP');
          If FileExistsI (mPath+mFileName+'.TMP') then mRef.LoadFromFile (mPath+mFileName+'.TMP');
          mRef.AddStrings (oRefFile);
          mRef.SaveToFile (mPath+mFileName+'.TMP');
          RenameFile (mPath+mFileName+'.TMP',mPath+mFileName+'.REF');
        end
        else begin // Po urcitom case zrusit - napr. po zavedeni ERU
          mFileName:='PLS'+StrIntZero(mPlsNum,5);   mFileExt:='.REF';
          mCnt:=0;
          Repeat
            mFileExt:='.'+StrIntZero(mCnt,3);
            mFind:=FileExistsI (mPath+mFileName+mFileExt);
            If mFind then Inc (mCnt);
          until not mFind;
          mRef.AddStrings (oRefFile);
          mRef.SaveToFile (mPath+'PLS.TMP');
          RenameFile (mPath+'PLS.TMP',mPath+mFileName+mFileExt);
        end;
      end;
      dmCAB.btCABLST.Next;
    until (dmCAB.btCABLST.Eof);
//      FreeAndNil (mRef);
    mRef.Free;
  end;
  dmCAB.btCABLST.Close;
end;

end.
{MOD 1807019}
{MOD 1909001}
