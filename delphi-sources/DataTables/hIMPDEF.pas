unit hImpdef;

interface

uses
  IcTypes, NexPath, NexGlob, bImpdef,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;


type
  TImpdefHnd = class (TImpdefBtr)
  private
  public
    function  ReadString(const Section, Name, Default: string): string; virtual;
    procedure WriteString(const Section, Name, Value: String); virtual;
    function  ReadInteger(const Section, Name: string; Default: Longint): Longint; virtual;
    procedure WriteInteger(const Section, Name: string; Value: Longint); virtual;
    function  ReadBool(const Section, Name: string; Default: Boolean): Boolean; virtual;
    procedure WriteBool(const Section, Name: string; Value: Boolean); virtual;
    function  ReadDate(const Section, Name: string; Default: TDateTime): TDateTime; virtual;
    procedure WriteDate(const Section, Name: string; Value: TDateTime); virtual;
    function  ReadDateTime(const Section, Name: string; Default: TDateTime): TDateTime; virtual;
    procedure WriteDateTime(const Section, Name: string; Value: TDateTime); virtual;
    function  ReadFloat(const Section, Name: string; Default: Double): Double; virtual;
    procedure WriteFloat(const Section, Name: string; Value: Double); virtual;
    function  ReadTime(const Section, Name: string; Default: TDateTime): TDateTime; virtual;
    procedure WriteTime(const Section, Name: string; Value: TDateTime); virtual;
    procedure ConvertFormINI(pSection:string);
  published
  end;

var gImp:TImpdefHnd;

implementation

{ TImpdefHnd }

uses NexIni;

procedure TImpdefHnd.ConvertFormINI(pSection:string);
var mL:TStrings;mI:integer;mS,mV:String;
begin
  If not LocateSectionName(pSection) and gIni.SectionExists(pSection) then begin
    mL:=TStringList.Create;
    gIni.ReadSection(pSection,mL);
    for mI:=0 to mL.Count do begin
      mS:=mL[mI];
      mV:=gIni.ReadString(pSection,mS,'');
      gImp.WriteString(pSection,mS,mV);
    end;
    FreeAndNil(mL);
    gIni.EraseSection(pSection);
  end;
end;

function TImpdefHnd.ReadBool(const Section, Name: string;
  Default: Boolean): Boolean;
begin
  Result:=StrToBool(ReadString(Section,Name,BoolToStr(Default)));
end;

function TImpdefHnd.ReadDate(const Section, Name: string;
  Default: TDateTime): TDateTime;
begin
  Result:=StrToDate(ReadString(Section,Name,DateToStr(Default)));
end;

function TImpdefHnd.ReadDateTime(const Section, Name: string;
  Default: TDateTime): TDateTime;
begin
  Result:=StrToDateTime(ReadString(Section,name,DateTimeToStr(Default)));
end;

function TImpdefHnd.ReadFloat(const Section, Name: string;
  Default: Double): Double;
begin
  Result:=StrToFloat(ReadString(Section,Name,FloatToStr(Default)));
end;

function TImpdefHnd.ReadInteger(const Section, Name: string;
  Default: Integer): Longint;
begin
  Result:=StrToInt(ReadString(Section,Name,IntToStr(Default)));
end;

function TImpdefHnd.ReadString(const Section, Name,
  Default: string): string;
begin
  Result:=Default;
  If LocateSnIn (Section,Name)
    then Result:=KeyValue
    else Result:=Default;
end;

function TImpdefHnd.ReadTime(const Section, Name: string;
  Default: TDateTime): TDateTime;
begin
  Result:=StrToTime(ReadString(Section,Name,TimeToStr(Default)));
end;

procedure TImpdefHnd.WriteBool(const Section, Name: string;
  Value: Boolean);
begin
  WriteString(Section,Name,BoolToStr(Value));
end;

procedure TImpdefHnd.WriteDate(const Section, Name: string;
  Value: TDateTime);
begin
  WriteString(Section,Name,DateToStr(Value));
end;

procedure TImpdefHnd.WriteDateTime(const Section, Name: string;
  Value: TDateTime);
begin
  WriteString(Section,Name,DateTimeToStr(Value));
end;

procedure TImpdefHnd.WriteFloat(const Section, Name: string;
  Value: Double);
begin                                         
  WriteString(Section,Name,FloatToStr(Value));
end;

procedure TImpdefHnd.WriteInteger(const Section, Name: string;
  Value: Integer);
begin
  WriteString(Section,Name,IntToStr(Value));
end;

procedure TImpdefHnd.WriteString(const Section, Name, Value: String);
begin
  if not LocateSnIn(Section,Name) then begin
    Insert;
    SectionName:=Section;
    IdentName:=Name;
  end else Edit;
  KeyValue:=Value;
  Post;
end;

procedure TImpdefHnd.WriteTime(const Section, Name: string;
  Value: TDateTime);
begin
  WriteString(Section,Name,TimeToStr(Value));
end;

end.
