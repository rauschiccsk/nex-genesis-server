// ------------------------------------------------------------------------------
//                               PREDAJN¡ »INNOSç
// ------------------------------------------------------------------------------
unit TesKey;

interface

uses
  IcTypes, IcConv, IcVariab, NexPath, NexGlob, NexIni, hKEYDEF,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

type
  TTesKey=class (TComponent)
    constructor Create(phKEYDEF:TKeydefHnd);
    destructor Destroy; override;
  private
    ohKEYDEF:TKeydefHnd;
    // ExpedÌcia tovaru
    function ReadPogIdc:boolean;    procedure WritePogIdc(pValue:boolean);
    // Mobiln˝ predaj
    function ReadSgsIdc:boolean;    procedure WriteSgsIdc(pValue:boolean);
    // Invent˙ra
    function ReadInvIdc:boolean;    procedure WriteInvIdc(pValue:boolean);
    function ReadInvPoc:boolean;    procedure WriteInvPoc(pValue:boolean);
  public
    // ExpedÌcia tovaru
    property PogIdc:boolean read ReadPogIdc write WritePogIdc;   // Zobraziù identifikaËn˝ kÛd tovaru
    // Mobiln˝ predaj
    property SgsIdc:boolean read ReadSgsIdc write WriteSgsIdc;   // Zobraziù identifikaËn˝ kÛd tovaru
    // invent˙ra
    property InvIdc:boolean read ReadInvIdc write WriteInvIdc;   // Zobraziù identifikaËn˝ kÛd tovaru
    property InvPoc:boolean read ReadInvPoc write WriteInvPoc;   // Povoliù identifikovaù tovar podæa poziËnÈho kÛdu
  end;

implementation

constructor TTesKey.Create(phKEYDEF:TKeydefHnd);
begin
  ohKEYDEF:=phKEYDEF;
end;

destructor TTesKey.Destroy;
begin
end;

// ******************************** PRIVATE ************************************

function TTesKey.ReadPogIdc:boolean;
begin
  Result:=ohKEYDEF.ReadBoolean('TES','','PogIdc',FALSE);
end;

procedure TTesKey.WritePogIdc(pValue:boolean);
begin
  ohKEYDEF.WriteBoolean('TES','','PogIdc',pValue);
end;

function TTesKey.ReadSgsIdc:boolean;
begin
  Result:=ohKEYDEF.ReadBoolean('TES','','SgsIdc',FALSE);
end;

procedure TTesKey.WriteSgsIdc(pValue:boolean);
begin
  ohKEYDEF.WriteBoolean('TES','','SgsIdc',pValue);
end;

function TTesKey.ReadInvIdc:boolean;
begin
  Result:=ohKEYDEF.ReadBoolean('TES','','InvIdc',FALSE);
end;

procedure TTesKey.WriteInvIdc(pValue:boolean);
begin
  ohKEYDEF.WriteBoolean('TES','','InvIdc',pValue);
end;

function TTesKey.ReadInvPoc:boolean;
begin
  Result:=ohKEYDEF.ReadBoolean('TES','','InvPoc',FALSE);
end;

procedure TTesKey.WriteInvPoc(pValue:boolean);
begin
  ohKEYDEF.WriteBoolean('TES','','InvPoc',pValue);
end;
// ********************************* PUBLIC ************************************

end.

