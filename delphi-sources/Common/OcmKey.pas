unit OcmKey;

interface

uses
  IcTypes, IcConv, IcVariab, NexPath, NexGlob, NexIni, hKEYDEF,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

type
  TOcmKey = class (TComponent)
    constructor Create(phKEYDEF:TKeydefHnd);
    destructor  Destroy; override;
  private
    ohKEYDEF:TKeydefHnd;
    function ReadComExp:boolean;   procedure WriteComExp(pValue:boolean);
    function ReadNewRes:boolean;   procedure WriteNewRes(pValue:boolean);
  public
    property ComExp:boolean read ReadComExp write WriteComExp;     // Kompletná expedícia rozdelených položiek
    property NewRes:boolean read ReadNewRes write WriteNewRes;     // Nový rezervaèný systém
  end;

implementation

constructor TOcmKey.Create(phKEYDEF:TKeydefHnd);
begin
  ohKEYDEF:=phKEYDEF;
end;

destructor TOcmKey.Destroy;
begin
end;

// ******************************** PRIVATE ************************************

function TOcmKey.ReadComExp:boolean;
begin
  Result:=ohKEYDEF.ReadBoolean('OCM','','ComExp',FALSE);
end;

procedure TOcmKey.WriteComExp(pValue:boolean);
begin
  ohKEYDEF.WriteBoolean('OCM','','ComExp',pValue);
end;

function TOcmKey.ReadNewRes:boolean;
begin
  Result:=ohKEYDEF.ReadBoolean('OCM','','NewRes',FALSE);
end;

procedure TOcmKey.WriteNewRes(pValue:boolean);
begin
  ohKEYDEF.WriteBoolean('OCM','','NewRes',pValue);
end;

// ********************************* PUBLIC ************************************

end.


