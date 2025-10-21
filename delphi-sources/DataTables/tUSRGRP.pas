unit tUSRGRP;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGrpNum = '';
  ixGrpName_ = 'GrpName_';

type
  TUsrgrpTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
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
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateGrpNum (pGrpNum:word):boolean;
    function LocateGrpName_ (pGrpName_:Str30):boolean;

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
    procedure DisableControls;
    procedure EnableControls;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read ReadCount;
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
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TUsrgrpTmp.Create;
begin
  oTmpTable := TmpInit ('USRGRP',Self);
end;

destructor TUsrgrpTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TUsrgrpTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TUsrgrpTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TUsrgrpTmp.ReadGrpNum:word;
begin
  Result := oTmpTable.FieldByName('GrpNum').AsInteger;
end;

procedure TUsrgrpTmp.WriteGrpNum(pValue:word);
begin
  oTmpTable.FieldByName('GrpNum').AsInteger := pValue;
end;

function TUsrgrpTmp.ReadGrpName:Str30;
begin
  Result := oTmpTable.FieldByName('GrpName').AsString;
end;

procedure TUsrgrpTmp.WriteGrpName(pValue:Str30);
begin
  oTmpTable.FieldByName('GrpName').AsString := pValue;
end;

function TUsrgrpTmp.ReadGrpName_:Str30;
begin
  Result := oTmpTable.FieldByName('GrpName_').AsString;
end;

procedure TUsrgrpTmp.WriteGrpName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GrpName_').AsString := pValue;
end;

function TUsrgrpTmp.ReadLanguage:Str2;
begin
  Result := oTmpTable.FieldByName('Language').AsString;
end;

procedure TUsrgrpTmp.WriteLanguage(pValue:Str2);
begin
  oTmpTable.FieldByName('Language').AsString := pValue;
end;

function TUsrgrpTmp.ReadGrpLev:byte;
begin
  Result := oTmpTable.FieldByName('GrpLev').AsInteger;
end;

procedure TUsrgrpTmp.WriteGrpLev(pValue:byte);
begin
  oTmpTable.FieldByName('GrpLev').AsInteger := pValue;
end;

function TUsrgrpTmp.ReadMaxDsc:byte;
begin
  Result := oTmpTable.FieldByName('MaxDsc').AsInteger;
end;

procedure TUsrgrpTmp.WriteMaxDsc(pValue:byte);
begin
  oTmpTable.FieldByName('MaxDsc').AsInteger := pValue;
end;

function TUsrgrpTmp.ReadMinPrf:byte;
begin
  Result := oTmpTable.FieldByName('MinPrf').AsInteger;
end;

procedure TUsrgrpTmp.WriteMinPrf(pValue:byte);
begin
  oTmpTable.FieldByName('MinPrf').AsInteger := pValue;
end;

function TUsrgrpTmp.ReadDefSet1:word;
begin
  Result := oTmpTable.FieldByName('DefSet1').AsInteger;
end;

procedure TUsrgrpTmp.WriteDefSet1(pValue:word);
begin
  oTmpTable.FieldByName('DefSet1').AsInteger := pValue;
end;

function TUsrgrpTmp.ReadDefSet2:word;
begin
  Result := oTmpTable.FieldByName('DefSet2').AsInteger;
end;

procedure TUsrgrpTmp.WriteDefSet2(pValue:word);
begin
  oTmpTable.FieldByName('DefSet2').AsInteger := pValue;
end;

function TUsrgrpTmp.ReadDefSet3:word;
begin
  Result := oTmpTable.FieldByName('DefSet3').AsInteger;
end;

procedure TUsrgrpTmp.WriteDefSet3(pValue:word);
begin
  oTmpTable.FieldByName('DefSet3').AsInteger := pValue;
end;

function TUsrgrpTmp.ReadDefSet4:byte;
begin
  Result := oTmpTable.FieldByName('DefSet4').AsInteger;
end;

procedure TUsrgrpTmp.WriteDefSet4(pValue:byte);
begin
  oTmpTable.FieldByName('DefSet4').AsInteger := pValue;
end;

function TUsrgrpTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TUsrgrpTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TUsrgrpTmp.ReadCrtName:Str30;
begin
  Result := oTmpTable.FieldByName('CrtName').AsString;
end;

procedure TUsrgrpTmp.WriteCrtName(pValue:Str30);
begin
  oTmpTable.FieldByName('CrtName').AsString := pValue;
end;

function TUsrgrpTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TUsrgrpTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TUsrgrpTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TUsrgrpTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TUsrgrpTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TUsrgrpTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TUsrgrpTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TUsrgrpTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TUsrgrpTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TUsrgrpTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TUsrgrpTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TUsrgrpTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TUsrgrpTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TUsrgrpTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TUsrgrpTmp.LocateGrpNum (pGrpNum:word):boolean;
begin
  SetIndex (ixGrpNum);
  Result := oTmpTable.FindKey([pGrpNum]);
end;

function TUsrgrpTmp.LocateGrpName_ (pGrpName_:Str30):boolean;
begin
  SetIndex (ixGrpName_);
  Result := oTmpTable.FindKey([pGrpName_]);
end;

procedure TUsrgrpTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TUsrgrpTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TUsrgrpTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TUsrgrpTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TUsrgrpTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TUsrgrpTmp.First;
begin
  oTmpTable.First;
end;

procedure TUsrgrpTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TUsrgrpTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TUsrgrpTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TUsrgrpTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TUsrgrpTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TUsrgrpTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TUsrgrpTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TUsrgrpTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TUsrgrpTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TUsrgrpTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TUsrgrpTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
