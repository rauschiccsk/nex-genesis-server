unit tSAIITM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRowNum = '';
  ixGsCode = 'GsCode';
  ixGsName_ = 'GsName_';
  ixBarCode = 'BarCode';
  ixGcSdS = 'GcSdS';
  ixSdSt = 'SdSt';

type
  TSaiitmTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRowNum:longint;        procedure WriteRowNum (pValue:longint);
    function  ReadSalDate:TDatetime;     procedure WriteSalDate (pValue:TDatetime);
    function  ReadSalTime:Str8;          procedure WriteSalTime (pValue:Str8);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadBlkNum:longint;        procedure WriteBlkNum (pValue:longint);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadDscVal:double;         procedure WriteDscVal (pValue:double);
    function  ReadStatus:byte;           procedure WriteStatus (pValue:byte);
    function  ReadWgiCmp:longint;        procedure WriteWgiCmp (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateRowNum (pRowNum:longint):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName_ (pGsName_:Str30):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateGcSdS (pGsCode:longint;pSalDate:TDatetime;pStatus:byte):boolean;
    function LocateSdSt (pSalDate:TDatetime;pSalTime:Str8):boolean;

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
    property RowNum:longint read ReadRowNum write WriteRowNum;
    property SalDate:TDatetime read ReadSalDate write WriteSalDate;
    property SalTime:Str8 read ReadSalTime write WriteSalTime;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property BlkNum:longint read ReadBlkNum write WriteBlkNum;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property BValue:double read ReadBValue write WriteBValue;
    property DscVal:double read ReadDscVal write WriteDscVal;
    property Status:byte read ReadStatus write WriteStatus;
    property WgiCmp:longint read ReadWgiCmp write WriteWgiCmp;
  end;

implementation

constructor TSaiitmTmp.Create;
begin
  oTmpTable := TmpInit ('SAIITM',Self);
end;

destructor TSaiitmTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TSaiitmTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TSaiitmTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TSaiitmTmp.ReadRowNum:longint;
begin
  Result := oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TSaiitmTmp.WriteRowNum(pValue:longint);
begin
  oTmpTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TSaiitmTmp.ReadSalDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('SalDate').AsDateTime;
end;

procedure TSaiitmTmp.WriteSalDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('SalDate').AsDateTime := pValue;
end;

function TSaiitmTmp.ReadSalTime:Str8;
begin
  Result := oTmpTable.FieldByName('SalTime').AsString;
end;

procedure TSaiitmTmp.WriteSalTime(pValue:Str8);
begin
  oTmpTable.FieldByName('SalTime').AsString := pValue;
end;

function TSaiitmTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TSaiitmTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TSaiitmTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TSaiitmTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TSaiitmTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TSaiitmTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TSaiitmTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TSaiitmTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TSaiitmTmp.ReadGsQnt:double;
begin
  Result := oTmpTable.FieldByName('GsQnt').AsFloat;
end;

procedure TSaiitmTmp.WriteGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TSaiitmTmp.ReadBlkNum:longint;
begin
  Result := oTmpTable.FieldByName('BlkNum').AsInteger;
end;

procedure TSaiitmTmp.WriteBlkNum(pValue:longint);
begin
  oTmpTable.FieldByName('BlkNum').AsInteger := pValue;
end;

function TSaiitmTmp.ReadBPrice:double;
begin
  Result := oTmpTable.FieldByName('BPrice').AsFloat;
end;

procedure TSaiitmTmp.WriteBPrice(pValue:double);
begin
  oTmpTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TSaiitmTmp.ReadBValue:double;
begin
  Result := oTmpTable.FieldByName('BValue').AsFloat;
end;

procedure TSaiitmTmp.WriteBValue(pValue:double);
begin
  oTmpTable.FieldByName('BValue').AsFloat := pValue;
end;

function TSaiitmTmp.ReadDscVal:double;
begin
  Result := oTmpTable.FieldByName('DscVal').AsFloat;
end;

procedure TSaiitmTmp.WriteDscVal(pValue:double);
begin
  oTmpTable.FieldByName('DscVal').AsFloat := pValue;
end;

function TSaiitmTmp.ReadStatus:byte;
begin
  Result := oTmpTable.FieldByName('Status').AsInteger;
end;

procedure TSaiitmTmp.WriteStatus(pValue:byte);
begin
  oTmpTable.FieldByName('Status').AsInteger := pValue;
end;

function TSaiitmTmp.ReadWgiCmp:longint;
begin
  Result := oTmpTable.FieldByName('WgiCmp').AsInteger;
end;

procedure TSaiitmTmp.WriteWgiCmp(pValue:longint);
begin
  oTmpTable.FieldByName('WgiCmp').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSaiitmTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TSaiitmTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TSaiitmTmp.LocateRowNum (pRowNum:longint):boolean;
begin
  SetIndex (ixRowNum);
  Result := oTmpTable.FindKey([pRowNum]);
end;

function TSaiitmTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TSaiitmTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

function TSaiitmTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

function TSaiitmTmp.LocateGcSdS (pGsCode:longint;pSalDate:TDatetime;pStatus:byte):boolean;
begin
  SetIndex (ixGcSdS);
  Result := oTmpTable.FindKey([pGsCode,pSalDate,pStatus]);
end;

function TSaiitmTmp.LocateSdSt (pSalDate:TDatetime;pSalTime:Str8):boolean;
begin
  SetIndex (ixSdSt);
  Result := oTmpTable.FindKey([pSalDate,pSalTime]);
end;

procedure TSaiitmTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TSaiitmTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TSaiitmTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TSaiitmTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TSaiitmTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TSaiitmTmp.First;
begin
  oTmpTable.First;
end;

procedure TSaiitmTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TSaiitmTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TSaiitmTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TSaiitmTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TSaiitmTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TSaiitmTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TSaiitmTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TSaiitmTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TSaiitmTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TSaiitmTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TSaiitmTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
