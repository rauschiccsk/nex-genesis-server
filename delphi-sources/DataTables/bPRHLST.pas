unit bPRHLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = 'DocNum';
  ixSerNum = 'SerNum';
  ixPrjCod = 'PrjCod';
  ixPrjDes = 'PrjDes';

type
  TPrhlstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadBokNum:longint;        procedure WriteBokNum (pValue:longint);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadSerNum:word;           procedure WriteSerNum (pValue:word);
    function  ReadPrjTyp:Str1;           procedure WritePrjTyp (pValue:Str1);
    function  ReadPrjCod:Str20;          procedure WritePrjCod (pValue:Str20);
    function  ReadPrjDes:Str100;         procedure WritePrjDes (pValue:Str100);
    function  ReadPrjDes_:Str50;         procedure WritePrjDes_ (pValue:Str50);
    function  ReadReason:Str100;         procedure WriteReason (pValue:Str100);
    function  ReadResult:Str100;         procedure WriteResult (pValue:Str100);
    function  ReadNotice:Str250;         procedure WriteNotice (pValue:Str250);
    function  ReadPriori:Str1;           procedure WritePriori (pValue:Str1);
    function  ReadIprSta:Str1;           procedure WriteIprSta (pValue:Str1);
    function  ReadRegDat:TDatetime;      procedure WriteRegDat (pValue:TDatetime);
    function  ReadRegTim:TDatetime;      procedure WriteRegTim (pValue:TDatetime);
    function  ReadRegUsr:word;           procedure WriteRegUsr (pValue:word);
    function  ReadRegNam:Str30;          procedure WriteRegNam (pValue:Str30);
    function  ReadMngUsr:word;           procedure WriteMngUsr (pValue:word);
    function  ReadMngNam:Str30;          procedure WriteMngNam (pValue:Str30);
    function  ReadParCod:longint;        procedure WriteParCod (pValue:longint);
    function  ReadParNam:Str60;          procedure WriteParNam (pValue:Str60);
    function  ReadDurati:TDatetime;      procedure WriteDurati (pValue:TDatetime);
    function  ReadPlnDat:TDatetime;      procedure WritePlnDat (pValue:TDatetime);
    function  ReadPlnTim:TDatetime;      procedure WritePlnTim (pValue:TDatetime);
    function  ReadPlnDur:TDatetime;      procedure WritePlnDur (pValue:TDatetime);
    function  ReadReqDat:TDatetime;      procedure WriteReqDat (pValue:TDatetime);
    function  ReadReqTim:TDatetime;      procedure WriteReqTim (pValue:TDatetime);
    function  ReadEndDat:TDatetime;      procedure WriteEndDat (pValue:TDatetime);
    function  ReadEndTim:TDatetime;      procedure WriteEndTim (pValue:TDatetime);
    function  ReadEndDur:TDatetime;      procedure WriteEndDur (pValue:TDatetime);
    function  ReadSprQnt:word;           procedure WriteSprQnt (pValue:word);
    function  ReadJobQnt:word;           procedure WriteJobQnt (pValue:word);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateSerNum (pSerNum:word):boolean;
    function LocatePrjCod (pPrjCod:Str20):boolean;
    function LocatePrjDes (pPrjDes_:Str50):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestSerNum (pSerNum:word):boolean;
    function NearestPrjCod (pPrjCod:Str20):boolean;
    function NearestPrjDes (pPrjDes_:Str50):boolean;

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
    procedure EnableControls;
    procedure DisableControls;
  published
    property BtrTable:TNexBtrTable read oBtrTable;
    property Count:integer read ReadCount;
    // Pristup k databazovym poliam
    property BokNum:longint read ReadBokNum write WriteBokNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property SerNum:word read ReadSerNum write WriteSerNum;
    property PrjTyp:Str1 read ReadPrjTyp write WritePrjTyp;
    property PrjCod:Str20 read ReadPrjCod write WritePrjCod;
    property PrjDes:Str100 read ReadPrjDes write WritePrjDes;
    property PrjDes_:Str50 read ReadPrjDes_ write WritePrjDes_;
    property Reason:Str100 read ReadReason write WriteReason;
    property Result:Str100 read ReadResult write WriteResult;
    property Notice:Str250 read ReadNotice write WriteNotice;
    property Priori:Str1 read ReadPriori write WritePriori;
    property IprSta:Str1 read ReadIprSta write WriteIprSta;
    property RegDat:TDatetime read ReadRegDat write WriteRegDat;
    property RegTim:TDatetime read ReadRegTim write WriteRegTim;
    property RegUsr:word read ReadRegUsr write WriteRegUsr;
    property RegNam:Str30 read ReadRegNam write WriteRegNam;
    property MngUsr:word read ReadMngUsr write WriteMngUsr;
    property MngNam:Str30 read ReadMngNam write WriteMngNam;
    property ParCod:longint read ReadParCod write WriteParCod;
    property ParNam:Str60 read ReadParNam write WriteParNam;
    property Durati:TDatetime read ReadDurati write WriteDurati;
    property PlnDat:TDatetime read ReadPlnDat write WritePlnDat;
    property PlnTim:TDatetime read ReadPlnTim write WritePlnTim;
    property PlnDur:TDatetime read ReadPlnDur write WritePlnDur;
    property ReqDat:TDatetime read ReadReqDat write WriteReqDat;
    property ReqTim:TDatetime read ReadReqTim write WriteReqTim;
    property EndDat:TDatetime read ReadEndDat write WriteEndDat;
    property EndTim:TDatetime read ReadEndTim write WriteEndTim;
    property EndDur:TDatetime read ReadEndDur write WriteEndDur;
    property SprQnt:word read ReadSprQnt write WriteSprQnt;
    property JobQnt:word read ReadJobQnt write WriteJobQnt;
  end;

implementation

constructor TPrhlstBtr.Create;
begin
  oBtrTable := BtrInit ('PRHLST',gPath.MgdPath,Self);
end;

constructor TPrhlstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('PRHLST',pPath,Self);
end;

destructor TPrhlstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPrhlstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPrhlstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPrhlstBtr.ReadBokNum:longint;
begin
  Result := oBtrTable.FieldByName('BokNum').AsInteger;
end;

procedure TPrhlstBtr.WriteBokNum(pValue:longint);
begin
  oBtrTable.FieldByName('BokNum').AsInteger := pValue;
end;

function TPrhlstBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TPrhlstBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TPrhlstBtr.ReadSerNum:word;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TPrhlstBtr.WriteSerNum(pValue:word);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TPrhlstBtr.ReadPrjTyp:Str1;
begin
  Result := oBtrTable.FieldByName('PrjTyp').AsString;
end;

procedure TPrhlstBtr.WritePrjTyp(pValue:Str1);
begin
  oBtrTable.FieldByName('PrjTyp').AsString := pValue;
end;

function TPrhlstBtr.ReadPrjCod:Str20;
begin
  Result := oBtrTable.FieldByName('PrjCod').AsString;
end;

procedure TPrhlstBtr.WritePrjCod(pValue:Str20);
begin
  oBtrTable.FieldByName('PrjCod').AsString := pValue;
end;

function TPrhlstBtr.ReadPrjDes:Str100;
begin
  Result := oBtrTable.FieldByName('PrjDes').AsString;
end;

procedure TPrhlstBtr.WritePrjDes(pValue:Str100);
begin
  oBtrTable.FieldByName('PrjDes').AsString := pValue;
end;

function TPrhlstBtr.ReadPrjDes_:Str50;
begin
  Result := oBtrTable.FieldByName('PrjDes_').AsString;
end;

procedure TPrhlstBtr.WritePrjDes_(pValue:Str50);
begin
  oBtrTable.FieldByName('PrjDes_').AsString := pValue;
end;

function TPrhlstBtr.ReadReason:Str100;
begin
  Result := oBtrTable.FieldByName('Reason').AsString;
end;

procedure TPrhlstBtr.WriteReason(pValue:Str100);
begin
  oBtrTable.FieldByName('Reason').AsString := pValue;
end;

function TPrhlstBtr.ReadResult:Str100;
begin
  Result := oBtrTable.FieldByName('Result').AsString;
end;

procedure TPrhlstBtr.WriteResult(pValue:Str100);
begin
  oBtrTable.FieldByName('Result').AsString := pValue;
end;

function TPrhlstBtr.ReadNotice:Str250;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TPrhlstBtr.WriteNotice(pValue:Str250);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

function TPrhlstBtr.ReadPriori:Str1;
begin
  Result := oBtrTable.FieldByName('Priori').AsString;
end;

procedure TPrhlstBtr.WritePriori(pValue:Str1);
begin
  oBtrTable.FieldByName('Priori').AsString := pValue;
end;

function TPrhlstBtr.ReadIprSta:Str1;
begin
  Result := oBtrTable.FieldByName('IprSta').AsString;
end;

procedure TPrhlstBtr.WriteIprSta(pValue:Str1);
begin
  oBtrTable.FieldByName('IprSta').AsString := pValue;
end;

function TPrhlstBtr.ReadRegDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('RegDat').AsDateTime;
end;

procedure TPrhlstBtr.WriteRegDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('RegDat').AsDateTime := pValue;
end;

function TPrhlstBtr.ReadRegTim:TDatetime;
begin
  Result := oBtrTable.FieldByName('RegTim').AsDateTime;
end;

procedure TPrhlstBtr.WriteRegTim(pValue:TDatetime);
begin
  oBtrTable.FieldByName('RegTim').AsDateTime := pValue;
end;

function TPrhlstBtr.ReadRegUsr:word;
begin
  Result := oBtrTable.FieldByName('RegUsr').AsInteger;
end;

procedure TPrhlstBtr.WriteRegUsr(pValue:word);
begin
  oBtrTable.FieldByName('RegUsr').AsInteger := pValue;
end;

function TPrhlstBtr.ReadRegNam:Str30;
begin
  Result := oBtrTable.FieldByName('RegNam').AsString;
end;

procedure TPrhlstBtr.WriteRegNam(pValue:Str30);
begin
  oBtrTable.FieldByName('RegNam').AsString := pValue;
end;

function TPrhlstBtr.ReadMngUsr:word;
begin
  Result := oBtrTable.FieldByName('MngUsr').AsInteger;
end;

procedure TPrhlstBtr.WriteMngUsr(pValue:word);
begin
  oBtrTable.FieldByName('MngUsr').AsInteger := pValue;
end;

function TPrhlstBtr.ReadMngNam:Str30;
begin
  Result := oBtrTable.FieldByName('MngNam').AsString;
end;

procedure TPrhlstBtr.WriteMngNam(pValue:Str30);
begin
  oBtrTable.FieldByName('MngNam').AsString := pValue;
end;

function TPrhlstBtr.ReadParCod:longint;
begin
  Result := oBtrTable.FieldByName('ParCod').AsInteger;
end;

procedure TPrhlstBtr.WriteParCod(pValue:longint);
begin
  oBtrTable.FieldByName('ParCod').AsInteger := pValue;
end;

function TPrhlstBtr.ReadParNam:Str60;
begin
  Result := oBtrTable.FieldByName('ParNam').AsString;
end;

procedure TPrhlstBtr.WriteParNam(pValue:Str60);
begin
  oBtrTable.FieldByName('ParNam').AsString := pValue;
end;

function TPrhlstBtr.ReadDurati:TDatetime;
begin
  Result := oBtrTable.FieldByName('Durati').AsDateTime;
end;

procedure TPrhlstBtr.WriteDurati(pValue:TDatetime);
begin
  oBtrTable.FieldByName('Durati').AsDateTime := pValue;
end;

function TPrhlstBtr.ReadPlnDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('PlnDat').AsDateTime;
end;

procedure TPrhlstBtr.WritePlnDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('PlnDat').AsDateTime := pValue;
end;

function TPrhlstBtr.ReadPlnTim:TDatetime;
begin
  Result := oBtrTable.FieldByName('PlnTim').AsDateTime;
end;

procedure TPrhlstBtr.WritePlnTim(pValue:TDatetime);
begin
  oBtrTable.FieldByName('PlnTim').AsDateTime := pValue;
end;

function TPrhlstBtr.ReadPlnDur:TDatetime;
begin
  Result := oBtrTable.FieldByName('PlnDur').AsDateTime;
end;

procedure TPrhlstBtr.WritePlnDur(pValue:TDatetime);
begin
  oBtrTable.FieldByName('PlnDur').AsDateTime := pValue;
end;

function TPrhlstBtr.ReadReqDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('ReqDat').AsDateTime;
end;

procedure TPrhlstBtr.WriteReqDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ReqDat').AsDateTime := pValue;
end;

function TPrhlstBtr.ReadReqTim:TDatetime;
begin
  Result := oBtrTable.FieldByName('ReqTim').AsDateTime;
end;

procedure TPrhlstBtr.WriteReqTim(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ReqTim').AsDateTime := pValue;
end;

function TPrhlstBtr.ReadEndDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndDat').AsDateTime;
end;

procedure TPrhlstBtr.WriteEndDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndDat').AsDateTime := pValue;
end;

function TPrhlstBtr.ReadEndTim:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndTim').AsDateTime;
end;

procedure TPrhlstBtr.WriteEndTim(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndTim').AsDateTime := pValue;
end;

function TPrhlstBtr.ReadEndDur:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndDur').AsDateTime;
end;

procedure TPrhlstBtr.WriteEndDur(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndDur').AsDateTime := pValue;
end;

function TPrhlstBtr.ReadSprQnt:word;
begin
  Result := oBtrTable.FieldByName('SprQnt').AsInteger;
end;

procedure TPrhlstBtr.WriteSprQnt(pValue:word);
begin
  oBtrTable.FieldByName('SprQnt').AsInteger := pValue;
end;

function TPrhlstBtr.ReadJobQnt:word;
begin
  Result := oBtrTable.FieldByName('JobQnt').AsInteger;
end;

procedure TPrhlstBtr.WriteJobQnt(pValue:word);
begin
  oBtrTable.FieldByName('JobQnt').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPrhlstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPrhlstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TPrhlstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPrhlstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPrhlstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPrhlstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPrhlstBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TPrhlstBtr.LocateSerNum (pSerNum:word):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindKey([pSerNum]);
end;

function TPrhlstBtr.LocatePrjCod (pPrjCod:Str20):boolean;
begin
  SetIndex (ixPrjCod);
  Result := oBtrTable.FindKey([pPrjCod]);
end;

function TPrhlstBtr.LocatePrjDes (pPrjDes_:Str50):boolean;
begin
  SetIndex (ixPrjDes);
  Result := oBtrTable.FindKey([StrToAlias(pPrjDes_)]);
end;

function TPrhlstBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TPrhlstBtr.NearestSerNum (pSerNum:word):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindNearest([pSerNum]);
end;

function TPrhlstBtr.NearestPrjCod (pPrjCod:Str20):boolean;
begin
  SetIndex (ixPrjCod);
  Result := oBtrTable.FindNearest([pPrjCod]);
end;

function TPrhlstBtr.NearestPrjDes (pPrjDes_:Str50):boolean;
begin
  SetIndex (ixPrjDes);
  Result := oBtrTable.FindNearest([pPrjDes_]);
end;

procedure TPrhlstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPrhlstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TPrhlstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPrhlstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPrhlstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPrhlstBtr.First;
begin
  oBtrTable.First;
end;

procedure TPrhlstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPrhlstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPrhlstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPrhlstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPrhlstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPrhlstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPrhlstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPrhlstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPrhlstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPrhlstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPrhlstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1930001}
