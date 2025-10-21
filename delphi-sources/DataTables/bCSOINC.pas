unit bCSOINC;

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
  TCsoincBtr = class (TComponent)
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
    procedure Prior;
    procedure Next;
    procedure First;
    procedure Last;
    procedure Insert;
    procedure Edit;
    procedure Post; virtual;
    procedure Delete;
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
  end;

implementation

constructor TCsoincBtr.Create;
begin
  oBtrTable := BtrInit ('CSOINC',gPath.LdgPath,Self);
end;

constructor TCsoincBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('CSOINC',pPath,Self);
end;

destructor TCsoincBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TCsoincBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TCsoincBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TCsoincBtr.ReadCsoNum:word;
begin
  Result := oBtrTable.FieldByName('CsoNum').AsInteger;
end;

procedure TCsoincBtr.WriteCsoNum(pValue:word);
begin
  oBtrTable.FieldByName('CsoNum').AsInteger := pValue;
end;

function TCsoincBtr.ReadCsoName:Str30;
begin
  Result := oBtrTable.FieldByName('CsoName').AsString;
end;

procedure TCsoincBtr.WriteCsoName(pValue:Str30);
begin
  oBtrTable.FieldByName('CsoName').AsString := pValue;
end;

function TCsoincBtr.ReadCsoName_:Str30;
begin
  Result := oBtrTable.FieldByName('CsoName_').AsString;
end;

procedure TCsoincBtr.WriteCsoName_(pValue:Str30);
begin
  oBtrTable.FieldByName('CsoName_').AsString := pValue;
end;

function TCsoincBtr.ReadVatPrc:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsInteger;
end;

procedure TCsoincBtr.WriteVatPrc(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TCsoincBtr.ReadAccSnt:Str3;
begin
  Result := oBtrTable.FieldByName('AccSnt').AsString;
end;

procedure TCsoincBtr.WriteAccSnt(pValue:Str3);
begin
  oBtrTable.FieldByName('AccSnt').AsString := pValue;
end;

function TCsoincBtr.ReadAccAnl:Str6;
begin
  Result := oBtrTable.FieldByName('AccAnl').AsString;
end;

procedure TCsoincBtr.WriteAccAnl(pValue:Str6);
begin
  oBtrTable.FieldByName('AccAnl').AsString := pValue;
end;

function TCsoincBtr.ReadCrtName:Str8;
begin
  Result := oBtrTable.FieldByName('CrtName').AsString;
end;

procedure TCsoincBtr.WriteCrtName(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtName').AsString := pValue;
end;

function TCsoincBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TCsoincBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TCsoincBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TCsoincBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TCsoincBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TCsoincBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TCsoincBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TCsoincBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TCsoincBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TCsoincBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TCsoincBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TCsoincBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TCsoincBtr.ReadPayVal:double;
begin
  Result := oBtrTable.FieldByName('PayVal').AsFloat;
end;

procedure TCsoincBtr.WritePayVal(pValue:double);
begin
  oBtrTable.FieldByName('PayVal').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCsoincBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCsoincBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TCsoincBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCsoincBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TCsoincBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TCsoincBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TCsoincBtr.LocateCsoNum (pCsoNum:word):boolean;
begin
  SetIndex (ixCsoNum);
  Result := oBtrTable.FindKey([pCsoNum]);
end;

function TCsoincBtr.LocateCsoName (pCsoName_:Str30):boolean;
begin
  SetIndex (ixCsoName);
  Result := oBtrTable.FindKey([StrToAlias(pCsoName_)]);
end;

function TCsoincBtr.LocateSntAnl (pAccSnt:Str3;pAccAnl:Str6):boolean;
begin
  SetIndex (ixSntAnl);
  Result := oBtrTable.FindKey([pAccSnt,pAccAnl]);
end;

function TCsoincBtr.NearestCsoNum (pCsoNum:word):boolean;
begin
  SetIndex (ixCsoNum);
  Result := oBtrTable.FindNearest([pCsoNum]);
end;

function TCsoincBtr.NearestCsoName (pCsoName_:Str30):boolean;
begin
  SetIndex (ixCsoName);
  Result := oBtrTable.FindNearest([pCsoName_]);
end;

function TCsoincBtr.NearestSntAnl (pAccSnt:Str3;pAccAnl:Str6):boolean;
begin
  SetIndex (ixSntAnl);
  Result := oBtrTable.FindNearest([pAccSnt,pAccAnl]);
end;

procedure TCsoincBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TCsoincBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TCsoincBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TCsoincBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TCsoincBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TCsoincBtr.First;
begin
  oBtrTable.First;
end;

procedure TCsoincBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TCsoincBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TCsoincBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TCsoincBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TCsoincBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TCsoincBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TCsoincBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TCsoincBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TCsoincBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TCsoincBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TCsoincBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
