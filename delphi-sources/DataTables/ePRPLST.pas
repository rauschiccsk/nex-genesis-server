unit ePRPLST;

interface

uses
  IcTypes, IcConv, dPRPLST,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TPrplstHne=class(TPrplstDat)
  private
  public
    function ReadString(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str9;pDefault:Str100):Str100; overload;
    function ReadString(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str9;pPrpSpc:Str5;pDefault:Str100):Str100; overload;

    function ReadInteger(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str9;pDefault:integer):integer; overload;
    function ReadInteger(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str9;pPrpSpc:Str5;pDefault:integer):integer; overload;

    function ReadBoolean(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str9;pDefault:boolean):boolean; overload;
    function ReadBoolean(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str9;pPrpSpc:Str5;pDefault:boolean):boolean; overload;

    function ReadFloat(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str9;pDefault:double;pFrc:byte):double; overload;
    function ReadFloat(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str9;pPrpSpc:Str5;pDefault:double;pFrc:byte):double; overload;

    procedure WriteString(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str9;pPrpVal:Str100); overload;
    procedure WriteString(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str9;pPrpSpc:Str5;pPrpVal:Str100); overload;

    procedure WriteInteger(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str9;pPrpVal:integer); overload;
    procedure WriteInteger(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str9;pPrpSpc:Str5;pPrpVal:integer); overload;

    procedure WriteBoolean(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str9;pPrpVal:boolean); overload;
    procedure WriteBoolean(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str9;pPrpSpc:Str5;pPrpVal:boolean); overload;

    procedure WriteFloat(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str9;pPrpVal:double;pFrc:byte); overload;
    procedure WriteFloat(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str9;pPrpSpc:Str5;pPrpVal:double;pFrc:byte); overload;
  published
  end;

implementation

// *************************************** PRIVATE ********************************************

// **************************************** PUBLIC ********************************************

function TPrplstHne.ReadString(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str9;pDefault:Str100):Str100;
begin
  Result:=ReadString(pPmdNam,pBokNum,pPrpNam,'',pDefault);
end;

function TPrplstHne.ReadString(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str9;pPrpSpc:Str5;pDefault:Str100):Str100;
begin
  Result:=pDefault;
  If LocPnBnPnPs(pPmdNam,pBokNum,pPrpNam,pPrpSpc)
    then Result:=PrpVal
    else WriteString(pPmdNam,pBokNum,pPrpNam,pPrpSpc,pDefault);
end;

function TPrplstHne.ReadInteger(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str9;pDefault:integer):integer;
begin
  Result:=ReadInteger(pPmdNam,pBokNum,pPrpNam,'',pDefault);
end;

function TPrplstHne.ReadInteger(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str9;pPrpSpc:Str5;pDefault:integer):integer;
begin
  Result:=ValInt(ReadString(pPmdNam,pBokNum,pPrpNam,pPrpSpc,StrInt(pDefault,0)));
end;

function TPrplstHne.ReadBoolean(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str9;pDefault:boolean):boolean;
begin
  Result:=ReadBoolean(pPmdNam,pBokNum,pPrpNam,'',pDefault);
end;

function TPrplstHne.ReadBoolean(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str9;pPrpSpc:Str5;pDefault:boolean):boolean;
begin
  Result:=ReadString(pPmdNam,pBokNum,pPrpNam,pPrpSpc,'OFF')='ON';
end;

function TPrplstHne.ReadFloat(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str9;pDefault:double;pFrc:byte):double;
begin
  Result:=ReadFloat(pPmdNam,pBokNum,pPrpNam,'',pDefault,pFrc);
end;

function TPrplstHne.ReadFloat(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str9;pPrpSpc:Str5;pDefault:double;pFrc:byte):double;
begin
  try
    Result:=ValDoub(ReadString(pPmdNam,pBokNum,pPrpNam,pPrpSpc,StrDoub(pDefault,0,pFrc)));
  except
    on E: EConvertError do Result:=0;
  end;
end;

procedure TPrplstHne.WriteString(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str9;pPrpVal:Str100);
begin
  WriteString(pPmdNam,pBokNum,pPrpNam,'',pPrpVal);
end;

procedure TPrplstHne.WriteString(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str9;pPrpSpc:Str5;pPrpVal:Str100);
begin
  If not Active then Open;
  If LocPnBnPnPs(pPmdNam,pBokNum,pPrpNam,pPrpSpc) then begin
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
    PrpSpc:=pPrpSpc;
    Post;
  end;
end;

procedure TPrplstHne.WriteInteger(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str9;pPrpVal:integer);
begin
  WriteInteger(pPmdNam,pBokNum,pPrpNam,'',pPrpVal);
end;

procedure TPrplstHne.WriteInteger(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str9;pPrpSpc:Str5;pPrpVal:integer);
begin
  WriteString(pPmdNam,pBokNum,pPrpNam,pPrpSpc,StrInt(pPrpVal,0));
end;

procedure TPrplstHne.WriteBoolean(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str9;pPrpVal:boolean);
begin
  WriteBoolean(pPmdNam,pBokNum,pPrpNam,'',pPrpVal);
end;

procedure TPrplstHne.WriteBoolean(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str9;pPrpSpc:Str5;pPrpVal:boolean);
begin
  If pPrpVal
    then WriteString(pPmdNam,pBokNum,pPrpNam,pPrpSpc,'ON')
    else WriteString(pPmdNam,pBokNum,pPrpNam,pPrpSpc,'OFF');
end;

procedure TPrplstHne.WriteFloat(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str9;pPrpVal:double;pFrc:byte);
begin
  WriteFloat(pPmdNam,pBokNum,pPrpNam,'',pPrpVal,pFrc);
end;

procedure TPrplstHne.WriteFloat(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str9;pPrpSpc:Str5;pPrpVal:double;pFrc:byte);
begin
  WriteString(pPmdNam,pBokNum,pPrpNam,pPrpSpc,StrDoub(pPrpVal,0,pFrc));
end;

end.
