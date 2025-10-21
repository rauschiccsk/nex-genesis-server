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
    ohARDLST:TArdlstHne;  // Hlavièky zákazkových dokladov
    ohARDHIS:TArdhisHne;  // Položky zákazkových dokladov
    procedure Add(pDocNum:Str12;pParNum:longint;pParNam:Str60;pUsrNam:Str30);
    procedure PdfPrnVer;   // Prekontoluje èi na aktuálny doklad existuje PDF súbor, ak áno oznaèí záznam s príznakom "A" ak nie potom s príznakom "E"
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
  // Archívny register
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
  // História zmien
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

procedure TArdFnc.PdfPrnVer;   // Prekontoluje èi na aktu8lny doklad existuje PDF súbor, ak áno oznaèí záznam s príznakom "A" ak nie potom s príznakom "E"
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


