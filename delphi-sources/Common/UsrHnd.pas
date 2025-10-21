unit UsrHnd;

interface

uses
  IcTypes,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, BtrTable, NexBtrTable;

type
  TUsr = class(TForm)
    btUSRLST: TNexBtrTable;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    function ReadCount:integer;
    function ReadLogName:Str8;
    procedure WriteLogName(pValue:Str8);
    function ReadLogOwnr:Str20;
    procedure WriteLogOwnr(pValue:Str20);
    function ReadUsrName:Str30;
    procedure WriteUsrName(pValue:Str30);
    function ReadActLang:Str2;
    procedure WriteActLang(pValue:Str2);
    function ReadMaxDsc:byte;
    procedure WriteMaxDsc(pValue:byte);
  public
    function Eof: boolean;
    function LocLogName (pLogName:Str8):boolean; // Nastavi databazovy kurzor na zadaneho uzivatela
    function GetUsrName (pLogName:Str8):Str30; // Funkcia vrati plne meno na zaklade priezviska
    procedure Prior;
    procedure Next;
    procedure First;
    procedure Last;
    procedure Insert;
    procedure Edit;
    procedure Post;
    procedure SwapIndex;
    procedure RestoreIndex;
    procedure IndLogName; // Nastavi index na LogName
    procedure IndLnLo;    // nastavi index na LogName LogOwnr
  published
    property DataSet:TNexBtrTable read btUSRLST;
    property Count:integer read ReadCount;
    property LogName:Str8 read ReadLogName write WriteLogName;
    property LogOwnr:Str20 read ReadLogOwnr write WriteLogOwnr;
    property UsrName:Str30 read ReadUsrName write WriteUsrName;
    property ActLang:Str2 read ReadActLang write WriteActLang;
    property MaxDsc:byte read ReadMaxDsc write WriteMaxDsc;
  end;

implementation

{$R *.dfm}

procedure TUsr.FormCreate(Sender: TObject);
begin
  btUSRLST.Open;
end;

procedure TUsr.FormDestroy(Sender: TObject);
begin
  btUSRLST.Close;
end;

// *************************************** PRIVATE ********************************************

function TUsr.ReadCount:integer;
begin
  Result := btUSRLST.RecordCount;
end;

function TUsr.ReadLogName:Str8;
begin
  Result := btUSRLST.FieldByName('LoginName').AsString;
end;

procedure TUsr.WriteLogName(pValue:Str8);
begin
  btUSRLST.FieldByName('LoginName').AsString := pValue;
end;

function TUsr.ReadLogOwnr:Str20;
begin
  Result := btUSRLST.FieldByName('LoginOwnr').AsString;
end;

procedure TUsr.WriteLogOwnr(pValue:Str20);
begin
  btUSRLST.FieldByName('LoginOwnr').AsString := pValue;
end;

function TUsr.ReadUsrName:Str30;
begin
  Result := btUSRLST.FieldByName('UserName').AsString;
end;

procedure TUsr.WriteUsrName(pValue:Str30);
begin
  btUSRLST.FieldByName('UserName').AsString := pValue;
end;

function TUsr.ReadActLang:Str2;
begin
  Result := btUSRLST.FieldByName('Language').AsString;
end;

procedure TUsr.WriteActLang(pValue:Str2);
begin
  btUSRLST.FieldByName('Language').AsString := pValue;
end;

function TUsr.ReadMaxDsc:byte;
begin
  Result := btUSRLST.FieldByName('MaxDsc').AsInteger;
end;

procedure TUsr.WriteMaxDsc(pValue:byte);
begin
  btUSRLST.FieldByName('MaxDsc').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TUsr.Eof: boolean;
begin
  Result := btUSRLST.Eof;
end;

function TUsr.LocLogName (pLogName:Str8):boolean; // Nastavi databazovy kurzor na zadaneho uzivatela
begin
  If btUSRLST.IndexName<>'LoginName' then btUSRLST.IndexName := 'LoginName';
  Result := btUSRLST.FindKey([pLogName]);
end;

function TUsr.GetUsrName (pLogName:Str8):Str30; // Funkcia vrati plne meno na zaklade priezviska
begin
  Result := '';
  btUSRLST.SwapIndex;
  If LocLogName (pLogName) then Result := UsrName;
  btUSRLST.RestoreIndex
end;

procedure TUsr.Prior;
begin
  btUSRLST.Prior;
end;

procedure TUsr.Next;
begin
  btUSRLST.Next;
end;

procedure TUsr.First;
begin
  btUSRLST.First;
end;

procedure TUsr.Last;
begin
  btUSRLST.Last;
end;

procedure TUsr.Insert;
begin
  btUSRLST.Insert;
end;

procedure TUsr.Edit;
begin
  btUSRLST.Edit;
end;

procedure TUsr.Post;
begin
  btUSRLST.Post;
end;

procedure TUsr.SwapIndex;
begin
  btUSRLST.SwapIndex;
end;

procedure TUsr.RestoreIndex;
begin
  btUSRLST.RestoreIndex;
end;

procedure TUsr.IndLogName; // Nastavi index na LogName
begin
  If btUSRLST.IndexName<>'LoginName' then btUSRLST.IndexName := 'LoginName';
end;

procedure TUsr.IndLnLo;    // nastavi index na LogName LogOwnr
begin
  If btUSRLST.IndexName<>'LnLo' then btUSRLST.IndexName := 'LnLo';
end;

end.
