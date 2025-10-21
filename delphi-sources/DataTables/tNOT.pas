unit tNOT;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = '';

type
  TNotTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadNoticeN0:Str150;       procedure WriteNoticeN0 (pValue:Str150);
    function  ReadNoticeN1:Str150;       procedure WriteNoticeN1 (pValue:Str150);
    function  ReadNoticeN2:Str150;       procedure WriteNoticeN2 (pValue:Str150);
    function  ReadNoticeN3:Str150;       procedure WriteNoticeN3 (pValue:Str150);
    function  ReadNoticeN4:Str150;       procedure WriteNoticeN4 (pValue:Str150);
    function  ReadNoticeN5:Str150;       procedure WriteNoticeN5 (pValue:Str150);
    function  ReadNoticeN6:Str150;       procedure WriteNoticeN6 (pValue:Str150);
    function  ReadNoticeN7:Str150;       procedure WriteNoticeN7 (pValue:Str150);
    function  ReadNoticeN8:Str150;       procedure WriteNoticeN8 (pValue:Str150);
    function  ReadNoticeN9:Str150;       procedure WriteNoticeN9 (pValue:Str150);
    function  ReadNoticeI0:Str150;       procedure WriteNoticeI0 (pValue:Str150);
    function  ReadNoticeI1:Str150;       procedure WriteNoticeI1 (pValue:Str150);
    function  ReadNoticeI2:Str150;       procedure WriteNoticeI2 (pValue:Str150);
    function  ReadNoticeI3:Str150;       procedure WriteNoticeI3 (pValue:Str150);
    function  ReadNoticeI4:Str150;       procedure WriteNoticeI4 (pValue:Str150);
    function  ReadNoticeI5:Str150;       procedure WriteNoticeI5 (pValue:Str150);
    function  ReadNoticeI6:Str150;       procedure WriteNoticeI6 (pValue:Str150);
    function  ReadNoticeI7:Str150;       procedure WriteNoticeI7 (pValue:Str150);
    function  ReadNoticeI8:Str150;       procedure WriteNoticeI8 (pValue:Str150);
    function  ReadNoticeI9:Str150;       procedure WriteNoticeI9 (pValue:Str150);
    function  ReadNoticeT0:Str150;       procedure WriteNoticeT0 (pValue:Str150);
    function  ReadNoticeT1:Str150;       procedure WriteNoticeT1 (pValue:Str150);
    function  ReadNoticeT2:Str150;       procedure WriteNoticeT2 (pValue:Str150);
    function  ReadNoticeT3:Str150;       procedure WriteNoticeT3 (pValue:Str150);
    function  ReadNoticeT4:Str150;       procedure WriteNoticeT4 (pValue:Str150);
    function  ReadNoticeT5:Str150;       procedure WriteNoticeT5 (pValue:Str150);
    function  ReadNoticeT6:Str150;       procedure WriteNoticeT6 (pValue:Str150);
    function  ReadNoticeT7:Str150;       procedure WriteNoticeT7 (pValue:Str150);
    function  ReadNoticeT8:Str150;       procedure WriteNoticeT8 (pValue:Str150);
    function  ReadNoticeT9:Str150;       procedure WriteNoticeT9 (pValue:Str150);
    function  ReadNoticeP0:Str150;       procedure WriteNoticeP0 (pValue:Str150);
    function  ReadNoticeP1:Str150;       procedure WriteNoticeP1 (pValue:Str150);
    function  ReadNoticeP2:Str150;       procedure WriteNoticeP2 (pValue:Str150);
    function  ReadNoticeP3:Str150;       procedure WriteNoticeP3 (pValue:Str150);
    function  ReadNoticeP4:Str150;       procedure WriteNoticeP4 (pValue:Str150);
    function  ReadNoticeP5:Str150;       procedure WriteNoticeP5 (pValue:Str150);
    function  ReadNoticeP6:Str150;       procedure WriteNoticeP6 (pValue:Str150);
    function  ReadNoticeP7:Str150;       procedure WriteNoticeP7 (pValue:Str150);
    function  ReadNoticeP8:Str150;       procedure WriteNoticeP8 (pValue:Str150);
    function  ReadNoticeP9:Str150;       procedure WriteNoticeP9 (pValue:Str150);
    function  ReadNoticeS0:Str150;       procedure WriteNoticeS0 (pValue:Str150);
    function  ReadNoticeS1:Str150;       procedure WriteNoticeS1 (pValue:Str150);
    function  ReadNoticeS2:Str150;       procedure WriteNoticeS2 (pValue:Str150);
    function  ReadNoticeS3:Str150;       procedure WriteNoticeS3 (pValue:Str150);
    function  ReadNoticeS4:Str150;       procedure WriteNoticeS4 (pValue:Str150);
    function  ReadNoticeS5:Str150;       procedure WriteNoticeS5 (pValue:Str150);
    function  ReadNoticeS6:Str150;       procedure WriteNoticeS6 (pValue:Str150);
    function  ReadNoticeS7:Str150;       procedure WriteNoticeS7 (pValue:Str150);
    function  ReadNoticeS8:Str150;       procedure WriteNoticeS8 (pValue:Str150);
    function  ReadNoticeS9:Str150;       procedure WriteNoticeS9 (pValue:Str150);
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
    property NoticeN0:Str150 read ReadNoticeN0 write WriteNoticeN0;
    property NoticeN1:Str150 read ReadNoticeN1 write WriteNoticeN1;
    property NoticeN2:Str150 read ReadNoticeN2 write WriteNoticeN2;
    property NoticeN3:Str150 read ReadNoticeN3 write WriteNoticeN3;
    property NoticeN4:Str150 read ReadNoticeN4 write WriteNoticeN4;
    property NoticeN5:Str150 read ReadNoticeN5 write WriteNoticeN5;
    property NoticeN6:Str150 read ReadNoticeN6 write WriteNoticeN6;
    property NoticeN7:Str150 read ReadNoticeN7 write WriteNoticeN7;
    property NoticeN8:Str150 read ReadNoticeN8 write WriteNoticeN8;
    property NoticeN9:Str150 read ReadNoticeN9 write WriteNoticeN9;
    property NoticeI0:Str150 read ReadNoticeI0 write WriteNoticeI0;
    property NoticeI1:Str150 read ReadNoticeI1 write WriteNoticeI1;
    property NoticeI2:Str150 read ReadNoticeI2 write WriteNoticeI2;
    property NoticeI3:Str150 read ReadNoticeI3 write WriteNoticeI3;
    property NoticeI4:Str150 read ReadNoticeI4 write WriteNoticeI4;
    property NoticeI5:Str150 read ReadNoticeI5 write WriteNoticeI5;
    property NoticeI6:Str150 read ReadNoticeI6 write WriteNoticeI6;
    property NoticeI7:Str150 read ReadNoticeI7 write WriteNoticeI7;
    property NoticeI8:Str150 read ReadNoticeI8 write WriteNoticeI8;
    property NoticeI9:Str150 read ReadNoticeI9 write WriteNoticeI9;
    property NoticeT0:Str150 read ReadNoticeT0 write WriteNoticeT0;
    property NoticeT1:Str150 read ReadNoticeT1 write WriteNoticeT1;
    property NoticeT2:Str150 read ReadNoticeT2 write WriteNoticeT2;
    property NoticeT3:Str150 read ReadNoticeT3 write WriteNoticeT3;
    property NoticeT4:Str150 read ReadNoticeT4 write WriteNoticeT4;
    property NoticeT5:Str150 read ReadNoticeT5 write WriteNoticeT5;
    property NoticeT6:Str150 read ReadNoticeT6 write WriteNoticeT6;
    property NoticeT7:Str150 read ReadNoticeT7 write WriteNoticeT7;
    property NoticeT8:Str150 read ReadNoticeT8 write WriteNoticeT8;
    property NoticeT9:Str150 read ReadNoticeT9 write WriteNoticeT9;
    property NoticeP0:Str150 read ReadNoticeP0 write WriteNoticeP0;
    property NoticeP1:Str150 read ReadNoticeP1 write WriteNoticeP1;
    property NoticeP2:Str150 read ReadNoticeP2 write WriteNoticeP2;
    property NoticeP3:Str150 read ReadNoticeP3 write WriteNoticeP3;
    property NoticeP4:Str150 read ReadNoticeP4 write WriteNoticeP4;
    property NoticeP5:Str150 read ReadNoticeP5 write WriteNoticeP5;
    property NoticeP6:Str150 read ReadNoticeP6 write WriteNoticeP6;
    property NoticeP7:Str150 read ReadNoticeP7 write WriteNoticeP7;
    property NoticeP8:Str150 read ReadNoticeP8 write WriteNoticeP8;
    property NoticeP9:Str150 read ReadNoticeP9 write WriteNoticeP9;
    property NoticeS0:Str150 read ReadNoticeS0 write WriteNoticeS0;
    property NoticeS1:Str150 read ReadNoticeS1 write WriteNoticeS1;
    property NoticeS2:Str150 read ReadNoticeS2 write WriteNoticeS2;
    property NoticeS3:Str150 read ReadNoticeS3 write WriteNoticeS3;
    property NoticeS4:Str150 read ReadNoticeS4 write WriteNoticeS4;
    property NoticeS5:Str150 read ReadNoticeS5 write WriteNoticeS5;
    property NoticeS6:Str150 read ReadNoticeS6 write WriteNoticeS6;
    property NoticeS7:Str150 read ReadNoticeS7 write WriteNoticeS7;
    property NoticeS8:Str150 read ReadNoticeS8 write WriteNoticeS8;
    property NoticeS9:Str150 read ReadNoticeS9 write WriteNoticeS9;
  end;

implementation

constructor TNotTmp.Create;
begin
  oTmpTable := TmpInit ('NOT',Self);
end;

destructor TNotTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TNotTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TNotTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TNotTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TNotTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TNotTmp.ReadNoticeN0:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeN0').AsString;
end;

procedure TNotTmp.WriteNoticeN0(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeN0').AsString := pValue;
end;

function TNotTmp.ReadNoticeN1:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeN1').AsString;
end;

procedure TNotTmp.WriteNoticeN1(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeN1').AsString := pValue;
end;

function TNotTmp.ReadNoticeN2:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeN2').AsString;
end;

procedure TNotTmp.WriteNoticeN2(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeN2').AsString := pValue;
end;

function TNotTmp.ReadNoticeN3:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeN3').AsString;
end;

procedure TNotTmp.WriteNoticeN3(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeN3').AsString := pValue;
end;

function TNotTmp.ReadNoticeN4:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeN4').AsString;
end;

procedure TNotTmp.WriteNoticeN4(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeN4').AsString := pValue;
end;

function TNotTmp.ReadNoticeN5:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeN5').AsString;
end;

procedure TNotTmp.WriteNoticeN5(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeN5').AsString := pValue;
end;

function TNotTmp.ReadNoticeN6:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeN6').AsString;
end;

procedure TNotTmp.WriteNoticeN6(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeN6').AsString := pValue;
end;

function TNotTmp.ReadNoticeN7:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeN7').AsString;
end;

procedure TNotTmp.WriteNoticeN7(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeN7').AsString := pValue;
end;

function TNotTmp.ReadNoticeN8:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeN8').AsString;
end;

procedure TNotTmp.WriteNoticeN8(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeN8').AsString := pValue;
end;

function TNotTmp.ReadNoticeN9:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeN9').AsString;
end;

procedure TNotTmp.WriteNoticeN9(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeN9').AsString := pValue;
end;

function TNotTmp.ReadNoticeI0:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeI0').AsString;
end;

procedure TNotTmp.WriteNoticeI0(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeI0').AsString := pValue;
end;

function TNotTmp.ReadNoticeI1:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeI1').AsString;
end;

procedure TNotTmp.WriteNoticeI1(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeI1').AsString := pValue;
end;

function TNotTmp.ReadNoticeI2:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeI2').AsString;
end;

procedure TNotTmp.WriteNoticeI2(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeI2').AsString := pValue;
end;

function TNotTmp.ReadNoticeI3:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeI3').AsString;
end;

procedure TNotTmp.WriteNoticeI3(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeI3').AsString := pValue;
end;

function TNotTmp.ReadNoticeI4:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeI4').AsString;
end;

procedure TNotTmp.WriteNoticeI4(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeI4').AsString := pValue;
end;

function TNotTmp.ReadNoticeI5:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeI5').AsString;
end;

procedure TNotTmp.WriteNoticeI5(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeI5').AsString := pValue;
end;

function TNotTmp.ReadNoticeI6:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeI6').AsString;
end;

procedure TNotTmp.WriteNoticeI6(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeI6').AsString := pValue;
end;

function TNotTmp.ReadNoticeI7:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeI7').AsString;
end;

procedure TNotTmp.WriteNoticeI7(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeI7').AsString := pValue;
end;

function TNotTmp.ReadNoticeI8:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeI8').AsString;
end;

procedure TNotTmp.WriteNoticeI8(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeI8').AsString := pValue;
end;

function TNotTmp.ReadNoticeI9:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeI9').AsString;
end;

procedure TNotTmp.WriteNoticeI9(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeI9').AsString := pValue;
end;

function TNotTmp.ReadNoticeT0:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeT0').AsString;
end;

procedure TNotTmp.WriteNoticeT0(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeT0').AsString := pValue;
end;

function TNotTmp.ReadNoticeT1:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeT1').AsString;
end;

procedure TNotTmp.WriteNoticeT1(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeT1').AsString := pValue;
end;

function TNotTmp.ReadNoticeT2:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeT2').AsString;
end;

procedure TNotTmp.WriteNoticeT2(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeT2').AsString := pValue;
end;

function TNotTmp.ReadNoticeT3:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeT3').AsString;
end;

procedure TNotTmp.WriteNoticeT3(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeT3').AsString := pValue;
end;

function TNotTmp.ReadNoticeT4:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeT4').AsString;
end;

procedure TNotTmp.WriteNoticeT4(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeT4').AsString := pValue;
end;

function TNotTmp.ReadNoticeT5:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeT5').AsString;
end;

procedure TNotTmp.WriteNoticeT5(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeT5').AsString := pValue;
end;

function TNotTmp.ReadNoticeT6:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeT6').AsString;
end;

procedure TNotTmp.WriteNoticeT6(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeT6').AsString := pValue;
end;

function TNotTmp.ReadNoticeT7:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeT7').AsString;
end;

procedure TNotTmp.WriteNoticeT7(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeT7').AsString := pValue;
end;

function TNotTmp.ReadNoticeT8:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeT8').AsString;
end;

procedure TNotTmp.WriteNoticeT8(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeT8').AsString := pValue;
end;

function TNotTmp.ReadNoticeT9:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeT9').AsString;
end;

procedure TNotTmp.WriteNoticeT9(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeT9').AsString := pValue;
end;

function TNotTmp.ReadNoticeP0:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeP0').AsString;
end;

procedure TNotTmp.WriteNoticeP0(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeP0').AsString := pValue;
end;

function TNotTmp.ReadNoticeP1:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeP1').AsString;
end;

procedure TNotTmp.WriteNoticeP1(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeP1').AsString := pValue;
end;

function TNotTmp.ReadNoticeP2:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeP2').AsString;
end;

procedure TNotTmp.WriteNoticeP2(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeP2').AsString := pValue;
end;

function TNotTmp.ReadNoticeP3:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeP3').AsString;
end;

procedure TNotTmp.WriteNoticeP3(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeP3').AsString := pValue;
end;

function TNotTmp.ReadNoticeP4:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeP4').AsString;
end;

procedure TNotTmp.WriteNoticeP4(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeP4').AsString := pValue;
end;

function TNotTmp.ReadNoticeP5:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeP5').AsString;
end;

procedure TNotTmp.WriteNoticeP5(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeP5').AsString := pValue;
end;

function TNotTmp.ReadNoticeP6:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeP6').AsString;
end;

procedure TNotTmp.WriteNoticeP6(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeP6').AsString := pValue;
end;

function TNotTmp.ReadNoticeP7:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeP7').AsString;
end;

procedure TNotTmp.WriteNoticeP7(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeP7').AsString := pValue;
end;

function TNotTmp.ReadNoticeP8:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeP8').AsString;
end;

procedure TNotTmp.WriteNoticeP8(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeP8').AsString := pValue;
end;

function TNotTmp.ReadNoticeP9:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeP9').AsString;
end;

procedure TNotTmp.WriteNoticeP9(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeP9').AsString := pValue;
end;

function TNotTmp.ReadNoticeS0:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeS0').AsString;
end;

procedure TNotTmp.WriteNoticeS0(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeS0').AsString := pValue;
end;

function TNotTmp.ReadNoticeS1:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeS1').AsString;
end;

procedure TNotTmp.WriteNoticeS1(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeS1').AsString := pValue;
end;

function TNotTmp.ReadNoticeS2:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeS2').AsString;
end;

procedure TNotTmp.WriteNoticeS2(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeS2').AsString := pValue;
end;

function TNotTmp.ReadNoticeS3:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeS3').AsString;
end;

procedure TNotTmp.WriteNoticeS3(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeS3').AsString := pValue;
end;

function TNotTmp.ReadNoticeS4:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeS4').AsString;
end;

procedure TNotTmp.WriteNoticeS4(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeS4').AsString := pValue;
end;

function TNotTmp.ReadNoticeS5:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeS5').AsString;
end;

procedure TNotTmp.WriteNoticeS5(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeS5').AsString := pValue;
end;

function TNotTmp.ReadNoticeS6:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeS6').AsString;
end;

procedure TNotTmp.WriteNoticeS6(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeS6').AsString := pValue;
end;

function TNotTmp.ReadNoticeS7:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeS7').AsString;
end;

procedure TNotTmp.WriteNoticeS7(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeS7').AsString := pValue;
end;

function TNotTmp.ReadNoticeS8:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeS8').AsString;
end;

procedure TNotTmp.WriteNoticeS8(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeS8').AsString := pValue;
end;

function TNotTmp.ReadNoticeS9:Str150;
begin
  Result := oTmpTable.FieldByName('NoticeS9').AsString;
end;

procedure TNotTmp.WriteNoticeS9(pValue:Str150);
begin
  oTmpTable.FieldByName('NoticeS9').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TNotTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TNotTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TNotTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

procedure TNotTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TNotTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TNotTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TNotTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TNotTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TNotTmp.First;
begin
  oTmpTable.First;
end;

procedure TNotTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TNotTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TNotTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TNotTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TNotTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TNotTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TNotTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TNotTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TNotTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TNotTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TNotTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
