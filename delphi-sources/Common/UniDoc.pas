unit UniDoc;
{$F+}
//******************************************************************
//
//******************************************************************

interface

uses
  IcTypes, IcConv, IcTools, IcFiles, IniFiles, NexPath, NexIni,
  TxtWrap, TxtCut, StkCanc, DocHand, NexMsg, NexError,
  Forms, Classes, SysUtils;

type
  TUniDoc = class
    constructor Create;
    destructor  Destroy; override;
    private
      oFileName: ShortString; // Nazov textoveho suboru
      oItemCount: longint;  // Pocet riadkov dokladu
      oPos: word; // Poradove cilo polozky na ktorom stoji kurzor objektu
      oFile: TStrings;  // Polozky dokladu
      oCut: TTxtCut;  // Univerzalny ovladac citania textoveho suboru
      oEof: boolean;  // TRUE ak sme na konci suboru poloziek dokladu
    public
      function GetBarCode:Str15;
      function GetGsName:Str30;
      function GetGsQnt:double;
      function GetBPrice:double;
      function GetBValue:double;
      // Funkcie na pracovanie s polozkami dokladu
      procedure First;
      procedure Last;
      procedure Next;

      procedure LoadFromFile (pFileName:string);  // Nacita doklad z textoveho suboru
    published
      property ItemCount:longint read oItemCount;
      property BarCode:Str15 read GetBarCode;
      property GsName:Str30 read GetGsName;
      property GsQnt:double read GetGsQnt;
      property BPrice:double read GetBPrice;
      property BValue:double read GetBValue;
      property Eof:boolean read oEof;
  end;

implementation

uses
   DM_STKDAT;

constructor TUniDoc.Create;
begin
  oItemCount := 0;
  oEof := FALSE;
  oFile := TStringList.Create;
  oCut := TTxtCut.Create;
end;

destructor TUniDoc.Destroy;
begin
  FreeAndNil (oCut);
  FreeAndNil (oFile);
end;

procedure TUniDoc.First;
begin
  oPos := 0;
  oCut.SetStr (oFile.Strings[oPos]);
end;

procedure TUniDoc.Last;
begin
  oPos := oFile.Count-1;
  oCut.SetStr (oFile.Strings[oPos]);
end;

procedure TUniDoc.Next;
begin
  If oPos<oFile.Count-1 then begin
    oEof := False;
    Inc (oPos);
    oCut.SetStr (oFile.Strings[oPos]);
  end
  else oEof := TRUE;
end;

function TUniDoc.GetBarCode:Str15;
begin
  Result := oCut.GetText(1);
end;

function TUniDoc.GetGsName:Str30;
begin
  Result := oCut.GetText(2);
end;

function TUniDoc.GetGsQnt:double;
begin
  Result := oCut.GetReal(3);
end;

function TUniDoc.GetBPrice:double;
begin
  Result := oCut.GetReal(4);
end;

function TUniDoc.GetBValue:double;
begin
  Result := 0;
  If ItemCount>0 then begin
    First;
    Repeat
      Result := Result+BPrice*GsQnt;
      Next;
    until Eof;
  end;
end;

procedure TUniDoc.LoadFromFile (pFileName:string);  // Nacita doklad z textoveho suboru
begin
  oFileName := pFileName;
  oFile.Clear;
  If FileExistsI (pFileName) then oFile.LoadFromFile (pFileName);
  oItemCount := oFile.Count;
end;

// **************************** PRIVATE **************************

end.
