unit ParCat;
{$F+}
// =============================================================================
//                          FUNKCIE KATAL�GU PARTNEROV
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// ************************* POU�IT� DATAB�ZOV� S�BORY *************************
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// *********************** POPIS PRIVATE FUNKCI� OBJEKTU ***********************
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// ************************ POPIS PUBLIC FUNKCI� OBJEKTU ***********************
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// ********************************* POZN�MKY **********************************
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ****************************** HIST�RIA ZMIEN *******************************
// -----------------------------------------------------------------------------
//
// =============================================================================
interface

uses
  IcTypes, IcConv, IcTools, IcVariab, SysUtils, Forms, NexIni,
  hPARCAT;

type
  TParCat=class
    constructor Create;
    destructor Destroy; override;
    private
      function GetParNam(pParNum:longint):Str60;
      function GetPlsNum(pParNum:longint):word;
      function GetAplNum(pParNum:longint):word;
      function GetDscPrc(pParNum:longint):double;
    public
      ohPARCAT:TParcatHnd;    // Katal�g partnerov
      function GetNextParNum:longint;
      property ParNam[pParNum:longint]:Str60 read GetParNam;   // N�zov firmy
      property PlsNum[pParNum:longint]:word read GetPlsNum;    // Perdajn� cennn�k partnera
      property AplNum[pParNum:longint]:word read GetAplNum;    // Akciov� cennn�k partnera
      property DscPrc[pParNum:longint]:double read GetDscPrc;  // Firemn� z�ava v %
  end;

implementation

constructor TParCat.Create;
begin
  ohPARCAT:=TParcatHnd.Create;
end;

destructor TParCat.Destroy;
begin
  FreeAndnil(ohPARCAT);
end;

// ********************************* PRIVATE ***********************************

function TParCat.GetParNam(pParNum:longint):Str60;
begin
  Result:='';
  If ohPARCAT.LocParNum(pParNum) then Result:=ohPARCAT.ParNam;
end;

function TParCat.GetPlsNum(pParNum:longint):word;
begin
  Result:=0;
  If ohPARCAT.LocParNum(pParNum) then Result:=ohPARCAT.PlsNum;
  If Result=0 then Result:=gIni.MainPls; // Hlavn� cenn�k
end;

function TParCat.GetAplNum(pParNum:longint):word;
begin
  Result:=0;
  If ohPARCAT.LocParNum(pParNum) then Result:=ohPARCAT.AplNum;
end;

function TParCat.GetDscPrc(pParNum:longint):double;
begin
  Result:=0;
  If ohPARCAT.LocParNum(pParNum) then Result:=ohPARCAT.DscPrc;
end;

// ********************************** PUBLIC ***********************************

function TParCat.GetNextParNum:longint;
begin
  ohPARCAT.SwapIndex;
  ohPARCAT.SetIndex(ixParNum);
  ohPARCAT.Last;
  Result := ohPARCAT.ParNum+1;
  ohPARCAT.RestIndex;
end;

end.


