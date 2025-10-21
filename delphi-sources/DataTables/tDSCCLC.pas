unit tDSCCLC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixItmNum='';

type
  TDscclcTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetItmNum:word;             procedure SetItmNum (pValue:word);
    function GetVatPrc:byte;             procedure SetVatPrc (pValue:byte);
    function GetPlsAva:double;           procedure SetPlsAva (pValue:double);
    function GetPlsBva:double;           procedure SetPlsBva (pValue:double);
    function GetDscPrc:double;           procedure SetDscPrc (pValue:double);
    function GetSalAva:double;           procedure SetSalAva (pValue:double);
    function GetSalBva:double;           procedure SetSalBva (pValue:double);
    function GetNewPrc:double;           procedure SetNewPrc (pValue:double);
    function GetNewAva:double;           procedure SetNewAva (pValue:double);
    function GetNewBva:double;           procedure SetNewBva (pValue:double);
    function GetSapSrc:Str2;             procedure SetSapSrc (pValue:Str2);
    function GetProTyp:Str1;             procedure SetProTyp (pValue:Str1);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocItmNum (pItmNum:word):boolean;

    procedure SetIndex(pIndexName:ShortString);
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
    procedure RestIndex;
    procedure SwapStatus;
    procedure RestStatus;
    procedure EnabCont;
    procedure DisabCont;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read GetCount;
    property ItmNum:word read GetItmNum write SetItmNum;
    property VatPrc:byte read GetVatPrc write SetVatPrc;
    property PlsAva:double read GetPlsAva write SetPlsAva;
    property PlsBva:double read GetPlsBva write SetPlsBva;
    property DscPrc:double read GetDscPrc write SetDscPrc;
    property SalAva:double read GetSalAva write SetSalAva;
    property SalBva:double read GetSalBva write SetSalBva;
    property NewPrc:double read GetNewPrc write SetNewPrc;
    property NewAva:double read GetNewAva write SetNewAva;
    property NewBva:double read GetNewBva write SetNewBva;
    property SapSrc:Str2 read GetSapSrc write SetSapSrc;
    property ProTyp:Str1 read GetProTyp write SetProTyp;
  end;

implementation

constructor TDscclcTmp.Create;
begin
  oTmpTable:=TmpInit ('DSCCLC',Self);
end;

destructor TDscclcTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TDscclcTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TDscclcTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TDscclcTmp.GetItmNum:word;
begin
  Result:=oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TDscclcTmp.SetItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TDscclcTmp.GetVatPrc:byte;
begin
  Result:=oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TDscclcTmp.SetVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger:=pValue;
end;

function TDscclcTmp.GetPlsAva:double;
begin
  Result:=oTmpTable.FieldByName('PlsAva').AsFloat;
end;

procedure TDscclcTmp.SetPlsAva(pValue:double);
begin
  oTmpTable.FieldByName('PlsAva').AsFloat:=pValue;
end;

function TDscclcTmp.GetPlsBva:double;
begin
  Result:=oTmpTable.FieldByName('PlsBva').AsFloat;
end;

procedure TDscclcTmp.SetPlsBva(pValue:double);
begin
  oTmpTable.FieldByName('PlsBva').AsFloat:=pValue;
end;

function TDscclcTmp.GetDscPrc:double;
begin
  Result:=oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TDscclcTmp.SetDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat:=pValue;
end;

function TDscclcTmp.GetSalAva:double;
begin
  Result:=oTmpTable.FieldByName('SalAva').AsFloat;
end;

procedure TDscclcTmp.SetSalAva(pValue:double);
begin
  oTmpTable.FieldByName('SalAva').AsFloat:=pValue;
end;

function TDscclcTmp.GetSalBva:double;
begin
  Result:=oTmpTable.FieldByName('SalBva').AsFloat;
end;

procedure TDscclcTmp.SetSalBva(pValue:double);
begin
  oTmpTable.FieldByName('SalBva').AsFloat:=pValue;
end;

function TDscclcTmp.GetNewPrc:double;
begin
  Result:=oTmpTable.FieldByName('NewPrc').AsFloat;
end;

procedure TDscclcTmp.SetNewPrc(pValue:double);
begin
  oTmpTable.FieldByName('NewPrc').AsFloat:=pValue;
end;

function TDscclcTmp.GetNewAva:double;
begin
  Result:=oTmpTable.FieldByName('NewAva').AsFloat;
end;

procedure TDscclcTmp.SetNewAva(pValue:double);
begin
  oTmpTable.FieldByName('NewAva').AsFloat:=pValue;
end;

function TDscclcTmp.GetNewBva:double;
begin
  Result:=oTmpTable.FieldByName('NewBva').AsFloat;
end;

procedure TDscclcTmp.SetNewBva(pValue:double);
begin
  oTmpTable.FieldByName('NewBva').AsFloat:=pValue;
end;

function TDscclcTmp.GetSapSrc:Str2;
begin
  Result:=oTmpTable.FieldByName('SapSrc').AsString;
end;

procedure TDscclcTmp.SetSapSrc(pValue:Str2);
begin
  oTmpTable.FieldByName('SapSrc').AsString:=pValue;
end;

function TDscclcTmp.GetProTyp:Str1;
begin
  Result:=oTmpTable.FieldByName('ProTyp').AsString;
end;

procedure TDscclcTmp.SetProTyp(pValue:Str1);
begin
  oTmpTable.FieldByName('ProTyp').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TDscclcTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TDscclcTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TDscclcTmp.LocItmNum(pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result:=oTmpTable.FindKey([pItmNum]);
end;

procedure TDscclcTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TDscclcTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TDscclcTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TDscclcTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TDscclcTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TDscclcTmp.First;
begin
  oTmpTable.First;
end;

procedure TDscclcTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TDscclcTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TDscclcTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TDscclcTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TDscclcTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TDscclcTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TDscclcTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TDscclcTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TDscclcTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TDscclcTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TDscclcTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
