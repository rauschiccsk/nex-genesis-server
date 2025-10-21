unit tVATPRN;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSalDte = '';

type
  TVatprnTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSalDte:Str20;          procedure WriteSalDte (pValue:Str20);
    function  ReadRegVin:Str30;          procedure WriteRegVin (pValue:Str30);
    function  ReadProNam1:Str60;         procedure WriteProNam1 (pValue:Str60);
    function  ReadStkCod1:Str15;         procedure WriteStkCod1 (pValue:Str15);
    function  ReadSalPrq1:Str30;         procedure WriteSalPrq1 (pValue:Str30);
    function  ReadSapBva1:Str30;         procedure WriteSapBva1 (pValue:Str30);
    function  ReadVatPrc1:Str5;          procedure WriteVatPrc1 (pValue:Str5);
    function  ReadVatVal1:Str30;         procedure WriteVatVal1 (pValue:Str30);
    function  ReadProNam2:Str60;         procedure WriteProNam2 (pValue:Str60);
    function  ReadStkCod2:Str15;         procedure WriteStkCod2 (pValue:Str15);
    function  ReadSalPrq2:Str30;         procedure WriteSalPrq2 (pValue:Str30);
    function  ReadSapBva2:Str30;         procedure WriteSapBva2 (pValue:Str30);
    function  ReadVatPrc2:Str5;          procedure WriteVatPrc2 (pValue:Str5);
    function  ReadVatVal2:Str30;         procedure WriteVatVal2 (pValue:Str30);
    function  ReadProNam3:Str60;         procedure WriteProNam3 (pValue:Str60);
    function  ReadStkCod3:Str15;         procedure WriteStkCod3 (pValue:Str15);
    function  ReadSalPrq3:Str30;         procedure WriteSalPrq3 (pValue:Str30);
    function  ReadSapBva3:Str30;         procedure WriteSapBva3 (pValue:Str30);
    function  ReadVatPrc3:Str5;          procedure WriteVatPrc3 (pValue:Str5);
    function  ReadVatVal3:Str30;         procedure WriteVatVal3 (pValue:Str30);
    function  ReadProNam4:Str60;         procedure WriteProNam4 (pValue:Str60);
    function  ReadStkCod4:Str15;         procedure WriteStkCod4 (pValue:Str15);
    function  ReadSalPrq4:Str30;         procedure WriteSalPrq4 (pValue:Str30);
    function  ReadSapBva4:Str30;         procedure WriteSapBva4 (pValue:Str30);
    function  ReadVatPrc4:Str5;          procedure WriteVatPrc4 (pValue:Str5);
    function  ReadVatVal4:Str30;         procedure WriteVatVal4 (pValue:Str30);
    function  ReadProNam5:Str60;         procedure WriteProNam5 (pValue:Str60);
    function  ReadStkCod5:Str15;         procedure WriteStkCod5 (pValue:Str15);
    function  ReadSalPrq5:Str30;         procedure WriteSalPrq5 (pValue:Str30);
    function  ReadSapBva5:Str30;         procedure WriteSapBva5 (pValue:Str30);
    function  ReadVatPrc5:Str5;          procedure WriteVatPrc5 (pValue:Str5);
    function  ReadVatVal5:Str30;         procedure WriteVatVal5 (pValue:Str30);
    function  ReadVatVal:Str30;          procedure WriteVatVal (pValue:Str30);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateSalDte (pSalDte:Str20):boolean;

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
    property SalDte:Str20 read ReadSalDte write WriteSalDte;
    property RegVin:Str30 read ReadRegVin write WriteRegVin;
    property ProNam1:Str60 read ReadProNam1 write WriteProNam1;
    property StkCod1:Str15 read ReadStkCod1 write WriteStkCod1;
    property SalPrq1:Str30 read ReadSalPrq1 write WriteSalPrq1;
    property SapBva1:Str30 read ReadSapBva1 write WriteSapBva1;
    property VatPrc1:Str5 read ReadVatPrc1 write WriteVatPrc1;
    property VatVal1:Str30 read ReadVatVal1 write WriteVatVal1;
    property ProNam2:Str60 read ReadProNam2 write WriteProNam2;
    property StkCod2:Str15 read ReadStkCod2 write WriteStkCod2;
    property SalPrq2:Str30 read ReadSalPrq2 write WriteSalPrq2;
    property SapBva2:Str30 read ReadSapBva2 write WriteSapBva2;
    property VatPrc2:Str5 read ReadVatPrc2 write WriteVatPrc2;
    property VatVal2:Str30 read ReadVatVal2 write WriteVatVal2;
    property ProNam3:Str60 read ReadProNam3 write WriteProNam3;
    property StkCod3:Str15 read ReadStkCod3 write WriteStkCod3;
    property SalPrq3:Str30 read ReadSalPrq3 write WriteSalPrq3;
    property SapBva3:Str30 read ReadSapBva3 write WriteSapBva3;
    property VatPrc3:Str5 read ReadVatPrc3 write WriteVatPrc3;
    property VatVal3:Str30 read ReadVatVal3 write WriteVatVal3;
    property ProNam4:Str60 read ReadProNam4 write WriteProNam4;
    property StkCod4:Str15 read ReadStkCod4 write WriteStkCod4;
    property SalPrq4:Str30 read ReadSalPrq4 write WriteSalPrq4;
    property SapBva4:Str30 read ReadSapBva4 write WriteSapBva4;
    property VatPrc4:Str5 read ReadVatPrc4 write WriteVatPrc4;
    property VatVal4:Str30 read ReadVatVal4 write WriteVatVal4;
    property ProNam5:Str60 read ReadProNam5 write WriteProNam5;
    property StkCod5:Str15 read ReadStkCod5 write WriteStkCod5;
    property SalPrq5:Str30 read ReadSalPrq5 write WriteSalPrq5;
    property SapBva5:Str30 read ReadSapBva5 write WriteSapBva5;
    property VatPrc5:Str5 read ReadVatPrc5 write WriteVatPrc5;
    property VatVal5:Str30 read ReadVatVal5 write WriteVatVal5;
    property VatVal:Str30 read ReadVatVal write WriteVatVal;
  end;

implementation

constructor TVatprnTmp.Create;
begin
  oTmpTable := TmpInit ('VATPRN',Self);
end;

destructor TVatprnTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TVatprnTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TVatprnTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TVatprnTmp.ReadSalDte:Str20;
begin
  Result := oTmpTable.FieldByName('SalDte').AsString;
end;

procedure TVatprnTmp.WriteSalDte(pValue:Str20);
begin
  oTmpTable.FieldByName('SalDte').AsString := pValue;
end;

function TVatprnTmp.ReadRegVin:Str30;
begin
  Result := oTmpTable.FieldByName('RegVin').AsString;
end;

procedure TVatprnTmp.WriteRegVin(pValue:Str30);
begin
  oTmpTable.FieldByName('RegVin').AsString := pValue;
end;

function TVatprnTmp.ReadProNam1:Str60;
begin
  Result := oTmpTable.FieldByName('ProNam1').AsString;
end;

procedure TVatprnTmp.WriteProNam1(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam1').AsString := pValue;
end;

function TVatprnTmp.ReadStkCod1:Str15;
begin
  Result := oTmpTable.FieldByName('StkCod1').AsString;
end;

procedure TVatprnTmp.WriteStkCod1(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCod1').AsString := pValue;
end;

function TVatprnTmp.ReadSalPrq1:Str30;
begin
  Result := oTmpTable.FieldByName('SalPrq1').AsString;
end;

procedure TVatprnTmp.WriteSalPrq1(pValue:Str30);
begin
  oTmpTable.FieldByName('SalPrq1').AsString := pValue;
end;

function TVatprnTmp.ReadSapBva1:Str30;
begin
  Result := oTmpTable.FieldByName('SapBva1').AsString;
end;

procedure TVatprnTmp.WriteSapBva1(pValue:Str30);
begin
  oTmpTable.FieldByName('SapBva1').AsString := pValue;
end;

function TVatprnTmp.ReadVatPrc1:Str5;
begin
  Result := oTmpTable.FieldByName('VatPrc1').AsString;
end;

procedure TVatprnTmp.WriteVatPrc1(pValue:Str5);
begin
  oTmpTable.FieldByName('VatPrc1').AsString := pValue;
end;

function TVatprnTmp.ReadVatVal1:Str30;
begin
  Result := oTmpTable.FieldByName('VatVal1').AsString;
end;

procedure TVatprnTmp.WriteVatVal1(pValue:Str30);
begin
  oTmpTable.FieldByName('VatVal1').AsString := pValue;
end;

function TVatprnTmp.ReadProNam2:Str60;
begin
  Result := oTmpTable.FieldByName('ProNam2').AsString;
end;

procedure TVatprnTmp.WriteProNam2(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam2').AsString := pValue;
end;

function TVatprnTmp.ReadStkCod2:Str15;
begin
  Result := oTmpTable.FieldByName('StkCod2').AsString;
end;

procedure TVatprnTmp.WriteStkCod2(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCod2').AsString := pValue;
end;

function TVatprnTmp.ReadSalPrq2:Str30;
begin
  Result := oTmpTable.FieldByName('SalPrq2').AsString;
end;

procedure TVatprnTmp.WriteSalPrq2(pValue:Str30);
begin
  oTmpTable.FieldByName('SalPrq2').AsString := pValue;
end;

function TVatprnTmp.ReadSapBva2:Str30;
begin
  Result := oTmpTable.FieldByName('SapBva2').AsString;
end;

procedure TVatprnTmp.WriteSapBva2(pValue:Str30);
begin
  oTmpTable.FieldByName('SapBva2').AsString := pValue;
end;

function TVatprnTmp.ReadVatPrc2:Str5;
begin
  Result := oTmpTable.FieldByName('VatPrc2').AsString;
end;

procedure TVatprnTmp.WriteVatPrc2(pValue:Str5);
begin
  oTmpTable.FieldByName('VatPrc2').AsString := pValue;
end;

function TVatprnTmp.ReadVatVal2:Str30;
begin
  Result := oTmpTable.FieldByName('VatVal2').AsString;
end;

procedure TVatprnTmp.WriteVatVal2(pValue:Str30);
begin
  oTmpTable.FieldByName('VatVal2').AsString := pValue;
end;

function TVatprnTmp.ReadProNam3:Str60;
begin
  Result := oTmpTable.FieldByName('ProNam3').AsString;
end;

procedure TVatprnTmp.WriteProNam3(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam3').AsString := pValue;
end;

function TVatprnTmp.ReadStkCod3:Str15;
begin
  Result := oTmpTable.FieldByName('StkCod3').AsString;
end;

procedure TVatprnTmp.WriteStkCod3(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCod3').AsString := pValue;
end;

function TVatprnTmp.ReadSalPrq3:Str30;
begin
  Result := oTmpTable.FieldByName('SalPrq3').AsString;
end;

procedure TVatprnTmp.WriteSalPrq3(pValue:Str30);
begin
  oTmpTable.FieldByName('SalPrq3').AsString := pValue;
end;

function TVatprnTmp.ReadSapBva3:Str30;
begin
  Result := oTmpTable.FieldByName('SapBva3').AsString;
end;

procedure TVatprnTmp.WriteSapBva3(pValue:Str30);
begin
  oTmpTable.FieldByName('SapBva3').AsString := pValue;
end;

function TVatprnTmp.ReadVatPrc3:Str5;
begin
  Result := oTmpTable.FieldByName('VatPrc3').AsString;
end;

procedure TVatprnTmp.WriteVatPrc3(pValue:Str5);
begin
  oTmpTable.FieldByName('VatPrc3').AsString := pValue;
end;

function TVatprnTmp.ReadVatVal3:Str30;
begin
  Result := oTmpTable.FieldByName('VatVal3').AsString;
end;

procedure TVatprnTmp.WriteVatVal3(pValue:Str30);
begin
  oTmpTable.FieldByName('VatVal3').AsString := pValue;
end;

function TVatprnTmp.ReadProNam4:Str60;
begin
  Result := oTmpTable.FieldByName('ProNam4').AsString;
end;

procedure TVatprnTmp.WriteProNam4(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam4').AsString := pValue;
end;

function TVatprnTmp.ReadStkCod4:Str15;
begin
  Result := oTmpTable.FieldByName('StkCod4').AsString;
end;

procedure TVatprnTmp.WriteStkCod4(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCod4').AsString := pValue;
end;

function TVatprnTmp.ReadSalPrq4:Str30;
begin
  Result := oTmpTable.FieldByName('SalPrq4').AsString;
end;

procedure TVatprnTmp.WriteSalPrq4(pValue:Str30);
begin
  oTmpTable.FieldByName('SalPrq4').AsString := pValue;
end;

function TVatprnTmp.ReadSapBva4:Str30;
begin
  Result := oTmpTable.FieldByName('SapBva4').AsString;
end;

procedure TVatprnTmp.WriteSapBva4(pValue:Str30);
begin
  oTmpTable.FieldByName('SapBva4').AsString := pValue;
end;

function TVatprnTmp.ReadVatPrc4:Str5;
begin
  Result := oTmpTable.FieldByName('VatPrc4').AsString;
end;

procedure TVatprnTmp.WriteVatPrc4(pValue:Str5);
begin
  oTmpTable.FieldByName('VatPrc4').AsString := pValue;
end;

function TVatprnTmp.ReadVatVal4:Str30;
begin
  Result := oTmpTable.FieldByName('VatVal4').AsString;
end;

procedure TVatprnTmp.WriteVatVal4(pValue:Str30);
begin
  oTmpTable.FieldByName('VatVal4').AsString := pValue;
end;

function TVatprnTmp.ReadProNam5:Str60;
begin
  Result := oTmpTable.FieldByName('ProNam5').AsString;
end;

procedure TVatprnTmp.WriteProNam5(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam5').AsString := pValue;
end;

function TVatprnTmp.ReadStkCod5:Str15;
begin
  Result := oTmpTable.FieldByName('StkCod5').AsString;
end;

procedure TVatprnTmp.WriteStkCod5(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCod5').AsString := pValue;
end;

function TVatprnTmp.ReadSalPrq5:Str30;
begin
  Result := oTmpTable.FieldByName('SalPrq5').AsString;
end;

procedure TVatprnTmp.WriteSalPrq5(pValue:Str30);
begin
  oTmpTable.FieldByName('SalPrq5').AsString := pValue;
end;

function TVatprnTmp.ReadSapBva5:Str30;
begin
  Result := oTmpTable.FieldByName('SapBva5').AsString;
end;

procedure TVatprnTmp.WriteSapBva5(pValue:Str30);
begin
  oTmpTable.FieldByName('SapBva5').AsString := pValue;
end;

function TVatprnTmp.ReadVatPrc5:Str5;
begin
  Result := oTmpTable.FieldByName('VatPrc5').AsString;
end;

procedure TVatprnTmp.WriteVatPrc5(pValue:Str5);
begin
  oTmpTable.FieldByName('VatPrc5').AsString := pValue;
end;

function TVatprnTmp.ReadVatVal5:Str30;
begin
  Result := oTmpTable.FieldByName('VatVal5').AsString;
end;

procedure TVatprnTmp.WriteVatVal5(pValue:Str30);
begin
  oTmpTable.FieldByName('VatVal5').AsString := pValue;
end;

function TVatprnTmp.ReadVatVal:Str30;
begin
  Result := oTmpTable.FieldByName('VatVal').AsString;
end;

procedure TVatprnTmp.WriteVatVal(pValue:Str30);
begin
  oTmpTable.FieldByName('VatVal').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TVatprnTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TVatprnTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TVatprnTmp.LocateSalDte (pSalDte:Str20):boolean;
begin
  SetIndex (ixSalDte);
  Result := oTmpTable.FindKey([pSalDte]);
end;

procedure TVatprnTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TVatprnTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TVatprnTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TVatprnTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TVatprnTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TVatprnTmp.First;
begin
  oTmpTable.First;
end;

procedure TVatprnTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TVatprnTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TVatprnTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TVatprnTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TVatprnTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TVatprnTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TVatprnTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TVatprnTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TVatprnTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TVatprnTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TVatprnTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2202001}
