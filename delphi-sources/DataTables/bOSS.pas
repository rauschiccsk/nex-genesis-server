unit bOSS;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsCode = 'GsCode';
  ixMgCode = 'MgCode';
  ixGsName = 'GsName';
  ixBarCode = 'BarCode';
  ixPaCode = 'PaCode';

type
  TOssBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str15;         procedure WriteGsName_ (pValue:Str15);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadOutQnt01:double;       procedure WriteOutQnt01 (pValue:double);
    function  ReadOutQnt02:double;       procedure WriteOutQnt02 (pValue:double);
    function  ReadOutQnt03:double;       procedure WriteOutQnt03 (pValue:double);
    function  ReadOutQnt04:double;       procedure WriteOutQnt04 (pValue:double);
    function  ReadOutQnt05:double;       procedure WriteOutQnt05 (pValue:double);
    function  ReadOutQnt06:double;       procedure WriteOutQnt06 (pValue:double);
    function  ReadOutQnt07:double;       procedure WriteOutQnt07 (pValue:double);
    function  ReadOutQnt08:double;       procedure WriteOutQnt08 (pValue:double);
    function  ReadOutQnt09:double;       procedure WriteOutQnt09 (pValue:double);
    function  ReadOutQnt10:double;       procedure WriteOutQnt10 (pValue:double);
    function  ReadOutQnt11:double;       procedure WriteOutQnt11 (pValue:double);
    function  ReadOutQnt12:double;       procedure WriteOutQnt12 (pValue:double);
    function  ReadOutQnt:double;         procedure WriteOutQnt (pValue:double);
    function  ReadInpQnt01:double;       procedure WriteInpQnt01 (pValue:double);
    function  ReadInpQnt02:double;       procedure WriteInpQnt02 (pValue:double);
    function  ReadInpQnt03:double;       procedure WriteInpQnt03 (pValue:double);
    function  ReadInpQnt04:double;       procedure WriteInpQnt04 (pValue:double);
    function  ReadInpQnt05:double;       procedure WriteInpQnt05 (pValue:double);
    function  ReadInpQnt06:double;       procedure WriteInpQnt06 (pValue:double);
    function  ReadInpQnt07:double;       procedure WriteInpQnt07 (pValue:double);
    function  ReadInpQnt08:double;       procedure WriteInpQnt08 (pValue:double);
    function  ReadInpQnt09:double;       procedure WriteInpQnt09 (pValue:double);
    function  ReadInpQnt10:double;       procedure WriteInpQnt10 (pValue:double);
    function  ReadInpQnt11:double;       procedure WriteInpQnt11 (pValue:double);
    function  ReadInpQnt12:double;       procedure WriteInpQnt12 (pValue:double);
    function  ReadInpQnt:double;         procedure WriteInpQnt (pValue:double);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateMgCode (pMgCode:longint):boolean;
    function LocateGsName (pGsName_:Str15):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestMgCode (pMgCode:longint):boolean;
    function NearestGsName (pGsName_:Str15):boolean;
    function NearestBarCode (pBarCode:Str15):boolean;
    function NearestPaCode (pPaCode:longint):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pBookNum:Str5);
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
    procedure EnableControls;
    procedure DisableControls;
  published
    property BtrTable:TNexBtrTable read oBtrTable;
    property Count:integer read ReadCount;
    // Pristup k databazovym poliam
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str15 read ReadGsName_ write WriteGsName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property OutQnt01:double read ReadOutQnt01 write WriteOutQnt01;
    property OutQnt02:double read ReadOutQnt02 write WriteOutQnt02;
    property OutQnt03:double read ReadOutQnt03 write WriteOutQnt03;
    property OutQnt04:double read ReadOutQnt04 write WriteOutQnt04;
    property OutQnt05:double read ReadOutQnt05 write WriteOutQnt05;
    property OutQnt06:double read ReadOutQnt06 write WriteOutQnt06;
    property OutQnt07:double read ReadOutQnt07 write WriteOutQnt07;
    property OutQnt08:double read ReadOutQnt08 write WriteOutQnt08;
    property OutQnt09:double read ReadOutQnt09 write WriteOutQnt09;
    property OutQnt10:double read ReadOutQnt10 write WriteOutQnt10;
    property OutQnt11:double read ReadOutQnt11 write WriteOutQnt11;
    property OutQnt12:double read ReadOutQnt12 write WriteOutQnt12;
    property OutQnt:double read ReadOutQnt write WriteOutQnt;
    property InpQnt01:double read ReadInpQnt01 write WriteInpQnt01;
    property InpQnt02:double read ReadInpQnt02 write WriteInpQnt02;
    property InpQnt03:double read ReadInpQnt03 write WriteInpQnt03;
    property InpQnt04:double read ReadInpQnt04 write WriteInpQnt04;
    property InpQnt05:double read ReadInpQnt05 write WriteInpQnt05;
    property InpQnt06:double read ReadInpQnt06 write WriteInpQnt06;
    property InpQnt07:double read ReadInpQnt07 write WriteInpQnt07;
    property InpQnt08:double read ReadInpQnt08 write WriteInpQnt08;
    property InpQnt09:double read ReadInpQnt09 write WriteInpQnt09;
    property InpQnt10:double read ReadInpQnt10 write WriteInpQnt10;
    property InpQnt11:double read ReadInpQnt11 write WriteInpQnt11;
    property InpQnt12:double read ReadInpQnt12 write WriteInpQnt12;
    property InpQnt:double read ReadInpQnt write WriteInpQnt;
  end;

implementation

constructor TOssBtr.Create;
begin
  oBtrTable := BtrInit ('OSS',gPath.StkPath,Self);
end;

constructor TOssBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('OSS',pPath,Self);
end;

destructor TOssBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TOssBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TOssBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TOssBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TOssBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TOssBtr.ReadMgCode:longint;
begin
  Result := oBtrTable.FieldByName('MgCode').AsInteger;
end;

procedure TOssBtr.WriteMgCode(pValue:longint);
begin
  oBtrTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TOssBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TOssBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TOssBtr.ReadGsName_:Str15;
begin
  Result := oBtrTable.FieldByName('GsName_').AsString;
end;

procedure TOssBtr.WriteGsName_(pValue:Str15);
begin
  oBtrTable.FieldByName('GsName_').AsString := pValue;
end;

function TOssBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TOssBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TOssBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TOssBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TOssBtr.ReadOutQnt01:double;
begin
  Result := oBtrTable.FieldByName('OutQnt01').AsFloat;
end;

procedure TOssBtr.WriteOutQnt01(pValue:double);
begin
  oBtrTable.FieldByName('OutQnt01').AsFloat := pValue;
end;

function TOssBtr.ReadOutQnt02:double;
begin
  Result := oBtrTable.FieldByName('OutQnt02').AsFloat;
end;

procedure TOssBtr.WriteOutQnt02(pValue:double);
begin
  oBtrTable.FieldByName('OutQnt02').AsFloat := pValue;
end;

function TOssBtr.ReadOutQnt03:double;
begin
  Result := oBtrTable.FieldByName('OutQnt03').AsFloat;
end;

procedure TOssBtr.WriteOutQnt03(pValue:double);
begin
  oBtrTable.FieldByName('OutQnt03').AsFloat := pValue;
end;

function TOssBtr.ReadOutQnt04:double;
begin
  Result := oBtrTable.FieldByName('OutQnt04').AsFloat;
end;

procedure TOssBtr.WriteOutQnt04(pValue:double);
begin
  oBtrTable.FieldByName('OutQnt04').AsFloat := pValue;
end;

function TOssBtr.ReadOutQnt05:double;
begin
  Result := oBtrTable.FieldByName('OutQnt05').AsFloat;
end;

procedure TOssBtr.WriteOutQnt05(pValue:double);
begin
  oBtrTable.FieldByName('OutQnt05').AsFloat := pValue;
end;

function TOssBtr.ReadOutQnt06:double;
begin
  Result := oBtrTable.FieldByName('OutQnt06').AsFloat;
end;

procedure TOssBtr.WriteOutQnt06(pValue:double);
begin
  oBtrTable.FieldByName('OutQnt06').AsFloat := pValue;
end;

function TOssBtr.ReadOutQnt07:double;
begin
  Result := oBtrTable.FieldByName('OutQnt07').AsFloat;
end;

procedure TOssBtr.WriteOutQnt07(pValue:double);
begin
  oBtrTable.FieldByName('OutQnt07').AsFloat := pValue;
end;

function TOssBtr.ReadOutQnt08:double;
begin
  Result := oBtrTable.FieldByName('OutQnt08').AsFloat;
end;

procedure TOssBtr.WriteOutQnt08(pValue:double);
begin
  oBtrTable.FieldByName('OutQnt08').AsFloat := pValue;
end;

function TOssBtr.ReadOutQnt09:double;
begin
  Result := oBtrTable.FieldByName('OutQnt09').AsFloat;
end;

procedure TOssBtr.WriteOutQnt09(pValue:double);
begin
  oBtrTable.FieldByName('OutQnt09').AsFloat := pValue;
end;

function TOssBtr.ReadOutQnt10:double;
begin
  Result := oBtrTable.FieldByName('OutQnt10').AsFloat;
end;

procedure TOssBtr.WriteOutQnt10(pValue:double);
begin
  oBtrTable.FieldByName('OutQnt10').AsFloat := pValue;
end;

function TOssBtr.ReadOutQnt11:double;
begin
  Result := oBtrTable.FieldByName('OutQnt11').AsFloat;
end;

procedure TOssBtr.WriteOutQnt11(pValue:double);
begin
  oBtrTable.FieldByName('OutQnt11').AsFloat := pValue;
end;

function TOssBtr.ReadOutQnt12:double;
begin
  Result := oBtrTable.FieldByName('OutQnt12').AsFloat;
end;

procedure TOssBtr.WriteOutQnt12(pValue:double);
begin
  oBtrTable.FieldByName('OutQnt12').AsFloat := pValue;
end;

function TOssBtr.ReadOutQnt:double;
begin
  Result := oBtrTable.FieldByName('OutQnt').AsFloat;
end;

procedure TOssBtr.WriteOutQnt(pValue:double);
begin
  oBtrTable.FieldByName('OutQnt').AsFloat := pValue;
end;

function TOssBtr.ReadInpQnt01:double;
begin
  Result := oBtrTable.FieldByName('InpQnt01').AsFloat;
end;

procedure TOssBtr.WriteInpQnt01(pValue:double);
begin
  oBtrTable.FieldByName('InpQnt01').AsFloat := pValue;
end;

function TOssBtr.ReadInpQnt02:double;
begin
  Result := oBtrTable.FieldByName('InpQnt02').AsFloat;
end;

procedure TOssBtr.WriteInpQnt02(pValue:double);
begin
  oBtrTable.FieldByName('InpQnt02').AsFloat := pValue;
end;

function TOssBtr.ReadInpQnt03:double;
begin
  Result := oBtrTable.FieldByName('InpQnt03').AsFloat;
end;

procedure TOssBtr.WriteInpQnt03(pValue:double);
begin
  oBtrTable.FieldByName('InpQnt03').AsFloat := pValue;
end;

function TOssBtr.ReadInpQnt04:double;
begin
  Result := oBtrTable.FieldByName('InpQnt04').AsFloat;
end;

procedure TOssBtr.WriteInpQnt04(pValue:double);
begin
  oBtrTable.FieldByName('InpQnt04').AsFloat := pValue;
end;

function TOssBtr.ReadInpQnt05:double;
begin
  Result := oBtrTable.FieldByName('InpQnt05').AsFloat;
end;

procedure TOssBtr.WriteInpQnt05(pValue:double);
begin
  oBtrTable.FieldByName('InpQnt05').AsFloat := pValue;
end;

function TOssBtr.ReadInpQnt06:double;
begin
  Result := oBtrTable.FieldByName('InpQnt06').AsFloat;
end;

procedure TOssBtr.WriteInpQnt06(pValue:double);
begin
  oBtrTable.FieldByName('InpQnt06').AsFloat := pValue;
end;

function TOssBtr.ReadInpQnt07:double;
begin
  Result := oBtrTable.FieldByName('InpQnt07').AsFloat;
end;

procedure TOssBtr.WriteInpQnt07(pValue:double);
begin
  oBtrTable.FieldByName('InpQnt07').AsFloat := pValue;
end;

function TOssBtr.ReadInpQnt08:double;
begin
  Result := oBtrTable.FieldByName('InpQnt08').AsFloat;
end;

procedure TOssBtr.WriteInpQnt08(pValue:double);
begin
  oBtrTable.FieldByName('InpQnt08').AsFloat := pValue;
end;

function TOssBtr.ReadInpQnt09:double;
begin
  Result := oBtrTable.FieldByName('InpQnt09').AsFloat;
end;

procedure TOssBtr.WriteInpQnt09(pValue:double);
begin
  oBtrTable.FieldByName('InpQnt09').AsFloat := pValue;
end;

function TOssBtr.ReadInpQnt10:double;
begin
  Result := oBtrTable.FieldByName('InpQnt10').AsFloat;
end;

procedure TOssBtr.WriteInpQnt10(pValue:double);
begin
  oBtrTable.FieldByName('InpQnt10').AsFloat := pValue;
end;

function TOssBtr.ReadInpQnt11:double;
begin
  Result := oBtrTable.FieldByName('InpQnt11').AsFloat;
end;

procedure TOssBtr.WriteInpQnt11(pValue:double);
begin
  oBtrTable.FieldByName('InpQnt11').AsFloat := pValue;
end;

function TOssBtr.ReadInpQnt12:double;
begin
  Result := oBtrTable.FieldByName('InpQnt12').AsFloat;
end;

procedure TOssBtr.WriteInpQnt12(pValue:double);
begin
  oBtrTable.FieldByName('InpQnt12').AsFloat := pValue;
end;

function TOssBtr.ReadInpQnt:double;
begin
  Result := oBtrTable.FieldByName('InpQnt').AsFloat;
end;

procedure TOssBtr.WriteInpQnt(pValue:double);
begin
  oBtrTable.FieldByName('InpQnt').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TOssBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TOssBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TOssBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TOssBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TOssBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TOssBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TOssBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TOssBtr.LocateMgCode (pMgCode:longint):boolean;
begin
  SetIndex (ixMgCode);
  Result := oBtrTable.FindKey([pMgCode]);
end;

function TOssBtr.LocateGsName (pGsName_:Str15):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindKey([StrToAlias(pGsName_)]);
end;

function TOssBtr.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindKey([pBarCode]);
end;

function TOssBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TOssBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TOssBtr.NearestMgCode (pMgCode:longint):boolean;
begin
  SetIndex (ixMgCode);
  Result := oBtrTable.FindNearest([pMgCode]);
end;

function TOssBtr.NearestGsName (pGsName_:Str15):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindNearest([pGsName_]);
end;

function TOssBtr.NearestBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindNearest([pBarCode]);
end;

function TOssBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

procedure TOssBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TOssBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TOssBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TOssBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TOssBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TOssBtr.First;
begin
  oBtrTable.First;
end;

procedure TOssBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TOssBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TOssBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TOssBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TOssBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TOssBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TOssBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TOssBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TOssBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TOssBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TOssBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
