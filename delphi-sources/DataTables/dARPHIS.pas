unit dARPHIS;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDnPaPn='DnPaPn';
  ixDocNum='DocNum';
  ixDocTyp='DocTyp';
  ixBokNum='BokNum';
  ixParNum='ParNum';
  ixPdfSta='PdfSta';
  ixPrnUsr='PrnUsr';

type
  TArphisDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetDocNum:Str12;            procedure SetDocNum(pValue:Str12);
    function GetParNum:longint;          procedure SetParNum(pValue:longint);
    function GetPrnNum:word;             procedure SetPrnNum(pValue:word);
    function GetRepNam:Str8;             procedure SetRepNam(pValue:Str8);
    function GetRepVer:Str3;             procedure SetRepVer(pValue:Str3);
    function GetRepDes:Str60;            procedure SetRepDes(pValue:Str60);
    function GetDocTyp:Str3;             procedure SetDocTyp(pValue:Str3);
    function GetBokNum:Str3;             procedure SetBokNum(pValue:Str3);
    function GetPdfNam:Str30;            procedure SetPdfNam(pValue:Str30);
    function GetPdfSta:Str1;             procedure SetPdfSta(pValue:Str1);
    function GetPrnUsr:Str15;            procedure SetPrnUsr(pValue:Str15);
    function GetPrnUsn:Str30;            procedure SetPrnUsn(pValue:Str30);
    function GetPrnDte:TDatetime;        procedure SetPrnDte(pValue:TDatetime);
    function GetPrnTim:TDatetime;        procedure SetPrnTim(pValue:TDatetime);
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
    function LocDnPaPn(pDocNum:Str12;pParNum:longint;pPrnNum:word):boolean;
    function LocDocNum(pDocNum:Str12):boolean;
    function LocDocTyp(pDocTyp:Str3):boolean;
    function LocBokNum(pBokNum:Str3):boolean;
    function LocParNum(pParNum:longint):boolean;
    function LocPdfSta(pPdfSta:Str1):boolean;
    function LocPrnUsr(pPrnUsr:Str15):boolean;
    function NearDnPaPn(pDocNum:Str12;pParNum:longint;pPrnNum:word):boolean;
    function NearDocNum(pDocNum:Str12):boolean;
    function NearDocTyp(pDocTyp:Str3):boolean;
    function NearBokNum(pBokNum:Str3):boolean;
    function NearParNum(pParNum:longint):boolean;
    function NearPdfSta(pPdfSta:Str1):boolean;
    function NearPrnUsr(pPrnUsr:Str15):boolean;

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
    property PrnNum:word read GetPrnNum write SetPrnNum;
    property RepNam:Str8 read GetRepNam write SetRepNam;
    property RepVer:Str3 read GetRepVer write SetRepVer;
    property RepDes:Str60 read GetRepDes write SetRepDes;
    property DocTyp:Str3 read GetDocTyp write SetDocTyp;
    property BokNum:Str3 read GetBokNum write SetBokNum;
    property PdfNam:Str30 read GetPdfNam write SetPdfNam;            
    property PdfSta:Str1 read GetPdfSta write SetPdfSta;
    property PrnUsr:Str15 read GetPrnUsr write SetPrnUsr;
    property PrnUsn:Str30 read GetPrnUsn write SetPrnUsn;
    property PrnDte:TDatetime read GetPrnDte write SetPrnDte;
    property PrnTim:TDatetime read GetPrnTim write SetPrnTim;
  end;

implementation

constructor TArphisDat.Create;
begin
  oTable:=DatInit('ARPHIS',gPath.SysPath,Self);
end;

constructor TArphisDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('ARPHIS',pPath,Self);
end;

destructor TArphisDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TArphisDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TArphisDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TArphisDat.GetDocNum:Str12;
begin
  Result:=oTable.FieldByName('DocNum').AsString;
end;

procedure TArphisDat.SetDocNum(pValue:Str12);
begin
  oTable.FieldByName('DocNum').AsString:=pValue;
end;

function TArphisDat.GetParNum:longint;
begin
  Result:=oTable.FieldByName('ParNum').AsInteger;
end;

procedure TArphisDat.SetParNum(pValue:longint);
begin
  oTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TArphisDat.GetPrnNum:word;
begin
  Result:=oTable.FieldByName('PrnNum').AsInteger;
end;

procedure TArphisDat.SetPrnNum(pValue:word);
begin
  oTable.FieldByName('PrnNum').AsInteger:=pValue;
end;

function TArphisDat.GetRepNam:Str8;
begin
  Result:=oTable.FieldByName('RepNam').AsString;
end;

procedure TArphisDat.SetRepNam(pValue:Str8);
begin
  oTable.FieldByName('RepNam').AsString:=pValue;
end;

function TArphisDat.GetRepVer:Str3;
begin
  Result:=oTable.FieldByName('RepVer').AsString;
end;

procedure TArphisDat.SetRepVer(pValue:Str3);
begin
  oTable.FieldByName('RepVer').AsString:=pValue;
end;

function TArphisDat.GetRepDes:Str60;
begin
  Result:=oTable.FieldByName('RepDes').AsString;
end;

procedure TArphisDat.SetRepDes(pValue:Str60);
begin
  oTable.FieldByName('RepDes').AsString:=pValue;
end;

function TArphisDat.GetDocTyp:Str3;
begin
  Result:=oTable.FieldByName('DocTyp').AsString;
end;

procedure TArphisDat.SetDocTyp(pValue:Str3);
begin
  oTable.FieldByName('DocTyp').AsString:=pValue;
end;

function TArphisDat.GetBokNum:Str3;
begin
  Result:=oTable.FieldByName('BokNum').AsString;
end;

procedure TArphisDat.SetBokNum(pValue:Str3);
begin
  oTable.FieldByName('BokNum').AsString:=pValue;
end;

function TArphisDat.GetPdfNam:Str30;
begin
  Result:=oTable.FieldByName('PdfNam').AsString;
end;

procedure TArphisDat.SetPdfNam(pValue:Str30);
begin
  oTable.FieldByName('PdfNam').AsString:=pValue;
end;

function TArphisDat.GetPdfSta:Str1;
begin
  Result:=oTable.FieldByName('PdfSta').AsString;
end;

procedure TArphisDat.SetPdfSta(pValue:Str1);
begin
  oTable.FieldByName('PdfSta').AsString:=pValue;
end;

function TArphisDat.GetPrnUsr:Str15;
begin
  Result:=oTable.FieldByName('PrnUsr').AsString;
end;

procedure TArphisDat.SetPrnUsr(pValue:Str15);
begin
  oTable.FieldByName('PrnUsr').AsString:=pValue;
end;

function TArphisDat.GetPrnUsn:Str30;
begin
  Result:=oTable.FieldByName('PrnUsn').AsString;
end;

procedure TArphisDat.SetPrnUsn(pValue:Str30);
begin
  oTable.FieldByName('PrnUsn').AsString:=pValue;
end;

function TArphisDat.GetPrnDte:TDatetime;
begin
  Result:=oTable.FieldByName('PrnDte').AsDateTime;
end;

procedure TArphisDat.SetPrnDte(pValue:TDatetime);
begin
  oTable.FieldByName('PrnDte').AsDateTime:=pValue;
end;

function TArphisDat.GetPrnTim:TDatetime;
begin
  Result:=oTable.FieldByName('PrnTim').AsDateTime;
end;

procedure TArphisDat.SetPrnTim(pValue:TDatetime);
begin
  oTable.FieldByName('PrnTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TArphisDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TArphisDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TArphisDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TArphisDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TArphisDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TArphisDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TArphisDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TArphisDat.LocDnPaPn(pDocNum:Str12;pParNum:longint;pPrnNum:word):boolean;
begin
  SetIndex(ixDnPaPn);
  Result:=oTable.FindKey([pDocNum,pParNum,pPrnNum]);
end;

function TArphisDat.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindKey([pDocNum]);
end;

function TArphisDat.LocDocTyp(pDocTyp:Str3):boolean;
begin
  SetIndex(ixDocTyp);
  Result:=oTable.FindKey([pDocTyp]);
end;

function TArphisDat.LocBokNum(pBokNum:Str3):boolean;
begin
  SetIndex(ixBokNum);
  Result:=oTable.FindKey([pBokNum]);
end;

function TArphisDat.LocParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindKey([pParNum]);
end;

function TArphisDat.LocPdfSta(pPdfSta:Str1):boolean;
begin
  SetIndex(ixPdfSta);
  Result:=oTable.FindKey([pPdfSta]);
end;

function TArphisDat.LocPrnUsr(pPrnUsr:Str15):boolean;
begin
  SetIndex(ixPrnUsr);
  Result:=oTable.FindKey([pPrnUsr]);
end;

function TArphisDat.NearDnPaPn(pDocNum:Str12;pParNum:longint;pPrnNum:word):boolean;
begin
  SetIndex(ixDnPaPn);
  Result:=oTable.FindNearest([pDocNum,pParNum,pPrnNum]);
end;

function TArphisDat.NearDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindNearest([pDocNum]);
end;

function TArphisDat.NearDocTyp(pDocTyp:Str3):boolean;
begin
  SetIndex(ixDocTyp);
  Result:=oTable.FindNearest([pDocTyp]);
end;

function TArphisDat.NearBokNum(pBokNum:Str3):boolean;
begin
  SetIndex(ixBokNum);
  Result:=oTable.FindNearest([pBokNum]);
end;

function TArphisDat.NearParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindNearest([pParNum]);
end;

function TArphisDat.NearPdfSta(pPdfSta:Str1):boolean;
begin
  SetIndex(ixPdfSta);
  Result:=oTable.FindNearest([pPdfSta]);
end;

function TArphisDat.NearPrnUsr(pPrnUsr:Str15):boolean;
begin
  SetIndex(ixPrnUsr);
  Result:=oTable.FindNearest([pPrnUsr]);
end;

procedure TArphisDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TArphisDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TArphisDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TArphisDat.Prior;
begin
  oTable.Prior;
end;

procedure TArphisDat.Next;
begin
  oTable.Next;
end;

procedure TArphisDat.First;
begin
  Open;
  oTable.First;
end;

procedure TArphisDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TArphisDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TArphisDat.Edit;
begin
  oTable.Edit;
end;

procedure TArphisDat.Post;
begin
  oTable.Post;
end;

procedure TArphisDat.Delete;
begin
  oTable.Delete;
end;

procedure TArphisDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TArphisDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TArphisDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TArphisDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TArphisDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TArphisDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001001}
