unit tDHEAD;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = '';

type
  TDheadTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadStkName:Str30;         procedure WriteStkName (pValue:Str30);
    function  ReadDocName:Str20;         procedure WriteDocName (pValue:Str20);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadRegName:Str60;         procedure WriteRegName (pValue:Str60);
    function  ReadOldTin:Str15;          procedure WriteOldTin (pValue:Str15);
    function  ReadRegIno:Str15;          procedure WriteRegIno (pValue:Str15);
    function  ReadRegTin:Str15;          procedure WriteRegTin (pValue:Str15);
    function  ReadRegVin:Str15;          procedure WriteRegVin (pValue:Str15);
    function  ReadRegAddr:Str30;         procedure WriteRegAddr (pValue:Str30);
    function  ReadRegCty:Str3;           procedure WriteRegCty (pValue:Str3);
    function  ReadRegCtn:Str30;          procedure WriteRegCtn (pValue:Str30);
    function  ReadRegZip:Str15;          procedure WriteRegZip (pValue:Str15);
    function  ReadRegSta:Str2;           procedure WriteRegSta (pValue:Str2);
    function  ReadRegStn:Str30;          procedure WriteRegStn (pValue:Str30);
    function  ReadRegRec:Str60;          procedure WriteRegRec (pValue:Str60);
    function  ReadHedName:Str30;         procedure WriteHedName (pValue:Str30);
    function  ReadWpaStn:Str30;          procedure WriteWpaStn (pValue:Str30);
    function  ReadIdCode:Str20;          procedure WriteIdCode (pValue:Str20);
    function  ReadRspName:Str30;         procedure WriteRspName (pValue:Str30);
    function  ReadCrtName:Str30;         procedure WriteCrtName (pValue:Str30);
    function  ReadAccName:Str30;         procedure WriteAccName (pValue:Str30);
    function  ReadPayName:Str30;         procedure WritePayName (pValue:Str30);
    function  ReadBankName:Str30;        procedure WriteBankName (pValue:Str30);
    function  ReadSwftCode:Str30;        procedure WriteSwftCode (pValue:Str30);
    function  ReadOwnIno:Str15;          procedure WriteOwnIno (pValue:Str15);
    function  ReadOwnTin:Str15;          procedure WriteOwnTin (pValue:Str15);
    function  ReadOwnVin:Str15;          procedure WriteOwnVin (pValue:Str15);
    function  ReadOwnName:Str60;         procedure WriteOwnName (pValue:Str60);
    function  ReadOwnAddr:Str30;         procedure WriteOwnAddr (pValue:Str30);
    function  ReadOwnSta:Str2;           procedure WriteOwnSta (pValue:Str2);
    function  ReadOwnStn:Str30;          procedure WriteOwnStn (pValue:Str30);
    function  ReadOwnCty:Str3;           procedure WriteOwnCty (pValue:Str3);
    function  ReadOwnCtn:Str30;          procedure WriteOwnCtn (pValue:Str30);
    function  ReadOwnZip:Str10;          procedure WriteOwnZip (pValue:Str10);
    function  ReadOwnWeb:Str30;          procedure WriteOwnWeb (pValue:Str30);
    function  ReadOwnTel:Str20;          procedure WriteOwnTel (pValue:Str20);
    function  ReadOwnFax:Str20;          procedure WriteOwnFax (pValue:Str20);
    function  ReadOwnEml:Str30;          procedure WriteOwnEml (pValue:Str30);
    function  ReadOwnReg:Str90;          procedure WriteOwnReg (pValue:Str90);
    function  ReadSerNum1:longint;       procedure WriteSerNum1 (pValue:longint);
    function  ReadSerNum2:longint;       procedure WriteSerNum2 (pValue:longint);
    function  ReadCrtDate1:TDatetime;    procedure WriteCrtDate1 (pValue:TDatetime);
    function  ReadCrtDate2:TDatetime;    procedure WriteCrtDate2 (pValue:TDatetime);
    function  ReadDate1:TDatetime;       procedure WriteDate1 (pValue:TDatetime);
    function  ReadDate2:TDatetime;       procedure WriteDate2 (pValue:TDatetime);
    function  ReadCode1:longint;         procedure WriteCode1 (pValue:longint);
    function  ReadCode2:longint;         procedure WriteCode2 (pValue:longint);
    function  ReadCode:longint;          procedure WriteCode (pValue:longint);
    function  ReadName:Str30;            procedure WriteName (pValue:Str30);
    function  ReadText:Str60;            procedure WriteText (pValue:Str60);
    function  ReadInfo:Str60;            procedure WriteInfo (pValue:Str60);
    function  ReadSpMark:Str10;          procedure WriteSpMark (pValue:Str10);
    function  ReadTxtVal:Str80;          procedure WriteTxtVal (pValue:Str80);
    function  ReadVatCls:word;           procedure WriteVatCls (pValue:word);
    function  ReadFgVatVal1:double;      procedure WriteFgVatVal1 (pValue:double);
    function  ReadFgVatVal2:double;      procedure WriteFgVatVal2 (pValue:double);
    function  ReadFgVatVal3:double;      procedure WriteFgVatVal3 (pValue:double);
    function  ReadFgBValue:double;       procedure WriteFgBValue (pValue:double);
    function  ReadFgRndVal:double;       procedure WriteFgRndVal (pValue:double);
    function  ReadFgPaySum:double;       procedure WriteFgPaySum (pValue:double);
    function  ReadFgEndSum:double;       procedure WriteFgEndSum (pValue:double);
    function  ReadDscPrc1:double;        procedure WriteDscPrc1 (pValue:double);
    function  ReadDscPrc2:double;        procedure WriteDscPrc2 (pValue:double);
    function  ReadDscVal1:double;        procedure WriteDscVal1 (pValue:double);
    function  ReadDscVal2:double;        procedure WriteDscVal2 (pValue:double);
    function  ReadEndVal1:double;        procedure WriteEndVal1 (pValue:double);
    function  ReadEndVal2:double;        procedure WriteEndVal2 (pValue:double);
    function  ReadAccSnt1:Str3;          procedure WriteAccSnt1 (pValue:Str3);
    function  ReadAccAnl1:Str6;          procedure WriteAccAnl1 (pValue:Str6);
    function  ReadCredVal1:double;       procedure WriteCredVal1 (pValue:double);
    function  ReadDebVal1:double;        procedure WriteDebVal1 (pValue:double);
    function  ReadSCredVal1:Str16;       procedure WriteSCredVal1 (pValue:Str16);
    function  ReadSDebVal1:Str16;        procedure WriteSDebVal1 (pValue:Str16);
    function  ReadAccSnt2:Str3;          procedure WriteAccSnt2 (pValue:Str3);
    function  ReadAccAnl2:Str6;          procedure WriteAccAnl2 (pValue:Str6);
    function  ReadCredVal2:double;       procedure WriteCredVal2 (pValue:double);
    function  ReadDebVal2:double;        procedure WriteDebVal2 (pValue:double);
    function  ReadSCredVal2:Str16;       procedure WriteSCredVal2 (pValue:Str16);
    function  ReadSDebVal2:Str16;        procedure WriteSDebVal2 (pValue:Str16);
    function  ReadAccSnt3:Str3;          procedure WriteAccSnt3 (pValue:Str3);
    function  ReadAccAnl3:Str6;          procedure WriteAccAnl3 (pValue:Str6);
    function  ReadCredVal3:double;       procedure WriteCredVal3 (pValue:double);
    function  ReadDebVal3:double;        procedure WriteDebVal3 (pValue:double);
    function  ReadSCredVal3:Str16;       procedure WriteSCredVal3 (pValue:Str16);
    function  ReadSDebVal3:Str16;        procedure WriteSDebVal3 (pValue:Str16);
    function  ReadAccSnt4:Str3;          procedure WriteAccSnt4 (pValue:Str3);
    function  ReadAccAnl4:Str6;          procedure WriteAccAnl4 (pValue:Str6);
    function  ReadCredVal4:double;       procedure WriteCredVal4 (pValue:double);
    function  ReadDebVal4:double;        procedure WriteDebVal4 (pValue:double);
    function  ReadSCredVal4:Str16;       procedure WriteSCredVal4 (pValue:Str16);
    function  ReadSDebVal4:Str16;        procedure WriteSDebVal4 (pValue:Str16);
    function  ReadAccSnt5:Str3;          procedure WriteAccSnt5 (pValue:Str3);
    function  ReadAccAnl5:Str6;          procedure WriteAccAnl5 (pValue:Str6);
    function  ReadCredVal5:double;       procedure WriteCredVal5 (pValue:double);
    function  ReadDebVal5:double;        procedure WriteDebVal5 (pValue:double);
    function  ReadSCredVal5:Str16;       procedure WriteSCredVal5 (pValue:Str16);
    function  ReadSDebVal5:Str16;        procedure WriteSDebVal5 (pValue:Str16);
    function  ReadAccSnt6:Str3;          procedure WriteAccSnt6 (pValue:Str3);
    function  ReadAccAnl6:Str6;          procedure WriteAccAnl6 (pValue:Str6);
    function  ReadCredVal6:double;       procedure WriteCredVal6 (pValue:double);
    function  ReadDebVal6:double;        procedure WriteDebVal6 (pValue:double);
    function  ReadSCredVal6:Str16;       procedure WriteSCredVal6 (pValue:Str16);
    function  ReadSDebVal6:Str16;        procedure WriteSDebVal6 (pValue:Str16);
    function  ReadAccSnt7:Str3;          procedure WriteAccSnt7 (pValue:Str3);
    function  ReadAccAnl7:Str6;          procedure WriteAccAnl7 (pValue:Str6);
    function  ReadCredVal7:double;       procedure WriteCredVal7 (pValue:double);
    function  ReadDebVal7:double;        procedure WriteDebVal7 (pValue:double);
    function  ReadSCredVal7:Str16;       procedure WriteSCredVal7 (pValue:Str16);
    function  ReadSDebVal7:Str16;        procedure WriteSDebVal7 (pValue:Str16);
    function  ReadAccSnt8:Str3;          procedure WriteAccSnt8 (pValue:Str3);
    function  ReadAccAnl8:Str6;          procedure WriteAccAnl8 (pValue:Str6);
    function  ReadCredVal8:double;       procedure WriteCredVal8 (pValue:double);
    function  ReadDebVal8:double;        procedure WriteDebVal8 (pValue:double);
    function  ReadSCredVal8:Str16;       procedure WriteSCredVal8 (pValue:Str16);
    function  ReadSDebVal8:Str16;        procedure WriteSDebVal8 (pValue:Str16);
    function  ReadSpAValue:double;       procedure WriteSpAValue (pValue:double);
    function  ReadSpBValue:double;       procedure WriteSpBValue (pValue:double);
    function  ReadSpVatValue:double;     procedure WriteSpVatValue (pValue:double);
    function  ReadNSpAValue:double;      procedure WriteNSpAValue (pValue:double);
    function  ReadNSpBValue:double;      procedure WriteNSpBValue (pValue:double);
    function  ReadNSpVatValue:double;    procedure WriteNSpVatValue (pValue:double);
    function  ReadChecked1:Str1;         procedure WriteChecked1 (pValue:Str1);
    function  ReadChecked2:Str1;         procedure WriteChecked2 (pValue:Str1);
    function  ReadChecked3:Str1;         procedure WriteChecked3 (pValue:Str1);
    function  ReadChecked4:Str1;         procedure WriteChecked4 (pValue:Str1);
    function  ReadChecked5:Str1;         procedure WriteChecked5 (pValue:Str1);
    function  ReadChecked6:Str1;         procedure WriteChecked6 (pValue:Str1);
    function  ReadChecked7:Str1;         procedure WriteChecked7 (pValue:Str1);
    function  ReadChecked8:Str1;         procedure WriteChecked8 (pValue:Str1);
    function  ReadChecked9:Str1;         procedure WriteChecked9 (pValue:Str1);
    function  ReadDlrName:Str30;         procedure WriteDlrName (pValue:Str30);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDocNum (pDocNum:Str12):boolean;

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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property WriNum:word read ReadWriNum write WriteWriNum;
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
    property SwftCode:Str30 read ReadSwftCode write WriteSwftCode;
    property OwnIno:Str15 read ReadOwnIno write WriteOwnIno;
    property OwnTin:Str15 read ReadOwnTin write WriteOwnTin;
    property OwnVin:Str15 read ReadOwnVin write WriteOwnVin;
    property OwnName:Str60 read ReadOwnName write WriteOwnName;
    property OwnAddr:Str30 read ReadOwnAddr write WriteOwnAddr;
    property OwnSta:Str2 read ReadOwnSta write WriteOwnSta;
    property OwnStn:Str30 read ReadOwnStn write WriteOwnStn;
    property OwnCty:Str3 read ReadOwnCty write WriteOwnCty;
    property OwnCtn:Str30 read ReadOwnCtn write WriteOwnCtn;
    property OwnZip:Str10 read ReadOwnZip write WriteOwnZip;
    property OwnWeb:Str30 read ReadOwnWeb write WriteOwnWeb;
    property OwnTel:Str20 read ReadOwnTel write WriteOwnTel;
    property OwnFax:Str20 read ReadOwnFax write WriteOwnFax;
    property OwnEml:Str30 read ReadOwnEml write WriteOwnEml;
    property OwnReg:Str90 read ReadOwnReg write WriteOwnReg;
    property SerNum1:longint read ReadSerNum1 write WriteSerNum1;
    property SerNum2:longint read ReadSerNum2 write WriteSerNum2;
    property CrtDate1:TDatetime read ReadCrtDate1 write WriteCrtDate1;
    property CrtDate2:TDatetime read ReadCrtDate2 write WriteCrtDate2;
    property Date1:TDatetime read ReadDate1 write WriteDate1;
    property Date2:TDatetime read ReadDate2 write WriteDate2;
    property Code1:longint read ReadCode1 write WriteCode1;
    property Code2:longint read ReadCode2 write WriteCode2;
    property Code:longint read ReadCode write WriteCode;
    property Name:Str30 read ReadName write WriteName;
    property Text:Str60 read ReadText write WriteText;
    property Info:Str60 read ReadInfo write WriteInfo;
    property SpMark:Str10 read ReadSpMark write WriteSpMark;
    property TxtVal:Str80 read ReadTxtVal write WriteTxtVal;
    property VatCls:word read ReadVatCls write WriteVatCls;
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
    property AccSnt1:Str3 read ReadAccSnt1 write WriteAccSnt1;
    property AccAnl1:Str6 read ReadAccAnl1 write WriteAccAnl1;
    property CredVal1:double read ReadCredVal1 write WriteCredVal1;
    property DebVal1:double read ReadDebVal1 write WriteDebVal1;
    property SCredVal1:Str16 read ReadSCredVal1 write WriteSCredVal1;
    property SDebVal1:Str16 read ReadSDebVal1 write WriteSDebVal1;
    property AccSnt2:Str3 read ReadAccSnt2 write WriteAccSnt2;
    property AccAnl2:Str6 read ReadAccAnl2 write WriteAccAnl2;
    property CredVal2:double read ReadCredVal2 write WriteCredVal2;
    property DebVal2:double read ReadDebVal2 write WriteDebVal2;
    property SCredVal2:Str16 read ReadSCredVal2 write WriteSCredVal2;
    property SDebVal2:Str16 read ReadSDebVal2 write WriteSDebVal2;
    property AccSnt3:Str3 read ReadAccSnt3 write WriteAccSnt3;
    property AccAnl3:Str6 read ReadAccAnl3 write WriteAccAnl3;
    property CredVal3:double read ReadCredVal3 write WriteCredVal3;
    property DebVal3:double read ReadDebVal3 write WriteDebVal3;
    property SCredVal3:Str16 read ReadSCredVal3 write WriteSCredVal3;
    property SDebVal3:Str16 read ReadSDebVal3 write WriteSDebVal3;
    property AccSnt4:Str3 read ReadAccSnt4 write WriteAccSnt4;
    property AccAnl4:Str6 read ReadAccAnl4 write WriteAccAnl4;
    property CredVal4:double read ReadCredVal4 write WriteCredVal4;
    property DebVal4:double read ReadDebVal4 write WriteDebVal4;
    property SCredVal4:Str16 read ReadSCredVal4 write WriteSCredVal4;
    property SDebVal4:Str16 read ReadSDebVal4 write WriteSDebVal4;
    property AccSnt5:Str3 read ReadAccSnt5 write WriteAccSnt5;
    property AccAnl5:Str6 read ReadAccAnl5 write WriteAccAnl5;
    property CredVal5:double read ReadCredVal5 write WriteCredVal5;
    property DebVal5:double read ReadDebVal5 write WriteDebVal5;
    property SCredVal5:Str16 read ReadSCredVal5 write WriteSCredVal5;
    property SDebVal5:Str16 read ReadSDebVal5 write WriteSDebVal5;
    property AccSnt6:Str3 read ReadAccSnt6 write WriteAccSnt6;
    property AccAnl6:Str6 read ReadAccAnl6 write WriteAccAnl6;
    property CredVal6:double read ReadCredVal6 write WriteCredVal6;
    property DebVal6:double read ReadDebVal6 write WriteDebVal6;
    property SCredVal6:Str16 read ReadSCredVal6 write WriteSCredVal6;
    property SDebVal6:Str16 read ReadSDebVal6 write WriteSDebVal6;
    property AccSnt7:Str3 read ReadAccSnt7 write WriteAccSnt7;
    property AccAnl7:Str6 read ReadAccAnl7 write WriteAccAnl7;
    property CredVal7:double read ReadCredVal7 write WriteCredVal7;
    property DebVal7:double read ReadDebVal7 write WriteDebVal7;
    property SCredVal7:Str16 read ReadSCredVal7 write WriteSCredVal7;
    property SDebVal7:Str16 read ReadSDebVal7 write WriteSDebVal7;
    property AccSnt8:Str3 read ReadAccSnt8 write WriteAccSnt8;
    property AccAnl8:Str6 read ReadAccAnl8 write WriteAccAnl8;
    property CredVal8:double read ReadCredVal8 write WriteCredVal8;
    property DebVal8:double read ReadDebVal8 write WriteDebVal8;
    property SCredVal8:Str16 read ReadSCredVal8 write WriteSCredVal8;
    property SDebVal8:Str16 read ReadSDebVal8 write WriteSDebVal8;
    property SpAValue:double read ReadSpAValue write WriteSpAValue;
    property SpBValue:double read ReadSpBValue write WriteSpBValue;
    property SpVatValue:double read ReadSpVatValue write WriteSpVatValue;
    property NSpAValue:double read ReadNSpAValue write WriteNSpAValue;
    property NSpBValue:double read ReadNSpBValue write WriteNSpBValue;
    property NSpVatValue:double read ReadNSpVatValue write WriteNSpVatValue;
    property Checked1:Str1 read ReadChecked1 write WriteChecked1;
    property Checked2:Str1 read ReadChecked2 write WriteChecked2;
    property Checked3:Str1 read ReadChecked3 write WriteChecked3;
    property Checked4:Str1 read ReadChecked4 write WriteChecked4;
    property Checked5:Str1 read ReadChecked5 write WriteChecked5;
    property Checked6:Str1 read ReadChecked6 write WriteChecked6;
    property Checked7:Str1 read ReadChecked7 write WriteChecked7;
    property Checked8:Str1 read ReadChecked8 write WriteChecked8;
    property Checked9:Str1 read ReadChecked9 write WriteChecked9;
    property DlrName:Str30 read ReadDlrName write WriteDlrName;
  end;

implementation

constructor TDheadTmp.Create;
begin
  oTmpTable := TmpInit ('DHEAD',Self);
end;

destructor TDheadTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TDheadTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TDheadTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
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

function TDheadTmp.ReadWriNum:word;
begin
  Result := oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TDheadTmp.WriteWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger := pValue;
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

function TDheadTmp.ReadSwftCode:Str30;
begin
  Result := oTmpTable.FieldByName('SwftCode').AsString;
end;

procedure TDheadTmp.WriteSwftCode(pValue:Str30);
begin
  oTmpTable.FieldByName('SwftCode').AsString := pValue;
end;

function TDheadTmp.ReadOwnIno:Str15;
begin
  Result := oTmpTable.FieldByName('OwnIno').AsString;
end;

procedure TDheadTmp.WriteOwnIno(pValue:Str15);
begin
  oTmpTable.FieldByName('OwnIno').AsString := pValue;
end;

function TDheadTmp.ReadOwnTin:Str15;
begin
  Result := oTmpTable.FieldByName('OwnTin').AsString;
end;

procedure TDheadTmp.WriteOwnTin(pValue:Str15);
begin
  oTmpTable.FieldByName('OwnTin').AsString := pValue;
end;

function TDheadTmp.ReadOwnVin:Str15;
begin
  Result := oTmpTable.FieldByName('OwnVin').AsString;
end;

procedure TDheadTmp.WriteOwnVin(pValue:Str15);
begin
  oTmpTable.FieldByName('OwnVin').AsString := pValue;
end;

function TDheadTmp.ReadOwnName:Str60;
begin
  Result := oTmpTable.FieldByName('OwnName').AsString;
end;

procedure TDheadTmp.WriteOwnName(pValue:Str60);
begin
  oTmpTable.FieldByName('OwnName').AsString := pValue;
end;

function TDheadTmp.ReadOwnAddr:Str30;
begin
  Result := oTmpTable.FieldByName('OwnAddr').AsString;
end;

procedure TDheadTmp.WriteOwnAddr(pValue:Str30);
begin
  oTmpTable.FieldByName('OwnAddr').AsString := pValue;
end;

function TDheadTmp.ReadOwnSta:Str2;
begin
  Result := oTmpTable.FieldByName('OwnSta').AsString;
end;

procedure TDheadTmp.WriteOwnSta(pValue:Str2);
begin
  oTmpTable.FieldByName('OwnSta').AsString := pValue;
end;

function TDheadTmp.ReadOwnStn:Str30;
begin
  Result := oTmpTable.FieldByName('OwnStn').AsString;
end;

procedure TDheadTmp.WriteOwnStn(pValue:Str30);
begin
  oTmpTable.FieldByName('OwnStn').AsString := pValue;
end;

function TDheadTmp.ReadOwnCty:Str3;
begin
  Result := oTmpTable.FieldByName('OwnCty').AsString;
end;

procedure TDheadTmp.WriteOwnCty(pValue:Str3);
begin
  oTmpTable.FieldByName('OwnCty').AsString := pValue;
end;

function TDheadTmp.ReadOwnCtn:Str30;
begin
  Result := oTmpTable.FieldByName('OwnCtn').AsString;
end;

procedure TDheadTmp.WriteOwnCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('OwnCtn').AsString := pValue;
end;

function TDheadTmp.ReadOwnZip:Str10;
begin
  Result := oTmpTable.FieldByName('OwnZip').AsString;
end;

procedure TDheadTmp.WriteOwnZip(pValue:Str10);
begin
  oTmpTable.FieldByName('OwnZip').AsString := pValue;
end;

function TDheadTmp.ReadOwnWeb:Str30;
begin
  Result := oTmpTable.FieldByName('OwnWeb').AsString;
end;

procedure TDheadTmp.WriteOwnWeb(pValue:Str30);
begin
  oTmpTable.FieldByName('OwnWeb').AsString := pValue;
end;

function TDheadTmp.ReadOwnTel:Str20;
begin
  Result := oTmpTable.FieldByName('OwnTel').AsString;
end;

procedure TDheadTmp.WriteOwnTel(pValue:Str20);
begin
  oTmpTable.FieldByName('OwnTel').AsString := pValue;
end;

function TDheadTmp.ReadOwnFax:Str20;
begin
  Result := oTmpTable.FieldByName('OwnFax').AsString;
end;

procedure TDheadTmp.WriteOwnFax(pValue:Str20);
begin
  oTmpTable.FieldByName('OwnFax').AsString := pValue;
end;

function TDheadTmp.ReadOwnEml:Str30;
begin
  Result := oTmpTable.FieldByName('OwnEml').AsString;
end;

procedure TDheadTmp.WriteOwnEml(pValue:Str30);
begin
  oTmpTable.FieldByName('OwnEml').AsString := pValue;
end;

function TDheadTmp.ReadOwnReg:Str90;
begin
  Result := oTmpTable.FieldByName('OwnReg').AsString;
end;

procedure TDheadTmp.WriteOwnReg(pValue:Str90);
begin
  oTmpTable.FieldByName('OwnReg').AsString := pValue;
end;

function TDheadTmp.ReadSerNum1:longint;
begin
  Result := oTmpTable.FieldByName('SerNum1').AsInteger;
end;

procedure TDheadTmp.WriteSerNum1(pValue:longint);
begin
  oTmpTable.FieldByName('SerNum1').AsInteger := pValue;
end;

function TDheadTmp.ReadSerNum2:longint;
begin
  Result := oTmpTable.FieldByName('SerNum2').AsInteger;
end;

procedure TDheadTmp.WriteSerNum2(pValue:longint);
begin
  oTmpTable.FieldByName('SerNum2').AsInteger := pValue;
end;

function TDheadTmp.ReadCrtDate1:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate1').AsDateTime;
end;

procedure TDheadTmp.WriteCrtDate1(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate1').AsDateTime := pValue;
end;

function TDheadTmp.ReadCrtDate2:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate2').AsDateTime;
end;

procedure TDheadTmp.WriteCrtDate2(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate2').AsDateTime := pValue;
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

function TDheadTmp.ReadSpMark:Str10;
begin
  Result := oTmpTable.FieldByName('SpMark').AsString;
end;

procedure TDheadTmp.WriteSpMark(pValue:Str10);
begin
  oTmpTable.FieldByName('SpMark').AsString := pValue;
end;

function TDheadTmp.ReadTxtVal:Str80;
begin
  Result := oTmpTable.FieldByName('TxtVal').AsString;
end;

procedure TDheadTmp.WriteTxtVal(pValue:Str80);
begin
  oTmpTable.FieldByName('TxtVal').AsString := pValue;
end;

function TDheadTmp.ReadVatCls:word;
begin
  Result := oTmpTable.FieldByName('VatCls').AsInteger;
end;

procedure TDheadTmp.WriteVatCls(pValue:word);
begin
  oTmpTable.FieldByName('VatCls').AsInteger := pValue;
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

function TDheadTmp.ReadAccSnt1:Str3;
begin
  Result := oTmpTable.FieldByName('AccSnt1').AsString;
end;

procedure TDheadTmp.WriteAccSnt1(pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt1').AsString := pValue;
end;

function TDheadTmp.ReadAccAnl1:Str6;
begin
  Result := oTmpTable.FieldByName('AccAnl1').AsString;
end;

procedure TDheadTmp.WriteAccAnl1(pValue:Str6);
begin
  oTmpTable.FieldByName('AccAnl1').AsString := pValue;
end;

function TDheadTmp.ReadCredVal1:double;
begin
  Result := oTmpTable.FieldByName('CredVal1').AsFloat;
end;

procedure TDheadTmp.WriteCredVal1(pValue:double);
begin
  oTmpTable.FieldByName('CredVal1').AsFloat := pValue;
end;

function TDheadTmp.ReadDebVal1:double;
begin
  Result := oTmpTable.FieldByName('DebVal1').AsFloat;
end;

procedure TDheadTmp.WriteDebVal1(pValue:double);
begin
  oTmpTable.FieldByName('DebVal1').AsFloat := pValue;
end;

function TDheadTmp.ReadSCredVal1:Str16;
begin
  Result := oTmpTable.FieldByName('SCredVal1').AsString;
end;

procedure TDheadTmp.WriteSCredVal1(pValue:Str16);
begin
  oTmpTable.FieldByName('SCredVal1').AsString := pValue;
end;

function TDheadTmp.ReadSDebVal1:Str16;
begin
  Result := oTmpTable.FieldByName('SDebVal1').AsString;
end;

procedure TDheadTmp.WriteSDebVal1(pValue:Str16);
begin
  oTmpTable.FieldByName('SDebVal1').AsString := pValue;
end;

function TDheadTmp.ReadAccSnt2:Str3;
begin
  Result := oTmpTable.FieldByName('AccSnt2').AsString;
end;

procedure TDheadTmp.WriteAccSnt2(pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt2').AsString := pValue;
end;

function TDheadTmp.ReadAccAnl2:Str6;
begin
  Result := oTmpTable.FieldByName('AccAnl2').AsString;
end;

procedure TDheadTmp.WriteAccAnl2(pValue:Str6);
begin
  oTmpTable.FieldByName('AccAnl2').AsString := pValue;
end;

function TDheadTmp.ReadCredVal2:double;
begin
  Result := oTmpTable.FieldByName('CredVal2').AsFloat;
end;

procedure TDheadTmp.WriteCredVal2(pValue:double);
begin
  oTmpTable.FieldByName('CredVal2').AsFloat := pValue;
end;

function TDheadTmp.ReadDebVal2:double;
begin
  Result := oTmpTable.FieldByName('DebVal2').AsFloat;
end;

procedure TDheadTmp.WriteDebVal2(pValue:double);
begin
  oTmpTable.FieldByName('DebVal2').AsFloat := pValue;
end;

function TDheadTmp.ReadSCredVal2:Str16;
begin
  Result := oTmpTable.FieldByName('SCredVal2').AsString;
end;

procedure TDheadTmp.WriteSCredVal2(pValue:Str16);
begin
  oTmpTable.FieldByName('SCredVal2').AsString := pValue;
end;

function TDheadTmp.ReadSDebVal2:Str16;
begin
  Result := oTmpTable.FieldByName('SDebVal2').AsString;
end;

procedure TDheadTmp.WriteSDebVal2(pValue:Str16);
begin
  oTmpTable.FieldByName('SDebVal2').AsString := pValue;
end;

function TDheadTmp.ReadAccSnt3:Str3;
begin
  Result := oTmpTable.FieldByName('AccSnt3').AsString;
end;

procedure TDheadTmp.WriteAccSnt3(pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt3').AsString := pValue;
end;

function TDheadTmp.ReadAccAnl3:Str6;
begin
  Result := oTmpTable.FieldByName('AccAnl3').AsString;
end;

procedure TDheadTmp.WriteAccAnl3(pValue:Str6);
begin
  oTmpTable.FieldByName('AccAnl3').AsString := pValue;
end;

function TDheadTmp.ReadCredVal3:double;
begin
  Result := oTmpTable.FieldByName('CredVal3').AsFloat;
end;

procedure TDheadTmp.WriteCredVal3(pValue:double);
begin
  oTmpTable.FieldByName('CredVal3').AsFloat := pValue;
end;

function TDheadTmp.ReadDebVal3:double;
begin
  Result := oTmpTable.FieldByName('DebVal3').AsFloat;
end;

procedure TDheadTmp.WriteDebVal3(pValue:double);
begin
  oTmpTable.FieldByName('DebVal3').AsFloat := pValue;
end;

function TDheadTmp.ReadSCredVal3:Str16;
begin
  Result := oTmpTable.FieldByName('SCredVal3').AsString;
end;

procedure TDheadTmp.WriteSCredVal3(pValue:Str16);
begin
  oTmpTable.FieldByName('SCredVal3').AsString := pValue;
end;

function TDheadTmp.ReadSDebVal3:Str16;
begin
  Result := oTmpTable.FieldByName('SDebVal3').AsString;
end;

procedure TDheadTmp.WriteSDebVal3(pValue:Str16);
begin
  oTmpTable.FieldByName('SDebVal3').AsString := pValue;
end;

function TDheadTmp.ReadAccSnt4:Str3;
begin
  Result := oTmpTable.FieldByName('AccSnt4').AsString;
end;

procedure TDheadTmp.WriteAccSnt4(pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt4').AsString := pValue;
end;

function TDheadTmp.ReadAccAnl4:Str6;
begin
  Result := oTmpTable.FieldByName('AccAnl4').AsString;
end;

procedure TDheadTmp.WriteAccAnl4(pValue:Str6);
begin
  oTmpTable.FieldByName('AccAnl4').AsString := pValue;
end;

function TDheadTmp.ReadCredVal4:double;
begin
  Result := oTmpTable.FieldByName('CredVal4').AsFloat;
end;

procedure TDheadTmp.WriteCredVal4(pValue:double);
begin
  oTmpTable.FieldByName('CredVal4').AsFloat := pValue;
end;

function TDheadTmp.ReadDebVal4:double;
begin
  Result := oTmpTable.FieldByName('DebVal4').AsFloat;
end;

procedure TDheadTmp.WriteDebVal4(pValue:double);
begin
  oTmpTable.FieldByName('DebVal4').AsFloat := pValue;
end;

function TDheadTmp.ReadSCredVal4:Str16;
begin
  Result := oTmpTable.FieldByName('SCredVal4').AsString;
end;

procedure TDheadTmp.WriteSCredVal4(pValue:Str16);
begin
  oTmpTable.FieldByName('SCredVal4').AsString := pValue;
end;

function TDheadTmp.ReadSDebVal4:Str16;
begin
  Result := oTmpTable.FieldByName('SDebVal4').AsString;
end;

procedure TDheadTmp.WriteSDebVal4(pValue:Str16);
begin
  oTmpTable.FieldByName('SDebVal4').AsString := pValue;
end;

function TDheadTmp.ReadAccSnt5:Str3;
begin
  Result := oTmpTable.FieldByName('AccSnt5').AsString;
end;

procedure TDheadTmp.WriteAccSnt5(pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt5').AsString := pValue;
end;

function TDheadTmp.ReadAccAnl5:Str6;
begin
  Result := oTmpTable.FieldByName('AccAnl5').AsString;
end;

procedure TDheadTmp.WriteAccAnl5(pValue:Str6);
begin
  oTmpTable.FieldByName('AccAnl5').AsString := pValue;
end;

function TDheadTmp.ReadCredVal5:double;
begin
  Result := oTmpTable.FieldByName('CredVal5').AsFloat;
end;

procedure TDheadTmp.WriteCredVal5(pValue:double);
begin
  oTmpTable.FieldByName('CredVal5').AsFloat := pValue;
end;

function TDheadTmp.ReadDebVal5:double;
begin
  Result := oTmpTable.FieldByName('DebVal5').AsFloat;
end;

procedure TDheadTmp.WriteDebVal5(pValue:double);
begin
  oTmpTable.FieldByName('DebVal5').AsFloat := pValue;
end;

function TDheadTmp.ReadSCredVal5:Str16;
begin
  Result := oTmpTable.FieldByName('SCredVal5').AsString;
end;

procedure TDheadTmp.WriteSCredVal5(pValue:Str16);
begin
  oTmpTable.FieldByName('SCredVal5').AsString := pValue;
end;

function TDheadTmp.ReadSDebVal5:Str16;
begin
  Result := oTmpTable.FieldByName('SDebVal5').AsString;
end;

procedure TDheadTmp.WriteSDebVal5(pValue:Str16);
begin
  oTmpTable.FieldByName('SDebVal5').AsString := pValue;
end;

function TDheadTmp.ReadAccSnt6:Str3;
begin
  Result := oTmpTable.FieldByName('AccSnt6').AsString;
end;

procedure TDheadTmp.WriteAccSnt6(pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt6').AsString := pValue;
end;

function TDheadTmp.ReadAccAnl6:Str6;
begin
  Result := oTmpTable.FieldByName('AccAnl6').AsString;
end;

procedure TDheadTmp.WriteAccAnl6(pValue:Str6);
begin
  oTmpTable.FieldByName('AccAnl6').AsString := pValue;
end;

function TDheadTmp.ReadCredVal6:double;
begin
  Result := oTmpTable.FieldByName('CredVal6').AsFloat;
end;

procedure TDheadTmp.WriteCredVal6(pValue:double);
begin
  oTmpTable.FieldByName('CredVal6').AsFloat := pValue;
end;

function TDheadTmp.ReadDebVal6:double;
begin
  Result := oTmpTable.FieldByName('DebVal6').AsFloat;
end;

procedure TDheadTmp.WriteDebVal6(pValue:double);
begin
  oTmpTable.FieldByName('DebVal6').AsFloat := pValue;
end;

function TDheadTmp.ReadSCredVal6:Str16;
begin
  Result := oTmpTable.FieldByName('SCredVal6').AsString;
end;

procedure TDheadTmp.WriteSCredVal6(pValue:Str16);
begin
  oTmpTable.FieldByName('SCredVal6').AsString := pValue;
end;

function TDheadTmp.ReadSDebVal6:Str16;
begin
  Result := oTmpTable.FieldByName('SDebVal6').AsString;
end;

procedure TDheadTmp.WriteSDebVal6(pValue:Str16);
begin
  oTmpTable.FieldByName('SDebVal6').AsString := pValue;
end;

function TDheadTmp.ReadAccSnt7:Str3;
begin
  Result := oTmpTable.FieldByName('AccSnt7').AsString;
end;

procedure TDheadTmp.WriteAccSnt7(pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt7').AsString := pValue;
end;

function TDheadTmp.ReadAccAnl7:Str6;
begin
  Result := oTmpTable.FieldByName('AccAnl7').AsString;
end;

procedure TDheadTmp.WriteAccAnl7(pValue:Str6);
begin
  oTmpTable.FieldByName('AccAnl7').AsString := pValue;
end;

function TDheadTmp.ReadCredVal7:double;
begin
  Result := oTmpTable.FieldByName('CredVal7').AsFloat;
end;

procedure TDheadTmp.WriteCredVal7(pValue:double);
begin
  oTmpTable.FieldByName('CredVal7').AsFloat := pValue;
end;

function TDheadTmp.ReadDebVal7:double;
begin
  Result := oTmpTable.FieldByName('DebVal7').AsFloat;
end;

procedure TDheadTmp.WriteDebVal7(pValue:double);
begin
  oTmpTable.FieldByName('DebVal7').AsFloat := pValue;
end;

function TDheadTmp.ReadSCredVal7:Str16;
begin
  Result := oTmpTable.FieldByName('SCredVal7').AsString;
end;

procedure TDheadTmp.WriteSCredVal7(pValue:Str16);
begin
  oTmpTable.FieldByName('SCredVal7').AsString := pValue;
end;

function TDheadTmp.ReadSDebVal7:Str16;
begin
  Result := oTmpTable.FieldByName('SDebVal7').AsString;
end;

procedure TDheadTmp.WriteSDebVal7(pValue:Str16);
begin
  oTmpTable.FieldByName('SDebVal7').AsString := pValue;
end;

function TDheadTmp.ReadAccSnt8:Str3;
begin
  Result := oTmpTable.FieldByName('AccSnt8').AsString;
end;

procedure TDheadTmp.WriteAccSnt8(pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt8').AsString := pValue;
end;

function TDheadTmp.ReadAccAnl8:Str6;
begin
  Result := oTmpTable.FieldByName('AccAnl8').AsString;
end;

procedure TDheadTmp.WriteAccAnl8(pValue:Str6);
begin
  oTmpTable.FieldByName('AccAnl8').AsString := pValue;
end;

function TDheadTmp.ReadCredVal8:double;
begin
  Result := oTmpTable.FieldByName('CredVal8').AsFloat;
end;

procedure TDheadTmp.WriteCredVal8(pValue:double);
begin
  oTmpTable.FieldByName('CredVal8').AsFloat := pValue;
end;

function TDheadTmp.ReadDebVal8:double;
begin
  Result := oTmpTable.FieldByName('DebVal8').AsFloat;
end;

procedure TDheadTmp.WriteDebVal8(pValue:double);
begin
  oTmpTable.FieldByName('DebVal8').AsFloat := pValue;
end;

function TDheadTmp.ReadSCredVal8:Str16;
begin
  Result := oTmpTable.FieldByName('SCredVal8').AsString;
end;

procedure TDheadTmp.WriteSCredVal8(pValue:Str16);
begin
  oTmpTable.FieldByName('SCredVal8').AsString := pValue;
end;

function TDheadTmp.ReadSDebVal8:Str16;
begin
  Result := oTmpTable.FieldByName('SDebVal8').AsString;
end;

procedure TDheadTmp.WriteSDebVal8(pValue:Str16);
begin
  oTmpTable.FieldByName('SDebVal8').AsString := pValue;
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

function TDheadTmp.ReadChecked1:Str1;
begin
  Result := oTmpTable.FieldByName('Checked1').AsString;
end;

procedure TDheadTmp.WriteChecked1(pValue:Str1);
begin
  oTmpTable.FieldByName('Checked1').AsString := pValue;
end;

function TDheadTmp.ReadChecked2:Str1;
begin
  Result := oTmpTable.FieldByName('Checked2').AsString;
end;

procedure TDheadTmp.WriteChecked2(pValue:Str1);
begin
  oTmpTable.FieldByName('Checked2').AsString := pValue;
end;

function TDheadTmp.ReadChecked3:Str1;
begin
  Result := oTmpTable.FieldByName('Checked3').AsString;
end;

procedure TDheadTmp.WriteChecked3(pValue:Str1);
begin
  oTmpTable.FieldByName('Checked3').AsString := pValue;
end;

function TDheadTmp.ReadChecked4:Str1;
begin
  Result := oTmpTable.FieldByName('Checked4').AsString;
end;

procedure TDheadTmp.WriteChecked4(pValue:Str1);
begin
  oTmpTable.FieldByName('Checked4').AsString := pValue;
end;

function TDheadTmp.ReadChecked5:Str1;
begin
  Result := oTmpTable.FieldByName('Checked5').AsString;
end;

procedure TDheadTmp.WriteChecked5(pValue:Str1);
begin
  oTmpTable.FieldByName('Checked5').AsString := pValue;
end;

function TDheadTmp.ReadChecked6:Str1;
begin
  Result := oTmpTable.FieldByName('Checked6').AsString;
end;

procedure TDheadTmp.WriteChecked6(pValue:Str1);
begin
  oTmpTable.FieldByName('Checked6').AsString := pValue;
end;

function TDheadTmp.ReadChecked7:Str1;
begin
  Result := oTmpTable.FieldByName('Checked7').AsString;
end;

procedure TDheadTmp.WriteChecked7(pValue:Str1);
begin
  oTmpTable.FieldByName('Checked7').AsString := pValue;
end;

function TDheadTmp.ReadChecked8:Str1;
begin
  Result := oTmpTable.FieldByName('Checked8').AsString;
end;

procedure TDheadTmp.WriteChecked8(pValue:Str1);
begin
  oTmpTable.FieldByName('Checked8').AsString := pValue;
end;

function TDheadTmp.ReadChecked9:Str1;
begin
  Result := oTmpTable.FieldByName('Checked9').AsString;
end;

procedure TDheadTmp.WriteChecked9(pValue:Str1);
begin
  oTmpTable.FieldByName('Checked9').AsString := pValue;
end;

function TDheadTmp.ReadDlrName:Str30;
begin
  Result := oTmpTable.FieldByName('DlrName').AsString;
end;

procedure TDheadTmp.WriteDlrName(pValue:Str30);
begin
  oTmpTable.FieldByName('DlrName').AsString := pValue;
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
var mEdit:boolean;
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

procedure TDheadTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TDheadTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TDheadTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TDheadTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1904012}
