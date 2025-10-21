unit tACMSTV;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixStAsAn='';

type
  TAcmstvTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetStkNum:word;             procedure SetStkNum (pValue:word);
    function GetAccSnt:Str3;             procedure SetAccSnt (pValue:Str3);
    function GetAccAnl:Str6;             procedure SetAccAnl (pValue:Str6);
    function GetAccNam:Str30;            procedure SetAccNam (pValue:Str30);
    function GetStkNam:Str30;            procedure SetStkNam (pValue:Str30);
    function GetBegAcv:double;           procedure SetBegAcv (pValue:double);
    function GetCrdAcv:double;           procedure SetCrdAcv (pValue:double);
    function GetDebAcv:double;           procedure SetDebAcv (pValue:double);
    function GetEndAcv:double;           procedure SetEndAcv (pValue:double);
    function GetBegStv:double;           procedure SetBegStv (pValue:double);
    function GetCrdStv:double;           procedure SetCrdStv (pValue:double);
    function GetDebStv:double;           procedure SetDebStv (pValue:double);
    function GetEndStv:double;           procedure SetEndStv (pValue:double);
    function GetDifVal:double;           procedure SetDifVal (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocStAsAn (pStkNum:word;pAccSnt:Str3;pAccAnl:Str6):boolean;

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
    property StkNum:word read GetStkNum write SetStkNum;
    property AccSnt:Str3 read GetAccSnt write SetAccSnt;
    property AccAnl:Str6 read GetAccAnl write SetAccAnl;
    property AccNam:Str30 read GetAccNam write SetAccNam;
    property StkNam:Str30 read GetStkNam write SetStkNam;
    property BegAcv:double read GetBegAcv write SetBegAcv;
    property CrdAcv:double read GetCrdAcv write SetCrdAcv;
    property DebAcv:double read GetDebAcv write SetDebAcv;
    property EndAcv:double read GetEndAcv write SetEndAcv;
    property BegStv:double read GetBegStv write SetBegStv;
    property CrdStv:double read GetCrdStv write SetCrdStv;
    property DebStv:double read GetDebStv write SetDebStv;
    property EndStv:double read GetEndStv write SetEndStv;
    property DifVal:double read GetDifVal write SetDifVal;
  end;

implementation

constructor TAcmstvTmp.Create;
begin
  oTmpTable:=TmpInit ('ACMSTV',Self);
end;

destructor TAcmstvTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TAcmstvTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TAcmstvTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TAcmstvTmp.GetStkNum:word;
begin
  Result:=oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TAcmstvTmp.SetStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TAcmstvTmp.GetAccSnt:Str3;
begin
  Result:=oTmpTable.FieldByName('AccSnt').AsString;
end;

procedure TAcmstvTmp.SetAccSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt').AsString:=pValue;
end;

function TAcmstvTmp.GetAccAnl:Str6;
begin
  Result:=oTmpTable.FieldByName('AccAnl').AsString;
end;

procedure TAcmstvTmp.SetAccAnl(pValue:Str6);
begin
  oTmpTable.FieldByName('AccAnl').AsString:=pValue;
end;

function TAcmstvTmp.GetAccNam:Str30;
begin
  Result:=oTmpTable.FieldByName('AccNam').AsString;
end;

procedure TAcmstvTmp.SetAccNam(pValue:Str30);
begin
  oTmpTable.FieldByName('AccNam').AsString:=pValue;
end;

function TAcmstvTmp.GetStkNam:Str30;
begin
  Result:=oTmpTable.FieldByName('StkNam').AsString;
end;

procedure TAcmstvTmp.SetStkNam(pValue:Str30);
begin
  oTmpTable.FieldByName('StkNam').AsString:=pValue;
end;

function TAcmstvTmp.GetBegAcv:double;
begin
  Result:=oTmpTable.FieldByName('BegAcv').AsFloat;
end;

procedure TAcmstvTmp.SetBegAcv(pValue:double);
begin
  oTmpTable.FieldByName('BegAcv').AsFloat:=pValue;
end;

function TAcmstvTmp.GetCrdAcv:double;
begin
  Result:=oTmpTable.FieldByName('CrdAcv').AsFloat;
end;

procedure TAcmstvTmp.SetCrdAcv(pValue:double);
begin
  oTmpTable.FieldByName('CrdAcv').AsFloat:=pValue;
end;

function TAcmstvTmp.GetDebAcv:double;
begin
  Result:=oTmpTable.FieldByName('DebAcv').AsFloat;
end;

procedure TAcmstvTmp.SetDebAcv(pValue:double);
begin
  oTmpTable.FieldByName('DebAcv').AsFloat:=pValue;
end;

function TAcmstvTmp.GetEndAcv:double;
begin
  Result:=oTmpTable.FieldByName('EndAcv').AsFloat;
end;

procedure TAcmstvTmp.SetEndAcv(pValue:double);
begin
  oTmpTable.FieldByName('EndAcv').AsFloat:=pValue;
end;

function TAcmstvTmp.GetBegStv:double;
begin
  Result:=oTmpTable.FieldByName('BegStv').AsFloat;
end;

procedure TAcmstvTmp.SetBegStv(pValue:double);
begin
  oTmpTable.FieldByName('BegStv').AsFloat:=pValue;
end;

function TAcmstvTmp.GetCrdStv:double;
begin
  Result:=oTmpTable.FieldByName('CrdStv').AsFloat;
end;

procedure TAcmstvTmp.SetCrdStv(pValue:double);
begin
  oTmpTable.FieldByName('CrdStv').AsFloat:=pValue;
end;

function TAcmstvTmp.GetDebStv:double;
begin
  Result:=oTmpTable.FieldByName('DebStv').AsFloat;
end;

procedure TAcmstvTmp.SetDebStv(pValue:double);
begin
  oTmpTable.FieldByName('DebStv').AsFloat:=pValue;
end;

function TAcmstvTmp.GetEndStv:double;
begin
  Result:=oTmpTable.FieldByName('EndStv').AsFloat;
end;

procedure TAcmstvTmp.SetEndStv(pValue:double);
begin
  oTmpTable.FieldByName('EndStv').AsFloat:=pValue;
end;

function TAcmstvTmp.GetDifVal:double;
begin
  Result:=oTmpTable.FieldByName('DifVal').AsFloat;
end;

procedure TAcmstvTmp.SetDifVal(pValue:double);
begin
  oTmpTable.FieldByName('DifVal').AsFloat:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TAcmstvTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TAcmstvTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TAcmstvTmp.LocStAsAn(pStkNum:word;pAccSnt:Str3;pAccAnl:Str6):boolean;
begin
  SetIndex (ixStAsAn);
  Result:=oTmpTable.FindKey([pStkNum,pAccSnt,pAccAnl]);
end;

procedure TAcmstvTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TAcmstvTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TAcmstvTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TAcmstvTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TAcmstvTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TAcmstvTmp.First;
begin
  oTmpTable.First;
end;

procedure TAcmstvTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TAcmstvTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TAcmstvTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TAcmstvTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TAcmstvTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TAcmstvTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TAcmstvTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TAcmstvTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TAcmstvTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TAcmstvTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TAcmstvTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
