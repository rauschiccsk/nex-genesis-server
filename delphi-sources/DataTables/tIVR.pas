unit tIVR;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRecNum = '';
  ixIlPoGs = 'IlPoGs';
  ixPoCode = 'PoCode';
  ixGsCode = 'GsCode';

type
  TIvrTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRecNum:word;           procedure WriteRecNum (pValue:word);
    function  ReadIvlNum:word;           procedure WriteIvlNum (pValue:word);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadTrmNum:word;           procedure WriteTrmNum (pValue:word);
    function  ReadIvFase:byte;           procedure WriteIvFase (pValue:byte);
    function  ReadPoCode:Str15;          procedure WritePoCode (pValue:Str15);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadSrCode:Str15;          procedure WriteSrCode (pValue:Str15);
    function  ReadBefQnt:double;         procedure WriteBefQnt (pValue:double);
    function  ReadInvQnt:double;         procedure WriteInvQnt (pValue:double);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtName:str30;         procedure WriteCrtName (pValue:str30);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateRecNum (pRecNum:word):boolean;
    function LocateIlPoGs (pIvlNum:word;pPoCode:Str15;pGsCode:longint):boolean;
    function LocatePoCode (pPoCode:Str15):boolean;
    function LocateGsCode (pGsCode:longint):boolean;

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
    property RecNum:word read ReadRecNum write WriteRecNum;
    property IvlNum:word read ReadIvlNum write WriteIvlNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property TrmNum:word read ReadTrmNum write WriteTrmNum;
    property IvFase:byte read ReadIvFase write WriteIvFase;
    property PoCode:Str15 read ReadPoCode write WritePoCode;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property SrCode:Str15 read ReadSrCode write WriteSrCode;
    property BefQnt:double read ReadBefQnt write WriteBefQnt;
    property InvQnt:double read ReadInvQnt write WriteInvQnt;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtName:str30 read ReadCrtName write WriteCrtName;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TIvrTmp.Create;
begin
  oTmpTable := TmpInit ('IVR',Self);
end;

destructor TIvrTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TIvrTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TIvrTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TIvrTmp.ReadRecNum:word;
begin
  Result := oTmpTable.FieldByName('RecNum').AsInteger;
end;

procedure TIvrTmp.WriteRecNum(pValue:word);
begin
  oTmpTable.FieldByName('RecNum').AsInteger := pValue;
end;

function TIvrTmp.ReadIvlNum:word;
begin
  Result := oTmpTable.FieldByName('IvlNum').AsInteger;
end;

procedure TIvrTmp.WriteIvlNum(pValue:word);
begin
  oTmpTable.FieldByName('IvlNum').AsInteger := pValue;
end;

function TIvrTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TIvrTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TIvrTmp.ReadTrmNum:word;
begin
  Result := oTmpTable.FieldByName('TrmNum').AsInteger;
end;

procedure TIvrTmp.WriteTrmNum(pValue:word);
begin
  oTmpTable.FieldByName('TrmNum').AsInteger := pValue;
end;

function TIvrTmp.ReadIvFase:byte;
begin
  Result := oTmpTable.FieldByName('IvFase').AsInteger;
end;

procedure TIvrTmp.WriteIvFase(pValue:byte);
begin
  oTmpTable.FieldByName('IvFase').AsInteger := pValue;
end;

function TIvrTmp.ReadPoCode:Str15;
begin
  Result := oTmpTable.FieldByName('PoCode').AsString;
end;

procedure TIvrTmp.WritePoCode(pValue:Str15);
begin
  oTmpTable.FieldByName('PoCode').AsString := pValue;
end;

function TIvrTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TIvrTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TIvrTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TIvrTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TIvrTmp.ReadSrCode:Str15;
begin
  Result := oTmpTable.FieldByName('SrCode').AsString;
end;

procedure TIvrTmp.WriteSrCode(pValue:Str15);
begin
  oTmpTable.FieldByName('SrCode').AsString := pValue;
end;

function TIvrTmp.ReadBefQnt:double;
begin
  Result := oTmpTable.FieldByName('BefQnt').AsFloat;
end;

procedure TIvrTmp.WriteBefQnt(pValue:double);
begin
  oTmpTable.FieldByName('BefQnt').AsFloat := pValue;
end;

function TIvrTmp.ReadInvQnt:double;
begin
  Result := oTmpTable.FieldByName('InvQnt').AsFloat;
end;

procedure TIvrTmp.WriteInvQnt(pValue:double);
begin
  oTmpTable.FieldByName('InvQnt').AsFloat := pValue;
end;

function TIvrTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TIvrTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TIvrTmp.ReadCrtName:str30;
begin
  Result := oTmpTable.FieldByName('CrtName').AsString;
end;

procedure TIvrTmp.WriteCrtName(pValue:str30);
begin
  oTmpTable.FieldByName('CrtName').AsString := pValue;
end;

function TIvrTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TIvrTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TIvrTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TIvrTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TIvrTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TIvrTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TIvrTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TIvrTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TIvrTmp.LocateRecNum (pRecNum:word):boolean;
begin
  SetIndex (ixRecNum);
  Result := oTmpTable.FindKey([pRecNum]);
end;

function TIvrTmp.LocateIlPoGs (pIvlNum:word;pPoCode:Str15;pGsCode:longint):boolean;
begin
  SetIndex (ixIlPoGs);
  Result := oTmpTable.FindKey([pIvlNum,pPoCode,pGsCode]);
end;

function TIvrTmp.LocatePoCode (pPoCode:Str15):boolean;
begin
  SetIndex (ixPoCode);
  Result := oTmpTable.FindKey([pPoCode]);
end;

function TIvrTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

procedure TIvrTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TIvrTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TIvrTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TIvrTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TIvrTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TIvrTmp.First;
begin
  oTmpTable.First;
end;

procedure TIvrTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TIvrTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TIvrTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TIvrTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TIvrTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TIvrTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TIvrTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TIvrTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TIvrTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TIvrTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TIvrTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1930001}
