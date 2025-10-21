unit Cnt;

interface

uses
  IcTypes, IcConv, IcVariab, IcTools, eDOCCNT, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs, Forms, DateUtils;

type
  TCnt=class
    constructor Create;
    destructor Destroy; override;
  private
  public
    ohDOCCNT:TDoccntHne;
//    function NewDocAdr(pDocYer,pDocTyp:Str2):longint;
    function NewItmAdr(pDocYer,pDocTyp:Str2):longint;
    function NewDocSer(pDocYer,pDocTyp:Str2;pBokNum:Str3):longint;
    function DecDocSer(pDocYer,pDocTyp:Str2;pBokNum:Str3;pSerNum:longint):boolean;
  end;

var gCnt:TCnt;

implementation

constructor TCnt.Create;
begin
  ohDOCCNT:=TDoccntHne.Create;
end;

destructor TCnt.Destroy;
begin
  FreeAndNil(ohDOCCNT);
end;

// ******************************** PRIVATE ************************************

// ********************************* PUBLIC ************************************

function TCnt.NewItmAdr(pDocYer,pDocTyp:Str2):longint;
begin
  If not ohDOCCNT.LocDyDtBn(pDocYer,pDocTyp,'ITM') then begin
    ohDOCCNT.Insert;
    ohDOCCNT.DocYer:=pDocYer;
    ohDOCCNT.DocTyp:=pDocTyp;
    ohDOCCNT.BokNum:='ITM';
    ohDOCCNT.CntNum:=ValInt(pDocYer)*100000001;
    ohDOCCNT.Post;
  end else begin
    ohDOCCNT.Edit;
    ohDOCCNT.CntNum:=ohDOCCNT.CntNum+1;
    ohDOCCNT.Post;
  end;
  Result:=ohDOCCNT.CntNum;
end;

function TCnt.NewDocSer(pDocYer,pDocTyp:Str2;pBokNum:Str3):longint;
begin
  If not ohDOCCNT.LocDyDtBn(pDocYer,pDocTyp,pBokNum) then begin
    ohDOCCNT.Insert;
    ohDOCCNT.DocYer:=pDocYer;
    ohDOCCNT.DocTyp:=pDocTyp;
    ohDOCCNT.BokNum:=pBokNum;
    ohDOCCNT.CntNum:=1;
    ohDOCCNT.Post;
  end else begin
    ohDOCCNT.Edit;
    ohDOCCNT.CntNum:=ohDOCCNT.CntNum+1;
    ohDOCCNT.Post;
  end;
  Result:=ohDOCCNT.CntNum;
end;

function TCnt.DecDocSer(pDocYer,pDocTyp:Str2;pBokNum:Str3;pSerNum:longint):boolean;
begin
  Result:=FALSE;
  If ohDOCCNT.LocDyDtBn(pDocYer,pDocTyp,pBokNum) then begin
    If ohDOCCNT.CntNum=pSerNum then begin
      Result:=TRUE;
      ohDOCCNT.Edit;
      ohDOCCNT.CntNum:=ohDOCCNT.CntNum-1;
      ohDOCCNT.Post;
    end;
  end;
end;

end.


