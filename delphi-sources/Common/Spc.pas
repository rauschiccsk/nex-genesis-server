unit Spc;
{$F+}

// *****************************************************************************
//                   OBJEKT NA PRACU SO POZICNYMI KARATMI
// *****************************************************************************
// Programové funkcia:
// ---------------
// xxx -
// *****************************************************************************


interface

uses
  IcTypes, IcConst, IcConv, IcTools, IcDate, NexGlob, NexPath, NexMsg, Key, //DocHand,
  hSPC, tSPC, hSPM, hSTK, hTRMLST,  
  NexBtrTable, NexPxTable, ComCtrls, SysUtils, Classes, Forms;

type
  TSpc=class(TComponent)
    constructor Create;
    destructor  Destroy; override;
    private
      oSpc:TList; // Zoznam skladovych pozicii
      oSpm:TList; // Pohyby na skladovych poziciach
      oStk:TList; // Skladové karty zásob
      procedure SetStkNum(pStkNum:word); // Otvori skladove subory na zadany sklad
      procedure Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
    public
      ohSPC:TSpcHnd;
      ohSPM:TSpmHnd;
      ohSTK:TStkHnd;
      otSPC:TSpcTmp;
      function GetOpenCount:word; // Pocet otvorenych skladov
      procedure Clc(pPoCode:Str15;pGsCode:longint); // Prepocita mnozstvo na zadanej skladovej pozicie podla pohybov
      procedure SlcItm(pGsCode:longint); // Uloží poozície vybraného tovru do doèasnej databáze
    published
      property StkNum:word write SetStkNum;
  end;

implementation

uses bSPC;

constructor TSpc.Create;
begin
  oSpc:=TList.Create;  oSpc.Clear;
  oSpm:=TList.Create;  oSpm.Clear;
  oStk:=TList.Create;  oStk.Clear;
  ohSPC:=TSpcHnd.Create;
  ohSPM:=TSpmHnd.Create;
  ohSTK:=TStkHnd.Create;
  otSPC:=TSpcTmp.Create;
end;

destructor TSpc.Destroy;
var I:word;
begin
  FreeAndNil(otSPC);
  If oSpc.Count>0 then begin
    For I:=0 to oSpc.Count-1 do begin
      Activate(I);
      FreeAndNil(ohSTK);
      FreeAndNil(ohSPC);
      FreeAndNil(ohSPM);
    end;
  end;
  FreeAndNil(oStk);
  FreeAndNil(oSpc);
  FreeAndNil(oSpm);
end;

// ********************************* PRIVATE ***********************************

procedure TSpc.SetStkNum(pStkNum:word); // Otvori skladove subory na zadany sklad
var mFind:boolean;  mCnt:word;
begin
  mFind:=FALSE;
  If oSpc.Count>0 then begin
    mCnt:=0;
    Repeat
      Activate(mCnt);
      mFind:=ohSPC.BtrTable.ListNum=pStkNum;
      Inc(mCnt);
    until mFind or (mCnt=oSpc.Count);
  end;
  If not mFind then begin // Ak dana kniha este nie je otvorena potomotvorime
    ohSTK:=TStkHnd.Create;  ohSTK.Open(pStkNum);   oStk.Add(ohSTK);
    ohSPC:=TSpcHnd.Create;  ohSPC.Open(pStkNum);   oSpc.Add(ohSPC);
    ohSPM:=TSpmHnd.Create;  ohSPM.Open(pStkNum);   oSpm.Add(ohSPM);
  end;
end;                                 

procedure TSpc.Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
begin
  ohSTK:=oStk.Items[pIndex];
  ohSPC:=oSpc.Items[pIndex];
  ohSPM:=oSpm.Items[pIndex];
end;

// ********************************** PUBLIC ***********************************

procedure TSpc.Clc(pPoCode:Str15;pGsCode:longint); // Prepocita mnozstvo na zadanej skladovej pozicie podla pohybov
begin
  ohSPC.Clc(pPoCode,pGsCode,ohSPM);
end;

procedure TSpc.SlcItm(pGsCode:longint); // Uloží poozície vybraného tovru do doèasnej databáze
begin
  otSPC.Open;
  If ohSPC.LocateGsCode(pGsCode) then begin
    Repeat
      otSPC.Insert;
      BTR_To_PX(ohSPC.BtrTable,otSPC.TmpTable);
      otSPC.SorStr:=ohSPC.PoCode+DateToDDMMYYYY(0);
      otSPC.Post;
      ohSPC.Next;
    until ohSPC.Eof or (ohSPC.GsCode<>pGsCode);
  end;
end;

function TSpc.GetOpenCount:word;
begin
  Result:=oSpc.Count;
end;

end.
