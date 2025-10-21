unit tACMSMO;

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
  TAcmsmoTmp=class(TComponent)
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
    function GetAccNam:Str30;            procedure SetAccNam (pValue:Str30);
    function GetSmoNam:Str30;            procedure SetSmoNam (pValue:Str30);
    function GetSmoTyp:Str1;             procedure SetSmoTyp (pValue:Str1);
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
    property AccNam:Str30 read GetAccNam write SetAccNam;
    property SmoNam:Str30 read GetSmoNam write SetSmoNam;
    property SmoTyp:Str1 read GetSmoTyp write SetSmoTyp;
  end;

implementation

constructor TAcmsmoTmp.Create;
begin
  oTmpTable:=TmpInit ('ACMSMO',Self);
end;

destructor TAcmsmoTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TAcmsmoTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TAcmsmoTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TAcmsmoTmp.GetSmoNum:word;
begin
  Result:=oTmpTable.FieldByName('SmoNum').AsInteger;
end;

procedure TAcmsmoTmp.SetSmoNum(pValue:word);
begin
  oTmpTable.FieldByName('SmoNum').AsInteger:=pValue;
end;

function TAcmsmoTmp.GetAccSnt:Str3;
begin
  Result:=oTmpTable.FieldByName('AccSnt').AsString;
end;

procedure TAcmsmoTmp.SetAccSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt').AsString:=pValue;
end;

function TAcmsmoTmp.GetAccAnl:Str6;
begin
  Result:=oTmpTable.FieldByName('AccAnl').AsString;
end;

procedure TAcmsmoTmp.SetAccAnl(pValue:Str6);
begin
  oTmpTable.FieldByName('AccAnl').AsString:=pValue;
end;

function TAcmsmoTmp.GetAccNam:Str30;
begin
  Result:=oTmpTable.FieldByName('AccNam').AsString;
end;

procedure TAcmsmoTmp.SetAccNam(pValue:Str30);
begin
  oTmpTable.FieldByName('AccNam').AsString:=pValue;
end;

function TAcmsmoTmp.GetSmoNam:Str30;
begin
  Result:=oTmpTable.FieldByName('SmoNam').AsString;
end;

procedure TAcmsmoTmp.SetSmoNam(pValue:Str30);
begin
  oTmpTable.FieldByName('SmoNam').AsString:=pValue;
end;

function TAcmsmoTmp.GetSmoTyp:Str1;
begin
  Result:=oTmpTable.FieldByName('SmoTyp').AsString;
end;

procedure TAcmsmoTmp.SetSmoTyp(pValue:Str1);
begin
  oTmpTable.FieldByName('SmoTyp').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TAcmsmoTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TAcmsmoTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TAcmsmoTmp.LocSoAsAn(pSmoNum:word;pAccSnt:Str3;pAccAnl:Str6):boolean;
begin
  SetIndex (ixSoAsAn);
  Result:=oTmpTable.FindKey([pSmoNum,pAccSnt,pAccAnl]);
end;

function TAcmsmoTmp.LocSmoNum(pSmoNum:word):boolean;
begin
  SetIndex (ixSmoNum);
  Result:=oTmpTable.FindKey([pSmoNum]);
end;

function TAcmsmoTmp.LocAsAn(pAccSnt:Str3;pAccAnl:Str6):boolean;
begin
  SetIndex (ixAsAn);
  Result:=oTmpTable.FindKey([pAccSnt,pAccAnl]);
end;

procedure TAcmsmoTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TAcmsmoTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TAcmsmoTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TAcmsmoTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TAcmsmoTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TAcmsmoTmp.First;
begin
  oTmpTable.First;
end;

procedure TAcmsmoTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TAcmsmoTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TAcmsmoTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TAcmsmoTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TAcmsmoTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TAcmsmoTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TAcmsmoTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TAcmsmoTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TAcmsmoTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TAcmsmoTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TAcmsmoTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
