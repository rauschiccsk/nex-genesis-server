unit tCRDTRN;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixBlkNum = '';
  ixDocNum = 'DocNum';
  ixBlkDate = 'BlkDate';
  ixBlkVal = 'BlkVal';

type
  TCrdtrnTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadBlkNum:Str10;          procedure WriteBlkNum (pValue:Str10);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadBlkDate:TDatetime;     procedure WriteBlkDate (pValue:TDatetime);
    function  ReadBlkTime:TDatetime;     procedure WriteBlkTime (pValue:TDatetime);
    function  ReadBlkVal:double;         procedure WriteBlkVal (pValue:double);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadVerify:Str1;           procedure WriteVerify (pValue:Str1);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateBlkNum (pBlkNum:Str10):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateBlkDate (pBlkDate:TDatetime):boolean;
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
    property BlkNum:Str10 read ReadBlkNum write WriteBlkNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property BlkDate:TDatetime read ReadBlkDate write WriteBlkDate;
    property BlkTime:TDatetime read ReadBlkTime write WriteBlkTime;
    property BlkVal:double read ReadBlkVal write WriteBlkVal;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property Verify:Str1 read ReadVerify write WriteVerify;
  end;

implementation

constructor TCrdtrnTmp.Create;
begin
  oTmpTable := TmpInit ('CRDTRN',Self);
end;

destructor TCrdtrnTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TCrdtrnTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TCrdtrnTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TCrdtrnTmp.ReadBlkNum:Str10;
begin
  Result := oTmpTable.FieldByName('BlkNum').AsString;
end;

procedure TCrdtrnTmp.WriteBlkNum(pValue:Str10);
begin
  oTmpTable.FieldByName('BlkNum').AsString := pValue;
end;

function TCrdtrnTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TCrdtrnTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TCrdtrnTmp.ReadBlkDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('BlkDate').AsDateTime;
end;

procedure TCrdtrnTmp.WriteBlkDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('BlkDate').AsDateTime := pValue;
end;

function TCrdtrnTmp.ReadBlkTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('BlkTime').AsDateTime;
end;

procedure TCrdtrnTmp.WriteBlkTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('BlkTime').AsDateTime := pValue;
end;

function TCrdtrnTmp.ReadBlkVal:double;
begin
  Result := oTmpTable.FieldByName('BlkVal').AsFloat;
end;

procedure TCrdtrnTmp.WriteBlkVal(pValue:double);
begin
  oTmpTable.FieldByName('BlkVal').AsFloat := pValue;
end;

function TCrdtrnTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TCrdtrnTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TCrdtrnTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TCrdtrnTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TCrdtrnTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TCrdtrnTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TCrdtrnTmp.ReadVerify:Str1;
begin
  Result := oTmpTable.FieldByName('Verify').AsString;
end;

procedure TCrdtrnTmp.WriteVerify(pValue:Str1);
begin
  oTmpTable.FieldByName('Verify').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCrdtrnTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TCrdtrnTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TCrdtrnTmp.LocateBlkNum (pBlkNum:Str10):boolean;
begin
  SetIndex (ixBlkNum);
  Result := oTmpTable.FindKey([pBlkNum]);
end;

function TCrdtrnTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TCrdtrnTmp.LocateBlkDate (pBlkDate:TDatetime):boolean;
begin
  SetIndex (ixBlkDate);
  Result := oTmpTable.FindKey([pBlkDate]);
end;

function TCrdtrnTmp.LocateBlkVal (pBlkVal:double):boolean;
begin
  SetIndex (ixBlkVal);
  Result := oTmpTable.FindKey([pBlkVal]);
end;

procedure TCrdtrnTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TCrdtrnTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TCrdtrnTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TCrdtrnTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TCrdtrnTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TCrdtrnTmp.First;
begin
  oTmpTable.First;
end;

procedure TCrdtrnTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TCrdtrnTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TCrdtrnTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TCrdtrnTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TCrdtrnTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TCrdtrnTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TCrdtrnTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TCrdtrnTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TCrdtrnTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TCrdtrnTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TCrdtrnTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
