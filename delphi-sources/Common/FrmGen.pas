unit FrmGen;
// *****************************************************************************
//                Generovanie retazca podla zadaneho formatu
// *****************************************************************************

interface

uses
  IcTypes, IcVariab, IcConv, NexVar, NexMsg, NexError,
  IniFiles, Classes, SysUtils;

type
  TParRec = record
    ParMrk:Str1;
    ParVal:Str10;
    ParPos:byte;
    ParLen:byte;
  end;

  TFrmGen = class
    constructor Create;
    destructor  Destroy; override;
  private
    oFormat:ShortString;
    oResult:ShortString;
    oParQnt:byte;
    oParLst:array [1..10] of TParRec;
    function GetResult:ShortString;
    procedure Analyze; // Analyzuje a rozlozi zadany format na parametre
    procedure Generat; // Vygeneruje retazec podla zadaneho formatu
  public
    procedure Add(pParMrk:Str1;pParVal:Str10);
    property Format:ShortString write oFormat;
    property Result:ShortString read GetResult;
  end;

implementation

constructor TFrmGen.Create;
begin
  oParQnt := 0;
  FillChar (oParLst,SizeOf(oParLst),#0);
end;

destructor TFrmGen.Destroy;
begin
end;

// ********************************** PRIVATE **********************************

procedure TFrmGen.Analyze; // Analyzuje a rozlozi zadany format na parametre
var mPos,mLen,I:byte;  mFind:boolean;
begin
  For I:=1 to oParQnt do begin
    mPos := Pos(oParLst[I].ParMrk,oFormat);
    If mPos>0 then begin
      mLen := 0;  mFind := FALSE;
      Repeat
        If oFormat[mPos+mLen]=oParLst[I].ParMrk then begin
          Inc (mLen);
          mFind := TRUE;
        end
        else mFind := FALSE;
      until not mFind;
      oParLst[I].ParPos := mPos;
      oParLst[I].ParLen := mLen;
    end;
  end;
end;

procedure TFrmGen.Generat; // Vygeneruje retazec podla zadaneho formatu
var mLen,I,J:byte;
begin
  oResult := oFormat;
  For I:=1 to oParQnt do begin
    If oParLst[I].ParPos>0 then begin
      Delete(oResult,oParLst[I].ParPos,oParLst[I].ParLen);
      mLen := Length(oParLst[I].ParVal);
      If oParLst[I].ParLen>mLen then begin // Hodnota je kratsia ako format preto doplnime z lava nulami
        For J:=1 to oParLst[I].ParLen-mLen do
          Insert('0',oParLst[I].ParVal,1);
      end;
      If oParLst[I].ParLen<mLen then begin // Format je kratsi ako hodnota preto orezame z lava
        Delete(oParLst[I].ParVal,1,mLen-oParLst[I].ParLen);
      end;
      Insert (oParLst[I].ParVal,oResult,oParLst[I].ParPos);
    end;
  end;
end;

function TFrmGen.GetResult:ShortString;
begin
  Analyze; // Analyzuje a rozlozi zadany format na parametre
  Generat; // Vygeneruje retazec podla zadaneho formatu
  Result := oResult;
end;

// *********************************** PUBLIC **********************************

procedure TFrmGen.Add(pParMrk:Str1;pParVal:Str10);
begin
  Inc(oParQnt);
  oParLst[oParQnt].ParMrk := pParMrk;
  oParLst[oParQnt].ParVal := pParVal;
end;

end.
