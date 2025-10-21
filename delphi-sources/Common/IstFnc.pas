unit IstFnc;
// =============================================================================
//                             FUNKCIE PRE INTRASTAT
// =============================================================================

interface

uses
  IcTypes, IcConv, IcVariab, IcTools, IcDate, NexPath, NexClc, NexGlob, eCCTDEF, eCCTLST, tCCTLST, hPROCAT, hPARCAT,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs, Forms, DateUtils;

type
  TIstFnc=class
    constructor Create;
    destructor Destroy; override;
  private
  public
    ohPROCAT:TProcatHnd;  // Katalóg produktov (Bázová evidncia)
    ohPARCAT:TParcatHnd;  // Katalóg partnerov
    ohCCTDEF:TCctdefHne;  // Definícia prenesenia daòovej povinnosti DPH
    ohCCTLST:TCctlstHne;  // Jednotný colný sadzobník
    otCCTLST:TCctlstTmp;  // Jednotný colný sadzobník - pre import
    function GetCctVat(pParNum,pProNum:longint):boolean; // TRUE ak platí prenesenie da+novej povinnosti DPH
  end;

implementation

constructor TIstFnc.Create;
begin
  ohPROCAT:=TProcatHnd.Create;
  ohPARCAT:=TParcatHnd.Create;
  ohCCTDEF:=TCctdefHne.Create;
  ohCCTLST:=TCctlstHne.Create;
  otCCTLST:=TCctlstTmp.Create;
end;

destructor TIstFnc.Destroy;
begin
  FreeAndNil(otCCTLST);
  FreeAndNil(ohCCTLST);
  FreeAndNil(ohCCTDEF);
  FreeAndNil(ohPARCAT);
  FreeAndNil(ohPROCAT);
end;

// ******************************** PRIVATE ************************************

// ********************************* PUBLIC ************************************

function TIstFnc.GetCctVat(pParNum,pProNum:longint):boolean; // TRUE ak platí prenesenie da+novej povinnosti DPH
begin
  Result:=FALSE;
  If (pParNum>0) and (pProNum>0) then begin
    ohCCTDEF.Open;
    If ohCCTDEF.Count>0 then begin // Kontrola na prenesenie daònovej povinnosti DPH
      If ohPARCAT.LocParNum(pParNum) then begin
        If (Length(ohPARCAT.RegVin)>=12) and (UpString((copy(ohPARCAT.RegVin,1,2)))='SK') then begin  // TODO - treba lepsiu kontrolu
          If ohPROCAT.LocProNum(pProNum) then begin
            If ohPROCAT.CctCod<>'' then begin
              If ohCCTDEF.LocBasCod(copy(ohPROCAT.CctCod,1,4)) then begin
                Result:=TRUE;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

end.


