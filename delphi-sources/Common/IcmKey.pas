unit IcmKey;

interface

uses
  IcTypes, IcConv, IcVariab, NexPath, NexGlob, NexIni, hKEYDEF,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

type
  TIcmKey = class (TComponent)
    constructor Create(phKEYDEF:TKeydefHnd);
    destructor  Destroy; override;
  private
    ohKEYDEF:TKeydefHnd;
    function ReadEmlSub:Str200;      procedure WriteEmlSub(pValue:Str200);
    function ReadEmlMsg:Str200;      procedure WriteEmlMsg(pValue:Str200);
    function ReadSpvSnt:Str3;        procedure WriteSpvSnt(pValue:Str3);
    function ReadSpvAnl:Str6;        procedure WriteSpvAnl(pValue:Str6);
    function ReadSptSnt:Str3;        procedure WriteSptSnt(pValue:Str3);
    function ReadSptAnl:Str6;        procedure WriteSptAnl(pValue:Str6);
    function ReadRndSnt:Str3;        procedure WriteRndSnt(pValue:Str3);
    function ReadRndAnl:Str6;        procedure WriteRndAnl(pValue:Str6);
  public
    property EmlSub:Str200 read ReadEmlSub write WriteEmlSub;     // Subjekt (predmet) elektronickej posty
    property EmlMsg:Str200 read ReadEmlMsg write WriteEmlMsg;     // Sprava (telo) elektronickej posty
    property SpvSnt:Str3 read ReadSpvSnt write WriteSpvSnt;       // Synteticka vast uctu celej ciastky zalohy (324)
    property SpvAnl:Str6 read ReadSpvAnl write WriteSpvAnl;       // Synteticka vast uctu celej ciastky zalohy
    property SptSnt:Str3 read ReadSptSnt write WriteSptSnt;       // Synteticka vast uctu DPH zo zalohy (317)
    property SptAnl:Str6 read ReadSptAnl write WriteSptAnl;       // Synteticka vast uctu DPH zo zalohy
    property RndSnt:Str3 read ReadRndSnt write WriteRndSnt;       // Synteticka vast uctu rozdielu zo zaokruhlenia
    property RndAnl:Str6 read ReadRndAnl write WriteRndAnl;       // Synteticka vast uctu rozdielu zo zaokruhlenia
  end;

implementation

constructor TIcmKey.Create(phKEYDEF:TKeydefHnd);
begin
  ohKEYDEF := phKEYDEF;
end;

destructor TIcmKey.Destroy;
begin
end;

// ******************************** PRIVATE ************************************

function TIcmKey.ReadEmlSub:Str200;
begin
  Result := ohKEYDEF.ReadString('ICM','','EmlSub','');
end;

procedure TIcmKey.WriteEmlSub(pValue:Str200);
begin
  ohKEYDEF.WriteString('ICM','','EmlSub',pValue);
end;

function TIcmKey.ReadEmlMsg:Str200;
begin
  Result := ohKEYDEF.ReadString('ICM','','EmlMsg','');
end;

procedure TIcmKey.WriteEmlMsg(pValue:Str200);
begin
  ohKEYDEF.WriteString('ICM','','EmlMsg',pValue);
end;

function TIcmKey.ReadSpvSnt:Str3;
begin
  Result := ohKEYDEF.ReadString('ICM','','SpvSnt','');
end;

procedure TIcmKey.WriteSpvSnt(pValue:Str3);
begin
  ohKEYDEF.WriteString('ICM','','SpvSnt',pValue);
end;

function TIcmKey.ReadSpvAnl:Str6;
begin
  Result := ohKEYDEF.ReadString('ICM','','SpvAnl','');
end;

procedure TIcmKey.WriteSpvAnl(pValue:Str6);
begin
  ohKEYDEF.WriteString('ICM','','SpvAnl',pValue);
end;

function TIcmKey.ReadSptSnt:Str3;
begin
  Result := ohKEYDEF.ReadString('ICM','','SptSnt','');
end;

procedure TIcmKey.WriteSptSnt(pValue:Str3);
begin
  ohKEYDEF.WriteString('ICM','','SptSnt',pValue);
end;

function TIcmKey.ReadSptAnl:Str6;
begin
  Result := ohKEYDEF.ReadString('ICM','','SptAnl','');
end;

procedure TIcmKey.WriteSptAnl(pValue:Str6);
begin
  ohKEYDEF.WriteString('ICM','','SptAnl',pValue);
end;

function TIcmKey.ReadRndSnt:Str3;
begin
  Result := ohKEYDEF.ReadString('ICM','','RndSnt','');
end;

procedure TIcmKey.WriteRndSnt(pValue:Str3);
begin
  ohKEYDEF.WriteString('ICM','','RndSnt',pValue);
end;

function TIcmKey.ReadRndAnl:Str6;
begin
  Result := ohKEYDEF.ReadString('ICM','','RndAnl','');
end;

procedure TIcmKey.WriteRndAnl(pValue:Str6);
begin
  ohKEYDEF.WriteString('ICM','','RndAnl',pValue);
end;

// ********************************* PUBLIC ************************************

end.


