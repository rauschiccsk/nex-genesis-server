unit bCSOEXP;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixCsoNum = 'CsoNum';
  ixCsoName = 'CsoName';
  ixSntAnl = 'SntAnl';

type
  TCsoexpBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadCsoNum:word;           procedure WriteCsoNum (pValue:word);
    function  ReadCsoName:Str30;         procedure WriteCsoName (pValue:Str30);
    function  ReadCsoName_:Str30;        procedure WriteCsoName_ (pValue:Str30);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadAccSnt:Str3;           procedure WriteAccSnt (pValue:Str3);
    function  ReadAccAnl:Str6;           procedure WriteAccAnl (pValue:Str6);
    function  ReadCrtName:Str8;          procedure WriteCrtName (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadPayVal:double;         procedure WritePayVal (pValue:double);
    function  ReadNvaPrc:double;         procedure WriteNvaPrc (pValue:double);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateCsoNum (pCsoNum:word):boolean;
    function LocateCsoName (pCsoName_:Str30):boolean;
    function LocateSntAnl (pAccSnt:Str3;pAccAnl:Str6):boolean;
    function NearestCsoNum (pCsoNum:word):boolean;
    function NearestCsoName (pCsoName_:Str30):boolean;
    function NearestSntAnl (pAccSnt:Str3;pAccAnl:Str6):boolean;

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
    property CsoNum:word read ReadCsoNum write WriteCsoNum;
    property CsoName:Str30 read ReadCsoName write WriteCsoName;
    property CsoName_:Str30 read ReadCsoName_ write WriteCsoName_;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property AccSnt:Str3 read ReadAccSnt write WriteAccSnt;
    property AccAnl:Str6 read ReadAccAnl write WriteAccAnl;
    property CrtName:Str8 read ReadCrtName write WriteCrtName;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property PayVal:double read ReadPayVal write WritePayVal;
    property NvaPrc:double read ReadNvaPrc write WriteNvaPrc;
  end;

implementation

constructor TCsoexpBtr.Create;
begin
  oBtrTable := BtrInit ('CSOEXP',gPath.LdgPath,Self);
end;

constructor TCsoexpBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('CSOEXP',pPath,Self);
end;

destructor TCsoexpBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TCsoexpBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TCsoexpBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TCsoexpBtr.ReadCsoNum:word;
begin
  Result := oBtrTable.FieldByName('CsoNum').AsInteger;
end;

procedure TCsoexpBtr.WriteCsoNum(pValue:word);
begin
  oBtrTable.FieldByName('CsoNum').AsInteger := pValue;
end;

function TCsoexpBtr.ReadCsoName:Str30;
begin
  Result := oBtrTable.FieldByName('CsoName').AsString;
end;

procedure TCsoexpBtr.WriteCsoName(pValue:Str30);
begin
  oBtrTable.FieldByName('CsoName').AsString := pValue;
end;

function TCsoexpBtr.ReadCsoName_:Str30;
begin
  Result := oBtrTable.FieldByName('CsoName_').AsString;
end;

procedure TCsoexpBtr.WriteCsoName_(pValue:Str30);
begin
  oBtrTable.FieldByName('CsoName_').AsString := pValue;
end;

function TCsoexpBtr.ReadVatPrc:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsInteger;
end;

procedure TCsoexpBtr.WriteVatPrc(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TCsoexpBtr.ReadAccSnt:Str3;
begin
  Result := oBtrTable.FieldByName('AccSnt').AsString;
end;

procedure TCsoexpBtr.WriteAccSnt(pValue:Str3);
begin
  oBtrTable.FieldByName('AccSnt').AsString := pValue;
end;

function TCsoexpBtr.ReadAccAnl:Str6;
begin
  Result := oBtrTable.FieldByName('AccAnl').AsString;
end;

procedure TCsoexpBtr.WriteAccAnl(pValue:Str6);
begin
  oBtrTable.FieldByName('AccAnl').AsString := pValue;
end;

function TCsoexpBtr.ReadCrtName:Str8;
begin
  Result := oBtrTable.FieldByName('CrtName').AsString;
end;

procedure TCsoexpBtr.WriteCrtName(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtName').AsString := pValue;
end;

function TCsoexpBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TCsoexpBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TCsoexpBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TCsoexpBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TCsoexpBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TCsoexpBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TCsoexpBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TCsoexpBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TCsoexpBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TCsoexpBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TCsoexpBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TCsoexpBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TCsoexpBtr.ReadPayVal:double;
begin
  Result := oBtrTable.FieldByName('PayVal').AsFloat;
end;

procedure TCsoexpBtr.WritePayVal(pValue:double);
begin
  oBtrTable.FieldByName('PayVal').AsFloat := pValue;
end;

function TCsoexpBtr.ReadNvaPrc:double;
begin
  Result := oBtrTable.FieldByName('NvaPrc').AsFloat;
end;

procedure TCsoexpBtr.WriteNvaPrc(pValue:double);
begin
  oBtrTable.FieldByName('NvaPrc').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCsoexpBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCsoexpBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TCsoexpBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCsoexpBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TCsoexpBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TCsoexpBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TCsoexpBtr.LocateCsoNum (pCsoNum:word):boolean;
begin
  SetIndex (ixCsoNum);
  Result := oBtrTable.FindKey([pCsoNum]);
end;

function TCsoexpBtr.LocateCsoName (pCsoName_:Str30):boolean;
begin
  SetIndex (ixCsoName);
  Result := oBtrTable.FindKey([StrToAlias(pCsoName_)]);
end;

function TCsoexpBtr.LocateSntAnl (pAccSnt:Str3;pAccAnl:Str6):boolean;
begin
  SetIndex (ixSntAnl);
  Result := oBtrTable.FindKey([pAccSnt,pAccAnl]);
end;

function TCsoexpBtr.NearestCsoNum (pCsoNum:word):boolean;
begin
  SetIndex (ixCsoNum);
  Result := oBtrTable.FindNearest([pCsoNum]);
end;

function TCsoexpBtr.NearestCsoName (pCsoName_:Str30):boolean;
begin
  SetIndex (ixCsoName);
  Result := oBtrTable.FindNearest([pCsoName_]);
end;

function TCsoexpBtr.NearestSntAnl (pAccSnt:Str3;pAccAnl:Str6):boolean;
begin
  SetIndex (ixSntAnl);
  Result := oBtrTable.FindNearest([pAccSnt,pAccAnl]);
end;

procedure TCsoexpBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TCsoexpBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TCsoexpBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TCsoexpBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TCsoexpBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TCsoexpBtr.First;
begin
  oBtrTable.First;
end;

procedure TCsoexpBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TCsoexpBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TCsoexpBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TCsoexpBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TCsoexpBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TCsoexpBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TCsoexpBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TCsoexpBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TCsoexpBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TCsoexpBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TCsoexpBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 2011001}
