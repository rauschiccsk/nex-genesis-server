unit bSYSTEM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixMyPaIno = 'MyPaIno';

type
  TSystemBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadMyPaIno:Str15;         procedure WriteMyPaIno (pValue:Str15);
    function  ReadMyPaTin:Str15;         procedure WriteMyPaTin (pValue:Str15);
    function  ReadMyPaVin:Str15;         procedure WriteMyPaVin (pValue:Str15);
    function  ReadMyOldTin:Str15;        procedure WriteMyOldTin (pValue:Str15);
    function  ReadMyPaName:Str60;        procedure WriteMyPaName (pValue:Str60);
    function  ReadMyPaAddr:Str30;        procedure WriteMyPaAddr (pValue:Str30);
    function  ReadMyStaCode:Str2;        procedure WriteMyStaCode (pValue:Str2);
    function  ReadMyStaName:Str30;       procedure WriteMyStaName (pValue:Str30);
    function  ReadMyCtyCode:Str3;        procedure WriteMyCtyCode (pValue:Str3);
    function  ReadMyCtyName:Str30;       procedure WriteMyCtyName (pValue:Str30);
    function  ReadMyZipCode:Str10;       procedure WriteMyZipCode (pValue:Str10);
    function  ReadMyWebSite:Str30;       procedure WriteMyWebSite (pValue:Str30);
    function  ReadMyTelNum:Str20;        procedure WriteMyTelNum (pValue:Str20);
    function  ReadMyFaxNum:Str20;        procedure WriteMyFaxNum (pValue:Str20);
    function  ReadMyEmail:Str30;         procedure WriteMyEmail (pValue:Str30);
    function  ReadMyBaConto:Str30;       procedure WriteMyBaConto (pValue:Str30);
    function  ReadMyBaName:Str30;        procedure WriteMyBaName (pValue:Str30);
    function  ReadMyBaCity:Str30;        procedure WriteMyBaCity (pValue:Str30);
    function  ReadMyBaStat:Str30;        procedure WriteMyBaStat (pValue:Str30);
    function  ReadMyWriNum:word;         procedure WriteMyWriNum (pValue:word);
    function  ReadRegister:Str90;        procedure WriteRegister (pValue:Str90);
    function  ReadBegGsCode:longint;     procedure WriteBegGsCode (pValue:longint);
    function  ReadEndGsCode:longint;     procedure WriteEndGsCode (pValue:longint);
    function  ReadBegPaCode:longint;     procedure WriteBegPaCode (pValue:longint);
    function  ReadEndPaCode:longint;     procedure WriteEndPaCode (pValue:longint);
    function  ReadDialHost:Str30;        procedure WriteDialHost (pValue:Str30);
    function  ReadDialUser:Str15;        procedure WriteDialUser (pValue:Str15);
    function  ReadDialPasw:Str15;        procedure WriteDialPasw (pValue:Str15);
    function  ReadFtpHost:Str30;         procedure WriteFtpHost (pValue:Str30);
    function  ReadFtpUser:Str15;         procedure WriteFtpUser (pValue:Str15);
    function  ReadFtpPasw:Str15;         procedure WriteFtpPasw (pValue:Str15);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateMyPaIno (pMyPaIno:Str15):boolean;
    function NearestMyPaIno (pMyPaIno:Str15):boolean;

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
    property MyPaIno:Str15 read ReadMyPaIno write WriteMyPaIno;
    property MyPaTin:Str15 read ReadMyPaTin write WriteMyPaTin;
    property MyPaVin:Str15 read ReadMyPaVin write WriteMyPaVin;
    property MyOldTin:Str15 read ReadMyOldTin write WriteMyOldTin;
    property MyPaName:Str60 read ReadMyPaName write WriteMyPaName;
    property MyPaAddr:Str30 read ReadMyPaAddr write WriteMyPaAddr;
    property MyStaCode:Str2 read ReadMyStaCode write WriteMyStaCode;
    property MyStaName:Str30 read ReadMyStaName write WriteMyStaName;
    property MyCtyCode:Str3 read ReadMyCtyCode write WriteMyCtyCode;
    property MyCtyName:Str30 read ReadMyCtyName write WriteMyCtyName;
    property MyZipCode:Str10 read ReadMyZipCode write WriteMyZipCode;
    property MyWebSite:Str30 read ReadMyWebSite write WriteMyWebSite;
    property MyTelNum:Str20 read ReadMyTelNum write WriteMyTelNum;
    property MyFaxNum:Str20 read ReadMyFaxNum write WriteMyFaxNum;
    property MyEmail:Str30 read ReadMyEmail write WriteMyEmail;
    property MyBaConto:Str30 read ReadMyBaConto write WriteMyBaConto;
    property MyBaName:Str30 read ReadMyBaName write WriteMyBaName;
    property MyBaCity:Str30 read ReadMyBaCity write WriteMyBaCity;
    property MyBaStat:Str30 read ReadMyBaStat write WriteMyBaStat;
    property MyWriNum:word read ReadMyWriNum write WriteMyWriNum;
    property Register:Str90 read ReadRegister write WriteRegister;
    property BegGsCode:longint read ReadBegGsCode write WriteBegGsCode;
    property EndGsCode:longint read ReadEndGsCode write WriteEndGsCode;
    property BegPaCode:longint read ReadBegPaCode write WriteBegPaCode;
    property EndPaCode:longint read ReadEndPaCode write WriteEndPaCode;
    property DialHost:Str30 read ReadDialHost write WriteDialHost;
    property DialUser:Str15 read ReadDialUser write WriteDialUser;
    property DialPasw:Str15 read ReadDialPasw write WriteDialPasw;
    property FtpHost:Str30 read ReadFtpHost write WriteFtpHost;
    property FtpUser:Str15 read ReadFtpUser write WriteFtpUser;
    property FtpPasw:Str15 read ReadFtpPasw write WriteFtpPasw;
  end;

implementation

constructor TSystemBtr.Create;
begin
  oBtrTable := BtrInit ('SYSTEM',gPath.SysPath,Self);
end;

constructor TSystemBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('SYSTEM',pPath,Self);
end;

destructor TSystemBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TSystemBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TSystemBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TSystemBtr.ReadMyPaIno:Str15;
begin
  Result := oBtrTable.FieldByName('MyPaIno').AsString;
end;

procedure TSystemBtr.WriteMyPaIno(pValue:Str15);
begin
  oBtrTable.FieldByName('MyPaIno').AsString := pValue;
end;

function TSystemBtr.ReadMyPaTin:Str15;
begin
  Result := oBtrTable.FieldByName('MyPaTin').AsString;
end;

procedure TSystemBtr.WriteMyPaTin(pValue:Str15);
begin
  oBtrTable.FieldByName('MyPaTin').AsString := pValue;
end;

function TSystemBtr.ReadMyPaVin:Str15;
begin
  Result := oBtrTable.FieldByName('MyPaVin').AsString;
end;

procedure TSystemBtr.WriteMyPaVin(pValue:Str15);
begin
  oBtrTable.FieldByName('MyPaVin').AsString := pValue;
end;

function TSystemBtr.ReadMyOldTin:Str15;
begin
  Result := oBtrTable.FieldByName('MyOldTin').AsString;
end;

procedure TSystemBtr.WriteMyOldTin(pValue:Str15);
begin
  oBtrTable.FieldByName('MyOldTin').AsString := pValue;
end;

function TSystemBtr.ReadMyPaName:Str60;
begin
  Result := oBtrTable.FieldByName('MyPaName').AsString;
end;

procedure TSystemBtr.WriteMyPaName(pValue:Str60);
begin
  oBtrTable.FieldByName('MyPaName').AsString := pValue;
end;

function TSystemBtr.ReadMyPaAddr:Str30;
begin
  Result := oBtrTable.FieldByName('MyPaAddr').AsString;
end;

procedure TSystemBtr.WriteMyPaAddr(pValue:Str30);
begin
  oBtrTable.FieldByName('MyPaAddr').AsString := pValue;
end;

function TSystemBtr.ReadMyStaCode:Str2;
begin
  Result := oBtrTable.FieldByName('MyStaCode').AsString;
end;

procedure TSystemBtr.WriteMyStaCode(pValue:Str2);
begin
  oBtrTable.FieldByName('MyStaCode').AsString := pValue;
end;

function TSystemBtr.ReadMyStaName:Str30;
begin
  Result := oBtrTable.FieldByName('MyStaName').AsString;
end;

procedure TSystemBtr.WriteMyStaName(pValue:Str30);
begin
  oBtrTable.FieldByName('MyStaName').AsString := pValue;
end;

function TSystemBtr.ReadMyCtyCode:Str3;
begin
  Result := oBtrTable.FieldByName('MyCtyCode').AsString;
end;

procedure TSystemBtr.WriteMyCtyCode(pValue:Str3);
begin
  oBtrTable.FieldByName('MyCtyCode').AsString := pValue;
end;

function TSystemBtr.ReadMyCtyName:Str30;
begin
  Result := oBtrTable.FieldByName('MyCtyName').AsString;
end;

procedure TSystemBtr.WriteMyCtyName(pValue:Str30);
begin
  oBtrTable.FieldByName('MyCtyName').AsString := pValue;
end;

function TSystemBtr.ReadMyZipCode:Str10;
begin
  Result := oBtrTable.FieldByName('MyZipCode').AsString;
end;

procedure TSystemBtr.WriteMyZipCode(pValue:Str10);
begin
  oBtrTable.FieldByName('MyZipCode').AsString := pValue;
end;

function TSystemBtr.ReadMyWebSite:Str30;
begin
  Result := oBtrTable.FieldByName('MyWebSite').AsString;
end;

procedure TSystemBtr.WriteMyWebSite(pValue:Str30);
begin
  oBtrTable.FieldByName('MyWebSite').AsString := pValue;
end;

function TSystemBtr.ReadMyTelNum:Str20;
begin
  Result := oBtrTable.FieldByName('MyTelNum').AsString;
end;

procedure TSystemBtr.WriteMyTelNum(pValue:Str20);
begin
  oBtrTable.FieldByName('MyTelNum').AsString := pValue;
end;

function TSystemBtr.ReadMyFaxNum:Str20;
begin
  Result := oBtrTable.FieldByName('MyFaxNum').AsString;
end;

procedure TSystemBtr.WriteMyFaxNum(pValue:Str20);
begin
  oBtrTable.FieldByName('MyFaxNum').AsString := pValue;
end;

function TSystemBtr.ReadMyEmail:Str30;
begin
  Result := oBtrTable.FieldByName('MyEmail').AsString;
end;

procedure TSystemBtr.WriteMyEmail(pValue:Str30);
begin
  oBtrTable.FieldByName('MyEmail').AsString := pValue;
end;

function TSystemBtr.ReadMyBaConto:Str30;
begin
  Result := oBtrTable.FieldByName('MyBaConto').AsString;
end;

procedure TSystemBtr.WriteMyBaConto(pValue:Str30);
begin
  oBtrTable.FieldByName('MyBaConto').AsString := pValue;
end;

function TSystemBtr.ReadMyBaName:Str30;
begin
  Result := oBtrTable.FieldByName('MyBaName').AsString;
end;

procedure TSystemBtr.WriteMyBaName(pValue:Str30);
begin
  oBtrTable.FieldByName('MyBaName').AsString := pValue;
end;

function TSystemBtr.ReadMyBaCity:Str30;
begin
  Result := oBtrTable.FieldByName('MyBaCity').AsString;
end;

procedure TSystemBtr.WriteMyBaCity(pValue:Str30);
begin
  oBtrTable.FieldByName('MyBaCity').AsString := pValue;
end;

function TSystemBtr.ReadMyBaStat:Str30;
begin
  Result := oBtrTable.FieldByName('MyBaStat').AsString;
end;

procedure TSystemBtr.WriteMyBaStat(pValue:Str30);
begin
  oBtrTable.FieldByName('MyBaStat').AsString := pValue;
end;

function TSystemBtr.ReadMyWriNum:word;
begin
  Result := oBtrTable.FieldByName('MyWriNum').AsInteger;
end;

procedure TSystemBtr.WriteMyWriNum(pValue:word);
begin
  oBtrTable.FieldByName('MyWriNum').AsInteger := pValue;
end;

function TSystemBtr.ReadRegister:Str90;
begin
  Result := oBtrTable.FieldByName('Register').AsString;
end;

procedure TSystemBtr.WriteRegister(pValue:Str90);
begin
  oBtrTable.FieldByName('Register').AsString := pValue;
end;

function TSystemBtr.ReadBegGsCode:longint;
begin
  Result := oBtrTable.FieldByName('BegGsCode').AsInteger;
end;

procedure TSystemBtr.WriteBegGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('BegGsCode').AsInteger := pValue;
end;

function TSystemBtr.ReadEndGsCode:longint;
begin
  Result := oBtrTable.FieldByName('EndGsCode').AsInteger;
end;

procedure TSystemBtr.WriteEndGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('EndGsCode').AsInteger := pValue;
end;

function TSystemBtr.ReadBegPaCode:longint;
begin
  Result := oBtrTable.FieldByName('BegPaCode').AsInteger;
end;

procedure TSystemBtr.WriteBegPaCode(pValue:longint);
begin
  oBtrTable.FieldByName('BegPaCode').AsInteger := pValue;
end;

function TSystemBtr.ReadEndPaCode:longint;
begin
  Result := oBtrTable.FieldByName('EndPaCode').AsInteger;
end;

procedure TSystemBtr.WriteEndPaCode(pValue:longint);
begin
  oBtrTable.FieldByName('EndPaCode').AsInteger := pValue;
end;

function TSystemBtr.ReadDialHost:Str30;
begin
  Result := oBtrTable.FieldByName('DialHost').AsString;
end;

procedure TSystemBtr.WriteDialHost(pValue:Str30);
begin
  oBtrTable.FieldByName('DialHost').AsString := pValue;
end;

function TSystemBtr.ReadDialUser:Str15;
begin
  Result := oBtrTable.FieldByName('DialUser').AsString;
end;

procedure TSystemBtr.WriteDialUser(pValue:Str15);
begin
  oBtrTable.FieldByName('DialUser').AsString := pValue;
end;

function TSystemBtr.ReadDialPasw:Str15;
begin
  Result := oBtrTable.FieldByName('DialPasw').AsString;
end;

procedure TSystemBtr.WriteDialPasw(pValue:Str15);
begin
  oBtrTable.FieldByName('DialPasw').AsString := pValue;
end;

function TSystemBtr.ReadFtpHost:Str30;
begin
  Result := oBtrTable.FieldByName('FtpHost').AsString;
end;

procedure TSystemBtr.WriteFtpHost(pValue:Str30);
begin
  oBtrTable.FieldByName('FtpHost').AsString := pValue;
end;

function TSystemBtr.ReadFtpUser:Str15;
begin
  Result := oBtrTable.FieldByName('FtpUser').AsString;
end;

procedure TSystemBtr.WriteFtpUser(pValue:Str15);
begin
  oBtrTable.FieldByName('FtpUser').AsString := pValue;
end;

function TSystemBtr.ReadFtpPasw:Str15;
begin
  Result := oBtrTable.FieldByName('FtpPasw').AsString;
end;

procedure TSystemBtr.WriteFtpPasw(pValue:Str15);
begin
  oBtrTable.FieldByName('FtpPasw').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSystemBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSystemBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TSystemBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSystemBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TSystemBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TSystemBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TSystemBtr.LocateMyPaIno (pMyPaIno:Str15):boolean;
begin
  SetIndex (ixMyPaIno);
  Result := oBtrTable.FindKey([pMyPaIno]);
end;

function TSystemBtr.NearestMyPaIno (pMyPaIno:Str15):boolean;
begin
  SetIndex (ixMyPaIno);
  Result := oBtrTable.FindNearest([pMyPaIno]);
end;

procedure TSystemBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TSystemBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TSystemBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TSystemBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TSystemBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TSystemBtr.First;
begin
  oBtrTable.First;
end;

procedure TSystemBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TSystemBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TSystemBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TSystemBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TSystemBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TSystemBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TSystemBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TSystemBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TSystemBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TSystemBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TSystemBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
