unit ScmKey;

interface

uses
  IcTypes, IcConv, IcVariab, NexPath, NexGlob, NexIni, hKEYDEF,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

type
  TScmKey = class (TComponent)
    constructor Create(phKEYDEF:TKeydefHnd);
    destructor  Destroy; override;
  private
    ohKEYDEF:TKeydefHnd;
    function ReadTcdBok:Str5;   procedure WriteTcdBok(pValue:Str5);
    function ReadCasNum:word;   procedure WriteCasNum(pValue:word);
    function ReadDvzNam:Str3;   procedure WriteDvzNam(pValue:Str3);
    function ReadExnFmt:Str12;  procedure WriteExnFmt(pValue:Str12);

  public
    property TcdBok:Str5   read ReadTcdBok write WriteTcdBok;  // Kniha vyúètovacích dodacích listov
    property CasNum:word   read ReadCasNum write WriteCasNum;  // Èíslo pokladne
    property DvzNam:Str3   read ReadDvzNam write WriteDvzNam;  // Vyúètovacia mena
    property ExnFmt:Str12  read ReadExnFmt write WriteExnFmt;  // Formát externého èísla
  end;

implementation

constructor TScmKey.Create(phKEYDEF:TKeydefHnd);
begin
  ohKEYDEF:=phKEYDEF;
end;

destructor TScmKey.Destroy;
begin
end;

// ******************************** PRIVATE ************************************

function TScmKey.ReadTcdBok:Str5;
begin
  Result:=ohKEYDEF.ReadString('SCM','','TcdBok','A-001');
end;

procedure TScmKey.WriteTcdBok(pValue:Str5);
begin
  ohKEYDEF.WriteString('SCM','','TcdBok',pValue);
end;

function TScmKey.ReadCasNum:word;
begin
  Result:=ohKEYDEF.ReadInteger('SCM','','CasNum',1);
end;

procedure TScmKey.WriteCasNum(pValue:word);
begin
  ohKEYDEF.Writeinteger('SCM','','CasNum',pValue);
end;

function TScmKey.ReadDvzNam:Str3;
begin
  Result:=ohKEYDEF.ReadString('SCM','','DvzNam','EUR');
end;

procedure TScmKey.WriteDvzNam(pValue:Str3);
begin
  ohKEYDEF.WriteString('SCM','','DvzNam',pValue);
end;

function TScmKey.ReadExnFmt:Str12;
begin
  Result:=ohKEYDEF.ReadString('SCM','','ExnFmt','yynnnnn');
end;

procedure TScmKey.WriteExnFmt(pValue:Str12);
begin
  ohKEYDEF.WriteString('SCM','','ExnFmt',pValue);
end;

// ********************************* PUBLIC ************************************

end.
{MOD 1916001}
