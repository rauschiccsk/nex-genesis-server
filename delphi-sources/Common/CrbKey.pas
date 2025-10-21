unit CrbKey;

interface

uses
  IcTypes, IcConv, IcVariab, NexPath, NexGlob, NexIni, hKEYDEF,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

type
  TCrbKey = class (TComponent)
    constructor Create(phKEYDEF:TKeydefHnd);
    destructor  Destroy; override;
  private
    ohKEYDEF:TKeydefHnd;
    function ReadReqTyp(pBokNum:Str5):Str1;    procedure WriteReqTyp(pBokNum:Str5;pValue:Str1);
  public
    property ReqTyp[pBokNum:Str5]:Str1   read ReadReqTyp write WriteReqTyp;  // Typ poziadavky
  end;

implementation

constructor TCrbKey.Create(phKEYDEF:TKeydefHnd);
begin
  ohKEYDEF := phKEYDEF;
end;

destructor TCrbKey.Destroy;
begin
end;

// ******************************** PRIVATE ************************************

function TCrbKey.ReadReqTyp(pBokNum:Str5):Str1;
begin
  Result := ohKEYDEF.ReadString('CRB',pBokNum,'ReqTyp','E');
end;

procedure TCrbKey.WriteReqTyp(pBokNum:Str5;pValue:Str1);
begin
  ohKEYDEF.WriteString('CRB',pBokNum,'ReqTyp',pValue);
end;

// ********************************* PUBLIC ************************************

end.
{MOD 1901005}
