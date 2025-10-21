unit PrintMan_Report;

interface

uses
  IcFiles, IcVariab, IcConv, IcTools, FpTools, RepManager,PropertiesEditor, 
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, DBGrids, DBTables, quickrpt,
  QuickRep, Qrctrls, QrTee, QRPrntr, QRExport, Printers,
  TeEngine, Series,  TeeProcs, Buttons, IniHandle;

type

  TF_RepPrint = class(TForm)
    QR_Universal        : TIcQuickRep;
    QRB_ColumnHeader    : TIcQRBand;
    QRB_Title           : TIcQRBand;
    QRB_Detail          : TIcQRBand;
    QRB_PageFooter      : TIcQRBand;
    QRB_Summary         : TIcQRBand;
    QRB_PageHeader      : TIcQRBand;
    IH_RepFld: TIniHandle;
    RepManager1: TRepManager;
    QRTextFilter1: TQRTextFilter;
    QRCSVFilter1: TQRCSVFilter;
    QRHTMLFilter1: TQRHTMLFilter;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    oDateLabel          : string;
    oSigno              : string;
    oHeader             : string;
    oFirmName           : string;
    oLoginName          : string;

    opageCount,
    oQRShapeNum,
    oQRLabelNum,
    oQRSysDataNum,
    oQRExprNum,
    oActFieldNum,
    oActLeft,
    oActTop,
    oActWidth,
    oWidth: integer;
    oExecute: boolean;

    oAQRPCaption_First,
    oAQRPCaption_Prew,
    oAQRPCaption_Next,
    oAQRPCaption_Last,
    oAQRPCaption_PrinterSetup,
    oAQRPCaption_Print,
    oAQRPCaption_FullPage,
    oAQRPCaption_FullWidth: string; //1999.12.6.}
    oFHRow,oRHRow,oRIRow,oLFRow,oPFRow:byte;

    oHeadDS             : TDataSet;
    oPath,oRepname      : string;

  public
    { Public declarations }

    procedure Execute(pPath,pFile: string);
    procedure Init(pcaption:string;pItemDS,pHeadDS: TDataSet);
    procedure InitHorizontal(pItemDS: TDataSet);  //1997.11.6.
    procedure SetQRShape        (pQrBand:TQRBand;prow,pCol:integer);
    procedure SetQRLabel        (pQrBand:TQRBand;pName:string;prow,pCol:integer);
    procedure SetQRSysData      (pQrBand:TQRBand;pName:string;prow,pCol:integer;pWidth:integer;pShape:boolean);
    procedure SetField          (pField: TField;    pDataSource: TDataSet;pRow,pCol,pWidth:integer;pShape:boolean);
    procedure SetFieldSumm      (pField: TField;    pDataSource: TDataSet;pRow,pCol,pWidth:integer;pShape:boolean);
    procedure SetFieldEx        (pFieldName: string;pDataSource: TDataSet;pRow,pCol,pWidth:integer;pShape:boolean);
    procedure SetFieldExSum     (pFieldName: string;pDataSource: TDataSet;pRow,pCol,pWidth:integer;pShape:boolean);
    procedure SetFieldExCalc    (pFieldName: string;pDataSource: TDataSet;pRow,pCol,pWidth:integer;pShape:boolean);
    procedure SetFieldExCalcSum (pFieldName: string;pDataSource: TDataSet;pRow,pCol,pWidth:integer;pShape:boolean);

    procedure SetHeadEx    (pFieldName: string;pDataSource: TDataSet;pRow,pCol,pWidth:integer;pShape:boolean);
    procedure SetFootEx    (pFieldName: string;pDataSource: TDataSet;pRow,pCol,pWidth:integer;pShape:boolean);

    procedure SetDBGrid(pDBGrid: TDBGrid);
    procedure SetReportFile (pPath,pFile: string);
    procedure SetReportQfile(pPath,pFile: string);
    procedure Preview;
    procedure Print;
    procedure Prepare;
    procedure ProcessRep_FH(pStr:string);
    procedure ProcessRep_RH(pStr:string);
    procedure ProcessRep_RI(pStr:string);
    procedure ProcessRep_LF(pStr:string);
    procedure ProcessRep_PF(pStr:string);
    procedure SetAgyQRPreviewCaptions(pAQRPCaption_First,
                                      pAQRPCaption_Prew,
                                      pAQRPCaption_Next,
                                      pAQRPCaption_Last,
                                      pAQRPCaption_PrinterSetup,
                                      pAQRPCaption_Print,
                                      pAQRPCaption_FullPage,
                                      pAQRPCaption_FullWidth: string); //1999.12.6.
    procedure SetDateLabelCaption(pDateLabelCaption: string); //1999.12.6.
    procedure SetSigno(pSigno: string); //1997.10.27.
    procedure SetHeader(pHeader: string);
    procedure SetFirmName(pFirmName: string);
    procedure SetLoginName(pLoginName: string);
    procedure SetQuickRepPrinterSettings(pCopies,pFirstPage,pLastPage:integer);
    function  GetPageNumber:integer;

    procedure InitVariables;
//    function  FindMyFldName(pDS:TDataSet;pFldName:String):integer; presunute do ICConv 
    procedure RemoveComponents;
  end;


var
  F_Print: TF_RepPrint;

implementation

{$R *.DFM}


procedure TF_RepPrint.Execute;
begin
//  ShowWindow (Self.Handle,SW_Restore);
  oExecute:=TRUE;
  opath:=pPath;oRepName:=pFile;
  If oPath[Length(oPath)]='\' then Delete(oPath,Length(oPath),1);
  Show;
  If F_PropertiesEditor <> nil then F_PropertiesEditor.Show;

  RepManager1.FSFolder:=oPath;
  RepManager1.FSFileNameMask:=orepname;
  RepManager1.FSFileExtensionMask:='*';
  RepManager1.Execute (oHeadDS,QR_Universal.DataSet);
end;

procedure TF_RepPrint.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  If oExecute then begin
    RepManager1.EndExecute;
    If F_PropertiesEditor <> nil then F_PropertiesEditor.EndExecute;
  end;
end;

procedure TF_RepPrint.Preview;
  begin
{    if F_AgyQRPreview = nil then Application.CreateForm(TF_AgyQRPreview, F_AgyQRPreview);//1999.12.6.
    F_AgyQRPreview.SetStringsInForm(oAQRPCaption_First,
                                    oAQRPCaption_Next,
                                    oAQRPCaption_Prew,
                                    oAQRPCaption_Last,
                                    oAQRPCaption_PrinterSetup,
                                    oAQRPCaption_Print,
                                    oAQRPCaption_FullPage,
                                    oAQRPCaption_FullWidth);       //1999.12.6.
}
    QR_Universal.Preview;
//    F_AgyQRPreview.Showmodal;                                      //1999.12.6.
//    F_AgyQRPreview.Free;                                           //1999.12.6.
//    F_AgyQRPreview := nil;                                         //1999.12.6.
  end;

procedure TF_RepPrint.Print;
begin
  QR_Universal.Print;
end;

procedure TF_RepPrint.Prepare;
begin
  QR_Universal.Prepare;
  oPageCount:=QR_Universal.QRPrinter.PageCount;
end;

procedure TF_RepPrint.SetQuickRepPrinterSettings;
begin
{  QR_Universal.QRPrinter.Copies   :=pCopies;
  QR_Universal.QRPrinter.FirstPage:=pFirstPage;
  QR_Universal.QRPrinter.LastPage :=pLastpage;}
  { ktore treba ??? }
  QR_Universal.PrinterSettings.Copies   :=pCopies;
  QR_Universal.PrinterSettings.FirstPage:=pFirstPage;
  QR_Universal.PrinterSettings.LastPage :=pLastpage;
end;

function TF_RepPrint.GetPageNumber;
begin
  Result:=oPageCount;
end;

procedure TF_RepPrint.SetDateLabelCaption(pDateLabelCaption: string); //1999.12.6.
  begin
    oDateLabel := pDateLabelCaption;
  end;

(*
function  TF_RepPrint.FindMyFldName;
var i: integer;
begin
  i:=0;
  while (i<pDS.FieldCount)and (UpperCase(pDS.fields[i].FieldName)<>pFldName)
    do Inc(i);
  If (i>=pDS.FieldCount)or(UpperCase(pDS.fields[i].FieldName)<>pFldName) then i:=-1;
  Result:=i;
end;
*)
procedure TF_RepPrint.SetAgyQRPreviewCaptions; //1999.12.6.
  begin
    oAQRPCaption_First        := pAQRPCaption_First;
    oAQRPCaption_Prew         := pAQRPCaption_Prew;
    oAQRPCaption_Next         := pAQRPCaption_Next;
    oAQRPCaption_Last         := pAQRPCaption_Last;
    oAQRPCaption_PrinterSetup := pAQRPCaption_PrinterSetup;
    oAQRPCaption_Print        := pAQRPCaption_Print;
    oAQRPCaption_FullPage     := pAQRPCaption_FullPage;
    oAQRPCaption_FullWidth    := pAQRPCaption_FullWidth;
  end;

procedure TF_RepPrint.RemoveComponents;
  var
    i: integer;
    mComponent: TComponent;
  begin
    for i := ComponentCount-1 downto 0 do begin
      if Components[i] is TIcQRExpr then begin
        mComponent := Components[i];
        RemoveComponent(mComponent as TIcQRExpr);
        (mComponent as TIcQRExpr).Free;
      end else
      if Components[i] is TIcQRLabel then begin
        If Pos('QRLabel',(Components[i] as TIcQRLabel).name)>0 then begin
          mComponent := Components[i];
          RemoveComponent(mComponent as TIcQRLabel);
          (mComponent as TIcQRLabel).Free;
        end;
      end else
      if Components[i] is TIcQRSysData then begin
        If Pos('QRSysData',(Components[i] as TIcQRSysData).name)>0 then begin
          mComponent := Components[i];
          RemoveComponent(mComponent as TIcQRSysData);
          (mComponent as TIcQRSysData).Free;
        end;
      end else
      if Components[i] is TIcQRShape then begin
        If Pos('QRShape',(Components[i] as TIcQRShape).name)>0 then begin
          mComponent := Components[i];
          RemoveComponent(mComponent as TIcQRShape);
          (mComponent as TIcQRShape).Free;
        end;
      end else
      If Components[i] is TIcQrDBText then begin
          mComponent := Components[i];
          RemoveComponent(mComponent as TIcQrDBText);
          (mComponent as TIcQrDBText).Free;
      end;
    end;
  end;

procedure TF_RepPrint.InitVariables;
  begin
    oActFieldNum := 1;
    oQrSysDataNum := 1;
    oQrlabelNum := 1;
    oQrShapeNum := 1;
    oQrExprNum := 1;
    oActLeft := 3;
    oActWidth := 0;
    oPageCount := 0;
    oExecute := FALSE;
    oAQRPCaption_First := '';
    oAQRPCaption_Prew := '';
    oAQRPCaption_Next := '';
    oAQRPCaption_Last := '';
    oAQRPCaption_PrinterSetup := '';
    oAQRPCaption_Print := '';
    oAQRPCaption_FullPage := '';
    oAQRPCaption_FullWidth := '';
  end;

procedure TF_RepPrint.Init;
  begin
    Self.Caption:=pcaption;
    InitVariables;
    RemoveComponents;
    oHeadDS:=pHeadDS;
    QR_Universal.DataSet := pItemDS;
    oWidth := QRB_Detail.Width;
{
    QRS_ColumnHeader.Width  := oWidth;
    QRS_Title.Width := oWidth;
    QRS_Detail.Width := oWidth-1;
    QRBottomShape.Width  := oWidth;
    QRS_ColumnHeader.Height:=QRB_ColumnHeader.Height;
    QRS_Title.Height:=QRB_Title.Height;
    QRS_Detail.Height:=QRB_Detail.Height;
}
  end;

procedure TF_RepPrint.InitHorizontal(pItemDS: TDataSet);
  begin
    InitVariables;
    RemoveComponents;
    QR_Universal.DataSet := pItemDS;
    QR_Universal.Page.Orientation := poPortrait;//poLandscape;
    oWidth := QRB_Detail.Width;
{
    QRS_ColumnHeader.Width := oWidth;
    QRS_Title.Width := oWidth-1;
    QRS_Detail.Width := oWidth-1;
    QRBottomShape.Width := oWidth-1;
}
  end;

procedure TF_RepPrint.SetSigno;
begin
  oSigNo := pSigno;
end;

procedure TF_RepPrint.SetReportQfile;
var mDS:TDataSet;
begin
  oPath:=pPath;oRepname:=pFile;
  If not FileExists(oPath+'\'+orepname) then begin
//    If not FileExists(oPath+'\'+'DEF.QRF2')
//    then WriteComponentResFile(oPath+'\'+'DEF.QRF2',SELF);
    If FileExists(oPath+'\'+'DEF.QRF')
      then IcFiles.CopyFile (oPath+'\'+'DEF.QRF',oPath+'\'+oRepName);
  end;
  ShowWindow (Self.Handle,SW_Minimize);
  If oPath[Length(oPath)]='\' then Delete(oPath,Length(oPath),1);
  gvSys.LastRepExt := copy(oRepName,POS('.',oRepName)+1,255);
  If FileExists(oPath+'\'+orepname) then
  try
    mDS:=QR_Universal.DataSet;
    SELF.DestroyComponents;
    ReadComponentResFile(oPath+'\'+oRepName,SELF);
    QR_Universal.DataSet := mDS;
  except
    //
  end;
  ShowWindow (Self.Handle,SW_Restore);
  Hide;
end;

procedure TF_RepPrint.SetReportFile (pPath,pFile: string);
var mTx: TextFile;  mFldStr,mStr,mFld,s: string;
begin
  oPath:=pPath;oRepname:=pFile;
  If oPath[Length(oPath)]='\' then Delete(oPath,Length(oPath),1);
  If FileExists(pPath+'\'+pFile) then begin
    AssignFile (mTx,pPath+'\'+pFile); Reset(mTx);
    IH_RepFld.FileName := oPath+'\'+copy(pfile,1,1)+'REPFLD.INI';
    IH_RepFld.Section := copy(pfile,1,Pos('.',pFile)-1);
    While not Eof(mTx) do begin
      ReadLn (mTx,s);
      If (Pos('@',S)>0) and (Pos('^',S)=0) then begin
        mFld:=Copy(S,Pos('@',S)+1,1);
        mFldStr:=Copy(S,Pos('=',S)+1,255);
        If Pos(';',mFldStr)>0
          then mFldStr:=RemSpaces(Copy(mFldStr,1,Pos(';',mFldStr)-1));
        IH_RepFld.WriteString('@'+IntToStr(Ord(mFld[1])),mFldStr);
      end;
    end;
    Reset(mTx);
    oFHRow:=0;oRHRow:=0;oRIRow:=0;oLFRow:=0;oPFRow:=0;
    while not Eof(mTx) do begin
      ReadLn(mTx,s);
      mStr := UpperCase(S);
      If (Pos('^FH',mStr)>0) then Inc (oFHRow);
      If (Pos('^RH',mStr)>0) then Inc (oRHRow);
      If (Pos('^RI',mStr)>0) then Inc (oRIRow);
      If (Pos('^LF',mStr)>0) then Inc (oLFRow);
      If (Pos('^PF',mStr)>0) then Inc (oPFRow);
      If (Pos('^FH',mStr)>0) and (RemNonCharNum(mStr)<>'') then begin
        ProcessRep_FH(S);
      end else
      If (Pos('^RH',mStr)>0) and (RemNonCharNum(mStr)<>'') then begin
        ProcessRep_RH(S);
      end else
      If (Pos('^RI',mStr)>0) and (RemNonCharNum(mStr)<>'') then begin
        ProcessRep_RI(S);
      end else
      If (Pos('^LF',mStr)>0) and (RemNonCharNum(mStr)<>'') then begin
        ProcessRep_LF(S);
      end else
      If (Pos('^PF',mStr)>0) and (RemNonCharNum(mStr)<>'') then begin
        ProcessRep_PF(S);
      end else ;
    end;
    If QRB_ColumnHeader<>NIL then
    QRB_ColumnHeader.Height   :=(oRHRow+0)*GetTextHeight(QRB_ColumnHeader.Font,Self)+3;
    If QRB_Title<>NIL then
    QRB_Title.Height          :=(oFHRow+0)*GetTextHeight(QRB_Title.Font,Self)+3;
    If QRB_Detail<>NIL then
    QRB_Detail.Height         :=(oRIRow+0)*GetTextHeight(QRB_Detail.Font,Self)+3;
    If (QRB_Summary<>NIL) and (oLFRow>0) then
    QRB_Summary.Height        :=(oLFRow+0)*GetTextHeight(QRB_Summary.Font,Self)+5;
    If QRB_PageFooter<>NIL then
    QRB_Pagefooter.Height     :=(oPFRow+0)*GetTextHeight(QRB_PageFooter.Font,Self)+3;
{
    QRS_ColumnHeader.Height   :=QRB_ColumnHeader.Height;
    QRS_Title.Height          :=QRB_Title.Height;
    QRS_Detail.Height         :=QRB_Detail.Height;
}
    Closefile(mTx);
  end;
end;

procedure TF_RepPrint.SetDBGrid(pDBGrid: TDBGrid);
var I:integer;
begin
 For I:=0 to pDBGrid.FieldCount-1 do
   with pDBGrid.Fields[I] do begin
     if (Visible) and (DisplayWidth>1) then Self.SetField(pDBGrid.Fields[i],pDBGrid.DataSource.DataSet,0,0,0,TRUE);
   end;
end;

procedure TF_RepPrint.Processrep_RH;
var mStr,mOS,mSub,s: string;   mPos,mLen: byte;
begin
  s:=pStr;
  mStr:=S;
  mOS :=S;
  mStr:=Copy(S,4,255);
  If (RemNonCharNum(mStr)='')and (mStr<>'')
    then SetQrShape(QRB_ColumnHeader,oRHRow,0);
  If (RemNoncharNum(mStr)<>'') then begin
    mStr:=ReplaceNoncharNum(mStr,' ');
    mStr:=ReplaceStr(mStr,'  ','__');
    mPos:=1;
    While mPos<Length(mStr) do begin
      If mStr[mPos]<>'_' then begin
        mLen:=0;
        while (mPos+mLen<=Length(mStr))and (mStr[mPos+mLen]<>'_') do begin
          Inc(mLen);
        end;
        mSub:=Copy(mStr,mPos,mLen);
        Self.SetQRLabel(QRB_ColumnHeader,mSub,oRHRow,mPos);
        mPos:=mPos+mlen;
      end else Inc (mPos);
    end;
  end;
end;

procedure TF_RepPrint.Processrep_RI;
var
  i,j:integer;
  mCalcStr,mFldStr,mFldStr2,mFldName,mDBName,mStr,mOS,mFld,s:String;
  mPos,mLen:byte;
begin
  s:=pStr;
  mStr:=S;
  mOS :=S;
  mStr:=Copy(mStr,4,255);
  While POS('#',mStr)>0 do begin
    mPos:=POS('#',mStr);
    mFld:=mStr[mPos+1];
    mStr[mPos]:=mFld[1];mLen:=0;
    while (mStr[mPos+mLen]=mFld)or (mStr[mPos+mLen]='.') do begin
      mStr[mPos+mlen]:=' ';
      Inc(mLen);
    end;
    mFldStr:=IH_RepFld.ReadString('I'+IntToStr(Ord(mFld[1])),'');
    If Pos('-',mFldStr)>0  then begin
      mFldName:=Uppercase(Copy(mFldStr,Pos('-',mFldStr)+1,255));
      mDBName :=Uppercase(Copy(mFldStr,1,Pos('-',mFldStr)-1));
      i:=FindMyFldName(QR_Universal.DataSet,mFldName);
      If (i>=0) then begin
        Self.SetFieldEx(QR_Universal.DataSet.Fields[i].FieldName,QR_Universal.DataSet,oRIRow,mPos,mLen,TRUE);
      end;
    end else begin
      mFldName:='/\';
    end;
  end;
  While POS('@',mStr)>0 do begin
    mPos:=POS('@',mStr);
    mFld:=mStr[mPos+1];
    mStr[mPos]:=mFld[1];mLen:=0;
    while (mStr[mPos+mLen]=mFld)or (mStr[mPos+mLen]='.') do begin
      mStr[mPos+mlen]:=' ';
      Inc(mLen);
    end;
    mFldStr2:=IH_RepFld.ReadString('@'+IntToStr(Ord(mFld[1])),'');
    j:=0;mCalcStr:='';
    while j<Length(mFldStr2) do begin
       Inc (j);
      If mFldStr2[j]='#' then begin
        Inc (J);
        mFld:=mFldStr2[j];
        mFldStr:=IH_RepFld.ReadString('I'+IntToStr(Ord(mFld[1])),'');
        If Pos('-',mFldStr)>0  then begin
          mFldName:=Uppercase(Copy(mFldStr,Pos('-',mFldStr)+1,255));
          mDBName :=Uppercase(Copy(mFldStr,1,Pos('-',mFldStr)-1));
          i:=FindMyFldName(QR_Universal.DataSet,mFldName);
          If (i>=0) then begin
            mCalcStr:=mCalcStr+QR_Universal.DataSet.Name+'.'+QR_Universal.DataSet.Fields[i].FieldName;
          end;
        end else begin
          mFldName:='/\';
        end;
      end else mCalcStr:=mcalcStr+' '+mFldStr2[j]+' ';
    end;
    Self.SetFieldExCalc(mcalcStr,QR_Universal.DataSet,oRIRow,mPos,mLen,TRUE);
  end;
end;

procedure TF_RepPrint.Processrep_LF;
var
  i,j:integer;
  mCalcStr,mFldStr,mFldStr2,mFldName,mDBName,mStr,mOS,mSub,mFld,s:String;
  mPos,mLen:byte;
begin
  s:=pStr;
  mOS :=S;
  mStr:=Copy(S,4,255);
  If (RemNonCharNum(mStr)='')and (mStr<>'')
    then SetQrShape(QRB_Summary,oLFRow,0);
  While POS(#228,mStr)>0 do begin
    mPos:=POS(#228,mStr);
    mFld:=mStr[mPos+1];
    mStr[mPos]:=mFld[1];mLen:=0;
    while (mStr[mPos+mLen]=mFld)or (mStr[mPos+mLen]='.') do begin
      mStr[mPos+mlen]:=' ';
      Inc(mLen);
    end;
    mFldStr:=IH_RepFld.ReadString('I'+IntToStr(Ord(mFld[1])),'');
    If Pos('-',mFldStr)>0  then begin
      mFldName:=Uppercase(Copy(mFldStr,Pos('-',mFldStr)+1,255));
      mDBName :=Uppercase(Copy(mFldStr,1,Pos('-',mFldStr)-1));
      i:=FindMyFldName(QR_Universal.DataSet,mFldName);
      If (i>=0) then begin
        Self.SetFieldExSum(QR_Universal.DataSet.Fields[i].FieldName,QR_Universal.DataSet,oLFRow,mPos,mLen,TRUE);
      end;
    end else begin
      mFldName:='/\';
    end;
  end;
  While POS('$',mStr)>0 do begin
    mPos:=POS('$',mStr);
    mFld:=mStr[mPos+1];
    mStr[mPos]:=mFld[1];mLen:=0;
    while (mStr[mPos+mLen]=mFld)or (mStr[mPos+mLen]='.') do begin
      mStr[mPos+mlen]:=' ';
      Inc(mLen);
    end;
    mFldStr2:=IH_RepFld.ReadString('@'+IntToStr(Ord(mFld[1])),'');
    j:=0;mCalcStr:='';
    while j<Length(mFldStr2) do begin
       Inc (j);
      If mFldStr2[j]='#' then begin
        Inc (J);
        mFld:=mFldStr2[j];
        mFldStr:=IH_RepFld.ReadString('I'+IntToStr(Ord(mFld[1])),'');
        If Pos('-',mFldStr)>0  then begin
          mFldName:=Uppercase(Copy(mFldStr,Pos('-',mFldStr)+1,255));
          mDBName :=Uppercase(Copy(mFldStr,1,Pos('-',mFldStr)-1));
          i:=FindMyFldName(QR_Universal.DataSet,mFldName);
          If (i>=0) then begin
            mCalcStr:=mCalcStr+QR_Universal.DataSet.Name+'.'+QR_Universal.DataSet.Fields[i].FieldName;
          end;
        end else begin
          mFldName:='/\';
        end;
      end else mCalcStr:=mcalcStr+' '+mFldStr2[j]+' ';
    end;
    Self.SetFieldExCalcSum(mcalcStr,QR_Universal.DataSet,oLFRow,mPos,mLen,TRUE);
  end;
  While POS(#252,mStr)>0 do begin
    mPos:=POS(#252,mStr);
    mFld:=mStr[mPos+1];
    mStr[mPos]:=mFld[1];mLen:=0;
    while (mStr[mPos+mLen]=mFld)or (mStr[mPos+mLen]='.') do begin
      mStr[mPos+mlen]:=' ';
      Inc(mLen);
    end;
    mFldStr:=IH_RepFld.ReadString('H'+IntToStr(Ord(mFld[1])),'');
    If Pos('-',mFldStr)>0  then begin
      mFldName:=Uppercase(Copy(mFldStr,Pos('-',mFldStr)+1,255));
      mDBName :=Uppercase(Copy(mFldStr,1,Pos('-',mFldStr)-1));
      i:=FindMyFldName(oHeadDS,mFldName);
      If (i>=0) then begin
        Self.SetFootEx(oHeadDS.Fields[i].FieldName,oHeadDS,oLFRow,mPos,mLen,FALSE);
      end;
    end else begin
      mFldName:='/\';
    end;
  end;
  If (RemNoncharNum(mStr)<>'') then begin
    mStr:=ReplaceNoncharNum(mStr,' ');
    mStr:=ReplaceStr(mStr,'  ','__');
    mPos:=1;
    While mPos<Length(mStr) do begin
      If mStr[mPos]<>'_' then begin
        mLen:=0;
        while (mPos+mLen<=Length(mStr))and (mStr[mPos+mLen]<>'_') do begin
          Inc(mLen);
        end;
        mSub:=Copy(mStr,mPos,mLen);
        Self.SetQRLabel(QRB_Summary,mSub,oLFRow,mPos);
        mPos:=mPos+mlen;
      end else Inc (mPos);
    end;
  end;
end;

procedure TF_RepPrint.Processrep_FH;
var
  i:integer;
  mFldStr,mFldName,mDBName,mStr,mOS,mSub,mFld,s:String;
  mPos,mLen:byte;
begin
  s:=pStr;
  mStr:=Copy(S,4,255);
  mOS :=S;
  If (RemNonCharNum(mStr)='')and (mStr<>'')
    then SetQrShape(QRB_Title,oFHRow,0);
  While POS(#252,mStr)>0 do begin
    mPos:=POS(#252,mStr);
    mFld:=mStr[mPos+1];
    mStr[mPos]:=mFld[1];mLen:=0;
    while (mStr[mPos+mLen]=mFld)or (mStr[mPos+mLen]='.') do begin
      mStr[mPos+mlen]:=' ';
      Inc(mLen);
    end;
    mFldStr:=IH_RepFld.ReadString('H'+IntToStr(Ord(mFld[1])),'');
    If Pos('-',mFldStr)>0  then begin
      mFldName:=Uppercase(Copy(mFldStr,Pos('-',mFldStr)+1,255));
      mDBName :=Uppercase(Copy(mFldStr,1,Pos('-',mFldStr)-1));
      i:=FindMyFldName(oHeadDS,mFldName);
      If (i>=0) then begin
        Self.SetHeadEx(oHeadDS.Fields[i].FieldName,oHeadDS,oFHRow,mPos,mLen,FALSE);
      end;
    end else begin
      mFldName:='/\';
    end;
  end;
  While POS('#',mStr)>0 do begin
    mPos:=POS('#',mStr);
    mFld:=mStr[mPos+1];
    mStr[mPos]:=mFld[1];mLen:=0;
    while (mStr[mPos+mLen]=mFld)or (mStr[mPos+mLen]='.') do begin
      mStr[mPos+mlen]:=' ';
      Inc(mLen);
    end;
    case mFld[1] of
      '0' : Self.SetQRLabel(QRB_Title,oFirmName,oFHRow,mPos);
      '4' : Self.SetQRLabel(QRB_Title,oLoginName,oFHRow,mPos);
      '1','2','3','5','7','8' : SetQRSYSData(QRB_Title,mFld,oFHRow,mPos,mLen,FALSE);
    end;
  end;
  If (RemNoncharNum(mStr)<>'') then begin
    mStr:=ReplaceNoncharNum(mStr,' ');
    mStr:=ReplaceStr(mStr,'  ','__');
    mPos:=1;
    While mPos<Length(mStr) do begin
      If mStr[mPos]<>'_' then begin
        mLen:=0;
        while (mPos+mLen<=Length(mStr))and (mStr[mPos+mLen]<>'_') do begin
          Inc(mLen);
        end;
        mSub:=Copy(mStr,mPos,mLen);
        Self.SetQRLabel(QRB_Title,mSub,oFHRow,mPos);
        mPos:=mPos+mlen;
      end else Inc (mPos);
    end;
  end;
end;

procedure TF_RepPrint.Processrep_PF;
var
  mStr,mOS,mSub,mFld,s:String;
  mPos,mLen:byte;
begin
  s:=pStr;
  mOS :=S;
  mStr:=Copy(S,4,255);
  If (RemNonCharNum(mStr)='')and (mStr<>'')
    then SetQrShape(QRB_PageFooter,oPFRow,0);
  While POS('#',mStr)>0 do begin
    mPos:=POS('#',mStr);
    mFld:=mStr[mPos+1];
    mStr[mPos]:=mFld[1];mLen:=0;
    while (mStr[mPos+mLen]=mFld)or (mStr[mPos+mLen]='.') do begin
      mStr[mPos+mlen]:=' ';
      Inc(mLen);
    end;
    case mFld[1] of
      '0' : Self.SetQRLabel(QRB_PageFooter,oFirmName,oPFRow,mPos);
      '4' : Self.SetQRLabel(QRB_PageFooter,oLoginName,oPFRow,mPos);
      '1','2','3','5','7','8' : SetQRSYSData(QRB_PageFooter,mFld,oPFRow,mPos,mLen,FALSE);
    end;
  end;
  If (RemNoncharNum(mStr)<>'') then begin
    mStr:=ReplaceNoncharNum(mStr,' ');
    mStr:=ReplaceStr(mStr,'  ','__');
    mPos:=1;
    While mPos<Length(mStr) do begin
      If mStr[mPos]<>'_' then begin
        mLen:=0;
        while (mPos+mLen<=Length(mStr))and (mStr[mPos+mLen]<>'_') do begin
          Inc(mLen);
        end;
        mSub:=Copy(mStr,mPos,mLen);
        Self.SetQRLabel(QRB_PageFooter,mSub,oPFRow,mPos);
        mPos:=mPos+mlen;
      end else Inc (mPos);
    end;
  end;
end;

procedure TF_RepPrint.SetField;
begin
  SetFieldEx(pField.FieldName,pDataSource,pRow,pCol,pWidth,pShape);
end;

procedure TF_RepPrint.SetFieldSumm;
begin
  SetFieldExSum(pField.FieldName, pDataSource,pRow,pCol,pWidth,pShape);
end;

procedure TF_RepPrint.SetHeader;
begin
  oHeader:= pHeader;
end;

procedure TF_RepPrint.SetFirmName;
begin
  oFirmName := pFirmName;
end;

procedure TF_RepPrint.SetLoginName;
begin
  oLoginName := pLoginName;
end;

procedure TF_RepPrint.SetQrlabel;
var mQRLabel: TIcQRLabel;
begin
  If ((pCol+Length(pName)) *GetTextWidth('H',pQRBand.Font,Self)  > oWidth) then Exit;
  oActWidth :=Length(pName)*GetTextWidth('H',pQRBand.Font,Self);
  oActLeft :=(pCol-1)*GetTextWidth ('H',pQRBand.Font,Self)+3;
  oActTop  :=(pRow-1)*GetTextHeight(    pQRBand.Font,Self)+3;
  mQRLabel := nil;
  mQRLabel := TIcQRLabel.Create (Self);
  if mQRLabel <> nil then begin
    mQRLabel.Parent           := pQRBand;
    mQRLabel.Name             := 'QRLabel' + IntToStr(oQrLabelNum);
    mQRLabel.ParentFont       := TRUE;
    mQRLabel.AutoSize         := TRUE;//FALSE;
//      mQRLabel.AutoStretch      := TRUE;
    mQRLabel.Caption          := DosStrToWinStr(pName);
    mQRLabel.Font.Style       := [fsBold];
    mQRLabel.Left             := oActLeft;
    mQRLabel.Top              := oActTop;
    mQRLabel.Width            := Length(pName)*GetTextWidth('H',pQRBand.Font,Self);
    mQRLabel.Width            := GetTextWidth(pName+'H',pQRBand.Font,Self);
    mQRLabel.Alignment        := taCenter;
    mQRLabel.Enabled          := TRUE;
  end;
  {
  mQRShape := nil;
  mQRShape := TAgyQRShape.Create(self);
  if mQRShape <> nil then begin
    mQRShape.Parent   := pQRBand;
//        mQRShape.Shape    := qrsRectangle
    mQRShape.Name     := 'QRShape' + IntToStr(oQrShapeNum);
    mQRShape.Top      := oActTop  - 3;
    mQRShape.Left     := oActLeft - 3;
    mQRShape.Width    := 1;
    mQRShape.Enabled  := TRUE;
  end;
  Inc (oQrShapeNum);
  }
  Inc (oQrLabelNum);
end;

procedure TF_RepPrint.SetFieldEx;
var mQRLabel: TIcQRLabel;
    mQRShape: TIcQRShape;
    mQRDBText: TIcQrDBText;
begin
  If (((pCol-1+pWidth)*GetTextWidth('H',QRB_Detail.Font,Self)  > oWidth)) then Exit;
  oActWidth := GetTextWidth ('H',QRB_Detail.Font,Self)*pWidth;
  oActLeft  := GetTextWidth ('H',QRB_Detail.Font,Self)*(pCol-1)+3;
  oActTop   := GetTextHeight(    QRB_Detail.Font,Self)*(pRow-1)+3;

  If pShape then begin
    mQRShape := nil;
    mQRShape := TIcQRShape.Create(self);
    if mQRShape <> nil then begin
      mQRShape.Parent   := QRB_Detail;
//        mQRShape.Shape    := qrsRectangle
      mQRShape.Name     := 'QRShape' + IntToStr(oQRShapeNum);
      mQRShape.Top      := oActTop  - 3;
      mQRShape.Left     := oActLeft - 3;
      mQRShape.Width    := 1;
      mQRShape.Enabled  := TRUE;
      mQRShape.height   := GetTextHeight(QRB_Detail.Font,Self)+3;
    end;
    Inc (oQRShapeNum);
  end;

  mQRDBText:=NIL;
  mQRDBText := TIcQrDBText.Create(self);
  if mQRDBText <> nil then begin
    mQRDBText.Parent    := QRB_Detail;
    mQRDBText.Name      := 'QRDBText' + IntToStr(oActFieldNum);
    mQRDBText.DataSet   := pDataSource;
    mQRDBText.DataField := pFieldName;
    mQRDBText.AutoSize  := FALSE;
//      mQRDBText.AutoStretch := TRUE;
    mQRDBText.Left      := oActLeft;
    mQrDBText.Top       := oActTop-2;
    mQRDBText.Width     := oActWidth;
    mQRDBText.Alignment := (pDataSource as TDataSet).FieldByName(pFieldName).Alignment;
    mQRDBText.Enabled   := TRUE;
  end;

  inc(oActFieldNum);
end;

procedure TF_RepPrint.SetFieldExCalc;
var mQRExpr: TIcQRExpr;
begin
  if (((pCol-1+pWidth)*GetTextWidth('H',QRB_Detail.Font,Self)  > oWidth)) then Exit;
  try
    oActWidth := GetTextWidth ('H',QRB_Detail.Font,Self)*pWidth;
    oActLeft  := GetTextWidth ('H',QRB_Detail.Font,Self)*(pCol-1)+3;
    oActTop   := GetTextHeight(    QRB_Detail.Font,Self)*(pRow-1)+3;

    mQRExpr := TIcQRExpr.Create(self);
    mQRExpr.Parent := QRB_Detail;
    mQRExpr.Name := 'QRExpr' + IntToStr(oQRExprNum);
    mQRExpr.Alignment := taRightJustify;
    mQRExpr.AutoSize  := FALSE;
    mQRExpr.AutoStretch := TRUE;
    mQRExpr.Top       := oActTop   - 2;
    mQRExpr.Left      := oActLeft;
    mQRExpr.Width     := oActWidth;
    mQRExpr.Font      := QRB_Detail.Font;
    mQRExpr.Font.Style := [fsBold];
    mQRExpr.Mask := '### ### ###.00   ';
    mQRExpr.Expression := pFieldName;
  finally
//      SetFieldEx(pFieldName, pDataSource,prow,pCol,pWidth,pShape);
    Inc(oQrExprNum);
  end;
end;

procedure TF_RepPrint.SetFieldExSum;
var mQRExpr: TIcQRExpr;
begin
  QRB_Summary.Enabled := TRUE;
  try
    If (((pCol-1+pWidth)*GetTextWidth('H',QRB_Summary.Font,Self)  > oWidth)) then Exit;
    oActWidth := GetTextWidth ('H',QRB_Summary.Font,Self)*pWidth;
    oActLeft  := GetTextWidth ('H',QRB_Summary.Font,Self)*(pCol-1)+3;
    oActTop   := GetTextHeight(    QRB_Summary.Font,Self)*(pRow-1)+3;

    mQRExpr := TIcQRExpr.Create(self);
    mQRExpr.Parent := QRB_Summary;
    mQRExpr.Name := 'QRExpr' + IntToStr(oQRExprNum);
    mQRExpr.Alignment := taRightJustify;
    mQRExpr.AutoSize  := FALSE;
    mQRExpr.AutoStretch := TRUE;
    mQRExpr.Top       := oActTop-2;
    mQRExpr.Left      := oActLeft;
    mQRExpr.Width     := oActWidth;
    mQRExpr.Font      := QRB_Summary.Font;
    mQRExpr.Font.Style := [fsBold];
    mQRExpr.Mask := '# ### ###.00   ';
    mQRExpr.Expression := 'SUM('+pDataSource.Name+'.'+pFieldName+')';
  finally
//      SetFieldEx(pFieldName, pDataSource,prow,pCol,pWidth,pShape);
    Inc(oQrExprNum);
  end;
end;

procedure TF_RepPrint.SetFieldExCalcSum;
var mQRExpr: TIcQRExpr;
begin
  QRB_Summary.Enabled := TRUE;
  try
    if (((pCol-1+pWidth)*GetTextWidth('H',QRB_Summary.Font,Self)  > oWidth)) then Exit;
    oActWidth := GetTextWidth ('H',QRB_Summary.Font,Self)*pWidth;
    oActLeft  := GetTextWidth ('H',QRB_Summary.Font,Self)*(pCol-1)+3;
    oActTop   := GetTextHeight(    QRB_Summary.Font,Self)*(pRow-1)+3;

    mQRExpr := TIcQRExpr.Create(self);
    mQRExpr.Parent := QRB_Summary;
    mQRExpr.Name := 'QRExpr' + IntToStr(oQRExprNum);
    mQRExpr.Alignment := taRightJustify;
    mQRExpr.AutoSize  := FALSE;
    mQRExpr.AutoStretch := TRUE;
    mQRExpr.Top       := oActTop-2;
    mQRExpr.Left      := oActLeft;
    mQRExpr.Width     := oActWidth;
    mQRExpr.Font      := QRB_Summary.Font;
    mQRExpr.Font.Style := [fsBold];
    mQRExpr.Mask := '# ### ###.00   ';
    mQRExpr.Expression := 'SUM('+pFieldName+')';
  finally
//      SetFieldEx(pFieldName, pDataSource,prow,pCol,pWidth,pShape);
    Inc(oQrExprNum);
  end;
end;

// header FLD's

procedure TF_RepPrint.SetHeadEx;
var mQRLabel:  TIcQRLabel;
    mQRShape:  TIcQRShape;
    mQRDBText: TIcQrDBText;
begin
  If (((pCol-1+pWidth)*GetTextWidth('H',QRB_Title.Font,Self)  > oWidth)) then Exit;
  oActWidth := GetTextWidth ('H',QRB_Title.Font,Self)*pWidth;
  oActLeft  := GetTextWidth ('H',QRB_Title.Font,Self)*(pCol-1)+3;
  oActTop   := GetTextHeight(    QRB_Title.Font,Self)*(pRow-1)+3;

  If pShape then begin
    mQRShape := nil;
    mQRShape := TIcQRShape.Create(self);
    if mQRShape <> nil then begin
      mQRShape.Parent   := QRB_Title;
      mQRShape.Name     := 'QRShape' + IntToStr(oQRShapeNum);
      mQRShape.Top      := oActTop  - 3;
      mQRShape.Left     := oActLeft - 3;
      mQRShape.Width    := 1;
      mQRShape.Enabled  := TRUE;
      mQRShape.height   := GetTextHeight(QRB_Title.Font,Self)+3;
    end;
    Inc(oQRShapeNum);
  end;

  mQRDBText:=NIL;
  mQRDBText := TIcQrDBText.Create(self);
  if mQRDBText <> nil then begin
    mQRDBText.Parent    := QRB_Title;
    mQRDBText.Name      := 'QRDBText' + IntToStr(oActFieldNum);
    mQRDBText.DataSet   := pDataSource;
    mQRDBText.DataField := pFieldName;
    mQRDBText.AutoSize  := FALSE;
//      mQRDBText.AutoStretch := TRUE;
    mQRDBText.Left      := oActLeft;
    mQrDBText.Top       := oActTop-2;
    mQRDBText.Width     := oActWidth;
    mQRDBText.Alignment := (pDataSource as TDataSet).FieldByName(pFieldName).Alignment;
    mQRDBText.Enabled   := TRUE;
  end;

  inc(oActFieldNum);
end;


procedure TF_RepPrint.SetFootEx;
var mQRLabel:  TIcQRLabel;
    mQRShape:  TIcQRShape;
    mQRDBText: TIcQrDBText;
begin
  if (((pCol-1+pWidth)*GetTextWidth('H',QRB_Summary.Font,Self)  > oWidth)) then Exit;
  oActWidth := GetTextWidth ('H',QRB_Summary.Font,Self)*pWidth;
  oActLeft  := GetTextWidth ('H',QRB_Summary.Font,Self)*(pCol-1)+3;
  oActTop   := GetTextHeight(    QRB_Summary.Font,Self)*(pRow-1)+3;

  If pShape then begin
    mQRShape := nil;
    mQRShape := TIcQRShape.Create(self);
    if mQRShape <> nil then begin
      mQRShape.Parent   := QRB_Summary;
      mQRShape.Name     := 'QRShape' + IntToStr(oQrShapeNum);
//        mQRShape.Shape    := qrsRectangle
      mQRShape.Top      := oActTop  - 3;
      mQRShape.Left     := oActLeft - 3;
      mQRShape.Width    := 1;
      mQRShape.Enabled  := TRUE;
      mQRShape.height   := GetTextHeight(QRB_Summary.Font,Self)+3;
    end;
    Inc (oQRShapeNum);
  end;

  mQRDBText:=NIL;
  mQRDBText := TIcQrDBText.Create(self);
  if mQRDBText <> nil then begin
    mQRDBText.Parent    := QRB_Summary;
    mQRDBText.Name      := 'QRDBText' + IntToStr(oActFieldNum);
    mQRDBText.DataSet   := pDataSource;
    mQRDBText.DataField := pFieldName;
    mQRDBText.AutoSize  := FALSE;
//      mQRDBText.AutoStretch := TRUE;
    mQRDBText.Left      := oActLeft;
    mQrDBText.Top       := oActTop-2;
    mQRDBText.Width     := oActWidth;
    mQRDBText.Alignment := (pDataSource as TDataSet).FieldByName(pFieldName).Alignment;
    mQRDBText.Enabled   := TRUE;
  end;

  inc(oActFieldNum);
end;

procedure TF_RepPrint.SetQRSysData;
var mQRSysData : TIcQRSysData;
    mQRShape : TIcQRShape;
begin
  if ((pCol+Length(pName)) *GetTextWidth('H',pQRBand.Font,Self)  > oWidth) then Exit;
  oActWidth :=Length(pName)*GetTextWidth('H',pQRBand.Font,Self);
  oActLeft :=(pCol-1)*GetTextWidth ('H',pQRBand.Font,Self)+3;
  oActTop  :=(pRow-1)*GetTextHeight(    pQRBand.Font,Self)+3;
  mQRSysData := nil;
  mQRSysData := TIcQRSysData.Create(self);
  if mQRSysData <> nil then begin
    mQRSysData.Parent         := pQRBand;
    case pName[1] of
      '1': mQRSysData.Data           := qrsDateTime;
      '2': mQRSysData.Data           := qrsDate;
      '3': mQRSysData.Data           := qrsTime;
      '4': ;
      '5': mQRSysData.Data           := qrsPageNumber;
      '6': ;
      '7': mQRSysData.Data           := qrsDetailNo;
      '8': mQRSysData.Data           := qrsDetailCount;
    end;
    mQRSysData.Name           := 'QRSysData' + IntToStr(oQrSysDataNum);
    mQRSysData.ParentFont     := TRUE;
    mQRSysData.AutoSize       := TRUE;//FALSE;
//      mQRSysData.AutoStretch      := TRUE;
    mQRSysData.Font.Style     := [fsBold];
    mQRSysData.Left           := oActLeft;
    mQRSysData.Top            := oActTop;
    mQRSysData.Width          := pWidth*GetTextWidth('H',pQRBand.Font,Self);
    mQRSysData.Alignment      := taCenter;
    mQRSysData.Enabled        := TRUE;
  end;
  {
  mQRShape := nil;
  mQRShape := TAgyQRShape.Create(self);
  if mQRShape <> nil then begin
    mQRShape.Parent   := pQRBand;
    mQRShape.Name     := 'QRShape' + IntToStr(oQRShapeNum);
    mQRShape.Top      := oActTop  - 3;
    mQRShape.Left     := oActLeft - 3;
    mQRShape.Width    := 1;
    mQRShape.Enabled  := TRUE;
  end;
  Inc (oQRShapeNum);
  }
  Inc (oQrSysDataNum);
end;

procedure TF_RepPrint.SetQRShape;
var mQRShape: TIcQRShape;
begin
  oActLeft :=(pCol)*GetTextWidth ('H',pQRBand.Font,Self);
  oActTop  :=(pRow-1)*GetTextHeight(    pQRBand.Font,Self);
  mQRShape := nil;
  mQRShape := TIcQRShape.Create(self);
  if mQRShape <> nil then begin
    mQRShape.Parent   := pQRBand;
    mQRShape.Shape    := qrsHorLine;
    mQRShape.Name     := 'QRShape' + IntToStr(oQrShapeNum);
    mQRShape.Top      := oActTop;
    mQRShape.Left     := oActLeft+2;
    mQRShape.Width    := oWidth-oActLeft-2;
    mQRShape.Height   := GetTextHeight(    pQRBand.Font,Self)+3;
    mQRShape.Enabled  := TRUE;
  end;
  Inc (oQrShapeNum);
end;

end.
