unit DocLst;
{$F+}

interface

uses
  IcTypes, IcConv, IcTools, SysUtils, Classes;

type
  TDocLst = class
    constructor Create;
    destructor Destroy; override;
  private
    oIndex:integer;
    oDocLst:TStrings;
  public
    function GetCount:integer;
    function GetDocNum:Str12;
    function Locate (pDocNum:Str12):boolean;
    function Bof:boolean;
    function Eof:boolean;
    procedure Add (pDocNum:Str12);
    procedure Clear;
    procedure First;
    procedure Last;
    procedure Next;
    procedure Prior;
  published
    property Count:integer read GetCount;
    property DocNum:Str12 read GetDocNum;
  end;

implementation

constructor TDocLst.Create;
begin
  oIndex := 0;
  oDocLst := TStringList.Create;
end;

destructor TDocLst.Destroy;
begin
  FreeAndNil (oDocLst);
end;

// *********************************** PRIVATE *********************************

function TDocLst.GetCount:integer;
begin
  Result := oDocLst.Count;
end;

function TDocLst.GetDocNum:Str12;
begin
  Result := oDocLst.Strings[oIndex];
end;

function TDocLst.Locate (pDocNum:Str12):boolean;
var mIndex:integer;
begin
  If Count>0 then begin
    mIndex := 0;
    Repeat
      Result := oDocLst.Strings[mIndex]=pDocNum;
      If not Result then Inc (mIndex);
    until Result or (mIndex=Count);
  end
  else Result := FALSE;
end;

// *********************************** PUBLIC **********************************

function TDocLst.Bof:boolean;
begin
  Result := (oIndex=0);
end;

function TDocLst.Eof:boolean;
begin
  Result := (oIndex=oDocLst.Count);
end;

procedure TDocLst.Add (pDocNum:Str12);
begin
  If not Locate(pDocNum) then oDocLst.Add (pDocNum);
end;

procedure TDocLst.Clear;
begin
  oDocLst.Clear;
end;

procedure TDocLst.First;
begin
  oIndex := 0;
end;

procedure TDocLst.Last;
begin
  oIndex := oDocLst.Count-1;
end;

procedure TDocLst.Next;
begin
  If not Eof then Inc (oIndex)
end;

procedure TDocLst.Prior;
begin
  If not Bof then Dec (oIndex)
end;

end.
