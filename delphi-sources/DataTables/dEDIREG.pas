unit dEDIREG;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixParNum='ParNum';
  ixParNam='ParNam';

type
  TEdiregDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetParNum:longint;          procedure SetParNum(pValue:longint);
    function GetParNam:Str60;            procedure SetParNam(pValue:Str60);
    function GetParNam_:Str60;           procedure SetParNam_(pValue:Str60);
    function GetRcvTyp:Str1;             procedure SetRcvTyp(pValue:Str1);
    function GetFtpAdr:Str20;            procedure SetFtpAdr(pValue:Str20);
    function GetFtpUsr:Str20;            procedure SetFtpUsr(pValue:Str20);
    function GetFtpPsw:Str20;            procedure SetFtpPsw(pValue:Str20);
    function GetEdiFrm:word;             procedure SetEdiFrm(pValue:word);
    function GetEdiDes:Str100;           procedure SetEdiDes(pValue:Str100);
    function GetRegIno:Str10;            procedure SetRegIno(pValue:Str10);
  public
    constructor Create(pPath:ShortString); overload;
    // Základné databázové operácie
    function Eof:boolean;
    function IsFirst:boolean;
    function IsLast:boolean;
    function Active:boolean;
    function ActPos:longint;
    function GotoPos(pActPos:longint):boolean;
    function FieldNum(pFieldName:Str20):Str3;
    function LocParNum(pParNum:longint):boolean;
    function LocParNam(pParNam_:Str60):boolean;
    function NearParNum(pParNum:longint):boolean;
    function NearParNam(pParNam_:Str60):boolean;

    procedure SetIndex(pIndexName:Str20);
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
    property Table:TNexBtrTable read oTable;
    property Count:integer read GetCount;
    // Prístup k databázovým poliam
    property ParNum:longint read GetParNum write SetParNum;
    property ParNam:Str60 read GetParNam write SetParNam;
    property ParNam_:Str60 read GetParNam_ write SetParNam_;
    property RcvTyp:Str1 read GetRcvTyp write SetRcvTyp;
    property FtpAdr:Str20 read GetFtpAdr write SetFtpAdr;
    property FtpUsr:Str20 read GetFtpUsr write SetFtpUsr;
    property FtpPsw:Str20 read GetFtpPsw write SetFtpPsw;
    property EdiFrm:word read GetEdiFrm write SetEdiFrm;
    property EdiDes:Str100 read GetEdiDes write SetEdiDes;
    property RegIno:Str10 read GetRegIno write SetRegIno;
  end;

implementation

constructor TEdiregDat.Create;
begin
  oTable:=DatInit('EDIREG',gPath.StkPath,Self);
end;

constructor TEdiregDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('EDIREG',pPath,Self);
end;

destructor TEdiregDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TEdiregDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TEdiregDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TEdiregDat.GetParNum:longint;
begin
  Result:=oTable.FieldByName('ParNum').AsInteger;
end;

procedure TEdiregDat.SetParNum(pValue:longint);
begin
  oTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TEdiregDat.GetParNam:Str60;
begin
  Result:=oTable.FieldByName('ParNam').AsString;
end;

procedure TEdiregDat.SetParNam(pValue:Str60);
begin
  oTable.FieldByName('ParNam').AsString:=pValue;
end;

function TEdiregDat.GetParNam_:Str60;
begin
  Result:=oTable.FieldByName('ParNam_').AsString;
end;

procedure TEdiregDat.SetParNam_(pValue:Str60);
begin
  oTable.FieldByName('ParNam_').AsString:=pValue;
end;

function TEdiregDat.GetRcvTyp:Str1;
begin
  Result:=oTable.FieldByName('RcvTyp').AsString;
end;

procedure TEdiregDat.SetRcvTyp(pValue:Str1);
begin
  oTable.FieldByName('RcvTyp').AsString:=pValue;
end;

function TEdiregDat.GetFtpAdr:Str20;
begin
  Result:=oTable.FieldByName('FtpAdr').AsString;
end;

procedure TEdiregDat.SetFtpAdr(pValue:Str20);
begin
  oTable.FieldByName('FtpAdr').AsString:=pValue;
end;

function TEdiregDat.GetFtpUsr:Str20;
begin
  Result:=oTable.FieldByName('FtpUsr').AsString;
end;

procedure TEdiregDat.SetFtpUsr(pValue:Str20);
begin
  oTable.FieldByName('FtpUsr').AsString:=pValue;
end;

function TEdiregDat.GetFtpPsw:Str20;
begin
  Result:=oTable.FieldByName('FtpPsw').AsString;
end;

procedure TEdiregDat.SetFtpPsw(pValue:Str20);
begin
  oTable.FieldByName('FtpPsw').AsString:=pValue;
end;

function TEdiregDat.GetEdiFrm:word;
begin
  Result:=oTable.FieldByName('EdiFrm').AsInteger;
end;

procedure TEdiregDat.SetEdiFrm(pValue:word);
begin
  oTable.FieldByName('EdiFrm').AsInteger:=pValue;
end;

function TEdiregDat.GetEdiDes:Str100;
begin
  Result:=oTable.FieldByName('EdiDes').AsString;
end;

procedure TEdiregDat.SetEdiDes(pValue:Str100);
begin
  oTable.FieldByName('EdiDes').AsString:=pValue;
end;

function TEdiregDat.GetRegIno:Str10;
begin
  Result:=oTable.FieldByName('RegIno').AsString;
end;

procedure TEdiregDat.SetRegIno(pValue:Str10);
begin
  oTable.FieldByName('RegIno').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TEdiregDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TEdiregDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TEdiregDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TEdiregDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TEdiregDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TEdiregDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TEdiregDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TEdiregDat.LocParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindKey([pParNum]);
end;

function TEdiregDat.LocParNam(pParNam_:Str60):boolean;
begin
  SetIndex(ixParNam);
  Result:=oTable.FindKey([StrToAlias(pParNam_)]);
end;

function TEdiregDat.NearParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindNearest([pParNum]);
end;

function TEdiregDat.NearParNam(pParNam_:Str60):boolean;
begin
  SetIndex(ixParNam);
  Result:=oTable.FindNearest([pParNam_]);
end;

procedure TEdiregDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TEdiregDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TEdiregDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TEdiregDat.Prior;
begin
  oTable.Prior;
end;

procedure TEdiregDat.Next;
begin
  oTable.Next;
end;

procedure TEdiregDat.First;
begin
  Open;
  oTable.First;
end;

procedure TEdiregDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TEdiregDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TEdiregDat.Edit;
begin
  oTable.Edit;
end;

procedure TEdiregDat.Post;
begin
  oTable.Post;
end;

procedure TEdiregDat.Delete;
begin
  oTable.Delete;
end;

procedure TEdiregDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TEdiregDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TEdiregDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TEdiregDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TEdiregDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TEdiregDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
