unit AplKey;

interface

uses
  IcTypes, IcConv, IcVariab, NexPath, NexGlob, NexIni, hKEYDEF,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

type
  TAplKey = class (TComponent)
    constructor Create(phKEYDEF:TKeydefHnd);
    destructor  Destroy; override;
  private
    ohKEYDEF:TKeydefHnd;
    function ReadNotDup(pAplNum:word):boolean;    procedure WriteNotDup(pAplNum:word;pValue:boolean);
  public
    property NotDup[pAplNum:word]:boolean read ReadNotDup write WriteNotDup;   // Nepovoli duplicitne zapsiat ten isty tovar do toho isteho cennika
  end;

implementation

constructor TAplKey.Create(phKEYDEF:TKeydefHnd);
begin
  ohKEYDEF := phKEYDEF;
end;

destructor TAplKey.Destroy;
begin
end;

// ******************************** PRIVATE ************************************

function TAplKey.ReadNotDup(pAplNum:word):boolean;
begin
  Result := ohKEYDEF.ReadBoolean('APL',StrInt(pAplNum,0),'NotDup',FALSE);
end;

procedure TAplKey.WriteNotDup(pAplNum:word;pValue:boolean);
begin
  ohKEYDEF.WriteBoolean('APL',StrInt(pAplNum,0),'NotDup',pValue);
end;


// ********************************* PUBLIC ************************************

end.


