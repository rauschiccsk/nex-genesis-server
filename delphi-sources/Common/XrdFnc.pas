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
    ohXRHLST:TXrhlstHne;  // Hlavi�ky XLS v�kazov
    ohXRILST:TXrilstHne;  // Polo�ky XLS v�kazov
    ohXRIDOU:TXridouHne;  // Podrobnosti v�dajov
    ohXRIDST:TXridstHne;  // Podrobnosti z�soby
    ohXRIDOS:TXridosHne;  // Podrobnosti objedn�vok
    otXRIFIF:TXrififTmp;  // Zostatky FIFO kariet k zadan�mu d�tumu
    function NewSerNum:word; // Nov� nasleduj�ce poradov� ��slo v�kazu
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

function TXrdFnc.NewSerNum:word; // Nov� nasleduj�ce poradov� ��slo v�kazu
begin
  ohXRHLST.SwapStatus;
  ohXRHLST.Last;
  Result:=ohXRHLST.SerNum+1;
  ohXRHLST.RestStatus;
end;

end.


