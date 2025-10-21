unit bCLSLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixWrCaCl = 'WrCaCl';
  ixCaCl = 'CaCl';
  ixCdCt = 'CdCt';

type
  TClslstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadWriNum:longint;        procedure WriteWriNum (pValue:longint);
    function  ReadCasNum:longint;        procedure WriteCasNum (pValue:longint);
    function  ReadClsNum:longint;        procedure WriteClsNum (pValue:longint);
    function  ReadBlkNum:longint;        procedure WriteBlkNum (pValue:longint);
    function  ReadClsDat:TDatetime;      procedure WriteClsDat (pValue:TDatetime);
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
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateWrCaCl (pWriNum:longint;pCasNum:longint;pClsNum:longint):boolean;
    function LocateCaCl (pCasNum:longint;pClsNum:longint):boolean;
    function LocateCdCt (pClsDat:TDatetime;pClsTim:TDatetime):boolean;
    function NearestWrCaCl (pWriNum:longint;pCasNum:longint;pClsNum:longint):boolean;
    function NearestCaCl (pCasNum:longint;pClsNum:longint):boolean;
    function NearestCdCt (pClsDat:TDatetime;pClsTim:TDatetime):boolean;

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
    procedure EnableControls;
    procedure DisableControls;
  published
    property BtrTable:TNexBtrTable read oBtrTable;
    property Count:integer read ReadCount;
    // Pristup k databazovym poliam
    property WriNum:longint read ReadWriNum write WriteWriNum;
    property CasNum:longint read ReadCasNum write WriteCasNum;
    property ClsNum:longint read ReadClsNum write WriteClsNum;
    property BlkNum:longint read ReadBlkNum write WriteBlkNum;
    property ClsDat:TDatetime read ReadClsDat write WriteClsDat;
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

constructor TClslstBtr.Create;
begin
  oBtrTable := BtrInit ('CLSLST',gPath.CabPath,Self);
end;

constructor TClslstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('CLSLST',pPath,Self);
end;

destructor TClslstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TClslstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TClslstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TClslstBtr.ReadWriNum:longint;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TClslstBtr.WriteWriNum(pValue:longint);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TClslstBtr.ReadCasNum:longint;
begin
  Result := oBtrTable.FieldByName('CasNum').AsInteger;
end;

procedure TClslstBtr.WriteCasNum(pValue:longint);
begin
  oBtrTable.FieldByName('CasNum').AsInteger := pValue;
end;

function TClslstBtr.ReadClsNum:longint;
begin
  Result := oBtrTable.FieldByName('ClsNum').AsInteger;
end;

procedure TClslstBtr.WriteClsNum(pValue:longint);
begin
  oBtrTable.FieldByName('ClsNum').AsInteger := pValue;
end;

function TClslstBtr.ReadBlkNum:longint;
begin
  Result := oBtrTable.FieldByName('BlkNum').AsInteger;
end;

procedure TClslstBtr.WriteBlkNum(pValue:longint);
begin
  oBtrTable.FieldByName('BlkNum').AsInteger := pValue;
end;

function TClslstBtr.ReadClsDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('ClsDat').AsDateTime;
end;

procedure TClslstBtr.WriteClsDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ClsDat').AsDateTime := pValue;
end;

function TClslstBtr.ReadClsTim:TDatetime;
begin
  Result := oBtrTable.FieldByName('ClsTim').AsDateTime;
end;

procedure TClslstBtr.WriteClsTim(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ClsTim').AsDateTime := pValue;
end;

function TClslstBtr.ReadDocCnt:longint;
begin
  Result := oBtrTable.FieldByName('DocCnt').AsInteger;
end;

procedure TClslstBtr.WriteDocCnt(pValue:longint);
begin
  oBtrTable.FieldByName('DocCnt').AsInteger := pValue;
end;

function TClslstBtr.ReadIncCnt:longint;
begin
  Result := oBtrTable.FieldByName('IncCnt').AsInteger;
end;

procedure TClslstBtr.WriteIncCnt(pValue:longint);
begin
  oBtrTable.FieldByName('IncCnt').AsInteger := pValue;
end;

function TClslstBtr.ReadOutCnt:longint;
begin
  Result := oBtrTable.FieldByName('OutCnt').AsInteger;
end;

procedure TClslstBtr.WriteOutCnt(pValue:longint);
begin
  oBtrTable.FieldByName('OutCnt').AsInteger := pValue;
end;

function TClslstBtr.ReadCncCnt:longint;
begin
  Result := oBtrTable.FieldByName('CncCnt').AsInteger;
end;

procedure TClslstBtr.WriteCncCnt(pValue:longint);
begin
  oBtrTable.FieldByName('CncCnt').AsInteger := pValue;
end;

function TClslstBtr.ReadLgnNum:Str8;
begin
  Result := oBtrTable.FieldByName('LgnNum').AsString;
end;

procedure TClslstBtr.WriteLgnNum(pValue:Str8);
begin
  oBtrTable.FieldByName('LgnNum').AsString := pValue;
end;

function TClslstBtr.ReadUsrNum:Str30;
begin
  Result := oBtrTable.FieldByName('UsrNum').AsString;
end;

procedure TClslstBtr.WriteUsrNum(pValue:Str30);
begin
  oBtrTable.FieldByName('UsrNum').AsString := pValue;
end;

function TClslstBtr.ReadAValue1:double;
begin
  Result := oBtrTable.FieldByName('AValue1').AsFloat;
end;

procedure TClslstBtr.WriteAValue1(pValue:double);
begin
  oBtrTable.FieldByName('AValue1').AsFloat := pValue;
end;

function TClslstBtr.ReadVValue1:double;
begin
  Result := oBtrTable.FieldByName('VValue1').AsFloat;
end;

procedure TClslstBtr.WriteVValue1(pValue:double);
begin
  oBtrTable.FieldByName('VValue1').AsFloat := pValue;
end;

function TClslstBtr.ReadBValue1:double;
begin
  Result := oBtrTable.FieldByName('BValue1').AsFloat;
end;

procedure TClslstBtr.WriteBValue1(pValue:double);
begin
  oBtrTable.FieldByName('BValue1').AsFloat := pValue;
end;

function TClslstBtr.ReadAValue2:double;
begin
  Result := oBtrTable.FieldByName('AValue2').AsFloat;
end;

procedure TClslstBtr.WriteAValue2(pValue:double);
begin
  oBtrTable.FieldByName('AValue2').AsFloat := pValue;
end;

function TClslstBtr.ReadVValue2:double;
begin
  Result := oBtrTable.FieldByName('VValue2').AsFloat;
end;

procedure TClslstBtr.WriteVValue2(pValue:double);
begin
  oBtrTable.FieldByName('VValue2').AsFloat := pValue;
end;

function TClslstBtr.ReadBValue2:double;
begin
  Result := oBtrTable.FieldByName('BValue2').AsFloat;
end;

procedure TClslstBtr.WriteBValue2(pValue:double);
begin
  oBtrTable.FieldByName('BValue2').AsFloat := pValue;
end;

function TClslstBtr.ReadAValue3:double;
begin
  Result := oBtrTable.FieldByName('AValue3').AsFloat;
end;

procedure TClslstBtr.WriteAValue3(pValue:double);
begin
  oBtrTable.FieldByName('AValue3').AsFloat := pValue;
end;

function TClslstBtr.ReadVValue3:double;
begin
  Result := oBtrTable.FieldByName('VValue3').AsFloat;
end;

procedure TClslstBtr.WriteVValue3(pValue:double);
begin
  oBtrTable.FieldByName('VValue3').AsFloat := pValue;
end;

function TClslstBtr.ReadBValue3:double;
begin
  Result := oBtrTable.FieldByName('BValue3').AsFloat;
end;

procedure TClslstBtr.WriteBValue3(pValue:double);
begin
  oBtrTable.FieldByName('BValue3').AsFloat := pValue;
end;

function TClslstBtr.ReadAValue4:double;
begin
  Result := oBtrTable.FieldByName('AValue4').AsFloat;
end;

procedure TClslstBtr.WriteAValue4(pValue:double);
begin
  oBtrTable.FieldByName('AValue4').AsFloat := pValue;
end;

function TClslstBtr.ReadVValue4:double;
begin
  Result := oBtrTable.FieldByName('VValue4').AsFloat;
end;

procedure TClslstBtr.WriteVValue4(pValue:double);
begin
  oBtrTable.FieldByName('VValue4').AsFloat := pValue;
end;

function TClslstBtr.ReadBValue4:double;
begin
  Result := oBtrTable.FieldByName('BValue4').AsFloat;
end;

procedure TClslstBtr.WriteBValue4(pValue:double);
begin
  oBtrTable.FieldByName('BValue4').AsFloat := pValue;
end;

function TClslstBtr.ReadAValue5:double;
begin
  Result := oBtrTable.FieldByName('AValue5').AsFloat;
end;

procedure TClslstBtr.WriteAValue5(pValue:double);
begin
  oBtrTable.FieldByName('AValue5').AsFloat := pValue;
end;

function TClslstBtr.ReadVValue5:double;
begin
  Result := oBtrTable.FieldByName('VValue5').AsFloat;
end;

procedure TClslstBtr.WriteVValue5(pValue:double);
begin
  oBtrTable.FieldByName('VValue5').AsFloat := pValue;
end;

function TClslstBtr.ReadBValue5:double;
begin
  Result := oBtrTable.FieldByName('BValue5').AsFloat;
end;

procedure TClslstBtr.WriteBValue5(pValue:double);
begin
  oBtrTable.FieldByName('BValue5').AsFloat := pValue;
end;

function TClslstBtr.ReadInvVal:double;
begin
  Result := oBtrTable.FieldByName('InvVal').AsFloat;
end;

procedure TClslstBtr.WriteInvVal(pValue:double);
begin
  oBtrTable.FieldByName('InvVal').AsFloat := pValue;
end;

function TClslstBtr.ReadInvCnt:longint;
begin
  Result := oBtrTable.FieldByName('InvCnt').AsInteger;
end;

procedure TClslstBtr.WriteInvCnt(pValue:longint);
begin
  oBtrTable.FieldByName('InvCnt').AsInteger := pValue;
end;

function TClslstBtr.ReadNegVal:double;
begin
  Result := oBtrTable.FieldByName('NegVal').AsFloat;
end;

procedure TClslstBtr.WriteNegVal(pValue:double);
begin
  oBtrTable.FieldByName('NegVal').AsFloat := pValue;
end;

function TClslstBtr.ReadNegCnt:longint;
begin
  Result := oBtrTable.FieldByName('NegCnt').AsInteger;
end;

procedure TClslstBtr.WriteNegCnt(pValue:longint);
begin
  oBtrTable.FieldByName('NegCnt').AsInteger := pValue;
end;

function TClslstBtr.ReadRetVal:double;
begin
  Result := oBtrTable.FieldByName('RetVal').AsFloat;
end;

procedure TClslstBtr.WriteRetVal(pValue:double);
begin
  oBtrTable.FieldByName('RetVal').AsFloat := pValue;
end;

function TClslstBtr.ReadRetCnt:longint;
begin
  Result := oBtrTable.FieldByName('RetCnt').AsInteger;
end;

procedure TClslstBtr.WriteRetCnt(pValue:longint);
begin
  oBtrTable.FieldByName('RetCnt').AsInteger := pValue;
end;

function TClslstBtr.ReadDscVal:double;
begin
  Result := oBtrTable.FieldByName('DscVal').AsFloat;
end;

procedure TClslstBtr.WriteDscVal(pValue:double);
begin
  oBtrTable.FieldByName('DscVal').AsFloat := pValue;
end;

function TClslstBtr.ReadDscCnt:longint;
begin
  Result := oBtrTable.FieldByName('DscCnt').AsInteger;
end;

procedure TClslstBtr.WriteDscCnt(pValue:longint);
begin
  oBtrTable.FieldByName('DscCnt').AsInteger := pValue;
end;

function TClslstBtr.ReadPayNum0:word;
begin
  Result := oBtrTable.FieldByName('PayNum0').AsInteger;
end;

procedure TClslstBtr.WritePayNum0(pValue:word);
begin
  oBtrTable.FieldByName('PayNum0').AsInteger := pValue;
end;

function TClslstBtr.ReadPayNam0:Str30;
begin
  Result := oBtrTable.FieldByName('PayNam0').AsString;
end;

procedure TClslstBtr.WritePayNam0(pValue:Str30);
begin
  oBtrTable.FieldByName('PayNam0').AsString := pValue;
end;

function TClslstBtr.ReadPayInc0:double;
begin
  Result := oBtrTable.FieldByName('PayInc0').AsFloat;
end;

procedure TClslstBtr.WritePayInc0(pValue:double);
begin
  oBtrTable.FieldByName('PayInc0').AsFloat := pValue;
end;

function TClslstBtr.ReadPayOut0:double;
begin
  Result := oBtrTable.FieldByName('PayOut0').AsFloat;
end;

procedure TClslstBtr.WritePayOut0(pValue:double);
begin
  oBtrTable.FieldByName('PayOut0').AsFloat := pValue;
end;

function TClslstBtr.ReadPayTrn0:double;
begin
  Result := oBtrTable.FieldByName('PayTrn0').AsFloat;
end;

procedure TClslstBtr.WritePayTrn0(pValue:double);
begin
  oBtrTable.FieldByName('PayTrn0').AsFloat := pValue;
end;

function TClslstBtr.ReadPayNum1:word;
begin
  Result := oBtrTable.FieldByName('PayNum1').AsInteger;
end;

procedure TClslstBtr.WritePayNum1(pValue:word);
begin
  oBtrTable.FieldByName('PayNum1').AsInteger := pValue;
end;

function TClslstBtr.ReadPayNam1:Str30;
begin
  Result := oBtrTable.FieldByName('PayNam1').AsString;
end;

procedure TClslstBtr.WritePayNam1(pValue:Str30);
begin
  oBtrTable.FieldByName('PayNam1').AsString := pValue;
end;

function TClslstBtr.ReadPayInc1:double;
begin
  Result := oBtrTable.FieldByName('PayInc1').AsFloat;
end;

procedure TClslstBtr.WritePayInc1(pValue:double);
begin
  oBtrTable.FieldByName('PayInc1').AsFloat := pValue;
end;

function TClslstBtr.ReadPayOut1:double;
begin
  Result := oBtrTable.FieldByName('PayOut1').AsFloat;
end;

procedure TClslstBtr.WritePayOut1(pValue:double);
begin
  oBtrTable.FieldByName('PayOut1').AsFloat := pValue;
end;

function TClslstBtr.ReadPayTrn1:double;
begin
  Result := oBtrTable.FieldByName('PayTrn1').AsFloat;
end;

procedure TClslstBtr.WritePayTrn1(pValue:double);
begin
  oBtrTable.FieldByName('PayTrn1').AsFloat := pValue;
end;

function TClslstBtr.ReadPayNum2:word;
begin
  Result := oBtrTable.FieldByName('PayNum2').AsInteger;
end;

procedure TClslstBtr.WritePayNum2(pValue:word);
begin
  oBtrTable.FieldByName('PayNum2').AsInteger := pValue;
end;

function TClslstBtr.ReadPayNam2:Str30;
begin
  Result := oBtrTable.FieldByName('PayNam2').AsString;
end;

procedure TClslstBtr.WritePayNam2(pValue:Str30);
begin
  oBtrTable.FieldByName('PayNam2').AsString := pValue;
end;

function TClslstBtr.ReadPayInc2:double;
begin
  Result := oBtrTable.FieldByName('PayInc2').AsFloat;
end;

procedure TClslstBtr.WritePayInc2(pValue:double);
begin
  oBtrTable.FieldByName('PayInc2').AsFloat := pValue;
end;

function TClslstBtr.ReadPayOut2:double;
begin
  Result := oBtrTable.FieldByName('PayOut2').AsFloat;
end;

procedure TClslstBtr.WritePayOut2(pValue:double);
begin
  oBtrTable.FieldByName('PayOut2').AsFloat := pValue;
end;

function TClslstBtr.ReadPayTrn2:double;
begin
  Result := oBtrTable.FieldByName('PayTrn2').AsFloat;
end;

procedure TClslstBtr.WritePayTrn2(pValue:double);
begin
  oBtrTable.FieldByName('PayTrn2').AsFloat := pValue;
end;

function TClslstBtr.ReadPayNum3:word;
begin
  Result := oBtrTable.FieldByName('PayNum3').AsInteger;
end;

procedure TClslstBtr.WritePayNum3(pValue:word);
begin
  oBtrTable.FieldByName('PayNum3').AsInteger := pValue;
end;

function TClslstBtr.ReadPayNam3:Str30;
begin
  Result := oBtrTable.FieldByName('PayNam3').AsString;
end;

procedure TClslstBtr.WritePayNam3(pValue:Str30);
begin
  oBtrTable.FieldByName('PayNam3').AsString := pValue;
end;

function TClslstBtr.ReadPayInc3:double;
begin
  Result := oBtrTable.FieldByName('PayInc3').AsFloat;
end;

procedure TClslstBtr.WritePayInc3(pValue:double);
begin
  oBtrTable.FieldByName('PayInc3').AsFloat := pValue;
end;

function TClslstBtr.ReadPayOut3:double;
begin
  Result := oBtrTable.FieldByName('PayOut3').AsFloat;
end;

procedure TClslstBtr.WritePayOut3(pValue:double);
begin
  oBtrTable.FieldByName('PayOut3').AsFloat := pValue;
end;

function TClslstBtr.ReadPayTrn3:double;
begin
  Result := oBtrTable.FieldByName('PayTrn3').AsFloat;
end;

procedure TClslstBtr.WritePayTrn3(pValue:double);
begin
  oBtrTable.FieldByName('PayTrn3').AsFloat := pValue;
end;

function TClslstBtr.ReadPayNum4:word;
begin
  Result := oBtrTable.FieldByName('PayNum4').AsInteger;
end;

procedure TClslstBtr.WritePayNum4(pValue:word);
begin
  oBtrTable.FieldByName('PayNum4').AsInteger := pValue;
end;

function TClslstBtr.ReadPayNam4:Str30;
begin
  Result := oBtrTable.FieldByName('PayNam4').AsString;
end;

procedure TClslstBtr.WritePayNam4(pValue:Str30);
begin
  oBtrTable.FieldByName('PayNam4').AsString := pValue;
end;

function TClslstBtr.ReadPayInc4:double;
begin
  Result := oBtrTable.FieldByName('PayInc4').AsFloat;
end;

procedure TClslstBtr.WritePayInc4(pValue:double);
begin
  oBtrTable.FieldByName('PayInc4').AsFloat := pValue;
end;

function TClslstBtr.ReadPayOut4:double;
begin
  Result := oBtrTable.FieldByName('PayOut4').AsFloat;
end;

procedure TClslstBtr.WritePayOut4(pValue:double);
begin
  oBtrTable.FieldByName('PayOut4').AsFloat := pValue;
end;

function TClslstBtr.ReadPayTrn4:double;
begin
  Result := oBtrTable.FieldByName('PayTrn4').AsFloat;
end;

procedure TClslstBtr.WritePayTrn4(pValue:double);
begin
  oBtrTable.FieldByName('PayTrn4').AsFloat := pValue;
end;

function TClslstBtr.ReadPayNum5:word;
begin
  Result := oBtrTable.FieldByName('PayNum5').AsInteger;
end;

procedure TClslstBtr.WritePayNum5(pValue:word);
begin
  oBtrTable.FieldByName('PayNum5').AsInteger := pValue;
end;

function TClslstBtr.ReadPayNam5:Str30;
begin
  Result := oBtrTable.FieldByName('PayNam5').AsString;
end;

procedure TClslstBtr.WritePayNam5(pValue:Str30);
begin
  oBtrTable.FieldByName('PayNam5').AsString := pValue;
end;

function TClslstBtr.ReadPayInc5:double;
begin
  Result := oBtrTable.FieldByName('PayInc5').AsFloat;
end;

procedure TClslstBtr.WritePayInc5(pValue:double);
begin
  oBtrTable.FieldByName('PayInc5').AsFloat := pValue;
end;

function TClslstBtr.ReadPayOut5:double;
begin
  Result := oBtrTable.FieldByName('PayOut5').AsFloat;
end;

procedure TClslstBtr.WritePayOut5(pValue:double);
begin
  oBtrTable.FieldByName('PayOut5').AsFloat := pValue;
end;

function TClslstBtr.ReadPayTrn5:double;
begin
  Result := oBtrTable.FieldByName('PayTrn5').AsFloat;
end;

procedure TClslstBtr.WritePayTrn5(pValue:double);
begin
  oBtrTable.FieldByName('PayTrn5').AsFloat := pValue;
end;

function TClslstBtr.ReadPayNum6:word;
begin
  Result := oBtrTable.FieldByName('PayNum6').AsInteger;
end;

procedure TClslstBtr.WritePayNum6(pValue:word);
begin
  oBtrTable.FieldByName('PayNum6').AsInteger := pValue;
end;

function TClslstBtr.ReadPayNam6:Str30;
begin
  Result := oBtrTable.FieldByName('PayNam6').AsString;
end;

procedure TClslstBtr.WritePayNam6(pValue:Str30);
begin
  oBtrTable.FieldByName('PayNam6').AsString := pValue;
end;

function TClslstBtr.ReadPayInc6:double;
begin
  Result := oBtrTable.FieldByName('PayInc6').AsFloat;
end;

procedure TClslstBtr.WritePayInc6(pValue:double);
begin
  oBtrTable.FieldByName('PayInc6').AsFloat := pValue;
end;

function TClslstBtr.ReadPayOut6:double;
begin
  Result := oBtrTable.FieldByName('PayOut6').AsFloat;
end;

procedure TClslstBtr.WritePayOut6(pValue:double);
begin
  oBtrTable.FieldByName('PayOut6').AsFloat := pValue;
end;

function TClslstBtr.ReadPayTrn6:double;
begin
  Result := oBtrTable.FieldByName('PayTrn6').AsFloat;
end;

procedure TClslstBtr.WritePayTrn6(pValue:double);
begin
  oBtrTable.FieldByName('PayTrn6').AsFloat := pValue;
end;

function TClslstBtr.ReadPayNum7:word;
begin
  Result := oBtrTable.FieldByName('PayNum7').AsInteger;
end;

procedure TClslstBtr.WritePayNum7(pValue:word);
begin
  oBtrTable.FieldByName('PayNum7').AsInteger := pValue;
end;

function TClslstBtr.ReadPayNam7:Str30;
begin
  Result := oBtrTable.FieldByName('PayNam7').AsString;
end;

procedure TClslstBtr.WritePayNam7(pValue:Str30);
begin
  oBtrTable.FieldByName('PayNam7').AsString := pValue;
end;

function TClslstBtr.ReadPayInc7:double;
begin
  Result := oBtrTable.FieldByName('PayInc7').AsFloat;
end;

procedure TClslstBtr.WritePayInc7(pValue:double);
begin
  oBtrTable.FieldByName('PayInc7').AsFloat := pValue;
end;

function TClslstBtr.ReadPayOut7:double;
begin
  Result := oBtrTable.FieldByName('PayOut7').AsFloat;
end;

procedure TClslstBtr.WritePayOut7(pValue:double);
begin
  oBtrTable.FieldByName('PayOut7').AsFloat := pValue;
end;

function TClslstBtr.ReadPayTrn7:double;
begin
  Result := oBtrTable.FieldByName('PayTrn7').AsFloat;
end;

procedure TClslstBtr.WritePayTrn7(pValue:double);
begin
  oBtrTable.FieldByName('PayTrn7').AsFloat := pValue;
end;

function TClslstBtr.ReadPayNum8:word;
begin
  Result := oBtrTable.FieldByName('PayNum8').AsInteger;
end;

procedure TClslstBtr.WritePayNum8(pValue:word);
begin
  oBtrTable.FieldByName('PayNum8').AsInteger := pValue;
end;

function TClslstBtr.ReadPayNam8:Str30;
begin
  Result := oBtrTable.FieldByName('PayNam8').AsString;
end;

procedure TClslstBtr.WritePayNam8(pValue:Str30);
begin
  oBtrTable.FieldByName('PayNam8').AsString := pValue;
end;

function TClslstBtr.ReadPayInc8:double;
begin
  Result := oBtrTable.FieldByName('PayInc8').AsFloat;
end;

procedure TClslstBtr.WritePayInc8(pValue:double);
begin
  oBtrTable.FieldByName('PayInc8').AsFloat := pValue;
end;

function TClslstBtr.ReadPayOut8:double;
begin
  Result := oBtrTable.FieldByName('PayOut8').AsFloat;
end;

procedure TClslstBtr.WritePayOut8(pValue:double);
begin
  oBtrTable.FieldByName('PayOut8').AsFloat := pValue;
end;

function TClslstBtr.ReadPayTrn8:double;
begin
  Result := oBtrTable.FieldByName('PayTrn8').AsFloat;
end;

procedure TClslstBtr.WritePayTrn8(pValue:double);
begin
  oBtrTable.FieldByName('PayTrn8').AsFloat := pValue;
end;

function TClslstBtr.ReadPayNum9:word;
begin
  Result := oBtrTable.FieldByName('PayNum9').AsInteger;
end;

procedure TClslstBtr.WritePayNum9(pValue:word);
begin
  oBtrTable.FieldByName('PayNum9').AsInteger := pValue;
end;

function TClslstBtr.ReadPayNam9:Str30;
begin
  Result := oBtrTable.FieldByName('PayNam9').AsString;
end;

procedure TClslstBtr.WritePayNam9(pValue:Str30);
begin
  oBtrTable.FieldByName('PayNam9').AsString := pValue;
end;

function TClslstBtr.ReadPayInc9:double;
begin
  Result := oBtrTable.FieldByName('PayInc9').AsFloat;
end;

procedure TClslstBtr.WritePayInc9(pValue:double);
begin
  oBtrTable.FieldByName('PayInc9').AsFloat := pValue;
end;

function TClslstBtr.ReadPayOut9:double;
begin
  Result := oBtrTable.FieldByName('PayOut9').AsFloat;
end;

procedure TClslstBtr.WritePayOut9(pValue:double);
begin
  oBtrTable.FieldByName('PayOut9').AsFloat := pValue;
end;

function TClslstBtr.ReadPayTrn9:double;
begin
  Result := oBtrTable.FieldByName('PayTrn9').AsFloat;
end;

procedure TClslstBtr.WritePayTrn9(pValue:double);
begin
  oBtrTable.FieldByName('PayTrn9').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TClslstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TClslstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TClslstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TClslstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TClslstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TClslstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TClslstBtr.LocateWrCaCl (pWriNum:longint;pCasNum:longint;pClsNum:longint):boolean;
begin
  SetIndex (ixWrCaCl);
  Result := oBtrTable.FindKey([pWriNum,pCasNum,pClsNum]);
end;

function TClslstBtr.LocateCaCl (pCasNum:longint;pClsNum:longint):boolean;
begin
  SetIndex (ixCaCl);
  Result := oBtrTable.FindKey([pCasNum,pClsNum]);
end;

function TClslstBtr.LocateCdCt (pClsDat:TDatetime;pClsTim:TDatetime):boolean;
begin
  SetIndex (ixCdCt);
  Result := oBtrTable.FindKey([pClsDat,pClsTim]);
end;

function TClslstBtr.NearestWrCaCl (pWriNum:longint;pCasNum:longint;pClsNum:longint):boolean;
begin
  SetIndex (ixWrCaCl);
  Result := oBtrTable.FindNearest([pWriNum,pCasNum,pClsNum]);
end;

function TClslstBtr.NearestCaCl (pCasNum:longint;pClsNum:longint):boolean;
begin
  SetIndex (ixCaCl);
  Result := oBtrTable.FindNearest([pCasNum,pClsNum]);
end;

function TClslstBtr.NearestCdCt (pClsDat:TDatetime;pClsTim:TDatetime):boolean;
begin
  SetIndex (ixCdCt);
  Result := oBtrTable.FindNearest([pClsDat,pClsTim]);
end;

procedure TClslstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TClslstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TClslstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TClslstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TClslstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TClslstBtr.First;
begin
  oBtrTable.First;
end;

procedure TClslstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TClslstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TClslstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TClslstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TClslstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TClslstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TClslstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TClslstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TClslstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TClslstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TClslstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
