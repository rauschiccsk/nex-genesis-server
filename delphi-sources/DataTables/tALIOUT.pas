unit tALIOUT;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = '';
  ixDocNum = 'DocNum';
  ixGsCode = 'GsCode';
  ixGsName_ = 'GsName_';
  ixBarCode = 'BarCode';
  ixPaName_ = 'PaName_';

type
  TAlioutTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadPaName_:Str30;         procedure WritePaName_ (pValue:Str30);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadRetDate:TDatetime;     procedure WriteRetDate (pValue:TDatetime);
    function  ReadDayQnt:word;           procedure WriteDayQnt (pValue:word);
    function  ReadNotice:Str30;          procedure WriteNotice (pValue:Str30);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName_ (pGsName_:Str30):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocatePaName_ (pPaName_:Str30):boolean;

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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property PaName_:Str30 read ReadPaName_ write WritePaName_;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property RetDate:TDatetime read ReadRetDate write WriteRetDate;
    property DayQnt:word read ReadDayQnt write WriteDayQnt;
    property Notice:Str30 read ReadNotice write WriteNotice;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TAlioutTmp.Create;
begin
  oTmpTable := TmpInit ('ALIOUT',Self);
end;

destructor TAlioutTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TAlioutTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TAlioutTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TAlioutTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TAlioutTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TAlioutTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TAlioutTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TAlioutTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TAlioutTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TAlioutTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TAlioutTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TAlioutTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TAlioutTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TAlioutTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TAlioutTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TAlioutTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TAlioutTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TAlioutTmp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TAlioutTmp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TAlioutTmp.ReadPaName_:Str30;
begin
  Result := oTmpTable.FieldByName('PaName_').AsString;
end;

procedure TAlioutTmp.WritePaName_(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName_').AsString := pValue;
end;

function TAlioutTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TAlioutTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TAlioutTmp.ReadRetDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('RetDate').AsDateTime;
end;

procedure TAlioutTmp.WriteRetDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RetDate').AsDateTime := pValue;
end;

function TAlioutTmp.ReadDayQnt:word;
begin
  Result := oTmpTable.FieldByName('DayQnt').AsInteger;
end;

procedure TAlioutTmp.WriteDayQnt(pValue:word);
begin
  oTmpTable.FieldByName('DayQnt').AsInteger := pValue;
end;

function TAlioutTmp.ReadNotice:Str30;
begin
  Result := oTmpTable.FieldByName('Notice').AsString;
end;

procedure TAlioutTmp.WriteNotice(pValue:Str30);
begin
  oTmpTable.FieldByName('Notice').AsString := pValue;
end;

function TAlioutTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TAlioutTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAlioutTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TAlioutTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TAlioutTmp.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TAlioutTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TAlioutTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TAlioutTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

function TAlioutTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

function TAlioutTmp.LocatePaName_ (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName_);
  Result := oTmpTable.FindKey([pPaName_]);
end;

procedure TAlioutTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TAlioutTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TAlioutTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TAlioutTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TAlioutTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TAlioutTmp.First;
begin
  oTmpTable.First;
end;

procedure TAlioutTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TAlioutTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TAlioutTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TAlioutTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TAlioutTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TAlioutTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TAlioutTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TAlioutTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TAlioutTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TAlioutTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TAlioutTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
