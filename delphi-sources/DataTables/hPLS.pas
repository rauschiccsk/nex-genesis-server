unit hPLS;

interface

uses
  IcTypes, NexPath, NexGlob, bPLS, bPLSADD,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TPlsHnd = class (TPlsBtr)
  private
    obPLSADD : TPlsaddBtr;
  public
    procedure OpenPlsAdd;
    procedure ClosePlsAdd;
    procedure Post; override;
    procedure Delete; override;
    function  GetLevAPrice(pGsCode:longint;pLevNum:byte):double; // Predajna cena zadanej cenovej hladiny
    function  GetLevBPrice(pGsCode:longint;pLevNum:byte):double; // Predajna cena zadanej cenovej hladiny
    function  GetFixLevelItem(pLevNum:byte):boolean; // Zistenie pevnej cenovej hladiny
    procedure SetFixLevelItem(pLevNum:byte;pValue:boolean); // Nastavenie pevna cenova hladina
  published
  end;

implementation

// *************************************** PRIVATE ********************************************

// **************************************** PUBLIC ********************************************

function TPlsHnd.GetLevAPrice(pGsCode:longint;pLevNum:byte):double; // Predajna cena zadanej cenovej hladiny
begin
  Result := 0;
  If LocateGsCode(pGsCode) then begin
    case pLevNum of
      1: Result := APrice1;
      2: Result := APrice2;
      3: Result := APrice3;
      else Result := APrice;
    end;
  end;
end;

function TPlsHnd.GetLevBPrice(pGsCode:longint;pLevNum:byte):double; // Predajna cena zadanej cenovej hladiny
begin
  Result := 0;
  If LocateGsCode(pGsCode) then begin
    case pLevNum of
      1: Result := BPrice1;
      2: Result := BPrice2;
      3: Result := BPrice3;
      else Result := BPrice;
    end;
  end;
end;

function TPlsHnd.GetFixLevelItem(pLevNum:byte):boolean; // Zistenie pevnej cenovej hladiny
var mOP:boolean;
begin
  Result := False;
  mOP:=obPLSADD=NIL;
  If mOP then begin
    obPLSADD:=TPlsaddBtr.Create;
    obPLSADD.open;
  end;
  If obPLSADD.LocatePnGc(BtrTable.ListNum,GsCode) then begin
    case pLevNum of
      0: Result:=(obPLSADD.FixLevel and 1)<>0;
      1: Result:=(obPLSADD.FixLevel and 2)<>0;
      2: Result:=(obPLSADD.FixLevel and 4)<>0;
      3: Result:=(obPLSADD.FixLevel and 8)<>0;
    end;
  end;
  If mOp then begin
    obPLSADD.Close;
    FreeAndNil(obPLSADD);
  end;
end;

procedure TPlsHnd.setFixLevelItem(pLevNum:byte;pValue:boolean); // Nastevenie pevnej cenovej hladiny
var mOP:boolean;
begin
  mOP:=obPLSADD=NIL;
  If mOP then begin
    obPLSADD:=TPlsaddBtr.Create;
    obPLSADD.open;
  end;
  If obPLSADD.LocatePnGc(BtrTable.ListNum,GsCode) then obPLSADD.Edit else obPLSADD.Insert;
  obPLSADD.PlsNum:=BtrTable.ListNum;
  obPLSADD.GsCode:= GsCode;
  case pLevNum of
    0: If pValue then obPLSADD.FixLevel:=(obPLSADD.FixLevel or 1) else obPLSADD.FixLevel:=(obPLSADD.FixLevel and 254);
    1: If pValue then obPLSADD.FixLevel:=(obPLSADD.FixLevel or 2) else obPLSADD.FixLevel:=(obPLSADD.FixLevel and 253);
    2: If pValue then obPLSADD.FixLevel:=(obPLSADD.FixLevel or 4) else obPLSADD.FixLevel:=(obPLSADD.FixLevel and 251);
    3: If pValue then obPLSADD.FixLevel:=(obPLSADD.FixLevel or 8) else obPLSADD.FixLevel:=(obPLSADD.FixLevel and 247);
  end;
  obPLSADD.Post;
  If mOp then begin
    obPLSADD.Close;
    FreeAndNil(obPLSADD);
  end;
end;

procedure TPlsHnd.Delete;
var mOP:boolean;
begin
  mOP:=obPLSADD=NIL;
  If mOP then begin
    obPLSADD:=TPlsaddBtr.Create;
    obPLSADD.open;
  end;
  If obPLSADD.LocatePnGc(BtrTable.ListNum,GsCode) then obPLSADD.Delete;
  If mOp then begin
    obPLSADD.Close;
    FreeAndNil(obPLSADD);
  end;
  inherited;
end;

procedure TPlsHnd.Post;
begin
  inherited;

end;

procedure TPlsHnd.ClosePlsAdd;
begin
    obPLSADD.Close;
    FreeAndNil(obPLSADD);
end;

procedure TPlsHnd.OpenPlsAdd;
begin
    obPLSADD:=TPlsaddBtr.Create;
    obPLSADD.open;
end;

end.
