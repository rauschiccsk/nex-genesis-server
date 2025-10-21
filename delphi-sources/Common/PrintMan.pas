unit PrintMan;

interface

uses
  IcVariab, IcTypes, IcTools, IcEditors, NexPath, BtrTable,
  PrintMan_Report, Variants,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  FileCtrl, Printers, QuickRpt, QrExtra, QRexport,
  StdCtrls, Buttons, DbTables, Grids, DBGrids, ExtCtrls, Db, Spin,
  Dialogs, IniFIles;

type
  TF_PrintSlct = class(TForm)
    GroupBox1: TGroupBox;
    SE_FirstPage: TSpinEdit;
    SE_lastPage: TSpinEdit;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    GroupBox3: TGroupBox;
    Label3: TLabel;
    B_Convert: TBitBtn;
    E_DosRepFile: TEdit;
    GroupBox4: TGroupBox;
    CB_RepName: TComboBox;
    Label2: TLabel;
    E_Copies: TEdit;
    PrintDialog1: TPrintDialog;
    PrinterSetupDialog1: TPrinterSetupDialog;
    B_Print: TBitBtn;
    B_FormSize: TBitBtn;
    B_Preview: TBitBtn;
    BitBtn2: TBitBtn;
    E_RepFile: TEdit;
    E_RepExt: TEdit;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    procedure B_SlctPathClick(Sender: TObject);
    procedure B_ConvertClick(Sender: TObject);
    procedure B_PreviewClick(Sender: TObject);
    procedure B_SetupClick(Sender: TObject);
    procedure B_PrintClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CB_RepNameClick(Sender: TObject);
    procedure B_FormSizeClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
    oReports    : TStrings;
    oHead,oItem : TDataSet;
    
    procedure FindLastRepExt;
    procedure GetRepInfo;
  public
    { Public declarations }
    procedure SetRepBtr(pItem,pHead:TDataSet);
    procedure SetRepFile(pPath,pFile:string);
    procedure SettingComboBox;
  end;

var
  F_PrintSlct: TF_PrintSlct;
//  F_PrintManager: TF_PrintSlct;

 procedure ReportPrint (pReport:Str8; pHead,pItem:TDataSet);

implementation

uses
  DM_SYSTEM;

{$R *.DFM}

procedure ReportPrint (pReport:Str8; pHead,pItem:TDataSet);
begin
 if F_PrintSlct = nil then Application.CreateForm(TF_PrintSlct, F_PrintSlct);
 F_PrintSlct.SetRepBtr (pItem,pHead);
 F_PrintSlct.SetRepFile (gPath.RepPath,pReport);
end;

procedure TF_PrintSlct.FindlastRepExt;
begin
  If dmSYS.btLASTREP.Locate ('Username;DefMask',VarArrayOf([gvSys.LoginName,E_RepFile.text]), [loCaseInsensitive]) then begin
    E_RepExt.Text:=dmSYS.btLASTREP.FieldByName('MaskFile').AsString;
  end else begin
    E_RepExt.Text:='Q01';
  end;
  gvSys.LastRepExt:=E_RepExt.Text;
end;

procedure TF_PrintSlct.SettingComboBox;
var mSearchRec : TSearchRec;   mItem,mName: string;
    mIndex,mNum:integer;   mIniFile: TIniFile;
begin
  CB_RepName.Items.Clear;
  oReports.Clear;
//  If E_RepPath.Text[length(E_repPath.text)]<>'\' then E_RepPath.text:=E_RepPath.Text+'\';
  mNum:=0;mIndex:=0;
  If (0 = FindFirst(gPath.RepPath+E_RepFile.Text+'.*', faAnyFile-faVolumeID-faDirectory, mSearchRec)) then begin
    mIniFile := TIniFile.Create (gPath.RepPath+'REPNAMEQ.SYS');
    Repeat
      mItem:=UpperCase(Copy(mSearchrec.Name,Pos('.',mSearchrec.Name)+1,255));
      If mItem[1]= 'Q' then begin
        Inc (mNum);
//        AgyAppIni1.IniFileName:=E_RepPath.Text + 'REPNAMEQ.SYS';
//        AgyAppIni1.Section:=E_RepFile.Text;
        mName := mIniFIle.ReadString(E_RepFile.Text,mItem,'');
        If mName='' then begin
          mName:=E_RepFile.Text+'.'+mItem;
          mIniFile.WriteString(E_RepFile.Text,mItem,mName);
        end;
        oReports.Add(mItem);
        CB_RepName.Items.Add(mName);
      end else If mItem[1]= 'U' then begin
        Inc (mNum);
//        AgyAppIni1.IniFileName:=E_RepPath.Text + 'REPNAMEU.SYS';
//        AgyAppIni1.Section:=E_RepFile.Text;
        mName := mIniFIle.ReadString(E_RepFile.Text,mItem,'');
        If mName='' then begin
          mName := E_RepFile.Text+'.'+mItem;
          mIniFile.WriteString(E_RepFile.Text,mItem,mName);
        end;
        oReports.Add(mItem);
        CB_RepName.Items.Add(mname);
      end;
      If mItem=E_repExt.text then mIndex:=mNum;
    until (FindNext(mSearchRec) <> 0);
    mIniFile.Free;
  end;
  FindClose(mSearchRec);
  CB_RepName.ItemIndex:=mIndex-1;
end;

procedure TF_PrintSlct.SetRepBtr;
begin
  oHead := pHead;
  oItem := pItem;
end;

procedure TF_PrintSlct.SetRepFile;
begin
  E_DosRepFile.Text := pFile+'.R01';
  E_RepFile.Text := pFile;
//  E_RepPath.Text := RemLastBS(ppath);
  FindLastRepExt;
  SettingComboBox;
(*
  If oHead<>NIL then oHead.DisableControls;
  If oItem<>NIL then oItem.DisableControls;
  GetRepInfo;
  If oHead<>NIL then oHead.EnableControls;
  If oItem<>NIL then oItem.EnableControls;
*)  
  ShowModal;
end;

procedure TF_PrintSlct.GetRepInfo;
begin
  If F_Print = nil then Application.CreateForm(TF_RepPrint, F_Print);
  F_Print.Init(CB_RepName.text,oItem,oHead);
  F_Print.SetHeader(gPath.RepPath+'\'+E_RepFile.Text);
  F_Print.SetFirmName('GetFirmName');
  F_Print.SetReportQfile(gPath.RepPath,E_RepFile.Text+'.'+E_RepExt.Text);
  F_Print.SetSigno('REPGEN by IdentCode Consulting');
  F_Print.Prepare;
  SE_LastPage.MaxValue:=F_Print.GetPageNumber;
  SE_FirstPage.MaxValue:=SE_LastPage.MaxValue;
end;

procedure TF_PrintSlct.B_SlctPathClick(Sender: TObject);
var mDir: string;
begin
//  mDir := E_RepPath.Text;
//  If SelectDirectory('', '', mDir) then E_RepPath.Text := mDIR;
end;

procedure TF_PrintSlct.B_ConvertClick(Sender: TObject);
begin
  If F_Print = nil then Application.CreateForm(TF_RepPrint, F_Print);
  F_Print.Init(CB_RepName.text,oItem,oHead);
  F_Print.SetHeader(gPath.RepPath+'\'+E_DosRepFile.Text);
  F_Print.SetFirmName('GetFirmName');
  F_Print.SetReportfile(gPath.RepPath,E_DosRepFile.Text);
  F_Print.SetSigno('REPGEN by IdentCode Consulting');
  F_Print.Execute(gPath.RepPath,E_RepFile.Text);
  E_RepExt.Text:=gvSys.LastRepExt;
end;

procedure TF_PrintSlct.B_PreviewClick(Sender: TObject);
begin
  if F_Print = nil then Application.CreateForm(TF_RepPrint, F_Print);
  F_Print.Init(CB_RepName.text,oItem,oHead);
  F_Print.SetHeader(gPath.RepPath+'\'+E_RepFile.Text);
  F_Print.SetFirmName('GetFirmName');
  F_Print.SetReportQfile(gPath.RepPath,E_RepFile.Text+'.'+E_RepExt.Text);
  F_Print.SetSigno('REPGEN by IdentCode Consulting');
  F_Print.SetQuickRepPrinterSettings(StrToInt(E_Copies.text),Se_FirstPage.Value,SE_LastPage.Value);
//  F_Print.Prepare;
  F_Print.Preview;
end;

procedure TF_PrintSlct.B_SetupClick(Sender: TObject);
begin
  if F_Print = nil then Application.CreateForm(TF_RepPrint, F_Print);
  F_Print.Init(CB_RepName.text,oItem,oHead);
  F_Print.SetHeader(gPath.RepPath+'\'+E_RepFile.Text);
  F_Print.SetFirmName('GetFirmName');
  F_Print.SetReportQfile(gPath.RepPath,E_RepFile.Text+'.'+E_RepExt.Text);
  F_Print.SetSigno('REPGEN by IdentCode Consulting');
  F_Print.Execute(gPath.RepPath,E_RepFile.Text);
end;

procedure TF_PrintSlct.B_PrintClick(Sender: TObject);
begin
  if F_Print = nil then Application.CreateForm(TF_RepPrint, F_Print);
  F_Print.Init(CB_RepName.text,oItem,oHead);
  F_Print.SetHeader(gPath.RepPath+'\'+E_RepFile.Text);
  F_Print.SetFirmName('GetFirmName');
  F_Print.SetReportQfile(gPath.RepPath,E_RepFile.Text+'.'+E_RepExt.Text);
  F_Print.SetSigno('REPGEN by IdentCode Consulting');
//  F_Print.Prepare;

  F_Print.SetQuickRepPrinterSettings(StrToInt(E_Copies.text),Se_FirstPage.Value,SE_LastPage.Value);
{  If PrintDialog1.Execute then }F_Print.Print;
end;

procedure TF_PrintSlct.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  If dmSYS.btLASTREP.Locate ('Username;DefMask',VarArrayOf([gvSys.LoginName,E_RepFile.text]), [loCaseInsensitive])
    then dmSYS.btLASTREP.Edit
    else begin
      dmSYS.btLASTREP.Insert;
      dmSYS.btLASTREP.fieldbyname('UserName').AsString := gvSys.LoginName;
      dmSYS.btLASTREP.fieldbyname('DefMask').AsString := E_RepFile.Text;
    end;
  dmSYS.btLASTREP.Fieldbyname('MaskFile').AsString := E_RepExt.Text;
  dmSYS.btLASTREP.Post;
end;

procedure TF_PrintSlct.FormCreate(Sender: TObject);
begin
  Height := 200;

  dmSYS.btLASTREP.Open;
  oReports := TStringList.Create;
  FindLastRepExt;
  oHead := nil;
  oItem := nil;
end;

procedure TF_PrintSlct.FormActivate(Sender: TObject);
begin
  E_RepExt.Text := gvSys.LastRepExt;
  SettingComboBox;
end;

procedure TF_PrintSlct.FormDestroy(Sender: TObject);
begin
  oReports.Free;
end;

procedure TF_PrintSlct.CB_RepNameClick(Sender: TObject);
begin
  E_RepExt.Text := oReports[CB_RepName.ItemIndex];
  gvSys.LastRepExt := E_RepExt.Text;
end;

procedure TF_PrintSlct.B_FormSizeClick(Sender: TObject);
begin
  If Height=290
    then Height := 200
    else Height := 290;
end;

procedure TF_PrintSlct.BitBtn2Click(Sender: TObject);
begin
  PrinterSetupDialog1.Execute;
end;

procedure TF_PrintSlct.RadioButton1Click(Sender: TObject);
begin
  SE_FirstPage.Enabled:=RadioButton2.Checked;
  SE_LastPage.Enabled :=RadioButton2.Checked;
end;

procedure TF_PrintSlct.BitBtn3Click(Sender: TObject);
begin
  Close;
end;

end.
