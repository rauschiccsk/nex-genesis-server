unit tSMRSTM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSnDoGs = '';
  ixGsCode = 'GsCode';
  ixGsName_ = 'GsName_';
  ixDocDate = 'DocDate';
  ixSmCode = 'SmCode';

type
  TSmrstmTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadSmCode:word;           procedure WriteSmCode (pValue:word);
    function  ReadBegNrv:double;         procedure WriteBegNrv (pValue:double);
    function  ReadTrnNrv:double;         procedure WriteTrnNrv (pValue:double);
    function  ReadEndNrv:double;         procedure WriteEndNrv (pValue:double);
    function  ReadBegAcv:double;         procedure WriteBegAcv (pValue:double);
    function  ReadTrnAcv:double;         procedure WriteTrnAcv (pValue:double);
    function  ReadEndAcv:double;         procedure WriteEndAcv (pValue:double);
    function  ReadBegSuv:double;         procedure WriteBegSuv (pValue:double);
    function  ReadTrnSuv:double;         procedure WriteTrnSuv (pValue:double);
    function  ReadEndSuv:double;         procedure WriteEndSuv (pValue:double);
    function  ReadBegNrq:double;         procedure WriteBegNrq (pValue:double);
    function  ReadTrnNrq:double;         procedure WriteTrnNrq (pValue:double);
    function  ReadEndNrq:double;         procedure WriteEndNrq (pValue:double);
    function  ReadBegAcq:double;         procedure WriteBegAcq (pValue:double);
    function  ReadTrnAcq:double;         procedure WriteTrnAcq (pValue:double);
    function  ReadEndAcq:double;         procedure WriteEndAcq (pValue:double);
    function  ReadBegSuq:double;         procedure WriteBegSuq (pValue:double);
    function  ReadTrnSuq:double;         procedure WriteTrnSuq (pValue:double);
    function  ReadEndSuq:double;         procedure WriteEndSuq (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateSnDoGs (pStkNum:word;pDocNum:Str12;pGsCode:longint):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName_ (pGsName_:Str30):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateSmCode (pSmCode:word):boolean;

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
    property StkNum:word read ReadStkNum write WriteStkNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property SmCode:word read ReadSmCode write WriteSmCode;
    property BegNrv:double read ReadBegNrv write WriteBegNrv;
    property TrnNrv:double read ReadTrnNrv write WriteTrnNrv;
    property EndNrv:double read ReadEndNrv write WriteEndNrv;
    property BegAcv:double read ReadBegAcv write WriteBegAcv;
    property TrnAcv:double read ReadTrnAcv write WriteTrnAcv;
    property EndAcv:double read ReadEndAcv write WriteEndAcv;
    property BegSuv:double read ReadBegSuv write WriteBegSuv;
    property TrnSuv:double read ReadTrnSuv write WriteTrnSuv;
    property EndSuv:double read ReadEndSuv write WriteEndSuv;
    property BegNrq:double read ReadBegNrq write WriteBegNrq;
    property TrnNrq:double read ReadTrnNrq write WriteTrnNrq;
    property EndNrq:double read ReadEndNrq write WriteEndNrq;
    property BegAcq:double read ReadBegAcq write WriteBegAcq;
    property TrnAcq:double read ReadTrnAcq write WriteTrnAcq;
    property EndAcq:double read ReadEndAcq write WriteEndAcq;
    property BegSuq:double read ReadBegSuq write WriteBegSuq;
    property TrnSuq:double read ReadTrnSuq write WriteTrnSuq;
    property EndSuq:double read ReadEndSuq write WriteEndSuq;
  end;

implementation

constructor TSmrstmTmp.Create;
begin
  oTmpTable := TmpInit ('SMRSTM',Self);
end;

destructor TSmrstmTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TSmrstmTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TSmrstmTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TSmrstmTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TSmrstmTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TSmrstmTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TSmrstmTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TSmrstmTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TSmrstmTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TSmrstmTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TSmrstmTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TSmrstmTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TSmrstmTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TSmrstmTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TSmrstmTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TSmrstmTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TSmrstmTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TSmrstmTmp.ReadSmCode:word;
begin
  Result := oTmpTable.FieldByName('SmCode').AsInteger;
end;

procedure TSmrstmTmp.WriteSmCode(pValue:word);
begin
  oTmpTable.FieldByName('SmCode').AsInteger := pValue;
end;

function TSmrstmTmp.ReadBegNrv:double;
begin
  Result := oTmpTable.FieldByName('BegNrv').AsFloat;
end;

procedure TSmrstmTmp.WriteBegNrv(pValue:double);
begin
  oTmpTable.FieldByName('BegNrv').AsFloat := pValue;
end;

function TSmrstmTmp.ReadTrnNrv:double;
begin
  Result := oTmpTable.FieldByName('TrnNrv').AsFloat;
end;

procedure TSmrstmTmp.WriteTrnNrv(pValue:double);
begin
  oTmpTable.FieldByName('TrnNrv').AsFloat := pValue;
end;

function TSmrstmTmp.ReadEndNrv:double;
begin
  Result := oTmpTable.FieldByName('EndNrv').AsFloat;
end;

procedure TSmrstmTmp.WriteEndNrv(pValue:double);
begin
  oTmpTable.FieldByName('EndNrv').AsFloat := pValue;
end;

function TSmrstmTmp.ReadBegAcv:double;
begin
  Result := oTmpTable.FieldByName('BegAcv').AsFloat;
end;

procedure TSmrstmTmp.WriteBegAcv(pValue:double);
begin
  oTmpTable.FieldByName('BegAcv').AsFloat := pValue;
end;

function TSmrstmTmp.ReadTrnAcv:double;
begin
  Result := oTmpTable.FieldByName('TrnAcv').AsFloat;
end;

procedure TSmrstmTmp.WriteTrnAcv(pValue:double);
begin
  oTmpTable.FieldByName('TrnAcv').AsFloat := pValue;
end;

function TSmrstmTmp.ReadEndAcv:double;
begin
  Result := oTmpTable.FieldByName('EndAcv').AsFloat;
end;

procedure TSmrstmTmp.WriteEndAcv(pValue:double);
begin
  oTmpTable.FieldByName('EndAcv').AsFloat := pValue;
end;

function TSmrstmTmp.ReadBegSuv:double;
begin
  Result := oTmpTable.FieldByName('BegSuv').AsFloat;
end;

procedure TSmrstmTmp.WriteBegSuv(pValue:double);
begin
  oTmpTable.FieldByName('BegSuv').AsFloat := pValue;
end;

function TSmrstmTmp.ReadTrnSuv:double;
begin
  Result := oTmpTable.FieldByName('TrnSuv').AsFloat;
end;

procedure TSmrstmTmp.WriteTrnSuv(pValue:double);
begin
  oTmpTable.FieldByName('TrnSuv').AsFloat := pValue;
end;

function TSmrstmTmp.ReadEndSuv:double;
begin
  Result := oTmpTable.FieldByName('EndSuv').AsFloat;
end;

procedure TSmrstmTmp.WriteEndSuv(pValue:double);
begin
  oTmpTable.FieldByName('EndSuv').AsFloat := pValue;
end;

function TSmrstmTmp.ReadBegNrq:double;
begin
  Result := oTmpTable.FieldByName('BegNrq').AsFloat;
end;

procedure TSmrstmTmp.WriteBegNrq(pValue:double);
begin
  oTmpTable.FieldByName('BegNrq').AsFloat := pValue;
end;

function TSmrstmTmp.ReadTrnNrq:double;
begin
  Result := oTmpTable.FieldByName('TrnNrq').AsFloat;
end;

procedure TSmrstmTmp.WriteTrnNrq(pValue:double);
begin
  oTmpTable.FieldByName('TrnNrq').AsFloat := pValue;
end;

function TSmrstmTmp.ReadEndNrq:double;
begin
  Result := oTmpTable.FieldByName('EndNrq').AsFloat;
end;

procedure TSmrstmTmp.WriteEndNrq(pValue:double);
begin
  oTmpTable.FieldByName('EndNrq').AsFloat := pValue;
end;

function TSmrstmTmp.ReadBegAcq:double;
begin
  Result := oTmpTable.FieldByName('BegAcq').AsFloat;
end;

procedure TSmrstmTmp.WriteBegAcq(pValue:double);
begin
  oTmpTable.FieldByName('BegAcq').AsFloat := pValue;
end;

function TSmrstmTmp.ReadTrnAcq:double;
begin
  Result := oTmpTable.FieldByName('TrnAcq').AsFloat;
end;

procedure TSmrstmTmp.WriteTrnAcq(pValue:double);
begin
  oTmpTable.FieldByName('TrnAcq').AsFloat := pValue;
end;

function TSmrstmTmp.ReadEndAcq:double;
begin
  Result := oTmpTable.FieldByName('EndAcq').AsFloat;
end;

procedure TSmrstmTmp.WriteEndAcq(pValue:double);
begin
  oTmpTable.FieldByName('EndAcq').AsFloat := pValue;
end;

function TSmrstmTmp.ReadBegSuq:double;
begin
  Result := oTmpTable.FieldByName('BegSuq').AsFloat;
end;

procedure TSmrstmTmp.WriteBegSuq(pValue:double);
begin
  oTmpTable.FieldByName('BegSuq').AsFloat := pValue;
end;

function TSmrstmTmp.ReadTrnSuq:double;
begin
  Result := oTmpTable.FieldByName('TrnSuq').AsFloat;
end;

procedure TSmrstmTmp.WriteTrnSuq(pValue:double);
begin
  oTmpTable.FieldByName('TrnSuq').AsFloat := pValue;
end;

function TSmrstmTmp.ReadEndSuq:double;
begin
  Result := oTmpTable.FieldByName('EndSuq').AsFloat;
end;

procedure TSmrstmTmp.WriteEndSuq(pValue:double);
begin
  oTmpTable.FieldByName('EndSuq').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSmrstmTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TSmrstmTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TSmrstmTmp.LocateSnDoGs (pStkNum:word;pDocNum:Str12;pGsCode:longint):boolean;
begin
  SetIndex (ixSnDoGs);
  Result := oTmpTable.FindKey([pStkNum,pDocNum,pGsCode]);
end;

function TSmrstmTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TSmrstmTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

function TSmrstmTmp.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oTmpTable.FindKey([pDocDate]);
end;

function TSmrstmTmp.LocateSmCode (pSmCode:word):boolean;
begin
  SetIndex (ixSmCode);
  Result := oTmpTable.FindKey([pSmCode]);
end;

procedure TSmrstmTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TSmrstmTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TSmrstmTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TSmrstmTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TSmrstmTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TSmrstmTmp.First;
begin
  oTmpTable.First;
end;

procedure TSmrstmTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TSmrstmTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TSmrstmTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TSmrstmTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TSmrstmTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TSmrstmTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TSmrstmTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TSmrstmTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TSmrstmTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TSmrstmTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TSmrstmTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1912001}
