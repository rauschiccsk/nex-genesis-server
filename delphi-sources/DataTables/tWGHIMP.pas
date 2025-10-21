unit tWGHIMP;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixVWB = '';
  ixBlkNum = 'BlkNum';
  ixBlkVal = 'BlkVal';

type
  TWghimpTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadVendor:longint;        procedure WriteVendor (pValue:longint);
    function  ReadWgNum:longint;         procedure WriteWgNum (pValue:longint);
    function  ReadBlkNum:longint;        procedure WriteBlkNum (pValue:longint);
    function  ReadBlkDate:TDatetime;     procedure WriteBlkDate (pValue:TDatetime);
    function  ReadBlkTime:TDatetime;     procedure WriteBlkTime (pValue:TDatetime);
    function  ReadBlkVal:double;         procedure WriteBlkVal (pValue:double);
    function  ReadItmCnt:longint;        procedure WriteItmCnt (pValue:longint);
    function  ReadImpStat:Str1;          procedure WriteImpStat (pValue:Str1);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateVWB (pVendor:longint;pWgNum:longint;pBlkNum:longint):boolean;
    function LocateBlkNum (pBlkNum:longint):boolean;
    function LocateBlkVal (pBlkVal:double):boolean;

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
    property Vendor:longint read ReadVendor write WriteVendor;
    property WgNum:longint read ReadWgNum write WriteWgNum;
    property BlkNum:longint read ReadBlkNum write WriteBlkNum;
    property BlkDate:TDatetime read ReadBlkDate write WriteBlkDate;
    property BlkTime:TDatetime read ReadBlkTime write WriteBlkTime;
    property BlkVal:double read ReadBlkVal write WriteBlkVal;
    property ItmCnt:longint read ReadItmCnt write WriteItmCnt;
    property ImpStat:Str1 read ReadImpStat write WriteImpStat;
  end;

implementation

constructor TWghimpTmp.Create;
begin
  oTmpTable := TmpInit ('WGHIMP',Self);
end;

destructor TWghimpTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TWghimpTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TWghimpTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TWghimpTmp.ReadVendor:longint;
begin
  Result := oTmpTable.FieldByName('Vendor').AsInteger;
end;

procedure TWghimpTmp.WriteVendor(pValue:longint);
begin
  oTmpTable.FieldByName('Vendor').AsInteger := pValue;
end;

function TWghimpTmp.ReadWgNum:longint;
begin
  Result := oTmpTable.FieldByName('WgNum').AsInteger;
end;

procedure TWghimpTmp.WriteWgNum(pValue:longint);
begin
  oTmpTable.FieldByName('WgNum').AsInteger := pValue;
end;

function TWghimpTmp.ReadBlkNum:longint;
begin
  Result := oTmpTable.FieldByName('BlkNum').AsInteger;
end;

procedure TWghimpTmp.WriteBlkNum(pValue:longint);
begin
  oTmpTable.FieldByName('BlkNum').AsInteger := pValue;
end;

function TWghimpTmp.ReadBlkDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('BlkDate').AsDateTime;
end;

procedure TWghimpTmp.WriteBlkDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('BlkDate').AsDateTime := pValue;
end;

function TWghimpTmp.ReadBlkTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('BlkTime').AsDateTime;
end;

procedure TWghimpTmp.WriteBlkTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('BlkTime').AsDateTime := pValue;
end;

function TWghimpTmp.ReadBlkVal:double;
begin
  Result := oTmpTable.FieldByName('BlkVal').AsFloat;
end;

procedure TWghimpTmp.WriteBlkVal(pValue:double);
begin
  oTmpTable.FieldByName('BlkVal').AsFloat := pValue;
end;

function TWghimpTmp.ReadItmCnt:longint;
begin
  Result := oTmpTable.FieldByName('ItmCnt').AsInteger;
end;

procedure TWghimpTmp.WriteItmCnt(pValue:longint);
begin
  oTmpTable.FieldByName('ItmCnt').AsInteger := pValue;
end;

function TWghimpTmp.ReadImpStat:Str1;
begin
  Result := oTmpTable.FieldByName('ImpStat').AsString;
end;

procedure TWghimpTmp.WriteImpStat(pValue:Str1);
begin
  oTmpTable.FieldByName('ImpStat').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TWghimpTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TWghimpTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TWghimpTmp.LocateVWB (pVendor:longint;pWgNum:longint;pBlkNum:longint):boolean;
begin
  SetIndex (ixVWB);
  Result := oTmpTable.FindKey([pVendor,pWgNum,pBlkNum]);
end;

function TWghimpTmp.LocateBlkNum (pBlkNum:longint):boolean;
begin
  SetIndex (ixBlkNum);
  Result := oTmpTable.FindKey([pBlkNum]);
end;

function TWghimpTmp.LocateBlkVal (pBlkVal:double):boolean;
begin
  SetIndex (ixBlkVal);
  Result := oTmpTable.FindKey([pBlkVal]);
end;

procedure TWghimpTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TWghimpTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TWghimpTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TWghimpTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TWghimpTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TWghimpTmp.First;
begin
  oTmpTable.First;
end;

procedure TWghimpTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TWghimpTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TWghimpTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TWghimpTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TWghimpTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TWghimpTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TWghimpTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TWghimpTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TWghimpTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TWghimpTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TWghimpTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
