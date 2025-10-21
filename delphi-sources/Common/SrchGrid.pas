unit SrchGrid;


interface

uses
  IcVariab,
  AdvGrid, Windows, SysUtils,
  BtrTable, DefRgh, StdCtrls,
  DBSrGrid_GridSum, DBSrGrid,
  IcTools, IcConv, DBTables, DB, Classes;

type
  TDatabaseType = (dtStandard, dtBtrieve);     

  TSrchGrid = class (TAdvGrid)
  private
    oDatabaseType: TDatabaseType;
  protected
    procedure CreateWnd; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;

    procedure   SetActIndex;
  published
    property DatabaseType:TDatabaseType read oDatabaseType write oDatabaseType;
    property Visible;
  end;

procedure Register;

implementation

constructor TSrchGrid.Create(AOwner: TComponent);
begin
  inherited Create (AOwner);
  oDBSrGrid.oDBGridReadOnly    := TRUE;
  oDBSrGrid.oDBGridMultiSelect := FALSE;
  oDBSrGrid.oDBGrid.ReadOnly   := TRUE;
  ShowRecNo  := FALSE;

  oDatabaseType := dtBtrieve;
end;

destructor TSrchGrid.Destroy;
begin
  inherited Destroy;
end;

procedure  TSrchGrid.SetActIndex;
begin
  If oDBSrGrid.DataSet<>nil then begin
    If oDBSrGrid.DataSet is TBtrieveTable then begin
      oDBSrGrid.SetExtIndexName((oDBSrGrid.DataSet as TBtrieveTable).IndexName);
    end else begin
      oDBSrGrid.SetExtIndexName((oDBSrGrid.DataSet as TTable).IndexName);
    end;
  end;
end;

procedure TSrchGrid.CreateWnd;
begin
  inherited CreateWnd;
  ServiceMode := FALSE;
  If gRgh<>nil then ServiceMode := gRgh.Service or gvSys.DesignMode;
end;

procedure Register;
begin
  RegisterComponents('IcDataAccess', [TSrchGrid]);
end;

end.
