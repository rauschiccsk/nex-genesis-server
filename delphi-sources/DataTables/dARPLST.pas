unit dARPLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoPa='DoPa';
  ixDocNum='DocNum';
  ixParNum='ParNum';
  ixParNam='ParNam';
  ixDocTyp='DocTyp';
  ixBokNum='BokNum';
  ixPrnUsr='PrnUsr';
  ixPrnUsn='PrnUsn';
  ixPrnDte='PrnDte';

type
  TArplstDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetDocNum:Str12;            procedure SetDocNum(pValue:Str12);
    function GetParNum:longint;          procedure SetParNum(pValue:longint);
    function GetParNam:Str60;            procedure SetParNam(pValue:Str60);
    function GetParNam_:Str60;           procedure SetParNam_(pValue:Str60);
    function GetDocTyp:Str2;             procedure SetDocTyp(pValue:Str2);
    function GetBokNum:Str3;             procedure SetBokNum(pValue:Str3);
    function GetPrnUsr:Str15;            procedure SetPrnUsr(pValue:Str15);
    function GetPrnUsn:Str30;            procedure SetPrnUsn(pValue:Str30);
    function GetPrnDte:TDatetime;        procedure SetPrnDte(pValue:TDatetime);
    function GetPrnTim:TDatetime;        procedure SetPrnTim(pValue:TDatetime);
    function GetPrnQnt:word;             procedure SetPrnQnt(pValue:word);
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
    function LocDoPa(pDocNum:Str12;pParNum:longint):boolean;
    function LocDocNum(pDocNum:Str12):boolean;
    function LocParNum(pParNum:longint):boolean;
    function LocParNam(pParNam_:Str60):boolean;
    function LocDocTyp(pDocTyp:Str2):boolean;
    function LocBokNum(pBokNum:Str3):boolean;
    function LocPrnUsr(pPrnUsr:Str15):boolean;
    function LocPrnUsn(pPrnUsn:Str30):boolean;
    function LocPrnDte(pPrnDte:TDatetime):boolean;
    function NearDoPa(pDocNum:Str12;pParNum:longint):boolean;
    function NearDocNum(pDocNum:Str12):boolean;
    function NearParNum(pParNum:longint):boolean;
    function NearParNam(pParNam_:Str60):boolean;
    function NearDocTyp(pDocTyp:Str2):boolean;
    function NearBokNum(pBokNum:Str3):boolean;
    function NearPrnUsr(pPrnUsr:Str15):boolean;
    function NearPrnUsn(pPrnUsn:Str30):boolean;
    function NearPrnDte(pPrnDte:TDatetime):boolean;

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
    property DocNum:Str12 read GetDocNum write SetDocNum;
    property ParNum:longint read GetParNum write SetParNum;
    property ParNam:Str60 read GetParNam write SetParNam;
    property ParNam_:Str60 read GetParNam_ write SetParNam_;
    property DocTyp:Str2 read GetDocTyp write SetDocTyp;
    property BokNum:Str3 read GetBokNum write SetBokNum;
    property PrnUsr:Str15 read GetPrnUsr write SetPrnUsr;
    property PrnUsn:Str30 read GetPrnUsn write SetPrnUsn;
    property PrnDte:TDatetime read GetPrnDte write SetPrnDte;
    property PrnTim:TDatetime read GetPrnTim write SetPrnTim;
    property PrnQnt:word read GetPrnQnt write SetPrnQnt;
  end;

implementation

constructor TArplstDat.Create;
begin
  oTable:=DatInit('ARPLST',gPath.SysPath,Self);
end;

constructor TArplstDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('ARPLST',pPath,Self);
end;

destructor TArplstDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TArplstDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TArplstDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TArplstDat.GetDocNum:Str12;
begin
  Result:=oTable.FieldByName('DocNum').AsString;
end;

procedure TArplstDat.SetDocNum(pValue:Str12);
begin
  oTable.FieldByName('DocNum').AsString:=pValue;
end;

function TArplstDat.GetParNum:longint;
begin
  Result:=oTable.FieldByName('ParNum').AsInteger;
end;

procedure TArplstDat.SetParNum(pValue:longint);
begin
  oTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TArplstDat.GetParNam:Str60;
begin
  Result:=oTable.FieldByName('ParNam').AsString;
end;

procedure TArplstDat.SetParNam(pValue:Str60);
begin
  oTable.FieldByName('ParNam').AsString:=pValue;
end;

function TArplstDat.GetParNam_:Str60;
begin
  Result:=oTable.FieldByName('ParNam_').AsString;
end;

procedure TArplstDat.SetParNam_(pValue:Str60);
begin
  oTable.FieldByName('ParNam_').AsString:=pValue;
end;

function TArplstDat.GetDocTyp:Str2;
begin
  Result:=oTable.FieldByName('DocTyp').AsString;
end;

procedure TArplstDat.SetDocTyp(pValue:Str2);
begin
  oTable.FieldByName('DocTyp').AsString:=pValue;
end;

function TArplstDat.GetBokNum:Str3;
begin
  Result:=oTable.FieldByName('BokNum').AsString;
end;

procedure TArplstDat.SetBokNum(pValue:Str3);
begin
  oTable.FieldByName('BokNum').AsString:=pValue;
end;

function TArplstDat.GetPrnUsr:Str15;
begin
  Result:=oTable.FieldByName('PrnUsr').AsString;
end;

procedure TArplstDat.SetPrnUsr(pValue:Str15);
begin
  oTable.FieldByName('PrnUsr').AsString:=pValue;
end;

function TArplstDat.GetPrnUsn:Str30;
begin
  Result:=oTable.FieldByName('PrnUsn').AsString;
end;

procedure TArplstDat.SetPrnUsn(pValue:Str30);
begin
  oTable.FieldByName('PrnUsn').AsString:=pValue;
end;

function TArplstDat.GetPrnDte:TDatetime;
begin
  Result:=oTable.FieldByName('PrnDte').AsDateTime;
end;

procedure TArplstDat.SetPrnDte(pValue:TDatetime);
begin
  oTable.FieldByName('PrnDte').AsDateTime:=pValue;
end;

function TArplstDat.GetPrnTim:TDatetime;
begin
  Result:=oTable.FieldByName('PrnTim').AsDateTime;
end;

procedure TArplstDat.SetPrnTim(pValue:TDatetime);
begin
  oTable.FieldByName('PrnTim').AsDateTime:=pValue;
end;

function TArplstDat.GetPrnQnt:word;
begin
  Result:=oTable.FieldByName('PrnQnt').AsInteger;
end;

procedure TArplstDat.SetPrnQnt(pValue:word);
begin
  oTable.FieldByName('PrnQnt').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TArplstDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TArplstDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TArplstDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TArplstDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TArplstDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TArplstDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TArplstDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TArplstDat.LocDoPa(pDocNum:Str12;pParNum:longint):boolean;
begin
  SetIndex(ixDoPa);
  Result:=oTable.FindKey([pDocNum,pParNum]);
end;

function TArplstDat.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindKey([pDocNum]);
end;

function TArplstDat.LocParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindKey([pParNum]);
end;

function TArplstDat.LocParNam(pParNam_:Str60):boolean;
begin
  SetIndex(ixParNam);
  Result:=oTable.FindKey([StrToAlias(pParNam_)]);
end;

function TArplstDat.LocDocTyp(pDocTyp:Str2):boolean;
begin
  SetIndex(ixDocTyp);
  Result:=oTable.FindKey([pDocTyp]);
end;

function TArplstDat.LocBokNum(pBokNum:Str3):boolean;
begin
  SetIndex(ixBokNum);
  Result:=oTable.FindKey([pBokNum]);
end;

function TArplstDat.LocPrnUsr(pPrnUsr:Str15):boolean;
begin
  SetIndex(ixPrnUsr);
  Result:=oTable.FindKey([pPrnUsr]);
end;

function TArplstDat.LocPrnUsn(pPrnUsn:Str30):boolean;
begin
  SetIndex(ixPrnUsn);
  Result:=oTable.FindKey([pPrnUsn]);
end;

function TArplstDat.LocPrnDte(pPrnDte:TDatetime):boolean;
begin
  SetIndex(ixPrnDte);
  Result:=oTable.FindKey([pPrnDte]);
end;

function TArplstDat.NearDoPa(pDocNum:Str12;pParNum:longint):boolean;
begin
  SetIndex(ixDoPa);
  Result:=oTable.FindNearest([pDocNum,pParNum]);
end;

function TArplstDat.NearDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindNearest([pDocNum]);
end;

function TArplstDat.NearParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindNearest([pParNum]);
end;

function TArplstDat.NearParNam(pParNam_:Str60):boolean;
begin
  SetIndex(ixParNam);
  Result:=oTable.FindNearest([pParNam_]);
end;

function TArplstDat.NearDocTyp(pDocTyp:Str2):boolean;
begin
  SetIndex(ixDocTyp);
  Result:=oTable.FindNearest([pDocTyp]);
end;

function TArplstDat.NearBokNum(pBokNum:Str3):boolean;
begin
  SetIndex(ixBokNum);
  Result:=oTable.FindNearest([pBokNum]);
end;

function TArplstDat.NearPrnUsr(pPrnUsr:Str15):boolean;
begin
  SetIndex(ixPrnUsr);
  Result:=oTable.FindNearest([pPrnUsr]);
end;

function TArplstDat.NearPrnUsn(pPrnUsn:Str30):boolean;
begin
  SetIndex(ixPrnUsn);
  Result:=oTable.FindNearest([pPrnUsn]);
end;

function TArplstDat.NearPrnDte(pPrnDte:TDatetime):boolean;
begin
  SetIndex(ixPrnDte);
  Result:=oTable.FindNearest([pPrnDte]);
end;

procedure TArplstDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TArplstDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TArplstDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TArplstDat.Prior;
begin
  oTable.Prior;
end;

procedure TArplstDat.Next;
begin
  oTable.Next;
end;

procedure TArplstDat.First;
begin
  Open;
  oTable.First;
end;

procedure TArplstDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TArplstDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TArplstDat.Edit;
begin
  oTable.Edit;
end;

procedure TArplstDat.Post;
begin
  oTable.Post;
end;

procedure TArplstDat.Delete;
begin
  oTable.Delete;
end;

procedure TArplstDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TArplstDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TArplstDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TArplstDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TArplstDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TArplstDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001001}
