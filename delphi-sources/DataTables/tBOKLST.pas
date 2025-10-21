unit tBOKLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixBokNum = '';
  ixBokName_ = 'BokName_';

type
  TBoklstTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadBokNum:Str5;           procedure WriteBokNum (pValue:Str5);
    function  ReadBokName:Str30;         procedure WriteBokName (pValue:Str30);
    function  ReadBokName_:Str30;        procedure WriteBokName_ (pValue:Str30);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocBokNum (pBokNum:Str5):boolean;
    function LocBokName_ (pBokName_:Str30):boolean;

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
    property BokNam:Str30 read ReadBokName write WriteBokName;
    property BokName_:Str30 read ReadBokName_ write WriteBokName_;
  end;

implementation

constructor TBoklstTmp.Create;
begin
  oTmpTable := TmpInit ('BOKLST',Self);
end;

destructor TBoklstTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TBoklstTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TBoklstTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TBoklstTmp.ReadBokNum:Str5;
begin
  Result := oTmpTable.FieldByName('BokNum').AsString;
end;

procedure TBoklstTmp.WriteBokNum(pValue:Str5);
begin
  oTmpTable.FieldByName('BokNum').AsString := pValue;
end;

function TBoklstTmp.ReadBokName:Str30;
begin
  Result := oTmpTable.FieldByName('BokName').AsString;
end;

procedure TBoklstTmp.WriteBokName(pValue:Str30);
begin
  oTmpTable.FieldByName('BokName').AsString := pValue;
end;

function TBoklstTmp.ReadBokName_:Str30;
begin
  Result := oTmpTable.FieldByName('BokName_').AsString;
end;

procedure TBoklstTmp.WriteBokName_(pValue:Str30);
begin
  oTmpTable.FieldByName('BokName_').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TBoklstTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TBoklstTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TBoklstTmp.LocBokNum (pBokNum:Str5):boolean;
begin
  SetIndex (ixBokNum);
  Result := oTmpTable.FindKey([pBokNum]);
end;

function TBoklstTmp.LocBokName_ (pBokName_:Str30):boolean;
begin
  SetIndex (ixBokName_);
  Result := oTmpTable.FindKey([pBokName_]);
end;

procedure TBoklstTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TBoklstTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TBoklstTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TBoklstTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TBoklstTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TBoklstTmp.First;
begin
  oTmpTable.First;
end;

procedure TBoklstTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TBoklstTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TBoklstTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TBoklstTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TBoklstTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TBoklstTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TBoklstTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TBoklstTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TBoklstTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TBoklstTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TBoklstTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
