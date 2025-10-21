unit tBSMINV;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixInvDoc='';
  ixParNum='ParNum';
  ixParNam_='ParNam_';

type
  TBsminvTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetInvDoc:Str12;            procedure SetInvDoc (pValue:Str12);
    function GetVarSym:Str12;            procedure SetVarSym (pValue:Str12);
    function GetInvTyp:Str1;             procedure SetInvTyp (pValue:Str1);
    function GetInvDvz:Str3;             procedure SetInvDvz (pValue:Str3);
    function GetInvCrs:double;           procedure SetInvCrs (pValue:double);
    function GetInvCdt:TDatetime;        procedure SetInvCdt (pValue:TDatetime);
    function GetEndFgv:double;           procedure SetEndFgv (pValue:double);
    function GetEndAcv:double;           procedure SetEndAcv (pValue:double);
    function GetParNum:longint;          procedure SetParNum (pValue:longint);
    function GetParNam:Str60;            procedure SetParNam (pValue:Str60);
    function GetParNam_:Str60;           procedure SetParNam_ (pValue:Str60);
    function GetWriNum:word;             procedure SetWriNum (pValue:word);
    function GetAccSnt:Str3;             procedure SetAccSnt (pValue:Str3);
    function GetAccAnl:Str6;             procedure SetAccAnl (pValue:Str6);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocInvDoc (pInvDoc:Str12):boolean;
    function LocParNum (pParNum:longint):boolean;
    function LocParNam_ (pParNam_:Str60):boolean;

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
    property InvDoc:Str12 read GetInvDoc write SetInvDoc;
    property VarSym:Str12 read GetVarSym write SetVarSym;
    property InvTyp:Str1 read GetInvTyp write SetInvTyp;
    property InvDvz:Str3 read GetInvDvz write SetInvDvz;
    property InvCrs:double read GetInvCrs write SetInvCrs;
    property InvCdt:TDatetime read GetInvCdt write SetInvCdt;
    property EndFgv:double read GetEndFgv write SetEndFgv;
    property EndAcv:double read GetEndAcv write SetEndAcv;
    property ParNum:longint read GetParNum write SetParNum;
    property ParNam:Str60 read GetParNam write SetParNam;
    property ParNam_:Str60 read GetParNam_ write SetParNam_;
    property WriNum:word read GetWriNum write SetWriNum;
    property AccSnt:Str3 read GetAccSnt write SetAccSnt;
    property AccAnl:Str6 read GetAccAnl write SetAccAnl;
  end;

implementation

constructor TBsminvTmp.Create;
begin
  oTmpTable:=TmpInit ('BSMINV',Self);
end;

destructor TBsminvTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TBsminvTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TBsminvTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TBsminvTmp.GetInvDoc:Str12;
begin
  Result:=oTmpTable.FieldByName('InvDoc').AsString;
end;

procedure TBsminvTmp.SetInvDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('InvDoc').AsString:=pValue;
end;

function TBsminvTmp.GetVarSym:Str12;
begin
  Result:=oTmpTable.FieldByName('VarSym').AsString;
end;

procedure TBsminvTmp.SetVarSym(pValue:Str12);
begin
  oTmpTable.FieldByName('VarSym').AsString:=pValue;
end;

function TBsminvTmp.GetInvTyp:Str1;
begin
  Result:=oTmpTable.FieldByName('InvTyp').AsString;
end;

procedure TBsminvTmp.SetInvTyp(pValue:Str1);
begin
  oTmpTable.FieldByName('InvTyp').AsString:=pValue;
end;

function TBsminvTmp.GetInvDvz:Str3;
begin
  Result:=oTmpTable.FieldByName('InvDvz').AsString;
end;

procedure TBsminvTmp.SetInvDvz(pValue:Str3);
begin
  oTmpTable.FieldByName('InvDvz').AsString:=pValue;
end;

function TBsminvTmp.GetInvCrs:double;
begin
  Result:=oTmpTable.FieldByName('InvCrs').AsFloat;
end;

procedure TBsminvTmp.SetInvCrs(pValue:double);
begin
  oTmpTable.FieldByName('InvCrs').AsFloat:=pValue;
end;

function TBsminvTmp.GetInvCdt:TDatetime;
begin
  Result:=oTmpTable.FieldByName('InvCdt').AsDateTime;
end;

procedure TBsminvTmp.SetInvCdt(pValue:TDatetime);
begin
  oTmpTable.FieldByName('InvCdt').AsDateTime:=pValue;
end;

function TBsminvTmp.GetEndFgv:double;
begin
  Result:=oTmpTable.FieldByName('EndFgv').AsFloat;
end;

procedure TBsminvTmp.SetEndFgv(pValue:double);
begin
  oTmpTable.FieldByName('EndFgv').AsFloat:=pValue;
end;

function TBsminvTmp.GetEndAcv:double;
begin
  Result:=oTmpTable.FieldByName('EndAcv').AsFloat;
end;

procedure TBsminvTmp.SetEndAcv(pValue:double);
begin
  oTmpTable.FieldByName('EndAcv').AsFloat:=pValue;
end;

function TBsminvTmp.GetParNum:longint;
begin
  Result:=oTmpTable.FieldByName('ParNum').AsInteger;
end;

procedure TBsminvTmp.SetParNum(pValue:longint);
begin
  oTmpTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TBsminvTmp.GetParNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ParNam').AsString;
end;

procedure TBsminvTmp.SetParNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ParNam').AsString:=pValue;
end;

function TBsminvTmp.GetParNam_:Str60;
begin
  Result:=oTmpTable.FieldByName('ParNam_').AsString;
end;

procedure TBsminvTmp.SetParNam_(pValue:Str60);
begin
  oTmpTable.FieldByName('ParNam_').AsString:=pValue;
end;

function TBsminvTmp.GetWriNum:word;
begin
  Result:=oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TBsminvTmp.SetWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger:=pValue;
end;

function TBsminvTmp.GetAccSnt:Str3;
begin
  Result:=oTmpTable.FieldByName('AccSnt').AsString;
end;

procedure TBsminvTmp.SetAccSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt').AsString:=pValue;
end;

function TBsminvTmp.GetAccAnl:Str6;
begin
  Result:=oTmpTable.FieldByName('AccAnl').AsString;
end;

procedure TBsminvTmp.SetAccAnl(pValue:Str6);
begin
  oTmpTable.FieldByName('AccAnl').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TBsminvTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TBsminvTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TBsminvTmp.LocInvDoc(pInvDoc:Str12):boolean;
begin
  SetIndex (ixInvDoc);
  Result:=oTmpTable.FindKey([pInvDoc]);
end;

function TBsminvTmp.LocParNum(pParNum:longint):boolean;
begin
  SetIndex (ixParNum);
  Result:=oTmpTable.FindKey([pParNum]);
end;

function TBsminvTmp.LocParNam_(pParNam_:Str60):boolean;
begin
  SetIndex (ixParNam_);
  Result:=oTmpTable.FindKey([pParNam_]);
end;

procedure TBsminvTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TBsminvTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TBsminvTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TBsminvTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TBsminvTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TBsminvTmp.First;
begin
  oTmpTable.First;
end;

procedure TBsminvTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TBsminvTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TBsminvTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TBsminvTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TBsminvTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TBsminvTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TBsminvTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TBsminvTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TBsminvTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TBsminvTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TBsminvTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
