unit bSCS;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoCsIt = 'DoCsIt';
  ixDocNum = 'DocNum';
  ixGsCode = 'GsCode';
  ixPaCode = 'PaCode';
  ixFinStat = 'FinStat';

type
  TScsBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadCsType:Str1;           procedure WriteCsType (pValue:Str1);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadMgCode:word;           procedure WriteMgCode (pValue:word);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadNotice:Str30;          procedure WriteNotice (pValue:Str30);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadAcAValue:double;       procedure WriteAcAValue (pValue:double);
    function  ReadAcBValue:double;       procedure WriteAcBValue (pValue:double);
    function  ReadFgDPrice:double;       procedure WriteFgDPrice (pValue:double);
    function  ReadFgAPrice:double;       procedure WriteFgAPrice (pValue:double);
    function  ReadFgBPrice:double;       procedure WriteFgBPrice (pValue:double);
    function  ReadFgDValue:double;       procedure WriteFgDValue (pValue:double);
    function  ReadFgDscVal:double;       procedure WriteFgDscVal (pValue:double);
    function  ReadFgAValue:double;       procedure WriteFgAValue (pValue:double);
    function  ReadFgBValue:double;       procedure WriteFgBValue (pValue:double);
    function  ReadDscType:Str1;          procedure WriteDscType (pValue:Str1);
    function  ReadDlrCode:word;          procedure WriteDlrCode (pValue:word);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadGrtType:Str1;          procedure WriteGrtType (pValue:Str1);
    function  ReadCasNum:word;           procedure WriteCasNum (pValue:word);
    function  ReadIcdNum:Str12;          procedure WriteIcdNum (pValue:Str12);
    function  ReadIcdItm:word;           procedure WriteIcdItm (pValue:word);
    function  ReadIcdDate:TDatetime;     procedure WriteIcdDate (pValue:TDatetime);
    function  ReadFinStat:Str1;          procedure WriteFinStat (pValue:Str1);
    function  ReadAction:Str1;           procedure WriteAction (pValue:Str1);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateDoCsIt (pDocNum:Str12;pCsType:Str1;pItmNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocateFinStat (pFinStat:Str1):boolean;
    function NearestDoCsIt (pDocNum:Str12;pCsType:Str1;pItmNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
    function NearestFinStat (pFinStat:Str1):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pBookNum:Str5);
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
    procedure EnableControls;
    procedure DisableControls;
  published
    property BtrTable:TNexBtrTable read oBtrTable;
    property Count:integer read ReadCount;
    // Pristup k databazovym poliam
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property CsType:Str1 read ReadCsType write WriteCsType;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property MgCode:word read ReadMgCode write WriteMgCode;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property Notice:Str30 read ReadNotice write WriteNotice;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property AcAValue:double read ReadAcAValue write WriteAcAValue;
    property AcBValue:double read ReadAcBValue write WriteAcBValue;
    property FgDPrice:double read ReadFgDPrice write WriteFgDPrice;
    property FgAPrice:double read ReadFgAPrice write WriteFgAPrice;
    property FgBPrice:double read ReadFgBPrice write WriteFgBPrice;
    property FgDValue:double read ReadFgDValue write WriteFgDValue;
    property FgDscVal:double read ReadFgDscVal write WriteFgDscVal;
    property FgAValue:double read ReadFgAValue write WriteFgAValue;
    property FgBValue:double read ReadFgBValue write WriteFgBValue;
    property DscType:Str1 read ReadDscType write WriteDscType;
    property DlrCode:word read ReadDlrCode write WriteDlrCode;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property GrtType:Str1 read ReadGrtType write WriteGrtType;
    property CasNum:word read ReadCasNum write WriteCasNum;
    property IcdNum:Str12 read ReadIcdNum write WriteIcdNum;
    property IcdItm:word read ReadIcdItm write WriteIcdItm;
    property IcdDate:TDatetime read ReadIcdDate write WriteIcdDate;
    property FinStat:Str1 read ReadFinStat write WriteFinStat;
    property Action:Str1 read ReadAction write WriteAction;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TScsBtr.Create;
begin
  oBtrTable := BtrInit ('SCS',gPath.StkPath,Self);
end;

constructor TScsBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('SCS',pPath,Self);
end;

destructor TScsBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TScsBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TScsBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TScsBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TScsBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TScsBtr.ReadCsType:Str1;
begin
  Result := oBtrTable.FieldByName('CsType').AsString;
end;

procedure TScsBtr.WriteCsType(pValue:Str1);
begin
  oBtrTable.FieldByName('CsType').AsString := pValue;
end;

function TScsBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TScsBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TScsBtr.ReadMgCode:word;
begin
  Result := oBtrTable.FieldByName('MgCode').AsInteger;
end;

procedure TScsBtr.WriteMgCode(pValue:word);
begin
  oBtrTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TScsBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TScsBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TScsBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TScsBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TScsBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TScsBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TScsBtr.ReadNotice:Str30;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TScsBtr.WriteNotice(pValue:Str30);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

function TScsBtr.ReadMsName:Str10;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TScsBtr.WriteMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TScsBtr.ReadGsQnt:double;
begin
  Result := oBtrTable.FieldByName('GsQnt').AsFloat;
end;

procedure TScsBtr.WriteGsQnt(pValue:double);
begin
  oBtrTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TScsBtr.ReadVatPrc:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsInteger;
end;

procedure TScsBtr.WriteVatPrc(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TScsBtr.ReadDscPrc:double;
begin
  Result := oBtrTable.FieldByName('DscPrc').AsFloat;
end;

procedure TScsBtr.WriteDscPrc(pValue:double);
begin
  oBtrTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TScsBtr.ReadAcAValue:double;
begin
  Result := oBtrTable.FieldByName('AcAValue').AsFloat;
end;

procedure TScsBtr.WriteAcAValue(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue').AsFloat := pValue;
end;

function TScsBtr.ReadAcBValue:double;
begin
  Result := oBtrTable.FieldByName('AcBValue').AsFloat;
end;

procedure TScsBtr.WriteAcBValue(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue').AsFloat := pValue;
end;

function TScsBtr.ReadFgDPrice:double;
begin
  Result := oBtrTable.FieldByName('FgDPrice').AsFloat;
end;

procedure TScsBtr.WriteFgDPrice(pValue:double);
begin
  oBtrTable.FieldByName('FgDPrice').AsFloat := pValue;
end;

function TScsBtr.ReadFgAPrice:double;
begin
  Result := oBtrTable.FieldByName('FgAPrice').AsFloat;
end;

procedure TScsBtr.WriteFgAPrice(pValue:double);
begin
  oBtrTable.FieldByName('FgAPrice').AsFloat := pValue;
end;

function TScsBtr.ReadFgBPrice:double;
begin
  Result := oBtrTable.FieldByName('FgBPrice').AsFloat;
end;

procedure TScsBtr.WriteFgBPrice(pValue:double);
begin
  oBtrTable.FieldByName('FgBPrice').AsFloat := pValue;
end;

function TScsBtr.ReadFgDValue:double;
begin
  Result := oBtrTable.FieldByName('FgDValue').AsFloat;
end;

procedure TScsBtr.WriteFgDValue(pValue:double);
begin
  oBtrTable.FieldByName('FgDValue').AsFloat := pValue;
end;

function TScsBtr.ReadFgDscVal:double;
begin
  Result := oBtrTable.FieldByName('FgDscVal').AsFloat;
end;

procedure TScsBtr.WriteFgDscVal(pValue:double);
begin
  oBtrTable.FieldByName('FgDscVal').AsFloat := pValue;
end;

function TScsBtr.ReadFgAValue:double;
begin
  Result := oBtrTable.FieldByName('FgAValue').AsFloat;
end;

procedure TScsBtr.WriteFgAValue(pValue:double);
begin
  oBtrTable.FieldByName('FgAValue').AsFloat := pValue;
end;

function TScsBtr.ReadFgBValue:double;
begin
  Result := oBtrTable.FieldByName('FgBValue').AsFloat;
end;

procedure TScsBtr.WriteFgBValue(pValue:double);
begin
  oBtrTable.FieldByName('FgBValue').AsFloat := pValue;
end;

function TScsBtr.ReadDscType:Str1;
begin
  Result := oBtrTable.FieldByName('DscType').AsString;
end;

procedure TScsBtr.WriteDscType(pValue:Str1);
begin
  oBtrTable.FieldByName('DscType').AsString := pValue;
end;

function TScsBtr.ReadDlrCode:word;
begin
  Result := oBtrTable.FieldByName('DlrCode').AsInteger;
end;

procedure TScsBtr.WriteDlrCode(pValue:word);
begin
  oBtrTable.FieldByName('DlrCode').AsInteger := pValue;
end;

function TScsBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TScsBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TScsBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TScsBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TScsBtr.ReadGrtType:Str1;
begin
  Result := oBtrTable.FieldByName('GrtType').AsString;
end;

procedure TScsBtr.WriteGrtType(pValue:Str1);
begin
  oBtrTable.FieldByName('GrtType').AsString := pValue;
end;

function TScsBtr.ReadCasNum:word;
begin
  Result := oBtrTable.FieldByName('CasNum').AsInteger;
end;

procedure TScsBtr.WriteCasNum(pValue:word);
begin
  oBtrTable.FieldByName('CasNum').AsInteger := pValue;
end;

function TScsBtr.ReadIcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('IcdNum').AsString;
end;

procedure TScsBtr.WriteIcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('IcdNum').AsString := pValue;
end;

function TScsBtr.ReadIcdItm:word;
begin
  Result := oBtrTable.FieldByName('IcdItm').AsInteger;
end;

procedure TScsBtr.WriteIcdItm(pValue:word);
begin
  oBtrTable.FieldByName('IcdItm').AsInteger := pValue;
end;

function TScsBtr.ReadIcdDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('IcdDate').AsDateTime;
end;

procedure TScsBtr.WriteIcdDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('IcdDate').AsDateTime := pValue;
end;

function TScsBtr.ReadFinStat:Str1;
begin
  Result := oBtrTable.FieldByName('FinStat').AsString;
end;

procedure TScsBtr.WriteFinStat(pValue:Str1);
begin
  oBtrTable.FieldByName('FinStat').AsString := pValue;
end;

function TScsBtr.ReadAction:Str1;
begin
  Result := oBtrTable.FieldByName('Action').AsString;
end;

procedure TScsBtr.WriteAction(pValue:Str1);
begin
  oBtrTable.FieldByName('Action').AsString := pValue;
end;

function TScsBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TScsBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TScsBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TScsBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TScsBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TScsBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TScsBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TScsBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TScsBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TScsBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TScsBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TScsBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TScsBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TScsBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TScsBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TScsBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TScsBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TScsBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TScsBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TScsBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TScsBtr.LocateDoCsIt (pDocNum:Str12;pCsType:Str1;pItmNum:word):boolean;
begin
  SetIndex (ixDoCsIt);
  Result := oBtrTable.FindKey([pDocNum,pCsType,pItmNum]);
end;

function TScsBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TScsBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TScsBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TScsBtr.LocateFinStat (pFinStat:Str1):boolean;
begin
  SetIndex (ixFinStat);
  Result := oBtrTable.FindKey([pFinStat]);
end;

function TScsBtr.NearestDoCsIt (pDocNum:Str12;pCsType:Str1;pItmNum:word):boolean;
begin
  SetIndex (ixDoCsIt);
  Result := oBtrTable.FindNearest([pDocNum,pCsType,pItmNum]);
end;

function TScsBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TScsBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TScsBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TScsBtr.NearestFinStat (pFinStat:Str1):boolean;
begin
  SetIndex (ixFinStat);
  Result := oBtrTable.FindNearest([pFinStat]);
end;

procedure TScsBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TScsBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TScsBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TScsBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TScsBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TScsBtr.First;
begin
  oBtrTable.First;
end;

procedure TScsBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TScsBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TScsBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TScsBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TScsBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TScsBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TScsBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TScsBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TScsBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TScsBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TScsBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
