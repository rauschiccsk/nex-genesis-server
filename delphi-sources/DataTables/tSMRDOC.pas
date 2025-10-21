unit tSMRDOC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixBoDo = '';
  ixDocNum = 'DocNum';
  ixDocDes_ = 'DocDes_';

type
  TSmrdocTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadBokNum:Str5;           procedure WriteBokNum (pValue:Str5);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadDocDes:Str30;          procedure WriteDocDes (pValue:Str30);
    function  ReadDocDes_:Str30;         procedure WriteDocDes_ (pValue:Str30);
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
    function LocateBoDo (pBokNum:Str5;pDocNum:Str12):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDocDes_ (pDocDes_:Str30):boolean;

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
    property BokNum:Str5 read ReadBokNum write WriteBokNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property DocDes:Str30 read ReadDocDes write WriteDocDes;
    property DocDes_:Str30 read ReadDocDes_ write WriteDocDes_;
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

constructor TSmrdocTmp.Create;
begin
  oTmpTable := TmpInit ('SMRDOC',Self);
end;

destructor TSmrdocTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TSmrdocTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TSmrdocTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TSmrdocTmp.ReadBokNum:Str5;
begin
  Result := oTmpTable.FieldByName('BokNum').AsString;
end;

procedure TSmrdocTmp.WriteBokNum(pValue:Str5);
begin
  oTmpTable.FieldByName('BokNum').AsString := pValue;
end;

function TSmrdocTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TSmrdocTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TSmrdocTmp.ReadDocDes:Str30;
begin
  Result := oTmpTable.FieldByName('DocDes').AsString;
end;

procedure TSmrdocTmp.WriteDocDes(pValue:Str30);
begin
  oTmpTable.FieldByName('DocDes').AsString := pValue;
end;

function TSmrdocTmp.ReadDocDes_:Str30;
begin
  Result := oTmpTable.FieldByName('DocDes_').AsString;
end;

procedure TSmrdocTmp.WriteDocDes_(pValue:Str30);
begin
  oTmpTable.FieldByName('DocDes_').AsString := pValue;
end;

function TSmrdocTmp.ReadBegNrv:double;
begin
  Result := oTmpTable.FieldByName('BegNrv').AsFloat;
end;

procedure TSmrdocTmp.WriteBegNrv(pValue:double);
begin
  oTmpTable.FieldByName('BegNrv').AsFloat := pValue;
end;

function TSmrdocTmp.ReadTrnNrv:double;
begin
  Result := oTmpTable.FieldByName('TrnNrv').AsFloat;
end;

procedure TSmrdocTmp.WriteTrnNrv(pValue:double);
begin
  oTmpTable.FieldByName('TrnNrv').AsFloat := pValue;
end;

function TSmrdocTmp.ReadEndNrv:double;
begin
  Result := oTmpTable.FieldByName('EndNrv').AsFloat;
end;

procedure TSmrdocTmp.WriteEndNrv(pValue:double);
begin
  oTmpTable.FieldByName('EndNrv').AsFloat := pValue;
end;

function TSmrdocTmp.ReadBegAcv:double;
begin
  Result := oTmpTable.FieldByName('BegAcv').AsFloat;
end;

procedure TSmrdocTmp.WriteBegAcv(pValue:double);
begin
  oTmpTable.FieldByName('BegAcv').AsFloat := pValue;
end;

function TSmrdocTmp.ReadTrnAcv:double;
begin
  Result := oTmpTable.FieldByName('TrnAcv').AsFloat;
end;

procedure TSmrdocTmp.WriteTrnAcv(pValue:double);
begin
  oTmpTable.FieldByName('TrnAcv').AsFloat := pValue;
end;

function TSmrdocTmp.ReadEndAcv:double;
begin
  Result := oTmpTable.FieldByName('EndAcv').AsFloat;
end;

procedure TSmrdocTmp.WriteEndAcv(pValue:double);
begin
  oTmpTable.FieldByName('EndAcv').AsFloat := pValue;
end;

function TSmrdocTmp.ReadBegSuv:double;
begin
  Result := oTmpTable.FieldByName('BegSuv').AsFloat;
end;

procedure TSmrdocTmp.WriteBegSuv(pValue:double);
begin
  oTmpTable.FieldByName('BegSuv').AsFloat := pValue;
end;

function TSmrdocTmp.ReadTrnSuv:double;
begin
  Result := oTmpTable.FieldByName('TrnSuv').AsFloat;
end;

procedure TSmrdocTmp.WriteTrnSuv(pValue:double);
begin
  oTmpTable.FieldByName('TrnSuv').AsFloat := pValue;
end;

function TSmrdocTmp.ReadEndSuv:double;
begin
  Result := oTmpTable.FieldByName('EndSuv').AsFloat;
end;

procedure TSmrdocTmp.WriteEndSuv(pValue:double);
begin
  oTmpTable.FieldByName('EndSuv').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSmrdocTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TSmrdocTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TSmrdocTmp.LocateBoDo (pBokNum:Str5;pDocNum:Str12):boolean;
begin
  SetIndex (ixBoDo);
  Result := oTmpTable.FindKey([pBokNum,pDocNum]);
end;

function TSmrdocTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TSmrdocTmp.LocateDocDes_ (pDocDes_:Str30):boolean;
begin
  SetIndex (ixDocDes_);
  Result := oTmpTable.FindKey([pDocDes_]);
end;

procedure TSmrdocTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TSmrdocTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TSmrdocTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TSmrdocTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TSmrdocTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TSmrdocTmp.First;
begin
  oTmpTable.First;
end;

procedure TSmrdocTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TSmrdocTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TSmrdocTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TSmrdocTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TSmrdocTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TSmrdocTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TSmrdocTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TSmrdocTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TSmrdocTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TSmrdocTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TSmrdocTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1905014}
