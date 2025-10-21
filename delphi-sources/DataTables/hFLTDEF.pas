unit hFltdef;

interface

uses
  IcTypes, NexPath, NexGlob, bFltdef,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;


type
  TFltdefHnd = class (TFltdefBtr)
  private
    oFltGrp  : Str50;
  public
    function  ReadString(const FltName, FltFld, Default: string): string; virtual;
    procedure WriteString(const FltName, FltFld, FltVal: String); virtual;
    function  ReadInteger(const FltName, FltFld: string; Default: Longint): Longint; virtual;
    procedure WriteInteger(const FltName, FltFld: string; FltVal: Longint); virtual;
    function  ReadBool(const FltName, FltFld: string; Default: Boolean): Boolean; virtual;
    procedure WriteBool(const FltName, FltFld: string; FltVal: Boolean); virtual;
    function  ReadDate(const FltName, FltFld: string; Default: TDateTime): TDateTime; virtual;
    procedure WriteDate(const FltName, FltFld: string; FltVal: TDateTime); virtual;
    function  ReadDateTime(const FltName, FltFld: string; Default: TDateTime): TDateTime; virtual;
    procedure WriteDateTime(const FltName, FltFld: string; FltVal: TDateTime); virtual;
    function  ReadFloat(const FltName, FltFld: string; Default: Double): Double; virtual;
    procedure WriteFloat(const FltName, FltFld: string; FltVal: Double); virtual;
    function  ReadTime(const FltName, FltFld: string; Default: TDateTime): TDateTime; virtual;
    procedure WriteTime(const FltName, FltFld: string; FltVal: TDateTime); virtual;
    procedure EraseSection (const FltName: string); virtual;
    procedure GetFltNames(pStrings:TStrings);
  published
    property FltGrp:Str50 read oFltGrp write oFltGrp;
  end;

var gFlt:TFltdefHnd;

implementation

procedure TFltdefHnd.EraseSection(const FltName: string);
begin
  If LocateSectionName(FltName) then begin
    repeat
      Delete;
    until Eof or (FltName<>SectionName);
  end
end;

procedure TFltdefHnd.GetFltNames(pStrings: TStrings);
begin
  pStrings.Clear;
  If LocateSectionName('NAMES') then begin
    repeat
      If Pos(FltGrp,IdentName)=1 then pStrings.add(KeyValue);
      Next;
    until Eof or (SectionName<>'NAMES');
  end;
end;

function TFltDefHnd.ReadBool(const FltName, FltFld: string;Default: Boolean): Boolean;
begin
  Result:=StrToBool(ReadString(FltName,FltFld,BoolToStr(Default)));
end;

function TFltDefHnd.ReadDate(const FltName, FltFld: string;Default: TDateTime): TDateTime;
begin
  Result:=StrToDate(ReadString(FltName,FltFld,DateToStr(Default)));
end;

function TFltDefHnd.ReadDateTime(const FltName, FltFld: string;Default: TDateTime): TDateTime;
begin
  Result:=StrToDateTime(ReadString(FltName,FltFld,DateTimeToStr(Default)));
end;

function TFltDefHnd.ReadFloat(const FltName, FltFld: string;Default: Double): Double;
begin
  Result:=StrToFloat(ReadString(FltName,FltFld,FloatToStr(Default)));
end;

function TFltDefHnd.ReadInteger(const FltName, FltFld: string;Default: Integer): Longint;
begin
  Result:=StrToInt(ReadString(FltName,FltFld,IntToStr(Default)));
end;

function TFltDefHnd.ReadTime(const FltName, FltFld: string;Default: TDateTime): TDateTime;
begin
  Result:=StrToTime(ReadString(FltName,FltFld,TimeToStr(Default)));
end;

function TFltDefHnd.ReadString(const FltName, FltFld,Default: string): string;
begin
  Result:=Default;
  If LocateSnIn (FltName,FltFld)
    then Result:=KeyValue
    else Result:=Default;
end;

procedure TFltDefHnd.WriteBool(const FltName, FltFld: string;FltVal: Boolean);
begin
  WriteString(FltName,FltFld,BoolToStr(FltVal));
end;

procedure TFltDefHnd.WriteDate(const FltName, FltFld: string;FltVal: TDateTime);
begin
  WriteString(FltName,FltFld,DateToStr(FltVal));
end;

procedure TFltDefHnd.WriteDateTime(const FltName, FltFld: string;FltVal: TDateTime);
begin
  WriteString(FltName,FltFld,DateTimeToStr(FltVal));
end;

procedure TFltDefHnd.WriteFloat(const FltName, FltFld: string;FltVal: Double);
begin
  WriteString(FltName,FltFld,FloatToStr(FltVal));
end;

procedure TFltDefHnd.WriteInteger(const FltName, FltFld: string;FltVal: Integer);
begin
  WriteString(FltName,FltFld,IntToStr(FltVal));
end;

procedure TFltDefHnd.WriteTime(const FltName, FltFld: string;FltVal: TDateTime);
begin
  WriteString(FltName,FltFld,TimeToStr(FltVal));
end;

procedure TFltDefHnd.WriteString(const FltName, FltFld, FltVal: String);
begin
  if not LocateSnIn(FltName,FltFld) then begin
    Insert;
    SectionName:=FltName;
    IdentName:=FltFld;
  end else Edit;
  KeyValue:=FltVal;
  Post;
end;

end.
