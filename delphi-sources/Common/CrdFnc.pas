unit CrdFnc;

interface

uses
  IcTypes, IcConv, IcVariab, IcTools, IcDate, NexPath, NexClc, NexGlob, eCRDLST, eCRDGRP, eCRDBON,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs, Forms, DateUtils;

type
  TCrdFnc=class
    constructor Create;
    destructor Destroy; override;
  private
  public
    ohCRDLST:TCrdlstHne;
    ohCRDGRP:TCrdgrpHne;
    ohCRDBON:TCrdbonHne;
  end;

implementation

constructor TCrdFnc.Create;
begin
  ohCRDLST:=TCrdlstHne.Create;
  ohCRDGRP:=TCrdgrpHne.Create;
  ohCRDBON:=TCrdbonHne.Create;
end;

destructor TCrdFnc.Destroy;
begin
  FreeAndNil(ohCRDBON);
  FreeAndNil(ohCRDGRP);
  FreeAndNil(ohCRDLST);
end;

// ******************************** PRIVATE ************************************

// ********************************* PUBLIC ************************************

end.


