unit BtrUtilD_;

interface

uses
  LangForm, BtrUtilV_, NexPath, IcTools,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IcLabels, Buttons, IcButtons, IcInfoFields, ExtCtrls,
  ActnList, IcActionList;

type
  TF_BtrUtilD = class(TLangForm)
    NI_DBPath: TNameInfo;
    NI_DBName: TNameInfo;
    LI_RebNum: TLongInfo;
    B_Cancel: TSpecButton;
    RightLabel1: TRightLabel;
    RightLabel2: TRightLabel;
    RightLabel3: TRightLabel;
    GroupBox1: TGroupBox;
    LI_SrcQnt: TLongInfo;
    LI_ReadQnt: TLongInfo;
    LI_TrgQnt: TLongInfo;
    NI_RebName: TNameInfo;
    NI_RebDate: TNameInfo;
    NI_RebTime: TNameInfo;
    RightLabel4: TRightLabel;
    RightLabel5: TRightLabel;
    RightLabel6: TRightLabel;
    RightLabel7: TRightLabel;
    RightLabel8: TRightLabel;
    RightLabel9: TRightLabel;
    RightLabel10: TRightLabel;
    LI_CrtNum: TLongInfo;
    RightLabel11: TRightLabel;
    NI_CrtName: TNameInfo;
    RightLabel12: TRightLabel;
    NI_CrtDate: TNameInfo;
    NI_CrtTime: TNameInfo;
    RightLabel13: TRightLabel;
    BB_ViewDel: TBitBtn;
    IcActionList1: TIcActionList;
    A_Exit: TAction;
    procedure BB_ViewDelClick(Sender: TObject);
    procedure A_ExitExecute(Sender: TObject);
  private
    procedure FillData;
    { Private declarations }
  public
    procedure Execute;
    { Public declarations }
  end;

var
  F_BtrUtilD: TF_BtrUtilD;

implementation

  uses Dbs_F;
{$R *.dfm}

procedure TF_BtrUtilD.Execute;
var mS:string;
begin
  FillData;
  mS:=ExtractFileName (NI_DBName.Text);
  If Pos ('.',mS)>1 then Delete (mS,Pos ('.',mS),Length (mS));
  mS:=NI_DBPath.Text+mS+'.DEL';
  BB_ViewDel.Visible:=FileExists(mS);
  BB_ViewDel.Enabled:=BB_ViewDel.Visible;
  ShowModal;
end;

procedure TF_BtrUtilD.FillData;
begin
  NI_DBPath.Text :=  (Owner as TF_Dbs).bt_DBLst.FieldByName ('DBPath').AsString;
  NI_DBName.Text :=  (Owner as TF_Dbs).bt_DBLst.FieldByName ('DBName').AsString;
  LI_CrtNum.Long :=  (Owner as TF_Dbs).bt_DBLst.FieldByName ('CrtNum').AsInteger;
  NI_CrtName.Text :=  (Owner as TF_Dbs).bt_DBLst.FieldByName ('CrtName').AsString;
  NI_CrtDate.Text :=  (Owner as TF_Dbs).bt_DBLst.FieldByName ('CrtDate').AsString;
  NI_CrtTime.Text :=  (Owner as TF_Dbs).bt_DBLst.FieldByName ('CrtTime').AsString;
  LI_RebNum.Long :=  (Owner as TF_Dbs).bt_DBLst.FieldByName ('RebNum').AsInteger;
  LI_SrcQnt.Long :=  (Owner as TF_Dbs).bt_DBLst.FieldByName ('SrcQnt').AsInteger;
  LI_ReadQnt.Long :=  (Owner as TF_Dbs).bt_DBLst.FieldByName ('ReadQnt').AsInteger;
  LI_TrgQnt.Long :=  (Owner as TF_Dbs).bt_DBLst.FieldByName ('TrgQnt').AsInteger;
  NI_RebName.Text :=  (Owner as TF_Dbs).bt_DBLst.FieldByName ('RebName').AsString;
  NI_RebDate.Text :=  (Owner as TF_Dbs).bt_DBLst.FieldByName ('RebDate').AsString;
  NI_RebTime.Text :=  (Owner as TF_Dbs).bt_DBLst.FieldByName ('RebTime').AsString;
end;

procedure TF_BtrUtilD.BB_ViewDelClick(Sender: TObject);
var
  mTblName:string;
begin
  mTblName := ExtractFileName (NI_DBName.Text);
  If Pos ('.',mTblName)>1 then Delete (mTblName,Pos ('.',mTblName),Length (mTblName));
  If FileExists (gPath.DefPath+RemEndNumsDef (mTblName)+'.BDF') then begin
    F_BtrUtilV.ExecuteDel (NI_DBPath.Text,mTblName,'DEL');
  end else MessageDlg('**--** Pre databázový súbor'+#13+NI_DBPath.Text+mTblName+#13+'neexistuje definièný súbor'+#13+gPath.DefPath+RemEndNumsDef (mTblName)+'.BDF !', mtInformation, [mbOK], 0);
end;

procedure TF_BtrUtilD.A_ExitExecute(Sender: TObject);
begin
  Close;
end;

end.
