unit hGSNAME;

interface

uses
  IcTypes, IcTools, IcConv, NexPath, NexGlob,  bGSNAME,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TGsnameHnd = class (TGsnameBtr)
    constructor Create; virtual;
    destructor  Destroy; override;
  private
    oGscLst:TStrings;
  public
    procedure Add (pGsCode:longint;pGsName:Str60); // Rozbije n8zov na slova a prida ich do databaze
    procedure Del (pGsCode:longint);  // Vymaze vsetky slova zadaneho PLU z databaze
    procedure Src (pGsName:Str60); // Vyhlada PLU v ktorych je zadany nazov
  published
    property GscLst:TStrings read oGscLst;
  end;

implementation

constructor TGsnameHnd.Create;
begin
  inherited;
  oGscLst := TStringList.Create;
end;

destructor  TGsnameHnd.Destroy;
begin
  FreeAndNil (oGscLst);
  inherited
end;

// *************************************** PRIVATE ********************************************

// **************************************** PUBLIC ********************************************

procedure TGsnameHnd.Add (pGsCode:longint;pGsName:Str60);
var mQnt,I:byte;  mTxt:Str30;
begin
  Del (pGsCode);
  mQnt := LineElementNum (pGsName,' ');
  For I:=0 to mQnt-1 do begin
    mTxt := LineElement (pGsName,I,' ');
    If (mTxt<>'') and (mTxt<>' ') then begin
      Insert;
      GsCode := pGsCode;
      GsName := StrToAlias (mTxt);
      Post;
    end;
  end;
end;

procedure TGsnameHnd.Del (pGsCode:longint);
begin
  If LocateGsCode (pGsCode) then begin
    Repeat
      Delete;
    until Eof or (GsCode<>pGsCode);
  end;
end;

procedure TGsnameHnd.Src (pGsName:Str60); // Vyhlada PLU v ktorych je zadany nazov
var mGsName:Str60; mLen:byte; mPartSrc:boolean; // Hladat cast slova
begin
  oGscLst.Clear;
  mLen := Length (pGsName);
  mGsName := StrToAlias(pGsName);
  mPartSrc := mGsName[mLen]='*';
  If mPartSrc then begin // Hladat cast slova
    System.Delete (mGsName,mLen,1);
    If NearestGsName (mGsName) then begin
      Repeat
        oGscLst.Add (StrInt(GsCode,0));
        Next;
      until Eof or (Pos(mGsName,GsName)=0);
    end;
  end
  else begin // Hladatcele slovo
    If LocateGsName (mGsName) then begin
      Repeat
        oGscLst.Add (StrInt(GsCode,0));
        Next;
      until Eof or (GsName<>mGsName);
    end;
  end;
end;

end.
