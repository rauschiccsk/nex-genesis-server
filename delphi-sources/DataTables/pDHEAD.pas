unit pDHEAD;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = 'DocNum';

type
  TDheadTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;               procedure WriteDocNum (pValue:Str12);
    function  ReadSerNum:longint;             procedure WriteSerNum (pValue:longint);
    function  ReadStkNum:word;                procedure WriteStkNum (pValue:word);
    function  ReadStkName:Str30;              procedure WriteStkName (pValue:Str30);
    function  ReadDocName:Str20;              procedure WriteDocName (pValue:Str20);
    function  ReadPaCode:longint;             procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;               procedure WritePaName (pValue:Str30);
    function  ReadRegName:Str60;              procedure WriteRegName (pValue:Str60);
    function  ReadOldTin:Str15;               procedure WriteOldTin (pValue:Str15);
    function  ReadRegIno:Str15;               procedure WriteRegIno (pValue:Str15);
    function  ReadRegTin:Str15;               procedure WriteRegTin (pValue:Str15);
    function  ReadRegVin:Str15;               procedure WriteRegVin (pValue:Str15);
    function  ReadRegAddr:Str30;              procedure WriteRegAddr (pValue:Str30);
    function  ReadRegCty:Str3;                procedure WriteRegCty (pValue:Str3);
    function  ReadRegCtn:Str30;               procedure WriteRegCtn (pValue:Str30);
    function  ReadRegZip:Str15;               procedure WriteRegZip (pValue:Str15);
    function  ReadRegSta:Str2;                procedure WriteRegSta (pValue:Str2);
    function  ReadRegStn:Str30;               procedure WriteRegStn (pValue:Str30);
    function  ReadRegRec:Str60;               procedure WriteRegRec (pValue:Str60);
    function  ReadHedName:Str30;              procedure WriteHedName (pValue:Str30);
    function  ReadWpaStn:Str30;               procedure WriteWpaStn (pValue:Str30);
    function  ReadIdCode:Str20;               procedure WriteIdCode (pValue:Str20);
    function  ReadRspName:Str30;              procedure WriteRspName (pValue:Str30);
    function  ReadCrtName:Str30;              procedure WriteCrtName (pValue:Str30);
    function  ReadAccName:Str30;              procedure WriteAccName (pValue:Str30);
    function  ReadPayName:Str30;              procedure WritePayName (pValue:Str30);
    function  ReadBankName:Str30;             procedure WriteBankName (pValue:Str30);
    function  ReadDate1:TDatetime;            procedure WriteDate1 (pValue:TDatetime);
    function  ReadDate2:TDatetime;            procedure WriteDate2 (pValue:TDatetime);
    function  ReadCode1:longint;              procedure WriteCode1 (pValue:longint);
    function  ReadCode2:longint;              procedure WriteCode2 (pValue:longint);
    function  ReadCode:longint;               procedure WriteCode (pValue:longint);
    function  ReadName:Str30;                 procedure WriteName (pValue:Str30);
    function  ReadText:Str60;                 procedure WriteText (pValue:Str60);
    function  ReadInfo:Str60;                 procedure WriteInfo (pValue:Str60);
    function  ReadTxtVal:Str80;               procedure WriteTxtVal (pValue:Str80);
    function  ReadFgVatVal1:double;           procedure WriteFgVatVal1 (pValue:double);
    function  ReadFgVatVal2:double;           procedure WriteFgVatVal2 (pValue:double);
    function  ReadFgVatVal3:double;           procedure WriteFgVatVal3 (pValue:double);
    function  ReadFgBValue:double;            procedure WriteFgBValue (pValue:double);
    function  ReadFgRndVal:double;            procedure WriteFgRndVal (pValue:double);
    function  ReadFgPaySum:double;            procedure WriteFgPaySum (pValue:double);
    function  ReadFgEndSum:double;            procedure WriteFgEndSum (pValue:double);
    function  ReadDscPrc1:double;             procedure WriteDscPrc1 (pValue:double);
    function  ReadDscPrc2:double;             procedure WriteDscPrc2 (pValue:double);
    function  ReadDscVal1:double;             procedure WriteDscVal1 (pValue:double);
    function  ReadDscVal2:double;             procedure WriteDscVal2 (pValue:double);
    function  ReadEndVal1:double;             procedure WriteEndVal1 (pValue:double);
    function  ReadEndVal2:double;             procedure WriteEndVal2 (pValue:double);
    function  ReadSpAValue:double;            procedure WriteSpAValue (pValue:double);
    function  ReadSpBValue:double;            procedure WriteSpBValue (pValue:double);
    function  ReadSpVatValue:double;          procedure WriteSpVatValue (pValue:double);
    function  ReadNSpAValue:double;           procedure WriteNSpAValue (pValue:double);
    function  ReadNSpBValue:double;           procedure WriteNSpBValue (pValue:double);
    function  ReadNSpVatValue:double;         procedure WriteNSpVatValue (pValue:double);
    function  ReadAccSnt(Index:byte):Str3;    procedure WriteAccSnt (Index:byte;pValue:Str3);
    function  ReadAccAnl(Index:byte):Str6;    procedure WriteAccAnl (Index:byte;pValue:Str6);
    function  ReadCrdVal(Index:byte):double;  procedure WriteCrdVal (Index:byte;pValue:double);
    function  ReadDebVal(Index:byte):double;  procedure WriteDebVal (Index:byte;pValue:double);
    function  ReadSCrdVal(Index:byte):Str16;  procedure WriteSCrdVal (Index:byte;pValue:Str16);
    function  ReadSDebVal(Index:byte):Str16;  procedure WriteSDebVal (Index:byte;pValue:Str16);
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
    procedure Post;
    procedure Delete;
    procedure SwapIndex;
    procedure RestoreIndex;

    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read ReadCount;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property StkName:Str30 read ReadStkName write WriteStkName;
    property DocName:Str20 read ReadDocName write WriteDocName;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property RegName:Str60 read ReadRegName write WriteRegName;
    property OldTin:Str15 read ReadOldTin write WriteOldTin;
    property RegIno:Str15 read ReadRegIno write WriteRegIno;
    property RegTin:Str15 read ReadRegTin write WriteRegTin;
    property RegVin:Str15 read ReadRegVin write WriteRegVin;
    property RegAddr:Str30 read ReadRegAddr write WriteRegAddr;
    property RegCty:Str3 read ReadRegCty write WriteRegCty;
    property RegCtn:Str30 read ReadRegCtn write WriteRegCtn;
    property RegZip:Str15 read ReadRegZip write WriteRegZip;
    property RegSta:Str2 read ReadRegSta write WriteRegSta;
    property RegStn:Str30 read ReadRegStn write WriteRegStn;
    property RegRec:Str60 read ReadRegRec write WriteRegRec;
    property HedName:Str30 read ReadHedName write WriteHedName;
    property WpaStn:Str30 read ReadWpaStn write WriteWpaStn;
    property IdCode:Str20 read ReadIdCode write WriteIdCode;
    property RspName:Str30 read ReadRspName write WriteRspName;
    property CrtName:Str30 read ReadCrtName write WriteCrtName;
    property AccName:Str30 read ReadAccName write WriteAccName;
    property PayName:Str30 read ReadPayName write WritePayName;
    property BankName:Str30 read ReadBankName write WriteBankName;
    property Date1:TDatetime read ReadDate1 write WriteDate1;
    property Date2:TDatetime read ReadDate2 write WriteDate2;
    property Code1:longint read ReadCode1 write WriteCode1;
    property Code2:longint read ReadCode2 write WriteCode2;
    property Code:longint read ReadCode write WriteCode;
    property Name:Str30 read ReadName write WriteName;
    property Text:Str60 read ReadText write WriteText;
    property Info:Str60 read ReadInfo write WriteInfo;
    property TxtVal:Str80 read ReadTxtVal write WriteTxtVal;
    property FgVatVal1:double read ReadFgVatVal1 write WriteFgVatVal1;
    property FgVatVal2:double read ReadFgVatVal2 write WriteFgVatVal2;
    property FgVatVal3:double read ReadFgVatVal3 write WriteFgVatVal3;
    property FgBValue:double read ReadFgBValue write WriteFgBValue;
    property FgRndVal:double read ReadFgRndVal write WriteFgRndVal;
    property FgPaySum:double read ReadFgPaySum write WriteFgPaySum;
    property FgEndSum:double read ReadFgEndSum write WriteFgEndSum;
    property DscPrc1:double read ReadDscPrc1 write WriteDscPrc1;
    property DscPrc2:double read ReadDscPrc2 write WriteDscPrc2;
    property DscVal1:double read ReadDscVal1 write WriteDscVal1;
    property DscVal2:double read ReadDscVal2 write WriteDscVal2;
    property EndVal1:double read ReadEndVal1 write WriteEndVal1;
    property EndVal2:double read ReadEndVal2 write WriteEndVal2;
    property SpAValue:double read ReadSpAValue write WriteSpAValue;
    property SpBValue:double read ReadSpBValue write WriteSpBValue;
    property SpVatValue:double read ReadSpVatValue write WriteSpVatValue;
    property NSpAValue:double read ReadNSpAValue write WriteNSpAValue;
    property NSpBValue:double read ReadNSpBValue write WriteNSpBValue;
    property NSpVatValue:double read ReadNSpVatValue write WriteNSpVatValue;

    property AccSnt[Index:byte]:Str3 read ReadAccSnt write WriteAccSnt;
    property AccAnl[Index:byte]:Str6 read ReadAccAnl write WriteAccAnl;
    property CrdVal[Index:byte]:double read ReadCrdVal write WriteCrdVal;
    property DebVal[Index:byte]:double read ReadDebVal write WriteDebVal;
    property SCrdVal[Index:byte]:Str16 read ReadSCrdVal write WriteSCrdVal;
    property SDebVal[Index:byte]:Str16 read ReadSDebVal write WriteSDebVal;
  end;

implementation

constructor TDheadTmp.Create;
begin
  oTmpTable := TmpInit ('DHEAD',Self);
end;

destructor  TDheadTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TDheadTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TDheadTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TDheadTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TDheadTmp.ReadSerNum:longint;
begin
  Result := oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TDheadTmp.WriteSerNum(pValue:longint);
begin
  oTmpTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TDheadTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TDheadTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TDheadTmp.ReadStkName:Str30;
begin
  Result := oTmpTable.FieldByName('StkName').AsString;
end;

procedure TDheadTmp.WriteStkName(pValue:Str30);
begin
  oTmpTable.FieldByName('StkName').AsString := pValue;
end;

function TDheadTmp.ReadDocName:Str20;
begin
  Result := oTmpTable.FieldByName('DocName').AsString;
end;

procedure TDheadTmp.WriteDocName(pValue:Str20);
begin
  oTmpTable.FieldByName('DocName').AsString := pValue;
end;

function TDheadTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TDheadTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TDheadTmp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TDheadTmp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TDheadTmp.ReadRegName:Str60;
begin
  Result := oTmpTable.FieldByName('RegName').AsString;
end;

procedure TDheadTmp.WriteRegName(pValue:Str60);
begin
  oTmpTable.FieldByName('RegName').AsString := pValue;
end;

function TDheadTmp.ReadOldTin:Str15;
begin
  Result := oTmpTable.FieldByName('OldTin').AsString;
end;

procedure TDheadTmp.WriteOldTin(pValue:Str15);
begin
  oTmpTable.FieldByName('OldTin').AsString := pValue;
end;

function TDheadTmp.ReadRegIno:Str15;
begin
  Result := oTmpTable.FieldByName('RegIno').AsString;
end;

procedure TDheadTmp.WriteRegIno(pValue:Str15);
begin
  oTmpTable.FieldByName('RegIno').AsString := pValue;
end;

function TDheadTmp.ReadRegTin:Str15;
begin
  Result := oTmpTable.FieldByName('RegTin').AsString;
end;

procedure TDheadTmp.WriteRegTin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegTin').AsString := pValue;
end;

function TDheadTmp.ReadRegVin:Str15;
begin
  Result := oTmpTable.FieldByName('RegVin').AsString;
end;

procedure TDheadTmp.WriteRegVin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegVin').AsString := pValue;
end;

function TDheadTmp.ReadRegAddr:Str30;
begin
  Result := oTmpTable.FieldByName('RegAddr').AsString;
end;

procedure TDheadTmp.WriteRegAddr(pValue:Str30);
begin
  oTmpTable.FieldByName('RegAddr').AsString := pValue;
end;

function TDheadTmp.ReadRegCty:Str3;
begin
  Result := oTmpTable.FieldByName('RegCty').AsString;
end;

procedure TDheadTmp.WriteRegCty(pValue:Str3);
begin
  oTmpTable.FieldByName('RegCty').AsString := pValue;
end;

function TDheadTmp.ReadRegCtn:Str30;
begin
  Result := oTmpTable.FieldByName('RegCtn').AsString;
end;

procedure TDheadTmp.WriteRegCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('RegCtn').AsString := pValue;
end;

function TDheadTmp.ReadRegZip:Str15;
begin
  Result := oTmpTable.FieldByName('RegZip').AsString;
end;

procedure TDheadTmp.WriteRegZip(pValue:Str15);
begin
  oTmpTable.FieldByName('RegZip').AsString := pValue;
end;

function TDheadTmp.ReadRegSta:Str2;
begin
  Result := oTmpTable.FieldByName('RegSta').AsString;
end;

procedure TDheadTmp.WriteRegSta(pValue:Str2);
begin
  oTmpTable.FieldByName('RegSta').AsString := pValue;
end;

function TDheadTmp.ReadRegStn:Str30;
begin
  Result := oTmpTable.FieldByName('RegStn').AsString;
end;

procedure TDheadTmp.WriteRegStn(pValue:Str30);
begin
  oTmpTable.FieldByName('RegStn').AsString := pValue;
end;

function TDheadTmp.ReadRegRec:Str60;
begin
  Result := oTmpTable.FieldByName('RegRec').AsString;
end;

procedure TDheadTmp.WriteRegRec(pValue:Str60);
begin
  oTmpTable.FieldByName('RegRec').AsString := pValue;
end;

function TDheadTmp.ReadHedName:Str30;
begin
  Result := oTmpTable.FieldByName('HedName').AsString;
end;

procedure TDheadTmp.WriteHedName(pValue:Str30);
begin
  oTmpTable.FieldByName('HedName').AsString := pValue;
end;

function TDheadTmp.ReadWpaStn:Str30;
begin
  Result := oTmpTable.FieldByName('WpaStn').AsString;
end;

procedure TDheadTmp.WriteWpaStn(pValue:Str30);
begin
  oTmpTable.FieldByName('WpaStn').AsString := pValue;
end;

function TDheadTmp.ReadIdCode:Str20;
begin
  Result := oTmpTable.FieldByName('IdCode').AsString;
end;

procedure TDheadTmp.WriteIdCode(pValue:Str20);
begin
  oTmpTable.FieldByName('IdCode').AsString := pValue;
end;

function TDheadTmp.ReadRspName:Str30;
begin
  Result := oTmpTable.FieldByName('RspName').AsString;
end;

procedure TDheadTmp.WriteRspName(pValue:Str30);
begin
  oTmpTable.FieldByName('RspName').AsString := pValue;
end;

function TDheadTmp.ReadCrtName:Str30;
begin
  Result := oTmpTable.FieldByName('CrtName').AsString;
end;

procedure TDheadTmp.WriteCrtName(pValue:Str30);
begin
  oTmpTable.FieldByName('CrtName').AsString := pValue;
end;

function TDheadTmp.ReadAccName:Str30;
begin
  Result := oTmpTable.FieldByName('AccName').AsString;
end;

procedure TDheadTmp.WriteAccName(pValue:Str30);
begin
  oTmpTable.FieldByName('AccName').AsString := pValue;
end;

function TDheadTmp.ReadPayName:Str30;
begin
  Result := oTmpTable.FieldByName('PayName').AsString;
end;

procedure TDheadTmp.WritePayName(pValue:Str30);
begin
  oTmpTable.FieldByName('PayName').AsString := pValue;
end;

function TDheadTmp.ReadBankName:Str30;
begin
  Result := oTmpTable.FieldByName('BankName').AsString;
end;

procedure TDheadTmp.WriteBankName(pValue:Str30);
begin
  oTmpTable.FieldByName('BankName').AsString := pValue;
end;

function TDheadTmp.ReadDate1:TDatetime;
begin
  Result := oTmpTable.FieldByName('Date1').AsDateTime;
end;

procedure TDheadTmp.WriteDate1(pValue:TDatetime);
begin
  oTmpTable.FieldByName('Date1').AsDateTime := pValue;
end;

function TDheadTmp.ReadDate2:TDatetime;
begin
  Result := oTmpTable.FieldByName('Date2').AsDateTime;
end;

procedure TDheadTmp.WriteDate2(pValue:TDatetime);
begin
  oTmpTable.FieldByName('Date2').AsDateTime := pValue;
end;

function TDheadTmp.ReadCode1:longint;
begin
  Result := oTmpTable.FieldByName('Code1').AsInteger;
end;

procedure TDheadTmp.WriteCode1(pValue:longint);
begin
  oTmpTable.FieldByName('Code1').AsInteger := pValue;
end;

function TDheadTmp.ReadCode2:longint;
begin
  Result := oTmpTable.FieldByName('Code2').AsInteger;
end;

procedure TDheadTmp.WriteCode2(pValue:longint);
begin
  oTmpTable.FieldByName('Code2').AsInteger := pValue;
end;

function TDheadTmp.ReadCode:longint;
begin
  Result := oTmpTable.FieldByName('Code').AsInteger;
end;

procedure TDheadTmp.WriteCode(pValue:longint);
begin
  oTmpTable.FieldByName('Code').AsInteger := pValue;
end;

function TDheadTmp.ReadName:Str30;
begin
  Result := oTmpTable.FieldByName('Name').AsString;
end;

procedure TDheadTmp.WriteName(pValue:Str30);
begin
  oTmpTable.FieldByName('Name').AsString := pValue;
end;

function TDheadTmp.ReadText:Str60;
begin
  Result := oTmpTable.FieldByName('Text').AsString;
end;

procedure TDheadTmp.WriteText(pValue:Str60);
begin
  oTmpTable.FieldByName('Text').AsString := pValue;
end;

function TDheadTmp.ReadInfo:Str60;
begin
  Result := oTmpTable.FieldByName('Info').AsString;
end;

procedure TDheadTmp.WriteInfo(pValue:Str60);
begin
  oTmpTable.FieldByName('Info').AsString := pValue;
end;

function TDheadTmp.ReadTxtVal:Str80;
begin
  Result := oTmpTable.FieldByName('TxtVal').AsString;
end;

procedure TDheadTmp.WriteTxtVal(pValue:Str80);
begin
  oTmpTable.FieldByName('TxtVal').AsString := pValue;
end;

function TDheadTmp.ReadFgVatVal1:double;
begin
  Result := oTmpTable.FieldByName('FgVatVal1').AsFloat;
end;

procedure TDheadTmp.WriteFgVatVal1(pValue:double);
begin
  oTmpTable.FieldByName('FgVatVal1').AsFloat := pValue;
end;

function TDheadTmp.ReadFgVatVal2:double;
begin
  Result := oTmpTable.FieldByName('FgVatVal2').AsFloat;
end;

procedure TDheadTmp.WriteFgVatVal2(pValue:double);
begin
  oTmpTable.FieldByName('FgVatVal2').AsFloat := pValue;
end;

function TDheadTmp.ReadFgVatVal3:double;
begin
  Result := oTmpTable.FieldByName('FgVatVal3').AsFloat;
end;

procedure TDheadTmp.WriteFgVatVal3(pValue:double);
begin
  oTmpTable.FieldByName('FgVatVal3').AsFloat := pValue;
end;

function TDheadTmp.ReadFgBValue:double;
begin
  Result := oTmpTable.FieldByName('FgBValue').AsFloat;
end;

procedure TDheadTmp.WriteFgBValue(pValue:double);
begin
  oTmpTable.FieldByName('FgBValue').AsFloat := pValue;
end;

function TDheadTmp.ReadFgRndVal:double;
begin
  Result := oTmpTable.FieldByName('FgRndVal').AsFloat;
end;

procedure TDheadTmp.WriteFgRndVal(pValue:double);
begin
  oTmpTable.FieldByName('FgRndVal').AsFloat := pValue;
end;

function TDheadTmp.ReadFgPaySum:double;
begin
  Result := oTmpTable.FieldByName('FgPaySum').AsFloat;
end;

procedure TDheadTmp.WriteFgPaySum(pValue:double);
begin
  oTmpTable.FieldByName('FgPaySum').AsFloat := pValue;
end;

function TDheadTmp.ReadFgEndSum:double;
begin
  Result := oTmpTable.FieldByName('FgEndSum').AsFloat;
end;

procedure TDheadTmp.WriteFgEndSum(pValue:double);
begin
  oTmpTable.FieldByName('FgEndSum').AsFloat := pValue;
end;

function TDheadTmp.ReadDscPrc1:double;
begin
  Result := oTmpTable.FieldByName('DscPrc1').AsFloat;
end;

procedure TDheadTmp.WriteDscPrc1(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc1').AsFloat := pValue;
end;

function TDheadTmp.ReadDscPrc2:double;
begin
  Result := oTmpTable.FieldByName('DscPrc2').AsFloat;
end;

procedure TDheadTmp.WriteDscPrc2(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc2').AsFloat := pValue;
end;

function TDheadTmp.ReadDscVal1:double;
begin
  Result := oTmpTable.FieldByName('DscVal1').AsFloat;
end;

procedure TDheadTmp.WriteDscVal1(pValue:double);
begin
  oTmpTable.FieldByName('DscVal1').AsFloat := pValue;
end;

function TDheadTmp.ReadDscVal2:double;
begin
  Result := oTmpTable.FieldByName('DscVal2').AsFloat;
end;

procedure TDheadTmp.WriteDscVal2(pValue:double);
begin
  oTmpTable.FieldByName('DscVal2').AsFloat := pValue;
end;

function TDheadTmp.ReadEndVal1:double;
begin
  Result := oTmpTable.FieldByName('EndVal1').AsFloat;
end;

procedure TDheadTmp.WriteEndVal1(pValue:double);
begin
  oTmpTable.FieldByName('EndVal1').AsFloat := pValue;
end;

function TDheadTmp.ReadEndVal2:double;
begin
  Result := oTmpTable.FieldByName('EndVal2').AsFloat;
end;

procedure TDheadTmp.WriteEndVal2(pValue:double);
begin
  oTmpTable.FieldByName('EndVal2').AsFloat := pValue;
end;

function TDheadTmp.ReadAccSnt(Index:byte):Str3;
begin
  Result := oTmpTable.FieldByName('AccSnt'+StrInt(Index,0)).AsString;
end;

procedure TDheadTmp.WriteAccSnt(Index:byte;pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt'+StrInt(Index,0)).AsString := pValue;
end;

function TDheadTmp.ReadAccAnl(Index:byte):Str6;
begin
  Result := oTmpTable.FieldByName('AccAnl'+StrInt(Index,0)).AsString;
end;

procedure TDheadTmp.WriteAccAnl(Index:byte;pValue:Str6);
begin
  oTmpTable.FieldByName('AccAnl'+StrInt(Index,0)).AsString := pValue;
end;

function TDheadTmp.ReadCrdVal(Index:byte):double;
begin
  Result := oTmpTable.FieldByName('CrdVal'+StrInt(Index,0)).AsFloat;
end;

procedure TDheadTmp.WriteCrdVal(Index:byte;pValue:double);
begin
  oTmpTable.FieldByName('CrdVal'+StrInt(Index,0)).AsFloat := pValue;
end;

function TDheadTmp.ReadDebVal(Index:byte):double;
begin
  Result := oTmpTable.FieldByName('DebVal'+StrInt(Index,0)).AsFloat;
end;

procedure TDheadTmp.WriteDebVal(Index:byte;pValue:double);
begin
  oTmpTable.FieldByName('DebVal'+StrInt(Index,0)).AsFloat := pValue;
end;

function TDheadTmp.ReadSCrdVal(Index:byte):Str16;
begin
  Result := oTmpTable.FieldByName('SCrdVal'+StrInt(Index,0)).AsString;
end;

procedure TDheadTmp.WriteSCrdVal(Index:byte;pValue:Str16);
begin
  oTmpTable.FieldByName('SCrdVal'+StrInt(Index,0)).AsString := pValue;
end;

function TDheadTmp.ReadSDebVal(Index:byte):Str16;
begin
  Result := oTmpTable.FieldByName('SDebVal'+StrInt(Index,0)).AsString;
end;

procedure TDheadTmp.WriteSDebVal(Index:byte;pValue:Str16);
begin
  oTmpTable.FieldByName('SDebVal'+StrInt(Index,0)).AsString := pValue;
end;

function TDheadTmp.ReadSpAValue:double;
begin
  Result := oTmpTable.FieldByName('SpAValue').AsFloat;
end;

procedure TDheadTmp.WriteSpAValue(pValue:double);
begin
  oTmpTable.FieldByName('SpAValue').AsFloat := pValue;
end;

function TDheadTmp.ReadSpBValue:double;
begin
  Result := oTmpTable.FieldByName('SpBValue').AsFloat;
end;

procedure TDheadTmp.WriteSpBValue(pValue:double);
begin
  oTmpTable.FieldByName('SpBValue').AsFloat := pValue;
end;

function TDheadTmp.ReadSpVatValue:double;
begin
  Result := oTmpTable.FieldByName('SpVatValue').AsFloat;
end;

procedure TDheadTmp.WriteSpVatValue(pValue:double);
begin
  oTmpTable.FieldByName('SpVatValue').AsFloat := pValue;
end;

function TDheadTmp.ReadNSpAValue:double;
begin
  Result := oTmpTable.FieldByName('NSpAValue').AsFloat;
end;

procedure TDheadTmp.WriteNSpAValue(pValue:double);
begin
  oTmpTable.FieldByName('NSpAValue').AsFloat := pValue;
end;

function TDheadTmp.ReadNSpBValue:double;
begin
  Result := oTmpTable.FieldByName('NSpBValue').AsFloat;
end;

procedure TDheadTmp.WriteNSpBValue(pValue:double);
begin
  oTmpTable.FieldByName('NSpBValue').AsFloat := pValue;
end;

function TDheadTmp.ReadNSpVatValue:double;
begin
  Result := oTmpTable.FieldByName('NSpVatValue').AsFloat;
end;

procedure TDheadTmp.WriteNSpVatValue(pValue:double);
begin
  oTmpTable.FieldByName('NSpVatValue').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TDheadTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TDheadTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TDheadTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

procedure TDheadTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TDheadTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TDheadTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TDheadTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TDheadTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TDheadTmp.First;
begin
  oTmpTable.First;
end;

procedure TDheadTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TDheadTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TDheadTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TDheadTmp.Post;
begin
  oTmpTable.Post;
end;

procedure TDheadTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TDheadTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TDheadTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

end.
