unit tCLSLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixWrCaCd = '';
  ixWrCaCl = 'WrCaCl';
  ixCaCl = 'CaCl';
  ixCdCt = 'CdCt';

type
  TClslstTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadWriNum:longint;        procedure WriteWriNum (pValue:longint);
    function  ReadCasNum:longint;        procedure WriteCasNum (pValue:longint);
    function  ReadClsDat:TDatetime;      procedure WriteClsDat (pValue:TDatetime);
    function  ReadClsNum:longint;        procedure WriteClsNum (pValue:longint);
    function  ReadBlkNum:longint;        procedure WriteBlkNum (pValue:longint);
    function  ReadClsTim:TDatetime;      procedure WriteClsTim (pValue:TDatetime);
    function  ReadDocCnt:longint;        procedure WriteDocCnt (pValue:longint);
    function  ReadIncCnt:longint;        procedure WriteIncCnt (pValue:longint);
    function  ReadOutCnt:longint;        procedure WriteOutCnt (pValue:longint);
    function  ReadCncCnt:longint;        procedure WriteCncCnt (pValue:longint);
    function  ReadLgnNum:Str8;           procedure WriteLgnNum (pValue:Str8);
    function  ReadUsrNum:Str30;          procedure WriteUsrNum (pValue:Str30);
    function  ReadAValue1:double;        procedure WriteAValue1 (pValue:double);
    function  ReadVValue1:double;        procedure WriteVValue1 (pValue:double);
    function  ReadBValue1:double;        procedure WriteBValue1 (pValue:double);
    function  ReadAValue2:double;        procedure WriteAValue2 (pValue:double);
    function  ReadVValue2:double;        procedure WriteVValue2 (pValue:double);
    function  ReadBValue2:double;        procedure WriteBValue2 (pValue:double);
    function  ReadAValue3:double;        procedure WriteAValue3 (pValue:double);
    function  ReadVValue3:double;        procedure WriteVValue3 (pValue:double);
    function  ReadBValue3:double;        procedure WriteBValue3 (pValue:double);
    function  ReadAValue4:double;        procedure WriteAValue4 (pValue:double);
    function  ReadVValue4:double;        procedure WriteVValue4 (pValue:double);
    function  ReadBValue4:double;        procedure WriteBValue4 (pValue:double);
    function  ReadAValue5:double;        procedure WriteAValue5 (pValue:double);
    function  ReadVValue5:double;        procedure WriteVValue5 (pValue:double);
    function  ReadBValue5:double;        procedure WriteBValue5 (pValue:double);
    function  ReadInvVal:double;         procedure WriteInvVal (pValue:double);
    function  ReadInvCnt:longint;        procedure WriteInvCnt (pValue:longint);
    function  ReadNegVal:double;         procedure WriteNegVal (pValue:double);
    function  ReadNegCnt:longint;        procedure WriteNegCnt (pValue:longint);
    function  ReadRetVal:double;         procedure WriteRetVal (pValue:double);
    function  ReadRetCnt:longint;        procedure WriteRetCnt (pValue:longint);
    function  ReadDscVal:double;         procedure WriteDscVal (pValue:double);
    function  ReadDscCnt:longint;        procedure WriteDscCnt (pValue:longint);
    function  ReadPayNum0:word;          procedure WritePayNum0 (pValue:word);
    function  ReadPayNam0:Str30;         procedure WritePayNam0 (pValue:Str30);
    function  ReadPayInc0:double;        procedure WritePayInc0 (pValue:double);
    function  ReadPayOut0:double;        procedure WritePayOut0 (pValue:double);
    function  ReadPayTrn0:double;        procedure WritePayTrn0 (pValue:double);
    function  ReadPayNum1:word;          procedure WritePayNum1 (pValue:word);
    function  ReadPayNam1:Str30;         procedure WritePayNam1 (pValue:Str30);
    function  ReadPayInc1:double;        procedure WritePayInc1 (pValue:double);
    function  ReadPayOut1:double;        procedure WritePayOut1 (pValue:double);
    function  ReadPayTrn1:double;        procedure WritePayTrn1 (pValue:double);
    function  ReadPayNum2:word;          procedure WritePayNum2 (pValue:word);
    function  ReadPayNam2:Str30;         procedure WritePayNam2 (pValue:Str30);
    function  ReadPayInc2:double;        procedure WritePayInc2 (pValue:double);
    function  ReadPayOut2:double;        procedure WritePayOut2 (pValue:double);
    function  ReadPayTrn2:double;        procedure WritePayTrn2 (pValue:double);
    function  ReadPayNum3:word;          procedure WritePayNum3 (pValue:word);
    function  ReadPayNam3:Str30;         procedure WritePayNam3 (pValue:Str30);
    function  ReadPayInc3:double;        procedure WritePayInc3 (pValue:double);
    function  ReadPayOut3:double;        procedure WritePayOut3 (pValue:double);
    function  ReadPayTrn3:double;        procedure WritePayTrn3 (pValue:double);
    function  ReadPayNum4:word;          procedure WritePayNum4 (pValue:word);
    function  ReadPayNam4:Str30;         procedure WritePayNam4 (pValue:Str30);
    function  ReadPayInc4:double;        procedure WritePayInc4 (pValue:double);
    function  ReadPayOut4:double;        procedure WritePayOut4 (pValue:double);
    function  ReadPayTrn4:double;        procedure WritePayTrn4 (pValue:double);
    function  ReadPayNum5:word;          procedure WritePayNum5 (pValue:word);
    function  ReadPayNam5:Str30;         procedure WritePayNam5 (pValue:Str30);
    function  ReadPayInc5:double;        procedure WritePayInc5 (pValue:double);
    function  ReadPayOut5:double;        procedure WritePayOut5 (pValue:double);
    function  ReadPayTrn5:double;        procedure WritePayTrn5 (pValue:double);
    function  ReadPayNum6:word;          procedure WritePayNum6 (pValue:word);
    function  ReadPayNam6:Str30;         procedure WritePayNam6 (pValue:Str30);
    function  ReadPayInc6:double;        procedure WritePayInc6 (pValue:double);
    function  ReadPayOut6:double;        procedure WritePayOut6 (pValue:double);
    function  ReadPayTrn6:double;        procedure WritePayTrn6 (pValue:double);
    function  ReadPayNum7:word;          procedure WritePayNum7 (pValue:word);
    function  ReadPayNam7:Str30;         procedure WritePayNam7 (pValue:Str30);
    function  ReadPayInc7:double;        procedure WritePayInc7 (pValue:double);
    function  ReadPayOut7:double;        procedure WritePayOut7 (pValue:double);
    function  ReadPayTrn7:double;        procedure WritePayTrn7 (pValue:double);
    function  ReadPayNum8:word;          procedure WritePayNum8 (pValue:word);
    function  ReadPayNam8:Str30;         procedure WritePayNam8 (pValue:Str30);
    function  ReadPayInc8:double;        procedure WritePayInc8 (pValue:double);
    function  ReadPayOut8:double;        procedure WritePayOut8 (pValue:double);
    function  ReadPayTrn8:double;        procedure WritePayTrn8 (pValue:double);
    function  ReadPayNum9:word;          procedure WritePayNum9 (pValue:word);
    function  ReadPayNam9:Str30;         procedure WritePayNam9 (pValue:Str30);
    function  ReadPayInc9:double;        procedure WritePayInc9 (pValue:double);
    function  ReadPayOut9:double;        procedure WritePayOut9 (pValue:double);
    function  ReadPayTrn9:double;        procedure WritePayTrn9 (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateWrCaCd (pWriNum:longint;pCasNum:longint;pClsDat:TDatetime):boolean;
    function LocateWrCaCl (pWriNum:longint;pCasNum:longint;pClsNum:longint):boolean;
    function LocateCaCl (pCasNum:longint;pClsNum:longint):boolean;
    function LocateCdCt (pClsDat:TDatetime;pClsTim:TDatetime):boolean;

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
    property WriNum:longint read ReadWriNum write WriteWriNum;
    property CasNum:longint read ReadCasNum write WriteCasNum;
    property ClsDat:TDatetime read ReadClsDat write WriteClsDat;
    property ClsNum:longint read ReadClsNum write WriteClsNum;
    property BlkNum:longint read ReadBlkNum write WriteBlkNum;
    property ClsTim:TDatetime read ReadClsTim write WriteClsTim;
    property DocCnt:longint read ReadDocCnt write WriteDocCnt;
    property IncCnt:longint read ReadIncCnt write WriteIncCnt;
    property OutCnt:longint read ReadOutCnt write WriteOutCnt;
    property CncCnt:longint read ReadCncCnt write WriteCncCnt;
    property LgnNum:Str8 read ReadLgnNum write WriteLgnNum;
    property UsrNum:Str30 read ReadUsrNum write WriteUsrNum;
    property AValue1:double read ReadAValue1 write WriteAValue1;
    property VValue1:double read ReadVValue1 write WriteVValue1;
    property BValue1:double read ReadBValue1 write WriteBValue1;
    property AValue2:double read ReadAValue2 write WriteAValue2;
    property VValue2:double read ReadVValue2 write WriteVValue2;
    property BValue2:double read ReadBValue2 write WriteBValue2;
    property AValue3:double read ReadAValue3 write WriteAValue3;
    property VValue3:double read ReadVValue3 write WriteVValue3;
    property BValue3:double read ReadBValue3 write WriteBValue3;
    property AValue4:double read ReadAValue4 write WriteAValue4;
    property VValue4:double read ReadVValue4 write WriteVValue4;
    property BValue4:double read ReadBValue4 write WriteBValue4;
    property AValue5:double read ReadAValue5 write WriteAValue5;
    property VValue5:double read ReadVValue5 write WriteVValue5;
    property BValue5:double read ReadBValue5 write WriteBValue5;
    property InvVal:double read ReadInvVal write WriteInvVal;
    property InvCnt:longint read ReadInvCnt write WriteInvCnt;
    property NegVal:double read ReadNegVal write WriteNegVal;
    property NegCnt:longint read ReadNegCnt write WriteNegCnt;
    property RetVal:double read ReadRetVal write WriteRetVal;
    property RetCnt:longint read ReadRetCnt write WriteRetCnt;
    property DscVal:double read ReadDscVal write WriteDscVal;
    property DscCnt:longint read ReadDscCnt write WriteDscCnt;
    property PayNum0:word read ReadPayNum0 write WritePayNum0;
    property PayNam0:Str30 read ReadPayNam0 write WritePayNam0;
    property PayInc0:double read ReadPayInc0 write WritePayInc0;
    property PayOut0:double read ReadPayOut0 write WritePayOut0;
    property PayTrn0:double read ReadPayTrn0 write WritePayTrn0;
    property PayNum1:word read ReadPayNum1 write WritePayNum1;
    property PayNam1:Str30 read ReadPayNam1 write WritePayNam1;
    property PayInc1:double read ReadPayInc1 write WritePayInc1;
    property PayOut1:double read ReadPayOut1 write WritePayOut1;
    property PayTrn1:double read ReadPayTrn1 write WritePayTrn1;
    property PayNum2:word read ReadPayNum2 write WritePayNum2;
    property PayNam2:Str30 read ReadPayNam2 write WritePayNam2;
    property PayInc2:double read ReadPayInc2 write WritePayInc2;
    property PayOut2:double read ReadPayOut2 write WritePayOut2;
    property PayTrn2:double read ReadPayTrn2 write WritePayTrn2;
    property PayNum3:word read ReadPayNum3 write WritePayNum3;
    property PayNam3:Str30 read ReadPayNam3 write WritePayNam3;
    property PayInc3:double read ReadPayInc3 write WritePayInc3;
    property PayOut3:double read ReadPayOut3 write WritePayOut3;
    property PayTrn3:double read ReadPayTrn3 write WritePayTrn3;
    property PayNum4:word read ReadPayNum4 write WritePayNum4;
    property PayNam4:Str30 read ReadPayNam4 write WritePayNam4;
    property PayInc4:double read ReadPayInc4 write WritePayInc4;
    property PayOut4:double read ReadPayOut4 write WritePayOut4;
    property PayTrn4:double read ReadPayTrn4 write WritePayTrn4;
    property PayNum5:word read ReadPayNum5 write WritePayNum5;
    property PayNam5:Str30 read ReadPayNam5 write WritePayNam5;
    property PayInc5:double read ReadPayInc5 write WritePayInc5;
    property PayOut5:double read ReadPayOut5 write WritePayOut5;
    property PayTrn5:double read ReadPayTrn5 write WritePayTrn5;
    property PayNum6:word read ReadPayNum6 write WritePayNum6;
    property PayNam6:Str30 read ReadPayNam6 write WritePayNam6;
    property PayInc6:double read ReadPayInc6 write WritePayInc6;
    property PayOut6:double read ReadPayOut6 write WritePayOut6;
    property PayTrn6:double read ReadPayTrn6 write WritePayTrn6;
    property PayNum7:word read ReadPayNum7 write WritePayNum7;
    property PayNam7:Str30 read ReadPayNam7 write WritePayNam7;
    property PayInc7:double read ReadPayInc7 write WritePayInc7;
    property PayOut7:double read ReadPayOut7 write WritePayOut7;
    property PayTrn7:double read ReadPayTrn7 write WritePayTrn7;
    property PayNum8:word read ReadPayNum8 write WritePayNum8;
    property PayNam8:Str30 read ReadPayNam8 write WritePayNam8;
    property PayInc8:double read ReadPayInc8 write WritePayInc8;
    property PayOut8:double read ReadPayOut8 write WritePayOut8;
    property PayTrn8:double read ReadPayTrn8 write WritePayTrn8;
    property PayNum9:word read ReadPayNum9 write WritePayNum9;
    property PayNam9:Str30 read ReadPayNam9 write WritePayNam9;
    property PayInc9:double read ReadPayInc9 write WritePayInc9;
    property PayOut9:double read ReadPayOut9 write WritePayOut9;
    property PayTrn9:double read ReadPayTrn9 write WritePayTrn9;
  end;

implementation

constructor TClslstTmp.Create;
begin
  oTmpTable := TmpInit ('CLSLST',Self);
end;

destructor TClslstTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TClslstTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TClslstTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TClslstTmp.ReadWriNum:longint;
begin
  Result := oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TClslstTmp.WriteWriNum(pValue:longint);
begin
  oTmpTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TClslstTmp.ReadCasNum:longint;
begin
  Result := oTmpTable.FieldByName('CasNum').AsInteger;
end;

procedure TClslstTmp.WriteCasNum(pValue:longint);
begin
  oTmpTable.FieldByName('CasNum').AsInteger := pValue;
end;

function TClslstTmp.ReadClsDat:TDatetime;
begin
  Result := oTmpTable.FieldByName('ClsDat').AsDateTime;
end;

procedure TClslstTmp.WriteClsDat(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ClsDat').AsDateTime := pValue;
end;

function TClslstTmp.ReadClsNum:longint;
begin
  Result := oTmpTable.FieldByName('ClsNum').AsInteger;
end;

procedure TClslstTmp.WriteClsNum(pValue:longint);
begin
  oTmpTable.FieldByName('ClsNum').AsInteger := pValue;
end;

function TClslstTmp.ReadBlkNum:longint;
begin
  Result := oTmpTable.FieldByName('BlkNum').AsInteger;
end;

procedure TClslstTmp.WriteBlkNum(pValue:longint);
begin
  oTmpTable.FieldByName('BlkNum').AsInteger := pValue;
end;

function TClslstTmp.ReadClsTim:TDatetime;
begin
  Result := oTmpTable.FieldByName('ClsTim').AsDateTime;
end;

procedure TClslstTmp.WriteClsTim(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ClsTim').AsDateTime := pValue;
end;

function TClslstTmp.ReadDocCnt:longint;
begin
  Result := oTmpTable.FieldByName('DocCnt').AsInteger;
end;

procedure TClslstTmp.WriteDocCnt(pValue:longint);
begin
  oTmpTable.FieldByName('DocCnt').AsInteger := pValue;
end;

function TClslstTmp.ReadIncCnt:longint;
begin
  Result := oTmpTable.FieldByName('IncCnt').AsInteger;
end;

procedure TClslstTmp.WriteIncCnt(pValue:longint);
begin
  oTmpTable.FieldByName('IncCnt').AsInteger := pValue;
end;

function TClslstTmp.ReadOutCnt:longint;
begin
  Result := oTmpTable.FieldByName('OutCnt').AsInteger;
end;

procedure TClslstTmp.WriteOutCnt(pValue:longint);
begin
  oTmpTable.FieldByName('OutCnt').AsInteger := pValue;
end;

function TClslstTmp.ReadCncCnt:longint;
begin
  Result := oTmpTable.FieldByName('CncCnt').AsInteger;
end;

procedure TClslstTmp.WriteCncCnt(pValue:longint);
begin
  oTmpTable.FieldByName('CncCnt').AsInteger := pValue;
end;

function TClslstTmp.ReadLgnNum:Str8;
begin
  Result := oTmpTable.FieldByName('LgnNum').AsString;
end;

procedure TClslstTmp.WriteLgnNum(pValue:Str8);
begin
  oTmpTable.FieldByName('LgnNum').AsString := pValue;
end;

function TClslstTmp.ReadUsrNum:Str30;
begin
  Result := oTmpTable.FieldByName('UsrNum').AsString;
end;

procedure TClslstTmp.WriteUsrNum(pValue:Str30);
begin
  oTmpTable.FieldByName('UsrNum').AsString := pValue;
end;

function TClslstTmp.ReadAValue1:double;
begin
  Result := oTmpTable.FieldByName('AValue1').AsFloat;
end;

procedure TClslstTmp.WriteAValue1(pValue:double);
begin
  oTmpTable.FieldByName('AValue1').AsFloat := pValue;
end;

function TClslstTmp.ReadVValue1:double;
begin
  Result := oTmpTable.FieldByName('VValue1').AsFloat;
end;

procedure TClslstTmp.WriteVValue1(pValue:double);
begin
  oTmpTable.FieldByName('VValue1').AsFloat := pValue;
end;

function TClslstTmp.ReadBValue1:double;
begin
  Result := oTmpTable.FieldByName('BValue1').AsFloat;
end;

procedure TClslstTmp.WriteBValue1(pValue:double);
begin
  oTmpTable.FieldByName('BValue1').AsFloat := pValue;
end;

function TClslstTmp.ReadAValue2:double;
begin
  Result := oTmpTable.FieldByName('AValue2').AsFloat;
end;

procedure TClslstTmp.WriteAValue2(pValue:double);
begin
  oTmpTable.FieldByName('AValue2').AsFloat := pValue;
end;

function TClslstTmp.ReadVValue2:double;
begin
  Result := oTmpTable.FieldByName('VValue2').AsFloat;
end;

procedure TClslstTmp.WriteVValue2(pValue:double);
begin
  oTmpTable.FieldByName('VValue2').AsFloat := pValue;
end;

function TClslstTmp.ReadBValue2:double;
begin
  Result := oTmpTable.FieldByName('BValue2').AsFloat;
end;

procedure TClslstTmp.WriteBValue2(pValue:double);
begin
  oTmpTable.FieldByName('BValue2').AsFloat := pValue;
end;

function TClslstTmp.ReadAValue3:double;
begin
  Result := oTmpTable.FieldByName('AValue3').AsFloat;
end;

procedure TClslstTmp.WriteAValue3(pValue:double);
begin
  oTmpTable.FieldByName('AValue3').AsFloat := pValue;
end;

function TClslstTmp.ReadVValue3:double;
begin
  Result := oTmpTable.FieldByName('VValue3').AsFloat;
end;

procedure TClslstTmp.WriteVValue3(pValue:double);
begin
  oTmpTable.FieldByName('VValue3').AsFloat := pValue;
end;

function TClslstTmp.ReadBValue3:double;
begin
  Result := oTmpTable.FieldByName('BValue3').AsFloat;
end;

procedure TClslstTmp.WriteBValue3(pValue:double);
begin
  oTmpTable.FieldByName('BValue3').AsFloat := pValue;
end;

function TClslstTmp.ReadAValue4:double;
begin
  Result := oTmpTable.FieldByName('AValue4').AsFloat;
end;

procedure TClslstTmp.WriteAValue4(pValue:double);
begin
  oTmpTable.FieldByName('AValue4').AsFloat := pValue;
end;

function TClslstTmp.ReadVValue4:double;
begin
  Result := oTmpTable.FieldByName('VValue4').AsFloat;
end;

procedure TClslstTmp.WriteVValue4(pValue:double);
begin
  oTmpTable.FieldByName('VValue4').AsFloat := pValue;
end;

function TClslstTmp.ReadBValue4:double;
begin
  Result := oTmpTable.FieldByName('BValue4').AsFloat;
end;

procedure TClslstTmp.WriteBValue4(pValue:double);
begin
  oTmpTable.FieldByName('BValue4').AsFloat := pValue;
end;

function TClslstTmp.ReadAValue5:double;
begin
  Result := oTmpTable.FieldByName('AValue5').AsFloat;
end;

procedure TClslstTmp.WriteAValue5(pValue:double);
begin
  oTmpTable.FieldByName('AValue5').AsFloat := pValue;
end;

function TClslstTmp.ReadVValue5:double;
begin
  Result := oTmpTable.FieldByName('VValue5').AsFloat;
end;

procedure TClslstTmp.WriteVValue5(pValue:double);
begin
  oTmpTable.FieldByName('VValue5').AsFloat := pValue;
end;

function TClslstTmp.ReadBValue5:double;
begin
  Result := oTmpTable.FieldByName('BValue5').AsFloat;
end;

procedure TClslstTmp.WriteBValue5(pValue:double);
begin
  oTmpTable.FieldByName('BValue5').AsFloat := pValue;
end;

function TClslstTmp.ReadInvVal:double;
begin
  Result := oTmpTable.FieldByName('InvVal').AsFloat;
end;

procedure TClslstTmp.WriteInvVal(pValue:double);
begin
  oTmpTable.FieldByName('InvVal').AsFloat := pValue;
end;

function TClslstTmp.ReadInvCnt:longint;
begin
  Result := oTmpTable.FieldByName('InvCnt').AsInteger;
end;

procedure TClslstTmp.WriteInvCnt(pValue:longint);
begin
  oTmpTable.FieldByName('InvCnt').AsInteger := pValue;
end;

function TClslstTmp.ReadNegVal:double;
begin
  Result := oTmpTable.FieldByName('NegVal').AsFloat;
end;

procedure TClslstTmp.WriteNegVal(pValue:double);
begin
  oTmpTable.FieldByName('NegVal').AsFloat := pValue;
end;

function TClslstTmp.ReadNegCnt:longint;
begin
  Result := oTmpTable.FieldByName('NegCnt').AsInteger;
end;

procedure TClslstTmp.WriteNegCnt(pValue:longint);
begin
  oTmpTable.FieldByName('NegCnt').AsInteger := pValue;
end;

function TClslstTmp.ReadRetVal:double;
begin
  Result := oTmpTable.FieldByName('RetVal').AsFloat;
end;

procedure TClslstTmp.WriteRetVal(pValue:double);
begin
  oTmpTable.FieldByName('RetVal').AsFloat := pValue;
end;

function TClslstTmp.ReadRetCnt:longint;
begin
  Result := oTmpTable.FieldByName('RetCnt').AsInteger;
end;

procedure TClslstTmp.WriteRetCnt(pValue:longint);
begin
  oTmpTable.FieldByName('RetCnt').AsInteger := pValue;
end;

function TClslstTmp.ReadDscVal:double;
begin
  Result := oTmpTable.FieldByName('DscVal').AsFloat;
end;

procedure TClslstTmp.WriteDscVal(pValue:double);
begin
  oTmpTable.FieldByName('DscVal').AsFloat := pValue;
end;

function TClslstTmp.ReadDscCnt:longint;
begin
  Result := oTmpTable.FieldByName('DscCnt').AsInteger;
end;

procedure TClslstTmp.WriteDscCnt(pValue:longint);
begin
  oTmpTable.FieldByName('DscCnt').AsInteger := pValue;
end;

function TClslstTmp.ReadPayNum0:word;
begin
  Result := oTmpTable.FieldByName('PayNum0').AsInteger;
end;

procedure TClslstTmp.WritePayNum0(pValue:word);
begin
  oTmpTable.FieldByName('PayNum0').AsInteger := pValue;
end;

function TClslstTmp.ReadPayNam0:Str30;
begin
  Result := oTmpTable.FieldByName('PayNam0').AsString;
end;

procedure TClslstTmp.WritePayNam0(pValue:Str30);
begin
  oTmpTable.FieldByName('PayNam0').AsString := pValue;
end;

function TClslstTmp.ReadPayInc0:double;
begin
  Result := oTmpTable.FieldByName('PayInc0').AsFloat;
end;

procedure TClslstTmp.WritePayInc0(pValue:double);
begin
  oTmpTable.FieldByName('PayInc0').AsFloat := pValue;
end;

function TClslstTmp.ReadPayOut0:double;
begin
  Result := oTmpTable.FieldByName('PayOut0').AsFloat;
end;

procedure TClslstTmp.WritePayOut0(pValue:double);
begin
  oTmpTable.FieldByName('PayOut0').AsFloat := pValue;
end;

function TClslstTmp.ReadPayTrn0:double;
begin
  Result := oTmpTable.FieldByName('PayTrn0').AsFloat;
end;

procedure TClslstTmp.WritePayTrn0(pValue:double);
begin
  oTmpTable.FieldByName('PayTrn0').AsFloat := pValue;
end;

function TClslstTmp.ReadPayNum1:word;
begin
  Result := oTmpTable.FieldByName('PayNum1').AsInteger;
end;

procedure TClslstTmp.WritePayNum1(pValue:word);
begin
  oTmpTable.FieldByName('PayNum1').AsInteger := pValue;
end;

function TClslstTmp.ReadPayNam1:Str30;
begin
  Result := oTmpTable.FieldByName('PayNam1').AsString;
end;

procedure TClslstTmp.WritePayNam1(pValue:Str30);
begin
  oTmpTable.FieldByName('PayNam1').AsString := pValue;
end;

function TClslstTmp.ReadPayInc1:double;
begin
  Result := oTmpTable.FieldByName('PayInc1').AsFloat;
end;

procedure TClslstTmp.WritePayInc1(pValue:double);
begin
  oTmpTable.FieldByName('PayInc1').AsFloat := pValue;
end;

function TClslstTmp.ReadPayOut1:double;
begin
  Result := oTmpTable.FieldByName('PayOut1').AsFloat;
end;

procedure TClslstTmp.WritePayOut1(pValue:double);
begin
  oTmpTable.FieldByName('PayOut1').AsFloat := pValue;
end;

function TClslstTmp.ReadPayTrn1:double;
begin
  Result := oTmpTable.FieldByName('PayTrn1').AsFloat;
end;

procedure TClslstTmp.WritePayTrn1(pValue:double);
begin
  oTmpTable.FieldByName('PayTrn1').AsFloat := pValue;
end;

function TClslstTmp.ReadPayNum2:word;
begin
  Result := oTmpTable.FieldByName('PayNum2').AsInteger;
end;

procedure TClslstTmp.WritePayNum2(pValue:word);
begin
  oTmpTable.FieldByName('PayNum2').AsInteger := pValue;
end;

function TClslstTmp.ReadPayNam2:Str30;
begin
  Result := oTmpTable.FieldByName('PayNam2').AsString;
end;

procedure TClslstTmp.WritePayNam2(pValue:Str30);
begin
  oTmpTable.FieldByName('PayNam2').AsString := pValue;
end;

function TClslstTmp.ReadPayInc2:double;
begin
  Result := oTmpTable.FieldByName('PayInc2').AsFloat;
end;

procedure TClslstTmp.WritePayInc2(pValue:double);
begin
  oTmpTable.FieldByName('PayInc2').AsFloat := pValue;
end;

function TClslstTmp.ReadPayOut2:double;
begin
  Result := oTmpTable.FieldByName('PayOut2').AsFloat;
end;

procedure TClslstTmp.WritePayOut2(pValue:double);
begin
  oTmpTable.FieldByName('PayOut2').AsFloat := pValue;
end;

function TClslstTmp.ReadPayTrn2:double;
begin
  Result := oTmpTable.FieldByName('PayTrn2').AsFloat;
end;

procedure TClslstTmp.WritePayTrn2(pValue:double);
begin
  oTmpTable.FieldByName('PayTrn2').AsFloat := pValue;
end;

function TClslstTmp.ReadPayNum3:word;
begin
  Result := oTmpTable.FieldByName('PayNum3').AsInteger;
end;

procedure TClslstTmp.WritePayNum3(pValue:word);
begin
  oTmpTable.FieldByName('PayNum3').AsInteger := pValue;
end;

function TClslstTmp.ReadPayNam3:Str30;
begin
  Result := oTmpTable.FieldByName('PayNam3').AsString;
end;

procedure TClslstTmp.WritePayNam3(pValue:Str30);
begin
  oTmpTable.FieldByName('PayNam3').AsString := pValue;
end;

function TClslstTmp.ReadPayInc3:double;
begin
  Result := oTmpTable.FieldByName('PayInc3').AsFloat;
end;

procedure TClslstTmp.WritePayInc3(pValue:double);
begin
  oTmpTable.FieldByName('PayInc3').AsFloat := pValue;
end;

function TClslstTmp.ReadPayOut3:double;
begin
  Result := oTmpTable.FieldByName('PayOut3').AsFloat;
end;

procedure TClslstTmp.WritePayOut3(pValue:double);
begin
  oTmpTable.FieldByName('PayOut3').AsFloat := pValue;
end;

function TClslstTmp.ReadPayTrn3:double;
begin
  Result := oTmpTable.FieldByName('PayTrn3').AsFloat;
end;

procedure TClslstTmp.WritePayTrn3(pValue:double);
begin
  oTmpTable.FieldByName('PayTrn3').AsFloat := pValue;
end;

function TClslstTmp.ReadPayNum4:word;
begin
  Result := oTmpTable.FieldByName('PayNum4').AsInteger;
end;

procedure TClslstTmp.WritePayNum4(pValue:word);
begin
  oTmpTable.FieldByName('PayNum4').AsInteger := pValue;
end;

function TClslstTmp.ReadPayNam4:Str30;
begin
  Result := oTmpTable.FieldByName('PayNam4').AsString;
end;

procedure TClslstTmp.WritePayNam4(pValue:Str30);
begin
  oTmpTable.FieldByName('PayNam4').AsString := pValue;
end;

function TClslstTmp.ReadPayInc4:double;
begin
  Result := oTmpTable.FieldByName('PayInc4').AsFloat;
end;

procedure TClslstTmp.WritePayInc4(pValue:double);
begin
  oTmpTable.FieldByName('PayInc4').AsFloat := pValue;
end;

function TClslstTmp.ReadPayOut4:double;
begin
  Result := oTmpTable.FieldByName('PayOut4').AsFloat;
end;

procedure TClslstTmp.WritePayOut4(pValue:double);
begin
  oTmpTable.FieldByName('PayOut4').AsFloat := pValue;
end;

function TClslstTmp.ReadPayTrn4:double;
begin
  Result := oTmpTable.FieldByName('PayTrn4').AsFloat;
end;

procedure TClslstTmp.WritePayTrn4(pValue:double);
begin
  oTmpTable.FieldByName('PayTrn4').AsFloat := pValue;
end;

function TClslstTmp.ReadPayNum5:word;
begin
  Result := oTmpTable.FieldByName('PayNum5').AsInteger;
end;

procedure TClslstTmp.WritePayNum5(pValue:word);
begin
  oTmpTable.FieldByName('PayNum5').AsInteger := pValue;
end;

function TClslstTmp.ReadPayNam5:Str30;
begin
  Result := oTmpTable.FieldByName('PayNam5').AsString;
end;

procedure TClslstTmp.WritePayNam5(pValue:Str30);
begin
  oTmpTable.FieldByName('PayNam5').AsString := pValue;
end;

function TClslstTmp.ReadPayInc5:double;
begin
  Result := oTmpTable.FieldByName('PayInc5').AsFloat;
end;

procedure TClslstTmp.WritePayInc5(pValue:double);
begin
  oTmpTable.FieldByName('PayInc5').AsFloat := pValue;
end;

function TClslstTmp.ReadPayOut5:double;
begin
  Result := oTmpTable.FieldByName('PayOut5').AsFloat;
end;

procedure TClslstTmp.WritePayOut5(pValue:double);
begin
  oTmpTable.FieldByName('PayOut5').AsFloat := pValue;
end;

function TClslstTmp.ReadPayTrn5:double;
begin
  Result := oTmpTable.FieldByName('PayTrn5').AsFloat;
end;

procedure TClslstTmp.WritePayTrn5(pValue:double);
begin
  oTmpTable.FieldByName('PayTrn5').AsFloat := pValue;
end;

function TClslstTmp.ReadPayNum6:word;
begin
  Result := oTmpTable.FieldByName('PayNum6').AsInteger;
end;

procedure TClslstTmp.WritePayNum6(pValue:word);
begin
  oTmpTable.FieldByName('PayNum6').AsInteger := pValue;
end;

function TClslstTmp.ReadPayNam6:Str30;
begin
  Result := oTmpTable.FieldByName('PayNam6').AsString;
end;

procedure TClslstTmp.WritePayNam6(pValue:Str30);
begin
  oTmpTable.FieldByName('PayNam6').AsString := pValue;
end;

function TClslstTmp.ReadPayInc6:double;
begin
  Result := oTmpTable.FieldByName('PayInc6').AsFloat;
end;

procedure TClslstTmp.WritePayInc6(pValue:double);
begin
  oTmpTable.FieldByName('PayInc6').AsFloat := pValue;
end;

function TClslstTmp.ReadPayOut6:double;
begin
  Result := oTmpTable.FieldByName('PayOut6').AsFloat;
end;

procedure TClslstTmp.WritePayOut6(pValue:double);
begin
  oTmpTable.FieldByName('PayOut6').AsFloat := pValue;
end;

function TClslstTmp.ReadPayTrn6:double;
begin
  Result := oTmpTable.FieldByName('PayTrn6').AsFloat;
end;

procedure TClslstTmp.WritePayTrn6(pValue:double);
begin
  oTmpTable.FieldByName('PayTrn6').AsFloat := pValue;
end;

function TClslstTmp.ReadPayNum7:word;
begin
  Result := oTmpTable.FieldByName('PayNum7').AsInteger;
end;

procedure TClslstTmp.WritePayNum7(pValue:word);
begin
  oTmpTable.FieldByName('PayNum7').AsInteger := pValue;
end;

function TClslstTmp.ReadPayNam7:Str30;
begin
  Result := oTmpTable.FieldByName('PayNam7').AsString;
end;

procedure TClslstTmp.WritePayNam7(pValue:Str30);
begin
  oTmpTable.FieldByName('PayNam7').AsString := pValue;
end;

function TClslstTmp.ReadPayInc7:double;
begin
  Result := oTmpTable.FieldByName('PayInc7').AsFloat;
end;

procedure TClslstTmp.WritePayInc7(pValue:double);
begin
  oTmpTable.FieldByName('PayInc7').AsFloat := pValue;
end;

function TClslstTmp.ReadPayOut7:double;
begin
  Result := oTmpTable.FieldByName('PayOut7').AsFloat;
end;

procedure TClslstTmp.WritePayOut7(pValue:double);
begin
  oTmpTable.FieldByName('PayOut7').AsFloat := pValue;
end;

function TClslstTmp.ReadPayTrn7:double;
begin
  Result := oTmpTable.FieldByName('PayTrn7').AsFloat;
end;

procedure TClslstTmp.WritePayTrn7(pValue:double);
begin
  oTmpTable.FieldByName('PayTrn7').AsFloat := pValue;
end;

function TClslstTmp.ReadPayNum8:word;
begin
  Result := oTmpTable.FieldByName('PayNum8').AsInteger;
end;

procedure TClslstTmp.WritePayNum8(pValue:word);
begin
  oTmpTable.FieldByName('PayNum8').AsInteger := pValue;
end;

function TClslstTmp.ReadPayNam8:Str30;
begin
  Result := oTmpTable.FieldByName('PayNam8').AsString;
end;

procedure TClslstTmp.WritePayNam8(pValue:Str30);
begin
  oTmpTable.FieldByName('PayNam8').AsString := pValue;
end;

function TClslstTmp.ReadPayInc8:double;
begin
  Result := oTmpTable.FieldByName('PayInc8').AsFloat;
end;

procedure TClslstTmp.WritePayInc8(pValue:double);
begin
  oTmpTable.FieldByName('PayInc8').AsFloat := pValue;
end;

function TClslstTmp.ReadPayOut8:double;
begin
  Result := oTmpTable.FieldByName('PayOut8').AsFloat;
end;

procedure TClslstTmp.WritePayOut8(pValue:double);
begin
  oTmpTable.FieldByName('PayOut8').AsFloat := pValue;
end;

function TClslstTmp.ReadPayTrn8:double;
begin
  Result := oTmpTable.FieldByName('PayTrn8').AsFloat;
end;

procedure TClslstTmp.WritePayTrn8(pValue:double);
begin
  oTmpTable.FieldByName('PayTrn8').AsFloat := pValue;
end;

function TClslstTmp.ReadPayNum9:word;
begin
  Result := oTmpTable.FieldByName('PayNum9').AsInteger;
end;

procedure TClslstTmp.WritePayNum9(pValue:word);
begin
  oTmpTable.FieldByName('PayNum9').AsInteger := pValue;
end;

function TClslstTmp.ReadPayNam9:Str30;
begin
  Result := oTmpTable.FieldByName('PayNam9').AsString;
end;

procedure TClslstTmp.WritePayNam9(pValue:Str30);
begin
  oTmpTable.FieldByName('PayNam9').AsString := pValue;
end;

function TClslstTmp.ReadPayInc9:double;
begin
  Result := oTmpTable.FieldByName('PayInc9').AsFloat;
end;

procedure TClslstTmp.WritePayInc9(pValue:double);
begin
  oTmpTable.FieldByName('PayInc9').AsFloat := pValue;
end;

function TClslstTmp.ReadPayOut9:double;
begin
  Result := oTmpTable.FieldByName('PayOut9').AsFloat;
end;

procedure TClslstTmp.WritePayOut9(pValue:double);
begin
  oTmpTable.FieldByName('PayOut9').AsFloat := pValue;
end;

function TClslstTmp.ReadPayTrn9:double;
begin
  Result := oTmpTable.FieldByName('PayTrn9').AsFloat;
end;

procedure TClslstTmp.WritePayTrn9(pValue:double);
begin
  oTmpTable.FieldByName('PayTrn9').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TClslstTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TClslstTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TClslstTmp.LocateWrCaCd (pWriNum:longint;pCasNum:longint;pClsDat:TDatetime):boolean;
begin
  SetIndex (ixWrCaCd);
  Result := oTmpTable.FindKey([pWriNum,pCasNum,pClsDat]);
end;

function TClslstTmp.LocateWrCaCl (pWriNum:longint;pCasNum:longint;pClsNum:longint):boolean;
begin
  SetIndex (ixWrCaCl);
  Result := oTmpTable.FindKey([pWriNum,pCasNum,pClsNum]);
end;

function TClslstTmp.LocateCaCl (pCasNum:longint;pClsNum:longint):boolean;
begin
  SetIndex (ixCaCl);
  Result := oTmpTable.FindKey([pCasNum,pClsNum]);
end;

function TClslstTmp.LocateCdCt (pClsDat:TDatetime;pClsTim:TDatetime):boolean;
begin
  SetIndex (ixCdCt);
  Result := oTmpTable.FindKey([pClsDat,pClsTim]);
end;

procedure TClslstTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TClslstTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TClslstTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TClslstTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TClslstTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TClslstTmp.First;
begin
  oTmpTable.First;
end;

procedure TClslstTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TClslstTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TClslstTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TClslstTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TClslstTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TClslstTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TClslstTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TClslstTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TClslstTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TClslstTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TClslstTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
