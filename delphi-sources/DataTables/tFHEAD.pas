unit tFHEAD;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixBookNum = '';

type
  TFheadTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadBookNum:Str30;         procedure WriteBookNum (pValue:Str30);
    function  ReadDocType:Str30;         procedure WriteDocType (pValue:Str30);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadMthNum1:byte;          procedure WriteMthNum1 (pValue:byte);
    function  ReadMthNum2:byte;          procedure WriteMthNum2 (pValue:byte);
    function  ReadCasNum1:word;          procedure WriteCasNum1 (pValue:word);
    function  ReadCasNum2:word;          procedure WriteCasNum2 (pValue:word);
    function  ReadMgCode1:longint;       procedure WriteMgCode1 (pValue:longint);
    function  ReadMgCode2:longint;       procedure WriteMgCode2 (pValue:longint);
    function  ReadDate1:TDatetime;       procedure WriteDate1 (pValue:TDatetime);
    function  ReadDate2:TDatetime;       procedure WriteDate2 (pValue:TDatetime);
    function  ReadBefDate1:TDatetime;    procedure WriteBefDate1 (pValue:TDatetime);
    function  ReadBefDate2:TDatetime;    procedure WriteBefDate2 (pValue:TDatetime);
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadSmCode:word;           procedure WriteSmCode (pValue:word);
    function  ReadUsrName:Str30;         procedure WriteUsrName (pValue:Str30);
    function  ReadSerNums:Str30;         procedure WriteSerNums (pValue:Str30);
    function  ReadStkNums:Str30;         procedure WriteStkNums (pValue:Str30);
    function  ReadWriNums:Str30;         procedure WriteWriNums (pValue:Str30);
    function  ReadSmCodes:Str30;         procedure WriteSmCodes (pValue:Str30);
    function  ReadPaCodes:Str30;         procedure WritePaCodes (pValue:Str30);
    function  ReadDocSpcs:Str30;         procedure WriteDocSpcs (pValue:Str30);
    function  ReadVatClss:Str30;         procedure WriteVatClss (pValue:Str30);
    function  ReadAccDirs:Str30;         procedure WriteAccDirs (pValue:Str30);
    function  ReadCsyCodes:Str30;        procedure WriteCsyCodes (pValue:Str30);
    function  ReadDocDate:Str30;         procedure WriteDocDate (pValue:Str30);
    function  ReadSndDate:Str30;         procedure WriteSndDate (pValue:Str30);
    function  ReadExpDate:Str30;         procedure WriteExpDate (pValue:Str30);
    function  ReadVatDate:Str30;         procedure WriteVatDate (pValue:Str30);
    function  ReadTaxDate:Str30;         procedure WriteTaxDate (pValue:Str30);
    function  ReadPayDate:Str30;         procedure WritePayDate (pValue:Str30);
    function  ReadAccDate:Str30;         procedure WriteAccDate (pValue:Str30);
    function  ReadDocVal1:double;        procedure WriteDocVal1 (pValue:double);
    function  ReadDocVal2:double;        procedure WriteDocVal2 (pValue:double);
    function  ReadSmlText1:Str15;        procedure WriteSmlText1 (pValue:Str15);
    function  ReadSmlText2:Str15;        procedure WriteSmlText2 (pValue:Str15);
    function  ReadSmlText3:Str15;        procedure WriteSmlText3 (pValue:Str15);
    function  ReadSmlText4:Str15;        procedure WriteSmlText4 (pValue:Str15);
    function  ReadSmlText5:Str15;        procedure WriteSmlText5 (pValue:Str15);
    function  ReadLngText1:Str60;        procedure WriteLngText1 (pValue:Str60);
    function  ReadLngText2:Str60;        procedure WriteLngText2 (pValue:Str60);
    function  ReadLngText3:Str60;        procedure WriteLngText3 (pValue:Str60);
    function  ReadLngText4:Str60;        procedure WriteLngText4 (pValue:Str60);
    function  ReadLngText5:Str60;        procedure WriteLngText5 (pValue:Str60);
    function  ReadStatus1:Str1;          procedure WriteStatus1 (pValue:Str1);
    function  ReadStatus2:Str1;          procedure WriteStatus2 (pValue:Str1);
    function  ReadStatus3:Str1;          procedure WriteStatus3 (pValue:Str1);
    function  ReadStatus4:Str1;          procedure WriteStatus4 (pValue:Str1);
    function  ReadStatus5:Str1;          procedure WriteStatus5 (pValue:Str1);
    function  ReadStatus6:Str1;          procedure WriteStatus6 (pValue:Str1);
    function  ReadStatus7:Str1;          procedure WriteStatus7 (pValue:Str1);
    function  ReadStatus8:Str1;          procedure WriteStatus8 (pValue:Str1);
    function  ReadStatus9:Str1;          procedure WriteStatus9 (pValue:Str1);
    function  ReadStatus10:Str1;         procedure WriteStatus10 (pValue:Str1);
    function  ReadStatus11:Str1;         procedure WriteStatus11 (pValue:Str1);
    function  ReadStatus12:Str1;         procedure WriteStatus12 (pValue:Str1);
    function  ReadStatus13:Str1;         procedure WriteStatus13 (pValue:Str1);
    function  ReadStatus14:Str1;         procedure WriteStatus14 (pValue:Str1);
    function  ReadStatus15:Str1;         procedure WriteStatus15 (pValue:Str1);
    function  ReadStatus16:Str1;         procedure WriteStatus16 (pValue:Str1);
    function  ReadStatus17:Str1;         procedure WriteStatus17 (pValue:Str1);
    function  ReadStatus18:Str1;         procedure WriteStatus18 (pValue:Str1);
    function  ReadStatus19:Str1;         procedure WriteStatus19 (pValue:Str1);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateBookNum (pBookNum:Str30):boolean;

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
    property BookNum:Str30 read ReadBookNum write WriteBookNum;
    property DocType:Str30 read ReadDocType write WriteDocType;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property MthNum1:byte read ReadMthNum1 write WriteMthNum1;
    property MthNum2:byte read ReadMthNum2 write WriteMthNum2;
    property CasNum1:word read ReadCasNum1 write WriteCasNum1;
    property CasNum2:word read ReadCasNum2 write WriteCasNum2;
    property MgCode1:longint read ReadMgCode1 write WriteMgCode1;
    property MgCode2:longint read ReadMgCode2 write WriteMgCode2;
    property Date1:TDatetime read ReadDate1 write WriteDate1;
    property Date2:TDatetime read ReadDate2 write WriteDate2;
    property BefDate1:TDatetime read ReadBefDate1 write WriteBefDate1;
    property BefDate2:TDatetime read ReadBefDate2 write WriteBefDate2;
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property WriNum:word read ReadWriNum write WriteWriNum;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property SmCode:word read ReadSmCode write WriteSmCode;
    property UsrName:Str30 read ReadUsrName write WriteUsrName;
    property SerNums:Str30 read ReadSerNums write WriteSerNums;
    property StkNums:Str30 read ReadStkNums write WriteStkNums;
    property WriNums:Str30 read ReadWriNums write WriteWriNums;
    property SmCodes:Str30 read ReadSmCodes write WriteSmCodes;
    property PaCodes:Str30 read ReadPaCodes write WritePaCodes;
    property DocSpcs:Str30 read ReadDocSpcs write WriteDocSpcs;
    property VatClss:Str30 read ReadVatClss write WriteVatClss;
    property AccDirs:Str30 read ReadAccDirs write WriteAccDirs;
    property CsyCodes:Str30 read ReadCsyCodes write WriteCsyCodes;
    property DocDate:Str30 read ReadDocDate write WriteDocDate;
    property SndDate:Str30 read ReadSndDate write WriteSndDate;
    property ExpDate:Str30 read ReadExpDate write WriteExpDate;
    property VatDate:Str30 read ReadVatDate write WriteVatDate;
    property TaxDate:Str30 read ReadTaxDate write WriteTaxDate;
    property PayDate:Str30 read ReadPayDate write WritePayDate;
    property AccDate:Str30 read ReadAccDate write WriteAccDate;
    property DocVal1:double read ReadDocVal1 write WriteDocVal1;
    property DocVal2:double read ReadDocVal2 write WriteDocVal2;
    property SmlText1:Str15 read ReadSmlText1 write WriteSmlText1;
    property SmlText2:Str15 read ReadSmlText2 write WriteSmlText2;
    property SmlText3:Str15 read ReadSmlText3 write WriteSmlText3;
    property SmlText4:Str15 read ReadSmlText4 write WriteSmlText4;
    property SmlText5:Str15 read ReadSmlText5 write WriteSmlText5;
    property LngText1:Str60 read ReadLngText1 write WriteLngText1;
    property LngText2:Str60 read ReadLngText2 write WriteLngText2;
    property LngText3:Str60 read ReadLngText3 write WriteLngText3;
    property LngText4:Str60 read ReadLngText4 write WriteLngText4;
    property LngText5:Str60 read ReadLngText5 write WriteLngText5;
    property Status1:Str1 read ReadStatus1 write WriteStatus1;
    property Status2:Str1 read ReadStatus2 write WriteStatus2;
    property Status3:Str1 read ReadStatus3 write WriteStatus3;
    property Status4:Str1 read ReadStatus4 write WriteStatus4;
    property Status5:Str1 read ReadStatus5 write WriteStatus5;
    property Status6:Str1 read ReadStatus6 write WriteStatus6;
    property Status7:Str1 read ReadStatus7 write WriteStatus7;
    property Status8:Str1 read ReadStatus8 write WriteStatus8;
    property Status9:Str1 read ReadStatus9 write WriteStatus9;
    property Status10:Str1 read ReadStatus10 write WriteStatus10;
    property Status11:Str1 read ReadStatus11 write WriteStatus11;
    property Status12:Str1 read ReadStatus12 write WriteStatus12;
    property Status13:Str1 read ReadStatus13 write WriteStatus13;
    property Status14:Str1 read ReadStatus14 write WriteStatus14;
    property Status15:Str1 read ReadStatus15 write WriteStatus15;
    property Status16:Str1 read ReadStatus16 write WriteStatus16;
    property Status17:Str1 read ReadStatus17 write WriteStatus17;
    property Status18:Str1 read ReadStatus18 write WriteStatus18;
    property Status19:Str1 read ReadStatus19 write WriteStatus19;
  end;

implementation

constructor TFheadTmp.Create;
begin
  oTmpTable := TmpInit ('FHEAD',Self);
end;

destructor TFheadTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TFheadTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TFheadTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TFheadTmp.ReadBookNum:Str30;
begin
  Result := oTmpTable.FieldByName('BookNum').AsString;
end;

procedure TFheadTmp.WriteBookNum(pValue:Str30);
begin
  oTmpTable.FieldByName('BookNum').AsString := pValue;
end;

function TFheadTmp.ReadDocType:Str30;
begin
  Result := oTmpTable.FieldByName('DocType').AsString;
end;

procedure TFheadTmp.WriteDocType(pValue:Str30);
begin
  oTmpTable.FieldByName('DocType').AsString := pValue;
end;

function TFheadTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TFheadTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TFheadTmp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TFheadTmp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TFheadTmp.ReadMthNum1:byte;
begin
  Result := oTmpTable.FieldByName('MthNum1').AsInteger;
end;

procedure TFheadTmp.WriteMthNum1(pValue:byte);
begin
  oTmpTable.FieldByName('MthNum1').AsInteger := pValue;
end;

function TFheadTmp.ReadMthNum2:byte;
begin
  Result := oTmpTable.FieldByName('MthNum2').AsInteger;
end;

procedure TFheadTmp.WriteMthNum2(pValue:byte);
begin
  oTmpTable.FieldByName('MthNum2').AsInteger := pValue;
end;

function TFheadTmp.ReadCasNum1:word;
begin
  Result := oTmpTable.FieldByName('CasNum1').AsInteger;
end;

procedure TFheadTmp.WriteCasNum1(pValue:word);
begin
  oTmpTable.FieldByName('CasNum1').AsInteger := pValue;
end;

function TFheadTmp.ReadCasNum2:word;
begin
  Result := oTmpTable.FieldByName('CasNum2').AsInteger;
end;

procedure TFheadTmp.WriteCasNum2(pValue:word);
begin
  oTmpTable.FieldByName('CasNum2').AsInteger := pValue;
end;

function TFheadTmp.ReadMgCode1:longint;
begin
  Result := oTmpTable.FieldByName('MgCode1').AsInteger;
end;

procedure TFheadTmp.WriteMgCode1(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode1').AsInteger := pValue;
end;

function TFheadTmp.ReadMgCode2:longint;
begin
  Result := oTmpTable.FieldByName('MgCode2').AsInteger;
end;

procedure TFheadTmp.WriteMgCode2(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode2').AsInteger := pValue;
end;

function TFheadTmp.ReadDate1:TDatetime;
begin
  Result := oTmpTable.FieldByName('Date1').AsDateTime;
end;

procedure TFheadTmp.WriteDate1(pValue:TDatetime);
begin
  oTmpTable.FieldByName('Date1').AsDateTime := pValue;
end;

function TFheadTmp.ReadDate2:TDatetime;
begin
  Result := oTmpTable.FieldByName('Date2').AsDateTime;
end;

procedure TFheadTmp.WriteDate2(pValue:TDatetime);
begin
  oTmpTable.FieldByName('Date2').AsDateTime := pValue;
end;

function TFheadTmp.ReadBefDate1:TDatetime;
begin
  Result := oTmpTable.FieldByName('BefDate1').AsDateTime;
end;

procedure TFheadTmp.WriteBefDate1(pValue:TDatetime);
begin
  oTmpTable.FieldByName('BefDate1').AsDateTime := pValue;
end;

function TFheadTmp.ReadBefDate2:TDatetime;
begin
  Result := oTmpTable.FieldByName('BefDate2').AsDateTime;
end;

procedure TFheadTmp.WriteBefDate2(pValue:TDatetime);
begin
  oTmpTable.FieldByName('BefDate2').AsDateTime := pValue;
end;

function TFheadTmp.ReadSerNum:longint;
begin
  Result := oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TFheadTmp.WriteSerNum(pValue:longint);
begin
  oTmpTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TFheadTmp.ReadWriNum:word;
begin
  Result := oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TFheadTmp.WriteWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TFheadTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TFheadTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TFheadTmp.ReadSmCode:word;
begin
  Result := oTmpTable.FieldByName('SmCode').AsInteger;
end;

procedure TFheadTmp.WriteSmCode(pValue:word);
begin
  oTmpTable.FieldByName('SmCode').AsInteger := pValue;
end;

function TFheadTmp.ReadUsrName:Str30;
begin
  Result := oTmpTable.FieldByName('UsrName').AsString;
end;

procedure TFheadTmp.WriteUsrName(pValue:Str30);
begin
  oTmpTable.FieldByName('UsrName').AsString := pValue;
end;

function TFheadTmp.ReadSerNums:Str30;
begin
  Result := oTmpTable.FieldByName('SerNums').AsString;
end;

procedure TFheadTmp.WriteSerNums(pValue:Str30);
begin
  oTmpTable.FieldByName('SerNums').AsString := pValue;
end;

function TFheadTmp.ReadStkNums:Str30;
begin
  Result := oTmpTable.FieldByName('StkNums').AsString;
end;

procedure TFheadTmp.WriteStkNums(pValue:Str30);
begin
  oTmpTable.FieldByName('StkNums').AsString := pValue;
end;

function TFheadTmp.ReadWriNums:Str30;
begin
  Result := oTmpTable.FieldByName('WriNums').AsString;
end;

procedure TFheadTmp.WriteWriNums(pValue:Str30);
begin
  oTmpTable.FieldByName('WriNums').AsString := pValue;
end;

function TFheadTmp.ReadSmCodes:Str30;
begin
  Result := oTmpTable.FieldByName('SmCodes').AsString;
end;

procedure TFheadTmp.WriteSmCodes(pValue:Str30);
begin
  oTmpTable.FieldByName('SmCodes').AsString := pValue;
end;

function TFheadTmp.ReadPaCodes:Str30;
begin
  Result := oTmpTable.FieldByName('PaCodes').AsString;
end;

procedure TFheadTmp.WritePaCodes(pValue:Str30);
begin
  oTmpTable.FieldByName('PaCodes').AsString := pValue;
end;

function TFheadTmp.ReadDocSpcs:Str30;
begin
  Result := oTmpTable.FieldByName('DocSpcs').AsString;
end;

procedure TFheadTmp.WriteDocSpcs(pValue:Str30);
begin
  oTmpTable.FieldByName('DocSpcs').AsString := pValue;
end;

function TFheadTmp.ReadVatClss:Str30;
begin
  Result := oTmpTable.FieldByName('VatClss').AsString;
end;

procedure TFheadTmp.WriteVatClss(pValue:Str30);
begin
  oTmpTable.FieldByName('VatClss').AsString := pValue;
end;

function TFheadTmp.ReadAccDirs:Str30;
begin
  Result := oTmpTable.FieldByName('AccDirs').AsString;
end;

procedure TFheadTmp.WriteAccDirs(pValue:Str30);
begin
  oTmpTable.FieldByName('AccDirs').AsString := pValue;
end;

function TFheadTmp.ReadCsyCodes:Str30;
begin
  Result := oTmpTable.FieldByName('CsyCodes').AsString;
end;

procedure TFheadTmp.WriteCsyCodes(pValue:Str30);
begin
  oTmpTable.FieldByName('CsyCodes').AsString := pValue;
end;

function TFheadTmp.ReadDocDate:Str30;
begin
  Result := oTmpTable.FieldByName('DocDate').AsString;
end;

procedure TFheadTmp.WriteDocDate(pValue:Str30);
begin
  oTmpTable.FieldByName('DocDate').AsString := pValue;
end;

function TFheadTmp.ReadSndDate:Str30;
begin
  Result := oTmpTable.FieldByName('SndDate').AsString;
end;

procedure TFheadTmp.WriteSndDate(pValue:Str30);
begin
  oTmpTable.FieldByName('SndDate').AsString := pValue;
end;

function TFheadTmp.ReadExpDate:Str30;
begin
  Result := oTmpTable.FieldByName('ExpDate').AsString;
end;

procedure TFheadTmp.WriteExpDate(pValue:Str30);
begin
  oTmpTable.FieldByName('ExpDate').AsString := pValue;
end;

function TFheadTmp.ReadVatDate:Str30;
begin
  Result := oTmpTable.FieldByName('VatDate').AsString;
end;

procedure TFheadTmp.WriteVatDate(pValue:Str30);
begin
  oTmpTable.FieldByName('VatDate').AsString := pValue;
end;

function TFheadTmp.ReadTaxDate:Str30;
begin
  Result := oTmpTable.FieldByName('TaxDate').AsString;
end;

procedure TFheadTmp.WriteTaxDate(pValue:Str30);
begin
  oTmpTable.FieldByName('TaxDate').AsString := pValue;
end;

function TFheadTmp.ReadPayDate:Str30;
begin
  Result := oTmpTable.FieldByName('PayDate').AsString;
end;

procedure TFheadTmp.WritePayDate(pValue:Str30);
begin
  oTmpTable.FieldByName('PayDate').AsString := pValue;
end;

function TFheadTmp.ReadAccDate:Str30;
begin
  Result := oTmpTable.FieldByName('AccDate').AsString;
end;

procedure TFheadTmp.WriteAccDate(pValue:Str30);
begin
  oTmpTable.FieldByName('AccDate').AsString := pValue;
end;

function TFheadTmp.ReadDocVal1:double;
begin
  Result := oTmpTable.FieldByName('DocVal1').AsFloat;
end;

procedure TFheadTmp.WriteDocVal1(pValue:double);
begin
  oTmpTable.FieldByName('DocVal1').AsFloat := pValue;
end;

function TFheadTmp.ReadDocVal2:double;
begin
  Result := oTmpTable.FieldByName('DocVal2').AsFloat;
end;

procedure TFheadTmp.WriteDocVal2(pValue:double);
begin
  oTmpTable.FieldByName('DocVal2').AsFloat := pValue;
end;

function TFheadTmp.ReadSmlText1:Str15;
begin
  Result := oTmpTable.FieldByName('SmlText1').AsString;
end;

procedure TFheadTmp.WriteSmlText1(pValue:Str15);
begin
  oTmpTable.FieldByName('SmlText1').AsString := pValue;
end;

function TFheadTmp.ReadSmlText2:Str15;
begin
  Result := oTmpTable.FieldByName('SmlText2').AsString;
end;

procedure TFheadTmp.WriteSmlText2(pValue:Str15);
begin
  oTmpTable.FieldByName('SmlText2').AsString := pValue;
end;

function TFheadTmp.ReadSmlText3:Str15;
begin
  Result := oTmpTable.FieldByName('SmlText3').AsString;
end;

procedure TFheadTmp.WriteSmlText3(pValue:Str15);
begin
  oTmpTable.FieldByName('SmlText3').AsString := pValue;
end;

function TFheadTmp.ReadSmlText4:Str15;
begin
  Result := oTmpTable.FieldByName('SmlText4').AsString;
end;

procedure TFheadTmp.WriteSmlText4(pValue:Str15);
begin
  oTmpTable.FieldByName('SmlText4').AsString := pValue;
end;

function TFheadTmp.ReadSmlText5:Str15;
begin
  Result := oTmpTable.FieldByName('SmlText5').AsString;
end;

procedure TFheadTmp.WriteSmlText5(pValue:Str15);
begin
  oTmpTable.FieldByName('SmlText5').AsString := pValue;
end;

function TFheadTmp.ReadLngText1:Str60;
begin
  Result := oTmpTable.FieldByName('LngText1').AsString;
end;

procedure TFheadTmp.WriteLngText1(pValue:Str60);
begin
  oTmpTable.FieldByName('LngText1').AsString := pValue;
end;

function TFheadTmp.ReadLngText2:Str60;
begin
  Result := oTmpTable.FieldByName('LngText2').AsString;
end;

procedure TFheadTmp.WriteLngText2(pValue:Str60);
begin
  oTmpTable.FieldByName('LngText2').AsString := pValue;
end;

function TFheadTmp.ReadLngText3:Str60;
begin
  Result := oTmpTable.FieldByName('LngText3').AsString;
end;

procedure TFheadTmp.WriteLngText3(pValue:Str60);
begin
  oTmpTable.FieldByName('LngText3').AsString := pValue;
end;

function TFheadTmp.ReadLngText4:Str60;
begin
  Result := oTmpTable.FieldByName('LngText4').AsString;
end;

procedure TFheadTmp.WriteLngText4(pValue:Str60);
begin
  oTmpTable.FieldByName('LngText4').AsString := pValue;
end;

function TFheadTmp.ReadLngText5:Str60;
begin
  Result := oTmpTable.FieldByName('LngText5').AsString;
end;

procedure TFheadTmp.WriteLngText5(pValue:Str60);
begin
  oTmpTable.FieldByName('LngText5').AsString := pValue;
end;

function TFheadTmp.ReadStatus1:Str1;
begin
  Result := oTmpTable.FieldByName('Status1').AsString;
end;

procedure TFheadTmp.WriteStatus1(pValue:Str1);
begin
  oTmpTable.FieldByName('Status1').AsString := pValue;
end;

function TFheadTmp.ReadStatus2:Str1;
begin
  Result := oTmpTable.FieldByName('Status2').AsString;
end;

procedure TFheadTmp.WriteStatus2(pValue:Str1);
begin
  oTmpTable.FieldByName('Status2').AsString := pValue;
end;

function TFheadTmp.ReadStatus3:Str1;
begin
  Result := oTmpTable.FieldByName('Status3').AsString;
end;

procedure TFheadTmp.WriteStatus3(pValue:Str1);
begin
  oTmpTable.FieldByName('Status3').AsString := pValue;
end;

function TFheadTmp.ReadStatus4:Str1;
begin
  Result := oTmpTable.FieldByName('Status4').AsString;
end;

procedure TFheadTmp.WriteStatus4(pValue:Str1);
begin
  oTmpTable.FieldByName('Status4').AsString := pValue;
end;

function TFheadTmp.ReadStatus5:Str1;
begin
  Result := oTmpTable.FieldByName('Status5').AsString;
end;

procedure TFheadTmp.WriteStatus5(pValue:Str1);
begin
  oTmpTable.FieldByName('Status5').AsString := pValue;
end;

function TFheadTmp.ReadStatus6:Str1;
begin
  Result := oTmpTable.FieldByName('Status6').AsString;
end;

procedure TFheadTmp.WriteStatus6(pValue:Str1);
begin
  oTmpTable.FieldByName('Status6').AsString := pValue;
end;

function TFheadTmp.ReadStatus7:Str1;
begin
  Result := oTmpTable.FieldByName('Status7').AsString;
end;

procedure TFheadTmp.WriteStatus7(pValue:Str1);
begin
  oTmpTable.FieldByName('Status7').AsString := pValue;
end;

function TFheadTmp.ReadStatus8:Str1;
begin
  Result := oTmpTable.FieldByName('Status8').AsString;
end;

procedure TFheadTmp.WriteStatus8(pValue:Str1);
begin
  oTmpTable.FieldByName('Status8').AsString := pValue;
end;

function TFheadTmp.ReadStatus9:Str1;
begin
  Result := oTmpTable.FieldByName('Status9').AsString;
end;

procedure TFheadTmp.WriteStatus9(pValue:Str1);
begin
  oTmpTable.FieldByName('Status9').AsString := pValue;
end;

function TFheadTmp.ReadStatus10:Str1;
begin
  Result := oTmpTable.FieldByName('Status10').AsString;
end;

procedure TFheadTmp.WriteStatus10(pValue:Str1);
begin
  oTmpTable.FieldByName('Status10').AsString := pValue;
end;

function TFheadTmp.ReadStatus11:Str1;
begin
  Result := oTmpTable.FieldByName('Status11').AsString;
end;

procedure TFheadTmp.WriteStatus11(pValue:Str1);
begin
  oTmpTable.FieldByName('Status11').AsString := pValue;
end;

function TFheadTmp.ReadStatus12:Str1;
begin
  Result := oTmpTable.FieldByName('Status12').AsString;
end;

procedure TFheadTmp.WriteStatus12(pValue:Str1);
begin
  oTmpTable.FieldByName('Status12').AsString := pValue;
end;

function TFheadTmp.ReadStatus13:Str1;
begin
  Result := oTmpTable.FieldByName('Status13').AsString;
end;

procedure TFheadTmp.WriteStatus13(pValue:Str1);
begin
  oTmpTable.FieldByName('Status13').AsString := pValue;
end;

function TFheadTmp.ReadStatus14:Str1;
begin
  Result := oTmpTable.FieldByName('Status14').AsString;
end;

procedure TFheadTmp.WriteStatus14(pValue:Str1);
begin
  oTmpTable.FieldByName('Status14').AsString := pValue;
end;

function TFheadTmp.ReadStatus15:Str1;
begin
  Result := oTmpTable.FieldByName('Status15').AsString;
end;

procedure TFheadTmp.WriteStatus15(pValue:Str1);
begin
  oTmpTable.FieldByName('Status15').AsString := pValue;
end;

function TFheadTmp.ReadStatus16:Str1;
begin
  Result := oTmpTable.FieldByName('Status16').AsString;
end;

procedure TFheadTmp.WriteStatus16(pValue:Str1);
begin
  oTmpTable.FieldByName('Status16').AsString := pValue;
end;

function TFheadTmp.ReadStatus17:Str1;
begin
  Result := oTmpTable.FieldByName('Status17').AsString;
end;

procedure TFheadTmp.WriteStatus17(pValue:Str1);
begin
  oTmpTable.FieldByName('Status17').AsString := pValue;
end;

function TFheadTmp.ReadStatus18:Str1;
begin
  Result := oTmpTable.FieldByName('Status18').AsString;
end;

procedure TFheadTmp.WriteStatus18(pValue:Str1);
begin
  oTmpTable.FieldByName('Status18').AsString := pValue;
end;

function TFheadTmp.ReadStatus19:Str1;
begin
  Result := oTmpTable.FieldByName('Status19').AsString;
end;

procedure TFheadTmp.WriteStatus19(pValue:Str1);
begin
  oTmpTable.FieldByName('Status19').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TFheadTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TFheadTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TFheadTmp.LocateBookNum (pBookNum:Str30):boolean;
begin
  SetIndex (ixBookNum);
  Result := oTmpTable.FindKey([pBookNum]);
end;

procedure TFheadTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TFheadTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TFheadTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TFheadTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TFheadTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TFheadTmp.First;
begin
  oTmpTable.First;
end;

procedure TFheadTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TFheadTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TFheadTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TFheadTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TFheadTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TFheadTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TFheadTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TFheadTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TFheadTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TFheadTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TFheadTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
