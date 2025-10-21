unit tGSMOVS;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRowNum = '';
  ixSMDoc = 'SMDoc';
  ixSPDoc = 'SPDoc';

type
  TGsmovsTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRowNum:longint;        procedure WriteRowNum (pValue:longint);
    function  ReadSMDocNum:Str15;        procedure WriteSMDocNum (pValue:Str15);
    function  ReadSMItmNum:longint;      procedure WriteSMItmNum (pValue:longint);
    function  ReadSMDocDate:TDatetime;   procedure WriteSMDocDate (pValue:TDatetime);
    function  ReadSMQnt:double;          procedure WriteSMQnt (pValue:double);
    function  ReadSPDocNum:Str15;        procedure WriteSPDocNum (pValue:Str15);
    function  ReadSPItmNum:longint;      procedure WriteSPItmNum (pValue:longint);
    function  ReadSPDocDate:TDatetime;   procedure WriteSPDocDate (pValue:TDatetime);
    function  ReadSPQnt:double;          procedure WriteSPQnt (pValue:double);
    function  ReadDifQnt:double;         procedure WriteDifQnt (pValue:double);
    function  ReadPosCode:Str30;         procedure WritePosCode (pValue:Str30);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateRowNum (pRowNum:longint):boolean;
    function LocateSMDoc (pSMDocNum:Str15;pSMItmNum:longint):boolean;
    function LocateSPDoc (pSPDocNum:Str15;pSPItmNum:longint):boolean;

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
    property SMDocNum:Str15 read ReadSMDocNum write WriteSMDocNum;
    property SMItmNum:longint read ReadSMItmNum write WriteSMItmNum;
    property SMDocDate:TDatetime read ReadSMDocDate write WriteSMDocDate;
    property SMQnt:double read ReadSMQnt write WriteSMQnt;
    property SPDocNum:Str15 read ReadSPDocNum write WriteSPDocNum;
    property SPItmNum:longint read ReadSPItmNum write WriteSPItmNum;
    property SPDocDate:TDatetime read ReadSPDocDate write WriteSPDocDate;
    property SPQnt:double read ReadSPQnt write WriteSPQnt;
    property DifQnt:double read ReadDifQnt write WriteDifQnt;
    property PosCode:Str30 read ReadPosCode write WritePosCode;
  end;

implementation

constructor TGsmovsTmp.Create;
begin
  oTmpTable := TmpInit ('GSMOVS',Self);
end;

destructor TGsmovsTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TGsmovsTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TGsmovsTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TGsmovsTmp.ReadRowNum:longint;
begin
  Result := oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TGsmovsTmp.WriteRowNum(pValue:longint);
begin
  oTmpTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TGsmovsTmp.ReadSMDocNum:Str15;
begin
  Result := oTmpTable.FieldByName('SMDocNum').AsString;
end;

procedure TGsmovsTmp.WriteSMDocNum(pValue:Str15);
begin
  oTmpTable.FieldByName('SMDocNum').AsString := pValue;
end;

function TGsmovsTmp.ReadSMItmNum:longint;
begin
  Result := oTmpTable.FieldByName('SMItmNum').AsInteger;
end;

procedure TGsmovsTmp.WriteSMItmNum(pValue:longint);
begin
  oTmpTable.FieldByName('SMItmNum').AsInteger := pValue;
end;

function TGsmovsTmp.ReadSMDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('SMDocDate').AsDateTime;
end;

procedure TGsmovsTmp.WriteSMDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('SMDocDate').AsDateTime := pValue;
end;

function TGsmovsTmp.ReadSMQnt:double;
begin
  Result := oTmpTable.FieldByName('SMQnt').AsFloat;
end;

procedure TGsmovsTmp.WriteSMQnt(pValue:double);
begin
  oTmpTable.FieldByName('SMQnt').AsFloat := pValue;
end;

function TGsmovsTmp.ReadSPDocNum:Str15;
begin
  Result := oTmpTable.FieldByName('SPDocNum').AsString;
end;

procedure TGsmovsTmp.WriteSPDocNum(pValue:Str15);
begin
  oTmpTable.FieldByName('SPDocNum').AsString := pValue;
end;

function TGsmovsTmp.ReadSPItmNum:longint;
begin
  Result := oTmpTable.FieldByName('SPItmNum').AsInteger;
end;

procedure TGsmovsTmp.WriteSPItmNum(pValue:longint);
begin
  oTmpTable.FieldByName('SPItmNum').AsInteger := pValue;
end;

function TGsmovsTmp.ReadSPDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('SPDocDate').AsDateTime;
end;

procedure TGsmovsTmp.WriteSPDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('SPDocDate').AsDateTime := pValue;
end;

function TGsmovsTmp.ReadSPQnt:double;
begin
  Result := oTmpTable.FieldByName('SPQnt').AsFloat;
end;

procedure TGsmovsTmp.WriteSPQnt(pValue:double);
begin
  oTmpTable.FieldByName('SPQnt').AsFloat := pValue;
end;

function TGsmovsTmp.ReadDifQnt:double;
begin
  Result := oTmpTable.FieldByName('DifQnt').AsFloat;
end;

procedure TGsmovsTmp.WriteDifQnt(pValue:double);
begin
  oTmpTable.FieldByName('DifQnt').AsFloat := pValue;
end;

function TGsmovsTmp.ReadPosCode:Str30;
begin
  Result := oTmpTable.FieldByName('PosCode').AsString;
end;

procedure TGsmovsTmp.WritePosCode(pValue:Str30);
begin
  oTmpTable.FieldByName('PosCode').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TGsmovsTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TGsmovsTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TGsmovsTmp.LocateRowNum (pRowNum:longint):boolean;
begin
  SetIndex (ixRowNum);
  Result := oTmpTable.FindKey([pRowNum]);
end;

function TGsmovsTmp.LocateSMDoc (pSMDocNum:Str15;pSMItmNum:longint):boolean;
begin
  SetIndex (ixSMDoc);
  Result := oTmpTable.FindKey([pSMDocNum,pSMItmNum]);
end;

function TGsmovsTmp.LocateSPDoc (pSPDocNum:Str15;pSPItmNum:longint):boolean;
begin
  SetIndex (ixSPDoc);
  Result := oTmpTable.FindKey([pSPDocNum,pSPItmNum]);
end;

procedure TGsmovsTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TGsmovsTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TGsmovsTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TGsmovsTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TGsmovsTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TGsmovsTmp.First;
begin
  oTmpTable.First;
end;

procedure TGsmovsTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TGsmovsTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TGsmovsTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TGsmovsTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TGsmovsTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TGsmovsTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TGsmovsTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TGsmovsTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TGsmovsTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TGsmovsTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TGsmovsTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
