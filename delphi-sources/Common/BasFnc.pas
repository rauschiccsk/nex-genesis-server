unit BasFnc;
// =============================================================================
//                      B�ZOV� (Z�KLADN�) FUNKCIE SYST�MU
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ************************ POPIS JEDNOTLIV�CH FUNKCI� *************************
// -----------------------------------------------------------------------------
// BtrCpyTmp - Prekop�ruje aktu�lny z�znam zo zdrojov�ho BTR do do�asn�ho s�boru
//             � pBtrTab - zdrojov� datab�zov� s�bor BTR
//             � pTmpTab - cie�ov� do�asn� s�bor DB (Paradox)
// BtrCpyBtr - Prekop�ruje aktu�lny z�znam zo zdrojov�ho BTR do cie�ov�ho BTR
//             s�boru.
//             � pSrcTab - zdrojov� datab�zov� s�bor BTR
//             � pTrgTab - cie�ov� datab�zov� s�bor BTR
// TmpCpyTmp - Prekop�ruje aktu�lny z�znam zo zdrojov�ho DB do cie�ov�ho DB
//             s�boru.
//             � pSrcTab - zdrojov� datab�zov� s�bor DB (Paradox)
//             � pTrgTab - cie�ov� datab�zov� s�bor DB (Paradox)
// -----------------------------------------------------------------------------
// ********************************* POZN�MKY **********************************
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ****************************** HIST�RIA ZMIEN *******************************
// -----------------------------------------------------------------------------
// 21.03[28.12.2018] - Bola pridan� funkcia BtrCpyTmp (RZ)
// =============================================================================

interface

uses
  IcTypes, IcTools, IcConv, LinLst,
  NexBtrTable, NexPxTable, Windows, ComCtrls, DB, Controls, StdCtrls, SysUtils, Forms, ExtCtrls, Classes, IcProgressBar;

  function NewSerNum(pTable:TNexBtrTable;pBokNum:Str3;pDocYer:Str2):longint;
  function NewItmNum(pTable:TNexBtrTable;pDocNum:Str12):longint;

  procedure AddDocLst(pDocLst:TStrings;pDocNum:Str12);  // Prid� ��slo dokladu do zoznamu
  procedure AddNotLin(pTable:TNexBtrTable;pDocNum:Str12;pItmNum:word;pNotTyp:Str1;pLinNum:word;pNotLin:Str250);    // Ulo�� pozn�mkov� riadok do dokladu
  procedure DelNotLst(pTable:TNexBtrTable;pDocNum:Str12;pItmNum:word;pNotTyp:Str1);  // Vyma�e zadan� pozn�mkov� riadky
  procedure AddNotLst(pTable:TNexBtrTable;pDocNum:Str12;pItmNum:word;pNotTyp:Str1;pNotLst:TStrings);  // Ulo�� pozn�mky z memo do datab�ze
  procedure LodNotLst(pTable:TNexBtrTable;pDocNum:Str12;pItmNum:word;pNotTyp:Str1;pNotLst:TStrings);  // Na��ta pozn�mky z datab�ze do memo
  procedure AddPrnNot(ptDOCPRN:TNexPxTable;pLinNum:byte;pNotice:Str250); // Prid� pozn�mku do zadan�ho riadku
  procedure ClrTmpTab(pTable:TNexPxTable); // Vymaze obsah docasn�ho s�boru
  procedure ClrBtrTab(pTable:TNexBtrTable;pInd:TIcProgressBar); // Vymaze obsah zadan�ho s�boru BTR
  procedure CrtLinLst(pLinDat:Str250;var pLinLst:TLinLst);
  procedure BtrCpyTmp(pBtrTab:TNexBtrTable;pTmpTab:TNexPxTable); // Prekop�ruje aktu�lny z�znam zo s�boru pBtrTab do do�asn�ho s�boru pTmpTab
  procedure BtrCpyBtr(pSrcTab,pTrgTab:TNexBtrTable); // Prekop�ruje aktu�lny z�znam zo s�boru pSrcTab do do�asn�ho s�boru pTrgTab
  procedure TmpCpyTmp(pSrcTab,pTrgTab:TNexPxTable); // Prekop�ruje aktu�lny z�znam zo s�boru pSrcTab do do�asn�ho s�boru pTrgTab

implementation

function NewSerNum(pTable:TNexBtrTable;pBokNum:Str3;pDocYer:Str2):longint;
var mFind:boolean;
begin
  pTable.SwapIndex;
  If pTable.IndexName<>'DyBnSn' then pTable.IndexName:='DyBnSn';
  pTable.FindNearest([pDocYer,pBokNum,99999]);
  If pTable.FieldByName('BokNum').AsString=pBokNum then begin
    If pTable.FieldByName('DocYer').AsString=pDocYer then begin
      Result:=pTable.FieldByName('SerNum').AsInteger+1;
    end else Result:=1;
  end else Result:=1;
  // Kontrola �i dan� poradov� ��slo existuje
  Repeat
    mFind:=pTable.FindKey([pDocYer,pBokNum,Result]);
    If mFind then Inc(Result);
    Application.ProcessMessages;
  until not mFind;
  pTable.RestoreIndex;
end;

function NewItmNum(pTable:TNexBtrTable;pDocNum:Str12):longint;
var mFind:boolean;
begin
  pTable.SwapIndex;
  If pTable.IndexName<>'DnIn' then pTable.IndexName:='DnIn';
  pTable.FindNearest([pDocNum,99999]);
  If pTable.FieldByName('DocNum').AsString=pDocNum then begin
    Result:=pTable.FieldByName('ItmNum').AsInteger+1;
  end else Result:=1;
  // Kontrola �i dan� ��slo polo�ky existuje
  Repeat
    mFind:=pTable.FindKey([pDocNum,Result]);
    If mFind then Inc(Result);
    Application.ProcessMessages;
  until not mFind;
  pTable.RestoreIndex;
end;

procedure AddDocLst(pDocLst:TStrings;pDocNum:Str12);  // Prid� adresu hlavi�ky do zoznamu z�kaziek, ktor� boli zmenen�
var mExist:boolean;  I:word;
begin
  mExist:=FALSE;
  If pDocLst.Count>0 then begin  // Zoznam nie je pr�zdny
    For I:=0 to pDocLst.Count-1 do begin
      If pDocLst.Strings[I]=pDocNum then mExist:=TRUE;
    end
  end;
  If not mExist then pDocLst.Add(pDocNum);
end;

procedure AddNotLin(pTable:TNexBtrTable;pDocNum:Str12;pItmNum:word;pNotTyp:Str1;pLinNum:word;pNotLin:Str250);    // Ulo�� pozn�mkov� riadok datab�ze
begin
  If not pTable.Active then pTable.Open;
  pTable.Insert;
  pTable.FieldByName('DocNum').AsString:=pDocNum;
  pTable.FieldByName('ItmNum').Asinteger:=pItmNum;
  pTable.FieldByName('NotTyp').AsString:=pNotTyp;
  pTable.FieldByName('LinNum').Asinteger:=pLinNum;
  pTable.FieldByName('Notice').AsString:=pNotLin;
  pTable.Post;
end;

procedure DelNotLst(pTable:TNexBtrTable;pDocNum:Str12;pItmNum:word;pNotTyp:Str1);  // Vyma�e zadan� pozn�mkov� riadky
begin
  If not pTable.Active then pTable.Open;
  If pTable.IndexName<>'DnInNt' then pTable.IndexName:='DnInNt';
  While pTable.FindKey([pDocNum,pItmNum,pNotTyp]) do pTable.Delete;
end;

procedure AddNotLst(pTable:TNexBtrTable;pDocNum:Str12;pItmNum:word;pNotTyp:Str1;pNotLst:TStrings);  //
var mLinNum:word;
begin
  If pNotLst.Count>0 then begin
    If not pTable.Active then pTable.Open;
    For mLinNum:=0 to pNotLst.Count-1 do begin
      AddNotLin(pTable,pDocNum,pItmNum,pNotTyp,mLinNum,pNotLst.Strings[mLinNum]);
    end;
  end;
end;

procedure LodNotLst(pTable:TNexBtrTable;pDocNum:Str12;pItmNum:word;pNotTyp:Str1;pNotLst:TStrings);  //
begin
  pNotLst.Clear;
  If not pTable.Active then pTable.Open;
  pTable.SwapIndex;
  If pTable.IndexName<>'DnInNt' then pTable.IndexName:='DnInNt';
  If pTable.FindKey([pDocNum,pItmNum,pNotTyp]) then begin
    Repeat
      pNotLst.Add(pTable.FieldByName('Notice').AsString);
      Application.ProcessMessages;
      pTable.Next;
    until (pTable.Eof) or (pTable.FieldByName('DocNum').AsString<>pDocNum) or (pTable.FieldByName('ItmNum').AsInteger<>pItmNum) or (pTable.FieldByName('NotTyp').AsString<>pNotTyp);
  end;
  pTable.RestoreIndex;
end;

procedure AddPrnNot(ptDOCPRN:TNexPxTable;pLinNum:byte;pNotice:Str250); // Prid� pozn�mku do zadan�ho riadku
begin
  ptDOCPRN.Edit;
  ptDOCPRN.FieldByName('Notice'+StrInt(pLinNum,1)).AsString:=pNotice;
  ptDOCPRN.Post;
end;

procedure ClrTmpTab(pTable:TNexPxTable); // Vymaze obsah docasn�ho s�boru
begin
  If pTable.RecordCount>0 then begin
    pTable.First;
    Repeat
      pTable.Delete;
    until pTable.Eof or (pTable.RecordCount=0);
  end;
end;

procedure ClrBtrTab(pTable:TNexBtrTable;pInd:TIcProgressBar); // Vymaze obsah zadan�ho s�boru BTR
begin
  If pTable.RecordCount>0 then begin
    pTable.DisableControls;
    pInd.Max:=pTable.RecordCount;
    pInd.Position:=pInd.Max;
    pTable.First;
    Repeat
      pInd.StepBy(-1);
      Application.ProcessMessages;
      pTable.Delete;
    until pTable.Eof or (pTable.RecordCount=0);
    pTable.EnableControls;
  end;
end;

procedure CrtLinLst(pLinDat:Str250;var pLinLst:TLinLst);
var mLinQnt,I:word;
begin
  pLinLst.Clear;
  If pLinDat<>'' then begin
    mLinQnt:=LineElementNum(pLinDat,',');
    If mLinQnt>0 then begin
      For I:=0 to mLinQnt-1 do begin
        pLinLst.AddItm(LineElement(pLinDat,I,','));
      end;
    end;
  end;
end;

procedure BtrCpyTmp(pBtrTab:TNexBtrTable;pTmpTab:TNexPxTable);
var I:word;  mFldNam:string;  mFldTyp:TFieldType;
begin
  If pTmpTab.FindField('RowNum')<>nil then begin
    If pTmpTab.FieldByName('RowNum').AsInteger=0 then pTmpTab.FieldByName('RowNum').AsInteger:=pTmpTab.RecordCount+1;
  end;
  For I:=0 to pBtrTab.FieldCount-1 do begin
    mFldNam:=pBtrTab.Fields[I].FieldName;
    mFldTyp:=pBtrTab.FieldByName(mFldNam).DataType;
    If pTmpTab.FindField(mFldNam)<>nil then begin
      If (mFldTyp=ftDateTime) then begin
        // Ak pole je datum a v BTR je nula potom nulu nezapiseme do PX
        If pBtrTab.FieldByName(mFldNam).AsDateTime>0 then pTmpTab.FieldByName(mFldNam).AsDateTime:=pBtrTab.FieldByName(mFldNam).AsDateTime;
      end
      else pTmpTab.FieldByName(mFldNam).AsString:=pBtrTab.FieldByName(mFldNam).AsString;
    end;
  end;
  If pTmpTab.FindField('ActPos')<>nil then pTmpTab.FieldByName('ActPos').AsInteger:=pBtrTab.ActPos;
end;

procedure BtrCpyBtr(pSrcTab,pTrgTab:TNexBtrTable); // Prekop�ruje aktu�lny z�znam zo s�boru pSrcTab do do�asn�ho s�boru pTrgTab
var I:word;  mFldNam:string;  mFldTyp:TFieldType;
begin
  For I:=0 to pSrcTab.FieldCount-1 do begin
    mFldNam:=pSrcTab.Fields[I].FieldName;
    mFldTyp:=pSrcTab.FieldByName(mFldNam).DataType;
    If pTrgTab.FindField(mFldNam)<>nil then begin
      pTrgTab.FieldByName(mFldNam).AsString:=pSrcTab.FieldByName(mFldNam).AsString;
    end;
  end;
end;

procedure TmpCpyTmp(pSrcTab,pTrgTab:TNexPxTable); // Prekop�ruje aktu�lny z�znam zo s�boru pSrcTab do do�asn�ho s�boru pTrgTab
var I:word;  mFldNam:string;  mFldTyp:TFieldType;
begin
  If pTrgTab.FindField('RowNum')<>nil then begin
    If pTrgTab.FieldByName('RowNum').AsInteger=0 then pTrgTab.FieldByName('RowNum').AsInteger:=pTrgTab.RecordCount+1;
  end;
  For I:=0 to pSrcTab.FieldCount-1 do begin
    mFldNam:=pSrcTab.Fields[I].FieldName;
    mFldTyp:=pSrcTab.FieldByName(mFldNam).DataType;
    If pTrgTab.FindField(mFldNam)<>nil then begin
      If (mFldTyp=ftDateTime) then begin
        // Ak pole je datum a je nula potom nulu nezapiseme do PX
        If pSrcTab.FieldByName(mFldNam).AsDateTime>0 then pTrgTab.FieldByName(mFldNam).AsDateTime:=pSrcTab.FieldByName(mFldNam).AsDateTime;
      end
      else pTrgTab.FieldByName(mFldNam).AsString:=pSrcTab.FieldByName(mFldNam).AsString;
    end;
  end;
end;

end.

