unit LinLst;
{$F+}

// *****************************************************************************
//            OBJEKT NA PRACU S RIADKOVIM ZOZNAMOM 
// *****************************************************************************
// Programové funkcia:
// ---------------
// *****************************************************************************


interface

uses
  IcTypes, IcConst, IcConv, IcTools, NexGlob, NexPath, NexMsg, RepHand, Key,
  ComCtrls, SysUtils, Classes, Forms;

type
  TLinLst=class(TComponent)
    constructor Create;
    destructor  Destroy; override;
    private
      oIndex:integer;
      function GetCount:word;
      function GetItm:ShortString;
      function GetEof:boolean;
      function GetBof:boolean;
    public
      oLinLst:TStringList;
      function LocItm(pVal:ShortString):boolean;
      procedure Clear;
      procedure AddItm(pVal:ShortString);
      procedure AddLst(pLst:ShortString);
      procedure First;
      procedure Last;
      procedure Next;
      procedure Prior;
      procedure Sort;
    published
      property Count:word read GetCount;
      property Itm:ShortString read GetItm;
      property Eof:boolean read GetEof;
      property Bof:boolean read GetBof;
  end;

implementation

constructor TLinLst.Create;
begin
  oLinLst:=TStringList.Create;
  Clear;
end;

destructor TLinLst.Destroy;
begin
  FreeAndNil (oLinLst);
end;

// ********************************* PRIVATE ***********************************

function TLinLst.GetCount:word;
begin
  Result := oLinLst.Count;
end;

function TLinLst.GetItm:ShortString;
begin
  Result := oLinLst.Strings[oIndex];
end;

function TLinLst.GetEof:boolean;
begin
  Result := oIndex=oLinLst.Count;
end;

function TLinLst.GetBof:boolean;
begin
  Result := oIndex=-1;
end;

// ********************************** PUBLIC ***********************************

function TLinLst.LocItm(pVal:ShortString):boolean;
var mIndex:word;
begin
  Result:=FALSE;
  mIndex:=oIndex;
  If Count>0 then begin
    First;
    Repeat
      Result:=Itm=pVal;
      Next;
    until Eof or Result;
  end;
  oIndex:=mIndex;
end;

procedure TLinLst.Clear;
begin
  oLinLst.Clear;
end;

procedure TLinLst.AddItm(pVal:ShortString);
begin
  If pVal<>'' then oLinLst.Add(pVal);
end;

procedure TLinLst.AddLst(pLst:ShortString);
var I,mQnt:byte;
begin
  If pLst<>'' then begin
    mQnt := LineElementNum(pLst,',');
    For I:=0 to mQnt-1 do
      oLinLst.Add(LineElement(pLst,I,','));
  end;
end;

procedure TLinLst.First;
begin
  oIndex := 0;
end;

procedure TLinLst.Last;
begin
  oIndex := oLinLst.Count-1;
end;

procedure TLinLst.Next;
begin
  If oIndex<oLinLst.Count then Inc(oIndex);
end;

procedure TLinLst.Prior;
begin
  If oIndex>-1 then Dec(oIndex);
end;

procedure TLinLst.Sort;
begin
  oLinLst.Sort;
end;

end.
