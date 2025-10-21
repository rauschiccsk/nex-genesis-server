unit GscKey;

interface

uses
  IcTypes, IcConv, IcVariab, NexPath, NexGlob, NexIni, hKEYDEF,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

type
  TGscKey = class (TComponent)
    constructor Create(phKEYDEF:TKeydefHnd);
    destructor  Destroy; override;
  private
    ohKEYDEF:TKeydefHnd;
    function ReadIntBap:Str2;                procedure WriteIntBap(pValue:Str2);
    function ReadWghBap:Str2;                procedure WriteWghBap(pValue:Str2);
    function ReadRefStk:Str200;              procedure WriteRefStk(pValue:Str200);
    function ReadRefPls:Str200;              procedure WriteRefPls(pValue:Str200);
    function ReadStcCrt:boolean;             procedure WriteStcCrt(pValue:boolean);
    function ReadBcsPce:boolean;             procedure WriteBcsPce(pValue:boolean);
    function ReadCasRef:boolean;             procedure WriteCasRef(pValue:boolean);
    function ReadNewFrm:boolean;             procedure WriteNewFrm(pValue:boolean);
    function ReadBacVer:boolean;             procedure WriteBacVer(pValue:boolean);
    function ReadStcVer:boolean;             procedure WriteStcVer(pValue:boolean);
    function ReadSpcVer:boolean;             procedure WriteSpcVer(pValue:boolean);
    function ReadOscVer:boolean;             procedure WriteOscVer(pValue:boolean);
    function ReadPlsNum(pPlsNum:word):word;  procedure WritePlsNum(pPlsNum:word;pValue:word);
    function ReadStkNum(pStkNum:word):word;  procedure WriteStkNum(pStkNum:word;pValue:word);
    function ReadRefPath:Str60;              procedure WriteRefPath(pValue:Str60);
    function ReadItmTyp:Str60;               procedure WriteItmTyp(pValue:Str60);
  public
    property IntBap:Str2 read ReadIntBap write WriteIntBap;    // Prefix interneho ciaroveho kodu
    property WghBap:Str2 read ReadWghBap write WriteWghBap;    // Prefix interneho vahoveho ciaroveho kodu
    property RefStk:Str200 read ReadRefStk write WriteRefStk;  // Zoznam skladov na automaticku synchronizaciu
    property RefPls:Str200 read ReadRefPls write WriteRefPls;  // Zoznam cenniko na automaticku synchronizaciu
    property StcCrt:boolean read ReadStcCrt write WriteStcCrt; // Automaticke vytvorenie skladových kariet z bázovej evidencii tovaru
    property BcsPce:boolean read ReadBcsPce write WriteBcsPce; // Ak je TRUE system nakupnu cenu nacita z obchodnych podmienok
    property CasRef:boolean read ReadCasRef write WriteCasRef; // Ak je TRUE system vytvara GSCAT:REF pre synchronizaciu evidencia na pokladni
    property BacVer:boolean read ReadBacVer write WriteBacVer;  // Kontrola duplicity èiarového kódu
    property StcVer:boolean read ReadStcVer write WriteStcVer;  // Kontrola duplicity skladového kódu
    property SpcVer:boolean read ReadSpcVer write WriteSpcVer;  // Kontrola duplicity špecifikaèného kódu
    property OscVer:boolean read ReadBacVer write WriteOscVer;  // Kontrola duplicity objednávkového kódu
    property PlsNum[pPlsNum:word]:word read ReadPlsNum write WritePlsNum; // Èísla prednastavených cenníkov
    property StkNum[pStkNum:word]:word read ReadStkNum write WriteStkNum; // Èísla prednastavených skladov
    property RefPath:Str60 read ReadRefPath write WriteRefPath; // Adresar zapisu GSCAT.REF
    property ItmTyp:Str60 read ReadItmTyp write WriteItmTyp; // Zoznam povolenych typov tovaru
  end;

implementation

constructor TGscKey.Create(phKEYDEF:TKeydefHnd);
begin
  ohKEYDEF := phKEYDEF;
end;

destructor TGscKey.Destroy;
begin
end;

// ******************************** PRIVATE ************************************

function TGscKey.ReadIntBap:Str2;
begin
  Result := ohKEYDEF.ReadString ('GSC','','GscIntBap','21');
end;

procedure TGscKey.WriteIntBap(pValue:Str2);
begin
  ohKEYDEF.WriteString('GSC','','GscIntBap',pValue)
end;

function TGscKey.ReadWghBap:Str2;
begin
  Result := ohKEYDEF.ReadString ('GSC','','GscWghBap','20');
end;

procedure TGscKey.WriteWghBap(pValue:Str2);
begin
  ohKEYDEF.WriteString('GSC','','GscWghBap',pValue)
end;

procedure TGscKey.WriteRefStk(pValue:Str200);
begin
  ohKEYDEF.WriteString('GSC','','GscRefStk',pValue)
end;

function TGscKey.ReadRefStk:Str200;
begin
  Result := ohKEYDEF.ReadString ('GSC','','GscRefStk','');
end;

procedure TGscKey.WriteRefPls(pValue:Str200);
begin
  ohKEYDEF.WriteString('GSC','','GscRefPls',pValue)
end;

function TGscKey.ReadRefPls:Str200;
begin
  Result := ohKEYDEF.ReadString ('GSC','','GscRefPls','');
end;

function TGscKey.ReadStcCrt:boolean;
begin
  Result := ohKEYDEF.ReadBoolean('GSC','','GscStcCrt',FALSE);
end;

procedure TGscKey.WriteStcCrt(pValue:boolean);
begin
  ohKEYDEF.WriteBoolean('GSC','','GscStcCrt',pValue)
end;

function TGscKey.ReadBcsPce:boolean;
begin
  Result := ohKEYDEF.ReadBoolean('GSC','','GscBcsPce',FALSE);
end;

procedure TGscKey.WriteBcsPce(pValue:boolean);
begin
  ohKEYDEF.WriteBoolean('GSC','','GscBcsPce',pValue)
end;

function TGscKey.ReadCasRef:boolean;
begin
  Result := ohKEYDEF.ReadBoolean('GSC','','GscCasRef',FALSE);
end;

procedure TGscKey.WriteCasRef(pValue:boolean);
begin
  ohKEYDEF.WriteBoolean('GSC','','GscCasRef',pValue)
end;

function TGscKey.ReadNewFrm:boolean;
begin
  Result := ohKEYDEF.ReadBoolean('GSC','','NewFrm',FALSE);
end;

procedure TGscKey.WriteNewFrm(pValue:boolean);
begin
  ohKEYDEF.WriteBoolean('GSC','','NewFrm',pValue)
end;

function TGscKey.ReadBacVer:boolean;
begin
  Result := ohKEYDEF.ReadBoolean('GSC','','BacVer',TRUE);
end;

procedure TGscKey.WriteBacVer(pValue:boolean);
begin
  ohKEYDEF.WriteBoolean('GSC','','BacVer',pValue)
end;

function TGscKey.ReadStcVer:boolean;
begin
  Result := ohKEYDEF.ReadBoolean('GSC','','StcVer',TRUE);
end;

procedure TGscKey.WriteStcVer(pValue:boolean);
begin
  ohKEYDEF.WriteBoolean('GSC','','StcVer',pValue)
end;

function TGscKey.ReadSpcVer:boolean;
begin
  Result := ohKEYDEF.ReadBoolean('GSC','','SpcVer',TRUE);
end;

procedure TGscKey.WriteSpcVer(pValue:boolean);
begin
  ohKEYDEF.WriteBoolean('GSC','','SpcVer',pValue)
end;

function TGscKey.ReadOscVer:boolean;
begin
  Result := ohKEYDEF.ReadBoolean('GSC','','OscVer',TRUE);
end;

procedure TGscKey.WriteOscVer(pValue:boolean);
begin
  ohKEYDEF.WriteBoolean('GSC','','OscVer',pValue)
end;

function TGscKey.ReadRefPath:Str60;
begin
  Result := ohKEYDEF.ReadString('GSC','','GscRefPath','C:\TRANS\');
end;

procedure TGscKey.WriteRefPath(pValue:Str60);
begin
  ohKEYDEF.WriteString('GSC','','GscRefPath',pValue)
end;

function TGscKey.ReadItmTyp:Str60;
begin
  Result := ohKEYDEF.ReadString('GSC','','GscItmTyp','1,2,3,4,5');
end;

procedure TGscKey.WriteItmTyp(pValue:Str60);
begin
  ohKEYDEF.WriteString('GSC','','GscItmTyp',pValue)
end;

function TGscKey.ReadPlsNum(pPlsNum:word):word;
begin
  Result := ohKEYDEF.ReadInteger('GSC',StrInt(pPlsNum,0),'GscPlsNum',0);
end;

procedure TGscKey.WritePlsNum(pPlsNum:word;pValue:word);
begin
  ohKEYDEF.WriteInteger('GSC',StrInt(pPlsNum,0),'GscPlsNum',pValue);
end;

function TGscKey.ReadStkNum(pStkNum:word):word;
begin
  Result := ohKEYDEF.ReadInteger('GSC',StrInt(pStkNum,0),'GscStkNum',0);
end;

procedure TGscKey.WriteStkNum(pStkNum:word;pValue:word);
begin
  ohKEYDEF.WriteInteger('GSC',StrInt(pStkNum,0),'GscStkNum',pValue);
end;

// ********************************* PUBLIC ************************************

end.
{MOD 1807008}
{MOD 1808002}
{MOD 1901008}

