unit tSTP;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSerNum = '';
  ixProdNum = 'ProdNum';
  ixInDocDate = 'InDocDate';
  ixInDnInIt = 'InDnInIt';
  ixOuDnOuIt = 'OuDnOuIt';
  ixStatus = 'Status';

type
  TStpTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSerNum:word;           procedure WriteSerNum (pValue:word);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadProdNum:Str30;         procedure WriteProdNum (pValue:Str30);
    function  ReadInDocDate:TDatetime;   procedure WriteInDocDate (pValue:TDatetime);
    function  ReadInDocNum:Str12;        procedure WriteInDocNum (pValue:Str12);
    function  ReadInItmNum:word;         procedure WriteInItmNum (pValue:word);
    function  ReadInFifNum:longint;      procedure WriteInFifNum (pValue:longint);
    function  ReadOutDocDate:TDatetime;  procedure WriteOutDocDate (pValue:TDatetime);
    function  ReadOutDocNum:Str12;       procedure WriteOutDocNum (pValue:Str12);
    function  ReadOutItmNum:word;        procedure WriteOutItmNum (pValue:word);
    function  ReadStatus:Str1;           procedure WriteStatus (pValue:Str1);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateSerNum (pSerNum:word):boolean;
    function LocateProdNum (pProdNum:Str30):boolean;
    function LocateInDocDate (pInDocDate:TDatetime):boolean;
    function LocateInDnInIt (pInDocNum:Str12;pInItmNum:word):boolean;
    function LocateOuDnOuIt (pOutDocNum:Str12;pOutItmNum:word):boolean;
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
    property SerNum:word read ReadSerNum write WriteSerNum;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property ProdNum:Str30 read ReadProdNum write WriteProdNum;
    property InDocDate:TDatetime read ReadInDocDate write WriteInDocDate;
    property InDocNum:Str12 read ReadInDocNum write WriteInDocNum;
    property InItmNum:word read ReadInItmNum write WriteInItmNum;
    property InFifNum:longint read ReadInFifNum write WriteInFifNum;
    property OutDocDate:TDatetime read ReadOutDocDate write WriteOutDocDate;
    property OutDocNum:Str12 read ReadOutDocNum write WriteOutDocNum;
    property OutItmNum:word read ReadOutItmNum write WriteOutItmNum;
    property Status:Str1 read ReadStatus write WriteStatus;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TStpTmp.Create;
begin
  oTmpTable := TmpInit ('STP',Self);
end;

destructor TStpTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TStpTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TStpTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TStpTmp.ReadSerNum:word;
begin
  Result := oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TStpTmp.WriteSerNum(pValue:word);
begin
  oTmpTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TStpTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TStpTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TStpTmp.ReadProdNum:Str30;
begin
  Result := oTmpTable.FieldByName('ProdNum').AsString;
end;

procedure TStpTmp.WriteProdNum(pValue:Str30);
begin
  oTmpTable.FieldByName('ProdNum').AsString := pValue;
end;

function TStpTmp.ReadInDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('InDocDate').AsDateTime;
end;

procedure TStpTmp.WriteInDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('InDocDate').AsDateTime := pValue;
end;

function TStpTmp.ReadInDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('InDocNum').AsString;
end;

procedure TStpTmp.WriteInDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('InDocNum').AsString := pValue;
end;

function TStpTmp.ReadInItmNum:word;
begin
  Result := oTmpTable.FieldByName('InItmNum').AsInteger;
end;

procedure TStpTmp.WriteInItmNum(pValue:word);
begin
  oTmpTable.FieldByName('InItmNum').AsInteger := pValue;
end;

function TStpTmp.ReadInFifNum:longint;
begin
  Result := oTmpTable.FieldByName('InFifNum').AsInteger;
end;

procedure TStpTmp.WriteInFifNum(pValue:longint);
begin
  oTmpTable.FieldByName('InFifNum').AsInteger := pValue;
end;

function TStpTmp.ReadOutDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('OutDocDate').AsDateTime;
end;

procedure TStpTmp.WriteOutDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('OutDocDate').AsDateTime := pValue;
end;

function TStpTmp.ReadOutDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('OutDocNum').AsString;
end;

procedure TStpTmp.WriteOutDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OutDocNum').AsString := pValue;
end;

function TStpTmp.ReadOutItmNum:word;
begin
  Result := oTmpTable.FieldByName('OutItmNum').AsInteger;
end;

procedure TStpTmp.WriteOutItmNum(pValue:word);
begin
  oTmpTable.FieldByName('OutItmNum').AsInteger := pValue;
end;

function TStpTmp.ReadStatus:Str1;
begin
  Result := oTmpTable.FieldByName('Status').AsString;
end;

procedure TStpTmp.WriteStatus(pValue:Str1);
begin
  oTmpTable.FieldByName('Status').AsString := pValue;
end;

function TStpTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TStpTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TStpTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TStpTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TStpTmp.LocateSerNum (pSerNum:word):boolean;
begin
  SetIndex (ixSerNum);
  Result := oTmpTable.FindKey([pSerNum]);
end;

function TStpTmp.LocateProdNum (pProdNum:Str30):boolean;
begin
  SetIndex (ixProdNum);
  Result := oTmpTable.FindKey([pProdNum]);
end;

function TStpTmp.LocateInDocDate (pInDocDate:TDatetime):boolean;
begin
  SetIndex (ixInDocDate);
  Result := oTmpTable.FindKey([pInDocDate]);
end;

function TStpTmp.LocateInDnInIt (pInDocNum:Str12;pInItmNum:word):boolean;
begin
  SetIndex (ixInDnInIt);
  Result := oTmpTable.FindKey([pInDocNum,pInItmNum]);
end;

function TStpTmp.LocateOuDnOuIt (pOutDocNum:Str12;pOutItmNum:word):boolean;
begin
  SetIndex (ixOuDnOuIt);
  Result := oTmpTable.FindKey([pOutDocNum,pOutItmNum]);
end;

function TStpTmp.LocateStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oTmpTable.FindKey([pStatus]);
end;

procedure TStpTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TStpTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TStpTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TStpTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TStpTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TStpTmp.First;
begin
  oTmpTable.First;
end;

procedure TStpTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TStpTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TStpTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TStpTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TStpTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TStpTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TStpTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TStpTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TStpTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TStpTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TStpTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
