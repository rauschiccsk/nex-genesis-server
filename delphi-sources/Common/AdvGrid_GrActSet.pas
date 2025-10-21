unit AdvGrid_GrActSet;

interface

uses
   TxtCut, IcConv,
   Forms, IniFiles, Classes, SysUtils;

Type
  TGrActSet = class (TIniFile)

  private
    { Private declarations }
  protected
    oSetName  :string;      // Nazov suboru nastavenia gridu
    oActSet   :string;      // Èíslo aktuálneho nastavenia
    oActIndex :string;      // Aktuálny index
    oActPos   :string;      // Aktuálna pozícia kurzora v databáze
    oFirstCol :longint;
    { Protected declarations }
  public
    constructor Create (pSetFile,pSetName:string); reintroduce;
    function    GetActSet:string;
    function    GetActIndex:string;
    function    GetActPos:string;
    function    GetFirstCol:longint;

    procedure   ReadData;
    procedure   SaveActSet (pActSet,pActIndex,pActPos:string;pFirstCol:longint);

    { Public declarations }
  published
    { Published declarations }
  end;

implementation

constructor TGrActSet.Create(pSetFile,pSetName:string);
begin
  If ExtractFileName (pSetFile)='' then pSetFile := pSetFile+'DEFAULT';
  inherited Create(pSetFile+'.SET');
  oSetName := pSetName;
  If not ValueExists ('VIEWS',oSetName) then SaveActSet ('D01','','',1);
end;

procedure  TGrActSet.ReadData;
var mCut: TTxtCut;
begin
  mCut := TTxtCut.Create;
  mCut.SetDelimiter ('');
  mCut.SetSeparator (',');
  mCut.SetStr (ReadString('VIEWS',oSetName,''));
  oActSet := mCut.GetText (1);
  oActIndex := mCut.GetText (2);
  oActPos := mCut.GetText (3);
  oFirstCol := mCut.GetNum (4);
  mCut.Free;
end;

function  TGrActSet.GetActSet:string;
begin
  ReadData;
  Result := oActSet;
end;

function  TGrActSet.GetActIndex:string;
begin
  Result := oActIndex;
end;

function  TGrActSet.GetActPos:string;
begin
  Result := oActPos;
end;

function  TGrActSet.GetFirstCol:longint;
begin
  Result := oFirstCol;
end;

procedure TGrActSet.SaveActSet(pActSet,pActIndex,pActPos:string;pFirstCol:longint);
begin
  WriteString('VIEWS',oSetName,pActSet+','+pActIndex+','+pActPos+','+StrInt (pFirstCol,0));
end;

end.
