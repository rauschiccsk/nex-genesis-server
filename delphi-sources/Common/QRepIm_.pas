unit QRepIm_;

interface

uses
  IcConv,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ImgList;

type
  TF_ImageList = class(TForm)
    LV_ImageList: TListView;
    procedure LV_ImageListDblClick(Sender: TObject);
    procedure LV_ImageListKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    function  Execute (pImageList:TImageList):longint;
    { Public declarations }
  end;

var
  F_ImageList: TF_ImageList;

implementation

{$R *.DFM}

function  TF_ImageList.Execute (pImageList:TImageList):longint;
var
  I:longint;
  mListItem:TListItem;
  mRect:TRect;
  mW:longint;
  mH:longint;
begin
  LV_ImageList.LargeImages := pImageList;
  If LV_ImageList.LargeImages.Count>0 then begin
    For I:=0 to LV_ImageList.LargeImages.Count-1 do begin
      mListItem := LV_ImageList.Items.Add;
      mListItem.ImageIndex := I;
      mListItem.Caption := StrInt (I,0);
    end;
  end;
  mRect := LV_ImageList.Items.Item[0].DisplayRect(drBounds);
  mW := 600 div (mRect.Right+mRect.Left);
  If mW>LV_ImageList.LargeImages.Count then mW := LV_ImageList.LargeImages.Count;
  Width := (mW*(mRect.Right+mRect.Left))+mRect.Left+8;
  If (LV_ImageList.LargeImages.Count div mW)=(LV_ImageList.LargeImages.Count / mW)
    then mH := (LV_ImageList.LargeImages.Count div mW)
    else mH := (LV_ImageList.LargeImages.Count div mW)+1;
  Height := mH*(2*mRect.Top+mRect.Bottom+23)+10;
  LV_ImageList.ViewStyle := vsList;
  LV_ImageList.ViewStyle := vsIcon;
  ShowModal;
  If LV_ImageList.Selected<>nil
    then Result := LV_ImageList.Selected.Index
    else Result := -1;
  LV_ImageList.Items.Clear;
  LV_ImageList.LargeImages := nil;
end;

procedure TF_ImageList.LV_ImageListDblClick(Sender: TObject);
begin
  Close;
end;

procedure TF_ImageList.LV_ImageListKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: Close;
    VK_ESCAPE: begin
      LV_ImageList.Selected := nil;
      Close;
    end;
  end;
end;

end.

