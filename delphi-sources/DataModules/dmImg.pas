unit dmImg;

interface

uses
  IcVariab, IcTypes, BtrTable, IcConv, NexBtrTable,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ImgList, Registry, DBTables, PxTable, NexPxTable;

type
  TdmImg = class(TDataModule)
    imBok: TImageList;
    imBut: TImageList;
    imSml: TImageList;
    imTre: TImageList;
    imLrgIco: TImageList;
    imSmlIco: TImageList;
    imFnc: TImageList;
  private
  public
  end;

var gImg: TdmImg;

implementation

{$R *.DFM}

end.
