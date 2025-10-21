unit tTCDTOM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRowNum = '';
  ixTcDoIt = 'TcDoIt';
  ixToDoIt = 'ToDoIt';

type
  TTcdtomTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRowNum:longint;        procedure WriteRowNum (pValue:longint);
    function  ReadTcDocNum:Str15;        procedure WriteTcDocNum (pValue:Str15);
    function  ReadTcItmNum:longint;      procedure WriteTcItmNum (pValue:longint);
    function  ReadTcIcdDate:TDatetime;   procedure WriteTcIcdDate (pValue:TDatetime);
    function  ReadTcIcdNum:Str15;        procedure WriteTcIcdNum (pValue:Str15);
    function  ReadTcIcdItm:longint;      procedure WriteTcIcdItm (pValue:longint);
    function  ReadTcFinStat:Str1;        procedure WriteTcFinStat (pValue:Str1);
    function  ReadToDocNum:Str15;        procedure WriteToDocNum (pValue:Str15);
    function  ReadToItmNum:longint;      procedure WriteToItmNum (pValue:longint);
    function  ReadToIcdDate:TDatetime;   procedure WriteToIcdDate (pValue:TDatetime);
    function  ReadToIcdNum:Str15;        procedure WriteToIcdNum (pValue:Str15);
    function  ReadToIcdItm:longint;      procedure WriteToIcdItm (pValue:longint);
    function  ReadToCadNum:Str15;        procedure WriteToCadNum (pValue:Str15);
    function  ReadToFinStat:Str1;        procedure WriteToFinStat (pValue:Str1);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateRowNum (pRowNum:longint):boolean;
    function LocateTcDoIt (pTcDocNum:Str15;pTcItmNum:longint):boolean;
    function LocateToDoIt (pToDocNum:Str15;pToItmNum:longint):boolean;

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
    property TcDocNum:Str15 read ReadTcDocNum write WriteTcDocNum;
    property TcItmNum:longint read ReadTcItmNum write WriteTcItmNum;
    property TcIcdDate:TDatetime read ReadTcIcdDate write WriteTcIcdDate;
    property TcIcdNum:Str15 read ReadTcIcdNum write WriteTcIcdNum;
    property TcIcdItm:longint read ReadTcIcdItm write WriteTcIcdItm;
    property TcFinStat:Str1 read ReadTcFinStat write WriteTcFinStat;
    property ToDocNum:Str15 read ReadToDocNum write WriteToDocNum;
    property ToItmNum:longint read ReadToItmNum write WriteToItmNum;
    property ToIcdDate:TDatetime read ReadToIcdDate write WriteToIcdDate;
    property ToIcdNum:Str15 read ReadToIcdNum write WriteToIcdNum;
    property ToIcdItm:longint read ReadToIcdItm write WriteToIcdItm;
    property ToCadNum:Str15 read ReadToCadNum write WriteToCadNum;
    property ToFinStat:Str1 read ReadToFinStat write WriteToFinStat;
  end;

implementation

constructor TTcdtomTmp.Create;
begin
  oTmpTable := TmpInit ('TCDTOM',Self);
end;

destructor TTcdtomTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TTcdtomTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TTcdtomTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TTcdtomTmp.ReadRowNum:longint;
begin
  Result := oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TTcdtomTmp.WriteRowNum(pValue:longint);
begin
  oTmpTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TTcdtomTmp.ReadTcDocNum:Str15;
begin
  Result := oTmpTable.FieldByName('TcDocNum').AsString;
end;

procedure TTcdtomTmp.WriteTcDocNum(pValue:Str15);
begin
  oTmpTable.FieldByName('TcDocNum').AsString := pValue;
end;

function TTcdtomTmp.ReadTcItmNum:longint;
begin
  Result := oTmpTable.FieldByName('TcItmNum').AsInteger;
end;

procedure TTcdtomTmp.WriteTcItmNum(pValue:longint);
begin
  oTmpTable.FieldByName('TcItmNum').AsInteger := pValue;
end;

function TTcdtomTmp.ReadTcIcdDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('TcIcdDate').AsDateTime;
end;

procedure TTcdtomTmp.WriteTcIcdDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TcIcdDate').AsDateTime := pValue;
end;

function TTcdtomTmp.ReadTcIcdNum:Str15;
begin
  Result := oTmpTable.FieldByName('TcIcdNum').AsString;
end;

procedure TTcdtomTmp.WriteTcIcdNum(pValue:Str15);
begin
  oTmpTable.FieldByName('TcIcdNum').AsString := pValue;
end;

function TTcdtomTmp.ReadTcIcdItm:longint;
begin
  Result := oTmpTable.FieldByName('TcIcdItm').AsInteger;
end;

procedure TTcdtomTmp.WriteTcIcdItm(pValue:longint);
begin
  oTmpTable.FieldByName('TcIcdItm').AsInteger := pValue;
end;

function TTcdtomTmp.ReadTcFinStat:Str1;
begin
  Result := oTmpTable.FieldByName('TcFinStat').AsString;
end;

procedure TTcdtomTmp.WriteTcFinStat(pValue:Str1);
begin
  oTmpTable.FieldByName('TcFinStat').AsString := pValue;
end;

function TTcdtomTmp.ReadToDocNum:Str15;
begin
  Result := oTmpTable.FieldByName('ToDocNum').AsString;
end;

procedure TTcdtomTmp.WriteToDocNum(pValue:Str15);
begin
  oTmpTable.FieldByName('ToDocNum').AsString := pValue;
end;

function TTcdtomTmp.ReadToItmNum:longint;
begin
  Result := oTmpTable.FieldByName('ToItmNum').AsInteger;
end;

procedure TTcdtomTmp.WriteToItmNum(pValue:longint);
begin
  oTmpTable.FieldByName('ToItmNum').AsInteger := pValue;
end;

function TTcdtomTmp.ReadToIcdDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ToIcdDate').AsDateTime;
end;

procedure TTcdtomTmp.WriteToIcdDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ToIcdDate').AsDateTime := pValue;
end;

function TTcdtomTmp.ReadToIcdNum:Str15;
begin
  Result := oTmpTable.FieldByName('ToIcdNum').AsString;
end;

procedure TTcdtomTmp.WriteToIcdNum(pValue:Str15);
begin
  oTmpTable.FieldByName('ToIcdNum').AsString := pValue;
end;

function TTcdtomTmp.ReadToIcdItm:longint;
begin
  Result := oTmpTable.FieldByName('ToIcdItm').AsInteger;
end;

procedure TTcdtomTmp.WriteToIcdItm(pValue:longint);
begin
  oTmpTable.FieldByName('ToIcdItm').AsInteger := pValue;
end;

function TTcdtomTmp.ReadToCadNum:Str15;
begin
  Result := oTmpTable.FieldByName('ToCadNum').AsString;
end;

procedure TTcdtomTmp.WriteToCadNum(pValue:Str15);
begin
  oTmpTable.FieldByName('ToCadNum').AsString := pValue;
end;

function TTcdtomTmp.ReadToFinStat:Str1;
begin
  Result := oTmpTable.FieldByName('ToFinStat').AsString;
end;

procedure TTcdtomTmp.WriteToFinStat(pValue:Str1);
begin
  oTmpTable.FieldByName('ToFinStat').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTcdtomTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TTcdtomTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TTcdtomTmp.LocateRowNum (pRowNum:longint):boolean;
begin
  SetIndex (ixRowNum);
  Result := oTmpTable.FindKey([pRowNum]);
end;

function TTcdtomTmp.LocateTcDoIt (pTcDocNum:Str15;pTcItmNum:longint):boolean;
begin
  SetIndex (ixTcDoIt);
  Result := oTmpTable.FindKey([pTcDocNum,pTcItmNum]);
end;

function TTcdtomTmp.LocateToDoIt (pToDocNum:Str15;pToItmNum:longint):boolean;
begin
  SetIndex (ixToDoIt);
  Result := oTmpTable.FindKey([pToDocNum,pToItmNum]);
end;

procedure TTcdtomTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TTcdtomTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TTcdtomTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TTcdtomTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TTcdtomTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TTcdtomTmp.First;
begin
  oTmpTable.First;
end;

procedure TTcdtomTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TTcdtomTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TTcdtomTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TTcdtomTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TTcdtomTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TTcdtomTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TTcdtomTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TTcdtomTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TTcdtomTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TTcdtomTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TTcdtomTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
