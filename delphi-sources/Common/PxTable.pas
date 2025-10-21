unit PxTable;

interface

uses
  NexPath, IcTypes, IcConv,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DbTables;

type
  TPxStatusRec = packed record
    IndexName  : String[30];
    Position   : TBookmark;
    Filter     : string;
    Filtered   : boolean;
  end;
  TPxTable = class(TTable)
  private
    oGroupName    : Str20;
    oMoreOpen     : boolean; // TRUE ak databazovy subor uz bol otvoreny
    oIndexName    : string; // Na ukladanie nazvu indexu pri volani SwapIndex
    oBookMark     : TBookmark;// Pozicia v databaze
    oStatusRec    : array [1..10] of TPxStatusRec;
    oSwapNum      : byte;
  public
    procedure Open; overload;
    procedure SwapIndex;
    procedure RestoreIndex;
    procedure SwapStatus;
    procedure RestoreStatus;
  end;

procedure Register;

implementation

procedure TPxTable.Open;
begin
  If Active then Close;
  DatabaseName := gPath.SubPrivPath;
  oSwapNum     := 0;
  inherited Open;
end;

procedure TPxTable.SwapIndex;
begin
  oIndexName := IndexName;
end;

procedure TPxTable.RestoreIndex;
begin
  If oIndexName<>IndexName then IndexName := oIndexName;
end;

procedure TPxTable.SwapStatus;
begin
  Inc (oSwapNum);
  oStatusRec[oSwapNum].IndexName   := IndexName;
  oStatusRec[oSwapNum].Position    := GetBookMark;
  oStatusRec[oSwapNum].Filter      := Filter;
  oStatusRec[oSwapNum].Filtered    := Filtered;
end;

procedure TPxTable.RestoreStatus;
begin
  IndexName   := oStatusRec[oSwapNum].IndexName;
  Filter      := oStatusRec[oSwapNum].Filter;
  Filtered    := oStatusRec[oSwapNum].Filtered;
  GotoBookMark(oStatusRec[oSwapNum].Position);
  Dec(oSwapNum);
end;

procedure Register;
begin
  RegisterComponents('IcDataAccess', [TPxTable]);
end;

end.
