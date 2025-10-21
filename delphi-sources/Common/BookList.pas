unit BookList;

interface

uses
  IcTypes, IcTools, IcStand, NexBtrTable, NexText, NexMsg, BookList_Edit,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Buttons, StdCtrls, ComCtrls, ImgList;

type
  PDataRec = ^TDataRec;
  TDataRec = record
    BookNum : Str5;
    BookName: Str30;
  end;

  TBeforeBookDelEvent = procedure(pSender: TObject; var pDeleteYes: boolean) of object;
  TBeforeBookSelectEvent = procedure(pSender: TObject; pBookNum: Str5) of object;
  TBookModifyEvent = procedure(pSender: TObject; var pModify: boolean) of object;

  TBookList = class(TCustomPanel)
    L_Head: TLabel;
    L_Buttons: TLabel;
    B_AddBook: TSpeedButton;
    B_ModBook: TSpeedButton;
    B_DelBook: TSpeedButton;
    TV_BookList: TTreeView;
    procedure SetHead (pValue: string);
    function  GetHead: string;
    procedure SetHeadFontSize (pValue: word);
    function  GetHeadFontSize: word;
  private
    oOwnerForm: TForm;
    oBookNumField: Str20;
    oBookNameField: Str20;
    oDataSet: TNexBtrTable;
    oAskBeforExit: boolean;
    {Events}
    eBeforeBookDel: TBeforeBookDelEvent;
    eBeforeBookAdd: TBookModifyEvent;
    eBeforeBookMod: TBookModifyEvent;
    eBeforeBookSelect: TBeforeBookSelectEvent;
    eOnKeyDown: TKeyEvent;

    procedure LoadText; // Nacita texty do programu z jazykoveho suboru
    procedure SetSelectedImage;
    procedure MyOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MyOnChange(Sender: TObject; Node: TTreeNode);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure   Execute (pBookNum:Str5);
    procedure   Select (pIndex:word);
    procedure   DelBook (pSender: TObject);
    procedure   AddBook (pSender: TObject);
    procedure   ModBook (pSender: TObject);
    procedure   SelectBook (pSender: TObject);
    procedure LoadFromDatabase;
  published
    property Head: string read GetHead write SetHead;
    property HeadFontSize: word read GetHeadFontSize write SetHeadFontSize;
    property DataSet: TNexBtrTable read oDataSet write oDataSet;
    property BookNumField: Str20 read oBookNumField write oBookNumField;
    property BookNameField: Str20 read oBookNameField write oBookNameField;
    property AskBeforExit: boolean read oAskBeforExit write oAskBeforExit;
    property TabOrder;
    property TabStop;
    property Align;
    {Events}
    property BeforeBookDel: TBeforeBookDelEvent read eBeforeBookDel write eBeforeBookDel;
    property BeforeBookAdd: TBookModifyEvent read eBeforeBookAdd write eBeforeBookAdd;
    property BeforeBookMod: TBookModifyEvent read eBeforeBookMod write eBeforeBookMod;
    property BeforeBookSelect: TBeforeBookSelectEvent read eBeforeBookSelect write eBeforeBookSelect;
    property OnKeyDown: TKeyEvent read eOnKeyDown write eOnKeyDown;
  end;

procedure Register;

implementation

uses DM_SYSTEM;

constructor TBookList.Create(AOwner: TComponent);
begin
  oOwnerForm := (AOwner as TForm);
  inherited Create(AOwner);
  Width := 200;
  Align := alLeft;
  BorderWidth := 3;
  BevelInner := bvLowered;
  AskBeforExit := TRUE;

  L_Head := TLabel.Create (Self);
  L_Head.Parent := Self;
  L_Head.Name := 'L_Head';
  L_Head.Height := 20;
  L_Head.Align := alTop;
  L_Head.Alignment := taCenter;
  L_Head.AutoSize := False;
  L_Head.Color := clBlue;
  L_Head.Font.Color := clWhite;
  L_Head.Font.Style := [fsBold];
  L_Head.Font.Size := 10;

  L_Buttons := TLabel.Create (Self);
  L_Buttons.Parent := Self;
  L_Buttons.Align := alTop;
  L_Buttons.AutoSize := FALSE;
  L_Buttons.Height := 30;
  L_Buttons.Visible := FALSE;

  B_AddBook := TSpeedButton.Create (Self);
  B_AddBook.Parent := Self;
  B_AddBook.Name := 'B_AddBook';
  B_AddBook.Left := 7;
  B_AddBook.Top := 28;
  B_AddBook.Width := 25;
  B_AddBook.Height := 25;
  B_AddBook.NumGlyphs := 2;
  B_AddBook.ParentShowHint := False;
  B_AddBook.ShowHint := True;
  B_AddBook.Glyph.LoadFromResourceName (HInstance,'INSERT');
  B_AddBook.OnClick := AddBook;

  B_ModBook := TSpeedButton.Create (Self);
  B_ModBook.Parent := Self;
  B_ModBook.Name := 'B_ModBook';
  B_ModBook.Left := 35;
  B_ModBook.Top := 28;
  B_ModBook.Width := 25;
  B_ModBook.Height := 25;
  B_ModBook.NumGlyphs := 2;
  B_ModBook.ParentShowHint := False;
  B_ModBook.ShowHint := True;
  B_ModBook.Glyph.LoadFromResourceName (HInstance,'EDIT');
  B_ModBook.OnClick := ModBook;

  B_DelBook := TSpeedButton.Create (Self);
  B_DelBook.Parent := Self;
  B_DelBook.Name := 'B_DelBook';
  B_DelBook.Left := 61;
  B_DelBook.Top := 28;
  B_DelBook.Width := 25;
  B_DelBook.Height := 25;
  B_DelBook.NumGlyphs := 2;
  B_DelBook.ParentShowHint := False;
  B_DelBook.ShowHint := True;
  B_DelBook.Glyph.LoadFromResourceName (HInstance,'DELETE');
  B_DelBook.OnClick := DelBook;

  TV_BookList := TTreeView.Create (Self);
  TV_BookList.Parent := Self;
  TV_BookList.Name := 'TV_BookList';
  TV_BookList.Align := alClient;
  TV_BookList.ReadOnly := True;
  TV_BookList.HideSelection := False;
  TV_BookList.RowSelect := False;
  TV_BookList.ChangeDelay := 800;
  TV_BookList.OnDblClick := SelectBook;
  TV_BookList.OnKeyDown := MyOnKeyDown;
  TV_BookList.OnChange := MyOnChange;
end;

destructor TBookList.Destroy;
begin
  L_Buttons.Free;
  B_AddBook.Free;
  B_ModBook.Free;
  B_DelBook.Free;
  TV_BookList.Free;
  inherited Destroy;
end;

procedure TBookList.Execute (pBookNum:Str5);
var mDataRec: PDataRec;  mCnt:word;  mFind:boolean;
begin
  LoadText;
  TV_BookList.Images := dmSys.IL_BookList;
  If oDataSet.Active
    then LoadFromDatabase
    else ShowMsg (502,'');
  mCnt := 0;  mFind := FALSE;
  If TV_BookList.Items.Count>0 then begin
    Repeat
      mDataRec := TV_BookList.Items.Item[mCnt].Data;
      mFind := mDataRec.BookNum=pBookNum;
      Inc (mCnt);
    until mFind or (TV_BookList.Items.Count=mCnt);
  end;  
  If mFind
    then Select (mCnt-1)
    else Select (0);
end;

procedure TBookList.Select;
var mDataRec: PDataRec;
begin
  If TV_BookList.Items.Count>0 then begin
    TV_BookList.Selected := TV_BookList.Items.Item[pIndex];
    mDataRec := TV_BookList.Items.Item[pIndex].Data;
    SetSelectedImage;
    If Assigned (eBeforeBookSelect) then  eBeforeBookSelect(Self,mDataRec^.BookNum);
  end;
end;

procedure TBookList.LoadText;
begin
  gNT.SetSection ('BookList');
  B_AddBook.Hint := gNT.GetText('B_AddBook.Hint','Pridat novu knihu');
  B_ModBook.Hint := gNT.GetText('B_ModBook.Hint','Upravit vlastnosti knihy');
  B_DelBook.Hint := gNT.GetText('B_DelBook.Hint','Zrusit vybranu knihu');
end;

procedure TBookList.LoadFromDatabase;
var
  mNode: TTreeNode;
  mPDataRec: PDataRec;
  mItem: string;
  mActPos:longint;
begin
  mActPos := oDataSet.ActPos;
  oDataSet.SwapStatus;
  TV_BookList.Items.Clear;
  oDataSet.First;
  while not oDataSet.Eof do begin
    mItem := oDataSet.FieldByName(oBookNumField).AsString+'   '+oDataSet.FieldByName(oBookNameField).AsString;
    mNode := TV_BookList.Items.Add(nil,mItem);
    If mActPos=oDataSet.ActPos then begin
      mNode.SelectedIndex := 4;
      mNode.ImageIndex := 4;
      mNode.Selected := TRUE;
    end else begin
      mNode.SelectedIndex := 3;
      mNode.ImageIndex := 3;
    end;
    GetMem(mPDataRec,SizeOf(TDataRec));
    mPDataRec^.BookNum  := oDataSet.FieldByName(oBookNumField).AsString;
    mPDataRec^.BookName := oDataSet.FieldByName(oBookNameField).AsString;
    mNode.Data := mPDataRec;
    oDataSet.Next;
  end;
  oDataSet.RestoreStatus;
end;

procedure TBookList.SetSelectedImage;
var I:word;
begin
  For I:=0 to TV_BookList.Items.Count-1 do begin
    If TV_BookList.Items[I].Selected then begin
      TV_BookList.Items[I].SelectedIndex := 4;
      TV_BookList.Items[I].ImageIndex := 4;
    end
    else begin
      TV_BookList.Items[I].SelectedIndex := 3;
      TV_BookList.Items[I].ImageIndex := 3;
    end;
  end;
end;

procedure TBookList.SetHead(pValue: string);
begin
  L_Head.Caption := pValue;
end;

function TBookList.GetHead: string;
begin
  Result := L_Head.Caption;
end;

procedure TBookList.SetHeadFontSize(pValue: word);
begin
  L_Head.Font.Size := pValue;
end;

function TBookList.GetHeadFontSize: word;
begin
  Result := L_Head.Font.Size;
end;

//   ***************** E V E N T S **************

procedure TBookList.DelBook;
var
  mDeleteYes: boolean;  mDataRec: PDataRec;
  mModify: boolean;
  mItNum:integer;
begin
  mDeleteYes := FALSE;
  If Assigned(TV_BookList.Selected) then begin
    mItNum := TV_BookList.Selected.Index;
    If Assigned(eBeforeBookDel) then begin
      mDeleteYes := TRUE;
      eBeforeBookDel (Self,mDeleteYes);
      If mDeleteYes then begin
        mDataRec := TV_BookList.Selected.Data;
        oDataSet.FindKey ([mDataRec^.BookNum]);
        oDataSet.Delete;
      end;
    end else begin
      mDeleteYes := AskYes (2,'');
      If  mDeleteYes then begin
        mDataRec := TV_BookList.Selected.Data;
        oDataSet.FindKey ([mDataRec^.BookNum]);
        oDataSet.Delete;
      end;
    end;
    If mDeleteYes then begin
      LoadFromDatabase;
      If TV_BookList.Items.Count<mItNum+1 then Dec (mItNum);
      If mItNum>=0 then begin
        TV_BookList.Items.Item[mItNum].Selected := TRUE;
        TV_BookList.Items.Item[mItNum].SelectedIndex := 4;
        TV_BookList.Items.Item[mItNum].ImageIndex := 4;
        SelectBook (Self);
      end;
    end;
  end
  else ShowMsg (6,'');
end;

procedure TBookList.AddBook (pSender: TObject);
var mModify: boolean;
begin
  mModify := FALSE;
  If Assigned(eBeforeBookAdd)
    then eBeforeBookAdd (Self,mModify)
    else begin
      F_BookListEdit := TF_BookListEdit.Create (Self);
      F_BookListEdit.Execute ('','');
      If F_BookListEdit.SaveData then begin
        mModify := True;
        If oDataSet.FindKey ([F_BookListEdit.GetBookNum]) then begin
          oDataSet.Edit;
          oDataSet.FieldByName(oBookNameField).AsString := F_BookListEdit.GetBookName;
          oDataSet.Post;
        end
        else begin
          oDataSet.Insert;
          oDataSet.FieldByName(oBookNumField).AsString := F_BookListEdit.GetBookNum;
          oDataSet.FieldByName(oBookNameField).AsString := F_BookListEdit.GetBookName;
          oDataSet.Post;
        end;
      end;
    end;
  If mModify then begin
    LoadFromDatabase;
    SelectBook (Self);
  end;
end;

procedure TBookList.ModBook (pSender: TObject);
var mDataRec: PDataRec;   mModify: boolean;
begin
  If Assigned(TV_BookList.Selected) then begin
    If Assigned(eBeforeBookMod)
      then eBeforeBookMod (Self,mModify)
      else begin
        mDataRec := TV_BookList.Selected.Data;
        F_BookListEdit := TF_BookListEdit.Create (Self);
        F_BookListEdit.Execute (mDataRec^.BookNum,mDataRec^.BookName);
        If F_BookListEdit.SaveData then begin
          If oDataSet.FindKey ([F_BookListEdit.GetBookNum]) then begin
            oDataSet.Edit;
            oDataSet.FieldByName(oBookNameField).AsString := F_BookListEdit.GetBookName;
            oDataSet.Post;
          end
          else begin
            oDataSet.Insert;
            oDataSet.FieldByName(oBookNumField).AsString := F_BookListEdit.GetBookNum;
            oDataSet.FieldByName(oBookNameField).AsString := F_BookListEdit.GetBookName;
            oDataSet.Post;
          end;
        end;
      end;
    If mModify then LoadFromDatabase;
  end
  else ShowMsg (6,'');
end;

procedure TBookList.SelectBook (pSender: TObject);
var mDataRec: PDataRec;
begin
  If Assigned(eBeforeBookSelect) then begin
    SetSelectedImage;
    If TV_BookList.Selected<>nil then begin
      mDataRec := TV_BookList.Selected.Data;
      oDataSet.FindKey ([mDataRec^.BookNum]);
      eBeforeBookSelect (Self,mDataRec^.BookNum);
    end;
  end;
end;

procedure TBookList.MyOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Assigned(eOnKeyDown) then  eOnKeyDown (Sender,Key,Shift);
  If (Key=VK_RETURN) and (ssCtrl in Shift) then ModBook (Self);  // Tibi 06.10.2000
  If (Key = VK_RETURN) then SelectBook (Self);
  If (Key = VK_INSERT) then AddBook (Self);
  If (Key = VK_DELETE) then DelBook (Self);
  If (Key = VK_ESCAPE) then begin
    If oAskBeforExit then begin
      If AskYes (8,'') then oOwnerForm.Close;
    end
    else oOwnerForm.Close;
  end;
end;

procedure TBookList.MyOnChange(Sender: TObject; Node: TTreeNode);
begin
//  Davakrat vykona otvorenie 
//  SelectBook (Sender);
end;

// ***********************************************
procedure Register;
begin
  RegisterComponents('IcDataAccess', [TBookList]);
end;

end.
