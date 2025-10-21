unit tCAQNTSRC;

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
  ixCasNum = 'CasNum';
  ixBlkNum = 'BlkNum';

type
  TCaqntsrcTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRowNum:longint;        procedure WriteRowNum (pValue:longint);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadSalDate:TDatetime;     procedure WriteSalDate (pValue:TDatetime);
    function  ReadSalTime:Str8;          procedure WriteSalTime (pValue:Str8);
    function  ReadCasNum:word;           procedure WriteCasNum (pValue:word);
    function  ReadBlkNum:longint;        procedure WriteBlkNum (pValue:longint);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadUsrName:Str30;         procedure WriteUsrName (pValue:Str30);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateRowNum (pRowNum:longint):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName_ (pGsName_:Str30):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateSdSt (pSalDate:TDatetime;pSalTime:Str8):boolean;
    function LocateCasNum (pCasNum:word):boolean;
    function LocateBlkNum (pBlkNum:longint):boolean;

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
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property SalDate:TDatetime read ReadSalDate write WriteSalDate;
    property SalTime:Str8 read ReadSalTime write WriteSalTime;
    property CasNum:word read ReadCasNum write WriteCasNum;
    property BlkNum:longint read ReadBlkNum write WriteBlkNum;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property BValue:double read ReadBValue write WriteBValue;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property UsrName:Str30 read ReadUsrName write WriteUsrName;
    property PaName:Str30 read ReadPaName write WritePaName;
  end;

implementation

constructor TCaqntsrcTmp.Create;
begin
  oTmpTable := TmpInit ('CAQNTSRC',Self);
end;

destructor TCaqntsrcTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TCaqntsrcTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TCaqntsrcTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TCaqntsrcTmp.ReadRowNum:longint;
begin
  Result := oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TCaqntsrcTmp.WriteRowNum(pValue:longint);
begin
  oTmpTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TCaqntsrcTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TCaqntsrcTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TCaqntsrcTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TCaqntsrcTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TCaqntsrcTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TCaqntsrcTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TCaqntsrcTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TCaqntsrcTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TCaqntsrcTmp.ReadSalDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('SalDate').AsDateTime;
end;

procedure TCaqntsrcTmp.WriteSalDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('SalDate').AsDateTime := pValue;
end;

function TCaqntsrcTmp.ReadSalTime:Str8;
begin
  Result := oTmpTable.FieldByName('SalTime').AsString;
end;

procedure TCaqntsrcTmp.WriteSalTime(pValue:Str8);
begin
  oTmpTable.FieldByName('SalTime').AsString := pValue;
end;

function TCaqntsrcTmp.ReadCasNum:word;
begin
  Result := oTmpTable.FieldByName('CasNum').AsInteger;
end;

procedure TCaqntsrcTmp.WriteCasNum(pValue:word);
begin
  oTmpTable.FieldByName('CasNum').AsInteger := pValue;
end;

function TCaqntsrcTmp.ReadBlkNum:longint;
begin
  Result := oTmpTable.FieldByName('BlkNum').AsInteger;
end;

procedure TCaqntsrcTmp.WriteBlkNum(pValue:longint);
begin
  oTmpTable.FieldByName('BlkNum').AsInteger := pValue;
end;

function TCaqntsrcTmp.ReadGsQnt:double;
begin
  Result := oTmpTable.FieldByName('GsQnt').AsFloat;
end;

procedure TCaqntsrcTmp.WriteGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TCaqntsrcTmp.ReadBPrice:double;
begin
  Result := oTmpTable.FieldByName('BPrice').AsFloat;
end;

procedure TCaqntsrcTmp.WriteBPrice(pValue:double);
begin
  oTmpTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TCaqntsrcTmp.ReadBValue:double;
begin
  Result := oTmpTable.FieldByName('BValue').AsFloat;
end;

procedure TCaqntsrcTmp.WriteBValue(pValue:double);
begin
  oTmpTable.FieldByName('BValue').AsFloat := pValue;
end;

function TCaqntsrcTmp.ReadDscPrc:double;
begin
  Result := oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TCaqntsrcTmp.WriteDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TCaqntsrcTmp.ReadUsrName:Str30;
begin
  Result := oTmpTable.FieldByName('UsrName').AsString;
end;

procedure TCaqntsrcTmp.WriteUsrName(pValue:Str30);
begin
  oTmpTable.FieldByName('UsrName').AsString := pValue;
end;

function TCaqntsrcTmp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TCaqntsrcTmp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCaqntsrcTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TCaqntsrcTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TCaqntsrcTmp.LocateRowNum (pRowNum:longint):boolean;
begin
  SetIndex (ixRowNum);
  Result := oTmpTable.FindKey([pRowNum]);
end;

function TCaqntsrcTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TCaqntsrcTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

function TCaqntsrcTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

function TCaqntsrcTmp.LocateSdSt (pSalDate:TDatetime;pSalTime:Str8):boolean;
begin
  SetIndex (ixSdSt);
  Result := oTmpTable.FindKey([pSalDate,pSalTime]);
end;

function TCaqntsrcTmp.LocateCasNum (pCasNum:word):boolean;
begin
  SetIndex (ixCasNum);
  Result := oTmpTable.FindKey([pCasNum]);
end;

function TCaqntsrcTmp.LocateBlkNum (pBlkNum:longint):boolean;
begin
  SetIndex (ixBlkNum);
  Result := oTmpTable.FindKey([pBlkNum]);
end;

procedure TCaqntsrcTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TCaqntsrcTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TCaqntsrcTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TCaqntsrcTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TCaqntsrcTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TCaqntsrcTmp.First;
begin
  oTmpTable.First;
end;

procedure TCaqntsrcTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TCaqntsrcTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TCaqntsrcTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TCaqntsrcTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TCaqntsrcTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TCaqntsrcTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TCaqntsrcTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TCaqntsrcTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TCaqntsrcTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TCaqntsrcTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TCaqntsrcTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
