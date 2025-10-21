unit tTNVFRG;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ix = '';

type
  TTnvfrgTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadStaCode:Str3;          procedure WriteStaCode (pValue:Str3);
    function  ReadTyp:byte;              procedure WriteTyp (pValue:byte);
    function  ReadStaName:Str30;         procedure WriteStaName (pValue:Str30);
    function  ReadName:Str30;            procedure WriteName (pValue:Str30);
    function  Read1:word;                procedure Write1 (pValue:word);
    function  Read2:word;                procedure Write2 (pValue:word);
    function  Read3:word;                procedure Write3 (pValue:word);
    function  Read4:word;                procedure Write4 (pValue:word);
    function  Read5:word;                procedure Write5 (pValue:word);
    function  Read6:word;                procedure Write6 (pValue:word);
    function  Read7:word;                procedure Write7 (pValue:word);
    function  Read8:word;                procedure Write8 (pValue:word);
    function  Read9:word;                procedure Write9 (pValue:word);
    function  Read10:word;               procedure Write10 (pValue:word);
    function  Read11:word;               procedure Write11 (pValue:word);
    function  Read12:word;               procedure Write12 (pValue:word);
    function  Read13:word;               procedure Write13 (pValue:word);
    function  Read14:word;               procedure Write14 (pValue:word);
    function  Read15:word;               procedure Write15 (pValue:word);
    function  Read16:word;               procedure Write16 (pValue:word);
    function  Read17:word;               procedure Write17 (pValue:word);
    function  Read18:word;               procedure Write18 (pValue:word);
    function  Read19:word;               procedure Write19 (pValue:word);
    function  Read20:word;               procedure Write20 (pValue:word);
    function  Read21:word;               procedure Write21 (pValue:word);
    function  Read22:word;               procedure Write22 (pValue:word);
    function  Read23:word;               procedure Write23 (pValue:word);
    function  Read24:word;               procedure Write24 (pValue:word);
    function  Read25:word;               procedure Write25 (pValue:word);
    function  Read26:word;               procedure Write26 (pValue:word);
    function  Read27:word;               procedure Write27 (pValue:word);
    function  Read28:word;               procedure Write28 (pValue:word);
    function  Read29:word;               procedure Write29 (pValue:word);
    function  Read30:word;               procedure Write30 (pValue:word);
    function  Read31:word;               procedure Write31 (pValue:word);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function Locate (p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open;
    procedure Close;
    procedure Prior; virtual;
    procedure Next; virtual;
    procedure First; virtual;
    procedure Last; virtual;
    procedure Insert; virtual;
    procedure Edit; virtual;
    procedure Post; virtual;
    procedure Delete; virtual;
    procedure SwapIndex;
    procedure RestoreIndex;
    procedure SwapStatus;
    procedure RestoreStatus;
    procedure DisableControls;
    procedure EnableControls;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read ReadCount;
    property StaCode:Str3 read ReadStaCode write WriteStaCode;
    property Typ:byte read ReadTyp write WriteTyp;
    property StaName:Str30 read ReadStaName write WriteStaName;
    property Name:Str30 read ReadName write WriteName;
    property 1:word read Read1 write Write1;
    property 2:word read Read2 write Write2;
    property 3:word read Read3 write Write3;
    property 4:word read Read4 write Write4;
    property 5:word read Read5 write Write5;
    property 6:word read Read6 write Write6;
    property 7:word read Read7 write Write7;
    property 8:word read Read8 write Write8;
    property 9:word read Read9 write Write9;
    property 10:word read Read10 write Write10;
    property 11:word read Read11 write Write11;
    property 12:word read Read12 write Write12;
    property 13:word read Read13 write Write13;
    property 14:word read Read14 write Write14;
    property 15:word read Read15 write Write15;
    property 16:word read Read16 write Write16;
    property 17:word read Read17 write Write17;
    property 18:word read Read18 write Write18;
    property 19:word read Read19 write Write19;
    property 20:word read Read20 write Write20;
    property 21:word read Read21 write Write21;
    property 22:word read Read22 write Write22;
    property 23:word read Read23 write Write23;
    property 24:word read Read24 write Write24;
    property 25:word read Read25 write Write25;
    property 26:word read Read26 write Write26;
    property 27:word read Read27 write Write27;
    property 28:word read Read28 write Write28;
    property 29:word read Read29 write Write29;
    property 30:word read Read30 write Write30;
    property 31:word read Read31 write Write31;
  end;

implementation

constructor TTnvfrgTmp.Create;
begin
  oTmpTable := TmpInit ('TNVFRG',Self);
end;

destructor TTnvfrgTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TTnvfrgTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TTnvfrgTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TTnvfrgTmp.ReadStaCode:Str3;
begin
  Result := oTmpTable.FieldByName('StaCode').AsString;
end;

procedure TTnvfrgTmp.WriteStaCode(pValue:Str3);
begin
  oTmpTable.FieldByName('StaCode').AsString := pValue;
end;

function TTnvfrgTmp.ReadTyp:byte;
begin
  Result := oTmpTable.FieldByName('Typ').AsInteger;
end;

procedure TTnvfrgTmp.WriteTyp(pValue:byte);
begin
  oTmpTable.FieldByName('Typ').AsInteger := pValue;
end;

function TTnvfrgTmp.ReadStaName:Str30;
begin
  Result := oTmpTable.FieldByName('StaName').AsString;
end;

procedure TTnvfrgTmp.WriteStaName(pValue:Str30);
begin
  oTmpTable.FieldByName('StaName').AsString := pValue;
end;

function TTnvfrgTmp.ReadName:Str30;
begin
  Result := oTmpTable.FieldByName('Name').AsString;
end;

procedure TTnvfrgTmp.WriteName(pValue:Str30);
begin
  oTmpTable.FieldByName('Name').AsString := pValue;
end;

function TTnvfrgTmp.Read1:word;
begin
  Result := oTmpTable.FieldByName('1').AsInteger;
end;

procedure TTnvfrgTmp.Write1(pValue:word);
begin
  oTmpTable.FieldByName('1').AsInteger := pValue;
end;

function TTnvfrgTmp.Read2:word;
begin
  Result := oTmpTable.FieldByName('2').AsInteger;
end;

procedure TTnvfrgTmp.Write2(pValue:word);
begin
  oTmpTable.FieldByName('2').AsInteger := pValue;
end;

function TTnvfrgTmp.Read3:word;
begin
  Result := oTmpTable.FieldByName('3').AsInteger;
end;

procedure TTnvfrgTmp.Write3(pValue:word);
begin
  oTmpTable.FieldByName('3').AsInteger := pValue;
end;

function TTnvfrgTmp.Read4:word;
begin
  Result := oTmpTable.FieldByName('4').AsInteger;
end;

procedure TTnvfrgTmp.Write4(pValue:word);
begin
  oTmpTable.FieldByName('4').AsInteger := pValue;
end;

function TTnvfrgTmp.Read5:word;
begin
  Result := oTmpTable.FieldByName('5').AsInteger;
end;

procedure TTnvfrgTmp.Write5(pValue:word);
begin
  oTmpTable.FieldByName('5').AsInteger := pValue;
end;

function TTnvfrgTmp.Read6:word;
begin
  Result := oTmpTable.FieldByName('6').AsInteger;
end;

procedure TTnvfrgTmp.Write6(pValue:word);
begin
  oTmpTable.FieldByName('6').AsInteger := pValue;
end;

function TTnvfrgTmp.Read7:word;
begin
  Result := oTmpTable.FieldByName('7').AsInteger;
end;

procedure TTnvfrgTmp.Write7(pValue:word);
begin
  oTmpTable.FieldByName('7').AsInteger := pValue;
end;

function TTnvfrgTmp.Read8:word;
begin
  Result := oTmpTable.FieldByName('8').AsInteger;
end;

procedure TTnvfrgTmp.Write8(pValue:word);
begin
  oTmpTable.FieldByName('8').AsInteger := pValue;
end;

function TTnvfrgTmp.Read9:word;
begin
  Result := oTmpTable.FieldByName('9').AsInteger;
end;

procedure TTnvfrgTmp.Write9(pValue:word);
begin
  oTmpTable.FieldByName('9').AsInteger := pValue;
end;

function TTnvfrgTmp.Read10:word;
begin
  Result := oTmpTable.FieldByName('10').AsInteger;
end;

procedure TTnvfrgTmp.Write10(pValue:word);
begin
  oTmpTable.FieldByName('10').AsInteger := pValue;
end;

function TTnvfrgTmp.Read11:word;
begin
  Result := oTmpTable.FieldByName('11').AsInteger;
end;

procedure TTnvfrgTmp.Write11(pValue:word);
begin
  oTmpTable.FieldByName('11').AsInteger := pValue;
end;

function TTnvfrgTmp.Read12:word;
begin
  Result := oTmpTable.FieldByName('12').AsInteger;
end;

procedure TTnvfrgTmp.Write12(pValue:word);
begin
  oTmpTable.FieldByName('12').AsInteger := pValue;
end;

function TTnvfrgTmp.Read13:word;
begin
  Result := oTmpTable.FieldByName('13').AsInteger;
end;

procedure TTnvfrgTmp.Write13(pValue:word);
begin
  oTmpTable.FieldByName('13').AsInteger := pValue;
end;

function TTnvfrgTmp.Read14:word;
begin
  Result := oTmpTable.FieldByName('14').AsInteger;
end;

procedure TTnvfrgTmp.Write14(pValue:word);
begin
  oTmpTable.FieldByName('14').AsInteger := pValue;
end;

function TTnvfrgTmp.Read15:word;
begin
  Result := oTmpTable.FieldByName('15').AsInteger;
end;

procedure TTnvfrgTmp.Write15(pValue:word);
begin
  oTmpTable.FieldByName('15').AsInteger := pValue;
end;

function TTnvfrgTmp.Read16:word;
begin
  Result := oTmpTable.FieldByName('16').AsInteger;
end;

procedure TTnvfrgTmp.Write16(pValue:word);
begin
  oTmpTable.FieldByName('16').AsInteger := pValue;
end;

function TTnvfrgTmp.Read17:word;
begin
  Result := oTmpTable.FieldByName('17').AsInteger;
end;

procedure TTnvfrgTmp.Write17(pValue:word);
begin
  oTmpTable.FieldByName('17').AsInteger := pValue;
end;

function TTnvfrgTmp.Read18:word;
begin
  Result := oTmpTable.FieldByName('18').AsInteger;
end;

procedure TTnvfrgTmp.Write18(pValue:word);
begin
  oTmpTable.FieldByName('18').AsInteger := pValue;
end;

function TTnvfrgTmp.Read19:word;
begin
  Result := oTmpTable.FieldByName('19').AsInteger;
end;

procedure TTnvfrgTmp.Write19(pValue:word);
begin
  oTmpTable.FieldByName('19').AsInteger := pValue;
end;

function TTnvfrgTmp.Read20:word;
begin
  Result := oTmpTable.FieldByName('20').AsInteger;
end;

procedure TTnvfrgTmp.Write20(pValue:word);
begin
  oTmpTable.FieldByName('20').AsInteger := pValue;
end;

function TTnvfrgTmp.Read21:word;
begin
  Result := oTmpTable.FieldByName('21').AsInteger;
end;

procedure TTnvfrgTmp.Write21(pValue:word);
begin
  oTmpTable.FieldByName('21').AsInteger := pValue;
end;

function TTnvfrgTmp.Read22:word;
begin
  Result := oTmpTable.FieldByName('22').AsInteger;
end;

procedure TTnvfrgTmp.Write22(pValue:word);
begin
  oTmpTable.FieldByName('22').AsInteger := pValue;
end;

function TTnvfrgTmp.Read23:word;
begin
  Result := oTmpTable.FieldByName('23').AsInteger;
end;

procedure TTnvfrgTmp.Write23(pValue:word);
begin
  oTmpTable.FieldByName('23').AsInteger := pValue;
end;

function TTnvfrgTmp.Read24:word;
begin
  Result := oTmpTable.FieldByName('24').AsInteger;
end;

procedure TTnvfrgTmp.Write24(pValue:word);
begin
  oTmpTable.FieldByName('24').AsInteger := pValue;
end;

function TTnvfrgTmp.Read25:word;
begin
  Result := oTmpTable.FieldByName('25').AsInteger;
end;

procedure TTnvfrgTmp.Write25(pValue:word);
begin
  oTmpTable.FieldByName('25').AsInteger := pValue;
end;

function TTnvfrgTmp.Read26:word;
begin
  Result := oTmpTable.FieldByName('26').AsInteger;
end;

procedure TTnvfrgTmp.Write26(pValue:word);
begin
  oTmpTable.FieldByName('26').AsInteger := pValue;
end;

function TTnvfrgTmp.Read27:word;
begin
  Result := oTmpTable.FieldByName('27').AsInteger;
end;

procedure TTnvfrgTmp.Write27(pValue:word);
begin
  oTmpTable.FieldByName('27').AsInteger := pValue;
end;

function TTnvfrgTmp.Read28:word;
begin
  Result := oTmpTable.FieldByName('28').AsInteger;
end;

procedure TTnvfrgTmp.Write28(pValue:word);
begin
  oTmpTable.FieldByName('28').AsInteger := pValue;
end;

function TTnvfrgTmp.Read29:word;
begin
  Result := oTmpTable.FieldByName('29').AsInteger;
end;

procedure TTnvfrgTmp.Write29(pValue:word);
begin
  oTmpTable.FieldByName('29').AsInteger := pValue;
end;

function TTnvfrgTmp.Read30:word;
begin
  Result := oTmpTable.FieldByName('30').AsInteger;
end;

procedure TTnvfrgTmp.Write30(pValue:word);
begin
  oTmpTable.FieldByName('30').AsInteger := pValue;
end;

function TTnvfrgTmp.Read31:word;
begin
  Result := oTmpTable.FieldByName('31').AsInteger;
end;

procedure TTnvfrgTmp.Write31(pValue:word);
begin
  oTmpTable.FieldByName('31').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTnvfrgTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TTnvfrgTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TTnvfrgTmp.Locate (p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:;p:):boolean;
begin
  SetIndex (ix);
  Result := oTmpTable.FindKey([p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p]);
end;

procedure TTnvfrgTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TTnvfrgTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TTnvfrgTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TTnvfrgTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TTnvfrgTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TTnvfrgTmp.First;
begin
  oTmpTable.First;
end;

procedure TTnvfrgTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TTnvfrgTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TTnvfrgTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TTnvfrgTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TTnvfrgTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TTnvfrgTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TTnvfrgTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TTnvfrgTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TTnvfrgTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TTnvfrgTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TTnvfrgTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
