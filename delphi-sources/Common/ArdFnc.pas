unit ArdFnc;

interface

uses
  IcTypes, IcConv, IcVariab, IcTools, Nexpath, NexClc, NexGlob, StkGlob, Prp, eARDLST, eARDHIS,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs, Forms, DateUtils;

type
  TArdFnc=class
    constructor Create;
    destructor Destroy; override;
  private
  public
    ohARDLST:TArdlstHne;  // Hlavi�ky z�kazkov�ch dokladov
    ohARDHIS:TArdhisHne;  // Polo�ky z�kazkov�ch dokladov
    procedure Add(pDocNum:Str12;pParNum:longint;pParNam:Str60;pUsrNam:Str30);
    procedure PdfPrnVer;   // Prekontoluje �i na aktu�lny doklad existuje PDF s�bor, ak �no ozna�� z�znam s pr�znakom "A" ak nie potom s pr�znakom "E"
  end;

implementation

constructor TArdFnc.Create;
begin
  ohARDLST:=TArdlstHne.Create;
  ohARDHIS:=TArdhisHne.Create;
end;

destructor TArdFnc.Destroy;
begin
  FreeAndNil(ohARDHIS);
  FreeAndNil(ohARDLST);
end;

// ******************************** PRIVATE ************************************

// ********************************* PUBLIC ************************************

procedure TArdFnc.Add(pDocNum:Str12;pParNum:longint;pParNam:Str60;pUsrNam:Str30);
begin
  // Arch�vny register
  If not ohARDLST.LocDocNum(pDocNum) then begin
    ohARDLST.Insert;
    ohARDLST.DocNum:=pDocNum;
    ohARDLST.DocTyp:=copy(pDocNum,1,2);
    ohARDLST.CrtDte:=Date;
    ohARDLST.CrtTim:=Time;
  end else ohARDLST.Edit;
  ohARDLST.ParNum:=pParNum;
  ohARDLST.ParNam:=pParNam;
  ohARDLST.LasUsn:=pUsrNam;
  ohARDLST.LasDte:=Date;
  ohARDLST.LasTim:=Time;
  ohARDLST.ChgNum:=ohARDLST.ChgNum+1;
  ohARDLST.Post;
  // Hist�ria zmien
  ohARDHIS.Insert;
  ohARDHIS.DocNum:=pDocNum;
  ohARDHIS.ChgNum:=ohARDLST.ChgNum;
  ohARDHIS.ParNum:=pParNum;
  ohARDHIS.ParNam:=pParNam;
  ohARDHIS.PdfSta:='W';
  ohARDHIS.CrtUsn:=pUsrNam;
  ohARDHIS.CrtDte:=Date;
  ohARDHIS.CrtTim:=Time;
  ohARDHIS.Post;
end;

procedure TArdFnc.PdfPrnVer;   // Prekontoluje �i na aktu8lny doklad existuje PDF s�bor, ak �no ozna�� z�znam s pr�znakom "A" ak nie potom s pr�znakom "E"
var mPdfSta:Str1;
begin
  If FileExists(gPath.ArcPath+ohARDHIS.DocNum+'.PDF')
    then mPdfSta:='A'
    else mPdfSta:='E';
  ohARDHIS.Edit;
  ohARDHIS.PdfSta:=mPdfSta;
  ohARDHIS.Post;
end;

end.


