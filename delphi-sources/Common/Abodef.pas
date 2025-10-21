unit Abodef;
{$F+}

// *****************************************************************************
//              OBJEKT NA PRACU S ROZUCTOVACIMI PREDPISMI PRE ABO
// *****************************************************************************
// Programové funkcia:
// ---------------
// *****************************************************************************


interface

uses
  IcTypes, IcConst, IcConv, IcTools, NexGlob, NexPath, Key, hABODEF,
  ComCtrls, SysUtils, Classes, Forms, MxArrays;

type
  TAbodef = class
    constructor Create;
    destructor  Destroy; override;
    private
      ohABODEF:TAbodefHnd;
      oAccSnt:Str3;
      oAccAnl:Str6;
      oAccTxt:Str30;
    public
      function Find(pCoSymb,pSpSymb,pVaSymb:Str20;pNotice:Str30;pPayVal:double):boolean; // TRUE ak podarilo sa identifikova5 zadanu polozku
    published
      property AccSnt:Str3 read oAccSnt write oAccSnt;
      property AccAnl:Str6 read oAccAnl write oAccAnl;
      property AccTxt:Str30 read oAccTxt write oAccTxt;
  end;

implementation

constructor TAbodef.Create;
begin
  ohABODEF := TAbodefHnd.Create;  ohABODEF.Open;
end;

destructor TAbodef.Destroy;
begin
  ohABODEF.Close;FreeAndNil(ohABODEF);
end;

// ********************************* PRIVATE ***********************************

// ********************************** PUBLIC ***********************************

function TAbodef.Find(pCoSymb,pSpSymb,pVaSymb:Str20;pNotice:Str30;pPayVal:double):boolean; // TRUE ak podarilo sa identifikova5 zadanu polozku
var mPySign:Str1;
begin
  Result := FALSE;
  oAccSnt := '';  oAccAnl := '';  oAccTxt := '';
  If ohABODEF.Count>0 then begin
    If pPayVal>0
      then mPySign := '+'
      else mPySign := '-';
    ohABODEF.First;
    Repeat
      Result := ((ohABODEF.CoSymb=pCoSymb) or (ohABODEF.CoSymb='*')) and
                ((ohABODEF.SpSymb=pSpSymb) or (ohABODEF.SpSymb='*')) and
                ((ohABODEF.VaSymb=pVaSymb) or (ohABODEF.VaSymb='*')) and
                ((ohABODEF.PySign=mPySign) or (ohABODEF.PySign='*')) and
                ((ohABODEF.Notice=pNotice) or (ohABODEF.Notice='*'));
      If Result then begin
        oAccSnt := ohABODEF.AccSnt;
        oAccAnl := ohABODEF.AccAnl;
        oAccTxt := ohABODEF.AccTxt;
      end;
      ohABODEF.Next;
    until ohABODEF.Eof or (Result=TRUE);
  end;
end;

end.


