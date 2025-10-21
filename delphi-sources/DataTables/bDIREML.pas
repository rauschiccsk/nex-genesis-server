unit bDIREML;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixCnEsEa = 'CnEsEa';
  ixCnEs = 'CnEs';
  ixCntNum = 'CntNum';

type
  TDiremlBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadCntNum:longint;        procedure WriteCntNum (pValue:longint);
    function  ReadEmlSpc:Str1;           procedure WriteEmlSpc (pValue:Str1);
    function  ReadEmlAdr:Str30;          procedure WriteEmlAdr (pValue:Str30);
    function  ReadEmlDes:Str60;          procedure WriteEmlDes (pValue:Str60);
    function  ReadMarker:Str1;           procedure WriteMarker (pValue:Str1);
    function  ReadUsrLev:byte;           procedure WriteUsrLev (pValue:byte);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateCnEsEa (pCntNum:longint;pEmlSpc:Str1;pEmlAdr:Str30):boolean;
    function LocateCnEs (pCntNum:longint;pEmlSpc:Str1):boolean;
    function LocateCntNum (pCntNum:longint):boolean;
    function NearestCnEsEa (pCntNum:longint;pEmlSpc:Str1;pEmlAdr:Str30):boolean;
    function NearestCnEs (pCntNum:longint;pEmlSpc:Str1):boolean;
    function NearestCntNum (pCntNum:longint):boolean;

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
    property CntNum:longint read ReadCntNum write WriteCntNum;
    property EmlSpc:Str1 read ReadEmlSpc write WriteEmlSpc;
    property EmlAdr:Str30 read ReadEmlAdr write WriteEmlAdr;
    property EmlDes:Str60 read ReadEmlDes write WriteEmlDes;
    property Marker:Str1 read ReadMarker write WriteMarker;
    property UsrLev:byte read ReadUsrLev write WriteUsrLev;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TDiremlBtr.Create;
begin
  oBtrTable := BtrInit ('DIREML',gPath.DlsPath,Self);
end;

constructor TDiremlBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('DIREML',pPath,Self);
end;

destructor TDiremlBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TDiremlBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TDiremlBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TDiremlBtr.ReadCntNum:longint;
begin
  Result := oBtrTable.FieldByName('CntNum').AsInteger;
end;

procedure TDiremlBtr.WriteCntNum(pValue:longint);
begin
  oBtrTable.FieldByName('CntNum').AsInteger := pValue;
end;

function TDiremlBtr.ReadEmlSpc:Str1;
begin
  Result := oBtrTable.FieldByName('EmlSpc').AsString;
end;

procedure TDiremlBtr.WriteEmlSpc(pValue:Str1);
begin
  oBtrTable.FieldByName('EmlSpc').AsString := pValue;
end;

function TDiremlBtr.ReadEmlAdr:Str30;
begin
  Result := oBtrTable.FieldByName('EmlAdr').AsString;
end;

procedure TDiremlBtr.WriteEmlAdr(pValue:Str30);
begin
  oBtrTable.FieldByName('EmlAdr').AsString := pValue;
end;

function TDiremlBtr.ReadEmlDes:Str60;
begin
  Result := oBtrTable.FieldByName('EmlDes').AsString;
end;

procedure TDiremlBtr.WriteEmlDes(pValue:Str60);
begin
  oBtrTable.FieldByName('EmlDes').AsString := pValue;
end;

function TDiremlBtr.ReadMarker:Str1;
begin
  Result := oBtrTable.FieldByName('Marker').AsString;
end;

procedure TDiremlBtr.WriteMarker(pValue:Str1);
begin
  oBtrTable.FieldByName('Marker').AsString := pValue;
end;

function TDiremlBtr.ReadUsrLev:byte;
begin
  Result := oBtrTable.FieldByName('UsrLev').AsInteger;
end;

procedure TDiremlBtr.WriteUsrLev(pValue:byte);
begin
  oBtrTable.FieldByName('UsrLev').AsInteger := pValue;
end;

function TDiremlBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TDiremlBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TDiremlBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TDiremlBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TDiremlBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TDiremlBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TDiremlBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TDiremlBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TDiremlBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TDiremlBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TDiremlBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TDiremlBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TDiremlBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TDiremlBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TDiremlBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TDiremlBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TDiremlBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TDiremlBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TDiremlBtr.LocateCnEsEa (pCntNum:longint;pEmlSpc:Str1;pEmlAdr:Str30):boolean;
begin
  SetIndex (ixCnEsEa);
  Result := oBtrTable.FindKey([pCntNum,pEmlSpc,pEmlAdr]);
end;

function TDiremlBtr.LocateCnEs (pCntNum:longint;pEmlSpc:Str1):boolean;
begin
  SetIndex (ixCnEs);
  Result := oBtrTable.FindKey([pCntNum,pEmlSpc]);
end;

function TDiremlBtr.LocateCntNum (pCntNum:longint):boolean;
begin
  SetIndex (ixCntNum);
  Result := oBtrTable.FindKey([pCntNum]);
end;

function TDiremlBtr.NearestCnEsEa (pCntNum:longint;pEmlSpc:Str1;pEmlAdr:Str30):boolean;
begin
  SetIndex (ixCnEsEa);
  Result := oBtrTable.FindNearest([pCntNum,pEmlSpc,pEmlAdr]);
end;

function TDiremlBtr.NearestCnEs (pCntNum:longint;pEmlSpc:Str1):boolean;
begin
  SetIndex (ixCnEs);
  Result := oBtrTable.FindNearest([pCntNum,pEmlSpc]);
end;

function TDiremlBtr.NearestCntNum (pCntNum:longint):boolean;
begin
  SetIndex (ixCntNum);
  Result := oBtrTable.FindNearest([pCntNum]);
end;

procedure TDiremlBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TDiremlBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TDiremlBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TDiremlBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TDiremlBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TDiremlBtr.First;
begin
  oBtrTable.First;
end;

procedure TDiremlBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TDiremlBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TDiremlBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TDiremlBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TDiremlBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TDiremlBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TDiremlBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TDiremlBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TDiremlBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TDiremlBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TDiremlBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
