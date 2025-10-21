unit CrdTxt;
// *****************************************************************************
// Popis:
// Tento objekt ulozi zmenene zakaznicke karty alebo nacita ich
// z prenosoveho suboru.
// *****************************************************************************
interface

uses
  IcVariab, IcTypes, IcConv, IcConst, IcTools, NexPath, NexIni,
  TxtDoc, DocHand,
  Controls, ExtCtrls, Classes, StdCtrls, Buttons, Windows, Messages,
  SysUtils, Graphics, Forms, Dialogs, ComCtrls, LangForm, IcLabels,
  DBTables, PxTable, NexBtrTable, BtrTable, DB;

type
  TCrdTxt = class(TLangForm)
    btCRDLST: TNexBtrTable;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    oTxtDoc: TTxtDoc;
  public
    procedure SaveToFile (var pDocCnt:TNumLabel); // Ulozim zadane polozky do textoveho suboru
    procedure LoadFromFile (var pDocCnt:TNumLabel); // Nacita doklady do zadanej knihy z textoveho suboru
  end;

implementation

uses
  DM_DLSDAT, DM_SYSTEM;

{$R *.DFM}

procedure TCrdTxt.FormCreate(Sender: TObject);
begin
  oTxtDoc := TTxtDoc.Create;
end;

procedure TCrdTxt.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil (oTxtDoc);
end;

procedure TCrdTxt.SaveToFile (var pDocCnt:TNumLabel); // Ulozim zmenene doklady zo otovrenej knihy do textoveho suboru
var mFileName:ShortString;
begin
  dmDLS.OpenBase(btCRDLST);
  btCRDLST.IndexName := 'Sended';
  btCRDLST.Sended := FALSE;
  While btCRDLST.FindKey ([0]) do begin
    pDocCnt.Long := pDocCnt.Long+1;
    oTxtDoc.Insert;
    oTxtDoc.WriteString ('CrdNum',btCRDLST.FieldByName('CrdNum').AsString);
    oTxtDoc.WriteString ('CrdName',btCRDLST.FieldByName('CrdName').AsString);
    oTxtDoc.WriteInteger ('PaCode',btCRDLST.FieldByName('PaCode').AsInteger);
    oTxtDoc.WriteString ('PaName',btCRDLST.FieldByName('PaName').AsString);
    oTxtDoc.WriteString ('CrtUser',btCRDLST.FieldByName('CrtUser').AsString);
    oTxtDoc.WriteDate ('CrtDate',btCRDLST.FieldByName('CrtDate').AsDateTime);
    oTxtDoc.WriteTime ('CrtTime',btCRDLST.FieldByName('CrtTime').AsDateTime);
    oTxtDoc.WriteString ('ModUser',btCRDLST.FieldByName('ModUser').AsString);
    oTxtDoc.WriteDate ('ModDate',btCRDLST.FieldByName('ModDate').AsDateTime);
    oTxtDoc.WriteTime ('ModTime',btCRDLST.FieldByName('ModTime').AsDateTime);
    oTxtDoc.Post;
    btCRDLST.Edit;
    btCRDLST.FieldByName ('Sended').AsInteger := 1;
    btCRDLST.Post;
    Application.ProcessMessages;
  end;
  btCRDLST.Close;
  // Ulozime udaje do textoveho suboru
  If oTxtDoc.ItemCount>0 then begin
    mFileName := gIni.GetZipPath+'CRDLST.TXT';
    If FileExists (mFileName) then DeleteFile (mFileName);
    oTxtDoc.SaveToFile(mFileName);
  end;
end;

procedure TCrdTxt.LoadFromFile (var pDocCnt:TNumLabel); // Nacita doklady do zadanej knihy z textoveho suboru
var mFileName:ShortString;
begin
  try
    mFileName := gIni.GetZipPath+'CRDLST.TXT';
    If FileExists (mFileName) then begin
      dmDLS.OpenBase(btCRDLST);
      btCRDLST.IndexName := 'CrdNum';
      btCRDLST.Sended := FALSE;
      oTxtDoc.LoadFromFile (mFileName);
      // Nacitame cisla faktur z prenosoveho suboru
      oTxtDoc.First;
      Repeat
        If btCRDLST.FindKey ([oTxtDoc.ReadString('CrdNum')])
          then btCRDLST.Edit
          else begin
            btCRDLST.Insert;
            btCRDLST.FieldByName('CrdNum').AsString := oTxtDoc.ReadString ('CrdNum');
          end;
        btCRDLST.FieldByName('CrdName').AsString := oTxtDoc.ReadString ('CrdName');
        btCRDLST.FieldByName('PaCode').AsInteger := oTxtDoc.ReadInteger ('PaCode');
        btCRDLST.FieldByName('PaName').AsString := oTxtDoc.ReadString ('PaName');
        btCRDLST.FieldByName('CrtUser').AsString := oTxtDoc.ReadString ('CrtUser');
        btCRDLST.FieldByName('CrtDate').AsDateTime := oTxtDoc.ReadDate ('CrtDate');
        btCRDLST.FieldByName('CrtTime').AsDateTime := oTxtDoc.ReadTime ('CrtTime');
        btCRDLST.FieldByName('ModUser').AsString := oTxtDoc.ReadString ('ModUser');
        btCRDLST.FieldByName('ModDate').AsDateTime := oTxtDoc.ReadDate ('ModDate');
        btCRDLST.FieldByName('ModTime').AsDateTime := oTxtDoc.ReadTime ('ModTime');
        btCRDLST.Post;
        pDocCnt.Long := pDocCnt.Long+1;
        Application.ProcessMessages;
        oTxtDoc.Next;
      until oTxtDoc.Eof;
      btCRDLST.Close;
      DeleteFile (mFileName);
    end;
  except
  end;
end;

end.
