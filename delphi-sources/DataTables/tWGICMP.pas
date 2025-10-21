unit tWGICMP;

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
  ixSdSt = 'SdSt';

type
  TWgicmpTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRowNum:longint;        procedure WriteRowNum (pValue:longint);
    function  ReadWghCode:longint;       procedure WriteWghCode (pValue:longint);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadSalDate:TDatetime;     procedure WriteSalDate (pValue:TDatetime);
    function  ReadSalTime:Str8;          procedure WriteSalTime (pValue:Str8);
    function  ReadWghNum:word;           procedure WriteWghNum (pValue:word);
    function  ReadBlkNum:longint;        procedure WriteBlkNum (pValue:longint);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadStatus:byte;           procedure WriteStatus (pValue:byte);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateRowNum (pRowNum:longint):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName_ (pGsName_:Str30):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
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
    property WghCode:longint read ReadWghCode write WriteWghCode;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property SalDate:TDatetime read ReadSalDate write WriteSalDate;
    property SalTime:Str8 read ReadSalTime write WriteSalTime;
    property WghNum:word read ReadWghNum write WriteWghNum;
    property BlkNum:longint read ReadBlkNum write WriteBlkNum;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property BValue:double read ReadBValue write WriteBValue;
    property Status:byte read ReadStatus write WriteStatus;
  end;

implementation

constructor TWgicmpTmp.Create;
begin
  oTmpTable := TmpInit ('WGICMP',Self);
end;

destructor TWgicmpTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TWgicmpTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TWgicmpTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TWgicmpTmp.ReadRowNum:longint;
begin
  Result := oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TWgicmpTmp.WriteRowNum(pValue:longint);
begin
  oTmpTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TWgicmpTmp.ReadWghCode:longint;
begin
  Result := oTmpTable.FieldByName('WghCode').AsInteger;
end;

procedure TWgicmpTmp.WriteWghCode(pValue:longint);
begin
  oTmpTable.FieldByName('WghCode').AsInteger := pValue;
end;

function TWgicmpTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TWgicmpTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TWgicmpTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TWgicmpTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TWgicmpTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TWgicmpTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TWgicmpTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TWgicmpTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TWgicmpTmp.ReadSalDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('SalDate').AsDateTime;
end;

procedure TWgicmpTmp.WriteSalDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('SalDate').AsDateTime := pValue;
end;

function TWgicmpTmp.ReadSalTime:Str8;
begin
  Result := oTmpTable.FieldByName('SalTime').AsString;
end;

procedure TWgicmpTmp.WriteSalTime(pValue:Str8);
begin
  oTmpTable.FieldByName('SalTime').AsString := pValue;
end;

function TWgicmpTmp.ReadWghNum:word;
begin
  Result := oTmpTable.FieldByName('WghNum').AsInteger;
end;

procedure TWgicmpTmp.WriteWghNum(pValue:word);
begin
  oTmpTable.FieldByName('WghNum').AsInteger := pValue;
end;

function TWgicmpTmp.ReadBlkNum:longint;
begin
  Result := oTmpTable.FieldByName('BlkNum').AsInteger;
end;

procedure TWgicmpTmp.WriteBlkNum(pValue:longint);
begin
  oTmpTable.FieldByName('BlkNum').AsInteger := pValue;
end;

function TWgicmpTmp.ReadGsQnt:double;
begin
  Result := oTmpTable.FieldByName('GsQnt').AsFloat;
end;

procedure TWgicmpTmp.WriteGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TWgicmpTmp.ReadBPrice:double;
begin
  Result := oTmpTable.FieldByName('BPrice').AsFloat;
end;

procedure TWgicmpTmp.WriteBPrice(pValue:double);
begin
  oTmpTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TWgicmpTmp.ReadBValue:double;
begin
  Result := oTmpTable.FieldByName('BValue').AsFloat;
end;

procedure TWgicmpTmp.WriteBValue(pValue:double);
begin
  oTmpTable.FieldByName('BValue').AsFloat := pValue;
end;

function TWgicmpTmp.ReadStatus:byte;
begin
  Result := oTmpTable.FieldByName('Status').AsInteger;
end;

procedure TWgicmpTmp.WriteStatus(pValue:byte);
begin
  oTmpTable.FieldByName('Status').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TWgicmpTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TWgicmpTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TWgicmpTmp.LocateRowNum (pRowNum:longint):boolean;
begin
  SetIndex (ixRowNum);
  Result := oTmpTable.FindKey([pRowNum]);
end;

function TWgicmpTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TWgicmpTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

function TWgicmpTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

function TWgicmpTmp.LocateSdSt (pSalDate:TDatetime;pSalTime:Str8):boolean;
begin
  SetIndex (ixSdSt);
  Result := oTmpTable.FindKey([pSalDate,pSalTime]);
end;

procedure TWgicmpTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TWgicmpTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TWgicmpTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TWgicmpTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TWgicmpTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TWgicmpTmp.First;
begin
  oTmpTable.First;
end;

procedure TWgicmpTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TWgicmpTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TWgicmpTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TWgicmpTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TWgicmpTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TWgicmpTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TWgicmpTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TWgicmpTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TWgicmpTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TWgicmpTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TWgicmpTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
