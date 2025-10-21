unit hIcw;

interface

uses
  IcTypes, NexPath, NexGlob, bIcw,
  NexBtrTable, DocHand,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;


type
  TIcwHnd = class (TIcwBtr)
  private
    oIchTable: TNexBtrTable;
    constructor Create; overload;
  public
    procedure IchRefresh(pIcdNum:Str12);  // Obnovi udaje poslednej upomineky
  published
    property IchTable:TNexBtrTable write oIchTable;
  end;

implementation

{ TIcwHnd }

constructor TIcwHnd.Create;
begin
  inherited;
  oIchTable:=nil;
end;

procedure TIcwHnd.IchRefresh(pIcdNum: Str12);
var mWrnNum:byte; mWrnDate:TDateTime;   mBokNum:Str5;
begin
  mWrnNum := 0;  mWrnDate := 0;
  // Najdeme poslednu upomienku
  SwapStatus;
  If LocateIcdNum(pIcdNum)then begin
    Repeat
      If mWrnNum<WrnNum then begin
        mWrnNum := WrnNum;
        mWrnDate := WrnDate;
      end;
      Next;
    until Eof or (IcdNum<>pIcdNum);
  end;
  If oIchTable=nil then oIchTable := BtrInit ('ICH',gPath.LdgPath,Self);
  mBokNum := BookNumFromDocNum(pIcdNum);
  If oIchTable.Active then begin
    If oIchTable.BookNum<>mBokNum then begin
      oIchTable.Close;
      oIchTable.Open(mBokNum);
    end;
  end
  else oIchTable.Open(mBokNum);
  oIchTable.SwapIndex;
  oIchTable.IndexName := 'DocNum';
  If oIchTable.FindKey([pIcdNum]) then begin
    If (oIchTable.FieldByName('WrnNum').AsInteger<>mWrnNum) or (oIchTable.FieldByName('WrnDate').AsDateTime<>mWrnDate)  then begin
      oIchTable.Edit;
      oIchTable.FieldByName('WrnNum').AsInteger := mWrnNum;
      oIchTable.FieldByName('WrnDate').AsDateTime := mWrnDate;
      oIchTable.Post;
    end;
  end;
  oIchTable.RestoreIndex;
  RestoreStatus;
end;

end.
