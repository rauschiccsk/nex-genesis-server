unit tSMRSTK;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixStkNum = '';
  ixStkDes_ = 'StkDes_';

type
  TSmrstkTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadStkDes:Str30;          procedure WriteStkDes (pValue:Str30);
    function  ReadStkDes_:Str30;         procedure WriteStkDes_ (pValue:Str30);
    function  ReadBegNrv:double;         procedure WriteBegNrv (pValue:double);
    function  ReadTrnNrv:double;         procedure WriteTrnNrv (pValue:double);
    function  ReadEndNrv:double;         procedure WriteEndNrv (pValue:double);
    function  ReadBegAcv:double;         procedure WriteBegAcv (pValue:double);
    function  ReadTrnAcv:double;         procedure WriteTrnAcv (pValue:double);
    function  ReadEndAcv:double;         procedure WriteEndAcv (pValue:double);
    function  ReadBegSuv:double;         procedure WriteBegSuv (pValue:double);
    function  ReadTrnSuv:double;         procedure WriteTrnSuv (pValue:double);
    function  ReadEndSuv:double;         procedure WriteEndSuv (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateStkNum (pStkNum:word):boolean;
    function LocateStkDes_ (pStkDes_:Str30):boolean;

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
    property StkDes:Str30 read ReadStkDes write WriteStkDes;
    property StkDes_:Str30 read ReadStkDes_ write WriteStkDes_;
    property BegNrv:double read ReadBegNrv write WriteBegNrv;
    property TrnNrv:double read ReadTrnNrv write WriteTrnNrv;
    property EndNrv:double read ReadEndNrv write WriteEndNrv;
    property BegAcv:double read ReadBegAcv write WriteBegAcv;
    property TrnAcv:double read ReadTrnAcv write WriteTrnAcv;
    property EndAcv:double read ReadEndAcv write WriteEndAcv;
    property BegSuv:double read ReadBegSuv write WriteBegSuv;
    property TrnSuv:double read ReadTrnSuv write WriteTrnSuv;
    property EndSuv:double read ReadEndSuv write WriteEndSuv;
  end;

implementation

constructor TSmrstkTmp.Create;
begin
  oTmpTable := TmpInit ('SMRSTK',Self);
end;

destructor TSmrstkTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TSmrstkTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TSmrstkTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TSmrstkTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TSmrstkTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TSmrstkTmp.ReadStkDes:Str30;
begin
  Result := oTmpTable.FieldByName('StkDes').AsString;
end;

procedure TSmrstkTmp.WriteStkDes(pValue:Str30);
begin
  oTmpTable.FieldByName('StkDes').AsString := pValue;
end;

function TSmrstkTmp.ReadStkDes_:Str30;
begin
  Result := oTmpTable.FieldByName('StkDes_').AsString;
end;

procedure TSmrstkTmp.WriteStkDes_(pValue:Str30);
begin
  oTmpTable.FieldByName('StkDes_').AsString := pValue;
end;

function TSmrstkTmp.ReadBegNrv:double;
begin
  Result := oTmpTable.FieldByName('BegNrv').AsFloat;
end;

procedure TSmrstkTmp.WriteBegNrv(pValue:double);
begin
  oTmpTable.FieldByName('BegNrv').AsFloat := pValue;
end;

function TSmrstkTmp.ReadTrnNrv:double;
begin
  Result := oTmpTable.FieldByName('TrnNrv').AsFloat;
end;

procedure TSmrstkTmp.WriteTrnNrv(pValue:double);
begin
  oTmpTable.FieldByName('TrnNrv').AsFloat := pValue;
end;

function TSmrstkTmp.ReadEndNrv:double;
begin
  Result := oTmpTable.FieldByName('EndNrv').AsFloat;
end;

procedure TSmrstkTmp.WriteEndNrv(pValue:double);
begin
  oTmpTable.FieldByName('EndNrv').AsFloat := pValue;
end;

function TSmrstkTmp.ReadBegAcv:double;
begin
  Result := oTmpTable.FieldByName('BegAcv').AsFloat;
end;

procedure TSmrstkTmp.WriteBegAcv(pValue:double);
begin
  oTmpTable.FieldByName('BegAcv').AsFloat := pValue;
end;

function TSmrstkTmp.ReadTrnAcv:double;
begin
  Result := oTmpTable.FieldByName('TrnAcv').AsFloat;
end;

procedure TSmrstkTmp.WriteTrnAcv(pValue:double);
begin
  oTmpTable.FieldByName('TrnAcv').AsFloat := pValue;
end;

function TSmrstkTmp.ReadEndAcv:double;
begin
  Result := oTmpTable.FieldByName('EndAcv').AsFloat;
end;

procedure TSmrstkTmp.WriteEndAcv(pValue:double);
begin
  oTmpTable.FieldByName('EndAcv').AsFloat := pValue;
end;

function TSmrstkTmp.ReadBegSuv:double;
begin
  Result := oTmpTable.FieldByName('BegSuv').AsFloat;
end;

procedure TSmrstkTmp.WriteBegSuv(pValue:double);
begin
  oTmpTable.FieldByName('BegSuv').AsFloat := pValue;
end;

function TSmrstkTmp.ReadTrnSuv:double;
begin
  Result := oTmpTable.FieldByName('TrnSuv').AsFloat;
end;

procedure TSmrstkTmp.WriteTrnSuv(pValue:double);
begin
  oTmpTable.FieldByName('TrnSuv').AsFloat := pValue;
end;

function TSmrstkTmp.ReadEndSuv:double;
begin
  Result := oTmpTable.FieldByName('EndSuv').AsFloat;
end;

procedure TSmrstkTmp.WriteEndSuv(pValue:double);
begin
  oTmpTable.FieldByName('EndSuv').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSmrstkTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TSmrstkTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TSmrstkTmp.LocateStkNum (pStkNum:word):boolean;
begin
  SetIndex (ixStkNum);
  Result := oTmpTable.FindKey([pStkNum]);
end;

function TSmrstkTmp.LocateStkDes_ (pStkDes_:Str30):boolean;
begin
  SetIndex (ixStkDes_);
  Result := oTmpTable.FindKey([pStkDes_]);
end;

procedure TSmrstkTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TSmrstkTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TSmrstkTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TSmrstkTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TSmrstkTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TSmrstkTmp.First;
begin
  oTmpTable.First;
end;

procedure TSmrstkTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TSmrstkTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TSmrstkTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TSmrstkTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TSmrstkTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TSmrstkTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TSmrstkTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TSmrstkTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TSmrstkTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TSmrstkTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TSmrstkTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1905014}
