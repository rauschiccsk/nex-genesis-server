unit hPRPDEF;

interface

uses
  IcTypes, IcConv, bPRPDEF,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TPrpdefHnd=class (TPrpdefBtr)
  private
  public
    function ReadString(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str6;pDefault:Str60):Str60;
    function ReadInteger(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str6;pDefault:integer):integer;
    function ReadBoolean(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str6;pDefault:boolean):boolean;
    function ReadFloat(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str6;pDefault:double;pFrc:byte):double;
    procedure WriteString(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str6;pPrpVal:Str60);
    procedure WriteInteger(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str6;pPrpVal:integer);
    procedure WriteBoolean(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str6;pPrpVal:boolean);
    procedure WriteFloat(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str6;pPrpVal:double;pFrc:byte);
  published
  end;

implementation

function TPrpdefHnd.ReadString(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str6;pDefault:Str60):Str60;
begin
  Result:=pDefault;
  If not Active then Open;
  If LocatePnBnPn(pPmdNam,pBokNum,pPrpNam)
    then Result:=PrpVal
    else WriteString(pPmdNam,pBokNum,pPrpNam,pDefault);
end;

function TPrpdefHnd.ReadInteger(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str6;pDefault:integer):integer;
begin
  Result:=ValInt(ReadString(pPmdNam,pBokNum,pPrpNam,StrInt(pDefault,0)));
end;

function TPrpdefHnd.ReadBoolean(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str6;pDefault:boolean):boolean;
begin
  Result:=ReadString(pPmdNam,pBokNum,pPrpNam,'OFF')='ON';
end;

function TPrpdefHnd.ReadFloat(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str6;pDefault:double;pFrc:byte):double;
begin
  try
    Result:=ValDoub(ReadString(pPmdNam,pBokNum,pPrpNam,StrDoub(pDefault,0,pFrc)));
  except
    on E: EConvertError do Result:=0;
  end;
end;

procedure TPrpdefHnd.WriteString(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str6;pPrpVal:Str60);
begin
  If not Active then Open;
  If LocatePnBnPn(pPmdNam,pBokNum,pPrpNam) then begin
    Edit;
    PrpVal:=pPrpVal;
    Post;
  end
  else begin
    Insert;
    PmdNam:=pPmdNam;
    BokNum:=pBokNum;
    PrpNam:=pPrpNam;
    PrpVal:=pPrpVal;
    Post;
  end;
end;

procedure TPrpdefHnd.WriteInteger(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str6;pPrpVal:integer);
begin
  WriteString(pPmdNam,pBokNum,pPrpNam,StrInt(pPrpVal,0));
end;

procedure TPrpdefHnd.WriteBoolean(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str6;pPrpVal:boolean);
begin
  If pPrpVal
    then WriteString(pPmdNam,pBokNum,pPrpNam,'ON')
    else WriteString(pPmdNam,pBokNum,pPrpNam,'OFF');
end;

procedure TPrpdefHnd.WriteFloat(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str6;pPrpVal:double;pFrc:byte);
begin
  WriteString(pPmdNam,pBokNum,pPrpNam,StrDoub(pPrpVal,0,pFrc));
end;

end.
{MOD 2001001}
