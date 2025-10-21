unit DefRgh;

interface

uses
  IcTypes, IcVariab, IcConv, NexIni,
  hUsrGrp,
  Windows, Registry, SysUtils, Forms, Classes;

const
//
   rgService =  2;   // Servisne pristupove prava
   rgDiscret =  4;   // Zobrazit diskretne udaje
   rgShowAcc =  8;   // Zobrazit uctovne zapisy pri opusteni dokladu
   rgBprChg  = 16;   // Povolit zmenit predajnu cenu pri predaji
   rgStdUnl  = 32;   // Povolit odomknutie skladovych dokladov
   rgLgdUnl  = 64;   // Povolit odomknutie uctovnych dokladov
   rgBkProp  = 128;  // Povolit zmenit vlastnosti knih

type
  TDefSet = array [1..5] of word;

  TDefRgh = class
    constructor Create;
    destructor Destroy; override;
  private
    ohUsrGrp : TUsrGrpHnd;
    oDefSet: TDefSet;  // Zakladne nastavenia uzivatelov
    oMaxDsc: byte; // Maximalna zlava co moze poskytnut uzivatel pri MO a VO predaji
    oMinPrf: integer; // Minimalne obchodne prozpatie poskytnut uzivatel pri MO a VO predaji
  public
    procedure Clear; // Vybnuluje nastavenua
    procedure LoadRight (pGroupNum:integer); // Nacita pristupove prava zadaneho uzivatela
    procedure SaveRight (pGroupNum:integer);  // Ulozi zadane prava pristupu do databazovehos uboru

    function GetDefSet(Index:byte):word;
    procedure SetDefSet (Index:byte;pValue:word);

    function GetService:boolean;
    procedure SetService (pValue:boolean);
    function GetDiscret:boolean;
    procedure SetDiscret (pValue:boolean);
    function GetShowAcc:boolean;
    procedure SetShowAcc (pValue:boolean);
    function GetBprChg:boolean;
    procedure SetBprChg (pValue:boolean);
    function GetStdUnl:boolean;
    procedure SetStdUnl (pValue:boolean);
    function GetLgdUnl:boolean;
    procedure SetLgdUnl (pValue:boolean);
    function GetBkProp:boolean;
    procedure SetBkProp (pValue:boolean);

    property DefSet[Index:byte]:word read GetDefSet write SetDefSet;
    property Service:boolean read GetService write SetService;
    property Discret:boolean read GetDiscret write SetDiscret;
    property ShowAcc:boolean read GetShowAcc write SetShowAcc;
    property BprChg:boolean read GetBprChg write SetBprChg;
    property StdUnl:boolean read GetStdUnl write SetStdUnl;
    property LgdUnl:boolean read GetLgdUnl write SetLgdUnl;
    property BkProp:boolean read GetBkProp write SetBkProp;

    property MaxDsc:byte read oMaxDsc write oMaxDsc;
    property MinPrf:integer read oMinPrf write oMinPrf;
  end;

var gRgh: TDefRgh;

implementation

uses
  bUsrGrp;

constructor TDefRgh.Create;
begin
  ohUsrGrp:=TUsrGrpHnd.Create;ohUsrGrp.Open;
  // Nacitame pristupove prava prihlaseneho uzivatela k pouzitiu programovych modulov
end;

procedure TDefRgh.Clear; // Vybnuluje nastavenua
begin
  FillChar (oDefSet,SizeOf(oDefSet),#0);
  oMaxDsc := 0;
  oMinPrf := 0;
end;

procedure TDefRgh.LoadRight(pGroupNum:integer); // Nacita pristupove prava zadaneho uzivatela
var mGroupName:Str30;
begin
  FillChar (oDefSet,SizeOf(oDefSet),#0);
  If ohUsrGrp.LocateGrpNum(pGroupNum) then begin
    If (pGroupNum=0) then begin
      // Pre administratora su vsetky pristupove prava pridelene
      oDefSet[1] := 65535;
      oDefSet[2] := 65535;
      oDefSet[3] := 65535;
      oDefSet[4] := 65535;
      oDefSet[5] := 65535;
    end
    else begin
      oDefSet[1] := ohUsrGrp.DefSet1;
      oDefSet[2] := ohUsrGrp.DefSet2;
      oDefSet[3] := ohUsrGrp.DefSet3;
      oDefSet[4] := ohUsrGrp.DefSet4;
      oDefSet[5] := 65535;
//      oDefSet[5] := dmSYS.btUSRLST.FieldByName ('DefSet5').AsInteger;
    end;
    oMaxDsc := ohUsrGrp.MaxDsc;
    oMinPrf := ohUsrGrp.MinPrf;
  end;
end;

destructor TDefRgh.Destroy;
begin
  ohUsrGrp.Close;FreeAndNil(ohUsrGrp);
end;

procedure TDefRgh.SaveRight (pGroupNum:integer);  // Ulozi zadane prava pristupu do databazovehos uboru
begin
end;

// ------------------------------------------------------

function TDefRgh.GetDefSet(Index:byte):word;
begin
  Result := oDefSet[Index];
end;

procedure TDefRgh.SetDefSet (Index:byte;pValue:word);
begin
  oDefSet[Index] := pValue;
end;

//**************************** PROPERTY ****************************
function TDefRgh.GetService:boolean;
begin
  Result := (oDefSet[1] and rgService)=rgService;
end;

procedure TDefRgh.SetService (pValue:boolean);
begin
  If pValue
    then oDefSet[1] := oDefSet[1] or rgService
    else begin
      If GetService then oDefSet[1] := oDefSet[1]-rgService
    end;
end;

function TDefRgh.GetDiscret:boolean;
begin
  Result := (oDefSet[1] and rgDiscret)=rgDiscret;
end;

procedure TDefRgh.SetDiscret (pValue:boolean);
begin
  If pValue
    then oDefSet[1] := oDefSet[1] or rgDiscret
    else begin
      If GetDiscret then oDefSet[1] := oDefSet[1]-rgDiscret
    end;
end;

function TDefRgh.GetShowAcc:boolean;
begin
  Result := (oDefSet[1] and rgShowAcc)=rgShowAcc;
end;

procedure TDefRgh.SetShowAcc (pValue:boolean);
begin
  If pValue
    then oDefSet[1] := oDefSet[1] or rgShowAcc
    else begin
      If GetShowAcc then oDefSet[1] := oDefSet[1]-rgShowAcc
    end;
end;

function TDefRgh.GetBprChg:boolean;
begin
  Result := (oDefSet[1] and rgBprChg)=rgBprChg;
end;

procedure TDefRgh.SetBprChg (pValue:boolean);
begin
  If pValue
    then oDefSet[1] := oDefSet[1] or rgBprChg
    else begin
      If GetBprChg then oDefSet[1] := oDefSet[1]-rgBprChg
    end;
end;

function TDefRgh.GetStdUnl:boolean;
begin
  Result := (oDefSet[1] and rgStdUnl)=rgStdUnl;
end;

procedure TDefRgh.SetStdUnl (pValue:boolean);
begin
  If pValue
    then oDefSet[1] := oDefSet[1] or rgStdUnl
    else begin
      If GetStdUnl then oDefSet[1] := oDefSet[1]-rgStdUnl
    end;
end;

function TDefRgh.GetLgdUnl:boolean;
begin
  Result := (oDefSet[1] and rgLgdUnl)=rgLgdUnl;
end;

procedure TDefRgh.SetLgdUnl (pValue:boolean);
begin
  If pValue
    then oDefSet[1] := oDefSet[1] or rgLgdUnl
    else begin
      If GetLgdUnl then oDefSet[1] := oDefSet[1]-rgLgdUnl
    end;
end;

function TDefRgh.GetBkProp:boolean;
begin
  Result := (oDefSet[1] and rgBkProp)=rgBkProp;
end;

procedure TDefRgh.SetBkProp (pValue:boolean);
begin
  If pValue
    then oDefSet[1] := oDefSet[1] or rgBkProp
    else begin
      If GetBkProp then oDefSet[1] := oDefSet[1]-rgBkProp
    end;
end;

end.
