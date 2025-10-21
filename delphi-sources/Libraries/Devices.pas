unit Devices;

interface

uses
  IcTypes, IcVariab, IcText, IcDate, IcConv, TxtCut, TxtWrap,
  NexVar, NexText, NexPath, BtrTable, PQRep_, NexIni,
  Registry,
  Windows, Forms, Classes, SysUtils;

type
  TDevices = class
    constructor Create;
    destructor  Destroy; override;
  private
    oDvcNames: TStrings; // Zoznam pomenovani vsetkych zariadenie
    oDvcValue: TStrings; // Zoznam parametrov vsetkych zariadenie
    oWrap: TTxtWrap;
    // Polozky
    oItemIndex: byte; // Kurzor zoznamu
    oEof: boolean;    // TRUE ak sme na konci zoznamu
    oDvcType: Str10; // Typove oznacenie periferneho zariadenia
    oDvcName: Str50; // Nazov periferneho zariadenia
    oPort: Str4;    // Komunikacny port
    oBaud: Str6;    // Prenosova rychlost
    oData: Str1;    // Pocet data bitov
    oStop: Str1;    // Pocet stop bitov
    oParity: Str1;  // Parita
    oRegister : TRegistry;
    procedure SetRegText (pName,pValue:ShortString);  // Zapis textovych udajov do registra perifirnych zariadeni
    function GetRegText (pName:ShortString):ShortString; // Vycitanie textovych udajov z registra perifirnych zariadeni

    function GetCount:byte; // Pocet perifernych zariadeni
  public
    function FindDevice (pDvcType:Str10):boolean; // Vylada a nacita parametre zadaneho periferneho zeriadenia

    procedure CleaList;  // Vynuluje celu zoznam
    procedure CleaItem;  // Vynuluje polozky
    procedure AddToList; // Prida polozky do zoznamu
    procedure DeleteReg; // Vymaze periferne zariadenia z registrov
    procedure SaveData;  // Ulozi udaje objektu do registru
    procedure First; // Nastavy kurzor zoznamu na prve zariadenie
    procedure Next; // Nastavy kurzor zoznamu na nasledujuce zariadenie
    procedure ReadData;  // Nacita udaje z registra kde stoji kurzor zoznamu
  published
    property Eof:boolean read oEof;
    property Count:byte read GetCount;
    property DvcType:Str10 read oDvcType write oDvcType;
    property DvcName:Str50 read oDvcName write oDvcName;
    property Port:Str4 read oPort write oPort;
    property Baud:Str6 read oBaud write oBaud;
    property Data:Str1 read oData write oData;
    property Stop:Str1 read oStop write oStop;
    property Parity:Str1 read oParity write oParity;
  end;

var gDevices: TDevices;

implementation

constructor TDevices.Create;
var I:byte;
begin
  oItemIndex := 0; // Kurzor zoznamu
  oEof := FALSE;   // TRUE ak sme na konci zoznamu
  oWrap := TTxtWrap.Create;
  oWrap.SetDelimiter('');
  oWrap.SetSeparator(',');
  oDvcNames := TStringList.Create;
  oDvcValue := TStringList.Create;
  oRegister := TRegistry.Create;
  oRegister.RootKey := HKEY_LOCAL_MACHINE;
  oRegister.OpenKey('\SOFTWARE\ICC\NEX\Devices',TRUE);
  oRegister.GetValueNames(oDvcNames);
  If oDvcNames.Count>0 then begin
    For I:=0 to oDvcNames.Count-1 do begin
      If oRegister.GetDataType(oDvcNames[I])=rdString then oDvcValue.Add(oRegister.ReadString (oDvcNames[I]));
    end;  
  end;
end;

destructor TDevices.Destroy;
begin
  FreeAndNil (oRegister);
  FreeAndNil (oDvcNames);
  FreeAndNil (oDvcValue);
  FreeAndNil (oWrap);
end;

// ***************************** PRIVATE ***************************

procedure TDevices.SetRegText (pName,pValue:ShortString);  // Zapis textovych udajov do registra perifirnych zariadeni
begin
  oRegister.WriteString (pName,pValue);
end;

function TDevices.GetRegText (pName:ShortString):ShortString; // Vycitanie textovych udajov z registra perifirnych zariadeni
begin
  Result := '';
  If oRegister.ValueExists (pName) then Result := oRegister.ReadString (pName)
end;

function TDevices.GetCount:byte; // Pocet perifernych zariadeni
begin
  Result := oDvcNames.Count;
end;

// **************************** PUBLIC ***************************

function TDevices.FindDevice (pDvcType:Str10):boolean; // Vylada a nacita parametre zadaneho periferneho zeriadenia
begin
  Result := FALSE;
  If Count>0 then begin
    First;
    Repeat
      Result := oDvcNames.Strings[oItemIndex]=pDvcType;
      Next;
    until Result or Eof;
    If Result then ReadData;
  end;
end;

procedure TDevices.CleaList; // Vynuluje celu zoznam
begin
  oDvcNames.Clear; // Zoznam pomenovani vsetkych zariadenie
  oDvcValue.Clear; // Zoznam parametrov vsetkych zariadenie
end;

procedure TDevices.CleaItem; // Vynuluje polozky
begin
  oDvcType := '';  // Typove oznacenie periferneho zariadenia
  oDvcName := '';  // Nazov periferneho zariadenia
  oPort := '';    // Komunikacny port
  oBaud := '';    // Prenosova rychlost
  oData := '';    // Pocet data bitov
  oStop := '';    // Pocet stop bitov
  oParity := '';  // Parita
end;

procedure TDevices.AddToList; // Prida polozky do zoznamu
begin
  oDvcNames.Add(oDvcType);
  oWrap.ClearWrap;
  oWrap.SetText(oPort,0);
  oWrap.SetText(oBaud,0);
  oWrap.SetText(oData,0);
  oWrap.SetText(oStop,0);
  oWrap.SetText(oParity,0);
  oWrap.SetText(oDvcName,0);
  oDvcValue.Add(oWrap.GetWrapText);
end;

procedure TDevices.DeleteReg; // Vymaze periferne zariadenia z registrov
var mDvcnames:TStrings;  mCnt:byte;
begin
  // Vymazeme vsetky periferne zariadenia z registra
  mDvcNames := TStringList.Create;
  oRegister.GetValueNames(mDvcNames);
  If mDvcNames.Count>0 then begin
    mCnt := 0;
    Repeat
      oRegister.DeleteValue(mDvcNames.Strings[mCnt]);
      Inc (mCnt);
    until mCnt=mDvcNames.Count
  end;
  FreeAndNil (mDvcNames);
end;

procedure TDevices.SaveData; // Ulozi udaje objektu do registru
var mCnt:byte;
begin
  DeleteReg; // Vymaze periferne zariadenia z registrov
  // Ulozime udaje do registrov
  If oDvcNames.Count>0 then begin
    mCnt := 0;
    Repeat
      oRegister.WriteString (oDvcNames.Strings[mCnt],oDvcValue.Strings[mCnt]);
      Inc (mCnt);
    until mCnt=oDvcNames.Count;
  end;
end;

procedure TDevices.First; // Nastavy kurzor zoznamu na prve zariadenie
begin
  oEof := FALSE;
  oItemIndex := 0;
  ReadData;
end;

procedure TDevices.Next; // Nastavy kurzor zoznamu na nasledujuce zariadenie
begin
  If oItemIndex<oDvcNames.Count-1 then begin
    Inc (oItemIndex);
    ReadData;
  end
  else oEof := TRUE;
end;

procedure TDevices.ReadData;  // Nacita udaje z registra kde stoji kurzor zoznamu
var mCut:TTxtCut;
begin
  mCut := TTxtCut.Create;
  mCut.SetDelimiter('');
  mCut.SetSeparator(',');
  mCut.SetStr(oDvcValue.Strings[oItemIndex]);
  oDvcType := oDvcNames.Strings[oItemIndex];  // Typove oznacenie periferneho zariadenia
  oPort := mCut.GetText(1);     // Komunikacny port
  oBaud := mCut.GetText(2);     // Prenosova rychlost
  oData := mCut.GetText(3);     // Pocet data bitov
  oStop := mCut.GetText(4);     // Pocet stop bitov
  oParity := mCut.GetText(5);   // Parita
  oDvcName := mCut.GetText(6);  // Nazov periferneho zariadenia
end;

end.
