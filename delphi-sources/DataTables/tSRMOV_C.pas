unit tSRMOV_C;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixMoPaGs = '';
  ixPaGs = 'PaGs';
  ixPaCode = 'PaCode';
  ixGsCode = 'GsCode';
  ixGsName_ = 'GsName_';

type
  TSrmov_cTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadMovType:Str1;          procedure WriteMovType (pValue:Str1);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadMgCode:word;           procedure WriteMgCode (pValue:word);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadVolume:double;         procedure WriteVolume (pValue:double);
    function  ReadPrcVol:double;         procedure WritePrcVol (pValue:double);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadLaQnt:double;          procedure WriteLaQnt (pValue:double);
    function  ReadSrCode:Str15;          procedure WriteSrCode (pValue:Str15);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateMoPaGs (pMovType:Str1;pPaCode:longint;pGsCode:longint):boolean;
    function LocatePaGs (pPaCode:longint;pGsCode:longint):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName_ (pGsName_:Str30):boolean;

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
    property MovType:Str1 read ReadMovType write WriteMovType;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property MgCode:word read ReadMgCode write WriteMgCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property Volume:double read ReadVolume write WriteVolume;
    property PrcVol:double read ReadPrcVol write WritePrcVol;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property LaQnt:double read ReadLaQnt write WriteLaQnt;
    property SrCode:Str15 read ReadSrCode write WriteSrCode;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TSrmov_cTmp.Create;
begin
  oTmpTable := TmpInit ('SRMOV_C',Self);
end;

destructor TSrmov_cTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TSrmov_cTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TSrmov_cTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TSrmov_cTmp.ReadMovType:Str1;
begin
  Result := oTmpTable.FieldByName('MovType').AsString;
end;

procedure TSrmov_cTmp.WriteMovType(pValue:Str1);
begin
  oTmpTable.FieldByName('MovType').AsString := pValue;
end;

function TSrmov_cTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TSrmov_cTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TSrmov_cTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TSrmov_cTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TSrmov_cTmp.ReadMgCode:word;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TSrmov_cTmp.WriteMgCode(pValue:word);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TSrmov_cTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TSrmov_cTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TSrmov_cTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TSrmov_cTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TSrmov_cTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TSrmov_cTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TSrmov_cTmp.ReadVolume:double;
begin
  Result := oTmpTable.FieldByName('Volume').AsFloat;
end;

procedure TSrmov_cTmp.WriteVolume(pValue:double);
begin
  oTmpTable.FieldByName('Volume').AsFloat := pValue;
end;

function TSrmov_cTmp.ReadPrcVol:double;
begin
  Result := oTmpTable.FieldByName('PrcVol').AsFloat;
end;

procedure TSrmov_cTmp.WritePrcVol(pValue:double);
begin
  oTmpTable.FieldByName('PrcVol').AsFloat := pValue;
end;

function TSrmov_cTmp.ReadGsQnt:double;
begin
  Result := oTmpTable.FieldByName('GsQnt').AsFloat;
end;

procedure TSrmov_cTmp.WriteGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TSrmov_cTmp.ReadLaQnt:double;
begin
  Result := oTmpTable.FieldByName('LaQnt').AsFloat;
end;

procedure TSrmov_cTmp.WriteLaQnt(pValue:double);
begin
  oTmpTable.FieldByName('LaQnt').AsFloat := pValue;
end;

function TSrmov_cTmp.ReadSrCode:Str15;
begin
  Result := oTmpTable.FieldByName('SrCode').AsString;
end;

procedure TSrmov_cTmp.WriteSrCode(pValue:Str15);
begin
  oTmpTable.FieldByName('SrCode').AsString := pValue;
end;

function TSrmov_cTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TSrmov_cTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TSrmov_cTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TSrmov_cTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TSrmov_cTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TSrmov_cTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TSrmov_cTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TSrmov_cTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSrmov_cTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TSrmov_cTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TSrmov_cTmp.LocateMoPaGs (pMovType:Str1;pPaCode:longint;pGsCode:longint):boolean;
begin
  SetIndex (ixMoPaGs);
  Result := oTmpTable.FindKey([pMovType,pPaCode,pGsCode]);
end;

function TSrmov_cTmp.LocatePaGs (pPaCode:longint;pGsCode:longint):boolean;
begin
  SetIndex (ixPaGs);
  Result := oTmpTable.FindKey([pPaCode,pGsCode]);
end;

function TSrmov_cTmp.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oTmpTable.FindKey([pPaCode]);
end;

function TSrmov_cTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TSrmov_cTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

procedure TSrmov_cTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TSrmov_cTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TSrmov_cTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TSrmov_cTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TSrmov_cTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TSrmov_cTmp.First;
begin
  oTmpTable.First;
end;

procedure TSrmov_cTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TSrmov_cTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TSrmov_cTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TSrmov_cTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TSrmov_cTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TSrmov_cTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TSrmov_cTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TSrmov_cTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TSrmov_cTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TSrmov_cTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TSrmov_cTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
