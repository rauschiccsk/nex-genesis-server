unit ParHand;
// *****************************************************************
// Tento unit sluzi na pracu so zlozitymi parametrami ako napr:
// PAR1[ident1=value1],PAR2[ident2=value2]
// Propery:
//  - Line - je to PAR1[ident1=value1],PAR2[ident2=value2]
//  - ParLine - je to PAR1[definicia1=hodnota1]
//  - DefLine - je to definicia1=hodnota1
//  - ParIdent - je to PAR1
//  - DefIdent - je to definicia1
//  - DefValue - je to hodnota1
// *****************************************************************

interface

uses
  IcTypes, IcConv, IcTools, TxtCut, NexError, NexGlob,
  Dialogs, Classes, SysUtils;

type
  TParHand = class
    constructor Create;
    destructor Destroy; override;
  private
    oParList:TStrings; // Zoznam parametrov
    function GetParCount:byte;  // Pocet parametrov
    procedure SetLine (pValue:string);
  public
    function ParExist (pName:ShortString):boolean; // TRUE akv zadanom riadku existuje parameter pod nazvom pName
    function ParValue (pName:ShortString):ShortString;
  published
    property Line:string write SetLine;
    property ParCount:byte read GetParCount;
  end;

implementation

constructor TParHand.Create;
begin
  oParList := TStringList.Create; // Zoznam parametrov
end;

destructor TParHand.Destroy;
begin
  FreeAndNil (oParList);
end;

procedure TParHand.SetLine (pValue:string);
var mCut:TTxtCut;  I:byte;
begin
  If pValue<>'' then begin
    mCut := TTxtCut.Create;
    mCut.SetDelimiter('');  mCut.SetSeparator(',');
    mCut.SetStr(pValue);
    For I:=1 to mCut.Count do
      oParList.Add (mCut.GetText(I));
    FreeAndNil (mCut);
  end;
end;

function TParHand.GetParCount:byte;  // Pocet parametrov
begin
  Result := oParList.Count;
end;

function TParHand.ParExist (pName:ShortString):boolean; // TRUE akv zadanom riadku existuje parameter pod nazvom pName
var mText:ShortString;  mCnt,mPos:byte;
begin
  Result := FALSE;
  If ParCount>0 then begin
    mCnt := 0;
    Repeat
      mPos := Pos('[',oParList.Strings[mCnt]);
      If mPos>0
        then mText := copy(oParList.Strings[mCnt],1,mPos-1)
        else mText := oParList.Strings[mCnt];
      Result := mText=pName;
      Inc(mCnt);
    until (mCnt>=ParCount) or Result;
  end;
end;

function TParHand.ParValue (pName:ShortString):ShortString;
var mText:ShortString;  mCnt,mPos1,mPos2:byte;
begin
  Result := '';
  If ParCount>0 then begin
    mCnt := 0;
    Repeat
      mPos1 := Pos('[',oParList.Strings[mCnt]);
      mPos2 := Pos(']',oParList.Strings[mCnt]);
      If (mPos1>0) and (mPos2>mPos1) then Result := copy(oParList.Strings[mCnt],mPos1+1,mPos2-mPos1-1);
      Inc(mCnt);
    until (mCnt>=ParCount) or (Result<>'');
  end;
end;

end.
