unit tFXA;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = '';
  ixSerNum = 'SerNum';
  ixFxaName_ = 'FxaName_';
  ixWriNum = 'WriNum';
  ixBegDate = 'BegDate';
  ixExtNum = 'ExtNum';
  ixDocDate = 'DocDate';
  ixClasCode = 'ClasCode';
  ixPrvDoc = 'PrvDoc';
  ixPrvDate = 'PrvDate';
  ixPrvVal = 'PrvVal';

type
  TFxaTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
    function  ReadExtNum:Str12;          procedure WriteExtNum (pValue:Str12);
    function  ReadFxaName:Str30;         procedure WriteFxaName (pValue:Str30);
    function  ReadFxaName_:Str30;        procedure WriteFxaName_ (pValue:Str30);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadWriNum:longint;        procedure WriteWriNum (pValue:longint);
    function  ReadClasCode:Str10;        procedure WriteClasCode (pValue:Str10);
    function  ReadPrvDoc:Str12;          procedure WritePrvDoc (pValue:Str12);
    function  ReadPrvMode:byte;          procedure WritePrvMode (pValue:byte);
    function  ReadPrvDate:TDatetime;     procedure WritePrvDate (pValue:TDatetime);
    function  ReadPrvVal:double;         procedure WritePrvVal (pValue:double);
    function  ReadBegDoc:Str12;          procedure WriteBegDoc (pValue:Str12);
    function  ReadBegDate:TDatetime;     procedure WriteBegDate (pValue:TDatetime);
    function  ReadAsdDoc:Str12;          procedure WriteAsdDoc (pValue:Str12);
    function  ReadAsdDate:TDatetime;     procedure WriteAsdDate (pValue:TDatetime);
    function  ReadAsdMode:longint;       procedure WriteAsdMode (pValue:longint);
    function  ReadChgVal:double;         procedure WriteChgVal (pValue:double);
    function  ReadModVal:double;         procedure WriteModVal (pValue:double);
    function  ReadSuVal:double;          procedure WriteSuVal (pValue:double);
    function  ReadTEndVal:double;        procedure WriteTEndVal (pValue:double);
    function  ReadLEndVal:double;        procedure WriteLEndVal (pValue:double);
    function  ReadFxaType:byte;          procedure WriteFxaType (pValue:byte);
    function  ReadTsuGrp:byte;           procedure WriteTsuGrp (pValue:byte);
    function  ReadTsuMode:byte;          procedure WriteTsuMode (pValue:byte);
    function  ReadTsuYear:byte;          procedure WriteTsuYear (pValue:byte);
    function  ReadTItmQnt:byte;          procedure WriteTItmQnt (pValue:byte);
    function  ReadLsuMode:byte;          procedure WriteLsuMode (pValue:byte);
    function  ReadLsuYear:byte;          procedure WriteLsuYear (pValue:byte);
    function  ReadLItmQnt:word;          procedure WriteLItmQnt (pValue:word);
    function  ReadFxaGrp:longint;        procedure WriteFxaGrp (pValue:longint);
    function  ReadUseName:Str30;         procedure WriteUseName (pValue:Str30);
    function  ReadStatus:Str1;           procedure WriteStatus (pValue:Str1);
    function  ReadCrtName:Str8;          procedure WriteCrtName (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateSerNum (pSerNum:longint):boolean;
    function LocateFxaName_ (pFxaName_:Str30):boolean;
    function LocateWriNum (pWriNum:longint):boolean;
    function LocateBegDate (pBegDate:TDatetime):boolean;
    function LocateExtNum (pExtNum:Str12):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateClasCode (pClasCode:Str10):boolean;
    function LocatePrvDoc (pPrvDoc:Str12):boolean;
    function LocatePrvDate (pPrvDate:TDatetime):boolean;
    function LocatePrvVal (pPrvVal:double):boolean;

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
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property ExtNum:Str12 read ReadExtNum write WriteExtNum;
    property FxaName:Str30 read ReadFxaName write WriteFxaName;
    property FxaName_:Str30 read ReadFxaName_ write WriteFxaName_;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property WriNum:longint read ReadWriNum write WriteWriNum;
    property ClasCode:Str10 read ReadClasCode write WriteClasCode;
    property PrvDoc:Str12 read ReadPrvDoc write WritePrvDoc;
    property PrvMode:byte read ReadPrvMode write WritePrvMode;
    property PrvDate:TDatetime read ReadPrvDate write WritePrvDate;
    property PrvVal:double read ReadPrvVal write WritePrvVal;
    property BegDoc:Str12 read ReadBegDoc write WriteBegDoc;
    property BegDate:TDatetime read ReadBegDate write WriteBegDate;
    property AsdDoc:Str12 read ReadAsdDoc write WriteAsdDoc;
    property AsdDate:TDatetime read ReadAsdDate write WriteAsdDate;
    property AsdMode:longint read ReadAsdMode write WriteAsdMode;
    property ChgVal:double read ReadChgVal write WriteChgVal;
    property ModVal:double read ReadModVal write WriteModVal;
    property SuVal:double read ReadSuVal write WriteSuVal;
    property TEndVal:double read ReadTEndVal write WriteTEndVal;
    property LEndVal:double read ReadLEndVal write WriteLEndVal;
    property FxaType:byte read ReadFxaType write WriteFxaType;
    property TsuGrp:byte read ReadTsuGrp write WriteTsuGrp;
    property TsuMode:byte read ReadTsuMode write WriteTsuMode;
    property TsuYear:byte read ReadTsuYear write WriteTsuYear;
    property TItmQnt:byte read ReadTItmQnt write WriteTItmQnt;
    property LsuMode:byte read ReadLsuMode write WriteLsuMode;
    property LsuYear:byte read ReadLsuYear write WriteLsuYear;
    property LItmQnt:word read ReadLItmQnt write WriteLItmQnt;
    property FxaGrp:longint read ReadFxaGrp write WriteFxaGrp;
    property UseName:Str30 read ReadUseName write WriteUseName;
    property Status:Str1 read ReadStatus write WriteStatus;
    property CrtName:Str8 read ReadCrtName write WriteCrtName;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TFxaTmp.Create;
begin
  oTmpTable := TmpInit ('FXA',Self);
end;

destructor TFxaTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TFxaTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TFxaTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TFxaTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TFxaTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TFxaTmp.ReadSerNum:longint;
begin
  Result := oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TFxaTmp.WriteSerNum(pValue:longint);
begin
  oTmpTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TFxaTmp.ReadExtNum:Str12;
begin
  Result := oTmpTable.FieldByName('ExtNum').AsString;
end;

procedure TFxaTmp.WriteExtNum(pValue:Str12);
begin
  oTmpTable.FieldByName('ExtNum').AsString := pValue;
end;

function TFxaTmp.ReadFxaName:Str30;
begin
  Result := oTmpTable.FieldByName('FxaName').AsString;
end;

procedure TFxaTmp.WriteFxaName(pValue:Str30);
begin
  oTmpTable.FieldByName('FxaName').AsString := pValue;
end;

function TFxaTmp.ReadFxaName_:Str30;
begin
  Result := oTmpTable.FieldByName('FxaName_').AsString;
end;

procedure TFxaTmp.WriteFxaName_(pValue:Str30);
begin
  oTmpTable.FieldByName('FxaName_').AsString := pValue;
end;

function TFxaTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TFxaTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TFxaTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TFxaTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TFxaTmp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TFxaTmp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TFxaTmp.ReadWriNum:longint;
begin
  Result := oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TFxaTmp.WriteWriNum(pValue:longint);
begin
  oTmpTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TFxaTmp.ReadClasCode:Str10;
begin
  Result := oTmpTable.FieldByName('ClasCode').AsString;
end;

procedure TFxaTmp.WriteClasCode(pValue:Str10);
begin
  oTmpTable.FieldByName('ClasCode').AsString := pValue;
end;

function TFxaTmp.ReadPrvDoc:Str12;
begin
  Result := oTmpTable.FieldByName('PrvDoc').AsString;
end;

procedure TFxaTmp.WritePrvDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('PrvDoc').AsString := pValue;
end;

function TFxaTmp.ReadPrvMode:byte;
begin
  Result := oTmpTable.FieldByName('PrvMode').AsInteger;
end;

procedure TFxaTmp.WritePrvMode(pValue:byte);
begin
  oTmpTable.FieldByName('PrvMode').AsInteger := pValue;
end;

function TFxaTmp.ReadPrvDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('PrvDate').AsDateTime;
end;

procedure TFxaTmp.WritePrvDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('PrvDate').AsDateTime := pValue;
end;

function TFxaTmp.ReadPrvVal:double;
begin
  Result := oTmpTable.FieldByName('PrvVal').AsFloat;
end;

procedure TFxaTmp.WritePrvVal(pValue:double);
begin
  oTmpTable.FieldByName('PrvVal').AsFloat := pValue;
end;

function TFxaTmp.ReadBegDoc:Str12;
begin
  Result := oTmpTable.FieldByName('BegDoc').AsString;
end;

procedure TFxaTmp.WriteBegDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('BegDoc').AsString := pValue;
end;

function TFxaTmp.ReadBegDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('BegDate').AsDateTime;
end;

procedure TFxaTmp.WriteBegDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('BegDate').AsDateTime := pValue;
end;

function TFxaTmp.ReadAsdDoc:Str12;
begin
  Result := oTmpTable.FieldByName('AsdDoc').AsString;
end;

procedure TFxaTmp.WriteAsdDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('AsdDoc').AsString := pValue;
end;

function TFxaTmp.ReadAsdDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('AsdDate').AsDateTime;
end;

procedure TFxaTmp.WriteAsdDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('AsdDate').AsDateTime := pValue;
end;

function TFxaTmp.ReadAsdMode:longint;
begin
  Result := oTmpTable.FieldByName('AsdMode').AsInteger;
end;

procedure TFxaTmp.WriteAsdMode(pValue:longint);
begin
  oTmpTable.FieldByName('AsdMode').AsInteger := pValue;
end;

function TFxaTmp.ReadChgVal:double;
begin
  Result := oTmpTable.FieldByName('ChgVal').AsFloat;
end;

procedure TFxaTmp.WriteChgVal(pValue:double);
begin
  oTmpTable.FieldByName('ChgVal').AsFloat := pValue;
end;

function TFxaTmp.ReadModVal:double;
begin
  Result := oTmpTable.FieldByName('ModVal').AsFloat;
end;

procedure TFxaTmp.WriteModVal(pValue:double);
begin
  oTmpTable.FieldByName('ModVal').AsFloat := pValue;
end;

function TFxaTmp.ReadSuVal:double;
begin
  Result := oTmpTable.FieldByName('SuVal').AsFloat;
end;

procedure TFxaTmp.WriteSuVal(pValue:double);
begin
  oTmpTable.FieldByName('SuVal').AsFloat := pValue;
end;

function TFxaTmp.ReadTEndVal:double;
begin
  Result := oTmpTable.FieldByName('TEndVal').AsFloat;
end;

procedure TFxaTmp.WriteTEndVal(pValue:double);
begin
  oTmpTable.FieldByName('TEndVal').AsFloat := pValue;
end;

function TFxaTmp.ReadLEndVal:double;
begin
  Result := oTmpTable.FieldByName('LEndVal').AsFloat;
end;

procedure TFxaTmp.WriteLEndVal(pValue:double);
begin
  oTmpTable.FieldByName('LEndVal').AsFloat := pValue;
end;

function TFxaTmp.ReadFxaType:byte;
begin
  Result := oTmpTable.FieldByName('FxaType').AsInteger;
end;

procedure TFxaTmp.WriteFxaType(pValue:byte);
begin
  oTmpTable.FieldByName('FxaType').AsInteger := pValue;
end;

function TFxaTmp.ReadTsuGrp:byte;
begin
  Result := oTmpTable.FieldByName('TsuGrp').AsInteger;
end;

procedure TFxaTmp.WriteTsuGrp(pValue:byte);
begin
  oTmpTable.FieldByName('TsuGrp').AsInteger := pValue;
end;

function TFxaTmp.ReadTsuMode:byte;
begin
  Result := oTmpTable.FieldByName('TsuMode').AsInteger;
end;

procedure TFxaTmp.WriteTsuMode(pValue:byte);
begin
  oTmpTable.FieldByName('TsuMode').AsInteger := pValue;
end;

function TFxaTmp.ReadTsuYear:byte;
begin
  Result := oTmpTable.FieldByName('TsuYear').AsInteger;
end;

procedure TFxaTmp.WriteTsuYear(pValue:byte);
begin
  oTmpTable.FieldByName('TsuYear').AsInteger := pValue;
end;

function TFxaTmp.ReadTItmQnt:byte;
begin
  Result := oTmpTable.FieldByName('TItmQnt').AsInteger;
end;

procedure TFxaTmp.WriteTItmQnt(pValue:byte);
begin
  oTmpTable.FieldByName('TItmQnt').AsInteger := pValue;
end;

function TFxaTmp.ReadLsuMode:byte;
begin
  Result := oTmpTable.FieldByName('LsuMode').AsInteger;
end;

procedure TFxaTmp.WriteLsuMode(pValue:byte);
begin
  oTmpTable.FieldByName('LsuMode').AsInteger := pValue;
end;

function TFxaTmp.ReadLsuYear:byte;
begin
  Result := oTmpTable.FieldByName('LsuYear').AsInteger;
end;

procedure TFxaTmp.WriteLsuYear(pValue:byte);
begin
  oTmpTable.FieldByName('LsuYear').AsInteger := pValue;
end;

function TFxaTmp.ReadLItmQnt:word;
begin
  Result := oTmpTable.FieldByName('LItmQnt').AsInteger;
end;

procedure TFxaTmp.WriteLItmQnt(pValue:word);
begin
  oTmpTable.FieldByName('LItmQnt').AsInteger := pValue;
end;

function TFxaTmp.ReadFxaGrp:longint;
begin
  Result := oTmpTable.FieldByName('FxaGrp').AsInteger;
end;

procedure TFxaTmp.WriteFxaGrp(pValue:longint);
begin
  oTmpTable.FieldByName('FxaGrp').AsInteger := pValue;
end;

function TFxaTmp.ReadUseName:Str30;
begin
  Result := oTmpTable.FieldByName('UseName').AsString;
end;

procedure TFxaTmp.WriteUseName(pValue:Str30);
begin
  oTmpTable.FieldByName('UseName').AsString := pValue;
end;

function TFxaTmp.ReadStatus:Str1;
begin
  Result := oTmpTable.FieldByName('Status').AsString;
end;

procedure TFxaTmp.WriteStatus(pValue:Str1);
begin
  oTmpTable.FieldByName('Status').AsString := pValue;
end;

function TFxaTmp.ReadCrtName:Str8;
begin
  Result := oTmpTable.FieldByName('CrtName').AsString;
end;

procedure TFxaTmp.WriteCrtName(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtName').AsString := pValue;
end;

function TFxaTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TFxaTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TFxaTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TFxaTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TFxaTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TFxaTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TFxaTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TFxaTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TFxaTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TFxaTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TFxaTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TFxaTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TFxaTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TFxaTmp.LocateSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oTmpTable.FindKey([pSerNum]);
end;

function TFxaTmp.LocateFxaName_ (pFxaName_:Str30):boolean;
begin
  SetIndex (ixFxaName_);
  Result := oTmpTable.FindKey([pFxaName_]);
end;

function TFxaTmp.LocateWriNum (pWriNum:longint):boolean;
begin
  SetIndex (ixWriNum);
  Result := oTmpTable.FindKey([pWriNum]);
end;

function TFxaTmp.LocateBegDate (pBegDate:TDatetime):boolean;
begin
  SetIndex (ixBegDate);
  Result := oTmpTable.FindKey([pBegDate]);
end;

function TFxaTmp.LocateExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oTmpTable.FindKey([pExtNum]);
end;

function TFxaTmp.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oTmpTable.FindKey([pDocDate]);
end;

function TFxaTmp.LocateClasCode (pClasCode:Str10):boolean;
begin
  SetIndex (ixClasCode);
  Result := oTmpTable.FindKey([pClasCode]);
end;

function TFxaTmp.LocatePrvDoc (pPrvDoc:Str12):boolean;
begin
  SetIndex (ixPrvDoc);
  Result := oTmpTable.FindKey([pPrvDoc]);
end;

function TFxaTmp.LocatePrvDate (pPrvDate:TDatetime):boolean;
begin
  SetIndex (ixPrvDate);
  Result := oTmpTable.FindKey([pPrvDate]);
end;

function TFxaTmp.LocatePrvVal (pPrvVal:double):boolean;
begin
  SetIndex (ixPrvVal);
  Result := oTmpTable.FindKey([pPrvVal]);
end;

procedure TFxaTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TFxaTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TFxaTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TFxaTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TFxaTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TFxaTmp.First;
begin
  oTmpTable.First;
end;

procedure TFxaTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TFxaTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TFxaTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TFxaTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TFxaTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TFxaTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TFxaTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TFxaTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TFxaTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TFxaTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TFxaTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
