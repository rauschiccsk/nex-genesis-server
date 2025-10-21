unit DocGen;
{$F+}

// *****************************************************************************
//                     UNIVERZALNE GENEROVANIE DOKLADOC
// *****************************************************************************
// Tento objekt obsahuje funkcie, ktorÈ umoûnia naËÌtaù poloûky dokladov a
// uloûiù ich do inÈho dokladu
//
// ProgramovÈ funkcia:
// ---------------
//
// *****************************************************************************


interface

uses
  IcTypes, IcConst, IcConv, IcTools, DocHand, NexGlob, NexPath, Key,
  tCOMITM, hPAB, hTSH, hTSI, hTCH, hTCI,
  SysUtils, Classes, Forms;

type
  TDocGen = class(TComponent)
    constructor Create;
    destructor  Destroy; override;
    private
      ohPAB: TPabHnd;
      otCOMITM: TComitmTmp;
      oScdNum: Str12; // InternÈ ËÌslo zdrojovÈho dokladu
      oScdPac: longint; // Kod firmy zdrojovÈho dokladu
      oScdDes: Str30; // Textov˝ popis zdrojovÈho dokladu
    public
      procedure LoadScd(pDocNum:Str12); // NaËÌta zadany doklad ako zdroj udajov

      procedure SaveTcd(pBokNum:Str5;pSerNum,pPaCode:longint;pDocDate:TDateTime); // UloûÌ zdrojov˝ doklad ako odberateæsk˝ dodacÌ list
      procedure SaveIcd(pBokNum:Str5;pSerNum,pPaCode:longint;pDocDate:TDateTime); // UloûÌ zdrojov˝ doklad ako odberateæsk· fakt˙ra


    published
  end;

implementation

constructor TDocGen.Create;
begin
  ohPAB := TPabHnd.Create;  ohPAB.Open(0);
  otCOMITM := TComitmTmp.Create; otCOMITM.Open;
end;

destructor TDocGen.Destroy;
begin
  FreeAndNil (otCOMITM);
  FreeAndNil (ohPAB);
end;

// ********************************* PRIVATE ***********************************

// ********************************** PUBLIC ***********************************

procedure TDocGen.LoadScd(pDocNum:Str12); // NaËÌta zadany doklad ako zdroj udajov
var mDocType:byte;   mBokNum:Str5;  mhTSH:TTshHnd;  mhTSI:TTsiHnd;
begin
  otCOMITM.Open;
  mDocType := GetDocType (pDocNum);
  mBokNum := BookNumFromDocNum (pDocNum);
  case mDocType of
    dtTS: begin
            mhTSH := TTshHnd.Create;  mhTSH.Open(mBokNum);
            mhTSI := TTsiHnd.Create;  mhTSI.Open(mBokNum);
            If mhTSH.LocateDocNum(pDocNum) then begin
              oScdNum := mhTSH.DocNum;
              oScdPac := mhTSH.PaCode;
              If mhTSI.LocateDocNum(oScdNum) then begin
                Repeat
                  otCOMITM.Insert;
                  BTR_To_PX (mhTSI.BtrTable,otCOMITM.TmpTable);
                  otCOMITM.Post;
                  mhTSI.Next;
                until mhTSI.Eof or (mhTSI.DocNum<>oScdNum);
              end;
            end;
            FreeAndNil (mhTSI);
            FreeAndNil (mhTSH);
          end;
  end;
end;

procedure TDocGen.SaveTcd(pBokNum:Str5;pSerNum,pPaCode:longint;pDocDate:TDateTime); // UloûÌ zdrojov˝ doklad ako odberateæsk˝ dodacÌ list
var mhTCH:TTchHnd;  mhTCI:TTciHnd;  mSerNum,mItmNum:longint;  mDocNum:Str12;
begin
  If otCOMITM.Count>0 then begin // Ak su naËÌtanÈ nejake poloûky
    If ohPAB.LocatePaCode(pPaCode) then begin
      mhTCH := TTchHnd.Create;  mhTCH.Open(pBokNum);
      mhTCI := TTciHnd.Create;  mhTCI.Open(pBokNum);
      // Vyvorime hlacicku dokladu
      If pSerNum=0
        then mSerNum := mhTCH.NextSerNum
        else mSerNum := pSerNum;
      mDocNum := mhTCH.GenDocNum(pBokNum,mSerNum);
      If not mhTCH.LocateDocNum(mDocNum) then begin
        mhTCH.Insert;
        mhTCH.DocNum := mDocNum;
        mhTCH.SerNum := mSerNum;
        mhTCH.StkNum := gKey.TcbStkNum[pBokNum];
        mhTCH.SmCode := gKey.TcbSmCode[pBokNum];
        mhTCH.DocDate := pDocDate;
        BTR_To_BTR (ohPAB.BtrTable,mhTCH.BtrTable);
        mhTCH.Post;
      end;
      // Vytvorime poloûky dodacieho listu
      mItmNum := mhTCI.NextItmNum(mhTCH.DocNum);
      otCOMITM.First;
      Repeat
        mhTCI.Insert;
        PX_To_BTR (otCOMITM.TmpTable,mhTCI.BtrTable);
        mhTCI.DocNum := mDocNum;
        mhTCI.ItmNum := mItmNum;
        mhTCI.Post;
        Application.ProcessMessages;
        Inc (mItmNum);
        otCOMITM.Next;
      until otCOMITM.Eof;
      mhTCH.Clc(mhTCI);
      FreeAndNil (mhTCI);
      FreeAndNil (mhTCH);
    end;
  end;
end;

procedure TDocGen.SaveIcd(pBokNum:Str5;pSerNum,pPaCode:longint;pDocDate:TDateTime); // UloûÌ zdrojov˝ doklad ako odberateæsk· fakt˙ra
begin
end;

end.
