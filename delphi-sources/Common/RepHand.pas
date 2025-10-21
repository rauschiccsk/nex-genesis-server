unit RepHand;

interface

uses
  QRepIm_, QRepD_, QRepF_, QRepH, QRep2_, QRepN, PQRepR_, Preview_,
  NexPxTable, NexBtrTable, NexPath, Printers, QRPRNTR, qrexpr, QuickRpt, QRCTRLS,
  IcConst, IcConv, IniFiles, Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ActnList;

type
  TProcEvent = procedure of object;
  TF_RepHand = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    CB_PrinterName: TComboBox;
    Label2: TLabel;
    L_Port: TLabel;
    CB_RepMask: TComboBox;
    L_RepName: TLabel;
    B_Print: TBitBtn;
    Label5: TLabel;
    Label6: TLabel;
    E_Copies: TEdit;
    E_Pages: TEdit;
    B_Preview: TBitBtn;
    B_Cancel: TBitBtn;
    BB_GetPageCount: TBitBtn;
    E_PageCount: TEdit;
    ActionList1: TActionList;
    A_Exit: TAction;
    A_Print: TAction;
    A_Preview: TAction;
    procedure FormActivate(Sender: TObject);
    procedure CB_RepMaskChange(Sender: TObject);
    procedure CB_PrinterNameChange(Sender: TObject);
    procedure B_CancelClick(Sender: TObject);
    procedure B_PrintClick(Sender: TObject);
    procedure BB_GetPageCountClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure B_PreviewClick(Sender: TObject);
    procedure L_RepNameDblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    oMask      : string;
    oActRep    : string;
    oRepPath   : string;
    oFirst     : boolean;
    oPrnDefault: longint;
    oQR        : TQRPrinter;
    oMaskList  : TStrings;
    eExtFunctions: TProcEvent;
    oPrintClick: boolean; // Ak je true bolo stlacene tlacitko "Tlac". Je to potrebne procedure QuickExecute aby sme vedeli ci prvy doklad bol vytlaceny alebo nie
    oPreview   : TF_Preview;

    oPrinted   : boolean; //Vráti, èi bol vytlaèený dokument
    oPrintedQnt: longint; //Poèet vytlaèených kópií
(*
    oItemDef   : string;
    oNotiDef   : string;
    oSpecDef   : string;
*)
    oItem      : TNexPxTable;
    oNoti      : TNexPxTable;
    oSpec      : TNexPxTable;
    oMainTbl   : TNexBtrTable;

    oSysTmp    : TNexPxTable;
    oHedTmp    : TNexPxTable;
    oItmTmp    : TNexPxTable;
    oSpcTmp    : TNexPxTable;
    oSysBtr    : TNexBtrTable;
    oHedBtr    : TNexBtrTable;
    oItmBtr    : TNexBtrTable;
    oSpcBtr    : TNexBtrTable;

    oF_Rep     : TF_Rep;

    procedure ReadPrinters;
    procedure ReadRepMasks;
    procedure PrepareFunctions;

    procedure WriteRepIni;
    procedure ReadRepIni;
    procedure ReadDefIni;

    procedure AddDemoBand;
    procedure AddAboutBand;
(*
    procedure SetItemDef(pDef:string);
    procedure SetNotiDef(pDef:string);
    procedure SetSpecDef(pDef:string);
*)
    procedure MyPreview (Sender:TObject);
    { Private declarations }
    procedure GetRepIndexName(pName:string);
  public
    oQuickRep  : TQuickRep;
    oAccept: boolean;
    procedure Execute (pMask:string);
    procedure ExecuteQuick (pMask:string);
    function PrintClick:boolean;

    procedure SetBtrTable (pTable:TNexBtrTable);
    { Public declarations }
  published
    property OnExtFunctions:TProcEvent read eExtFunctions write eExtFunctions;
    property Accept:boolean read oAccept;
    property Printed:boolean read oPrinted write oPrinted;
    property PrintedQnt:longint read oPrintedQnt write oPrintedQnt;

//    property ItemDef:string read oItemDef write SetItemDef;
//    property NotiDef:string read oNotiDef write SetNotiDef;
//    property SpecDef:string read oSpecDef write SetSpecDef;

    property Item  :TNexPxTable  read oItem    write oItem;
    property Noti  :TNexPxTable  read oNoti    write oNoti;
    property Spec  :TNexPxTable  read oSpec    write oSpec;
    property Main  :TNexBtrTable read oMainTbl write oMainTbl;
    property SysTmp:TNexPxTable  read oSysTmp  write oSysTmp;
    property HedTmp:TNexPxTable  read oHedTmp  write oHedTmp;
    property ItmTmp:TNexPxTable  read oItmTmp  write oItmTmp;
    property SpcTmp:TNexPxTable  read oSpcTmp  write oSpcTmp;
    property SysBtr:TNexBtrTable read oSysBtr  write oSysBtr;
    property HedBtr:TNexBtrTable read oHedBtr  write oHedBtr;
    property ItmBtr:TNexBtrTable read oItmBtr  write oItmBtr;
    property SpcBtr:TNexBtrTable read oSpcBtr  write oSpcBtr;
//    property Main:TNexBtrTable write SetBtrTable;
  end;

var
  F_RepHand: TF_RepHand;

implementation

uses DBTables,BtrTable;

{$R *.DFM}

procedure TF_RepHand.Execute (pMask:string);
begin
  oPrinted    := FALSE;
  oPrintedQnt := 0;
  oAccept := FALSE;
  oPrintClick := FALSE;
  E_PageCount.Text := '';
  E_Pages.Text := '';
  oMask := pMask;
  oFirst := TRUE;
  oMaskList := TStringList.Create;
  oQR := TQRPrinter.Create;
  ShowModal;
  oQR.Free; oQR := nil;
  oMaskList.Free; oMaskList := nil;
end;

procedure TF_RepHand.ExecuteQuick (pMask:string);
var I:longint;  mMaskName:string;
begin
  oPrinted    := FALSE;
  oPrintedQnt := 0;
  If pMask=''
    then mMaskName := oRepPath+oActRep
    else mMaskName := oRepPath+pMask+'.Q01';
  If oPrintClick and FileExists (mMaskName) then begin
    oActRep := ExtractFileName (mMaskName);
    oQR := TQRPrinter.Create;
    oQuickRep := nil;
    oF_Rep.DestroyComponents;
    try
      ReadComponentResFile (mMaskName, oF_Rep);
      oF_Rep.InitTables (oItem, oNoti, oSpec, oMainTbl,oSysBtr,oHedBtr,oItmBtr,oSpcBtr,oSysTmp,oHedTmp,oItmTmp,oSpcTmp);
      oF_Rep.Hide;
      If oF_Rep.ComponentCount>0 then begin
        For I := 0 to oF_Rep.ComponentCount-1 do begin
          If oF_Rep.Components[I] is TQuickRep then begin
            oQuickRep := (oF_Rep.Components[I] as TQuickRep);
            oQuickRep.OnPreview := MyPreview;
            Break;
          end;
        end;
      end;
      If cPrintDemo then AddDemoBand;
      If cPrintAbout then AddAboutBand;
    except end;
    oQuickRep.PrinterSettings.PrinterIndex := CB_PrinterName.ItemIndex;
    PrepareFunctions;
    If oQuickRep<>nil then begin
      oQuickRep.PrinterSettings.Copies := 1;
      oQuickRep.Print;
    end;
    oQR.Free; oQR := nil;
  end;
end;

function TF_RepHand.PrintClick:boolean;
begin
  Result := oPrintClick;
end;

procedure TF_RepHand.SetBtrTable (pTable:TNexBtrTable);
begin
  oMainTbl.DatabaseName := pTable.DataBaseName;
  oMainTbl.TableName := pTable.TableName;
  oMainTbl.DefPath := pTable.DefPath;
  oMainTbl.DefName := pTable.DefName;
  oMainTbl.FixedName := pTable.FixedName;
  If oMainTbl.Exists then begin
    oMainTbl.Active := TRUE;
    oMainTbl.GotoPos(pTable.ActPos);
  end;
end;

procedure TF_RepHand.ReadPrinters;
var I:longint;
begin
  oPrnDefault := oQR.PrinterIndex;
  CB_PrinterName.Clear;
  If oQR.Printers.Count>0 then begin
    For I:=0 to oQR.Printers.Count-1 do begin
      If Pos (' on ', oQR.Printers.Strings[I])>0
        then CB_PrinterName.Items.Add (Copy (oQR.Printers.Strings[I],1,Pos (' on ', oQR.Printers.Strings[I])-1))
        else CB_PrinterName.Items.Add (oQR.Printers.Strings[I]);
    end;
    CB_PrinterName.ItemIndex := oPrnDefault;
  end;
end;

procedure TF_RepHand.ReadRepMasks;
var
  mSR:TSearchRec;
  mErr:longint;
  mA:TFileStream;
  mB:TStringStream;
  mSB:TStrings;
  mT:TextFile;
  mS,mTitle:string;
  mFind:boolean;
  mLevel:longint;
  mCnt:longint;
begin
  CB_RepMask.Clear;
  oMaskList.Clear;
  mSB := TStringList.Create;
  mErr := FindFirst (oMask+'.Q*', faAnyFile, mSR);
  While mErr=0 do begin
    mA := TFileStream.Create (ExtractFilePath (oMask)+mSR.Name,fmOpenRead);
    mB := TStringStream.Create(mS);
    ObjectResourceToText (mA,mB);
    mB.Seek(0, soFromBeginning);
    mSB.Text := mB.DataString;
    mTitle := '';
    mFind := FALSE;
    mLevel := 0;
    mCnt := 0;
    Repeat         
      If Pos ('  Tag = ', mSB.Strings[mCnt])=1 then mLevel := ValInt (Copy (mSB.Strings[mCnt], 9, Length (mSB.Strings[mCnt])));
      If Pos ('  Caption = ', mSB.Strings[mCnt])=1 then begin
        mFind := TRUE;
        mTitle := UnicodeIntToStr (Copy (mSB.Strings[mCnt], 13, Length (mSB.Strings[mCnt])));
      end;
      Inc (mCnt);
    until (mCnt>=mSB.Count) or mFind;
    mB.Free;
    mA.Free;
    If mLevel<=cUserRepLevel then begin
      oMaskList.Add (ExtractFileName(mSR.Name)+' '+mTitle);
      CB_RepMask.Items.Add (mTitle);
    end;
    mErr := FindNext (mSR);
  end;
  FindClose (mSR);
  mSB.Free;
end;

procedure TF_RepHand.PrepareFunctions;
var
  mR:TQREvResult;
  mPC:boolean;
  I:longint;
begin
  For I:=0 to oF_Rep.ComponentCount-1 do begin
    mPC := FALSE;
    If oF_Rep.Components[I] is TQRExpr then begin
      mPC := Pos ('PAGECOUNT', UpString ((oF_Rep.Components[I] as TQRExpr).Expression))>0;
    end;
    If mPC then Break;
  end;
  oQuickRep.Functions.Prepare;
  mR.Kind := resInt;
  If mPC then begin
    oQuickRep.Prepare;
    mR.intResult := oQuickRep.QRPrinter.PageCount;
    oQuickRep.QRPrinter.Free;
  end else mR.intResult := 0;
  oQuickRep.Functions.UpdateConstant ('PAGECOUNT',mR);
  mR.Kind := resString;
  mR.strResult := cFirmaName;
  oQuickRep.Functions.UpdateConstant ('FIRMANAME',mR);
  mR.strResult := DateToStr (Date);
  oQuickRep.Functions.UpdateConstant ('PRINTDATE',mR);
  mR.strResult := TimeToStr (Time);
  oQuickRep.Functions.UpdateConstant ('PRINTTIME',mR);
  mR.strResult := oActRep;
  oQuickRep.Functions.UpdateConstant ('REPFILE',mR);
  If Assigned (eExtFunctions) then eExtFunctions;
end;

procedure TF_RepHand.WriteRepIni;
var
  mTI:TIniFile;
  mFile:string;
  mS:string;
begin
  mTI := TIniFile.Create (cMainPrivPath+cUserName+'.QRI');
  mFile := oMaskList.Strings[CB_RepMask.ItemIndex];
  mFile := Copy (mFile, 1, Pos (' ',mFile)-1);
  mS := Copy (mFile,Pos ('.', mFile)+1,Length (mFile));
  mTI.WriteString('REPLIST', mFile, CB_PrinterName.Text+','+E_Copies.Text);
  mFile := Copy (mFile, 1, Pos ('.', mFile)-1);
  mTI.WriteString('DEFREP', mFile, mS);
  mTI.Free; mTI := nil;
end;

procedure TF_RepHand.ReadRepIni;
var
  mTI:TIniFile;
  mFile:string;
  mS:string;
  mPrinter:string;
  mCopies:longint;
  mPos:longint;
  mCnt:longint;
begin
  mTI := TIniFile.Create (cMainPrivPath+cUserName+'.QRI');
  mFile := oMaskList.Strings[CB_RepMask.ItemIndex];
  mFile := Copy (mFile, 1, Pos (' ',mFile)-1);
  mS := mTI.ReadString('REPLIST', mFile, '');
  mCopies := 0;
  mPrinter := '';
  If mS<>'' then begin
    mPrinter := Copy (mS,1,Pos (',',mS)-1);
    mCopies := ValInt (Copy (mS,Pos (',', mS)+1, Length (mS)));
  end;
  If CB_PrinterName.Items.Count>0 then begin
    If mPrinter<>'' then begin
      mPos := -1;
      mCnt := 0;
      Repeat
        If Pos (UpString (mPrinter), UpString (CB_PrinterName.Items.Strings[mCnt]))=1 then mPos := mCnt;
        If mPos<0 then Inc (mCnt);
      until (mCnt>=CB_PrinterName.Items.Count) or (mPos>-1);
      If mPos =-1 then mPos := oPrnDefault;
      CB_PrinterName.ItemIndex := mPos;
    end else CB_PrinterName.ItemIndex := oPrnDefault;
  end;
  If mCopies<=0 then mCopies := 1;
  E_Copies.Text := StrInt (mCopies, 0);
  mTI.Free; mTI := nil;
end;

procedure TF_RepHand.ReadDefIni;
var
  mTI:TIniFile;
  mS:string;
  mCnt:longint;
  mPos:longint;
begin
  mTI := TIniFile.Create (cMainPrivPath+cUserName+'.QRI');
  mS := mTI.ReadString('DEFREP', ExtractFileName (oMask), '');
  mTI.Free; mTI := nil;
  If CB_RepMask.Items.Count>0 then begin
    If mS<>'' then begin
      mPos := -1;
      mCnt := 0;
      Repeat
        If Pos (UpString (ExtractFileName (oMask)+'.'+mS), UpString (oMaskList.Strings[mCnt]))=1 then mPos := mCnt;
        If mPos<0 then Inc (mCnt);
      until (mCnt>=CB_RepMask.Items.Count) or (mPos>-1);
      If mPos =-1 then mPos := 0;
    end else mPos := 0;
    CB_RepMask.ItemIndex := mPos;
  end;
end;

procedure TF_RepHand.AddDemoBand;
var
  mPH:TQRBand;
  mCh:TQRChildBand;
  mL:TQRLabel;
  mLabel:string;
  I:longint;
  mAddPageHeader:boolean;
  mPHName:string;
  mWidth:longint;
begin
  mAddPageHeader := TRUE;
  mPHName := '';
  For I:=0 to oF_Rep.ComponentCount-1 do begin
    If oF_Rep.Components[I] is TQRBand then begin
      If (oF_Rep.Components[I] as TQRBand).BandType=rbPageHeader then begin
        mPHName := (oF_Rep.Components[I] as TQRBand).Name;
        mAddPageHeader := FALSE;
       Break;
      end;
    end;
  end;
  mL := TQRLabel.Create (oF_Rep);
  If mAddPageHeader then begin
    mPH := TQRBand.Create (oF_Rep);
    mPH.Parent := oQuickRep;
    mPH.BandType := rbPageHeader;
    mPH.Height := 16;
    mWidth := mPH.Width;
    mL.Parent := mPH;
  end else begin
    mCh := TQRChildband.Create (oF_Rep);
    mCh.Parent := oQuickRep;
    mCh.Height := 16;
    mCh.ParentBand := (oF_Rep.FindComponent (mPHName) as TQRBand);
    mWidth := mCh.Width;
    mL.Parent := mCh;
  end;
  mL.AutoSize := FALSE;
  mL.Left := 0;
  mL.Top := 0;
  mL.Height := 16;
  mL.Width := mWidth;
  mL.Font.Style := [fsBold];
  mL.Caption := '';
  For I:=1 to 40 do begin
    mL.Caption := mL.Caption+'D'; mL.Caption := mL.Caption+'E'; mL.Caption := mL.Caption+'M'; mL.Caption := mL.Caption+'O'; mL.Caption := mL.Caption+' ';
  end;
end;

procedure TF_RepHand.AddAboutBand;
var
  mPF:TQRBand;
  mCh:TQRChildBand;
  mL:TQRLabel;
  mLabel:string;
  I:longint;
  mAddPageFooter:boolean;
  mPFName:string;
  mWidth:longint;
begin
  mAddPageFooter := TRUE;
  mPFName := '';
  For I:=0 to oF_Rep.ComponentCount-1 do begin
    If oF_Rep.Components[I] is TQRBand then begin
      If (oF_Rep.Components[I] as TQRBand).BandType=rbPageFooter then begin
        mPFName := (oF_Rep.Components[I] as TQRBand).Name;
        mAddPageFooter := FALSE;
       Break;
      end;
    end;
  end;
  mL := TQRLabel.Create (oF_Rep);
  If mAddPageFooter then begin
    mPF := TQRBand.Create (oF_Rep);
    mPF.Parent := oQuickRep;
    mPF.BandType := rbPageFooter;
    mPF.Height := 12;
    mWidth := mPF.Width;
    mL.Parent := mPF;
  end else begin
    mCh := TQRChildband.Create (oF_Rep);
    mCh.Parent := oQuickRep;
    mCh.Height := 12;
    mCh.ParentBand := (oF_Rep.FindComponent (mPFName) as TQRBand);
    mWidth := mCh.Width;
    mL.Parent := mCh;
  end;
  mL.Left := 0;
  mL.Top := 0;
  mL.Height := 12;
  mL.Font.Size := 7;
  mL.Font.Style := [];
  mL.Caption := cAbout;
end;
(*
procedure TF_RepHand.SetItemDef(pDef:string);
begin
  oItemDef := pDef;
  oItem.DatabaseName := gPath.PrivPath;
  oItem.FixName := 'PRNI';
  oItem.DefPath := gPath.DefPath;
  oItem.DefName := pDef;
  oItem.Active := TRUE;
end;

procedure TF_RepHand.SetNotiDef(pDef:string);
begin
  oNotiDef := pDef;
  oNoti.DatabaseName := gPath.PrivPath;
  oNoti.FixName := 'PRNN';
  oNoti.DefPath := gPath.DefPath;
  oNoti.DefName := pDef;
  oNoti.Active := TRUE;
end;

procedure TF_RepHand.SetSpecDef(pDef:string);
begin
  oSpecDef := pDef;
  oSpec.DatabaseName := gPath.PrivPath;
  oSpec.FixName := 'PRNS';
  oSpec.DefPath := gPath.DefPath;
  oSpec.DefName := pDef;
  oSpec.Active := TRUE;
end;
*)
procedure TF_RepHand.MyPreview (Sender:TObject);
begin
  oPreview.QP_Preview.QRPrinter := TQRPrinter(Sender);
  oPreview.Show;
end;

procedure TF_RepHand.FormActivate(Sender: TObject);
begin
  If oFirst then begin
    ReadPrinters;
    ReadRepMasks;
    ReadDefIni;
    CB_RepMaskChange(Sender);
  end;
  oFirst := FALSE;
end;

procedure TF_RepHand.CB_RepMaskChange(Sender: TObject);
var I:longint;mName:string;
begin
  B_Print.Enabled := FALSE;
  B_Preview.Enabled := FALSE;
  E_PageCount.Text := '';
  E_Pages.Text := '';
  oQuickRep := nil;
  oF_Rep.Hide;
  If CB_RepMask.ItemIndex>-1 then begin
    oActRep := oMaskList.Strings[CB_RepMask.ItemIndex];
    oActRep := Copy (oActRep, 1, Pos (' ',oActRep)-1);
    oF_Rep.DestroyComponents;
    try
      oRepPath := ExtractFilePath (oMask);
      ReadComponentResFile (oRepPath+oActRep, oF_Rep);
      oF_Rep.InitTables (oItem, oNoti, oSpec, oMainTbl,oSysBtr,oHedBtr,oItmBtr,oSpcBtr,oSysTmp,oHedTmp,oItmTmp,oSpcTmp);
      oF_Rep.Hide;
      If oF_Rep.ComponentCount>0 then begin
        For I := 0 to oF_Rep.ComponentCount-1 do begin
          If oF_Rep.Components[I] is TQuickRep then begin
            oQuickRep := (oF_Rep.Components[I] as TQuickRep);
            mName:=oQuickRep.DataSet.Name;
            GetRepIndexName(mName);
            oQuickRep.OnPreview := MyPreview;
            Break;
          end;
        end;
      end;
      If cPrintDemo then AddDemoBand;
      If cPrintAbout then AddAboutBand;
      ReadRepIni;
      CB_PrinterNameChange(Sender);
    except end;
  end;
  B_Print.Enabled := TRUE;
  B_Preview.Enabled := TRUE;
end;

procedure TF_RepHand.CB_PrinterNameChange(Sender: TObject);
var mS:string;
begin
  mS := oQR.Printers.Strings[CB_PrinterName.ItemIndex];
  If Pos (' on ', mS)>0
    then L_Port.Caption := Copy (mS, Pos (' on ', mS)+4,Length (mS))
    else L_Port.Caption := '';
end;

procedure TF_RepHand.B_CancelClick(Sender: TObject);
begin
  oAccept := FALSE;
  Close;
end;

procedure TF_RepHand.B_PrintClick(Sender: TObject);
var
  mS:string;
  mA:string;
  mF,mL:longint;
  Saved8087CW: Word;
begin
  If B_Print.Enabled then begin
    oAccept := TRUE;
    oPrintClick := TRUE; // Bola spustena tlac
    If oQuickRep<>nil then begin
      oQuickRep.Units := MM;
      Saved8087CW := Default8087CW;
      Set8087CW($133f); { Disable all fpu exceptions }
      oQuickRep.PrinterSettings.Copies := ValInt (E_Copies.Text);
      oQuickRep.PrinterSettings.PrinterIndex := CB_PrinterName.ItemIndex;
      PrepareFunctions;
      If E_Pages.Text=''
        then oQuickRep.Print
        else begin
          mS := E_Pages.Text;
          Repeat
            If Pos (',',mS)>0 then begin
              mA := Copy (mS,1,Pos (',',mS)-1);
              Delete (mS,1,Pos (',',mS));
            end else begin
              mA := mS;
              mS := '';
            end;
            If Pos ('-',mA)>0 then begin
              mF := ValInt (Copy (mA, 1, Pos ('-',mA)-1));
              mL := ValInt (Copy (mA, Pos ('-',mA)+1,Length (mA)));
            end else begin
              mF := ValInt (mA);
              mL := mF;
            end;
            If (mF>0) and (mL>0) then begin
              oQuickRep.PrinterSettings.FirstPage := mF;
              oQuickRep.PrinterSettings.LastPage := mL;
              oQuickRep.Print;
            end;
          until mS='';
        end;
      WriteRepIni;
      oPrinted := TRUE;
      oPrintedQnt := oPrintedQnt+oQuickRep.PrinterSettings.Copies;
      Set8087CW(Saved8087CW);
    end;
    Close;
  end;
end;

procedure TF_RepHand.BB_GetPageCountClick(Sender: TObject);
begin
  oQuickRep.PrinterSettings.PrinterIndex := CB_PrinterName.ItemIndex;
  oQuickRep.Prepare;
  E_PageCount.Text := StrInt (oQuickRep.QRPrinter.PageCount,0);
  oQuickRep.QRPrinter.Free;
end;

procedure TF_RepHand.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key = VK_ESCAPE then Close;
end;

procedure TF_RepHand.B_PreviewClick(Sender: TObject);
begin
  If B_Preview.Enabled then begin
    oQuickRep.PrinterSettings.PrinterIndex := CB_PrinterName.ItemIndex;
    PrepareFunctions;
    If oQuickRep<>nil then begin
      oQuickRep.Preview;
      If oPreview.Printed then begin
        oPrinted := TRUE;
        oPrintedQnt := oPrintedQnt+oPreview.PrintedQnt;
      end;
    end;
    WriteRepIni;
  end;
end;

procedure TF_RepHand.L_RepNameDblClick(Sender: TObject);
var mF_QRMainH:TF_QRMainH;
begin
  mF_QRMainH := TF_QRMainH.Create(Self);
  mF_QRMainH.InitTables (oItem, oNoti, oSpec, oMainTbl,oSysBtr,oHedBtr,oItmBtr,oSpcBtr,oSysTmp,oHedTmp,oItmTmp,oSpcTmp);
  mF_QRMainH.Execute (oMask);
  FreeAndNil (mF_QRMainH);
end;

procedure TF_RepHand.FormDestroy(Sender: TObject);
begin
  oF_Rep.DestroyComponents;
  FreeAndNil (oF_Rep);
  FreeAndNil (oPreview);
(*
  oItem.Active := FALSE;
  FreeAndNil (oItem);
  oNoti.Active := FALSE;
  FreeAndNil (oNoti);
  oSpec.Active := FALSE;
  oMainTbl.Active := FALSE;
  FreeAndNil (oMainTbl);
*)
end;

procedure TF_RepHand.FormCreate(Sender: TObject);
begin
  oPreview := TF_Preview.Create(Self);
(*
  oItem := TNexPxTable.Create(Self);
  oNoti := TNexPxTable.Create(Self);
  oSpec := TNexPxTable.Create(Self);
  oMainTbl := TNexBtrTable.Create(Self);
*)
  oF_Rep := TF_Rep.Create(Self);
end;

procedure TF_RepHand.GetRepIndexName;

  function  GetTableObj (Value:string):TObject;
  var mDM, mTable:string;I,J:longint;
  begin
    Result := nil;
    If oItem.active then Result := oItem;
    for I:=0 to Application.ComponentCount-1 do begin
      If Application.Components[I] is TForm then begin
        for j:=0 to Application.Components[I].ComponentCount-1 do begin
          If (Application.Components[I].Components[J] is TBtrieveTable)
          and((Application.Components[I].Components[J] as TBtrieveTable).name=Value)
          and(Application.Components[I].Components[J] as TBtrieveTable).active
          then Result:=Application.Components[I].Components[J] as TBtrieveTable;
          If (Application.Components[I].Components[J] is TTable)
          and((Application.Components[I].Components[J] as TTable).name=Value)
          and(Application.Components[I].Components[J] as TTable).active
          then Result:=Application.Components[I].Components[J] as TTable;
        end;
      end else if Application.Components[I] is TDataModule then begin
        for j:=0 to Application.Components[I].ComponentCount-1 do begin
          If (Application.Components[I].Components[J] is TTable)
          and((Application.Components[I].Components[J] as TTable).name=Value)
          and(Application.Components[I].Components[J] as TTable).active
          then Result:=Application.Components[I].Components[J] as TTable;
          If (Application.Components[I].Components[J] is TBtrieveTable)
          and((Application.Components[I].Components[J] as TBtrieveTable).name=Value)
          and(Application.Components[I].Components[J] as TBtrieveTable).active
          then Result:=Application.Components[I].Components[J] as TBtrieveTable;
        end;
      end; // If Application.Components[I] is TForm (TDataModule) then begin
    end; // for I:=0 to Application.ComponentCount-1 do begin
  end;

var mFind:boolean;
    mINI:TInifile;
    mIndexName:String;
    mTable:TObject;
begin
  mFind:=False;
  If FileExists(gPath.RepPath+'REPIND.INI') then begin
    mINI:=TInifile.Create(gPath.RepPath+'REPIND.INI');
    mFind := mINI.ValueExists ('REPINDEX',oActRep);
    mIndexName:=mINI.ReadString('REPINDEX',oActRep,'');
  end;
  If mFind then begin
    mTable:=GetTableObj(pName);
    If mFind and (mTable<>NIL) then begin
      If mTable is TbtrieveTable then (mTable as TBtrieveTable).indexname:=mIndexname;
      If mTable is TTable then (mTable as TTable).indexname:=mIndexname;
    end;
  end;
end;

end.
