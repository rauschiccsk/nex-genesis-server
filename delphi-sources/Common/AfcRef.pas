unit AfcRef;

interface

uses
  IcTypes, IcVariab, IcConv, IcFiles, NexVar, TxtWrap, NexIni, NexPath,
  IniFiles, Classes, NexBtrTable, ComCtrls, SysUtils;

type
  TAfcRef = class
    constructor Create;
    destructor Destroy; override;
  private
    oWrap: TTxtWrap;
    oRefFile: TStrings;
  public
  published
    procedure AddToRefData (pCommand:Str1;btAFC:TNexBtrTable); // Prida aktualnu polozku zddaneho cennika do REF udajov
    procedure SaveToRefFile (pIndicator:TProgressBar); // Uloi udaje do REF suborov pre jednotlivych pokladnic
  end;

var gAfcRef:TAfcRef;

implementation

uses DM_CABDAT;

constructor TAfcRef.Create;
begin
  oWrap := TTxtWrap.Create;
  oRefFile := TStringList.Create
end;

destructor TAfcRef.Destroy;
begin
  FreeAndNil (oRefFile);
  FreeAndNil (oWrap);
  inherited Destroy;
end;

procedure TAfcRef.AddToRefData (pCommand:Str1;btAFC:TNexBtrTable); // Prida aktualnu polozku zddaneho cennika do REF udajov
begin
  oWrap.ClearWrap;
  oWrap.SetText (pCommand,1);                               // 1
  oWrap.SetNum (btAFC.FieldByName('GsCode').AsInteger,0);   // 2
  oWrap.SetText (WinStringToDosString(btAFC.FieldByName('GsName').AsString),0);   //  3
  oWrap.SetNum (btAFC.FieldByName('AfcCode').AsInteger,0);  // 4
  oWrap.SetReal (btAFC.FieldByName('AfcQnt').AsFloat,0,2);  // 5
  oRefFile.Add (oWrap.GetWrapText);
end;

procedure TAfcRef.SaveToRefFile (pIndicator:TProgressBar); // Uloi udaje do REF suborov pre jednotlivych pokladnic
var mRef:TStrings; mFileName:ShortString;
begin
  If gIni.PosRefresh then begin
    dmCAB.btCABLST.Open;
    If dmCAB.btCABLST.RecordCount>0 then begin
      If pIndicator<> nil then begin
        pIndicator.Max := dmCAB.btCABLST.RecordCount;
        pIndicator.Position := 0;
      end;
      mRef := TStringList.Create;
      dmCAB.btCABLST.First;
      Repeat
        If pIndicator<> nil  then pIndicator.StepBy(1);
        mRef.Clear;
        mFileName := gPath.CasPath(dmCAB.btCABLST.FieldByname('CasNum').AsInteger)+'AFC.REF';
        If FileExistsI (mFileName) then mRef.LoadFromFile (mFileName);
        mRef.AddStrings (oRefFile);
        mRef.SaveToFile (mFileName);
        dmCAB.btCABLST.Next;
      until (dmCAB.btCABLST.Eof);
      FreeAndNil (mRef);
    end;
    dmCAB.btCABLST.Close;
  end;
end;

end.
