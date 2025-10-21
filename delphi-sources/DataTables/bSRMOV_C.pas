unit bSRMOV_C;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSerNum = 'SerNum';
  ixSnMo = 'SnMo';
  ixSnMoPa = 'SnMoPa';
  ixSnMoPaGs = 'SnMoPaGs';
  ixGsCode = 'GsCode';

type
  TSrmov_cBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
    function  ReadMovType:Str1;          procedure WriteMovType (pValue:Str1);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadMgCode:word;           procedure WriteMgCode (pValue:word);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadVolume:double;         procedure WriteVolume (pValue:double);
    function  ReadPrcVol:double;         procedure WritePrcVol (pValue:double);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadLaQnt:double;          procedure WriteLaQnt (pValue:double);
    function  ReadSrCode:Str15;          procedure WriteSrCode (pValue:Str15);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateSerNum (pSerNum:longint):boolean;
    function LocateSnMo (pSerNum:longint;pMovType:Str1):boolean;
    function LocateSnMoPa (pSerNum:longint;pMovType:Str1;pPaCode:longint):boolean;
    function LocateSnMoPaGs (pSerNum:longint;pMovType:Str1;pPaCode:longint;pGsCode:longint):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function NearestSerNum (pSerNum:longint):boolean;
    function NearestSnMo (pSerNum:longint;pMovType:Str1):boolean;
    function NearestSnMoPa (pSerNum:longint;pMovType:Str1;pPaCode:longint):boolean;
    function NearestSnMoPaGs (pSerNum:longint;pMovType:Str1;pPaCode:longint;pGsCode:longint):boolean;
    function NearestGsCode (pGsCode:longint):boolean;

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
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property MovType:Str1 read ReadMovType write WriteMovType;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property MgCode:word read ReadMgCode write WriteMgCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property Volume:double read ReadVolume write WriteVolume;
    property PrcVol:double read ReadPrcVol write WritePrcVol;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property LaQnt:double read ReadLaQnt write WriteLaQnt;
    property SrCode:Str15 read ReadSrCode write WriteSrCode;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
  end;

implementation

constructor TSrmov_cBtr.Create;
begin
  oBtrTable := BtrInit ('SRMOV_C',gPath.LdgPath,Self);
end;

constructor TSrmov_cBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('SRMOV_C',pPath,Self);
end;

destructor TSrmov_cBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TSrmov_cBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TSrmov_cBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TSrmov_cBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TSrmov_cBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TSrmov_cBtr.ReadMovType:Str1;
begin
  Result := oBtrTable.FieldByName('MovType').AsString;
end;

procedure TSrmov_cBtr.WriteMovType(pValue:Str1);
begin
  oBtrTable.FieldByName('MovType').AsString := pValue;
end;

function TSrmov_cBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TSrmov_cBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TSrmov_cBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TSrmov_cBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TSrmov_cBtr.ReadMgCode:word;
begin
  Result := oBtrTable.FieldByName('MgCode').AsInteger;
end;

procedure TSrmov_cBtr.WriteMgCode(pValue:word);
begin
  oBtrTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TSrmov_cBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TSrmov_cBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TSrmov_cBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TSrmov_cBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TSrmov_cBtr.ReadVolume:double;
begin
  Result := oBtrTable.FieldByName('Volume').AsFloat;
end;

procedure TSrmov_cBtr.WriteVolume(pValue:double);
begin
  oBtrTable.FieldByName('Volume').AsFloat := pValue;
end;

function TSrmov_cBtr.ReadPrcVol:double;
begin
  Result := oBtrTable.FieldByName('PrcVol').AsFloat;
end;

procedure TSrmov_cBtr.WritePrcVol(pValue:double);
begin
  oBtrTable.FieldByName('PrcVol').AsFloat := pValue;
end;

function TSrmov_cBtr.ReadGsQnt:double;
begin
  Result := oBtrTable.FieldByName('GsQnt').AsFloat;
end;

procedure TSrmov_cBtr.WriteGsQnt(pValue:double);
begin
  oBtrTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TSrmov_cBtr.ReadLaQnt:double;
begin
  Result := oBtrTable.FieldByName('LaQnt').AsFloat;
end;

procedure TSrmov_cBtr.WriteLaQnt(pValue:double);
begin
  oBtrTable.FieldByName('LaQnt').AsFloat := pValue;
end;

function TSrmov_cBtr.ReadSrCode:Str15;
begin
  Result := oBtrTable.FieldByName('SrCode').AsString;
end;

procedure TSrmov_cBtr.WriteSrCode(pValue:Str15);
begin
  oBtrTable.FieldByName('SrCode').AsString := pValue;
end;

function TSrmov_cBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TSrmov_cBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TSrmov_cBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TSrmov_cBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TSrmov_cBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TSrmov_cBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSrmov_cBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSrmov_cBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TSrmov_cBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSrmov_cBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TSrmov_cBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TSrmov_cBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TSrmov_cBtr.LocateSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindKey([pSerNum]);
end;

function TSrmov_cBtr.LocateSnMo (pSerNum:longint;pMovType:Str1):boolean;
begin
  SetIndex (ixSnMo);
  Result := oBtrTable.FindKey([pSerNum,pMovType]);
end;

function TSrmov_cBtr.LocateSnMoPa (pSerNum:longint;pMovType:Str1;pPaCode:longint):boolean;
begin
  SetIndex (ixSnMoPa);
  Result := oBtrTable.FindKey([pSerNum,pMovType,pPaCode]);
end;

function TSrmov_cBtr.LocateSnMoPaGs (pSerNum:longint;pMovType:Str1;pPaCode:longint;pGsCode:longint):boolean;
begin
  SetIndex (ixSnMoPaGs);
  Result := oBtrTable.FindKey([pSerNum,pMovType,pPaCode,pGsCode]);
end;

function TSrmov_cBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TSrmov_cBtr.NearestSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindNearest([pSerNum]);
end;

function TSrmov_cBtr.NearestSnMo (pSerNum:longint;pMovType:Str1):boolean;
begin
  SetIndex (ixSnMo);
  Result := oBtrTable.FindNearest([pSerNum,pMovType]);
end;

function TSrmov_cBtr.NearestSnMoPa (pSerNum:longint;pMovType:Str1;pPaCode:longint):boolean;
begin
  SetIndex (ixSnMoPa);
  Result := oBtrTable.FindNearest([pSerNum,pMovType,pPaCode]);
end;

function TSrmov_cBtr.NearestSnMoPaGs (pSerNum:longint;pMovType:Str1;pPaCode:longint;pGsCode:longint):boolean;
begin
  SetIndex (ixSnMoPaGs);
  Result := oBtrTable.FindNearest([pSerNum,pMovType,pPaCode,pGsCode]);
end;

function TSrmov_cBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

procedure TSrmov_cBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TSrmov_cBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TSrmov_cBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TSrmov_cBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TSrmov_cBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TSrmov_cBtr.First;
begin
  oBtrTable.First;
end;

procedure TSrmov_cBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TSrmov_cBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TSrmov_cBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TSrmov_cBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TSrmov_cBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TSrmov_cBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TSrmov_cBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TSrmov_cBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TSrmov_cBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TSrmov_cBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TSrmov_cBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
