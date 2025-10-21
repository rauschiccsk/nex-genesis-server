unit bSOMLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSerNum = 'SerNum';
  ixDescribe = 'Describe';
  ixSnAn = 'SnAn';
  ixContoNum = 'ContoNum';

type
  TSomlstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSerNum:word;           procedure WriteSerNum (pValue:word);
    function  ReadVarSymb:Str12;         procedure WriteVarSymb (pValue:Str12);
    function  ReadSpcSymb:Str12;         procedure WriteSpcSymb (pValue:Str12);
    function  ReadDescribe:Str30;        procedure WriteDescribe (pValue:Str30);
    function  ReadDescribe_:Str30;       procedure WriteDescribe_ (pValue:Str30);
    function  ReadPayVal:double;         procedure WritePayVal (pValue:double);
    function  ReadContoNum:Str30;        procedure WriteContoNum (pValue:Str30);
    function  ReadBankName:Str30;        procedure WriteBankName (pValue:Str30);
    function  ReadBankCode:Str4;         procedure WriteBankCode (pValue:Str4);
    function  ReadCsyCode:Str4;          procedure WriteCsyCode (pValue:Str4);
    function  ReadAccSnt:Str3;           procedure WriteAccSnt (pValue:Str3);
    function  ReadAccAnl:Str6;           procedure WriteAccAnl (pValue:Str6);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:longint;        procedure WriteModNum (pValue:longint);
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
    function LocateDescribe (pDescribe_:Str30):boolean;
    function LocateSnAn (pAccSnt:Str3;pAccAnl:Str6):boolean;
    function LocateContoNum (pContoNum:Str30):boolean;
    function NearestSerNum (pSerNum:word):boolean;
    function NearestDescribe (pDescribe_:Str30):boolean;
    function NearestSnAn (pAccSnt:Str3;pAccAnl:Str6):boolean;
    function NearestContoNum (pContoNum:Str30):boolean;

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
    property VarSymb:Str12 read ReadVarSymb write WriteVarSymb;
    property SpcSymb:Str12 read ReadSpcSymb write WriteSpcSymb;
    property Describe:Str30 read ReadDescribe write WriteDescribe;
    property Describe_:Str30 read ReadDescribe_ write WriteDescribe_;
    property PayVal:double read ReadPayVal write WritePayVal;
    property ContoNum:Str30 read ReadContoNum write WriteContoNum;
    property BankName:Str30 read ReadBankName write WriteBankName;
    property BankCode:Str4 read ReadBankCode write WriteBankCode;
    property CsyCode:Str4 read ReadCsyCode write WriteCsyCode;
    property AccSnt:Str3 read ReadAccSnt write WriteAccSnt;
    property AccAnl:Str6 read ReadAccAnl write WriteAccAnl;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:longint read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TSomlstBtr.Create;
begin
  oBtrTable := BtrInit ('SOMLST',gPath.StkPath,Self);
end;

constructor TSomlstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('SOMLST',pPath,Self);
end;

destructor TSomlstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TSomlstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TSomlstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TSomlstBtr.ReadSerNum:word;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TSomlstBtr.WriteSerNum(pValue:word);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TSomlstBtr.ReadVarSymb:Str12;
begin
  Result := oBtrTable.FieldByName('VarSymb').AsString;
end;

procedure TSomlstBtr.WriteVarSymb(pValue:Str12);
begin
  oBtrTable.FieldByName('VarSymb').AsString := pValue;
end;

function TSomlstBtr.ReadSpcSymb:Str12;
begin
  Result := oBtrTable.FieldByName('SpcSymb').AsString;
end;

procedure TSomlstBtr.WriteSpcSymb(pValue:Str12);
begin
  oBtrTable.FieldByName('SpcSymb').AsString := pValue;
end;

function TSomlstBtr.ReadDescribe:Str30;
begin
  Result := oBtrTable.FieldByName('Describe').AsString;
end;

procedure TSomlstBtr.WriteDescribe(pValue:Str30);
begin
  oBtrTable.FieldByName('Describe').AsString := pValue;
end;

function TSomlstBtr.ReadDescribe_:Str30;
begin
  Result := oBtrTable.FieldByName('Describe_').AsString;
end;

procedure TSomlstBtr.WriteDescribe_(pValue:Str30);
begin
  oBtrTable.FieldByName('Describe_').AsString := pValue;
end;

function TSomlstBtr.ReadPayVal:double;
begin
  Result := oBtrTable.FieldByName('PayVal').AsFloat;
end;

procedure TSomlstBtr.WritePayVal(pValue:double);
begin
  oBtrTable.FieldByName('PayVal').AsFloat := pValue;
end;

function TSomlstBtr.ReadContoNum:Str30;
begin
  Result := oBtrTable.FieldByName('ContoNum').AsString;
end;

procedure TSomlstBtr.WriteContoNum(pValue:Str30);
begin
  oBtrTable.FieldByName('ContoNum').AsString := pValue;
end;

function TSomlstBtr.ReadBankName:Str30;
begin
  Result := oBtrTable.FieldByName('BankName').AsString;
end;

procedure TSomlstBtr.WriteBankName(pValue:Str30);
begin
  oBtrTable.FieldByName('BankName').AsString := pValue;
end;

function TSomlstBtr.ReadBankCode:Str4;
begin
  Result := oBtrTable.FieldByName('BankCode').AsString;
end;

procedure TSomlstBtr.WriteBankCode(pValue:Str4);
begin
  oBtrTable.FieldByName('BankCode').AsString := pValue;
end;

function TSomlstBtr.ReadCsyCode:Str4;
begin
  Result := oBtrTable.FieldByName('CsyCode').AsString;
end;

procedure TSomlstBtr.WriteCsyCode(pValue:Str4);
begin
  oBtrTable.FieldByName('CsyCode').AsString := pValue;
end;

function TSomlstBtr.ReadAccSnt:Str3;
begin
  Result := oBtrTable.FieldByName('AccSnt').AsString;
end;

procedure TSomlstBtr.WriteAccSnt(pValue:Str3);
begin
  oBtrTable.FieldByName('AccSnt').AsString := pValue;
end;

function TSomlstBtr.ReadAccAnl:Str6;
begin
  Result := oBtrTable.FieldByName('AccAnl').AsString;
end;

procedure TSomlstBtr.WriteAccAnl(pValue:Str6);
begin
  oBtrTable.FieldByName('AccAnl').AsString := pValue;
end;

function TSomlstBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TSomlstBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TSomlstBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TSomlstBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TSomlstBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TSomlstBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TSomlstBtr.ReadModNum:longint;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TSomlstBtr.WriteModNum(pValue:longint);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TSomlstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TSomlstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TSomlstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TSomlstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TSomlstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TSomlstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSomlstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSomlstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TSomlstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSomlstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TSomlstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TSomlstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TSomlstBtr.LocateSerNum (pSerNum:word):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindKey([pSerNum]);
end;

function TSomlstBtr.LocateDescribe (pDescribe_:Str30):boolean;
begin
  SetIndex (ixDescribe);
  Result := oBtrTable.FindKey([StrToAlias(pDescribe_)]);
end;

function TSomlstBtr.LocateSnAn (pAccSnt:Str3;pAccAnl:Str6):boolean;
begin
  SetIndex (ixSnAn);
  Result := oBtrTable.FindKey([pAccSnt,pAccAnl]);
end;

function TSomlstBtr.LocateContoNum (pContoNum:Str30):boolean;
begin
  SetIndex (ixContoNum);
  Result := oBtrTable.FindKey([pContoNum]);
end;

function TSomlstBtr.NearestSerNum (pSerNum:word):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindNearest([pSerNum]);
end;

function TSomlstBtr.NearestDescribe (pDescribe_:Str30):boolean;
begin
  SetIndex (ixDescribe);
  Result := oBtrTable.FindNearest([pDescribe_]);
end;

function TSomlstBtr.NearestSnAn (pAccSnt:Str3;pAccAnl:Str6):boolean;
begin
  SetIndex (ixSnAn);
  Result := oBtrTable.FindNearest([pAccSnt,pAccAnl]);
end;

function TSomlstBtr.NearestContoNum (pContoNum:Str30):boolean;
begin
  SetIndex (ixContoNum);
  Result := oBtrTable.FindNearest([pContoNum]);
end;

procedure TSomlstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TSomlstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TSomlstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TSomlstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TSomlstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TSomlstBtr.First;
begin
  oBtrTable.First;
end;

procedure TSomlstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TSomlstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TSomlstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TSomlstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TSomlstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TSomlstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TSomlstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TSomlstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TSomlstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TSomlstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TSomlstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 2011001}
