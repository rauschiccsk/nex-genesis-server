unit AdvGrid_GridDef;

interface

uses
  AdvGrid_GridSet, AdvGrid_ColText,
  IcConv, IcTools, CompTxt,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,DB,
  StdCtrls, Buttons, ExtCtrls, IcInfoFields, ActnList;

type
  TF_GridDef = class(TForm)
    LB_Default: TListBox;
    L_Show: TLabel;
    SB_Up: TSpeedButton;
    SB_Down: TSpeedButton;
    BB_Save: TBitBtn;
    BB_Exit: TBitBtn;
    GB_DGD: TGroupBox;
    L_ReadOnly: TLabel;
    L_Format: TLabel;
    L_Alignment: TLabel;
    L_Width: TLabel;
    L_Name: TLabel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Bevel7: TBevel;
    L_DisplayWidth: TLabel;
    L_DisplayWidthChar: TLabel;
    E_DisplayName: TEdit;
    E_DisplayWidth: TEdit;
    CB_Alignment: TComboBox;
    CB_Format: TComboBox;
    CB_EditFld: TComboBox;
    E_DisplayWidthChar: TEdit;
    BB_RefreshFld: TButton;
    NI_FullName: TNameInfo;
    B_ColText: TButton;
    ActionList1: TActionList;
    Action1: TAction;
    procedure LB_DefaultDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure LB_DefaultDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure FldEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SB_DownClick(Sender: TObject);
    procedure CB_EditFldKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LB_DefaultClick(Sender: TObject);
    procedure SB_UpClick(Sender: TObject);
    procedure E_DisplayWidthExit(Sender: TObject);
    procedure E_DisplayWidthCharExit(Sender: TObject);
    procedure BB_SaveClick(Sender: TObject);
    procedure FldEditExit(Sender: TObject);
    procedure BB_ExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BB_RefreshFldClick(Sender: TObject);
    procedure B_ColTextClick(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure L_NameDblClick(Sender: TObject);
  private
    oGridSet  : TGridSet;
    oFontSize : integer;
    oDataSet  : TDataSet;
    oDGDName  : string;

    procedure FillDefList;
    procedure FillFldData;
    procedure RefreshDefList;
    function  FieldInDefault (pFld:string):boolean;
    { Private declarations }
  public
    function  Execute (pDGDName:string;pFontSize:integer;pDataSet:TDataSet):integer;
    { Public declarations }
  end;

var
  F_GridDef: TF_GridDef;

implementation

{$R *.DFM}

function  TF_GridDef.Execute (pDGDName:string;pFontSize:integer;pDataSet:TDataSet):integer;
begin
  oDGDName := pDGDName;
  oDataSet := pDataSet;
  oFontSize := pFontSize;
  oGridSet := TGridSet.Create;
  oGridSet.SetDGDName (pDGDName);
  oGridSet.ReadDefault;
  FillDefList;
  FillFldData;
  GB_DGD.Caption := ExtractFileName (pDGDName);
  ShowModal;
  oGridSet.Free;
end;

procedure TF_GridDef.LB_DefaultDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  mRect:TRect;
  mNewPos:TPoint;
  mIndex:integer;
begin
  If (Sender is TListBox) and (Source is TListBox) then begin
    If (Source as TListBox).Name='LB_Default' then begin
      mRect := LB_Default.ItemRect(LB_Default.ItemIndex);
      mNewPos.X := X;
      mNewPos.Y := Y;
      mIndex := LB_Default.ItemIndex;
      LB_Default.ItemIndex := LB_Default.ItemAtPos (mNewPos,TRUE);
      LB_Default.Items.Move (mIndex,LB_Default.ItemIndex);
      oGridSet.oDefGrid.Move (mIndex,LB_Default.ItemIndex);
      LB_Default.Selected[LB_Default.ItemIndex] := TRUE;
    end;
  end;
end;

procedure TF_GridDef.LB_DefaultDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept := Source is TListBox;
end;

procedure TF_GridDef.FldEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var mForm:TCustomForm;
begin
  case Key of
    VK_RETURN: begin
      mForm := GetParentForm (Self);
      If (Key = VK_RETURN) then SendMessage (mForm.Handle,WM_NEXTDLGCTL,0,0);
    end;
    VK_ESCAPE: Close;
  end;
end;

procedure TF_GridDef.SB_DownClick(Sender: TObject);
var mIt:integer;
begin
  If (LB_Default.ItemIndex>=0) and (LB_Default.ItemIndex<LB_Default.Items.Count-1) then begin
    mIt := LB_Default.ItemIndex;
    LB_Default.Items.Move (mIt,mIt+1);
    oGridSet.oDefGrid.Move (mIt,mIt+1);
    LB_Default.ItemIndex := mIt+1;
    LB_Default.Selected[LB_Default.ItemIndex] := TRUE;
  end;
end;

procedure TF_GridDef.CB_EditFldKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: LB_Default.SetFocus;
    VK_ESCAPE: Close;
  end;
end;

procedure TF_GridDef.LB_DefaultClick(Sender: TObject);
begin
  FillFldData;
end;

procedure TF_GridDef.FillDefList;
var
  I:integer;
  mS:string;
begin
  LB_Default.Clear;
  If oGridSet.oDefGrid.Count>0 then begin
    For I:=0 to oGridSet.oDefGrid.Count-1 do begin
      mS := oGridSet.oDefGrid.Strings[I];
      mS := Copy (mS,1,Pos (',',mS)-1);
      LB_Default.Items.Add (mS);
    end;
  end;
  LB_Default.ItemIndex := 0;
  LB_Default.Selected[LB_Default.ItemIndex] := TRUE;
end;

procedure TF_GridDef.FillFldData;
var
  mS:string;
  mAlign:string;
begin
  If LB_Default.ItemIndex>=0 then begin
    mS := oGridSet.oDefGrid.Strings[LB_Default.ItemIndex];
    mS := Copy (mS,Pos ('=',mS)+1,Length (mS));
    E_DisplayName.Text := LineElement (mS,1,',');
    E_DisplayWidth.Text := StrInt (ValInt (LineElement (mS,2,',')),0);
    E_DisplayWidthChar.Text := StrInt (ValInt (E_DisplayWidth.Text) div oFontSize,0);
    mAlign := LineElement (mS,3,',');
    CB_Alignment.ItemIndex := 0;
    If mAlign='L' then CB_Alignment.ItemIndex := 0;
    If mAlign='C' then CB_Alignment.ItemIndex := 1;
    If mAlign='R' then CB_Alignment.ItemIndex := 2;
    CB_Format.Text := LineElement (mS,4,',');
    CB_EditFld.ItemIndex := 1;
    If LineElement (mS,5,',')='FALSE' then CB_EditFld.ItemIndex := 0;
    NI_FullName.Text:= LineElement (mS,6,',');
    E_DisplayName.Enabled := TRUE;
    E_DisplayWidth.Enabled := TRUE;
    CB_Alignment.Enabled := TRUE;
    CB_Format.Enabled := TRUE;
    CB_EditFld.Enabled := TRUE;
  end;
end;

procedure TF_GridDef.RefreshDefList;
var
  I:integer;
  mS:string;
begin
  If oGridSet.oDefGrid.Count>0 then begin
    For I:=0 to oGridSet.oDefGrid.Count-1 do begin
      mS := oGridSet.oDefGrid.Strings[I];
      mS := Copy (mS,1,Pos (',',mS)-1);
      If not FieldInDefault (mS) then LB_Default.Items.Add (mS);
    end;
  end;
end;

function TF_GridDef.FieldInDefault (pFld:string):boolean;
var I:longint;
begin
  Result := FALSE;
  If LB_Default.Items.Count>0 then begin
    I := 1;
    Repeat
      Result := (UpString (pFld)=UpString (LB_Default.Items.Strings[I-1]));
      Inc (I);
    until Result or (I>LB_Default.Items.Count);
  end;
end;

procedure TF_GridDef.SB_UpClick(Sender: TObject);
var mIt:integer;
begin
  If LB_Default.ItemIndex>0 then begin
    mIt := LB_Default.ItemIndex;
    LB_Default.Items.Move (mIt,mIt-1);
    oGridSet.oDefGrid.Move (mIt,mIt-1);
    LB_Default.ItemIndex := mIt-1;
    LB_Default.Selected[LB_Default.ItemIndex] := TRUE;
  end;
end;

procedure TF_GridDef.E_DisplayWidthExit(Sender: TObject);
begin
  E_DisplayWidthChar.Text := StrInt (ValInt (E_DisplayWidth.Text) div oFontSize,0);
  FldEditExit (Sender);
end;

procedure TF_GridDef.E_DisplayWidthCharExit(Sender: TObject);
begin
  E_DisplayWidth.Text := StrInt (ValInt (E_DisplayWidthChar.Text)*oFontSize,0);
  FldEditExit (Sender);
end;

procedure TF_GridDef.BB_SaveClick(Sender: TObject);
var I:integer;
begin
  For I:=0 to oGridSet.oDefGrid.Count-1 do
    oGridSet.oDefGrid.Strings[I] := 'Field'+StrInt (I,0)+'='+Copy (oGridSet.oDefGrid.Strings[I],Pos ('=',oGridSet.oDefGrid.Strings[I])+1,Length (oGridSet.oDefGrid.Strings[I]));
  oGridSet.SaveDefault;
  oGridSet.ReadDefault;
end;

procedure TF_GridDef.FldEditExit(Sender: TObject);
var
  mAlignment:string;
  mReadOnly:string;
begin
  mAlignment := 'R';
  If CB_Alignment.ItemIndex=0 then mAlignment := 'L';
  If CB_Alignment.ItemIndex=1 then mAlignment := 'C';
  If CB_Alignment.ItemIndex=2 then mAlignment := 'R';
  mReadOnly := 'TRUE';
  If CB_EditFld.ItemIndex=0 then mReadOnly := 'FALSE';
  oGridSet.oDefGrid.Strings[LB_Default.ItemIndex] := Copy (oGridSet.oDefGrid.Strings[LB_Default.ItemIndex],1,Pos (',',oGridSet.oDefGrid.Strings[LB_Default.ItemIndex]))
    +E_DisplayName.Text+','
    +StrInt (ValInt (E_DisplayWidth.Text),0)+','
    +mAlignment+','+CB_Format.Text+','+mReadOnly+','+NI_FullName.Text;
end;

procedure TF_GridDef.BB_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TF_GridDef.FormCreate(Sender: TObject);
begin
  ClientHeight :=290;
  Caption := ctGridDG_Caption;
  L_Name.Caption := ctGridDG_Name;
  L_Width.Caption := ctGridDG_Width;
  L_DisplayWidth.Caption := ctGridDG_DisplayWidth;
  L_DisplayWidthChar.Caption := ctGridDG_DisplayWidthChar;
  L_Alignment.Caption := ctGridDG_Alignment;
  L_Format.Caption := ctGridDG_Format;
  L_ReadOnly.Caption := ctGridDG_EditFld;

  SB_Up.Hint := ctGridDG_Up;
  SB_Down.Hint := ctGridDG_Down;

  CB_Alignment.Items.Add (ctGridDG_AlignmentLeft);
  CB_Alignment.Items.Add (ctGridDG_AlignmentCent);
  CB_Alignment.Items.Add (ctGridDG_AlignmentRight);

  CB_EditFld.Items.Add (ctGridDG_EditFldYes);
  CB_EditFld.Items.Add (ctGridDG_EditFldNo);

  BB_Save.Caption := ctGridDG_Save;
  BB_Exit.Caption := ctGridDG_Exit;
end;

procedure TF_GridDef.BB_RefreshFldClick(Sender: TObject);
begin
  oGridSet.ReadDefaultInDataSet (oDataSet,TRUE);
  FillDefList;
end;

procedure TF_GridDef.B_ColTextClick(Sender: TObject);
begin
  F_AdvGridColText := TF_AdvGridColText.Create(Self);;
  F_AdvGridColText.Execute(oDGDName);
  FreeAndNil (F_AdvGridColText);
end;

procedure TF_GridDef.Action1Execute(Sender: TObject);
begin
  Close;
end;

procedure TF_GridDef.L_NameDblClick(Sender: TObject);
begin
  If NI_FullName.Text<>'' then E_DisplayName.Text:=NI_FullName.Text;
end;

end.
