unit bUSRGRP;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGrpNum = 'GrpNum';
  ixGrpName = 'GrpName';

type
  TUsrgrpBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGrpNum:word;           procedure WriteGrpNum (pValue:word);
    function  ReadGrpName:Str30;         procedure WriteGrpName (pValue:Str30);
    function  ReadGrpName_:Str30;        procedure WriteGrpName_ (pValue:Str30);
    function  ReadLanguage:Str2;         procedure WriteLanguage (pValue:Str2);
    function  ReadGrpLev:byte;           procedure WriteGrpLev (pValue:byte);
    function  ReadMaxDsc:byte;           procedure WriteMaxDsc (pValue:byte);
    function  ReadMinPrf:byte;           procedure WriteMinPrf (pValue:byte);
    function  ReadDefSet1:word;          procedure WriteDefSet1 (pValue:word);
    function  ReadDefSet2:word;          procedure WriteDefSet2 (pValue:word);
    function  ReadDefSet3:word;          procedure WriteDefSet3 (pValue:word);
    function  ReadDefSet4:byte;          procedure WriteDefSet4 (pValue:byte);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtName:Str30;         procedure WriteCrtName (pValue:Str30);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
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
    function LocateGrpNum (pGrpNum:word):boolean;
    function LocateGrpName (pGrpName_:Str30):boolean;
    function NearestGrpNum (pGrpNum:word):boolean;
    function NearestGrpName (pGrpName_:Str30):boolean;

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
    property GrpNum:word read ReadGrpNum write WriteGrpNum;
    property GrpName:Str30 read ReadGrpName write WriteGrpName;
    property GrpName_:Str30 read ReadGrpName_ write WriteGrpName_;
    property Language:Str2 read ReadLanguage write WriteLanguage;
    property GrpLev:byte read ReadGrpLev write WriteGrpLev;
    property MaxDsc:byte read ReadMaxDsc write WriteMaxDsc;
    property MinPrf:byte read ReadMinPrf write WriteMinPrf;
    property DefSet1:word read ReadDefSet1 write WriteDefSet1;
    property DefSet2:word read ReadDefSet2 write WriteDefSet2;
    property DefSet3:word read ReadDefSet3 write WriteDefSet3;
    property DefSet4:byte read ReadDefSet4 write WriteDefSet4;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtName:Str30 read ReadCrtName write WriteCrtName;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TUsrgrpBtr.Create;
begin
  oBtrTable := BtrInit ('USRGRP',gPath.SysPath,Self);
end;

constructor TUsrgrpBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('USRGRP',pPath,Self);
end;

destructor TUsrgrpBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TUsrgrpBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TUsrgrpBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TUsrgrpBtr.ReadGrpNum:word;
begin
  Result := oBtrTable.FieldByName('GrpNum').AsInteger;
end;

procedure TUsrgrpBtr.WriteGrpNum(pValue:word);
begin
  oBtrTable.FieldByName('GrpNum').AsInteger := pValue;
end;

function TUsrgrpBtr.ReadGrpName:Str30;
begin
  Result := oBtrTable.FieldByName('GrpName').AsString;
end;

procedure TUsrgrpBtr.WriteGrpName(pValue:Str30);
begin
  oBtrTable.FieldByName('GrpName').AsString := pValue;
end;

function TUsrgrpBtr.ReadGrpName_:Str30;
begin
  Result := oBtrTable.FieldByName('GrpName_').AsString;
end;

procedure TUsrgrpBtr.WriteGrpName_(pValue:Str30);
begin
  oBtrTable.FieldByName('GrpName_').AsString := pValue;
end;

function TUsrgrpBtr.ReadLanguage:Str2;
begin
  Result := oBtrTable.FieldByName('Language').AsString;
end;

procedure TUsrgrpBtr.WriteLanguage(pValue:Str2);
begin
  oBtrTable.FieldByName('Language').AsString := pValue;
end;

function TUsrgrpBtr.ReadGrpLev:byte;
begin
  Result := oBtrTable.FieldByName('GrpLev').AsInteger;
end;

procedure TUsrgrpBtr.WriteGrpLev(pValue:byte);
begin
  oBtrTable.FieldByName('GrpLev').AsInteger := pValue;
end;

function TUsrgrpBtr.ReadMaxDsc:byte;
begin
  Result := oBtrTable.FieldByName('MaxDsc').AsInteger;
end;

procedure TUsrgrpBtr.WriteMaxDsc(pValue:byte);
begin
  oBtrTable.FieldByName('MaxDsc').AsInteger := pValue;
end;

function TUsrgrpBtr.ReadMinPrf:byte;
begin
  Result := oBtrTable.FieldByName('MinPrf').AsInteger;
end;

procedure TUsrgrpBtr.WriteMinPrf(pValue:byte);
begin
  oBtrTable.FieldByName('MinPrf').AsInteger := pValue;
end;

function TUsrgrpBtr.ReadDefSet1:word;
begin
  Result := oBtrTable.FieldByName('DefSet1').AsInteger;
end;

procedure TUsrgrpBtr.WriteDefSet1(pValue:word);
begin
  oBtrTable.FieldByName('DefSet1').AsInteger := pValue;
end;

function TUsrgrpBtr.ReadDefSet2:word;
begin
  Result := oBtrTable.FieldByName('DefSet2').AsInteger;
end;

procedure TUsrgrpBtr.WriteDefSet2(pValue:word);
begin
  oBtrTable.FieldByName('DefSet2').AsInteger := pValue;
end;

function TUsrgrpBtr.ReadDefSet3:word;
begin
  Result := oBtrTable.FieldByName('DefSet3').AsInteger;
end;

procedure TUsrgrpBtr.WriteDefSet3(pValue:word);
begin
  oBtrTable.FieldByName('DefSet3').AsInteger := pValue;
end;

function TUsrgrpBtr.ReadDefSet4:byte;
begin
  Result := oBtrTable.FieldByName('DefSet4').AsInteger;
end;

procedure TUsrgrpBtr.WriteDefSet4(pValue:byte);
begin
  oBtrTable.FieldByName('DefSet4').AsInteger := pValue;
end;

function TUsrgrpBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TUsrgrpBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TUsrgrpBtr.ReadCrtName:Str30;
begin
  Result := oBtrTable.FieldByName('CrtName').AsString;
end;

procedure TUsrgrpBtr.WriteCrtName(pValue:Str30);
begin
  oBtrTable.FieldByName('CrtName').AsString := pValue;
end;

function TUsrgrpBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TUsrgrpBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TUsrgrpBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TUsrgrpBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TUsrgrpBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TUsrgrpBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TUsrgrpBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TUsrgrpBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TUsrgrpBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TUsrgrpBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TUsrgrpBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TUsrgrpBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TUsrgrpBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TUsrgrpBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TUsrgrpBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TUsrgrpBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TUsrgrpBtr.LocateGrpNum (pGrpNum:word):boolean;
begin
  SetIndex (ixGrpNum);
  Result := oBtrTable.FindKey([pGrpNum]);
end;

function TUsrgrpBtr.LocateGrpName (pGrpName_:Str30):boolean;
begin
  SetIndex (ixGrpName);
  Result := oBtrTable.FindKey([StrToAlias(pGrpName_)]);
end;

function TUsrgrpBtr.NearestGrpNum (pGrpNum:word):boolean;
begin
  SetIndex (ixGrpNum);
  Result := oBtrTable.FindNearest([pGrpNum]);
end;

function TUsrgrpBtr.NearestGrpName (pGrpName_:Str30):boolean;
begin
  SetIndex (ixGrpName);
  Result := oBtrTable.FindNearest([pGrpName_]);
end;

procedure TUsrgrpBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TUsrgrpBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TUsrgrpBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TUsrgrpBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TUsrgrpBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TUsrgrpBtr.First;
begin
  oBtrTable.First;
end;

procedure TUsrgrpBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TUsrgrpBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TUsrgrpBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TUsrgrpBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TUsrgrpBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TUsrgrpBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TUsrgrpBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TUsrgrpBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TUsrgrpBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TUsrgrpBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TUsrgrpBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
