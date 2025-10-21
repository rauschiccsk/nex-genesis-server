unit tSMRITM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSnGs = '';
  ixGsCode = 'GsCode';
  ixGsName_ = 'GsName_';

type
  TSmritmTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
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
    function LocateSnGs (pStkNum:word;pGsCode:longint):boolean;
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
    property StkNum:word read ReadStkNum write WriteStkNum;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
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

constructor TSmritmTmp.Create;
begin
  oTmpTable := TmpInit ('SMRITM',Self);
end;

destructor TSmritmTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TSmritmTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TSmritmTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TSmritmTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TSmritmTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TSmritmTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TSmritmTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TSmritmTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TSmritmTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TSmritmTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TSmritmTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TSmritmTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TSmritmTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TSmritmTmp.ReadBegNrv:double;
begin
  Result := oTmpTable.FieldByName('BegNrv').AsFloat;
end;

procedure TSmritmTmp.WriteBegNrv(pValue:double);
begin
  oTmpTable.FieldByName('BegNrv').AsFloat := pValue;
end;

function TSmritmTmp.ReadTrnNrv:double;
begin
  Result := oTmpTable.FieldByName('TrnNrv').AsFloat;
end;

procedure TSmritmTmp.WriteTrnNrv(pValue:double);
begin
  oTmpTable.FieldByName('TrnNrv').AsFloat := pValue;
end;

function TSmritmTmp.ReadEndNrv:double;
begin
  Result := oTmpTable.FieldByName('EndNrv').AsFloat;
end;

procedure TSmritmTmp.WriteEndNrv(pValue:double);
begin
  oTmpTable.FieldByName('EndNrv').AsFloat := pValue;
end;

function TSmritmTmp.ReadBegAcv:double;
begin
  Result := oTmpTable.FieldByName('BegAcv').AsFloat;
end;

procedure TSmritmTmp.WriteBegAcv(pValue:double);
begin
  oTmpTable.FieldByName('BegAcv').AsFloat := pValue;
end;

function TSmritmTmp.ReadTrnAcv:double;
begin
  Result := oTmpTable.FieldByName('TrnAcv').AsFloat;
end;

procedure TSmritmTmp.WriteTrnAcv(pValue:double);
begin
  oTmpTable.FieldByName('TrnAcv').AsFloat := pValue;
end;

function TSmritmTmp.ReadEndAcv:double;
begin
  Result := oTmpTable.FieldByName('EndAcv').AsFloat;
end;

procedure TSmritmTmp.WriteEndAcv(pValue:double);
begin
  oTmpTable.FieldByName('EndAcv').AsFloat := pValue;
end;

function TSmritmTmp.ReadBegSuv:double;
begin
  Result := oTmpTable.FieldByName('BegSuv').AsFloat;
end;

procedure TSmritmTmp.WriteBegSuv(pValue:double);
begin
  oTmpTable.FieldByName('BegSuv').AsFloat := pValue;
end;

function TSmritmTmp.ReadTrnSuv:double;
begin
  Result := oTmpTable.FieldByName('TrnSuv').AsFloat;
end;

procedure TSmritmTmp.WriteTrnSuv(pValue:double);
begin
  oTmpTable.FieldByName('TrnSuv').AsFloat := pValue;
end;

function TSmritmTmp.ReadEndSuv:double;
begin
  Result := oTmpTable.FieldByName('EndSuv').AsFloat;
end;

procedure TSmritmTmp.WriteEndSuv(pValue:double);
begin
  oTmpTable.FieldByName('EndSuv').AsFloat := pValue;
end;

function TSmritmTmp.ReadBegNrq:double;
begin
  Result := oTmpTable.FieldByName('BegNrq').AsFloat;
end;

procedure TSmritmTmp.WriteBegNrq(pValue:double);
begin
  oTmpTable.FieldByName('BegNrq').AsFloat := pValue;
end;

function TSmritmTmp.ReadTrnNrq:double;
begin
  Result := oTmpTable.FieldByName('TrnNrq').AsFloat;
end;

procedure TSmritmTmp.WriteTrnNrq(pValue:double);
begin
  oTmpTable.FieldByName('TrnNrq').AsFloat := pValue;
end;

function TSmritmTmp.ReadEndNrq:double;
begin
  Result := oTmpTable.FieldByName('EndNrq').AsFloat;
end;

procedure TSmritmTmp.WriteEndNrq(pValue:double);
begin
  oTmpTable.FieldByName('EndNrq').AsFloat := pValue;
end;

function TSmritmTmp.ReadBegAcq:double;
begin
  Result := oTmpTable.FieldByName('BegAcq').AsFloat;
end;

procedure TSmritmTmp.WriteBegAcq(pValue:double);
begin
  oTmpTable.FieldByName('BegAcq').AsFloat := pValue;
end;

function TSmritmTmp.ReadTrnAcq:double;
begin
  Result := oTmpTable.FieldByName('TrnAcq').AsFloat;
end;

procedure TSmritmTmp.WriteTrnAcq(pValue:double);
begin
  oTmpTable.FieldByName('TrnAcq').AsFloat := pValue;
end;

function TSmritmTmp.ReadEndAcq:double;
begin
  Result := oTmpTable.FieldByName('EndAcq').AsFloat;
end;

procedure TSmritmTmp.WriteEndAcq(pValue:double);
begin
  oTmpTable.FieldByName('EndAcq').AsFloat := pValue;
end;

function TSmritmTmp.ReadBegSuq:double;
begin
  Result := oTmpTable.FieldByName('BegSuq').AsFloat;
end;

procedure TSmritmTmp.WriteBegSuq(pValue:double);
begin
  oTmpTable.FieldByName('BegSuq').AsFloat := pValue;
end;

function TSmritmTmp.ReadTrnSuq:double;
begin
  Result := oTmpTable.FieldByName('TrnSuq').AsFloat;
end;

procedure TSmritmTmp.WriteTrnSuq(pValue:double);
begin
  oTmpTable.FieldByName('TrnSuq').AsFloat := pValue;
end;

function TSmritmTmp.ReadEndSuq:double;
begin
  Result := oTmpTable.FieldByName('EndSuq').AsFloat;
end;

procedure TSmritmTmp.WriteEndSuq(pValue:double);
begin
  oTmpTable.FieldByName('EndSuq').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSmritmTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TSmritmTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TSmritmTmp.LocateSnGs (pStkNum:word;pGsCode:longint):boolean;
begin
  SetIndex (ixSnGs);
  Result := oTmpTable.FindKey([pStkNum,pGsCode]);
end;

function TSmritmTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TSmritmTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

procedure TSmritmTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TSmritmTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TSmritmTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TSmritmTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TSmritmTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TSmritmTmp.First;
begin
  oTmpTable.First;
end;

procedure TSmritmTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TSmritmTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TSmritmTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TSmritmTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TSmritmTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TSmritmTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TSmritmTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TSmritmTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TSmritmTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TSmritmTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TSmritmTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1912001}
