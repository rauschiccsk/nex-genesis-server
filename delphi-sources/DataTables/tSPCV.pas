unit tSPCV;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsCode = '';

type
  TSpcvTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadSpcQnt:double;         procedure WriteSpcQnt (pValue:double);
    function  ReadSpcResQnt:double;      procedure WriteSpcResQnt (pValue:double);
    function  ReadSpmQnt:double;         procedure WriteSpmQnt (pValue:double);
    function  ReadSpmResQnt:double;      procedure WriteSpmResQnt (pValue:double);
    function  ReadStQnt:double;          procedure WriteStQnt (pValue:double);
    function  ReadCDifQnt:double;        procedure WriteCDifQnt (pValue:double);
    function  ReadSDifQnt:double;        procedure WriteSDifQnt (pValue:double);
    function  ReadResDifQnt:double;      procedure WriteResDifQnt (pValue:double);
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
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property SpcQnt:double read ReadSpcQnt write WriteSpcQnt;
    property SpcResQnt:double read ReadSpcResQnt write WriteSpcResQnt;
    property SpmQnt:double read ReadSpmQnt write WriteSpmQnt;
    property SpmResQnt:double read ReadSpmResQnt write WriteSpmResQnt;
    property StQnt:double read ReadStQnt write WriteStQnt;
    property CDifQnt:double read ReadCDifQnt write WriteCDifQnt;
    property SDifQnt:double read ReadSDifQnt write WriteSDifQnt;
    property ResDifQnt:double read ReadResDifQnt write WriteResDifQnt;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TSpcvTmp.Create;
begin
  oTmpTable := TmpInit ('SPCV',Self);
end;

destructor TSpcvTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TSpcvTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TSpcvTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TSpcvTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TSpcvTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TSpcvTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TSpcvTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TSpcvTmp.ReadSpcQnt:double;
begin
  Result := oTmpTable.FieldByName('SpcQnt').AsFloat;
end;

procedure TSpcvTmp.WriteSpcQnt(pValue:double);
begin
  oTmpTable.FieldByName('SpcQnt').AsFloat := pValue;
end;

function TSpcvTmp.ReadSpcResQnt:double;
begin
  Result := oTmpTable.FieldByName('SpcResQnt').AsFloat;
end;

procedure TSpcvTmp.WriteSpcResQnt(pValue:double);
begin
  oTmpTable.FieldByName('SpcResQnt').AsFloat := pValue;
end;

function TSpcvTmp.ReadSpmQnt:double;
begin
  Result := oTmpTable.FieldByName('SpmQnt').AsFloat;
end;

procedure TSpcvTmp.WriteSpmQnt(pValue:double);
begin
  oTmpTable.FieldByName('SpmQnt').AsFloat := pValue;
end;

function TSpcvTmp.ReadSpmResQnt:double;
begin
  Result := oTmpTable.FieldByName('SpmResQnt').AsFloat;
end;

procedure TSpcvTmp.WriteSpmResQnt(pValue:double);
begin
  oTmpTable.FieldByName('SpmResQnt').AsFloat := pValue;
end;

function TSpcvTmp.ReadStQnt:double;
begin
  Result := oTmpTable.FieldByName('StQnt').AsFloat;
end;

procedure TSpcvTmp.WriteStQnt(pValue:double);
begin
  oTmpTable.FieldByName('StQnt').AsFloat := pValue;
end;

function TSpcvTmp.ReadCDifQnt:double;
begin
  Result := oTmpTable.FieldByName('CDifQnt').AsFloat;
end;

procedure TSpcvTmp.WriteCDifQnt(pValue:double);
begin
  oTmpTable.FieldByName('CDifQnt').AsFloat := pValue;
end;

function TSpcvTmp.ReadSDifQnt:double;
begin
  Result := oTmpTable.FieldByName('SDifQnt').AsFloat;
end;

procedure TSpcvTmp.WriteSDifQnt(pValue:double);
begin
  oTmpTable.FieldByName('SDifQnt').AsFloat := pValue;
end;

function TSpcvTmp.ReadResDifQnt:double;
begin
  Result := oTmpTable.FieldByName('ResDifQnt').AsFloat;
end;

procedure TSpcvTmp.WriteResDifQnt(pValue:double);
begin
  oTmpTable.FieldByName('ResDifQnt').AsFloat := pValue;
end;

function TSpcvTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TSpcvTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TSpcvTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TSpcvTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TSpcvTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TSpcvTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TSpcvTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TSpcvTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TSpcvTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TSpcvTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TSpcvTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TSpcvTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSpcvTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TSpcvTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TSpcvTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

procedure TSpcvTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TSpcvTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TSpcvTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TSpcvTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TSpcvTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TSpcvTmp.First;
begin
  oTmpTable.First;
end;

procedure TSpcvTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TSpcvTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TSpcvTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TSpcvTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TSpcvTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TSpcvTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TSpcvTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TSpcvTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TSpcvTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TSpcvTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TSpcvTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
