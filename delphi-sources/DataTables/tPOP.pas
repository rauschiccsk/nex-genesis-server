unit tPOP;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRowNum = '';
  ixDoIt = 'DoIt';
  ixDocNum = 'DocNum';
  ixGsCode = 'GsCode';
  ixPosOut = 'PosOut';
  ixPosRet = 'PosRet';
  ixDoPoGs = 'DoPoGs';
  ixDoPrGs = 'DoPrGs';

type
  TPopTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRowNum:word;           procedure WriteRowNum (pValue:word);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadOutQnt:double;         procedure WriteOutQnt (pValue:double);
    function  ReadDlvQnt:double;         procedure WriteDlvQnt (pValue:double);
    function  ReadRetQnt:double;         procedure WriteRetQnt (pValue:double);
    function  ReadReoNum:byte;           procedure WriteReoNum (pValue:byte);
    function  ReadRerNum:byte;           procedure WriteRerNum (pValue:byte);
    function  ReadPosOut:Str15;          procedure WritePosOut (pValue:Str15);
    function  ReadPosRet:Str15;          procedure WritePosRet (pValue:Str15);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateRowNum (pRowNum:word):boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocatePosOut (pPosOut:Str15):boolean;
    function LocatePosRet (pPosRet:Str15):boolean;
    function LocateDoPoGs (pDocNum:Str12;pPosOut:Str15;pGsCode:longint):boolean;
    function LocateDoPrGs (pDocNum:Str12;pPosRet:Str15;pGsCode:longint):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open;
    procedure Close;
    procedure Prior;
    procedure Next;
    procedure First;
    procedure Last;
    procedure Insert;
    procedure Edit;
    procedure Post; virtual;
    procedure Delete;
    procedure SwapIndex;
    procedure RestoreIndex;
    procedure SwapStatus;
    procedure RestoreStatus;
    procedure DisableControls;
    procedure EnableControls;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read ReadCount;
    property RowNum:word read ReadRowNum write WriteRowNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property OutQnt:double read ReadOutQnt write WriteOutQnt;
    property DlvQnt:double read ReadDlvQnt write WriteDlvQnt;
    property RetQnt:double read ReadRetQnt write WriteRetQnt;
    property ReoNum:byte read ReadReoNum write WriteReoNum;
    property RerNum:byte read ReadRerNum write WriteRerNum;
    property PosOut:Str15 read ReadPosOut write WritePosOut;
    property PosRet:Str15 read ReadPosRet write WritePosRet;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TPopTmp.Create;
begin
  oTmpTable := TmpInit ('POP',Self);
end;

destructor TPopTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TPopTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TPopTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TPopTmp.ReadRowNum:word;
begin
  Result := oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TPopTmp.WriteRowNum(pValue:word);
begin
  oTmpTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TPopTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TPopTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TPopTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TPopTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TPopTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TPopTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TPopTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TPopTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TPopTmp.ReadGsQnt:double;
begin
  Result := oTmpTable.FieldByName('GsQnt').AsFloat;
end;

procedure TPopTmp.WriteGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TPopTmp.ReadOutQnt:double;
begin
  Result := oTmpTable.FieldByName('OutQnt').AsFloat;
end;

procedure TPopTmp.WriteOutQnt(pValue:double);
begin
  oTmpTable.FieldByName('OutQnt').AsFloat := pValue;
end;

function TPopTmp.ReadDlvQnt:double;
begin
  Result := oTmpTable.FieldByName('DlvQnt').AsFloat;
end;

procedure TPopTmp.WriteDlvQnt(pValue:double);
begin
  oTmpTable.FieldByName('DlvQnt').AsFloat := pValue;
end;

function TPopTmp.ReadRetQnt:double;
begin
  Result := oTmpTable.FieldByName('RetQnt').AsFloat;
end;

procedure TPopTmp.WriteRetQnt(pValue:double);
begin
  oTmpTable.FieldByName('RetQnt').AsFloat := pValue;
end;

function TPopTmp.ReadReoNum:byte;
begin
  Result := oTmpTable.FieldByName('ReoNum').AsInteger;
end;

procedure TPopTmp.WriteReoNum(pValue:byte);
begin
  oTmpTable.FieldByName('ReoNum').AsInteger := pValue;
end;

function TPopTmp.ReadRerNum:byte;
begin
  Result := oTmpTable.FieldByName('RerNum').AsInteger;
end;

procedure TPopTmp.WriteRerNum(pValue:byte);
begin
  oTmpTable.FieldByName('RerNum').AsInteger := pValue;
end;

function TPopTmp.ReadPosOut:Str15;
begin
  Result := oTmpTable.FieldByName('PosOut').AsString;
end;

procedure TPopTmp.WritePosOut(pValue:Str15);
begin
  oTmpTable.FieldByName('PosOut').AsString := pValue;
end;

function TPopTmp.ReadPosRet:Str15;
begin
  Result := oTmpTable.FieldByName('PosRet').AsString;
end;

procedure TPopTmp.WritePosRet(pValue:Str15);
begin
  oTmpTable.FieldByName('PosRet').AsString := pValue;
end;

function TPopTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TPopTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TPopTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TPopTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TPopTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TPopTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TPopTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TPopTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TPopTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TPopTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TPopTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TPopTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPopTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TPopTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TPopTmp.LocateRowNum (pRowNum:word):boolean;
begin
  SetIndex (ixRowNum);
  Result := oTmpTable.FindKey([pRowNum]);
end;

function TPopTmp.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TPopTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TPopTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TPopTmp.LocatePosOut (pPosOut:Str15):boolean;
begin
  SetIndex (ixPosOut);
  Result := oTmpTable.FindKey([pPosOut]);
end;

function TPopTmp.LocatePosRet (pPosRet:Str15):boolean;
begin
  SetIndex (ixPosRet);
  Result := oTmpTable.FindKey([pPosRet]);
end;

function TPopTmp.LocateDoPoGs (pDocNum:Str12;pPosOut:Str15;pGsCode:longint):boolean;
begin
  SetIndex (ixDoPoGs);
  Result := oTmpTable.FindKey([pDocNum,pPosOut,pGsCode]);
end;

function TPopTmp.LocateDoPrGs (pDocNum:Str12;pPosRet:Str15;pGsCode:longint):boolean;
begin
  SetIndex (ixDoPrGs);
  Result := oTmpTable.FindKey([pDocNum,pPosRet,pGsCode]);
end;

procedure TPopTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TPopTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TPopTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TPopTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TPopTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TPopTmp.First;
begin
  oTmpTable.First;
end;

procedure TPopTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TPopTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TPopTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TPopTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TPopTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TPopTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TPopTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TPopTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TPopTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TPopTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TPopTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
