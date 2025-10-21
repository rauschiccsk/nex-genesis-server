unit tXRGCLC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPrim = '';

type
  TXrgclcTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadValTyp:Str2;           procedure WriteValTyp (pValue:Str2);
    function  ReadIdcTyp:Str2;           procedure WriteIdcTyp (pValue:Str2);
    function  ReadSrcNum:longint;        procedure WriteSrcNum (pValue:longint);
    function  ReadBegDat:TDatetime;      procedure WriteBegDat (pValue:TDatetime);
    function  ReadEndDat:TDatetime;      procedure WriteEndDat (pValue:TDatetime);
    function  ReadYerDef:longint;        procedure WriteYerDef (pValue:longint);
    function  ReadSalQnt:double;         procedure WriteSalQnt (pValue:double);
    function  ReadSalVal:double;         procedure WriteSalVal (pValue:double);
    function  ReadStkQnt:double;         procedure WriteStkQnt (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocatePrim (pValTyp:Str2;pIdcTyp:Str2;pSrcNum:longint;pBegDat:TDatetime;pEndDat:TDatetime):boolean;

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
    property ValTyp:Str2 read ReadValTyp write WriteValTyp;
    property IdcTyp:Str2 read ReadIdcTyp write WriteIdcTyp;
    property SrcNum:longint read ReadSrcNum write WriteSrcNum;
    property BegDat:TDatetime read ReadBegDat write WriteBegDat;
    property EndDat:TDatetime read ReadEndDat write WriteEndDat;
    property YerDef:longint read ReadYerDef write WriteYerDef;
    property SalQnt:double read ReadSalQnt write WriteSalQnt;
    property SalVal:double read ReadSalVal write WriteSalVal;
    property StkQnt:double read ReadStkQnt write WriteStkQnt;
  end;

implementation

constructor TXrgclcTmp.Create;
begin
  oTmpTable := TmpInit ('XRGCLC',Self);
end;

destructor TXrgclcTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TXrgclcTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TXrgclcTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TXrgclcTmp.ReadValTyp:Str2;
begin
  Result := oTmpTable.FieldByName('ValTyp').AsString;
end;

procedure TXrgclcTmp.WriteValTyp(pValue:Str2);
begin
  oTmpTable.FieldByName('ValTyp').AsString := pValue;
end;

function TXrgclcTmp.ReadIdcTyp:Str2;
begin
  Result := oTmpTable.FieldByName('IdcTyp').AsString;
end;

procedure TXrgclcTmp.WriteIdcTyp(pValue:Str2);
begin
  oTmpTable.FieldByName('IdcTyp').AsString := pValue;
end;

function TXrgclcTmp.ReadSrcNum:longint;
begin
  Result := oTmpTable.FieldByName('SrcNum').AsInteger;
end;

procedure TXrgclcTmp.WriteSrcNum(pValue:longint);
begin
  oTmpTable.FieldByName('SrcNum').AsInteger := pValue;
end;

function TXrgclcTmp.ReadBegDat:TDatetime;
begin
  Result := oTmpTable.FieldByName('BegDat').AsDateTime;
end;

procedure TXrgclcTmp.WriteBegDat(pValue:TDatetime);
begin
  oTmpTable.FieldByName('BegDat').AsDateTime := pValue;
end;

function TXrgclcTmp.ReadEndDat:TDatetime;
begin
  Result := oTmpTable.FieldByName('EndDat').AsDateTime;
end;

procedure TXrgclcTmp.WriteEndDat(pValue:TDatetime);
begin
  oTmpTable.FieldByName('EndDat').AsDateTime := pValue;
end;

function TXrgclcTmp.ReadYerDef:longint;
begin
  Result := oTmpTable.FieldByName('YerDef').AsInteger;
end;

procedure TXrgclcTmp.WriteYerDef(pValue:longint);
begin
  oTmpTable.FieldByName('YerDef').AsInteger := pValue;
end;

function TXrgclcTmp.ReadSalQnt:double;
begin
  Result := oTmpTable.FieldByName('SalQnt').AsFloat;
end;

procedure TXrgclcTmp.WriteSalQnt(pValue:double);
begin
  oTmpTable.FieldByName('SalQnt').AsFloat := pValue;
end;

function TXrgclcTmp.ReadSalVal:double;
begin
  Result := oTmpTable.FieldByName('SalVal').AsFloat;
end;

procedure TXrgclcTmp.WriteSalVal(pValue:double);
begin
  oTmpTable.FieldByName('SalVal').AsFloat := pValue;
end;

function TXrgclcTmp.ReadStkQnt:double;
begin
  Result := oTmpTable.FieldByName('StkQnt').AsFloat;
end;

procedure TXrgclcTmp.WriteStkQnt(pValue:double);
begin
  oTmpTable.FieldByName('StkQnt').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TXrgclcTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TXrgclcTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TXrgclcTmp.LocatePrim (pValTyp:Str2;pIdcTyp:Str2;pSrcNum:longint;pBegDat:TDatetime;pEndDat:TDatetime):boolean;
begin
  SetIndex (ixPrim);
  Result := oTmpTable.FindKey([pValTyp,pIdcTyp,pSrcNum,pBegDat,pEndDat]);
end;

procedure TXrgclcTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TXrgclcTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TXrgclcTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TXrgclcTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TXrgclcTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TXrgclcTmp.First;
begin
  oTmpTable.First;
end;

procedure TXrgclcTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TXrgclcTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TXrgclcTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TXrgclcTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TXrgclcTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TXrgclcTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TXrgclcTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TXrgclcTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TXrgclcTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TXrgclcTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TXrgclcTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1918001}
