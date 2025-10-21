unit NxbLst;

interface

uses
  IcTypes, IcTools, IcVariab, NexPath, BtrLst,
  hABKDEF, hNXBDEF,
//  dNXBDEF,
  IcStand, NexBtrTable, Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, Buttons, StdCtrls, ComCtrls, xpComp, ImgList;

type
  PDataRec = ^TDataRec;
  TDataRec = record
    BookNum : Str5;
    BookName: Str30;
  end;

  TBeforeSelectEvent = procedure(pSender: TObject; pBookNum: Str5) of object;

  TNxbLst = class(TxpSinglePanel)
    L_Head: TLabel;
    V_Book: TTreeView;
    procedure SetHead (pValue:Str30);
    function  GetHead: Str30;
  private
    oCount:word;
    oPmdMark:Str3;
    oSlcBook:Str5;
    {Events}
    eBeforeSelect:TBeforeSelectEvent;
    eOnKeyDown:TKeyEvent;

    procedure SetSelectedImage;
    procedure MyOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MyOnChange(Sender: TObject; Node: TTreeNode);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Execute (pPmdMark:Str3;pSlcBook:Str5); overload;
    procedure Execute (pTable:TNexBtrTable;pNumFld,pNameFld:Str10;pSlcLst:word); overload;
    procedure Select (pIndex:word);
    procedure Refresh;
    procedure SelectBook (pSender: TObject);
    procedure LoadNxbLst; // Nacita zoznam knih pre daneho uzivatela
  published
    property Count:word read oCount;
    property Head:Str30 read GetHead write SetHead;
    property SlcBook:Str5 read oSlcBook;
    property TabOrder;
    property TabStop;
    property Align;
    {Events}
    property BeforeSelect: TBeforeSelectEvent read eBeforeSelect write eBeforeSelect;
    property OnKeyDown: TKeyEvent read eOnKeyDown write eOnKeyDown;
  end;

procedure Register;

implementation

uses DM_SYSTEM;

constructor TNxbLst.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := 200;
  Align := alLeft;

  L_Head := TLabel.Create (Self);
  L_Head.Parent := Self;
  L_Head.Name := 'L_Head';
  L_Head.Height := 25;
  L_Head.Align := alTop;
  L_Head.Alignment := taCenter;
  L_Head.Layout  := tlCenter;
  L_Head.AutoSize := False;
  L_Head.Color := $00FF5E5E;
  L_Head.Font.Color := clWhite;
  L_Head.Font.Size := 10;

  V_Book := TTreeView.Create (Self);
  V_Book.Parent := Self;
  V_Book.Name := 'V_Book';
  V_Book.Align := alClient;
  V_Book.Font.Size := 10;
  V_Book.ReadOnly := True;
  V_Book.HideSelection := False;
  V_Book.RowSelect := False;
  V_Book.BorderStyle := bsNone;
  V_Book.ChangeDelay := 800;
  V_Book.OnDblClick := SelectBook;
  V_Book.OnKeyDown := MyOnKeyDown;
  V_Book.OnChange := MyOnChange;
end;

destructor TNxbLst.Destroy;
begin
  FreeAndNil (V_Book);
  FreeAndNil (L_Head);
  inherited Destroy;
end;

procedure TNxbLst.Execute (pPmdMark:Str3;pSlcBook:Str5);
var mDataRec: PDataRec;  mCnt:word;  mFind:boolean;
begin
  oCount := 0;
  oPmdMark := pPmdMark;
  oSlcBook := pSlcBook;
  V_Book.Images := dmSYS.IL_BookList;
  LoadNxbLst; // Nacita zoznam knih pre daneho uzivatela
end;

procedure TNxbLst.Execute (pTable:TNexBtrTable;pNumFld,pNameFld:Str10;pSlcLst:word);
var mNode:TTreeNode;  mDataRec:PDataRec;  mLstNum:Str5; mLstName:Str30;
begin
  oCount := 0;
  V_Book.Images := dmSYS.IL_BookList;
  V_Book.Items.Clear;
  If pTable.RecordCount>0 then begin
    pTable.SwapStatus;
    pTable.First;
    Repeat
      mLstNum := pTable.FieldByName(pNumFld).AsString;
      mLstName := pTable.FieldByName(pNameFld).AsString;
      mNode := V_Book.Items.Add(nil,mLstNum+'   '+mLstName);
      If pTable.FieldByName(pNumFld).AsInteger=pSlcLst then begin
        mNode.SelectedIndex := 4;
        mNode.ImageIndex := 4;
        mNode.Selected := TRUE;
      end else begin
        mNode.SelectedIndex := 3;
        mNode.ImageIndex := 3;
      end;
      GetMem(mDataRec,SizeOf(TDataRec));
      mDataRec^.BookNum  := mLstNum;
      mDataRec^.BookName := mLstName;
      mNode.Data := mDataRec;
      Inc (oCount);
      Application.ProcessMessages;
      pTable.Next;
    until pTable.Eof;
    pTable.RestoreStatus;
  end;
end;

procedure TNxbLst.Select;
var mDataRec: PDataRec;
begin
  If V_Book.Items.Count>0 then begin
    V_Book.Selected := V_Book.Items.Item[pIndex];
    mDataRec := V_Book.Items.Item[pIndex].Data;
    SetSelectedImage;
    If Assigned (eBeforeSelect) then  eBeforeSelect(Self,mDataRec^.BookNum);
  end;
end;

procedure TNxbLst.Refresh;
begin
  //
end;

procedure TNxbLst.LoadNxbLst;
var mNode:TTreeNode; mDataRec:PDataRec; mBookName:Str40; mhABKDEF:TAbkdefHnd; mhNXBDEF:TNxbdefHnd;
begin
  V_Book.Items.Clear;
  mhNXBDEF := TNxbdefHnd.Create;   mhNXBDEF.Open;
  mhABKDEF := TAbkdefHnd.Create;   mhABKDEF.Open;
  If mhABKDEF.LocateGrPm(gvSys.LoginGroup,oPmdMark) then begin
    mhABKDEF.NearestGrPmBn(gvSys.LoginGroup,oPmdMark,'');
    Repeat
      mBookName := mhNXBDEF.GetBookName(oPmdMark,mhABKDEF.BookNum);
      mNode := V_Book.Items.Add(nil,mhABKDEF.BookNum+'   '+mBookName);
      If mhABKDEF.BookNum=oSlcBook then begin
        mNode.SelectedIndex := 4;
        mNode.ImageIndex := 4;
        mNode.Selected := TRUE;
      end else begin
        mNode.SelectedIndex := 3;
        mNode.ImageIndex := 3;
      end;
      GetMem(mDataRec,SizeOf(TDataRec));
      mDataRec^.BookNum  := mhABKDEF.BookNum;
      mDataRec^.BookName := mBookName;
      mNode.Data := mDataRec;
      Inc (oCount);
      Application.ProcessMessages;
      mhABKDEF.Next;
    until mhABKDEF.Eof or (mhABKDEF.GrpNum<>gvSys.LoginGroup) or (mhABKDEF.PmdMark<>oPmdMark);
  end;
  FreeAndNil (mhABKDEF);
  FreeAndNil (mhNXBDEF);
end;

procedure TNxbLst.SetSelectedImage;
var I:word;
begin
  For I:=0 to V_Book.Items.Count-1 do begin
    If V_Book.Items[I].Selected then begin
      V_Book.Items[I].SelectedIndex := 4;
      V_Book.Items[I].ImageIndex := 4;
    end
    else begin
      V_Book.Items[I].SelectedIndex := 3;
      V_Book.Items[I].ImageIndex := 3;
    end;
  end;
end;

procedure TNxbLst.SetHead(pValue:Str30);
begin
  L_Head.Caption := pValue;
end;

function TNxbLst.GetHead:Str30;
begin
  Result := L_Head.Caption;
end;

// ****************************** E V E N T S *********************************

procedure TNxbLst.SelectBook (pSender: TObject);
var mDataRec: PDataRec;
begin
  If Assigned(eBeforeSelect) then begin
    SetSelectedImage;
    If V_Book.Selected<>nil then begin
      mDataRec := V_Book.Selected.Data;
      eBeforeSelect (Self,mDataRec^.BookNum);
    end;
  end;
end;

procedure TNxbLst.MyOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Assigned(eOnKeyDown) then  eOnKeyDown (Sender,Key,Shift);
  If (Key = VK_RETURN) then SelectBook (Self);
end;

procedure TNxbLst.MyOnChange(Sender: TObject; Node: TTreeNode);
begin
//  Davakrat vykona otvorenie
//  SelectBook (Sender);
end;

// ***********************************************
procedure Register;
begin
  RegisterComponents('IcDataAccess', [TNxbLst]);
end;

end.
