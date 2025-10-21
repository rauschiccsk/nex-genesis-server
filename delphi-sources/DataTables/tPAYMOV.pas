unit tPAYMOV;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = '';
  ixDocDat = 'DocDat';
  ixExtNum = 'ExtNum';
  ixConDoc = 'ConDoc';
  ixPayDes_ = 'PayDes_';
  ixParNam_ = 'ParNam_';

type
  TPaymovTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadDocDat:TDatetime;      procedure WriteDocDat (pValue:TDatetime);
    function  ReadExtNum:Str10;          procedure WriteExtNum (pValue:Str10);
    function  ReadConDoc:Str12;          procedure WriteConDoc (pValue:Str12);
    function  ReadPayDes:Str30;          procedure WritePayDes (pValue:Str30);
    function  ReadPayDes_:Str30;         procedure WritePayDes_ (pValue:Str30);
    function  ReadParCod:longint;        procedure WriteParCod (pValue:longint);
    function  ReadParNam:Str30;          procedure WriteParNam (pValue:Str30);
    function  ReadParNam_:Str30;         procedure WriteParNam_ (pValue:Str30);
    function  ReadIncVal:double;         procedure WriteIncVal (pValue:double);
    function  ReadOutVal:double;         procedure WriteOutVal (pValue:double);
    function  ReadEndVal:double;         procedure WriteEndVal (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateDocDat (pDocDat:TDatetime):boolean;
    function LocateExtNum (pExtNum:Str10):boolean;
    function LocateConDoc (pConDoc:Str12):boolean;
    function LocatePayDes_ (pPayDes_:Str30):boolean;
    function LocateParNam_ (pParNam_:Str30):boolean;

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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property DocDat:TDatetime read ReadDocDat write WriteDocDat;
    property ExtNum:Str10 read ReadExtNum write WriteExtNum;
    property ConDoc:Str12 read ReadConDoc write WriteConDoc;
    property PayDes:Str30 read ReadPayDes write WritePayDes;
    property PayDes_:Str30 read ReadPayDes_ write WritePayDes_;
    property ParCod:longint read ReadParCod write WriteParCod;
    property ParNam:Str30 read ReadParNam write WriteParNam;
    property ParNam_:Str30 read ReadParNam_ write WriteParNam_;
    property IncVal:double read ReadIncVal write WriteIncVal;
    property OutVal:double read ReadOutVal write WriteOutVal;
    property EndVal:double read ReadEndVal write WriteEndVal;
  end;

implementation

constructor TPaymovTmp.Create;
begin
  oTmpTable := TmpInit ('PAYMOV',Self);
end;

destructor TPaymovTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TPaymovTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TPaymovTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TPaymovTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TPaymovTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TPaymovTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TPaymovTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TPaymovTmp.ReadDocDat:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDat').AsDateTime;
end;

procedure TPaymovTmp.WriteDocDat(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDat').AsDateTime := pValue;
end;

function TPaymovTmp.ReadExtNum:Str10;
begin
  Result := oTmpTable.FieldByName('ExtNum').AsString;
end;

procedure TPaymovTmp.WriteExtNum(pValue:Str10);
begin
  oTmpTable.FieldByName('ExtNum').AsString := pValue;
end;

function TPaymovTmp.ReadConDoc:Str12;
begin
  Result := oTmpTable.FieldByName('ConDoc').AsString;
end;

procedure TPaymovTmp.WriteConDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('ConDoc').AsString := pValue;
end;

function TPaymovTmp.ReadPayDes:Str30;
begin
  Result := oTmpTable.FieldByName('PayDes').AsString;
end;

procedure TPaymovTmp.WritePayDes(pValue:Str30);
begin
  oTmpTable.FieldByName('PayDes').AsString := pValue;
end;

function TPaymovTmp.ReadPayDes_:Str30;
begin
  Result := oTmpTable.FieldByName('PayDes_').AsString;
end;

procedure TPaymovTmp.WritePayDes_(pValue:Str30);
begin
  oTmpTable.FieldByName('PayDes_').AsString := pValue;
end;

function TPaymovTmp.ReadParCod:longint;
begin
  Result := oTmpTable.FieldByName('ParCod').AsInteger;
end;

procedure TPaymovTmp.WriteParCod(pValue:longint);
begin
  oTmpTable.FieldByName('ParCod').AsInteger := pValue;
end;

function TPaymovTmp.ReadParNam:Str30;
begin
  Result := oTmpTable.FieldByName('ParNam').AsString;
end;

procedure TPaymovTmp.WriteParNam(pValue:Str30);
begin
  oTmpTable.FieldByName('ParNam').AsString := pValue;
end;

function TPaymovTmp.ReadParNam_:Str30;
begin
  Result := oTmpTable.FieldByName('ParNam_').AsString;
end;

procedure TPaymovTmp.WriteParNam_(pValue:Str30);
begin
  oTmpTable.FieldByName('ParNam_').AsString := pValue;
end;

function TPaymovTmp.ReadIncVal:double;
begin
  Result := oTmpTable.FieldByName('IncVal').AsFloat;
end;

procedure TPaymovTmp.WriteIncVal(pValue:double);
begin
  oTmpTable.FieldByName('IncVal').AsFloat := pValue;
end;

function TPaymovTmp.ReadOutVal:double;
begin
  Result := oTmpTable.FieldByName('OutVal').AsFloat;
end;

procedure TPaymovTmp.WriteOutVal(pValue:double);
begin
  oTmpTable.FieldByName('OutVal').AsFloat := pValue;
end;

function TPaymovTmp.ReadEndVal:double;
begin
  Result := oTmpTable.FieldByName('EndVal').AsFloat;
end;

procedure TPaymovTmp.WriteEndVal(pValue:double);
begin
  oTmpTable.FieldByName('EndVal').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPaymovTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TPaymovTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TPaymovTmp.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TPaymovTmp.LocateDocDat (pDocDat:TDatetime):boolean;
begin
  SetIndex (ixDocDat);
  Result := oTmpTable.FindKey([pDocDat]);
end;

function TPaymovTmp.LocateExtNum (pExtNum:Str10):boolean;
begin
  SetIndex (ixExtNum);
  Result := oTmpTable.FindKey([pExtNum]);
end;

function TPaymovTmp.LocateConDoc (pConDoc:Str12):boolean;
begin
  SetIndex (ixConDoc);
  Result := oTmpTable.FindKey([pConDoc]);
end;

function TPaymovTmp.LocatePayDes_ (pPayDes_:Str30):boolean;
begin
  SetIndex (ixPayDes_);
  Result := oTmpTable.FindKey([pPayDes_]);
end;

function TPaymovTmp.LocateParNam_ (pParNam_:Str30):boolean;
begin
  SetIndex (ixParNam_);
  Result := oTmpTable.FindKey([pParNam_]);
end;

procedure TPaymovTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TPaymovTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TPaymovTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TPaymovTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TPaymovTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TPaymovTmp.First;
begin
  oTmpTable.First;
end;

procedure TPaymovTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TPaymovTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TPaymovTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TPaymovTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TPaymovTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TPaymovTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TPaymovTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TPaymovTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TPaymovTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TPaymovTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TPaymovTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1928001}
