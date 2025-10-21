unit tSRSTA;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsCode = '';
  ixGsName_ = 'GsName_';
  ixMgCode = 'MgCode';
  ixBarCode = 'BarCode';

type
  TSrstaTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadMgCode:word;           procedure WriteMgCode (pValue:word);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadBegQnt:double;         procedure WriteBegQnt (pValue:double);
    function  ReadIncQnt:double;         procedure WriteIncQnt (pValue:double);
    function  ReadOutQnt:double;         procedure WriteOutQnt (pValue:double);
    function  ReadEndQnt:double;         procedure WriteEndQnt (pValue:double);
    function  ReadVolume:double;         procedure WriteVolume (pValue:double);
    function  ReadPrcVol:double;         procedure WritePrcVol (pValue:double);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
    function  ReadInvQnt:double;         procedure WriteInvQnt (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName_ (pGsName_:Str30):boolean;
    function LocateMgCode (pMgCode:word):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;

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
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property MgCode:word read ReadMgCode write WriteMgCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property BegQnt:double read ReadBegQnt write WriteBegQnt;
    property IncQnt:double read ReadIncQnt write WriteIncQnt;
    property OutQnt:double read ReadOutQnt write WriteOutQnt;
    property EndQnt:double read ReadEndQnt write WriteEndQnt;
    property Volume:double read ReadVolume write WriteVolume;
    property PrcVol:double read ReadPrcVol write WritePrcVol;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ActPos:longint read ReadActPos write WriteActPos;
    property InvQnt:double read ReadInvQnt write WriteInvQnt;
  end;

implementation

constructor TSrstaTmp.Create;
begin
  oTmpTable := TmpInit ('SRSTA',Self);
end;

destructor TSrstaTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TSrstaTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TSrstaTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TSrstaTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TSrstaTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TSrstaTmp.ReadMgCode:word;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TSrstaTmp.WriteMgCode(pValue:word);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TSrstaTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TSrstaTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TSrstaTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TSrstaTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TSrstaTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TSrstaTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TSrstaTmp.ReadBegQnt:double;
begin
  Result := oTmpTable.FieldByName('BegQnt').AsFloat;
end;

procedure TSrstaTmp.WriteBegQnt(pValue:double);
begin
  oTmpTable.FieldByName('BegQnt').AsFloat := pValue;
end;

function TSrstaTmp.ReadIncQnt:double;
begin
  Result := oTmpTable.FieldByName('IncQnt').AsFloat;
end;

procedure TSrstaTmp.WriteIncQnt(pValue:double);
begin
  oTmpTable.FieldByName('IncQnt').AsFloat := pValue;
end;

function TSrstaTmp.ReadOutQnt:double;
begin
  Result := oTmpTable.FieldByName('OutQnt').AsFloat;
end;

procedure TSrstaTmp.WriteOutQnt(pValue:double);
begin
  oTmpTable.FieldByName('OutQnt').AsFloat := pValue;
end;

function TSrstaTmp.ReadEndQnt:double;
begin
  Result := oTmpTable.FieldByName('EndQnt').AsFloat;
end;

procedure TSrstaTmp.WriteEndQnt(pValue:double);
begin
  oTmpTable.FieldByName('EndQnt').AsFloat := pValue;
end;

function TSrstaTmp.ReadVolume:double;
begin
  Result := oTmpTable.FieldByName('Volume').AsFloat;
end;

procedure TSrstaTmp.WriteVolume(pValue:double);
begin
  oTmpTable.FieldByName('Volume').AsFloat := pValue;
end;

function TSrstaTmp.ReadPrcVol:double;
begin
  Result := oTmpTable.FieldByName('PrcVol').AsFloat;
end;

procedure TSrstaTmp.WritePrcVol(pValue:double);
begin
  oTmpTable.FieldByName('PrcVol').AsFloat := pValue;
end;

function TSrstaTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TSrstaTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TSrstaTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TSrstaTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TSrstaTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TSrstaTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TSrstaTmp.ReadModNum:word;
begin
  Result := oTmpTable.FieldByName('ModNum').AsInteger;
end;

procedure TSrstaTmp.WriteModNum(pValue:word);
begin
  oTmpTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TSrstaTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TSrstaTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TSrstaTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TSrstaTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TSrstaTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TSrstaTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TSrstaTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TSrstaTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

function TSrstaTmp.ReadInvQnt:double;
begin
  Result := oTmpTable.FieldByName('InvQnt').AsFloat;
end;

procedure TSrstaTmp.WriteInvQnt(pValue:double);
begin
  oTmpTable.FieldByName('InvQnt').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSrstaTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TSrstaTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TSrstaTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TSrstaTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

function TSrstaTmp.LocateMgCode (pMgCode:word):boolean;
begin
  SetIndex (ixMgCode);
  Result := oTmpTable.FindKey([pMgCode]);
end;

function TSrstaTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

procedure TSrstaTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TSrstaTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TSrstaTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TSrstaTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TSrstaTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TSrstaTmp.First;
begin
  oTmpTable.First;
end;

procedure TSrstaTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TSrstaTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TSrstaTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TSrstaTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TSrstaTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TSrstaTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TSrstaTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TSrstaTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TSrstaTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TSrstaTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TSrstaTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
