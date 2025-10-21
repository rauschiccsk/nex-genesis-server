unit hIsw;

interface

uses
  IcTypes, NexPath, NexGlob, bIsw, NexBtrTable, DocHand,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;


type
  TIswHnd = class (TIswBtr)
  private
    oIshTable: TNexBtrTable;
    constructor Create; overload;
  public
    procedure IshRefresh(pIsdNum:Str12);  // Obnovi udaje poslednej upomineky
  published
    property IshTable:TNexBtrTable write oIshTable;
  end;

implementation

{ TIswHnd }

constructor TIswHnd.Create;
begin
  inherited ;
  oIshTable:=nil;
end;

procedure TIswHnd.IshRefresh(pIsdNum: Str12);
var mWrnNum:byte; mWrnDate:TDateTime;
begin
  mWrnNum := 0;  mWrnDate := 0;
  // Najdeme poslednu upomienku
  If LocateIsdNum(pIsdNum) then begin
    Repeat
      If mWrnNum<WrnNum then begin
        mWrnNum := WrnNum;
        mWrnDate := WrnDate;
      end;
      Next;
    until Eof or (IsdNum<>pIsdNum);
  end;
  If oIshTable=nil then oIshTable := BtrInit ('ISH',gPath.LdgPath,Self);
  If not oIshTable.Active then oIshTable.Open(BookNumFromDocNum(pIsdNum));
  oIshTable.SwapIndex;
  oIshTable.IndexName := 'DocNum';
  If oIshTable.FindKey([pIsdNum]) then begin
    If (oIshTable.FieldByName('WrnNum').AsInteger<>mWrnNum) or (oIshTable.FieldByName('WrnDate').AsDateTime<>mWrnDate)  then begin
      oIshTable.Edit;
      oIshTable.FieldByName('WrnNum').AsInteger := mWrnNum;
      oIshTable.FieldByName('WrnDate').AsDateTime := mWrnDate;
      oIshTable.Post;
    end;
  end;
  oIshTable.RestoreIndex;
end;

end.
