unit tOCT;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRowNum = '';
  ixDoItDdDi = 'DoItDdDi';
  ixDoIt = 'DoIt';
  ixTdTi = 'TdTi';

type
  TOctTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRowNum:longint;        procedure WriteRowNum (pValue:longint);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadDlvDoc:Str12;          procedure WriteDlvDoc (pValue:Str12);
    function  ReadDlvItm:word;           procedure WriteDlvItm (pValue:word);
    function  ReadDlvDate:TDatetime;     procedure WriteDlvDate (pValue:TDatetime);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadDlvQnt:double;         procedure WriteDlvQnt (pValue:double);
    function  ReadOciStat:Str1;          procedure WriteOciStat (pValue:Str1);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateRowNum (pRowNum:longint):boolean;
    function LocateDoItDdDi (pDocNum:Str12;pItmNum:word;pDlvDoc:Str12;pDlvItm:word):boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateTdTi (pDlvDoc:Str12;pDlvItm:word):boolean;

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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property DlvDoc:Str12 read ReadDlvDoc write WriteDlvDoc;
    property DlvItm:word read ReadDlvItm write WriteDlvItm;
    property DlvDate:TDatetime read ReadDlvDate write WriteDlvDate;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property DlvQnt:double read ReadDlvQnt write WriteDlvQnt;
    property OciStat:Str1 read ReadOciStat write WriteOciStat;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
  end;

implementation

constructor TOctTmp.Create;
begin
  oTmpTable := TmpInit ('OCT',Self);
end;

destructor TOctTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TOctTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TOctTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TOctTmp.ReadRowNum:longint;
begin
  Result := oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TOctTmp.WriteRowNum(pValue:longint);
begin
  oTmpTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TOctTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TOctTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TOctTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TOctTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TOctTmp.ReadDlvDoc:Str12;
begin
  Result := oTmpTable.FieldByName('DlvDoc').AsString;
end;

procedure TOctTmp.WriteDlvDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('DlvDoc').AsString := pValue;
end;

function TOctTmp.ReadDlvItm:word;
begin
  Result := oTmpTable.FieldByName('DlvItm').AsInteger;
end;

procedure TOctTmp.WriteDlvItm(pValue:word);
begin
  oTmpTable.FieldByName('DlvItm').AsInteger := pValue;
end;

function TOctTmp.ReadDlvDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DlvDate').AsDateTime;
end;

procedure TOctTmp.WriteDlvDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DlvDate').AsDateTime := pValue;
end;

function TOctTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TOctTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TOctTmp.ReadDlvQnt:double;
begin
  Result := oTmpTable.FieldByName('DlvQnt').AsFloat;
end;

procedure TOctTmp.WriteDlvQnt(pValue:double);
begin
  oTmpTable.FieldByName('DlvQnt').AsFloat := pValue;
end;

function TOctTmp.ReadOciStat:Str1;
begin
  Result := oTmpTable.FieldByName('OciStat').AsString;
end;

procedure TOctTmp.WriteOciStat(pValue:Str1);
begin
  oTmpTable.FieldByName('OciStat').AsString := pValue;
end;

function TOctTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TOctTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TOctTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TOctTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TOctTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TOctTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TOctTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TOctTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TOctTmp.LocateRowNum (pRowNum:longint):boolean;
begin
  SetIndex (ixRowNum);
  Result := oTmpTable.FindKey([pRowNum]);
end;

function TOctTmp.LocateDoItDdDi (pDocNum:Str12;pItmNum:word;pDlvDoc:Str12;pDlvItm:word):boolean;
begin
  SetIndex (ixDoItDdDi);
  Result := oTmpTable.FindKey([pDocNum,pItmNum,pDlvDoc,pDlvItm]);
end;

function TOctTmp.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TOctTmp.LocateTdTi (pDlvDoc:Str12;pDlvItm:word):boolean;
begin
  SetIndex (ixTdTi);
  Result := oTmpTable.FindKey([pDlvDoc,pDlvItm]);
end;

procedure TOctTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TOctTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TOctTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TOctTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TOctTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TOctTmp.First;
begin
  oTmpTable.First;
end;

procedure TOctTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TOctTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TOctTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TOctTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TOctTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TOctTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TOctTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TOctTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TOctTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TOctTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TOctTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
