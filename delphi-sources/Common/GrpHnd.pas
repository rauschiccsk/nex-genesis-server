unit GrpHnd;
// UsrGrp.BDF UsrGrp.TDF USRLST.BDF
interface

uses
  IcTypes,
  hUsrGrp,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, BtrTable, NexBtrTable;

type
  TGrp = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    ohUsrGrp : TUsrGrpHnd;
    function ReadCount:integer;
    function ReadGrpName:Str30;
    procedure WriteGrpName(pValue:Str30);
    function ReadActLang:Str2;
    procedure WriteActLang(pValue:Str2);
    function ReadMaxDsc:byte;
    procedure WriteMaxDsc(pValue:byte);
  public
    function Eof: boolean;
    function LocGrpName (pGrpName:Str30):boolean; // Nastavi databazovy kurzor na zadaneho uzivatela
    procedure Prior;
    procedure Next;
    procedure First;
    procedure Last;
    procedure Insert;
    procedure Edit;
    procedure Post;
    procedure SwapIndex;
    procedure RestoreIndex;
    procedure IndGrpName; // Nastavi index na GrpName
  published
    property DataSet:TNexBtrTable read ohUsrGrp.Btrtable;
    property Count:integer read ReadCount;
    property GrpName:Str30 read ReadGrpName write WriteGrpName;
    property ActLang:Str2 read ReadActLang write WriteActLang;
    property MaxDsc:byte read ReadMaxDsc write WriteMaxDsc;
  end;

implementation

{$R *.dfm}

procedure TGrp.FormCreate(Sender: TObject);
begin
  ohUsrGrp := TUsrGrpHnd.Create;
  ohUsrGrp.Open;
end;

procedure TGrp.FormDestroy(Sender: TObject);
begin
  ohUsrGrp.Close;
  FreeAndNil(ohUsrGrp);
end;

// *************************************** PRIVATE ********************************************

function TGrp.ReadCount:integer;
begin
  Result := ohUsrGrp.RecordCount;
end;

function TGrp.ReadGrpName:Str30;
begin
  Result := ohUsrGrp.FieldByName('GrpName').AsString;
end;

procedure TGrp.WriteGrpName(pValue:Str8);
begin
  ohUsrGrp.FieldByName('LoginName').AsString := pValue;
end;

function TGrp.ReadLogOwnr:Str20;
begin
  Result := ohUsrGrp.FieldByName('LoginOwnr').AsString;
end;

procedure TGrp.WriteLogOwnr(pValue:Str20);
begin
  ohUsrGrp.FieldByName('LoginOwnr').AsString := pValue;
end;

function TGrp.ReadUsrName:Str30;
begin
  Result := ohUsrGrp.FieldByName('UserName').AsString;
end;

procedure TGrp.WriteUsrName(pValue:Str30);
begin
  ohUsrGrp.FieldByName('UserName').AsString := pValue;
end;

function TGrp.ReadActLang:Str2;
begin
  Result := ohUsrGrp.FieldByName('Language').AsString;
end;

procedure TGrp.WriteActLang(pValue:Str2);
begin
  ohUsrGrp.FieldByName('Language').AsString := pValue;
end;

function TGrp.ReadMaxDsc:byte;
begin
  Result := ohUsrGrp.FieldByName('MaxDsc').AsInteger;
end;

procedure TGrp.WriteMaxDsc(pValue:byte);
begin
  ohUsrGrp.FieldByName('MaxDsc').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TGrp.Eof: boolean;
begin
  Result := ohUsrGrp.Eof;
end;

function TGrp.LocGrpName (pGrpName:Str8):boolean; // Nastavi databazovy kurzor na zadaneho uzivatela
begin
  If ohUsrGrp.IndexName<>'LoginName' then ohUsrGrp.IndexName := 'LoginName';
  Result := ohUsrGrp.FindKey([pGrpName]);
end;

function TGrp.GetUsrName (pGrpName:Str8):Str30; // Funkcia vrati plne meno na zaklade priezviska
begin
  Result := '';
  ohUsrGrp.SwapIndex;
  If LocGrpName (pGrpName) then Result := UsrName;
  ohUsrGrp.RestoreIndex
end;

procedure TGrp.Prior;
begin
  ohUsrGrp.Prior;
end;

procedure TGrp.Next;
begin
  ohUsrGrp.Next;
end;

procedure TGrp.First;
begin
  ohUsrGrp.First;
end;

procedure TGrp.Last;
begin
  ohUsrGrp.Last;
end;

procedure TGrp.Insert;
begin
  ohUsrGrp.Insert;
end;

procedure TGrp.Edit;
begin
  ohUsrGrp.Edit;
end;

procedure TGrp.Post;
begin
  ohUsrGrp.Post;
end;

procedure TGrp.SwapIndex;
begin
  ohUsrGrp.SwapIndex;
end;

procedure TGrp.RestoreIndex;
begin
  ohUsrGrp.RestoreIndex;
end;

procedure TGrp.IndGrpName; // Nastavi index na GrpName
begin
  If ohUsrGrp.IndexName<>'LoginName' then ohUsrGrp.IndexName := 'LoginName';
end;

procedure TGrp.IndLnLo;    // nastavi index na GrpName LogOwnr
begin
  If ohUsrGrp.IndexName<>'LnLo' then ohUsrGrp.IndexName := 'LnLo';
end;

end.
