unit IcdHand;
// *****************************************************************************
//                        Modul na pracu s dokladom OF
// *****************************************************************************
// PrnDoc - tlac odberatelskej faktury
// -----------------------------------------------------------------------------
// Ovladac obahuje nasledovne procedury a funkcie:
// NpyClc - procedure spocita hodnotu neuhradenych odberatelskych faktur
//          Parametre: pPaCode - firma pre ktoru budu pocitane udaje
//                     pBokLst - zoznam knih, z kotrych system ma spocitat
//                               neuhradene faktury
//                     pBokInd - indikator pre knih
//          Vysledok:  NpyVal  - hodnota vsetkych neuhradenych faktur
//                     NayVal  - hodnota nehuhradenych faktur po splatnosti
// -----------------------------------------------------------------------------
//
// *****************************************************************************

interface

uses
  IcTypes, IcTools, IcConv, IcVariab, NexGlob, NexPath, DocHand, RepHand,
  hICH, hICI, pBokLst, Key,
  ComCtrls, RefFile, Forms, Classes, SysUtils;

type
  TIcdHand = class (TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oNpyVal: double;
    oNayVal: double;
    oMaxExd: integer;
    otBOKLST:TBoklstTmp;
  public
    procedure PrnDoc (pDocNum:Str12);
    procedure NpyClc (pPaCode:longint;pExpPrm:word;pBokLst:ShortString;pBokInd:TProgressBar);
  published
    property NpyVal:double read oNpyVal;
    property NayVal:double read oNayVal;
    property MaxExd:integer read oMaxExd;
  end;

implementation

constructor TIcdHand.Create;
begin
  //
  otBOKLST:=TBoklstTmp.Create; otBOKLST.Open;
  otBOKLST.LoadToTmp('ICB');
end;

destructor TIcdHand.Destroy;
begin
  //
  otBOKLST.Close;FreeAndNil(otBOKLST);
end;

// ****************************** PRIVATE METHODS ******************************


// ******************************* PUBLIC METHODS ******************************

procedure TIcdHand.PrnDoc (pDocNum:Str12);
var mBookNum:Str5;  mbICH:TIchHnd;  mbICI:TIciHnd;  mRep:TF_RepHand;
begin
  mBookNum:=BookNumFromDocNum(pDocNum);
  mbICH:=TIchHnd.Create;  mbICH.Open(mBookNum);
  If mbICH.LocateDocNum(pDocNum) then begin
    mbICI:=TIciHnd.Create;  mbICI.Open(mBookNum);
(*
    mRep:=TF_RepHand.Create(Self);

    mRep.Main:=mbICH.BtrTable;
    mRep.Execute (gPath.RepPath+'ICD_E');
    FreeAndNil (mRep);
*)
    FreeAndNil (mbICI);
  end;
  FreeAndNil (mbICH);
end;

procedure TIcdHand.NpyClc (pPaCode:longint;pExpPrm:word;pBokLst:ShortString;pBokInd:TProgressBar);
var mbICH:TIchHnd; mExpDay:integer;
begin
  oNpyVal:=0;   oNayVal:=0;   oMaxExd:=0;
  otBOKLST.First;
  If otBOKLST.Count>0 then begin
    If pBokInd<>nil then begin
      pBokInd.Max:=otBOKLST.Count;
      pBokInd.Position:=0;
    end;
    mbICH:=TIchHnd.Create;
    otBOKLST.First;
    Repeat
      If pBokInd<>nil then pBokInd.StepBy(1);
      If StrInInterval (otBOKLST.BokNum,pBokLst) then begin
        mbICH.Open (otBOKLST.BokNum);
        If mbICH.LocatePaDp(pPaCode,0) then begin
          Repeat
            oNpyVal:=oNpyVal+mbICH.AcEndVal;
            If mbICH.ExpDate+pExpPrm<Date then oNayVal:=oNayVal+mbICH.AcEndVal;
            mExpDay:=Trunc(Date)-Trunc(mbICH.ExpDate);
            If oMaxExd<mExpDay then oMaxExd:=mExpDay;
            mbICH.Next;
          until mbICH.Eof or (mbICH.PaCode<>pPaCode) or (mbICH.DstPay<>0);
        end;
        mbICH.Close;
      end;
      Application.ProcessMessages;
      otBOKLST.Next;
    until otBOKLST.Eof;
    FreeAndNil (mbICH);
  end;
end;

end.
