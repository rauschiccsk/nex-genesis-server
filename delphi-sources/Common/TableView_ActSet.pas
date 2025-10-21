unit TableView_ActSet;

interface

uses
     IcVariab, IcTypes, IcConv, NexPath, TxtCut,
     IniFiles, Classes, SysUtils;

Type
  TActSet = class (TIniFile)

  private
    { Private declarations }
  protected
    { Protected declarations }
    oSetName: Str8;      // Nazov suboru nastavenia gridu
    oActSet: Str3;       // Èíslo aktuálneho nastavenia
    oActIndex: integer;  // Èíslo aktuálneho indexového k¾úèa
    oActPos: integer;    // Aktuálna pozícia kurzora v databáze
    oFormHeight: word;   // Vyska okna na ktotom je umistneny tento komponent
    oFormWidth: word;    // Sirka okna na ktotom je umistneny tento komponent
    procedure   ReadData;
  public
    { Public declarations }
    constructor Create(pSetName:Str8); reintroduce;
    function    GetActSet: Str3;
    function    GetActIndex: word;
    function    GetActPos: longint;
    function    GetFormHeight: word;
    function    GetFormWidth: word;
    procedure   SaveActSet (pActSet:Str3; pActIndex:integer; pActPos:longint; pFormHeight,pFormWidth:integer);

  published
    { Published declarations }
  end;

var gActSet: TActSet;

implementation

uses  DM_SYSTEM;

constructor TActSet.Create(pSetName:Str8);
var mFileName: string;
begin
  oSetName := pSetName;
  If FileExists (GetLngPath+gvSYS.LoginName+'.GRD')
    then mFileName := GetLngPath+gvSYS.LoginName+'.GRD'
    else mFileName := GetLngPath+'DEFAULT.GRD';
  inherited Create(mFileName);
  If not ValueExists ('VIEWS',oSetName) then SaveActSet ('D01',1,0,0,0);
end;

procedure  TActSet.ReadData;
var mCut: TTxtCut;
begin
  mCut := TTxtCut.Create;
  mCut.SetDelim ('');
  mCut.SetStr (ReadString('VIEWS',oSetName,''));
  oActSet := mCut.GetText (1);
  oActIndex := mCut.GetNum (2);
  oActPos := mCut.GetNum (3);
  oFormHeight := mCut.GetNum (4);
  oFormWidth := mCut.GetNum (5);
  mCut.Free;
end;

function  TActSet.GetActSet: Str3;
begin
  ReadData;
  Result := oActSet;
end;

function  TActSet.GetActIndex: word;
begin
  ReadData;
  Result := oActIndex;
end;

function  TActSet.GetActPos: longint;
begin
  ReadData;
  Result := oActPos;
end;

function  TActSet.GetFormHeight: word;
begin
  ReadData;
  Result := oFormHeight;
end;

function  TActSet.GetFormWidth: word;
begin
  ReadData;
  Result := oFormWidth;
end;

procedure TActSet.SaveActSet(pActSet:Str3; pActIndex:integer; pActPos:longint; pFormHeight,pFormWidth:integer);
begin
  WriteString('VIEWS',oSetName,pActSet+','+StrInt(pActIndex,0)+','+StrInt(pActPos,0)+','+StrInt(pFormHeight,0)+','+StrInt(pFormWidth,0));
end;


end.
