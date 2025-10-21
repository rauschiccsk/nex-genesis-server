unit TableView_AddSet;

interface

uses
  IcTypes, IcConv, IcEditors, IcStand, NexMsg, LangForm,
  TableView_ActSet, TableView_GridSet,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, Db, Tabs;

type
  PFieldParam = ^TFieldParam;
  TFieldParam = record
     FieldName: Str20;
     CollumnName: Str30;
     CollumnSize: word;
     Alignment: TAlignment
  end;

  TF_AddSet = class(TLangForm)
    B_Save: TBitBtn;
    B_Cancel: TBitBtn;
    Bevel1: TBevel;
    E_SetHead: TEdit;
    Label3: TLabel;
    E_SetName: TEdit;
    LB_Database: TListBox;
    LB_Viewer: TListBox;
    Bevel2: TBevel;
    B_AddField: TBitBtn;
    L_VBoxHead: TLabel;
    L_DBoxHead: TLabel;
    B_RemoveField: TBitBtn;
    Label4: TLabel;
    Label5: TLabel;
    Bevel3: TBevel;
    GroupBox1: TGroupBox;
    RB_AlignRight: TRadioButton;
    RB_AlignLeft: TRadioButton;
    RB_AlignCenter: TRadioButton;
    Label1: TLabel;
    Label2: TLabel;
    L_SetNum: TLabel;
    P_AddSet: TDinamicPanel;
    E_CollumnName: TNameEdit;
    E_CollumnSize: TLongEdit;
    Label6: TLabel;
    Label7: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure B_CancelClick(Sender: TObject);
    procedure LB_DatabaserKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LB_ViewerKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure B_AddFieldClick(Sender: TObject);
    procedure B_RemoveFieldClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure B_SaveClick(Sender: TObject);
    procedure E_CollumnNameKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LB_ViewerEnter(Sender: TObject);
    procedure LB_DatabaseEnter(Sender: TObject);
    procedure LB_ViewerExit(Sender: TObject);
    procedure LB_DatabaseExit(Sender: TObject);
    procedure LB_ViewerClick(Sender: TObject);
    procedure RB_AligntClick(Sender: TObject);
    procedure E_CollumnNameSizeExit(Sender: TObject);
  private
    { Private declarations }
    oFieldList: TList;     // zoznam paramtrov databazovych poli
    oAddNewSet: boolean;   // TRUE ak bolo pridan0 nov0 nastavenie

    function GetSelectedViewItem: integer;
    function AllDataOk: boolean;
  public
    { Public declarations }
    procedure Execute (pDataSet:TDataSet);
    procedure NextSetNum;
    procedure LoadViewsData (pActSet:Str3); // Nacitanie udajov zobrazenych poli vieweru
    procedure AddFieldToViewer (pFieldName:Str20; pCollumnName:Str30; pCollumnSize:integer; pAlignment:TAlignment);
    function  AddNewSet: boolean;
  end;

var
  F_AddSet: TF_AddSet;

implementation

{$R *.DFM}
procedure TF_AddSet.Execute;
var mParam: PFieldParam;
    I:byte;
begin
  L_VBoxHead.Caption := Label6.Caption;
  L_DBoxHead.Caption := Label7.Caption;
  L_VBoxHead.Font.Size := Label6.Font.Size;
  L_DBoxHead.Font.Size := Label7.Font.Size;
  oAddNewSet := FALSE;
  For I:=0 to pDataSet.FieldCount-1 do begin
    If not LB_Viewer.Items.IndexOf (pDataSet.FieldList.Fields[I].FieldName)>-1
      then LB_Database.Items.Add (pDataSet.FieldList.Fields[I].FieldName);
  end;
  ShowModal;
  If oFieldList.Count>0 then begin
    For I:=0 to oFieldList.Count-1 do begin
      mParam := oFieldList.Items[I];
      Dispose(mParam);
    end;
  end;
end;

procedure TF_AddSet.NextSetNum;
begin
  L_SetNum.Caption := gGridSet.GetNextSetNum;
end;

procedure TF_AddSet.LoadViewsData (pActSet:Str3);
var mFieldQnt,mCnt:word;
begin
  L_SetNum.Caption := pActSet;
  E_SetName.Text := gGridSet.GetSetName (pActSet);
  E_SetHead.Text := gGridSet.ReadSetHead;
  LB_Viewer.Clear;
  mCnt := 0;
  mFieldQnt := gGridSet.ReadFieldQnt;
  Repeat
    Inc (mCnt);
    gGridSet.LoadField (mCnt);
    AddFieldToViewer (gGridSet.GetFieldName,gGridSet.GetCollumnNAme,gGridSet.GetCollumnSize,gGridSet.GetAlignMent);
  until (mCnt=mFieldQnt);
end;

procedure TF_AddSet.AddFieldToViewer (pFieldName:Str20; pCollumnName:Str30; pCollumnSize:integer; pAlignment:TAlignment);
var mParam: PFieldParam;
begin
  New (mParam);
  mParam^.FieldName := pFieldName;
  mParam^.CollumnName := pCollumnName;
  mParam^.CollumnSize := pCollumnSize;
  mParam^.Alignment := pAlignment;
  oFieldList.Add (mParam);
  LB_Viewer.Items.Add (pFieldName);
end;

function TF_AddSet.AddNewSet: boolean;
begin
  AddNewSet := oAddNewSet;
end;

function TF_AddSet.GetSelectedViewItem: integer;
var mFind: boolean;
    mCnt: integer;
begin
  mCnt := 0;
  Repeat
    mFind := LB_Viewer.Selected[mCnt];
    If not mFind then Inc (mCnt);
  until mFind or (mCnt=LB_Viewer.Items.Count);
  If mFind
    then GetSelectedViewItem := mCnt
    else GetSelectedViewItem := -1;
end;

function TF_AddSet.AllDataOk: boolean;
begin
  If (E_SetName.Text='') then ShowMsg (1,'');
  If (E_SetHead.Text='') then ShowMsg (2,'');
  If (LB_Viewer.Items.Count=0) then ShowMsg (3,'');
  AllDataOk := (E_SetName.Text<>'') and (E_SetHead.Text<>'') and (LB_Viewer.Items.Count>0);
end;

procedure TF_AddSet.B_CancelClick(Sender: TObject);
begin
  Close;
end;

procedure TF_AddSet.LB_DatabaserKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key=VK_RETURN then B_AddFieldClick (Self);
  If (Key=VK_ESCAPE) then Close;
end;

procedure TF_AddSet.LB_ViewerKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key=VK_DELETE then B_RemoveFieldClick (Self);
  If (Key=VK_ESCAPE) then Close;
end;

procedure TF_AddSet.KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var mForm:TCustomForm;
begin
  If (Key=VK_RETURN) or (Key=VK_DOWN) then begin
    mForm := GetParentForm(((Sender as TComponent).Owner as TControl));
    if (mForm <> nil ) then SendMessage(mForm.Handle, WM_NEXTDLGCTL, 0, 0);
  end;
  If (Key=VK_ESCAPE) then Close;
end;

procedure TF_AddSet.B_AddFieldClick(Sender: TObject);
var mCnt:byte;  mFind: boolean;
begin
  mCnt := 0;
  Repeat
    mFind := LB_Database.Selected[mCnt];
    If mFind then begin
      AddFieldToViewer (LB_Database.Items.Strings[mCnt],LB_Database.Items.Strings[mCnt],10,taRightJustify);
      LB_Database.Items.Delete(mCnt);
    end
    else Inc (mCnt);
  until (mCnt=LB_Database.Items.Count);
  LB_Database.SetFocus;
end;

procedure TF_AddSet.B_RemoveFieldClick(Sender: TObject);
var I:byte;
    mFind: boolean;
begin
  I := 0;
  Repeat
    mFind := LB_Viewer.Selected[I];
    If mFind then begin
      oFieldList.Delete(I);
      LB_Database.Items.Add (LB_Viewer.Items.Strings[I]);
      LB_Viewer.Items.Delete(I);
    end;
    Inc (I);
  until mFind or (I=LB_Viewer.Items.Count);
  LB_Viewer.SetFocus;
end;

procedure TF_AddSet.FormCreate(Sender: TObject);
begin
  oFieldList := TList.Create;
  oFieldList.Clear;
end;

procedure TF_AddSet.FormActivate(Sender: TObject);
begin
  LB_Database.SetFocus;
end;

procedure TF_AddSet.FormDestroy(Sender: TObject);
begin
  oFieldList.Free;
end;

procedure TF_AddSet.B_SaveClick(Sender: TObject);
var mParam: PFieldParam;
    I:word;
    mNewSet: boolean;    // TRUE ak je to nove nastavenie
begin
  If AllDataOk then begin
    oAddNewSet := TRUE;
    gGridSet.SetSection (L_SetNum.Caption);
    mNewSet := not gGridSet.SectionExists (L_SetNum.Caption);
    If not mNewSet then gGridSet.DeleteSection;
    gGridSet.oSetNums.Add (L_SetNum.Caption);
    gGridSet.oSetNames.Add (E_SetName.Text);
    gGridSet.SaveSetData;
    gGridSet.SaveFieldQnt (oFieldList.Count);
    gGridSet.SaveSetHead (E_SetHead.Text);
    For I:=0 to oFieldList.Count-1 do begin
      mParam := oFieldList.Items[I];
      gGridSet.SaveField (I+1,mParam^.FieldName,mParam^.CollumnName,mParam^.CollumnSize,mParam^.Alignment);
    end;
    Close;
  end;
end;

procedure TF_AddSet.E_CollumnNameKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  KeyDown (Self,Key,Shift);
end;

procedure TF_AddSet.LB_ViewerEnter(Sender: TObject);
begin
  L_VBoxHead.Color := clBlue;
end;

procedure TF_AddSet.LB_DatabaseEnter(Sender: TObject);
begin
  L_DBoxHead.Color := clBlue;
end;

procedure TF_AddSet.LB_ViewerExit(Sender: TObject);
begin
  L_VBoxHead.Color := clGrayText;
end;

procedure TF_AddSet.LB_DatabaseExit(Sender: TObject);
begin
  L_DBoxHead.Color := clGrayText;
end;

procedure TF_AddSet.LB_ViewerClick(Sender: TObject);
var mIndex: integer;
    mParam: PFieldParam;
begin
  mIndex := GetSelectedViewItem;
  If mIndex>-1 then begin
    mParam := oFieldList[mIndex];
    E_CollumnName.Text := mParam^.CollumnName;
    E_CollumnSize.Text := StrInt(mParam^.CollumnSize,0);
    case mParam^.Alignment of
      taRightJustify: RB_AlignRight.Checked := TRUE;
      taLeftJustify: RB_AlignLeft.Checked := TRUE;
      taCenter: RB_AlignCenter.Checked := TRUE;
    end;
  end;
end;

procedure TF_AddSet.RB_AligntClick(Sender: TObject);
var mIndex: integer;
    mParam: PFieldParam;
begin
  mIndex := GetSelectedViewItem;
  If mIndex>-1 then begin
    mParam := oFieldList[mIndex];
    If RB_AlignRight.Checked then mParam^.Alignment := taRightJustify;
    If RB_AlignLeft.Checked then mParam^.Alignment := taLeftJustify;
    If RB_AlignCenter.Checked then mParam^.Alignment := taCenter;
  end;
end;

procedure TF_AddSet.E_CollumnNameSizeExit(Sender: TObject);
var mIndex: integer;
    mParam: PFieldParam;
begin
  mIndex := GetSelectedViewItem;
  If mIndex>-1 then begin
    mParam := oFieldList[mIndex];
    mParam^.CollumnName := E_CollumnName.Text;
    mParam^.CollumnSize := ValInt(E_CollumnSize.Text);
  end;
end;

end.
