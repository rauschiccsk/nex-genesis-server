unit TableView;

interface

uses
  IcTypes, IcConv, IcVariab, IcStand, NexPath, DefRgh,
  SrchGrid, BtrTable,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Tabs, Menus, Db;

type
  TTableView = class(TSrchGrid)
  private
    oShowButtonPanel: boolean;
    procedure SetShowButtonPanel (pValue:boolean);
  public
    constructor Create(AOwner: TComponent); override;
    procedure Loaded; override;
  published
    property ShowButtonPanel: boolean read oShowButtonPanel write SetShowButtonPanel;
  end;

procedure Register;

implementation

constructor TTableView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  BorderStyle := bsNone;
  BevelOuter := bvRaised;
  BevelInner := bvLowered;
  BorderWidth := 3;
  LoginName := gvSys.LoginName;
  If gvSys.Runing then begin
    SetPath := gPath.LngPath;
    DGDPath := gPath.LngPath;
  end;
end;

procedure TTableView.Loaded;
begin
  inherited;
  LoginName := gvSys.LoginName;
  ServiceMode := FALSE;
  If gRgh<>nil then ServiceMode := gRgh.Service or gvSys.DesignMode;
  If gvSys.Runing then begin
    SetPath := gPath.LngPath;
    DGDPath := gPath.LngPath;
  end;
end;

procedure TTableView.SetShowButtonPanel (pValue:boolean);
begin
  oShowButtonPanel := pValue;
  If pValue
    then ToolBarHeight := 28
    else ToolBarHeight := 0;
  Repaint;
end;

// **********************************************************
procedure Register;
begin
  RegisterComponents('IcDataAccess', [TTableView]);
end;

end.
