unit barreg5;{Print Bar Code Registration}
{
This unit simply registers the Delphi 5 version TPrintBarCode in the
 Delphi Component Pallette

 Copyright MountainTop Systems 1996-1997

 A number of Alternative Component pallette options are provided below.
 To Install the component in a pallette other than "data Access", Brack out
 the current RegisterComponents  line and UNBracket the one you want
 }


interface

PROCEDURE Register;

implementation

uses Classes, BarCd5, BarQr5;

PROCEDURE Register;
BEGIN
  Registercomponents('BarCode',[TPrintBarCode]);
  RegisterComponents('BarCode', [TQRBarcode]);
{To Install in Standard Pallette, use the following line instead}
{ Registercomponents('Standard',[TPrintBarCode]);}
{To Install On its own page in the component pallette, use this line:-}
{ Registercomponents('Print Bar Code',[TPrintBarCode]);}
{To Install in Any Pallette, replace the words "Pallette Name Here"
with the pallette name you want to use in the following line}
{ Registercomponents('Pallette Name Here',[TPrintBarCode]);}
END;

end.
