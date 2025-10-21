unit bMCRLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSerNum = 'SerNum';
  ixMcrName = 'McrName';

type
  TMcrlstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSerNum:word;           procedure WriteSerNum (pValue:word);
    function  ReadMcrName:Str30;         procedure WriteMcrName (pValue:Str30);
    function  ReadMcrName_:Str30;        procedure WriteMcrName_ (pValue:Str30);
    function  ReadAPrice:double;         procedure WriteAPrice (pValue:double);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadCrtName:Str8;          procedure WriteCrtName (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateSerNum (pSerNum:word):boolean;
    function LocateMcrName (pMcrName_:Str30):boolean;
    function NearestSerNum (pSerNum:word):boolean;
    function NearestMcrName (pMcrName_:Str30):boolean;

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
    property SerNum:word read ReadSerNum write WriteSerNum;
    property McrName:Str30 read ReadMcrName write WriteMcrName;
    property McrName_:Str30 read ReadMcrName_ write WriteMcrName_;
    property APrice:double read ReadAPrice write WriteAPrice;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property CrtName:Str8 read ReadCrtName write WriteCrtName;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TMcrlstBtr.Create;
begin
  oBtrTable := BtrInit ('MCRLST',gPath.StkPath,Self);
end;

constructor TMcrlstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('MCRLST',pPath,Self);
end;

destructor TMcrlstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TMcrlstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TMcrlstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TMcrlstBtr.ReadSerNum:word;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TMcrlstBtr.WriteSerNum(pValue:word);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TMcrlstBtr.ReadMcrName:Str30;
begin
  Result := oBtrTable.FieldByName('McrName').AsString;
end;

procedure TMcrlstBtr.WriteMcrName(pValue:Str30);
begin
  oBtrTable.FieldByName('McrName').AsString := pValue;
end;

function TMcrlstBtr.ReadMcrName_:Str30;
begin
  Result := oBtrTable.FieldByName('McrName_').AsString;
end;

procedure TMcrlstBtr.WriteMcrName_(pValue:Str30);
begin
  oBtrTable.FieldByName('McrName_').AsString := pValue;
end;

function TMcrlstBtr.ReadAPrice:double;
begin
  Result := oBtrTable.FieldByName('APrice').AsFloat;
end;

procedure TMcrlstBtr.WriteAPrice(pValue:double);
begin
  oBtrTable.FieldByName('APrice').AsFloat := pValue;
end;

function TMcrlstBtr.ReadVatPrc:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsInteger;
end;

procedure TMcrlstBtr.WriteVatPrc(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TMcrlstBtr.ReadCrtName:Str8;
begin
  Result := oBtrTable.FieldByName('CrtName').AsString;
end;

procedure TMcrlstBtr.WriteCrtName(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtName').AsString := pValue;
end;

function TMcrlstBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TMcrlstBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TMcrlstBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TMcrlstBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TMcrlstBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TMcrlstBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TMcrlstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TMcrlstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TMcrlstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TMcrlstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TMcrlstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TMcrlstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TMcrlstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TMcrlstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TMcrlstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TMcrlstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TMcrlstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TMcrlstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TMcrlstBtr.LocateSerNum (pSerNum:word):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindKey([pSerNum]);
end;

function TMcrlstBtr.LocateMcrName (pMcrName_:Str30):boolean;
begin
  SetIndex (ixMcrName);
  Result := oBtrTable.FindKey([StrToAlias(pMcrName_)]);
end;

function TMcrlstBtr.NearestSerNum (pSerNum:word):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindNearest([pSerNum]);
end;

function TMcrlstBtr.NearestMcrName (pMcrName_:Str30):boolean;
begin
  SetIndex (ixMcrName);
  Result := oBtrTable.FindNearest([pMcrName_]);
end;

procedure TMcrlstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TMcrlstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TMcrlstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TMcrlstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TMcrlstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TMcrlstBtr.First;
begin
  oBtrTable.First;
end;

procedure TMcrlstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TMcrlstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TMcrlstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TMcrlstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TMcrlstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TMcrlstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TMcrlstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TMcrlstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TMcrlstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TMcrlstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TMcrlstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
