unit tDOCACC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = '';

type
  TDocaccTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadAccSnt1:Str3;          procedure WriteAccSnt1 (pValue:Str3);
    function  ReadAccAnl1:Str6;          procedure WriteAccAnl1 (pValue:Str6);
    function  ReadCreVal1:Str16;         procedure WriteCreVal1 (pValue:Str16);
    function  ReadDebVal1:Str16;         procedure WriteDebVal1 (pValue:Str16);
    function  ReadAccSnt2:Str3;          procedure WriteAccSnt2 (pValue:Str3);
    function  ReadAccAnl2:Str6;          procedure WriteAccAnl2 (pValue:Str6);
    function  ReadCreVal2:Str16;         procedure WriteCreVal2 (pValue:Str16);
    function  ReadDebVal2:Str16;         procedure WriteDebVal2 (pValue:Str16);
    function  ReadAccSnt3:Str3;          procedure WriteAccSnt3 (pValue:Str3);
    function  ReadAccAnl3:Str6;          procedure WriteAccAnl3 (pValue:Str6);
    function  ReadCreVal3:Str16;         procedure WriteCreVal3 (pValue:Str16);
    function  ReadDebVal3:Str16;         procedure WriteDebVal3 (pValue:Str16);
    function  ReadAccSnt4:Str3;          procedure WriteAccSnt4 (pValue:Str3);
    function  ReadAccAnl4:Str6;          procedure WriteAccAnl4 (pValue:Str6);
    function  ReadCreVal4:Str16;         procedure WriteCreVal4 (pValue:Str16);
    function  ReadDebVal4:Str16;         procedure WriteDebVal4 (pValue:Str16);
    function  ReadAccSnt5:Str3;          procedure WriteAccSnt5 (pValue:Str3);
    function  ReadAccAnl5:Str6;          procedure WriteAccAnl5 (pValue:Str6);
    function  ReadCreVal5:Str16;         procedure WriteCreVal5 (pValue:Str16);
    function  ReadDebVal5:Str16;         procedure WriteDebVal5 (pValue:Str16);
    function  ReadAccSnt6:Str3;          procedure WriteAccSnt6 (pValue:Str3);
    function  ReadAccAnl6:Str6;          procedure WriteAccAnl6 (pValue:Str6);
    function  ReadCreVal6:Str16;         procedure WriteCreVal6 (pValue:Str16);
    function  ReadDebVal6:Str16;         procedure WriteDebVal6 (pValue:Str16);
    function  ReadAccSnt7:Str3;          procedure WriteAccSnt7 (pValue:Str3);
    function  ReadAccAnl7:Str6;          procedure WriteAccAnl7 (pValue:Str6);
    function  ReadCreVal7:Str16;         procedure WriteCreVal7 (pValue:Str16);
    function  ReadDebVal7:Str16;         procedure WriteDebVal7 (pValue:Str16);
    function  ReadAccSnt8:Str3;          procedure WriteAccSnt8 (pValue:Str3);
    function  ReadAccAnl8:Str6;          procedure WriteAccAnl8 (pValue:Str6);
    function  ReadCreVal8:Str16;         procedure WriteCreVal8 (pValue:Str16);
    function  ReadDebVal8:Str16;         procedure WriteDebVal8 (pValue:Str16);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDocNum (pDocNum:Str12):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open;
    procedure Close;
    procedure Prior;
    procedure Next;
    procedure First;
    procedure Last;
    procedure Insert;
    procedure Edit;
    procedure Post; virtual;
    procedure Delete;
    procedure SwapIndex;
    procedure RestoreIndex;
    procedure SwapStatus;
    procedure RestoreStatus;
    procedure DisableControls;
    procedure EnableControls;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read ReadCount;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property AccSnt1:Str3 read ReadAccSnt1 write WriteAccSnt1;
    property AccAnl1:Str6 read ReadAccAnl1 write WriteAccAnl1;
    property CreVal1:Str16 read ReadCreVal1 write WriteCreVal1;
    property DebVal1:Str16 read ReadDebVal1 write WriteDebVal1;
    property AccSnt2:Str3 read ReadAccSnt2 write WriteAccSnt2;
    property AccAnl2:Str6 read ReadAccAnl2 write WriteAccAnl2;
    property CreVal2:Str16 read ReadCreVal2 write WriteCreVal2;
    property DebVal2:Str16 read ReadDebVal2 write WriteDebVal2;
    property AccSnt3:Str3 read ReadAccSnt3 write WriteAccSnt3;
    property AccAnl3:Str6 read ReadAccAnl3 write WriteAccAnl3;
    property CreVal3:Str16 read ReadCreVal3 write WriteCreVal3;
    property DebVal3:Str16 read ReadDebVal3 write WriteDebVal3;
    property AccSnt4:Str3 read ReadAccSnt4 write WriteAccSnt4;
    property AccAnl4:Str6 read ReadAccAnl4 write WriteAccAnl4;
    property CreVal4:Str16 read ReadCreVal4 write WriteCreVal4;
    property DebVal4:Str16 read ReadDebVal4 write WriteDebVal4;
    property AccSnt5:Str3 read ReadAccSnt5 write WriteAccSnt5;
    property AccAnl5:Str6 read ReadAccAnl5 write WriteAccAnl5;
    property CreVal5:Str16 read ReadCreVal5 write WriteCreVal5;
    property DebVal5:Str16 read ReadDebVal5 write WriteDebVal5;
    property AccSnt6:Str3 read ReadAccSnt6 write WriteAccSnt6;
    property AccAnl6:Str6 read ReadAccAnl6 write WriteAccAnl6;
    property CreVal6:Str16 read ReadCreVal6 write WriteCreVal6;
    property DebVal6:Str16 read ReadDebVal6 write WriteDebVal6;
    property AccSnt7:Str3 read ReadAccSnt7 write WriteAccSnt7;
    property AccAnl7:Str6 read ReadAccAnl7 write WriteAccAnl7;
    property CreVal7:Str16 read ReadCreVal7 write WriteCreVal7;
    property DebVal7:Str16 read ReadDebVal7 write WriteDebVal7;
    property AccSnt8:Str3 read ReadAccSnt8 write WriteAccSnt8;
    property AccAnl8:Str6 read ReadAccAnl8 write WriteAccAnl8;
    property CreVal8:Str16 read ReadCreVal8 write WriteCreVal8;
    property DebVal8:Str16 read ReadDebVal8 write WriteDebVal8;
  end;

implementation

constructor TDocaccTmp.Create;
begin
  oTmpTable := TmpInit ('DOCACC',Self);
end;

destructor TDocaccTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TDocaccTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TDocaccTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TDocaccTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TDocaccTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TDocaccTmp.ReadAccSnt1:Str3;
begin
  Result := oTmpTable.FieldByName('AccSnt1').AsString;
end;

procedure TDocaccTmp.WriteAccSnt1(pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt1').AsString := pValue;
end;

function TDocaccTmp.ReadAccAnl1:Str6;
begin
  Result := oTmpTable.FieldByName('AccAnl1').AsString;
end;

procedure TDocaccTmp.WriteAccAnl1(pValue:Str6);
begin
  oTmpTable.FieldByName('AccAnl1').AsString := pValue;
end;

function TDocaccTmp.ReadCreVal1:Str16;
begin
  Result := oTmpTable.FieldByName('CreVal1').AsString;
end;

procedure TDocaccTmp.WriteCreVal1(pValue:Str16);
begin
  oTmpTable.FieldByName('CreVal1').AsString := pValue;
end;

function TDocaccTmp.ReadDebVal1:Str16;
begin
  Result := oTmpTable.FieldByName('DebVal1').AsString;
end;

procedure TDocaccTmp.WriteDebVal1(pValue:Str16);
begin
  oTmpTable.FieldByName('DebVal1').AsString := pValue;
end;

function TDocaccTmp.ReadAccSnt2:Str3;
begin
  Result := oTmpTable.FieldByName('AccSnt2').AsString;
end;

procedure TDocaccTmp.WriteAccSnt2(pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt2').AsString := pValue;
end;

function TDocaccTmp.ReadAccAnl2:Str6;
begin
  Result := oTmpTable.FieldByName('AccAnl2').AsString;
end;

procedure TDocaccTmp.WriteAccAnl2(pValue:Str6);
begin
  oTmpTable.FieldByName('AccAnl2').AsString := pValue;
end;

function TDocaccTmp.ReadCreVal2:Str16;
begin
  Result := oTmpTable.FieldByName('CreVal2').AsString;
end;

procedure TDocaccTmp.WriteCreVal2(pValue:Str16);
begin
  oTmpTable.FieldByName('CreVal2').AsString := pValue;
end;

function TDocaccTmp.ReadDebVal2:Str16;
begin
  Result := oTmpTable.FieldByName('DebVal2').AsString;
end;

procedure TDocaccTmp.WriteDebVal2(pValue:Str16);
begin
  oTmpTable.FieldByName('DebVal2').AsString := pValue;
end;

function TDocaccTmp.ReadAccSnt3:Str3;
begin
  Result := oTmpTable.FieldByName('AccSnt3').AsString;
end;

procedure TDocaccTmp.WriteAccSnt3(pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt3').AsString := pValue;
end;

function TDocaccTmp.ReadAccAnl3:Str6;
begin
  Result := oTmpTable.FieldByName('AccAnl3').AsString;
end;

procedure TDocaccTmp.WriteAccAnl3(pValue:Str6);
begin
  oTmpTable.FieldByName('AccAnl3').AsString := pValue;
end;

function TDocaccTmp.ReadCreVal3:Str16;
begin
  Result := oTmpTable.FieldByName('CreVal3').AsString;
end;

procedure TDocaccTmp.WriteCreVal3(pValue:Str16);
begin
  oTmpTable.FieldByName('CreVal3').AsString := pValue;
end;

function TDocaccTmp.ReadDebVal3:Str16;
begin
  Result := oTmpTable.FieldByName('DebVal3').AsString;
end;

procedure TDocaccTmp.WriteDebVal3(pValue:Str16);
begin
  oTmpTable.FieldByName('DebVal3').AsString := pValue;
end;

function TDocaccTmp.ReadAccSnt4:Str3;
begin
  Result := oTmpTable.FieldByName('AccSnt4').AsString;
end;

procedure TDocaccTmp.WriteAccSnt4(pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt4').AsString := pValue;
end;

function TDocaccTmp.ReadAccAnl4:Str6;
begin
  Result := oTmpTable.FieldByName('AccAnl4').AsString;
end;

procedure TDocaccTmp.WriteAccAnl4(pValue:Str6);
begin
  oTmpTable.FieldByName('AccAnl4').AsString := pValue;
end;

function TDocaccTmp.ReadCreVal4:Str16;
begin
  Result := oTmpTable.FieldByName('CreVal4').AsString;
end;

procedure TDocaccTmp.WriteCreVal4(pValue:Str16);
begin
  oTmpTable.FieldByName('CreVal4').AsString := pValue;
end;

function TDocaccTmp.ReadDebVal4:Str16;
begin
  Result := oTmpTable.FieldByName('DebVal4').AsString;
end;

procedure TDocaccTmp.WriteDebVal4(pValue:Str16);
begin
  oTmpTable.FieldByName('DebVal4').AsString := pValue;
end;

function TDocaccTmp.ReadAccSnt5:Str3;
begin
  Result := oTmpTable.FieldByName('AccSnt5').AsString;
end;

procedure TDocaccTmp.WriteAccSnt5(pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt5').AsString := pValue;
end;

function TDocaccTmp.ReadAccAnl5:Str6;
begin
  Result := oTmpTable.FieldByName('AccAnl5').AsString;
end;

procedure TDocaccTmp.WriteAccAnl5(pValue:Str6);
begin
  oTmpTable.FieldByName('AccAnl5').AsString := pValue;
end;

function TDocaccTmp.ReadCreVal5:Str16;
begin
  Result := oTmpTable.FieldByName('CreVal5').AsString;
end;

procedure TDocaccTmp.WriteCreVal5(pValue:Str16);
begin
  oTmpTable.FieldByName('CreVal5').AsString := pValue;
end;

function TDocaccTmp.ReadDebVal5:Str16;
begin
  Result := oTmpTable.FieldByName('DebVal5').AsString;
end;

procedure TDocaccTmp.WriteDebVal5(pValue:Str16);
begin
  oTmpTable.FieldByName('DebVal5').AsString := pValue;
end;

function TDocaccTmp.ReadAccSnt6:Str3;
begin
  Result := oTmpTable.FieldByName('AccSnt6').AsString;
end;

procedure TDocaccTmp.WriteAccSnt6(pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt6').AsString := pValue;
end;

function TDocaccTmp.ReadAccAnl6:Str6;
begin
  Result := oTmpTable.FieldByName('AccAnl6').AsString;
end;

procedure TDocaccTmp.WriteAccAnl6(pValue:Str6);
begin
  oTmpTable.FieldByName('AccAnl6').AsString := pValue;
end;

function TDocaccTmp.ReadCreVal6:Str16;
begin
  Result := oTmpTable.FieldByName('CreVal6').AsString;
end;

procedure TDocaccTmp.WriteCreVal6(pValue:Str16);
begin
  oTmpTable.FieldByName('CreVal6').AsString := pValue;
end;

function TDocaccTmp.ReadDebVal6:Str16;
begin
  Result := oTmpTable.FieldByName('DebVal6').AsString;
end;

procedure TDocaccTmp.WriteDebVal6(pValue:Str16);
begin
  oTmpTable.FieldByName('DebVal6').AsString := pValue;
end;

function TDocaccTmp.ReadAccSnt7:Str3;
begin
  Result := oTmpTable.FieldByName('AccSnt7').AsString;
end;

procedure TDocaccTmp.WriteAccSnt7(pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt7').AsString := pValue;
end;

function TDocaccTmp.ReadAccAnl7:Str6;
begin
  Result := oTmpTable.FieldByName('AccAnl7').AsString;
end;

procedure TDocaccTmp.WriteAccAnl7(pValue:Str6);
begin
  oTmpTable.FieldByName('AccAnl7').AsString := pValue;
end;

function TDocaccTmp.ReadCreVal7:Str16;
begin
  Result := oTmpTable.FieldByName('CreVal7').AsString;
end;

procedure TDocaccTmp.WriteCreVal7(pValue:Str16);
begin
  oTmpTable.FieldByName('CreVal7').AsString := pValue;
end;

function TDocaccTmp.ReadDebVal7:Str16;
begin
  Result := oTmpTable.FieldByName('DebVal7').AsString;
end;

procedure TDocaccTmp.WriteDebVal7(pValue:Str16);
begin
  oTmpTable.FieldByName('DebVal7').AsString := pValue;
end;

function TDocaccTmp.ReadAccSnt8:Str3;
begin
  Result := oTmpTable.FieldByName('AccSnt8').AsString;
end;

procedure TDocaccTmp.WriteAccSnt8(pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt8').AsString := pValue;
end;

function TDocaccTmp.ReadAccAnl8:Str6;
begin
  Result := oTmpTable.FieldByName('AccAnl8').AsString;
end;

procedure TDocaccTmp.WriteAccAnl8(pValue:Str6);
begin
  oTmpTable.FieldByName('AccAnl8').AsString := pValue;
end;

function TDocaccTmp.ReadCreVal8:Str16;
begin
  Result := oTmpTable.FieldByName('CreVal8').AsString;
end;

procedure TDocaccTmp.WriteCreVal8(pValue:Str16);
begin
  oTmpTable.FieldByName('CreVal8').AsString := pValue;
end;

function TDocaccTmp.ReadDebVal8:Str16;
begin
  Result := oTmpTable.FieldByName('DebVal8').AsString;
end;

procedure TDocaccTmp.WriteDebVal8(pValue:Str16);
begin
  oTmpTable.FieldByName('DebVal8').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TDocaccTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TDocaccTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TDocaccTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

procedure TDocaccTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TDocaccTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TDocaccTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TDocaccTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TDocaccTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TDocaccTmp.First;
begin
  oTmpTable.First;
end;

procedure TDocaccTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TDocaccTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TDocaccTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TDocaccTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TDocaccTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TDocaccTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TDocaccTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TDocaccTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TDocaccTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TDocaccTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TDocaccTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
