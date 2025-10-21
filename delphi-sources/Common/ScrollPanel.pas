unit ScrollPanel;

interface

uses
  IcTypes,
  Forms, StdCtrls, SysUtils, Classes, Controls, ExtCtrls;

type
  TScrollPanel = class(TPanel)
    SC_Horizontal: TScrollBar;
    SC_Vertical: TScrollBar;
    P_FixClient: TPanel;
    P_MoveClient: TPanel;
  private
    oClientWidth : longint;
    oClientHeight: longint;
    oCompCnt     : longint;
    oComp        : array [0..500] of Str30;

    procedure MyOnResize (Sender:TObject);
    procedure MyHorizontalChange(Sender: TObject);
    procedure MyVerticalChange(Sender: TObject);

    function  GetClientWidth:longint;
    procedure SetClientWidth (Value:longint);
    function  GetClientHeight:longint;
    procedure SetClientHeight (Value:longint);
    function  GetMovePanel:TPanel;
    procedure SetMovePanel (Value:TPanel);
    procedure MyActiveControlChange(Sender: TObject);
    { Private declarations }
  protected
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    { Public declarations }
  published
    { Published declarations }
    property ClientWidth:longint read GetClientWidth write SetClientWidth;
    property ClientHeight:longint read GetClientHeight write SetClientHeight;
    property MovePanel: TPanel read GetMovePanel write SetMovePanel;
  end;

procedure Register;

implementation

procedure TScrollPanel.MyOnResize (Sender:TObject);
begin
  If P_MoveClient<>nil then begin
    If P_MoveClient.Height>P_FixClient.Height then begin
      SC_Vertical.Enabled := TRUE;
      SC_Vertical.Max := P_MoveClient.Height-P_FixClient.Height;
      SC_Vertical.LargeChange := SC_Vertical.Max div 10;
    end else begin
      SC_Vertical.Max := 0;
      SC_Vertical.Enabled := FALSE;
    end;

    If P_MoveClient.Width>P_FixClient.Width then begin
      SC_Horizontal.Enabled := TRUE;
      SC_Horizontal.Max := P_MoveClient.Width-P_FixClient.Width;
      SC_Horizontal.LargeChange := SC_Horizontal.Max div 10;
    end else begin
      SC_Horizontal.Max := 0;
      SC_Horizontal.Enabled := FALSE;
    end;
  end;
end;

procedure TScrollPanel.MyHorizontalChange(Sender: TObject);
begin
  If P_MoveClient<>nil then P_MoveClient.Left := -1*SC_Horizontal.Position;
end;

procedure TScrollPanel.MyVerticalChange(Sender: TObject);
begin
  If P_MoveClient<>nil then P_MoveClient.Top := -1*SC_Vertical.Position;
end;

function  TScrollPanel.GetClientWidth:longint;
begin
  Result := oClientWidth;
end;

procedure TScrollPanel.SetClientWidth (Value:longint);
begin
  oClientWidth := Value;
  If not (csDesigning in ComponentState) then begin
    If P_MoveClient<>nil then P_MoveClient.Width := Value;
    MyOnResize (Self);
  end;
end;

function  TScrollPanel.GetClientHeight:longint;
begin
  Result := oClientHeight;
end;

procedure TScrollPanel.SetClientHeight (Value:longint);
begin
  oClientHeight := Value;
  If not (csDesigning in ComponentState) then begin
    If P_MoveClient<>nil then P_MoveClient.Height := Value;
    MyOnResize (Self);
  end;
end;

function  TScrollPanel.GetMovePanel:TPanel;
begin
  Result := P_MoveClient;
end;

procedure TScrollPanel.SetMovePanel (Value:TPanel);
var I:longint;
begin
  oCompCnt := 0;
  For I:=0 to 500 do
    oComp[I] := '';
  If Value<>nil then begin
    For I:=0 to Value.Parent.ComponentCount-1 do begin
      If Value.Parent.Components[I] is TWinControl then begin
        If (Value.Parent.Components[I] as TWinControl).Parent=Value then  begin
          oComp[oCompCnt] := Value.Parent.Components[I].Name;
          Inc (oCompCnt);
        end;
      end;
    end;
  end;
  P_MoveClient := Value;
  If not (csDesigning in ComponentState) then begin
    If P_MoveClient<>nil then begin
      P_MoveClient.Parent := P_FixClient;
      P_MoveClient.Top := 0;
      P_MoveClient.Left := 0;
      P_MoveClient.Height := oClientHeight;
      P_MoveClient.Width := oClientWidth;
      P_MoveClient.BevelOuter := bvNone;
      MyOnResize (Self);
    end;
  end;
end;


procedure TScrollPanel.MyActiveControlChange(Sender: TObject);
var
  mComp:TComponent;
  Active : TWinControl; I: Integer;
  mLeft,mRight,mTop,mBottom:integer;
begin
  Active := nil;
  For I:= 0 to oCompCnt-1 do begin
    mComp := Owner.FindComponent(oComp[I]);
    If mComp<>nil then  begin
      If mComp is TWinControl then begin
        If (mComp as TWinControl).Focused then begin
          Active := mComp as TWinControl;
          Break;
        end;
      end;
    end;
  end;
  If Active <> nil then begin
    mLeft := (Active as TWinControl).Left;
    mTop := (Active as TWinControl).Top;
    mRight := mLeft+(Active as TWinControl).Width;
    mBottom := mTop+(Active as TWinControl).Height;
    If P_MoveClient.Left+mRight>P_FixClient.Width then P_MoveClient.Left := -(mRight-P_FixClient.Width);
    If P_MoveClient.Top+mBottom>P_FixClient.Height then P_MoveClient.Top := -(mBottom-P_FixClient.Height);
    If mLeft+P_MoveClient.Left<0 then P_MoveClient.Left := -mLeft;
    If mTop+P_MoveClient.Top<0 then P_MoveClient.Top := -mTop;
    If P_MoveClient.Left>0 then P_MoveClient.Left := 0;
    If P_MoveClient.Top>0 then P_MoveClient.Top := 0;
    SC_Horizontal.Position := -1*P_MoveClient.Left;
    SC_Vertical.Position := -1*P_MoveClient.Top;
  end;
end;

constructor TScrollPanel.Create(AOwner: TComponent);
var I:longint;
begin
  inherited Create (AOwner);
  OnResize := MyOnResize;
  Width := 180;
  Height := 40;
  SC_Vertical := TScrollBar.Create(Self);
  SC_Vertical.Parent := Self;
  SC_Vertical.Kind := sbVertical;
  SC_Vertical.Left := Width-SC_Vertical.Width;
  SC_Vertical.Top := 0;
  SC_Vertical.Height := Height-SC_Vertical.Width;
  SC_Vertical.SmallChange := 6;
  SC_Vertical.Anchors := [akTop,akRight,akBottom];
  SC_Vertical.TabStop := FALSE;
  SC_Vertical.OnChange := MyVerticalChange;

  SC_Horizontal := TScrollBar.Create(Self);
  SC_Horizontal.Parent := Self;
  SC_Horizontal.Top := Height-SC_Horizontal.Height;
  SC_Horizontal.Left := 0;
  SC_Horizontal.Width := Width-SC_Horizontal.Height;
  SC_Horizontal.SmallChange := 6;
  SC_Horizontal.Anchors := [akLeft,akRight,akBottom];
  SC_Horizontal.TabStop := FALSE;
  SC_Horizontal.OnChange := MyHorizontalChange;

  P_FixClient := TPanel.Create(Self);
  P_FixClient.Parent := Self;
  P_FixClient.Top := 0;
  P_FixClient.Left := 0;
  P_FixClient.Width :=  Width-SC_Vertical.Width;
  P_FixClient.Height :=  Height-SC_Horizontal.Height;
  P_FixClient.BevelOuter := bvNone;
  P_FixClient.Anchors := [akLeft,akTop,akRight,akBottom];

  oClientWidth  := P_FixClient.Width;
  oClientHeight := P_FixClient.Height;
  MyOnResize (Self);
  oCompCnt := 0;
  For I:=0 to 500 do
    oComp[I] := '';
  Screen.OnActiveControlChange := MyActiveControlChange;
end;

destructor  TScrollPanel.Destroy;
begin
  Screen.OnActiveControlChange := nil;
  FreeAndNil(P_FixClient);
  FreeAndNil(SC_Horizontal);
  FreeAndNil(SC_Vertical);
  inherited Destroy;
end;

procedure Register;
begin
  RegisterComponents('IcStandard', [TScrollPanel]);
end;

end.

