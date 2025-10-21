unit bCRDLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixCrdNum = 'CrdNum';
  ixCrdName = 'CrdName';
  ixPaCode = 'PaCode';
  ixPaName = 'PaName';
  ixSended = 'Sended';
  ixCrdGrp = 'CrdGrp';

type
  TCrdlstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadCrdNum:Str20;          procedure WriteCrdNum (pValue:Str20);
    function  ReadCrdName:Str30;         procedure WriteCrdName (pValue:Str30);
    function  ReadCrdName_:Str30;        procedure WriteCrdName_ (pValue:Str30);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str60;          procedure WritePaName (pValue:Str60);
    function  ReadPaName_:Str30;         procedure WritePaName_ (pValue:Str30);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadBegDate:TDatetime;     procedure WriteBegDate (pValue:TDatetime);
    function  ReadEndDate:TDatetime;     procedure WriteEndDate (pValue:TDatetime);
    function  ReadCrdType:Str1;          procedure WriteCrdType (pValue:Str1);
    function  ReadDscType:Str5;          procedure WriteDscType (pValue:Str5);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadDocVal:double;         procedure WriteDocVal (pValue:double);
    function  ReadBonTrn:double;         procedure WriteBonTrn (pValue:double);
    function  ReadBonVal:double;         procedure WriteBonVal (pValue:double);
    function  ReadBegBon:word;           procedure WriteBegBon (pValue:word);
    function  ReadInpBon:word;           procedure WriteInpBon (pValue:word);
    function  ReadOutBon:word;           procedure WriteOutBon (pValue:word);
    function  ReadCrdGrp:word;           procedure WriteCrdGrp (pValue:word);
    function  ReadIdcNum:Str10;          procedure WriteIdcNum (pValue:Str10);
    function  ReadActBon:word;           procedure WriteActBon (pValue:word);
    function  ReadBegVal:double;         procedure WriteBegVal (pValue:double);
    function  ReadNouVal:double;         procedure WriteNouVal (pValue:double);
    function  ReadNebVal:double;         procedure WriteNebVal (pValue:double);
    function  ReadTrnVal:double;         procedure WriteTrnVal (pValue:double);
    function  ReadLasItm:word;           procedure WriteLasItm (pValue:word);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateCrdNum (pCrdNum:Str20):boolean;
    function LocateCrdName (pCrdName_:Str30):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName (pPaName_:Str30):boolean;
    function LocateSended (pSended:byte):boolean;
    function LocateCrdGrp (pCrdGrp:word):boolean;
    function NearestCrdNum (pCrdNum:Str20):boolean;
    function NearestCrdName (pCrdName_:Str30):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
    function NearestPaName (pPaName_:Str30):boolean;
    function NearestSended (pSended:byte):boolean;
    function NearestCrdGrp (pCrdGrp:word):boolean;

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
    property CrdNum:Str20 read ReadCrdNum write WriteCrdNum;
    property CrdName:Str30 read ReadCrdName write WriteCrdName;
    property CrdName_:Str30 read ReadCrdName_ write WriteCrdName_;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str60 read ReadPaName write WritePaName;
    property PaName_:Str30 read ReadPaName_ write WritePaName_;
    property Sended:boolean read ReadSended write WriteSended;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property BegDate:TDatetime read ReadBegDate write WriteBegDate;
    property EndDate:TDatetime read ReadEndDate write WriteEndDate;
    property CrdType:Str1 read ReadCrdType write WriteCrdType;
    property DscType:Str5 read ReadDscType write WriteDscType;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property DocVal:double read ReadDocVal write WriteDocVal;
    property BonTrn:double read ReadBonTrn write WriteBonTrn;
    property BonVal:double read ReadBonVal write WriteBonVal;
    property BegBon:word read ReadBegBon write WriteBegBon;
    property InpBon:word read ReadInpBon write WriteInpBon;
    property OutBon:word read ReadOutBon write WriteOutBon;
    property CrdGrp:word read ReadCrdGrp write WriteCrdGrp;
    property IdcNum:Str10 read ReadIdcNum write WriteIdcNum;
    property ActBon:word read ReadActBon write WriteActBon;
    property BegVal:double read ReadBegVal write WriteBegVal;
    property NouVal:double read ReadNouVal write WriteNouVal;
    property NebVal:double read ReadNebVal write WriteNebVal;
    property TrnVal:double read ReadTrnVal write WriteTrnVal;
    property LasItm:word read ReadLasItm write WriteLasItm;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
  end;

implementation

constructor TCrdlstBtr.Create;
begin
  oBtrTable := BtrInit ('CRDLST',gPath.DlsPath,Self);
end;

constructor TCrdlstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('CRDLST',pPath,Self);
end;

destructor TCrdlstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TCrdlstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TCrdlstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TCrdlstBtr.ReadCrdNum:Str20;
begin
  Result := oBtrTable.FieldByName('CrdNum').AsString;
end;

procedure TCrdlstBtr.WriteCrdNum(pValue:Str20);
begin
  oBtrTable.FieldByName('CrdNum').AsString := pValue;
end;

function TCrdlstBtr.ReadCrdName:Str30;
begin
  Result := oBtrTable.FieldByName('CrdName').AsString;
end;

procedure TCrdlstBtr.WriteCrdName(pValue:Str30);
begin
  oBtrTable.FieldByName('CrdName').AsString := pValue;
end;

function TCrdlstBtr.ReadCrdName_:Str30;
begin
  Result := oBtrTable.FieldByName('CrdName_').AsString;
end;

procedure TCrdlstBtr.WriteCrdName_(pValue:Str30);
begin
  oBtrTable.FieldByName('CrdName_').AsString := pValue;
end;

function TCrdlstBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TCrdlstBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TCrdlstBtr.ReadPaName:Str60;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TCrdlstBtr.WritePaName(pValue:Str60);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TCrdlstBtr.ReadPaName_:Str30;
begin
  Result := oBtrTable.FieldByName('PaName_').AsString;
end;

procedure TCrdlstBtr.WritePaName_(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName_').AsString := pValue;
end;

function TCrdlstBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TCrdlstBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TCrdlstBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TCrdlstBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TCrdlstBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TCrdlstBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TCrdlstBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TCrdlstBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TCrdlstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TCrdlstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TCrdlstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TCrdlstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TCrdlstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TCrdlstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TCrdlstBtr.ReadBegDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegDate').AsDateTime;
end;

procedure TCrdlstBtr.WriteBegDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegDate').AsDateTime := pValue;
end;

function TCrdlstBtr.ReadEndDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndDate').AsDateTime;
end;

procedure TCrdlstBtr.WriteEndDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndDate').AsDateTime := pValue;
end;

function TCrdlstBtr.ReadCrdType:Str1;
begin
  Result := oBtrTable.FieldByName('CrdType').AsString;
end;

procedure TCrdlstBtr.WriteCrdType(pValue:Str1);
begin
  oBtrTable.FieldByName('CrdType').AsString := pValue;
end;

function TCrdlstBtr.ReadDscType:Str5;
begin
  Result := oBtrTable.FieldByName('DscType').AsString;
end;

procedure TCrdlstBtr.WriteDscType(pValue:Str5);
begin
  oBtrTable.FieldByName('DscType').AsString := pValue;
end;

function TCrdlstBtr.ReadDscPrc:double;
begin
  Result := oBtrTable.FieldByName('DscPrc').AsFloat;
end;

procedure TCrdlstBtr.WriteDscPrc(pValue:double);
begin
  oBtrTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TCrdlstBtr.ReadDocVal:double;
begin
  Result := oBtrTable.FieldByName('DocVal').AsFloat;
end;

procedure TCrdlstBtr.WriteDocVal(pValue:double);
begin
  oBtrTable.FieldByName('DocVal').AsFloat := pValue;
end;

function TCrdlstBtr.ReadBonTrn:double;
begin
  Result := oBtrTable.FieldByName('BonTrn').AsFloat;
end;

procedure TCrdlstBtr.WriteBonTrn(pValue:double);
begin
  oBtrTable.FieldByName('BonTrn').AsFloat := pValue;
end;

function TCrdlstBtr.ReadBonVal:double;
begin
  Result := oBtrTable.FieldByName('BonVal').AsFloat;
end;

procedure TCrdlstBtr.WriteBonVal(pValue:double);
begin
  oBtrTable.FieldByName('BonVal').AsFloat := pValue;
end;

function TCrdlstBtr.ReadBegBon:word;
begin
  Result := oBtrTable.FieldByName('BegBon').AsInteger;
end;

procedure TCrdlstBtr.WriteBegBon(pValue:word);
begin
  oBtrTable.FieldByName('BegBon').AsInteger := pValue;
end;

function TCrdlstBtr.ReadInpBon:word;
begin
  Result := oBtrTable.FieldByName('InpBon').AsInteger;
end;

procedure TCrdlstBtr.WriteInpBon(pValue:word);
begin
  oBtrTable.FieldByName('InpBon').AsInteger := pValue;
end;

function TCrdlstBtr.ReadOutBon:word;
begin
  Result := oBtrTable.FieldByName('OutBon').AsInteger;
end;

procedure TCrdlstBtr.WriteOutBon(pValue:word);
begin
  oBtrTable.FieldByName('OutBon').AsInteger := pValue;
end;

function TCrdlstBtr.ReadCrdGrp:word;
begin
  Result := oBtrTable.FieldByName('CrdGrp').AsInteger;
end;

procedure TCrdlstBtr.WriteCrdGrp(pValue:word);
begin
  oBtrTable.FieldByName('CrdGrp').AsInteger := pValue;
end;

function TCrdlstBtr.ReadIdcNum:Str10;
begin
  Result := oBtrTable.FieldByName('IdcNum').AsString;
end;

procedure TCrdlstBtr.WriteIdcNum(pValue:Str10);
begin
  oBtrTable.FieldByName('IdcNum').AsString := pValue;
end;

function TCrdlstBtr.ReadActBon:word;
begin
  Result := oBtrTable.FieldByName('ActBon').AsInteger;
end;

procedure TCrdlstBtr.WriteActBon(pValue:word);
begin
  oBtrTable.FieldByName('ActBon').AsInteger := pValue;
end;

function TCrdlstBtr.ReadBegVal:double;
begin
  Result := oBtrTable.FieldByName('BegVal').AsFloat;
end;

procedure TCrdlstBtr.WriteBegVal(pValue:double);
begin
  oBtrTable.FieldByName('BegVal').AsFloat := pValue;
end;

function TCrdlstBtr.ReadNouVal:double;
begin
  Result := oBtrTable.FieldByName('NouVal').AsFloat;
end;

procedure TCrdlstBtr.WriteNouVal(pValue:double);
begin
  oBtrTable.FieldByName('NouVal').AsFloat := pValue;
end;

function TCrdlstBtr.ReadNebVal:double;
begin
  Result := oBtrTable.FieldByName('NebVal').AsFloat;
end;

procedure TCrdlstBtr.WriteNebVal(pValue:double);
begin
  oBtrTable.FieldByName('NebVal').AsFloat := pValue;
end;

function TCrdlstBtr.ReadTrnVal:double;
begin
  Result := oBtrTable.FieldByName('TrnVal').AsFloat;
end;

procedure TCrdlstBtr.WriteTrnVal(pValue:double);
begin
  oBtrTable.FieldByName('TrnVal').AsFloat := pValue;
end;

function TCrdlstBtr.ReadLasItm:word;
begin
  Result := oBtrTable.FieldByName('LasItm').AsInteger;
end;

procedure TCrdlstBtr.WriteLasItm(pValue:word);
begin
  oBtrTable.FieldByName('LasItm').AsInteger := pValue;
end;

function TCrdlstBtr.ReadItmQnt:word;
begin
  Result := oBtrTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TCrdlstBtr.WriteItmQnt(pValue:word);
begin
  oBtrTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCrdlstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCrdlstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TCrdlstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCrdlstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TCrdlstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TCrdlstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TCrdlstBtr.LocateCrdNum (pCrdNum:Str20):boolean;
begin
  SetIndex (ixCrdNum);
  Result := oBtrTable.FindKey([pCrdNum]);
end;

function TCrdlstBtr.LocateCrdName (pCrdName_:Str30):boolean;
begin
  SetIndex (ixCrdName);
  Result := oBtrTable.FindKey([StrToAlias(pCrdName_)]);
end;

function TCrdlstBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TCrdlstBtr.LocatePaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindKey([StrToAlias(pPaName_)]);
end;

function TCrdlstBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

function TCrdlstBtr.LocateCrdGrp (pCrdGrp:word):boolean;
begin
  SetIndex (ixCrdGrp);
  Result := oBtrTable.FindKey([pCrdGrp]);
end;

function TCrdlstBtr.NearestCrdNum (pCrdNum:Str20):boolean;
begin
  SetIndex (ixCrdNum);
  Result := oBtrTable.FindNearest([pCrdNum]);
end;

function TCrdlstBtr.NearestCrdName (pCrdName_:Str30):boolean;
begin
  SetIndex (ixCrdName);
  Result := oBtrTable.FindNearest([pCrdName_]);
end;

function TCrdlstBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TCrdlstBtr.NearestPaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindNearest([pPaName_]);
end;

function TCrdlstBtr.NearestSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindNearest([pSended]);
end;

function TCrdlstBtr.NearestCrdGrp (pCrdGrp:word):boolean;
begin
  SetIndex (ixCrdGrp);
  Result := oBtrTable.FindNearest([pCrdGrp]);
end;

procedure TCrdlstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TCrdlstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TCrdlstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TCrdlstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TCrdlstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TCrdlstBtr.First;
begin
  oBtrTable.First;
end;

procedure TCrdlstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TCrdlstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TCrdlstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TCrdlstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TCrdlstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TCrdlstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TCrdlstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TCrdlstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TCrdlstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TCrdlstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TCrdlstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1920001}
