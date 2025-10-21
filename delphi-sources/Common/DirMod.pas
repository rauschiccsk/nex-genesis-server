unit DirMod;
{$F+}
// *****************************************************************************
// Tento objekt zaznameáva všetky modifikácie údajov karty kontaktnej osoby.
// *****************************************************************************

interface

uses
  IcTypes, IcConst, IcConv, IcTools, DocHand, NexGlob, NexPath, NexIni, Key,
  hDIRMOD, hDIRCNT,
  SysUtils, Classes, Forms;

type
  TDirMod = class(TComponent)
    constructor Create;
    destructor  Destroy; override;
    private
      oModify:boolean;
      oCntNum:longint;
      oModNum:integer;
      ohDIRMOD:TDirmodHnd;
      procedure NewMod; // Vygeneruje nove cislo zmeny
    public
      procedure Clr;
      procedure Ver(pBas,pEdi,pFld:string); overload;
      procedure Ver(pBas,pEdi:integer;pFld:string); overload;
      procedure Ver(pBas,pEdi:boolean;pFld:string); overload;
      procedure Add(pTxt:string);
      {PROPERTY}
      property Modify:boolean read oModify;
      property CntNum:longint write oCntNum;
//      property ModNum:word read oModNum write oModNum;
      property phDIRMOD:TDirmodHnd read ohDIRMOD write ohDIRMOD;
  end;

implementation

constructor TDirMod.Create;
begin
  Clr;
  ohDIRMOD := TDirmodHnd.Create;   ohDIRMOD.Open;
end;

destructor TDirMod.Destroy;
begin
  FreeAndNil(ohDIRMOD);
end;

// ********************************* PRIVATE ***********************************

procedure TDirMod.NewMod; // Vygeneruje nove cislo zmeny
var mhDIRCNT:TDircntHnd;
begin
  mhDIRCNT := TDirCntHnd.Create;   mhDIRCNT.Open;
  If mhDIRCNT.LocateCntNum(oCntNum) then begin
    oModNum := mhDIRCNT.ModNum+1;
    mhDIRCNT.Edit;
    mhDIRCNT.ModNum := oModNum;
    mhDIRCNT.Post;
  end;
  FreeAndNil(mhDIRCNT);
end;


// ********************************** PUBLIC ***********************************

procedure TDirMod.Clr;
begin
  oModify := FALSE;
  oModNum := 0;
end;

procedure TDirMod.Ver(pBas,pEdi,pFld:string);
begin
  If pBas<>pEdi then begin
    If oModNum=0 then NewMod;
    oModify := TRUE;
    ohDIRMOD.Insert;
    ohDIRMOD.CntNum := oCntNum;
    ohDIRMOD.ModNum := oModNum;
    ohDIRMOD.ModDes := pFld+': '+pBas+' -> '+pEdi;
    ohDIRMOD.Post;
  end;
end;

procedure TDirMod.Ver(pBas,pEdi:integer;pFld:string);
begin
  Ver(StrInt(pBas,0),StrInt(pEdi,0),pFld);
end;

procedure TDirMod.Ver(pBas,pEdi:boolean;pFld:string);
var mBas,mEdi:Str3;
begin
  If pBas then mBas := 'ZAP'
          else mBas := 'VYP';
  If pEdi then mEdi := 'ZAP'
          else mEdi := 'VYP';
  Ver(mBas,mEdi,pFld);
end;

procedure TDirMod.Add(pTxt:string);
begin
  If oModNum=0 then NewMod;
  oModify := TRUE;
  ohDIRMOD.Insert;
  ohDIRMOD.CntNum := oCntNum;
  ohDIRMOD.ModNum := oModNum;
  ohDIRMOD.ModDes := pTxt;
  ohDIRMOD.Post;
end;

end.
