unit bACCANL;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSnAn = 'SnAn';
  ixAccSnt = 'AccSnt';
  ixAnlName = 'AnlName';
  ixCTurnVal = 'CTurnVal';
  ixDTurnVal = 'DTurnVal';
  ixDiffVal = 'DiffVal';
  ixStaStk = 'StaStk';

type
  TAccanlBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadAccSnt:str3;           procedure WriteAccSnt (pValue:str3);
    function  ReadAccAnl:str6;           procedure WriteAccAnl (pValue:str6);
    function  ReadAnlName:Str30;         procedure WriteAnlName (pValue:Str30);
    function  ReadAnlName_:Str30;        procedure WriteAnlName_ (pValue:Str30);
    function  ReadCTurn01:double;        procedure WriteCTurn01 (pValue:double);
    function  ReadDTurn01:double;        procedure WriteDTurn01 (pValue:double);
    function  ReadCTurn02:double;        procedure WriteCTurn02 (pValue:double);
    function  ReadDTurn02:double;        procedure WriteDTurn02 (pValue:double);
    function  ReadCTurn03:double;        procedure WriteCTurn03 (pValue:double);
    function  ReadDTurn03:double;        procedure WriteDTurn03 (pValue:double);
    function  ReadCTurn04:double;        procedure WriteCTurn04 (pValue:double);
    function  ReadDTurn04:double;        procedure WriteDTurn04 (pValue:double);
    function  ReadCTurn05:double;        procedure WriteCTurn05 (pValue:double);
    function  ReadDTurn05:double;        procedure WriteDTurn05 (pValue:double);
    function  ReadCTurn06:double;        procedure WriteCTurn06 (pValue:double);
    function  ReadDTurn06:double;        procedure WriteDTurn06 (pValue:double);
    function  ReadCTurn07:double;        procedure WriteCTurn07 (pValue:double);
    function  ReadDTurn07:double;        procedure WriteDTurn07 (pValue:double);
    function  ReadCTurn08:double;        procedure WriteCTurn08 (pValue:double);
    function  ReadDTurn08:double;        procedure WriteDTurn08 (pValue:double);
    function  ReadCTurn09:double;        procedure WriteCTurn09 (pValue:double);
    function  ReadDTurn09:double;        procedure WriteDTurn09 (pValue:double);
    function  ReadCTurn10:double;        procedure WriteCTurn10 (pValue:double);
    function  ReadDTurn10:double;        procedure WriteDTurn10 (pValue:double);
    function  ReadCTurn11:double;        procedure WriteCTurn11 (pValue:double);
    function  ReadDTurn11:double;        procedure WriteDTurn11 (pValue:double);
    function  ReadCTurn12:double;        procedure WriteCTurn12 (pValue:double);
    function  ReadDTurn12:double;        procedure WriteDTurn12 (pValue:double);
    function  ReadCBegVal:double;        procedure WriteCBegVal (pValue:double);
    function  ReadDBegVal:double;        procedure WriteDBegVal (pValue:double);
    function  ReadCTurnVal:double;       procedure WriteCTurnVal (pValue:double);
    function  ReadDTurnVal:double;       procedure WriteDTurnVal (pValue:double);
    function  ReadCEndVal:double;        procedure WriteCEndVal (pValue:double);
    function  ReadDEndVal:double;        procedure WriteDEndVal (pValue:double);
    function  ReadDiffVal:double;        procedure WriteDiffVal (pValue:double);
    function  ReadCrtName:str8;          procedure WriteCrtName (pValue:str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadNoTaxMod:boolean;      procedure WriteNoTaxMod (pValue:boolean);
    function  ReadAccType:Str1;          procedure WriteAccType (pValue:Str1);
    function  ReadBalance:Str1;          procedure WriteBalance (pValue:Str1);
    function  ReadFjrRow:Str2;           procedure WriteFjrRow (pValue:Str2);
    function  ReadStaStk:Str1;           procedure WriteStaStk (pValue:Str1);
    function  Readx_ResText:Str41;       procedure Writex_ResText (pValue:Str41);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateSnAn (pAccSnt:str3;pAccAnl:str6):boolean;
    function LocateAccSnt (pAccSnt:str3):boolean;
    function LocateAnlName (pAnlName_:Str30):boolean;
    function LocateCTurnVal (pCTurnVal:double):boolean;
    function LocateDTurnVal (pDTurnVal:double):boolean;
    function LocateDiffVal (pDiffVal:double):boolean;
    function LocateStaStk (pStaStk:Str1):boolean;
    function NearestSnAn (pAccSnt:str3;pAccAnl:str6):boolean;
    function NearestAccSnt (pAccSnt:str3):boolean;
    function NearestAnlName (pAnlName_:Str30):boolean;
    function NearestCTurnVal (pCTurnVal:double):boolean;
    function NearestDTurnVal (pDTurnVal:double):boolean;
    function NearestDiffVal (pDiffVal:double):boolean;
    function NearestStaStk (pStaStk:Str1):boolean;

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
    property AccSnt:str3 read ReadAccSnt write WriteAccSnt;
    property AccAnl:str6 read ReadAccAnl write WriteAccAnl;
    property AnlName:Str30 read ReadAnlName write WriteAnlName;
    property AnlName_:Str30 read ReadAnlName_ write WriteAnlName_;
    property CTurn01:double read ReadCTurn01 write WriteCTurn01;
    property DTurn01:double read ReadDTurn01 write WriteDTurn01;
    property CTurn02:double read ReadCTurn02 write WriteCTurn02;
    property DTurn02:double read ReadDTurn02 write WriteDTurn02;
    property CTurn03:double read ReadCTurn03 write WriteCTurn03;
    property DTurn03:double read ReadDTurn03 write WriteDTurn03;
    property CTurn04:double read ReadCTurn04 write WriteCTurn04;
    property DTurn04:double read ReadDTurn04 write WriteDTurn04;
    property CTurn05:double read ReadCTurn05 write WriteCTurn05;
    property DTurn05:double read ReadDTurn05 write WriteDTurn05;
    property CTurn06:double read ReadCTurn06 write WriteCTurn06;
    property DTurn06:double read ReadDTurn06 write WriteDTurn06;
    property CTurn07:double read ReadCTurn07 write WriteCTurn07;
    property DTurn07:double read ReadDTurn07 write WriteDTurn07;
    property CTurn08:double read ReadCTurn08 write WriteCTurn08;
    property DTurn08:double read ReadDTurn08 write WriteDTurn08;
    property CTurn09:double read ReadCTurn09 write WriteCTurn09;
    property DTurn09:double read ReadDTurn09 write WriteDTurn09;
    property CTurn10:double read ReadCTurn10 write WriteCTurn10;
    property DTurn10:double read ReadDTurn10 write WriteDTurn10;
    property CTurn11:double read ReadCTurn11 write WriteCTurn11;
    property DTurn11:double read ReadDTurn11 write WriteDTurn11;
    property CTurn12:double read ReadCTurn12 write WriteCTurn12;
    property DTurn12:double read ReadDTurn12 write WriteDTurn12;
    property CBegVal:double read ReadCBegVal write WriteCBegVal;
    property DBegVal:double read ReadDBegVal write WriteDBegVal;
    property CTurnVal:double read ReadCTurnVal write WriteCTurnVal;
    property DTurnVal:double read ReadDTurnVal write WriteDTurnVal;
    property CEndVal:double read ReadCEndVal write WriteCEndVal;
    property DEndVal:double read ReadDEndVal write WriteDEndVal;
    property DiffVal:double read ReadDiffVal write WriteDiffVal;
    property CrtName:str8 read ReadCrtName write WriteCrtName;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property NoTaxMod:boolean read ReadNoTaxMod write WriteNoTaxMod;
    property AccType:Str1 read ReadAccType write WriteAccType;
    property Balance:Str1 read ReadBalance write WriteBalance;
    property FjrRow:Str2 read ReadFjrRow write WriteFjrRow;
    property StaStk:Str1 read ReadStaStk write WriteStaStk;
    property x_ResText:Str41 read Readx_ResText write Writex_ResText;
  end;

implementation

constructor TAccanlBtr.Create;
begin
  oBtrTable := BtrInit ('ACCANL',gPath.LdgPath,Self);
end;

constructor TAccanlBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('ACCANL',pPath,Self);
end;

destructor TAccanlBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TAccanlBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TAccanlBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TAccanlBtr.ReadAccSnt:str3;
begin
  Result := oBtrTable.FieldByName('AccSnt').AsString;
end;

procedure TAccanlBtr.WriteAccSnt(pValue:str3);
begin
  oBtrTable.FieldByName('AccSnt').AsString := pValue;
end;

function TAccanlBtr.ReadAccAnl:str6;
begin
  Result := oBtrTable.FieldByName('AccAnl').AsString;
end;

procedure TAccanlBtr.WriteAccAnl(pValue:str6);
begin
  oBtrTable.FieldByName('AccAnl').AsString := pValue;
end;

function TAccanlBtr.ReadAnlName:Str30;
begin
  Result := oBtrTable.FieldByName('AnlName').AsString;
end;

procedure TAccanlBtr.WriteAnlName(pValue:Str30);
begin
  oBtrTable.FieldByName('AnlName').AsString := pValue;
end;

function TAccanlBtr.ReadAnlName_:Str30;
begin
  Result := oBtrTable.FieldByName('AnlName_').AsString;
end;

procedure TAccanlBtr.WriteAnlName_(pValue:Str30);
begin
  oBtrTable.FieldByName('AnlName_').AsString := pValue;
end;

function TAccanlBtr.ReadCTurn01:double;
begin
  Result := oBtrTable.FieldByName('CTurn01').AsFloat;
end;

procedure TAccanlBtr.WriteCTurn01(pValue:double);
begin
  oBtrTable.FieldByName('CTurn01').AsFloat := pValue;
end;

function TAccanlBtr.ReadDTurn01:double;
begin
  Result := oBtrTable.FieldByName('DTurn01').AsFloat;
end;

procedure TAccanlBtr.WriteDTurn01(pValue:double);
begin
  oBtrTable.FieldByName('DTurn01').AsFloat := pValue;
end;

function TAccanlBtr.ReadCTurn02:double;
begin
  Result := oBtrTable.FieldByName('CTurn02').AsFloat;
end;

procedure TAccanlBtr.WriteCTurn02(pValue:double);
begin
  oBtrTable.FieldByName('CTurn02').AsFloat := pValue;
end;

function TAccanlBtr.ReadDTurn02:double;
begin
  Result := oBtrTable.FieldByName('DTurn02').AsFloat;
end;

procedure TAccanlBtr.WriteDTurn02(pValue:double);
begin
  oBtrTable.FieldByName('DTurn02').AsFloat := pValue;
end;

function TAccanlBtr.ReadCTurn03:double;
begin
  Result := oBtrTable.FieldByName('CTurn03').AsFloat;
end;

procedure TAccanlBtr.WriteCTurn03(pValue:double);
begin
  oBtrTable.FieldByName('CTurn03').AsFloat := pValue;
end;

function TAccanlBtr.ReadDTurn03:double;
begin
  Result := oBtrTable.FieldByName('DTurn03').AsFloat;
end;

procedure TAccanlBtr.WriteDTurn03(pValue:double);
begin
  oBtrTable.FieldByName('DTurn03').AsFloat := pValue;
end;

function TAccanlBtr.ReadCTurn04:double;
begin
  Result := oBtrTable.FieldByName('CTurn04').AsFloat;
end;

procedure TAccanlBtr.WriteCTurn04(pValue:double);
begin
  oBtrTable.FieldByName('CTurn04').AsFloat := pValue;
end;

function TAccanlBtr.ReadDTurn04:double;
begin
  Result := oBtrTable.FieldByName('DTurn04').AsFloat;
end;

procedure TAccanlBtr.WriteDTurn04(pValue:double);
begin
  oBtrTable.FieldByName('DTurn04').AsFloat := pValue;
end;

function TAccanlBtr.ReadCTurn05:double;
begin
  Result := oBtrTable.FieldByName('CTurn05').AsFloat;
end;

procedure TAccanlBtr.WriteCTurn05(pValue:double);
begin
  oBtrTable.FieldByName('CTurn05').AsFloat := pValue;
end;

function TAccanlBtr.ReadDTurn05:double;
begin
  Result := oBtrTable.FieldByName('DTurn05').AsFloat;
end;

procedure TAccanlBtr.WriteDTurn05(pValue:double);
begin
  oBtrTable.FieldByName('DTurn05').AsFloat := pValue;
end;

function TAccanlBtr.ReadCTurn06:double;
begin
  Result := oBtrTable.FieldByName('CTurn06').AsFloat;
end;

procedure TAccanlBtr.WriteCTurn06(pValue:double);
begin
  oBtrTable.FieldByName('CTurn06').AsFloat := pValue;
end;

function TAccanlBtr.ReadDTurn06:double;
begin
  Result := oBtrTable.FieldByName('DTurn06').AsFloat;
end;

procedure TAccanlBtr.WriteDTurn06(pValue:double);
begin
  oBtrTable.FieldByName('DTurn06').AsFloat := pValue;
end;

function TAccanlBtr.ReadCTurn07:double;
begin
  Result := oBtrTable.FieldByName('CTurn07').AsFloat;
end;

procedure TAccanlBtr.WriteCTurn07(pValue:double);
begin
  oBtrTable.FieldByName('CTurn07').AsFloat := pValue;
end;

function TAccanlBtr.ReadDTurn07:double;
begin
  Result := oBtrTable.FieldByName('DTurn07').AsFloat;
end;

procedure TAccanlBtr.WriteDTurn07(pValue:double);
begin
  oBtrTable.FieldByName('DTurn07').AsFloat := pValue;
end;

function TAccanlBtr.ReadCTurn08:double;
begin
  Result := oBtrTable.FieldByName('CTurn08').AsFloat;
end;

procedure TAccanlBtr.WriteCTurn08(pValue:double);
begin
  oBtrTable.FieldByName('CTurn08').AsFloat := pValue;
end;

function TAccanlBtr.ReadDTurn08:double;
begin
  Result := oBtrTable.FieldByName('DTurn08').AsFloat;
end;

procedure TAccanlBtr.WriteDTurn08(pValue:double);
begin
  oBtrTable.FieldByName('DTurn08').AsFloat := pValue;
end;

function TAccanlBtr.ReadCTurn09:double;
begin
  Result := oBtrTable.FieldByName('CTurn09').AsFloat;
end;

procedure TAccanlBtr.WriteCTurn09(pValue:double);
begin
  oBtrTable.FieldByName('CTurn09').AsFloat := pValue;
end;

function TAccanlBtr.ReadDTurn09:double;
begin
  Result := oBtrTable.FieldByName('DTurn09').AsFloat;
end;

procedure TAccanlBtr.WriteDTurn09(pValue:double);
begin
  oBtrTable.FieldByName('DTurn09').AsFloat := pValue;
end;

function TAccanlBtr.ReadCTurn10:double;
begin
  Result := oBtrTable.FieldByName('CTurn10').AsFloat;
end;

procedure TAccanlBtr.WriteCTurn10(pValue:double);
begin
  oBtrTable.FieldByName('CTurn10').AsFloat := pValue;
end;

function TAccanlBtr.ReadDTurn10:double;
begin
  Result := oBtrTable.FieldByName('DTurn10').AsFloat;
end;

procedure TAccanlBtr.WriteDTurn10(pValue:double);
begin
  oBtrTable.FieldByName('DTurn10').AsFloat := pValue;
end;

function TAccanlBtr.ReadCTurn11:double;
begin
  Result := oBtrTable.FieldByName('CTurn11').AsFloat;
end;

procedure TAccanlBtr.WriteCTurn11(pValue:double);
begin
  oBtrTable.FieldByName('CTurn11').AsFloat := pValue;
end;

function TAccanlBtr.ReadDTurn11:double;
begin
  Result := oBtrTable.FieldByName('DTurn11').AsFloat;
end;

procedure TAccanlBtr.WriteDTurn11(pValue:double);
begin
  oBtrTable.FieldByName('DTurn11').AsFloat := pValue;
end;

function TAccanlBtr.ReadCTurn12:double;
begin
  Result := oBtrTable.FieldByName('CTurn12').AsFloat;
end;

procedure TAccanlBtr.WriteCTurn12(pValue:double);
begin
  oBtrTable.FieldByName('CTurn12').AsFloat := pValue;
end;

function TAccanlBtr.ReadDTurn12:double;
begin
  Result := oBtrTable.FieldByName('DTurn12').AsFloat;
end;

procedure TAccanlBtr.WriteDTurn12(pValue:double);
begin
  oBtrTable.FieldByName('DTurn12').AsFloat := pValue;
end;

function TAccanlBtr.ReadCBegVal:double;
begin
  Result := oBtrTable.FieldByName('CBegVal').AsFloat;
end;

procedure TAccanlBtr.WriteCBegVal(pValue:double);
begin
  oBtrTable.FieldByName('CBegVal').AsFloat := pValue;
end;

function TAccanlBtr.ReadDBegVal:double;
begin
  Result := oBtrTable.FieldByName('DBegVal').AsFloat;
end;

procedure TAccanlBtr.WriteDBegVal(pValue:double);
begin
  oBtrTable.FieldByName('DBegVal').AsFloat := pValue;
end;

function TAccanlBtr.ReadCTurnVal:double;
begin
  Result := oBtrTable.FieldByName('CTurnVal').AsFloat;
end;

procedure TAccanlBtr.WriteCTurnVal(pValue:double);
begin
  oBtrTable.FieldByName('CTurnVal').AsFloat := pValue;
end;

function TAccanlBtr.ReadDTurnVal:double;
begin
  Result := oBtrTable.FieldByName('DTurnVal').AsFloat;
end;

procedure TAccanlBtr.WriteDTurnVal(pValue:double);
begin
  oBtrTable.FieldByName('DTurnVal').AsFloat := pValue;
end;

function TAccanlBtr.ReadCEndVal:double;
begin
  Result := oBtrTable.FieldByName('CEndVal').AsFloat;
end;

procedure TAccanlBtr.WriteCEndVal(pValue:double);
begin
  oBtrTable.FieldByName('CEndVal').AsFloat := pValue;
end;

function TAccanlBtr.ReadDEndVal:double;
begin
  Result := oBtrTable.FieldByName('DEndVal').AsFloat;
end;

procedure TAccanlBtr.WriteDEndVal(pValue:double);
begin
  oBtrTable.FieldByName('DEndVal').AsFloat := pValue;
end;

function TAccanlBtr.ReadDiffVal:double;
begin
  Result := oBtrTable.FieldByName('DiffVal').AsFloat;
end;

procedure TAccanlBtr.WriteDiffVal(pValue:double);
begin
  oBtrTable.FieldByName('DiffVal').AsFloat := pValue;
end;

function TAccanlBtr.ReadCrtName:str8;
begin
  Result := oBtrTable.FieldByName('CrtName').AsString;
end;

procedure TAccanlBtr.WriteCrtName(pValue:str8);
begin
  oBtrTable.FieldByName('CrtName').AsString := pValue;
end;

function TAccanlBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TAccanlBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TAccanlBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TAccanlBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TAccanlBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TAccanlBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TAccanlBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TAccanlBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TAccanlBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TAccanlBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TAccanlBtr.ReadNoTaxMod:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('NoTaxMod').AsInteger);
end;

procedure TAccanlBtr.WriteNoTaxMod(pValue:boolean);
begin
  oBtrTable.FieldByName('NoTaxMod').AsInteger := BoolToByte(pValue);
end;

function TAccanlBtr.ReadAccType:Str1;
begin
  Result := oBtrTable.FieldByName('AccType').AsString;
end;

procedure TAccanlBtr.WriteAccType(pValue:Str1);
begin
  oBtrTable.FieldByName('AccType').AsString := pValue;
end;

function TAccanlBtr.ReadBalance:Str1;
begin
  Result := oBtrTable.FieldByName('Balance').AsString;
end;

procedure TAccanlBtr.WriteBalance(pValue:Str1);
begin
  oBtrTable.FieldByName('Balance').AsString := pValue;
end;

function TAccanlBtr.ReadFjrRow:Str2;
begin
  Result := oBtrTable.FieldByName('FjrRow').AsString;
end;

procedure TAccanlBtr.WriteFjrRow(pValue:Str2);
begin
  oBtrTable.FieldByName('FjrRow').AsString := pValue;
end;

function TAccanlBtr.ReadStaStk:Str1;
begin
  Result := oBtrTable.FieldByName('StaStk').AsString;
end;

procedure TAccanlBtr.WriteStaStk(pValue:Str1);
begin
  oBtrTable.FieldByName('StaStk').AsString := pValue;
end;

function TAccanlBtr.Readx_ResText:Str41;
begin
  Result := oBtrTable.FieldByName('x_ResText').AsString;
end;

procedure TAccanlBtr.Writex_ResText(pValue:Str41);
begin
  oBtrTable.FieldByName('x_ResText').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAccanlBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAccanlBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TAccanlBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAccanlBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TAccanlBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TAccanlBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TAccanlBtr.LocateSnAn (pAccSnt:str3;pAccAnl:str6):boolean;
begin
  SetIndex (ixSnAn);
  Result := oBtrTable.FindKey([pAccSnt,pAccAnl]);
end;

function TAccanlBtr.LocateAccSnt (pAccSnt:str3):boolean;
begin
  SetIndex (ixAccSnt);
  Result := oBtrTable.FindKey([pAccSnt]);
end;

function TAccanlBtr.LocateAnlName (pAnlName_:Str30):boolean;
begin
  SetIndex (ixAnlName);
  Result := oBtrTable.FindKey([StrToAlias(pAnlName_)]);
end;

function TAccanlBtr.LocateCTurnVal (pCTurnVal:double):boolean;
begin
  SetIndex (ixCTurnVal);
  Result := oBtrTable.FindKey([pCTurnVal]);
end;

function TAccanlBtr.LocateDTurnVal (pDTurnVal:double):boolean;
begin
  SetIndex (ixDTurnVal);
  Result := oBtrTable.FindKey([pDTurnVal]);
end;

function TAccanlBtr.LocateDiffVal (pDiffVal:double):boolean;
begin
  SetIndex (ixDiffVal);
  Result := oBtrTable.FindKey([pDiffVal]);
end;

function TAccanlBtr.LocateStaStk (pStaStk:Str1):boolean;
begin
  SetIndex (ixStaStk);
  Result := oBtrTable.FindKey([pStaStk]);
end;

function TAccanlBtr.NearestSnAn (pAccSnt:str3;pAccAnl:str6):boolean;
begin
  SetIndex (ixSnAn);
  Result := oBtrTable.FindNearest([pAccSnt,pAccAnl]);
end;

function TAccanlBtr.NearestAccSnt (pAccSnt:str3):boolean;
begin
  SetIndex (ixAccSnt);
  Result := oBtrTable.FindNearest([pAccSnt]);
end;

function TAccanlBtr.NearestAnlName (pAnlName_:Str30):boolean;
begin
  SetIndex (ixAnlName);
  Result := oBtrTable.FindNearest([pAnlName_]);
end;

function TAccanlBtr.NearestCTurnVal (pCTurnVal:double):boolean;
begin
  SetIndex (ixCTurnVal);
  Result := oBtrTable.FindNearest([pCTurnVal]);
end;

function TAccanlBtr.NearestDTurnVal (pDTurnVal:double):boolean;
begin
  SetIndex (ixDTurnVal);
  Result := oBtrTable.FindNearest([pDTurnVal]);
end;

function TAccanlBtr.NearestDiffVal (pDiffVal:double):boolean;
begin
  SetIndex (ixDiffVal);
  Result := oBtrTable.FindNearest([pDiffVal]);
end;

function TAccanlBtr.NearestStaStk (pStaStk:Str1):boolean;
begin
  SetIndex (ixStaStk);
  Result := oBtrTable.FindNearest([pStaStk]);
end;

procedure TAccanlBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TAccanlBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TAccanlBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TAccanlBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TAccanlBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TAccanlBtr.First;
begin
  oBtrTable.First;
end;

procedure TAccanlBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TAccanlBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TAccanlBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TAccanlBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TAccanlBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TAccanlBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TAccanlBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TAccanlBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TAccanlBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TAccanlBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TAccanlBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 2011001}
