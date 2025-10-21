unit PerFnc;

interface

uses
  IcTypes, IcConv, IcVariab, IcTools, NexPath, NexClc, NexGlob, ePERLST,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs, Forms, DateUtils;

type
  TPerFnc=class
    constructor Create;
    destructor Destroy; override;
  private
  public
    ohPERLST:TperlstHne;  // Zoznam osob
  end;

implementation

constructor TPerFnc.Create;
begin
  ohPERLST:=TPerlstHne.Create;
end;

destructor TPerFnc.Destroy;
begin
  FreeAndNil(ohPERLST);
end;

// ******************************** PRIVATE ************************************

// ********************************* PUBLIC ************************************

end.


