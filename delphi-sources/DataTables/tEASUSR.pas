unit tEASUSR;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixUsrLog='';

type
  TEasusrTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetUsrLog:Str8;             procedure SetUsrLog (pValue:Str8);
    function GetUsrNam:Str30;            procedure SetUsrNam (pValue:Str30);
    function GetEmlAdr:Str30;            procedure SetEmlAdr (pValue:Str30);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocUsrLog (pUsrLog:Str8):boolean;

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
    property UsrLog:Str8 read GetUsrLog write SetUsrLog;
    property UsrNam:Str30 read GetUsrNam write SetUsrNam;
    property EmlAdr:Str30 read GetEmlAdr write SetEmlAdr;
  end;

implementation

constructor TEasusrTmp.Create;
begin
  oTmpTable:=TmpInit ('EASUSR',Self);
end;

destructor TEasusrTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TEasusrTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TEasusrTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TEasusrTmp.GetUsrLog:Str8;
begin
  Result:=oTmpTable.FieldByName('UsrLog').AsString;
end;

procedure TEasusrTmp.SetUsrLog(pValue:Str8);
begin
  oTmpTable.FieldByName('UsrLog').AsString:=pValue;
end;

function TEasusrTmp.GetUsrNam:Str30;
begin
  Result:=oTmpTable.FieldByName('UsrNam').AsString;
end;

procedure TEasusrTmp.SetUsrNam(pValue:Str30);
begin
  oTmpTable.FieldByName('UsrNam').AsString:=pValue;
end;

function TEasusrTmp.GetEmlAdr:Str30;
begin
  Result:=oTmpTable.FieldByName('EmlAdr').AsString;
end;

procedure TEasusrTmp.SetEmlAdr(pValue:Str30);
begin
  oTmpTable.FieldByName('EmlAdr').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TEasusrTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TEasusrTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TEasusrTmp.LocUsrLog(pUsrLog:Str8):boolean;
begin
  SetIndex (ixUsrLog);
  Result:=oTmpTable.FindKey([pUsrLog]);
end;

procedure TEasusrTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TEasusrTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TEasusrTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TEasusrTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TEasusrTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TEasusrTmp.First;
begin
  oTmpTable.First;
end;

procedure TEasusrTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TEasusrTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TEasusrTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TEasusrTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TEasusrTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TEasusrTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TEasusrTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TEasusrTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TEasusrTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TEasusrTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TEasusrTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2001001}
