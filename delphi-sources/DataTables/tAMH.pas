unit tAMH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = '';
  ixSerNum = 'SerNum';
  ixDocDate = 'DocDate';
  ixExpDate = 'ExpDate';
  ixPaCode = 'PaCode';
  ixPaName_ = 'PaName_';
  ixRefNum = 'RefNum';
  ixStatus = 'Status';

type
  TAmhTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadYear:Str2;             procedure WriteYear (pValue:Str2);
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadExpDate:TDatetime;     procedure WriteExpDate (pValue:TDatetime);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadPaName_:Str30;         procedure WritePaName_ (pValue:Str30);
    function  ReadRegName:Str60;         procedure WriteRegName (pValue:Str60);
    function  ReadRegAddr:Str30;         procedure WriteRegAddr (pValue:Str30);
    function  ReadRegZip:Str15;          procedure WriteRegZip (pValue:Str15);
    function  ReadRegCty:Str3;           procedure WriteRegCty (pValue:Str3);
    function  ReadRegCtn:Str30;          procedure WriteRegCtn (pValue:Str30);
    function  ReadRegSta:Str2;           procedure WriteRegSta (pValue:Str2);
    function  ReadRegIno:Str15;          procedure WriteRegIno (pValue:Str15);
    function  ReadRegTin:Str15;          procedure WriteRegTin (pValue:Str15);
    function  ReadRegVin:Str15;          procedure WriteRegVin (pValue:Str15);
    function  ReadRegTel:Str20;          procedure WriteRegTel (pValue:Str20);
    function  ReadRegFax:Str20;          procedure WriteRegFax (pValue:Str20);
    function  ReadRegEml:Str30;          procedure WriteRegEml (pValue:Str30);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadSurPrc:double;         procedure WriteSurPrc (pValue:double);
    function  ReadPenPrc:double;         procedure WritePenPrc (pValue:double);
    function  ReadRdiPrc:double;         procedure WriteRdiPrc (pValue:double);
    function  ReadRduPrc:double;         procedure WriteRduPrc (pValue:double);
    function  ReadSurVal:double;         procedure WriteSurVal (pValue:double);
    function  ReadAgAValue:double;       procedure WriteAgAValue (pValue:double);
    function  ReadAgBvalue:double;       procedure WriteAgBvalue (pValue:double);
    function  ReadAsDValue:double;       procedure WriteAsDValue (pValue:double);
    function  ReadAsHValue:double;       procedure WriteAsHValue (pValue:double);
    function  ReadAsDdsVal:double;       procedure WriteAsDdsVal (pValue:double);
    function  ReadAsHdsVal:double;       procedure WriteAsHdsVal (pValue:double);
    function  ReadAsAValue:double;       procedure WriteAsAValue (pValue:double);
    function  ReadAsBvalue:double;       procedure WriteAsBvalue (pValue:double);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
    function  ReadPrnCnt:byte;           procedure WritePrnCnt (pValue:byte);
    function  ReadDstLck:byte;           procedure WriteDstLck (pValue:byte);
    function  ReadAodNum:Str12;          procedure WriteAodNum (pValue:Str12);
    function  ReadRefNum:word;           procedure WriteRefNum (pValue:word);
    function  ReadRefTxt:Str30;          procedure WriteRefTxt (pValue:Str30);
    function  ReadStatus:Str1;           procedure WriteStatus (pValue:Str1);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateSerNum (pSerNum:longint):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateExpDate (pExpDate:TDatetime):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName_ (pPaName_:Str30):boolean;
    function LocateRefNum (pRefNum:word):boolean;
    function LocateStatus (pStatus:Str1):boolean;

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
    property Year:Str2 read ReadYear write WriteYear;
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property ExpDate:TDatetime read ReadExpDate write WriteExpDate;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property PaName_:Str30 read ReadPaName_ write WritePaName_;
    property RegName:Str60 read ReadRegName write WriteRegName;
    property RegAddr:Str30 read ReadRegAddr write WriteRegAddr;
    property RegZip:Str15 read ReadRegZip write WriteRegZip;
    property RegCty:Str3 read ReadRegCty write WriteRegCty;
    property RegCtn:Str30 read ReadRegCtn write WriteRegCtn;
    property RegSta:Str2 read ReadRegSta write WriteRegSta;
    property RegIno:Str15 read ReadRegIno write WriteRegIno;
    property RegTin:Str15 read ReadRegTin write WriteRegTin;
    property RegVin:Str15 read ReadRegVin write WriteRegVin;
    property RegTel:Str20 read ReadRegTel write WriteRegTel;
    property RegFax:Str20 read ReadRegFax write WriteRegFax;
    property RegEml:Str30 read ReadRegEml write WriteRegEml;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property SurPrc:double read ReadSurPrc write WriteSurPrc;
    property PenPrc:double read ReadPenPrc write WritePenPrc;
    property RdiPrc:double read ReadRdiPrc write WriteRdiPrc;
    property RduPrc:double read ReadRduPrc write WriteRduPrc;
    property SurVal:double read ReadSurVal write WriteSurVal;
    property AgAValue:double read ReadAgAValue write WriteAgAValue;
    property AgBvalue:double read ReadAgBvalue write WriteAgBvalue;
    property AsDValue:double read ReadAsDValue write WriteAsDValue;
    property AsHValue:double read ReadAsHValue write WriteAsHValue;
    property AsDdsVal:double read ReadAsDdsVal write WriteAsDdsVal;
    property AsHdsVal:double read ReadAsHdsVal write WriteAsHdsVal;
    property AsAValue:double read ReadAsAValue write WriteAsAValue;
    property AsBvalue:double read ReadAsBvalue write WriteAsBvalue;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
    property PrnCnt:byte read ReadPrnCnt write WritePrnCnt;
    property DstLck:byte read ReadDstLck write WriteDstLck;
    property AodNum:Str12 read ReadAodNum write WriteAodNum;
    property RefNum:word read ReadRefNum write WriteRefNum;
    property RefTxt:Str30 read ReadRefTxt write WriteRefTxt;
    property Status:Str1 read ReadStatus write WriteStatus;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TAmhTmp.Create;
begin
  oTmpTable := TmpInit ('AMH',Self);
end;

destructor TAmhTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TAmhTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TAmhTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TAmhTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TAmhTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TAmhTmp.ReadYear:Str2;
begin
  Result := oTmpTable.FieldByName('Year').AsString;
end;

procedure TAmhTmp.WriteYear(pValue:Str2);
begin
  oTmpTable.FieldByName('Year').AsString := pValue;
end;

function TAmhTmp.ReadSerNum:longint;
begin
  Result := oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TAmhTmp.WriteSerNum(pValue:longint);
begin
  oTmpTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TAmhTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TAmhTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TAmhTmp.ReadExpDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ExpDate').AsDateTime;
end;

procedure TAmhTmp.WriteExpDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ExpDate').AsDateTime := pValue;
end;

function TAmhTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TAmhTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TAmhTmp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TAmhTmp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TAmhTmp.ReadPaName_:Str30;
begin
  Result := oTmpTable.FieldByName('PaName_').AsString;
end;

procedure TAmhTmp.WritePaName_(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName_').AsString := pValue;
end;

function TAmhTmp.ReadRegName:Str60;
begin
  Result := oTmpTable.FieldByName('RegName').AsString;
end;

procedure TAmhTmp.WriteRegName(pValue:Str60);
begin
  oTmpTable.FieldByName('RegName').AsString := pValue;
end;

function TAmhTmp.ReadRegAddr:Str30;
begin
  Result := oTmpTable.FieldByName('RegAddr').AsString;
end;

procedure TAmhTmp.WriteRegAddr(pValue:Str30);
begin
  oTmpTable.FieldByName('RegAddr').AsString := pValue;
end;

function TAmhTmp.ReadRegZip:Str15;
begin
  Result := oTmpTable.FieldByName('RegZip').AsString;
end;

procedure TAmhTmp.WriteRegZip(pValue:Str15);
begin
  oTmpTable.FieldByName('RegZip').AsString := pValue;
end;

function TAmhTmp.ReadRegCty:Str3;
begin
  Result := oTmpTable.FieldByName('RegCty').AsString;
end;

procedure TAmhTmp.WriteRegCty(pValue:Str3);
begin
  oTmpTable.FieldByName('RegCty').AsString := pValue;
end;

function TAmhTmp.ReadRegCtn:Str30;
begin
  Result := oTmpTable.FieldByName('RegCtn').AsString;
end;

procedure TAmhTmp.WriteRegCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('RegCtn').AsString := pValue;
end;

function TAmhTmp.ReadRegSta:Str2;
begin
  Result := oTmpTable.FieldByName('RegSta').AsString;
end;

procedure TAmhTmp.WriteRegSta(pValue:Str2);
begin
  oTmpTable.FieldByName('RegSta').AsString := pValue;
end;

function TAmhTmp.ReadRegIno:Str15;
begin
  Result := oTmpTable.FieldByName('RegIno').AsString;
end;

procedure TAmhTmp.WriteRegIno(pValue:Str15);
begin
  oTmpTable.FieldByName('RegIno').AsString := pValue;
end;

function TAmhTmp.ReadRegTin:Str15;
begin
  Result := oTmpTable.FieldByName('RegTin').AsString;
end;

procedure TAmhTmp.WriteRegTin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegTin').AsString := pValue;
end;

function TAmhTmp.ReadRegVin:Str15;
begin
  Result := oTmpTable.FieldByName('RegVin').AsString;
end;

procedure TAmhTmp.WriteRegVin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegVin').AsString := pValue;
end;

function TAmhTmp.ReadRegTel:Str20;
begin
  Result := oTmpTable.FieldByName('RegTel').AsString;
end;

procedure TAmhTmp.WriteRegTel(pValue:Str20);
begin
  oTmpTable.FieldByName('RegTel').AsString := pValue;
end;

function TAmhTmp.ReadRegFax:Str20;
begin
  Result := oTmpTable.FieldByName('RegFax').AsString;
end;

procedure TAmhTmp.WriteRegFax(pValue:Str20);
begin
  oTmpTable.FieldByName('RegFax').AsString := pValue;
end;

function TAmhTmp.ReadRegEml:Str30;
begin
  Result := oTmpTable.FieldByName('RegEml').AsString;
end;

procedure TAmhTmp.WriteRegEml(pValue:Str30);
begin
  oTmpTable.FieldByName('RegEml').AsString := pValue;
end;

function TAmhTmp.ReadDscPrc:double;
begin
  Result := oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TAmhTmp.WriteDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TAmhTmp.ReadSurPrc:double;
begin
  Result := oTmpTable.FieldByName('SurPrc').AsFloat;
end;

procedure TAmhTmp.WriteSurPrc(pValue:double);
begin
  oTmpTable.FieldByName('SurPrc').AsFloat := pValue;
end;

function TAmhTmp.ReadPenPrc:double;
begin
  Result := oTmpTable.FieldByName('PenPrc').AsFloat;
end;

procedure TAmhTmp.WritePenPrc(pValue:double);
begin
  oTmpTable.FieldByName('PenPrc').AsFloat := pValue;
end;

function TAmhTmp.ReadRdiPrc:double;
begin
  Result := oTmpTable.FieldByName('RdiPrc').AsFloat;
end;

procedure TAmhTmp.WriteRdiPrc(pValue:double);
begin
  oTmpTable.FieldByName('RdiPrc').AsFloat := pValue;
end;

function TAmhTmp.ReadRduPrc:double;
begin
  Result := oTmpTable.FieldByName('RduPrc').AsFloat;
end;

procedure TAmhTmp.WriteRduPrc(pValue:double);
begin
  oTmpTable.FieldByName('RduPrc').AsFloat := pValue;
end;

function TAmhTmp.ReadSurVal:double;
begin
  Result := oTmpTable.FieldByName('SurVal').AsFloat;
end;

procedure TAmhTmp.WriteSurVal(pValue:double);
begin
  oTmpTable.FieldByName('SurVal').AsFloat := pValue;
end;

function TAmhTmp.ReadAgAValue:double;
begin
  Result := oTmpTable.FieldByName('AgAValue').AsFloat;
end;

procedure TAmhTmp.WriteAgAValue(pValue:double);
begin
  oTmpTable.FieldByName('AgAValue').AsFloat := pValue;
end;

function TAmhTmp.ReadAgBvalue:double;
begin
  Result := oTmpTable.FieldByName('AgBvalue').AsFloat;
end;

procedure TAmhTmp.WriteAgBvalue(pValue:double);
begin
  oTmpTable.FieldByName('AgBvalue').AsFloat := pValue;
end;

function TAmhTmp.ReadAsDValue:double;
begin
  Result := oTmpTable.FieldByName('AsDValue').AsFloat;
end;

procedure TAmhTmp.WriteAsDValue(pValue:double);
begin
  oTmpTable.FieldByName('AsDValue').AsFloat := pValue;
end;

function TAmhTmp.ReadAsHValue:double;
begin
  Result := oTmpTable.FieldByName('AsHValue').AsFloat;
end;

procedure TAmhTmp.WriteAsHValue(pValue:double);
begin
  oTmpTable.FieldByName('AsHValue').AsFloat := pValue;
end;

function TAmhTmp.ReadAsDdsVal:double;
begin
  Result := oTmpTable.FieldByName('AsDdsVal').AsFloat;
end;

procedure TAmhTmp.WriteAsDdsVal(pValue:double);
begin
  oTmpTable.FieldByName('AsDdsVal').AsFloat := pValue;
end;

function TAmhTmp.ReadAsHdsVal:double;
begin
  Result := oTmpTable.FieldByName('AsHdsVal').AsFloat;
end;

procedure TAmhTmp.WriteAsHdsVal(pValue:double);
begin
  oTmpTable.FieldByName('AsHdsVal').AsFloat := pValue;
end;

function TAmhTmp.ReadAsAValue:double;
begin
  Result := oTmpTable.FieldByName('AsAValue').AsFloat;
end;

procedure TAmhTmp.WriteAsAValue(pValue:double);
begin
  oTmpTable.FieldByName('AsAValue').AsFloat := pValue;
end;

function TAmhTmp.ReadAsBvalue:double;
begin
  Result := oTmpTable.FieldByName('AsBvalue').AsFloat;
end;

procedure TAmhTmp.WriteAsBvalue(pValue:double);
begin
  oTmpTable.FieldByName('AsBvalue').AsFloat := pValue;
end;

function TAmhTmp.ReadItmQnt:word;
begin
  Result := oTmpTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TAmhTmp.WriteItmQnt(pValue:word);
begin
  oTmpTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TAmhTmp.ReadPrnCnt:byte;
begin
  Result := oTmpTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TAmhTmp.WritePrnCnt(pValue:byte);
begin
  oTmpTable.FieldByName('PrnCnt').AsInteger := pValue;
end;

function TAmhTmp.ReadDstLck:byte;
begin
  Result := oTmpTable.FieldByName('DstLck').AsInteger;
end;

procedure TAmhTmp.WriteDstLck(pValue:byte);
begin
  oTmpTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TAmhTmp.ReadAodNum:Str12;
begin
  Result := oTmpTable.FieldByName('AodNum').AsString;
end;

procedure TAmhTmp.WriteAodNum(pValue:Str12);
begin
  oTmpTable.FieldByName('AodNum').AsString := pValue;
end;

function TAmhTmp.ReadRefNum:word;
begin
  Result := oTmpTable.FieldByName('RefNum').AsInteger;
end;

procedure TAmhTmp.WriteRefNum(pValue:word);
begin
  oTmpTable.FieldByName('RefNum').AsInteger := pValue;
end;

function TAmhTmp.ReadRefTxt:Str30;
begin
  Result := oTmpTable.FieldByName('RefTxt').AsString;
end;

procedure TAmhTmp.WriteRefTxt(pValue:Str30);
begin
  oTmpTable.FieldByName('RefTxt').AsString := pValue;
end;

function TAmhTmp.ReadStatus:Str1;
begin
  Result := oTmpTable.FieldByName('Status').AsString;
end;

procedure TAmhTmp.WriteStatus(pValue:Str1);
begin
  oTmpTable.FieldByName('Status').AsString := pValue;
end;

function TAmhTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TAmhTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TAmhTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TAmhTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TAmhTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TAmhTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TAmhTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TAmhTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TAmhTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TAmhTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TAmhTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TAmhTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TAmhTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TAmhTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAmhTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TAmhTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TAmhTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TAmhTmp.LocateSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oTmpTable.FindKey([pSerNum]);
end;

function TAmhTmp.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oTmpTable.FindKey([pDocDate]);
end;

function TAmhTmp.LocateExpDate (pExpDate:TDatetime):boolean;
begin
  SetIndex (ixExpDate);
  Result := oTmpTable.FindKey([pExpDate]);
end;

function TAmhTmp.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oTmpTable.FindKey([pPaCode]);
end;

function TAmhTmp.LocatePaName_ (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName_);
  Result := oTmpTable.FindKey([pPaName_]);
end;

function TAmhTmp.LocateRefNum (pRefNum:word):boolean;
begin
  SetIndex (ixRefNum);
  Result := oTmpTable.FindKey([pRefNum]);
end;

function TAmhTmp.LocateStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oTmpTable.FindKey([pStatus]);
end;

procedure TAmhTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TAmhTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TAmhTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TAmhTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TAmhTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TAmhTmp.First;
begin
  oTmpTable.First;
end;

procedure TAmhTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TAmhTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TAmhTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TAmhTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TAmhTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TAmhTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TAmhTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TAmhTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TAmhTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TAmhTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TAmhTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
