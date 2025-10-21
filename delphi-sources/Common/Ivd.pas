unit Ivd;
{$F+}

// *****************************************************************************
//                               OBJEKT NA PRACU S INVENTUROU
// *****************************************************************************
// Programové funkcia:
// ---------------
// IVI.BDF IVD.BDF IVL.BDF SPC.BDF ivdlst.bdf IVI.TDF
// *****************************************************************************


interface

uses
  IcTypes, IcConst, IcConv, IcTools, IcValue, IcVariab,
  DocHand, NexGlob, NexPath, LinLst, Bok, Rep, Key, Stk, Plc, Spc, btrtools,
  hIVDLST, hIVD, hIVI, hIVR, tIVI, hIVL,
  ComCtrls, SysUtils, Classes, Forms, MxArrays;

type
  TIvd=class(TComponent)
    constructor Create(AOwner: TComponent);
    destructor  Destroy; override;
    private
      oFrmName:Str15;
      oIvdClc:TStrings;
      oInd:TProgressBar;
      oIVL:TList;
      oIVD:TList;
      oIVI:TList;
      oCompStr:String;
      oStkNum : integer;
      oClosed : integer;
      function GetIvdNum:integer;     procedure SetIvdNum(pIvdNum:integer);
      function GetIvlNum:integer;     procedure SetIvlNum(pIvlNum:integer);
      function GetOpenCount:word;
      procedure Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
    public
      ohIVDLST:TIvdlstHnd;
      ohIVL:TIvlHnd;
      ohIVD:TIvdHnd;
      ohIVI:TIviHnd;
      ohIVR:TIvrHnd;
      otIVI:TIviTmp;
      oSpc:TSpc;

      procedure OpenLst(pBokLst:ShortString); // Otvori vsetky knihy ktore su zadane v retazci

//      procedure SlcIvi(pGsCode:longint{;pPosCode:Str15}); // nacita polozky zadaneho harku do PX
      procedure SlcIvl(pIvlNum:integer); // nacita polozky zadaneho harku do PX
      procedure SlcGsc(pGsCode:integer); // nacita polozky zadaneho tovaru do PX

      procedure DocClc; overload; // Prepocita hlavicku zadaneho dokladu podla jeho poloziek
      procedure DocClc(pIvdNum:integer); overload; // Prepocita hlavicku zadaneho dokladu podla jeho poloziek
      procedure DocPrn(pIvdNum:integer); // Vytlaèí zadany doklad
      procedure LstClc; // Prepocita hlavicky dokladov ktore su uvedene v zozname oImhClc
      function  DocDel(pIvdNum:integer;pHedDel:boolean):boolean;  // Zrusi zadany doklad
      function  ItmDel(pIvlNum:integer;pItmNum:longint):boolean; // Zrusi zadanu polozku
      procedure TmpRef(pIvlNum,pGsCode:longint;pPoCode:Str15); // Obnovy zaznam na zaklade BTR
    published
      property OpenCount:word read GetOpenCount;
      property IvdNum:longint read GetIvdNum write SetIvdNum;
      property IvlNum:longint read GetIvlNum write SetIvlNum;
      property Ind:TProgressBar read oInd write oInd;
      property StkNum:longint read oStkNum write oStkNum;
      property Closed:longint read oClosed write oClosed;
  end;

implementation

uses NexBtrTable, bIVL,bIVD,bIVI, bSPC;

constructor TIvd.Create(AOwner: TComponent);
begin
  oFrmName:=AOwner.Name;
  oIVDClc:=TStringList.Create;  oIVDClc.Clear;
  oSpc:=TSpc.Create;
  ohIVDLST:=TIvdlstHnd.Create;  ohIVDLST.Open;
  oIVL:=TList.Create;  oIVL.Clear;
  oIVD:=TList.Create;  oIVD.Clear;
  oIVI:=TList.Create;  oIVI.Clear;
  otIVI:=TIVITmp.Create;
  ohIVL:=TIvlHnd.Create;
  ohIVD:=TIvdHnd.Create;
  ohIVI:=TIviHnd.Create;
  ohIVR:=TIvrHnd.Create;
end;

destructor TIvd.Destroy;
var I:word;
begin
  If oIVD.Count>0 then begin
    For I:=0 to oIVD.Count-1 do begin
      Activate (I);
      FreeAndNil(ohIVI);
      FreeAndNil(ohIVD);
      FreeAndNil(ohIVL);
    end;
  end else begin
    FreeAndNil(ohIVR);
    FreeAndNil(ohIVI);
    FreeAndNil(ohIVD);
    FreeAndNil(ohIVL);
  end;
  If otIVI.Active then otIVI.Close;
  FreeAndNil(otIVI);
  FreeAndNil(oIVI);
  FreeAndNil(oIVD);
  FreeAndNil(oIVL);
  FreeAndNil(oSpc);
  FreeAndNil(oIVDClc);
  FreeAndNil(ohIVDLST);
end;

// ********************************* PRIVATE ***********************************

function TIvd.GetIvdNum:integer;
begin
  Result:=ohIVD.BtrTable.ListNum;
end;

procedure TIvd.SetIvdNum (pIvdNum:integer);
var mFind:boolean;  mCnt:word;
begin
  mFind:=FALSE;
  If oIVD.Count>0 then begin
    mCnt:=0;
    Repeat
      Activate(mCnt);
      mFind:=ohIVD.BtrTable.ListNum=pIvdNum;
      Inc (mCnt);
    until mFind or (mCnt=oIVD.Count);
  end;
  If not mFind then begin // Ak dana kniha este nie je otvorena potomotvorime
    ohIVL:=TIVLHnd.Create;  ohIVL.Open(pIvdNum);   oIVL.Add(ohIVL);
    ohIVD:=TIVDHnd.Create;  ohIVD.Open(pIvdNum);   oIVD.Add(ohIVD);
    ohIVI:=TIVIHnd.Create;  ohIVI.Open(pIvdNum);   oIVI.Add(ohIVI);
  end;
end;

procedure TIvd.SetIvlNum (pIvlNum:integer);
begin
  If ohIVL.Count>0 then ohIVL.LocateSerNum(pIvlNum);
end;

function TIvd.GetIvlNum:integer;
begin
  Result:=ohIVL.SerNum;
end;

function TIvd.GetOpenCount:word;
begin
  Result:=oIVD.Count;
end;

procedure TIvd.Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
begin
  ohIVL:=oIVL.Items[pIndex];
  ohIVD:=oIVD.Items[pIndex];
  ohIVI:=oIVI.Items[pIndex];
end;

// ********************************** PUBLIC ***********************************

procedure TIvd.OpenLst(pBokLst:ShortString); // Otvori vsetky knihy ktore su zadane v retazci
var mLinLst:TLinLst;
begin
  mLinLst:=TLinLst.Create;
  mLinLst.AddLst(pBokLst);
  If mLinLst.Count>0 then begin
    mLinLst.First;
    Repeat
      If gBok.BokExist('IVD',mLinLst.Itm,TRUE) then begin
        IvdNum:=Valint(mLinLst.Itm);
      end;
      Application.ProcessMessages;
      mLinLst.Next;
    until mLinLst.Eof;
  end;
  FreeAndNil (mLinLst);
end;

procedure TIvd.SlcIvl(pIvlNum:integer); // Nacita polozky zadaneho harku do PX
var mCnt:longint;
begin
//  IvdNum:=pIvdNum;
  If otIVI.Active then otIVI.Close;
  otIVI.Open;
  If ohIVI.LocateIvlNum(pIvlNum) then begin
    mCnt:=0;
    Repeat
      Inc(mCnt);
      otIVI.Insert;
      BTR_To_PX (ohIVI.BtrTable,otIVI.TmpTable);
      otIVI.Post;
      Application.ProcessMessages;
      ohIVI.Next;
    until ohIVI.Eof or (ohIVI.IvlNum<>pIvlNum);
  end;
end;

procedure TIvd.SlcGsc(pGsCode:integer); // nacita polozky zadaneho tovaru do PX
begin
//  IvdNum:=pIvdNum;
  If otIVI.Active then otIVI.Close;
  otIVI.Open;
  If ohIVI.NearestGsPc(pGsCode,'') then begin
    while not ohIVI.Eof and (ohIVI.GsCode=pGsCode)do begin
      otIVI.Insert;
      BTR_To_PX (ohIVI.BtrTable,otIVI.TmpTable);
      otIVI.Post;
      Application.ProcessMessages;
      ohIVI.Next;
    end;
  end;
end;

procedure TIvd.DocClc;
begin
end;

procedure TIvd.DocClc(pIvdNum:integer);
begin
end;

procedure TIvd.DocPrn(pIvdNum:integer); // Vytlaèí zadany dodaci list
var mRep:TRep;
begin
(*
  IvdNum:=BookNumFromDocNum(pDocNum);
  If ohIVD.LocateDocNum(pDocNum) then begin
    mRep:=TRep.Create(Self);
    mRep.HedBtr:=ohIVD.BtrTable;
    mRep.ItmTmp :=
    mRep.Execute('IMD');
    FreeAndNil (mRep);
  end;
*)
end;

procedure TIvd.LstClc; // Prepocita hlavicky zakazkovych dokladov ktore su uvedene v zozname oOchClc
var I:word;
begin
  If oIVDClc.Count>0 then begin  // Mame doklady na prepocitanie
    For I:=0 to oIVDClc.Count-1 do begin
      IvdNum:=ValInt(Copy(oIVDClc.Strings[I],5,8));
      DocClc(Valint(oIVDClc.Strings[I]));
    end
  end;
end;

function TIvd.DocDel(pIvdNum:integer;pHedDel:boolean):boolean;  // Zrusi zadany doklad
begin
(*
  Result:=TRUE;
  If ohIVD.LocateDocNum(pDocNum) then begin
    If DocUnr(pDocNum) then begin
      If ohIVI.LocateDocNum(pDocNum) then begin
        Repeat
          Application.ProcessMessages;
          If ohIVI.StkStat='N'
            then ohIVI.Delete
            else begin
              Result:=FALSE;
              ohIVI.Next;
            end;
        until ohIVI.Eof or (ohIVI.Count=0) or (ohIVI.DocNum<>pDocNum);
      end;
    end;
    ohIVD.Clc(ohIVI);
    Result:=ohIVD.ItmQnt=0; // Je to v poriadku ak doklad nema ziadne polozky
    If Result and pHedDel then ohIVD.Delete;  // Ak je nastavene zrusenie hlavicky a bola vymazana kazda polozka zrusime hlavicku dokladu
  end;
*)
end;

function TIvd.ItmDel(pIvlNum:integer;pItmNum:longint):boolean; // Zrusi zadanu polozku
begin
  Result:=FALSE;
  ohIVI.LocateIlIt(pIvlNum,pItmNum);
end;

procedure TIvd.TmpRef(pIvlNum,pGsCode:longint;pPoCode:Str15); // Obnovy zaznam na zaklade BTR
begin
  If ohIVI.LocateIlGsPc(pIvlNum,pGsCode,pPoCode) then begin
    If otIVI.LocIlGsPo(pIvlNum,pGsCode,pPoCode)
      then otIVI.Edit
      else otIVI.Insert;
    otIVI.Edit;
    BTR_To_PX (ohIVI.BtrTable,otIVI.TmpTable);
    otIVI.Post;
  end;
end;
(*
procedure TIvd.SlcIvi(pGsCode:longint{;pPosCode:Str15}); // nacita polozky zadaneho harku do PX
begin
  oSPc.StkNum:=StkNum;
  If ohIVI.NearestGsPc(pGsCode,'') and (ohIVI.GsCode=pGsCode)then
  begin
    Repeat
      If not otIVDPOS.LocateGsPc(ohIVI.GsCode,ohIVI.PosCode) then begin
        otIVDPOS.Insert;
        BTR_To_PX (ohIVI.BtrTable,otIVDPOS.TmpTable);
        If oSpc.ohSPC.LocatePoGs(otIVDPOS.PosCode,otIVDPOS.GsCode) then begin
          otIVDPOS.EvQnt:=oSpc.ohSPC.ActQnt;
          otIVDPOS.EvmQnt:=oSpc.ohSPC.ActQnt;
        end else begin
          otIVDPOS.EvQnt:=0;
          otIVDPOS.EvmQnt:=0;
        end;
        otIVDPOS.MovQnt:=0;
        otIVDPOS.DifQnt:=otIVDPOS.EvmQnt-otIVDPOS.IvQnt;
        otIVDPOS.ADifQnt:=Abs(otIVDPOS.DifQnt);
        otIVDPOS.Post;
      end else begin
        WriteToLogFile(gPath.SysPath+'SLCIVI.ERR',IntToStr(ohIVI.GsCode)+';'+ohIVI.PosCode);
      end;
      Application.ProcessMessages;
      ohIVI.Next;
    until ohIVI.Eof or (ohIVI.GsCode<>pGsCode){or (ohIVI.PosCode<>pPosCode)};
  end;
  //  pozicie z SPC co su neni na harku
  otIVDPOS.First;
  while not otIVDPOS.Eof do
    If not Eq3(otIVDPOS.IvQnt,otIVDPOS.EvmQnt) then otIVDPOS.Next else otIVDPOS.Delete;
end;
*)

end.


