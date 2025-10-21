unit DbfTable;

interface

uses
  NexPath, IcTypes, IcConv,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DbTables;

type
  TDbfTable = class(TTable)
  public
    constructor Create(AOwner: TComponent); override;
    procedure Open; overload;
  end;

procedure Register;

implementation

constructor TDbfTable.Create(AOwner: TComponent);
begin
  inherited;
  TableType := ttDBase;
end;

procedure TDbfTable.Open;
begin
  If Active then Close;
  inherited Open;
end;

procedure Register;
begin
  RegisterComponents('IcDataAccess', [TDbfTable]);
end;

end.
