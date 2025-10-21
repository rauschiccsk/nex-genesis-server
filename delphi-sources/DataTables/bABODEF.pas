unit bABODEF;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixCsPsNo = 'CsPsNo';
  ixCoSymb = 'CoSymb';

type
  TAbodefBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadCoSymb:Str20;          procedure WriteCoSymb (pValue:Str20);
    function  ReadPySign:Str1;           procedure WritePySign (pValue:Str1);
    function  ReadNotice:Str30;          procedure WriteNotice (pValue:Str30);
    function  ReadSpSymb:Str20;          procedure WriteSpSymb (pValue:Str20);
    function  ReadVaSymb:Str20;          procedure WriteVaSymb (pValue:Str20);
    function  ReadAccTxt:Str30;          procedure WriteAccTxt (pValue:Str30);
    function  ReadAccSnt:Str3;           procedure WriteAccSnt (pValue:Str3);
    function  ReadAccAnl:Str6;           procedure WriteAccAnl (pValue:Str6);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
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
    function LocateCsPsNo (pCoSymb:Str20;pPySign:Str1;pNotice:Str30):boolean;
    function LocateCoSymb (pCoSymb:Str20):boolean;
    function NearestCsPsNo (pCoSymb:Str20;pPySign:Str1;pNotice:Str30):boolean;
    function NearestCoSymb (pCoSymb:Str20):boolean;

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
    property CoSymb:Str20 read ReadCoSymb write WriteCoSymb;
    property PySign:Str1 read ReadPySign write WritePySign;
    property Notice:Str30 read ReadNotice write WriteNotice;
    property SpSymb:Str20 read ReadSpSymb write WriteSpSymb;
    property VaSymb:Str20 read ReadVaSymb write WriteVaSymb;
    property AccTxt:Str30 read ReadAccTxt write WriteAccTxt;
    property AccSnt:Str3 read ReadAccSnt write WriteAccSnt;
    property AccAnl:Str6 read ReadAccAnl write WriteAccAnl;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TAbodefBtr.Create;
begin
  oBtrTable := BtrInit ('ABODEF',gPath.LdgPath,Self);
end;

constructor TAbodefBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('ABODEF',pPath,Self);
end;

destructor TAbodefBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TAbodefBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TAbodefBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TAbodefBtr.ReadCoSymb:Str20;
begin
  Result := oBtrTable.FieldByName('CoSymb').AsString;
end;

procedure TAbodefBtr.WriteCoSymb(pValue:Str20);
begin
  oBtrTable.FieldByName('CoSymb').AsString := pValue;
end;

function TAbodefBtr.ReadPySign:Str1;
begin
  Result := oBtrTable.FieldByName('PySign').AsString;
end;

procedure TAbodefBtr.WritePySign(pValue:Str1);
begin
  oBtrTable.FieldByName('PySign').AsString := pValue;
end;

function TAbodefBtr.ReadNotice:Str30;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TAbodefBtr.WriteNotice(pValue:Str30);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

function TAbodefBtr.ReadSpSymb:Str20;
begin
  Result := oBtrTable.FieldByName('SpSymb').AsString;
end;

procedure TAbodefBtr.WriteSpSymb(pValue:Str20);
begin
  oBtrTable.FieldByName('SpSymb').AsString := pValue;
end;

function TAbodefBtr.ReadVaSymb:Str20;
begin
  Result := oBtrTable.FieldByName('VaSymb').AsString;
end;

procedure TAbodefBtr.WriteVaSymb(pValue:Str20);
begin
  oBtrTable.FieldByName('VaSymb').AsString := pValue;
end;

function TAbodefBtr.ReadAccTxt:Str30;
begin
  Result := oBtrTable.FieldByName('AccTxt').AsString;
end;

procedure TAbodefBtr.WriteAccTxt(pValue:Str30);
begin
  oBtrTable.FieldByName('AccTxt').AsString := pValue;
end;

function TAbodefBtr.ReadAccSnt:Str3;
begin
  Result := oBtrTable.FieldByName('AccSnt').AsString;
end;

procedure TAbodefBtr.WriteAccSnt(pValue:Str3);
begin
  oBtrTable.FieldByName('AccSnt').AsString := pValue;
end;

function TAbodefBtr.ReadAccAnl:Str6;
begin
  Result := oBtrTable.FieldByName('AccAnl').AsString;
end;

procedure TAbodefBtr.WriteAccAnl(pValue:Str6);
begin
  oBtrTable.FieldByName('AccAnl').AsString := pValue;
end;

function TAbodefBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TAbodefBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TAbodefBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TAbodefBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TAbodefBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TAbodefBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TAbodefBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TAbodefBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TAbodefBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TAbodefBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TAbodefBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TAbodefBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TAbodefBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TAbodefBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAbodefBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAbodefBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TAbodefBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAbodefBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TAbodefBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TAbodefBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TAbodefBtr.LocateCsPsNo (pCoSymb:Str20;pPySign:Str1;pNotice:Str30):boolean;
begin
  SetIndex (ixCsPsNo);
  Result := oBtrTable.FindKey([pCoSymb,pPySign,pNotice]);
end;

function TAbodefBtr.LocateCoSymb (pCoSymb:Str20):boolean;
begin
  SetIndex (ixCoSymb);
  Result := oBtrTable.FindKey([pCoSymb]);
end;

function TAbodefBtr.NearestCsPsNo (pCoSymb:Str20;pPySign:Str1;pNotice:Str30):boolean;
begin
  SetIndex (ixCsPsNo);
  Result := oBtrTable.FindNearest([pCoSymb,pPySign,pNotice]);
end;

function TAbodefBtr.NearestCoSymb (pCoSymb:Str20):boolean;
begin
  SetIndex (ixCoSymb);
  Result := oBtrTable.FindNearest([pCoSymb]);
end;

procedure TAbodefBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TAbodefBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TAbodefBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TAbodefBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TAbodefBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TAbodefBtr.First;
begin
  oBtrTable.First;
end;

procedure TAbodefBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TAbodefBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TAbodefBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TAbodefBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TAbodefBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TAbodefBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TAbodefBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TAbodefBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TAbodefBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TAbodefBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TAbodefBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
