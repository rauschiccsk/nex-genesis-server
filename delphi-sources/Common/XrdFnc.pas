unit XrdFnc;

interface

uses
  IcTypes, IcConv, IcVariab, IcTools, Nexpath, NexClc, NexGlob, Prp, eXRHLST, eXRILST, eXRIDOU, eXRIDOS, eXRIDST, tXRIFIF,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs, Forms, DateUtils;

type
  TXrdFnc=class
    constructor Create;
    destructor Destroy; override;
  private
  public
    ohXRHLST:TXrhlstHne;  // Hlavièky XLS výkazov
    ohXRILST:TXrilstHne;  // Položky XLS výkazov
    ohXRIDOU:TXridouHne;  // Podrobnosti výdajov
    ohXRIDST:TXridstHne;  // Podrobnosti zásoby
    ohXRIDOS:TXridosHne;  // Podrobnosti objednávok
    otXRIFIF:TXrififTmp;  // Zostatky FIFO kariet k zadanému dátumu
    function NewSerNum:word; // Nové nasledujúce poradové èíslo výkazu
  end;

implementation

uses dXRHLST;

constructor TXrdFnc.Create;
begin
  ohXRHLST:=TXrhlstHne.Create;
  ohXRILST:=TXrilstHne.Create;
  ohXRIDOU:=TXridouHne.Create;
  ohXRIDST:=TXridstHne.Create;
  ohXRIDOS:=TXridosHne.Create;
  otXRIFIF:=TXrififTmp.Create;
end;

destructor TXrdFnc.Destroy;
begin
  FreeAndNil(otXRIFIF);
  FreeAndNil(ohXRHLST);
  FreeAndNil(ohXRILST);
  FreeAndNil(ohXRIDOU);
  FreeAndNil(ohXRIDST);
  FreeAndNil(ohXRIDOS);
end;

// ******************************** PRIVATE ************************************

// ********************************* PUBLIC ************************************

function TXrdFnc.NewSerNum:word; // Nové nasledujúce poradové èíslo výkazu
begin
  ohXRHLST.SwapStatus;
  ohXRHLST.Last;
  Result:=ohXRHLST.SerNum+1;
  ohXRHLST.RestStatus;
end;

end.


