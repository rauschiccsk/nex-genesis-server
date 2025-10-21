unit tSRCAT;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixBarCode = '';
  ixGsCode = 'GsCode';
  ixMgGs = 'MgGs';
  ixGsName = 'GsName';
  ixSended = 'Sended';

type
  TSrcatTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadVolume:double;         procedure WriteVolume (pValue:double);
    function  ReadPrcVol:double;         procedure WritePrcVol (pValue:double);
    function  ReadSended:byte;           procedure WriteSended (pValue:byte);
    function  ReadCrtName:Str8;          procedure WriteCrtName (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadVolumeDBF:double;      procedure WriteVolumeDBF (pValue:double);
    function  ReadPrcVolDBF:double;      procedure WritePrcVolDBF (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateMgGs (pMgCode:longint;pGsCode:longint):boolean;
    function LocateGsName (pGsName_:Str30):boolean;
    function LocateSended (pSended:byte):boolean;

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
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property Volume:double read ReadVolume write WriteVolume;
    property PrcVol:double read ReadPrcVol write WritePrcVol;
    property Sended:byte read ReadSended write WriteSended;
    property CrtName:Str8 read ReadCrtName write WriteCrtName;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property VolumeDBF:double read ReadVolumeDBF write WriteVolumeDBF;
    property PrcVolDBF:double read ReadPrcVolDBF write WritePrcVolDBF;
  end;

implementation

constructor TSrcatTmp.Create;
begin
  oTmpTable := TmpInit ('SRCAT',Self);
end;

destructor TSrcatTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TSrcatTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TSrcatTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TSrcatTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TSrcatTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TSrcatTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TSrcatTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TSrcatTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TSrcatTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TSrcatTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TSrcatTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TSrcatTmp.ReadMgCode:longint;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TSrcatTmp.WriteMgCode(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TSrcatTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TSrcatTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TSrcatTmp.ReadVolume:double;
begin
  Result := oTmpTable.FieldByName('Volume').AsFloat;
end;

procedure TSrcatTmp.WriteVolume(pValue:double);
begin
  oTmpTable.FieldByName('Volume').AsFloat := pValue;
end;

function TSrcatTmp.ReadPrcVol:double;
begin
  Result := oTmpTable.FieldByName('PrcVol').AsFloat;
end;

procedure TSrcatTmp.WritePrcVol(pValue:double);
begin
  oTmpTable.FieldByName('PrcVol').AsFloat := pValue;
end;

function TSrcatTmp.ReadSended:byte;
begin
  Result := oTmpTable.FieldByName('Sended').AsInteger;
end;

procedure TSrcatTmp.WriteSended(pValue:byte);
begin
  oTmpTable.FieldByName('Sended').AsInteger := pValue;
end;

function TSrcatTmp.ReadCrtName:Str8;
begin
  Result := oTmpTable.FieldByName('CrtName').AsString;
end;

procedure TSrcatTmp.WriteCrtName(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtName').AsString := pValue;
end;

function TSrcatTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TSrcatTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TSrcatTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TSrcatTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TSrcatTmp.ReadModNum:word;
begin
  Result := oTmpTable.FieldByName('ModNum').AsInteger;
end;

procedure TSrcatTmp.WriteModNum(pValue:word);
begin
  oTmpTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TSrcatTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TSrcatTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TSrcatTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TSrcatTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TSrcatTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TSrcatTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TSrcatTmp.ReadVolumeDBF:double;
begin
  Result := oTmpTable.FieldByName('VolumeDBF').AsFloat;
end;

procedure TSrcatTmp.WriteVolumeDBF(pValue:double);
begin
  oTmpTable.FieldByName('VolumeDBF').AsFloat := pValue;
end;

function TSrcatTmp.ReadPrcVolDBF:double;
begin
  Result := oTmpTable.FieldByName('PrcVolDBF').AsFloat;
end;

procedure TSrcatTmp.WritePrcVolDBF(pValue:double);
begin
  oTmpTable.FieldByName('PrcVolDBF').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSrcatTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TSrcatTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TSrcatTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

function TSrcatTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TSrcatTmp.LocateMgGs (pMgCode:longint;pGsCode:longint):boolean;
begin
  SetIndex (ixMgGs);
  Result := oTmpTable.FindKey([pMgCode,pGsCode]);
end;

function TSrcatTmp.LocateGsName (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName);
  Result := oTmpTable.FindKey([pGsName_]);
end;

function TSrcatTmp.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oTmpTable.FindKey([pSended]);
end;

procedure TSrcatTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TSrcatTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TSrcatTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TSrcatTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TSrcatTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TSrcatTmp.First;
begin
  oTmpTable.First;
end;

procedure TSrcatTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TSrcatTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TSrcatTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TSrcatTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TSrcatTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TSrcatTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TSrcatTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TSrcatTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TSrcatTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TSrcatTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TSrcatTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
