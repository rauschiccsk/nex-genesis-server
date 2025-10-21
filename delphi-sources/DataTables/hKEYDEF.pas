unit hKEYDEF;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, bKEYDEF,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TKeydefHnd = class (TKeydefBtr)
  private
  public
    function ReadString(pPmdName:Str3;pBookNum:Str5;pKeyName:Str30;pDefault:ShortString):ShortString;
    function ReadInteger(pPmdName:Str3;pBookNum:Str5;pKeyName:Str30;pDefault:integer):integer;
    function ReadBoolean(pPmdName:Str3;pBookNum:Str5;pKeyName:Str30;pDefault:boolean):boolean;
    function ReadFloat(pPmdName:Str3;pBookNum:Str5;pKeyName:Str30;pDefault:double;pFrc:byte):double;
    procedure WriteString(pPmdMark:Str3;pBookNum:Str5;pKeyName:Str30;pKeyVal:ShortString);
    procedure WriteInteger(pPmdMark:Str3;pBookNum:Str5;pKeyName:Str30;pKeyVal:integer);
    procedure WriteBoolean(pPmdMark:Str3;pBookNum:Str5;pKeyName:Str30;pKeyVal:boolean);
    procedure WriteFloat(pPmdMark:Str3;pBookNum:Str5;pKeyName:Str30;pKeyVal:double;pFrc:byte);
  published
  end;

implementation

const  cOn = 'ON';  cOff = 'OFF';

function TKeydefHnd.ReadString(pPmdName:Str3;pBookNum:Str5;pKeyName:Str30;pDefault:ShortString):ShortString;
begin
//  If Length(pBookNum)=5 then pBookNum:=copy(pBookNum,3,3);
  Result:=pDefault;
  If LocatePmBnKn(pPmdName,pBookNum,pKeyName)
    then Result:=Keyval
    else WriteString (pPmdName,pBookNum,pKeyName,pDefault);
end;

function TKeydefHnd.ReadInteger(pPmdName:Str3;pBookNum:Str5;pKeyName:Str30;pDefault:integer):integer;
begin
  Result:=ValInt(ReadString(pPmdName,pBookNum,pKeyName,StrInt(pDefault,0)));
end;

function TKeydefHnd.ReadBoolean(pPmdName:Str3;pBookNum:Str5;pKeyName:Str30;pDefault:boolean):boolean;
begin
  Result:=ReadString(pPmdName,pBookNum,pKeyName,cOff)=cOn;
end;

function TKeydefHnd.ReadFloat(pPmdName:Str3;pBookNum:Str5;pKeyName:Str30;pDefault:double;pFrc:byte):double;
begin
  try
    Result:=ValDoub(ReadString(pPmdName,pBookNum,pKeyName,StrDoub(pDefault,0,pFrc)));
  except
    on E: EConvertError do Result:=0;
  end;
end;

procedure TKeydefHnd.WriteString(pPmdMark:Str3;pBookNum:Str5;pKeyName:Str30;pKeyVal:ShortString);
begin
//  If Length(pBookNum)=5 then pBookNum:=copy(pBookNum,3,3);
  If LocatePmBnKn(pPmdMark,pBookNum,pKeyName) then begin
    Edit;
    KeyVal:=pKeyVal;
    Post;
  end
  else begin
    Insert;
    PmdMark:=pPmdMark;
    BookNum:=pBookNum;
    KeyName:=pKeyName;
    KeyVal:=pKeyVal;
    Post;
  end;
end;

procedure TKeydefHnd.WriteInteger(pPmdMark:Str3;pBookNum:Str5;pKeyName:Str30;pKeyVal:integer);
begin
  WriteString(pPmdMark,pBookNum,pKeyName,StrInt(pKeyVal,0));
end;

procedure TKeydefHnd.WriteBoolean(pPmdMark:Str3;pBookNum:Str5;pKeyName:Str30;pKeyVal:boolean);
begin
  If pKeyVal
    then WriteString(pPmdMark,pBookNum,pKeyName,cOn)
    else WriteString(pPmdMark,pBookNum,pKeyName,cOff);
end;

procedure TKeydefHnd.WriteFloat(pPmdMark:Str3;pBookNum:Str5;pKeyName:Str30;pKeyVal:double;pFrc:byte);
begin
  WriteString(pPmdMark,pBookNum,pKeyName,StrDoub(pKeyVal,0,pFrc));
end;

end.
