unit tSMRBOK;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDtBn = '';
  ixBokDes_ = 'BokDes_';

type
  TSmrbokTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocTyp:Str3;           procedure WriteDocTyp (pValue:Str3);
    function  ReadBokNum:Str5;           procedure WriteBokNum (pValue:Str5);
    function  ReadBokDes:Str30;          procedure WriteBokDes (pValue:Str30);
    function  ReadBokDes_:Str30;         procedure WriteBokDes_ (pValue:Str30);
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
    function LocateDtBn (pDocTyp:Str3;pBokNum:Str5):boolean;
    function LocateBokDes_ (pBokDes_:Str30):boolean;

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
    property DocTyp:Str3 read ReadDocTyp write WriteDocTyp;
    property BokNum:Str5 read ReadBokNum write WriteBokNum;
    property BokDes:Str30 read ReadBokDes write WriteBokDes;
    property BokDes_:Str30 read ReadBokDes_ write WriteBokDes_;
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

constructor TSmrbokTmp.Create;
begin
  oTmpTable := TmpInit ('SMRBOK',Self);
end;

destructor TSmrbokTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TSmrbokTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TSmrbokTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TSmrbokTmp.ReadDocTyp:Str3;
begin
  Result := oTmpTable.FieldByName('DocTyp').AsString;
end;

procedure TSmrbokTmp.WriteDocTyp(pValue:Str3);
begin
  oTmpTable.FieldByName('DocTyp').AsString := pValue;
end;

function TSmrbokTmp.ReadBokNum:Str5;
begin
  Result := oTmpTable.FieldByName('BokNum').AsString;
end;

procedure TSmrbokTmp.WriteBokNum(pValue:Str5);
begin
  oTmpTable.FieldByName('BokNum').AsString := pValue;
end;

function TSmrbokTmp.ReadBokDes:Str30;
begin
  Result := oTmpTable.FieldByName('BokDes').AsString;
end;

procedure TSmrbokTmp.WriteBokDes(pValue:Str30);
begin
  oTmpTable.FieldByName('BokDes').AsString := pValue;
end;

function TSmrbokTmp.ReadBokDes_:Str30;
begin
  Result := oTmpTable.FieldByName('BokDes_').AsString;
end;

procedure TSmrbokTmp.WriteBokDes_(pValue:Str30);
begin
  oTmpTable.FieldByName('BokDes_').AsString := pValue;
end;

function TSmrbokTmp.ReadBegNrv:double;
begin
  Result := oTmpTable.FieldByName('BegNrv').AsFloat;
end;

procedure TSmrbokTmp.WriteBegNrv(pValue:double);
begin
  oTmpTable.FieldByName('BegNrv').AsFloat := pValue;
end;

function TSmrbokTmp.ReadTrnNrv:double;
begin
  Result := oTmpTable.FieldByName('TrnNrv').AsFloat;
end;

procedure TSmrbokTmp.WriteTrnNrv(pValue:double);
begin
  oTmpTable.FieldByName('TrnNrv').AsFloat := pValue;
end;

function TSmrbokTmp.ReadEndNrv:double;
begin
  Result := oTmpTable.FieldByName('EndNrv').AsFloat;
end;

procedure TSmrbokTmp.WriteEndNrv(pValue:double);
begin
  oTmpTable.FieldByName('EndNrv').AsFloat := pValue;
end;

function TSmrbokTmp.ReadBegAcv:double;
begin
  Result := oTmpTable.FieldByName('BegAcv').AsFloat;
end;

procedure TSmrbokTmp.WriteBegAcv(pValue:double);
begin
  oTmpTable.FieldByName('BegAcv').AsFloat := pValue;
end;

function TSmrbokTmp.ReadTrnAcv:double;
begin
  Result := oTmpTable.FieldByName('TrnAcv').AsFloat;
end;

procedure TSmrbokTmp.WriteTrnAcv(pValue:double);
begin
  oTmpTable.FieldByName('TrnAcv').AsFloat := pValue;
end;

function TSmrbokTmp.ReadEndAcv:double;
begin
  Result := oTmpTable.FieldByName('EndAcv').AsFloat;
end;

procedure TSmrbokTmp.WriteEndAcv(pValue:double);
begin
  oTmpTable.FieldByName('EndAcv').AsFloat := pValue;
end;

function TSmrbokTmp.ReadBegSuv:double;
begin
  Result := oTmpTable.FieldByName('BegSuv').AsFloat;
end;

procedure TSmrbokTmp.WriteBegSuv(pValue:double);
begin
  oTmpTable.FieldByName('BegSuv').AsFloat := pValue;
end;

function TSmrbokTmp.ReadTrnSuv:double;
begin
  Result := oTmpTable.FieldByName('TrnSuv').AsFloat;
end;

procedure TSmrbokTmp.WriteTrnSuv(pValue:double);
begin
  oTmpTable.FieldByName('TrnSuv').AsFloat := pValue;
end;

function TSmrbokTmp.ReadEndSuv:double;
begin
  Result := oTmpTable.FieldByName('EndSuv').AsFloat;
end;

procedure TSmrbokTmp.WriteEndSuv(pValue:double);
begin
  oTmpTable.FieldByName('EndSuv').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSmrbokTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TSmrbokTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TSmrbokTmp.LocateDtBn (pDocTyp:Str3;pBokNum:Str5):boolean;
begin
  SetIndex (ixDtBn);
  Result := oTmpTable.FindKey([pDocTyp,pBokNum]);
end;

function TSmrbokTmp.LocateBokDes_ (pBokDes_:Str30):boolean;
begin
  SetIndex (ixBokDes_);
  Result := oTmpTable.FindKey([pBokDes_]);
end;

procedure TSmrbokTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TSmrbokTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TSmrbokTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TSmrbokTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TSmrbokTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TSmrbokTmp.First;
begin
  oTmpTable.First;
end;

procedure TSmrbokTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TSmrbokTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TSmrbokTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TSmrbokTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TSmrbokTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TSmrbokTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TSmrbokTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TSmrbokTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TSmrbokTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TSmrbokTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TSmrbokTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1907001}
