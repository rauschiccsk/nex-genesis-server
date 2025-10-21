unit ArpFnc;

interface

uses
  IcTypes, IcConv, IcVariab, IcTools, Nexpath, NexClc, NexGlob, StkGlob, Prp, eARPLST, eARPHIS, ePERLST,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs, Forms, DateUtils;

type
  TArpFnc=class
    constructor Create;
    destructor Destroy; override;
  private
  public
    ohPERLST:TPerlstHne;  // Evidencia osôb
    ohARPLST:TArplstHne;  // Archých vytlaèených dokumentov
    ohARPHIS:TArphisHne;  // História vytlaèených dokumentov

    procedure AddArpHis(pDocTyp:Str2;pDocNum:Str12;pParNum:longint;pParNam:Str60;pPrnUsr:Str15;pRepNam:Str8;pRepVer:Str3;pRepDes:Str60);
    procedure PdfPrnVer;   // Prekontoluje èi na aktuálny doklad existuje PDF súbor, ak áno oznaèí záznam s príznakom "A" ak nie potom s príznakom "E"
  end;

implementation

constructor TArpFnc.Create;
begin
  ohPERLST:=TPerlstHne.Create;
  ohARPLST:=TArplstHne.Create;
  ohARPHIS:=TArphisHne.Create;
end;

destructor TArpFnc.Destroy;
begin
  FreeAndNil(ohARPHIS);
  FreeAndNil(ohARPLST);
  FreeAndNil(ohPERLST);
end;

// ******************************** PRIVATE ************************************

// ********************************* PUBLIC ************************************

procedure TArpFnc.AddArpHis(pDocTyp:Str2;pDocNum:Str12;pParNum:longint;pParNam:Str60;pPrnUsr:Str15;pRepNam:Str8;pRepVer:Str3;pRepDes:Str60);
var mItmNum:word;
begin
  If not ohARPLST.LocDoPa(pDocNum,pParNum) then begin
    ohARPLST.Insert;
    ohARPLST.DocNum:=pDocNum;
    ohARPLST.ParNum:=pParNum;
    ohARPLST.ParNam:=pParNam;
    If pDocTyp='' then begin
      ohARPLST.DocTyp:=copy(pDocNum,1,2);
      ohARPLST.BokNum:=copy(pDocNum,3,3);
    end else begin
      ohARPLST.DocTyp:=pDocTyp;
    end;
  end else ohARPLST.Edit;
  ohARPLST.PrnUsr:=pPrnUsr;
  If ohPERLST.LocUsrLog(pPrnUsr)
    then ohARPLST.PrnUsn:=ohPERLST.PerNam
    else ohARPLST.PrnUsn:='';
  ohARPLST.PrnDte:=Date;
  ohARPLST.PrnTim:=Time;
  ohARPLST.PrnQnt:=ohARPLST.PrnQnt+1;
  ohARPLST.Post;
  // História zmien
  ohARPHIS.Insert;
  ohARPHIS.DocNum:=pDocNum;
  ohARPHIS.ParNum:=pParNum;
  ohARPHIS.PrnNum:=ohARPLST.PrnQnt;
  ohARPHIS.RepNam:=pRepNam;
  ohARPHIS.RepVer:=pRepVer;
  ohARPHIS.RepDes:=pRepDes;
  ohARPHIS.DocTyp:=ohARPLST.DocTyp;
  ohARPHIS.BokNum:=ohARPLST.BokNum;
  ohARPHIS.PdfNam:=pDocNum+'-'+StrIntZero(ohARPHIS.ParNum,6)+'-'+StrIntZero(ohARPHIS.PrnNum,5);
  ohARPHIS.PdfSta:='W';
  ohARPHIS.PrnUsr:=pPrnUsr;
  ohARPHIS.PrnUsn:=ohARPLST.PrnUsn;
  ohARPHIS.PrnDte:=Date;
  ohARPHIS.PrnTim:=Time;
  ohARPHIS.Post;
end;

procedure TArpFnc.PdfPrnVer;   // Prekontoluje èi na aktuálny doklad existuje PDF súbor, ak áno oznaèí záznam s príznakom "A" ak nie potom s príznakom "E"
var mFind:boolean;  mCnt:word;
begin
  mFind:=FALSE;  mCnt:=0;
  Repeat
    Inc(mCnt);
    mFind:=FileExists('G:\NEX\ARCHIV\DOC\'+ohARPHIS.PdfNam+'.PDF');
  //  mFind:=FileExists(gPath.ArcPath+'DOC\'+ohARPHIS.PdfNam+'.PDF');
    If not mFind then Wait(1000);
  until mFind or (mCnt=20);
  ohARPHIS.Edit;
  If mFind
    then ohARPHIS.PdfSta:='A'
    else ohARPHIS.PdfSta:='E';
  ohARPHIS.Post;
end;

end.


