unit hJob;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, bJOB,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TJobHnd = class (TJobBtr)
  private
  public
    function GetBokNum:Str5; // Cislo otvorenej knihy
    function GetActive:boolean; // TRUE ak databaza je otvorena
  published
    property BokNum:Str5 read GetBokNum;
    property Active:boolean read GetActive;
  end;

implementation

function TJobHnd.GetBokNum:Str5;
begin
  Result := BtrTable.BookNum;
end;

function TJobHnd.GetActive:boolean;
begin
  Result := BtrTable.Active;
end;

end.
