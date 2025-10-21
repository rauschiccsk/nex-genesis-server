unit NwxXml_F;

interface

uses
//  chrconv,
  IcVariab, IcEditors, IcStand, IcConv, IcTools,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Key, Inifiles,
  Dialogs, ExtCtrls, StdCtrls, IcLabels, IcInfoFields, Registry, Buttons,
  IcButtons, jpeg, ComCtrls, IcProgressBar, DB, DBTables, 
  xmldom, XMLIntf, msxmldom, XMLDoc, xpComp, oxmldom;

type
  TNwxXmlF = class(TForm)
    xpSinglePanel1: TxpSinglePanel;
    Bevel3: TBevel;
    Image1: TImage;
    PB_Indicator: TIcProgressBar;
    B_Run: TxpBitBtn;
    B_Cancel: TxpBitBtn;
    xpMemo1: TxpMemo;
    XMLDocument1: TXMLDocument;
    E_Gsc: TxpCheckBox;
    E_Cat: TxpCheckBox;
    E_Mg: TxpCheckBox;
    procedure B_RunClick(Sender: TObject);
    procedure B_CancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure XMLExport;
  public
    oAutoRun: boolean;
    oPath   : string;
    oYear   : String[4];
    procedure Execute(pPath:String;pYear:String;pAuto,pGsc,pCat,pMg:boolean);
  end;

var
  NwxXmlF: TNwxXmlF;

implementation

{$R *.DFM}

procedure TNwxXmlF.Execute;
begin
  oPath:=pPath;
  oYear:=pYear;
  E_Gsc.Checked:=pGsc;
  E_Cat.Checked:=pCat;
  E_Mg.Checked:=pMg;
  xpMemo1.Lines.Clear;
  oAutoRun:=pAuto;
  If pAuto then XMLExport else ShowModal;
end;

procedure TNwxXmlF.FormCreate(Sender: TObject);
begin
  oPath:='';
  oYear:='2012';
  oAutoRun:=True;
  E_Gsc.Checked:=True;
  E_Cat.Checked:=True;
  E_Mg.Checked:=True;
  xpMemo1.Lines.Clear;
end;

procedure TNwxXmlF.FormDestroy(Sender: TObject);
begin
//
end;

procedure TNwxXmlF.B_RunClick(Sender: TObject);
begin
  XMLExport;
end;

procedure TNwxXmlF.XMLExport;
var A,B,C: IXMLNode; mStr:String; mI: longint; mQnt:double;
  mTable:ttable;mIni:TIniFile;
begin
  If Pos('\\',oPath)>0 then Delete(oPath,Pos('\\',oPath),1);
{
<?xml version = "1.0" encoding="windows-1250" standalone="yes"?>
}
  XMLDocument1.Active:=False;
  XMLDocument1.Active:=True;
//  xmldocument1 := loadxmldata('<?xml version = "1.0" encoding="windows-1250" standalone="yes"?>');
  A:=XMLDocument1.AddChild('NawaxExport');
  If E_Gsc.Checked then begin
    mTable:=TTable.Create(Self);
    mTable.DatabaseName:=oPath+oYear+'\SYSTEM\';mTable.TableName:='GSCAT.DB';
    If FileExists(mTable.DatabaseName+mTable.TableName) then begin
      mTable.Open;
      PB_Indicator.Position:=0;PB_Indicator.Max:=mTable.RecordCount;
      If mTable.RecordCount>0 then begin
        mTable.First;
        while not mTable.Eof do begin
          PB_Indicator.StepBy(1);
          // srcat.bdf
          B:=A.AddChild('TOVAR');
          C:=B.AddChild('PLU');      C.Text:=mTable.fieldByName('GsCode').AsString;
          C:=B.AddChild('EAN');      C.Text:=mTable.fieldByName('BarCode').AsString;
          C:=B.AddChild('NAZOV');    C.Text:=mTable.fieldByName('GsName').AsString;
          C:=B.AddChild('SKUPINA');  C.Text:=mTable.fieldByName('MgCode').AsString;
          C:=B.AddChild('SADZBADPH');C.Text:=mTable.fieldByName('VatPrc').AsString;
          C:=B.AddChild('CENA');     C.Text:=mTable.fieldByName('APrice').AsString;
          C:=B.AddChild('CENASDPH'); C.Text:=mTable.fieldByName('BPrice').AsString;
          C:=B.AddChild('MJ');       C.Text:=mTable.fieldByName('MsName').AsString;
          C:=B.AddChild('TYP');      C.Text:=mTable.fieldByName('GsType').AsString;
          C:=B.AddChild('MERNE_MN');
          If mTable.fieldByName('MsuQnt').AsString+mTable.fieldByName('MsuName').AsString<>''
            then C.Text:=mTable.fieldByName('MsuQnt').AsString+' '+mTable.fieldByName('MsuName').AsString
            else C.Text:='';
          mTable.Next;
        end;
      end;
      mTable.Close;
    end;
    mTable.Free;
  end;
  If E_Gsc.Checked then begin
    PB_Indicator.Position:=0;PB_Indicator.Max:=16;
    If FileExists(oPath+'NAWAX.INI') then begin
      mIni:=TIniFile.Create(oPath+'NAWAX.INI');
      for mI:=1 to 8 do begin
        PB_Indicator.StepBy(1);
        mStr := mIni.ReadString ('ZKDF-PLU', 'PLU'+IntToStr(mI),  '||0|0|0|0|0|0');
        If LineElement(mStr,0,'|')<>'' then begin
          B:=A.AddChild('ZKDF');
          C:=B.AddChild('POR');        C.Text:=IntToStr(mI);
          C:=B.AddChild('NAZOV');      C.Text:=LineElement(mStr,0,'|');
          C:=B.AddChild('EAN');        C.Text:=LineElement(mStr,1,'|');
          C:=B.AddChild('OBSAH');      C.Text:=LineElement(mStr,2,'|');
          C:=B.AddChild('CENA_N');     C.Text:=LineElement(mStr,3,'|');
          C:=B.AddChild('CENA_Z');     C.Text:=LineElement(mStr,4,'|');
          C:=B.AddChild('CENA_P');     C.Text:=LineElement(mStr,5,'|');
          C:=B.AddChild('SADZBADPH');  C.Text:=LineElement(mStr,6,'|');
          C:=B.AddChild('KOMP');       C.Text:=LineElement(mStr,7,'|');
        end;
      end;
      for mI:=1 to 8 do begin
        PB_Indicator.StepBy(1);
        mStr := mIni.ReadString ('OF-PLU', 'PLU'+IntToStr(mI),  '||0|0|0|0|0');
        If LineElement(mStr,0,'|')<>'' then begin
          B:=A.AddChild('OF');
          C:=B.AddChild('POR');        C.Text:=IntToStr(mI);
          C:=B.AddChild('NAZOV');      C.Text:=LineElement(mStr,0,'|');
          C:=B.AddChild('EAN');        C.Text:=LineElement(mStr,1,'|');
          C:=B.AddChild('OBSAH');      C.Text:=LineElement(mStr,2,'|');
          C:=B.AddChild('CENA_N');     C.Text:=LineElement(mStr,3,'|');
          C:=B.AddChild('CENA_Z');     C.Text:=LineElement(mStr,4,'|');
          C:=B.AddChild('CENA_P');     C.Text:=LineElement(mStr,5,'|');
          C:=B.AddChild('SADZBADPH');  C.Text:=LineElement(mStr,6,'|');
        end;
      end;
      mIni.Free;
    end;
  end;
  If E_Mg.Checked then begin
    mTable:=TTable.Create(Self);
    mTable.DatabaseName:=oPath+oYear+'\SYSTEM\';mTable.TableName:='MG.DB';
    If FileExists(mTable.DatabaseName+mTable.TableName) then begin
      mTable.Open;
      PB_Indicator.Position:=0;PB_Indicator.Max:=mTable.RecordCount;
      If mTable.RecordCount>0 then begin
        mTable.First;
        while not mTable.Eof do begin
          PB_Indicator.StepBy(1);
          B:=A.AddChild('SKUPINA');
          C:=B.AddChild('CISLO');    C.Text:=mTable.fieldByName('MgCode').AsString;
          C:=B.AddChild('NAZOV');    C.Text:=mTable.fieldByName('MgName').AsString;
          C:=B.AddChild('ID');      C.Text:=mTable.fieldByName('MgID').AsString;
          mTable.Next;
        end;
      end;
      mTable.Close;
    end;
    mTable.Free;
  end;

  xpMemo1.Lines.Clear;
  xpMemo1.lines.Assign(XMLDocument1.XML);
  xpMemo1.Lines.Insert(0,'<?xml version = "1.0" encoding="windows-1250" standalone="yes"?>');
  xpMemo1.Lines.SaveToFile(oPath+'NAWAX.XML');
end;

procedure TNwxXmlF.B_CancelClick(Sender: TObject);
begin
  Close;
end;

procedure TNwxXmlF.FormShow(Sender: TObject);
begin
  If oAutoRun then begin
    XMLExport;
    Close;
  end;
end;

end.

