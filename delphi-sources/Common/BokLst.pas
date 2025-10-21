unit BokLst;

interface

uses
  IcTypes, IcTools, IcVariab, IcConv, NexPath, BtrLst, UsrFnc,
  hABKDEF, hNXBDEF,
  IcStand, NexBtrTable, Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, Buttons, StdCtrls, ComCtrls, xpComp, ImgList;

type
  PDataRec=^TDataRec;
  TDataRec=record
    BokNum:Str5;
    BokNam:Str30;
  end;

  TSelectEvent=procedure(pSender:TObject;pBokNum:Str5;pBokNam:Str30) of object;

  TBokLst=class(TxpSinglePanel)
    P_BokHed:TxpSinglePanel;
    L_BokHed:TLabel;
    V_BokLst:TTreeView;
  private
    oCount:word;
    oPmdCod:Str3;
    oBokNum:Str5;
    oBokNam:Str30;
    {Events}
    eOnSelect:TSelectEvent;
    eOnKeyDown:TKeyEvent;

    procedure MyOnKeyDown(Sender:TObject; var Key:Word; Shift:TShiftState);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Execute(pPmdCod:Str3;pBokNum:Str5);
    procedure ExeLodLst(pPmdCod,pBokNum:Str3);
    procedure SlcBok(Sender:TObject);
    procedure SetSlcImg;
    procedure LodBokLst; // Nacita zoznam knih pre daneho uzivatela - nový zoznam
    procedure LoadBokLst; // Nacita zoznam knih pre daneho uzivatela - starý zoznam
  published
    property Count:word read oCount;
    property BokNum:Str5 read oBokNum;
    property BokNam:Str30 read oBokNam;
    property TabOrder;
    property TabStop;
    property Align;
    {Events}
    property OnSelect:TSelectEvent read eOnSelect write eOnSelect;
    property OnKeyDown:TKeyEvent read eOnKeyDown write eOnKeyDown;
  end;

procedure Register;

implementation

uses DM_SYSTEM, dUSGRGH, dBOKLST;

constructor TBokLst.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  Width:=200;
  Align:=alLeft;
(*
  ParentFont:=FALSE;
  SystemColor:=FALSE;
  BorderColor:=clSilver;
  GradStartColor:=clSilver;
  GradEndColor:=$00E6E6E6;
  GradFillDir:=fdXP;
  Font.Color:=clBlack;

  P_BokHed:=TxpSinglePanel.Create(Self);
  P_BokHed.Parent:=Self;
  P_BokHed.Name:='P_BokHed';
  P_BokHed.Align:=alTop;
  P_BokHed.BorderColor:=clSilver;
  P_BokHed.GradStartColor:=clSilver;
  P_BokHed.GradEndColor:=$00E6E6E6;
  P_BokHed.GradFillDir:=fdXP;
  P_BokHed.Font.Color:=clBlack;
  P_BokHed.Height:=35;

  L_BokHed:=TLabel.Create(P_BokHed);
  L_BokHed.Parent:=P_BokHed;
  L_BokHed.Name:='L_BokHed';
  L_BokHed.Caption:='KNIHY';
  L_BokHed.Align:=alClient;
  L_BokHed.Alignment:=taCenter;
  L_BokHed.Layout:=tlCenter;
  L_BokHed.AutoSize:=TRUE;
  L_BokHed.Color:=$00FF5E5E;
  L_BokHed.Font.Color:=clBlack;
  L_BokHed.Font.Size:=12;
*)
  V_BokLst:=TTreeView.Create(Self);
  V_BokLst.Parent:=Self;
  V_BokLst.Name:='V_BokLst';
  V_BokLst.Align:=alClient;
  V_BokLst.ParentFont:=FALSE;
  V_BokLst.ParentColor:=FALSE;
//  V_BokLst.Font.Name:='Arial';
//  V_BokLst.Font.Size:=11;
  V_BokLst.ReadOnly:=TRUE;
  V_BokLst.HideSelection:=FALSE;
  V_BokLst.RowSelect:=FALSE;
  V_BokLst.BorderStyle:=bsNone;
  V_BokLst.ChangeDelay:=800;
  V_BokLst.OnDblClick:=SlcBok;
  V_BokLst.OnKeyDown:=MyOnKeyDown;
end;

destructor TBokLst.Destroy;
begin
  FreeAndNil(V_BokLst);
  FreeAndNil(L_BokHed);
  FreeAndNil(P_BokHed);
  inherited Destroy;
end;

procedure TBokLst.Execute(pPmdCod:Str3;pBokNum:Str5);
begin
  oCount:=0;
  oPmdCod:=pPmdCod;
  oBokNum:=pBokNum;
  V_BokLst.Images:=dmSYS.IL_BookList;
  LoadBokLst; // Nacita zoznam knih pre daneho uzivatela
end;

procedure TBokLst.ExeLodLst(pPmdCod,pBokNum:Str3);
begin
  oCount:=0;
  oPmdCod:=pPmdCod;
  oBokNum:=pBokNum;
  V_BokLst.Images:=dmSYS.IL_BookList;
  LodBokLst; // Nacita zoznam knih pre daneho uzivatela
end;

procedure TBokLst.LodBokLst;
var mNode:TTreeNode; mDataRec:PDataRec; mBokNam:Str50; mBokNum:Str3; mGrpNum,mPmdCod:ShortString;
begin
  V_BokLst.Items.Clear;
  With gUsr do begin
    mGrpNum:='['+ohUSGRGH.FieldNum('GrpNum')+']={'+StrInt(gUsr.GrpNum,0)+'}';
    mPmdCod:='['+ohUSGRGH.FieldNum('PmdCod')+']={'+oPmdCod+'}';
    ohUSGRGH.SetIndex('GnPc');
    ohUSGRGH.Table.ClearFilter;
    ohUSGRGH.Table.Filter:=mGrpNum+'^'+mPmdCod;
    ohUSGRGH.Table.Filtered:=TRUE;
    If ohUSGRGH.Count>0 then begin
      ohUSGRGH.SetIndex('GnPcBn');
      ohUSGRGH.First;
      Repeat
        mBokNum:=ohUSGRGH.BokNum;
        mBokNam:='-';
        If oBokNum='' then oBokNum:=mBokNum;
        If ohBOKLST.LocPmBn(oPmdCod,mBokNum) then mBokNam:=ohBOKLST.BokNam;
        mNode:=V_BokLst.Items.Add(nil,mBokNum+'   '+mBokNam);
        If mBokNum=oBokNum then begin
          mNode.SelectedIndex:=4;
          mNode.ImageIndex:=4;
          mNode.Selected:=TRUE;
        end else begin
          mNode.SelectedIndex:=3;
          mNode.ImageIndex:=3;
        end;
        GetMem(mDataRec,SizeOf(TDataRec));
        mDataRec^.BokNum:=mBokNum;
        mDataRec^.BokNam:=mBokNam;
        mNode.Data:=mDataRec;
        If oBokNum=mBokNum then oBokNam:=mBokNam;
        Inc(oCount);
        Application.ProcessMessages;
        ohUSGRGH.Next;
      until ohUSGRGH.Eof;
    end;
  end;
end;

procedure TBokLst.LoadBokLst;
var mNode:TTreeNode; mDataRec:PDataRec; mBokNam:Str40; mhABKDEF:TAbkdefHnd; mhNXBDEF:TNxbdefHnd; mBokNum:Str3;
begin
  V_BokLst.Items.Clear;
  mhNXBDEF:=TNxbdefHnd.Create;  mhNXBDEF.Open;
  mhABKDEF:=TAbkdefHnd.Create;  mhABKDEF.Open;
  If mhABKDEF.LocateGrPm(gvSys.LoginGroup,oPmdCod) then begin
    mhABKDEF.NearestGrPmBn(gvSys.LoginGroup,oPmdCod,'');
    Repeat
      If copy(mhABKDEF.BookNum,1,1)='A' then begin
        mBokNam:=mhNXBDEF.GetBookName(oPmdCod,mhABKDEF.BookNum);
        mBokNum:=copy(mhABKDEF.BookNum,3,3);
        mNode:=V_BokLst.Items.Add(nil,mBokNum+'   '+mBokNam);
        If copy(mhABKDEF.BookNum,3,3)=oBokNum then begin
          mNode.SelectedIndex:=4;
          mNode.ImageIndex:=4;
          mNode.Selected:=TRUE;
        end else begin
          mNode.SelectedIndex:=3;
          mNode.ImageIndex:=3;
        end;
        GetMem(mDataRec,SizeOf(TDataRec));
        mDataRec^.BokNum:=mBokNum;
        mDataRec^.BokNam:=mBokNam;
        mNode.Data:=mDataRec;
        If oBokNum=mBokNum then oBokNam:=mBokNam;
        Inc(oCount);
      end;
      Application.ProcessMessages;
      mhABKDEF.Next;
    until mhABKDEF.Eof or (mhABKDEF.GrpNum<>gvSys.LoginGroup) or (mhABKDEF.PmdMark<>oPmdCod);
  end;
  FreeAndNil(mhABKDEF);
  FreeAndNil(mhNXBDEF);
end;

procedure TBokLst.SetSlcImg;
var I:word;
begin
  For I:=0 to V_BokLst.Items.Count-1 do begin
    If V_BokLst.Items[I].Selected then begin
      V_BokLst.Items[I].SelectedIndex:=4;
      V_BokLst.Items[I].ImageIndex:=4;
    end
    else begin
      V_BokLst.Items[I].SelectedIndex:=3;
      V_BokLst.Items[I].ImageIndex:=3;
    end;
  end;
end;

// ****************************** E V E N T S *********************************

procedure TBokLst.SlcBok(Sender:TObject);
var mDataRec: PDataRec;
begin
  If Assigned(eOnSelect) then begin
    SetSlcImg;
    If V_BokLst.Selected<>nil then begin
      mDataRec:=V_BokLst.Selected.Data;
      oBokNam:=mDataRec^.BokNam;
      eOnSelect(Self,mDataRec^.BokNum,mDataRec^.BokNam);
    end;
  end;
end;

procedure TBokLst.MyOnKeyDown(Sender:TObject; var Key:Word; Shift:TShiftState);
begin
  If Assigned(eOnKeyDown) then  eOnKeyDown(Sender,Key,Shift);
  If (Key=VK_RETURN) then SlcBok(Self);
end;

// ***********************************************

procedure Register;
begin
  RegisterComponents('xpComp',[TBokLst]);
end;

end.
