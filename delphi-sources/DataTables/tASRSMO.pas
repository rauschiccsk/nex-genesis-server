unit tASRSMO;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSoAsAn='';
  ixSmoNum='SmoNum';
  ixAsAn='AsAn';

type
  TAsrsmoTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetSmoNum:word;             procedure SetSmoNum (pValue:word);
    function GetAccSnt:Str3;             procedure SetAccSnt (pValue:Str3);
    function GetAccAnl:Str6;             procedure SetAccAnl (pValue:Str6);
    function GetSmoNam:Str30;            procedure SetSmoNam (pValue:Str30);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocSoAsAn (pSmoNum:word;pAccSnt:Str3;pAccAnl:Str6):boolean;
    function LocSmoNum (pSmoNum:word):boolean;
    function LocAsAn (pAccSnt:Str3;pAccAnl:Str6):boolean;

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
    property SmoNum:word read GetSmoNum write SetSmoNum;
    property AccSnt:Str3 read GetAccSnt write SetAccSnt;
    property AccAnl:Str6 read GetAccAnl write SetAccAnl;
    property SmoNam:Str30 read GetSmoNam write SetSmoNam;
  end;

implementation

constructor TAsrsmoTmp.Create;
begin
  oTmpTable:=TmpInit ('ASRSMO',Self);
end;

destructor TAsrsmoTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TAsrsmoTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TAsrsmoTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TAsrsmoTmp.GetSmoNum:word;
begin
  Result:=oTmpTable.FieldByName('SmoNum').AsInteger;
end;

procedure TAsrsmoTmp.SetSmoNum(pValue:word);
begin
  oTmpTable.FieldByName('SmoNum').AsInteger:=pValue;
end;

function TAsrsmoTmp.GetAccSnt:Str3;
begin
  Result:=oTmpTable.FieldByName('AccSnt').AsString;
end;

procedure TAsrsmoTmp.SetAccSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt').AsString:=pValue;
end;

function TAsrsmoTmp.GetAccAnl:Str6;
begin
  Result:=oTmpTable.FieldByName('AccAnl').AsString;
end;

procedure TAsrsmoTmp.SetAccAnl(pValue:Str6);
begin
  oTmpTable.FieldByName('AccAnl').AsString:=pValue;
end;

function TAsrsmoTmp.GetSmoNam:Str30;
begin
  Result:=oTmpTable.FieldByName('SmoNam').AsString;
end;

procedure TAsrsmoTmp.SetSmoNam(pValue:Str30);
begin
  oTmpTable.FieldByName('SmoNam').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TAsrsmoTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TAsrsmoTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TAsrsmoTmp.LocSoAsAn(pSmoNum:word;pAccSnt:Str3;pAccAnl:Str6):boolean;
begin
  SetIndex (ixSoAsAn);
  Result:=oTmpTable.FindKey([pSmoNum,pAccSnt,pAccAnl]);
end;

function TAsrsmoTmp.LocSmoNum(pSmoNum:word):boolean;
begin
  SetIndex (ixSmoNum);
  Result:=oTmpTable.FindKey([pSmoNum]);
end;

function TAsrsmoTmp.LocAsAn(pAccSnt:Str3;pAccAnl:Str6):boolean;
begin
  SetIndex (ixAsAn);
  Result:=oTmpTable.FindKey([pAccSnt,pAccAnl]);
end;

procedure TAsrsmoTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TAsrsmoTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TAsrsmoTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TAsrsmoTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TAsrsmoTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TAsrsmoTmp.First;
begin
  oTmpTable.First;
end;

procedure TAsrsmoTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TAsrsmoTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TAsrsmoTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TAsrsmoTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TAsrsmoTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TAsrsmoTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TAsrsmoTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TAsrsmoTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TAsrsmoTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TAsrsmoTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TAsrsmoTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
