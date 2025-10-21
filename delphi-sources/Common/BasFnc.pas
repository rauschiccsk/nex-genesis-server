unit BasFnc;
// =============================================================================
//                      BÁZOVÉ (ZÁKLADNÉ) FUNKCIE SYSTÌMU
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ************************ POPIS JEDNOTLIVÉCH FUNKCIÍ *************************
// -----------------------------------------------------------------------------
// BtrCpyTmp - Prekopíruje aktuálny záznam zo zdrojového BTR do doèasného súboru
//             › pBtrTab - zdrojový databázový súbor BTR
//             › pTmpTab - cie¾ový doèasný súbor DB (Paradox)
// BtrCpyBtr - Prekopíruje aktuálny záznam zo zdrojového BTR do cie¾ového BTR
//             súboru.
//             › pSrcTab - zdrojový databázový súbor BTR
//             › pTrgTab - cie¾ový databázový súbor BTR
// TmpCpyTmp - Prekopíruje aktuálny záznam zo zdrojového DB do cie¾ového DB
//             súboru.
//             › pSrcTab - zdrojový databázový súbor DB (Paradox)
//             › pTrgTab - cie¾ový databázový súbor DB (Paradox)
// -----------------------------------------------------------------------------
// ********************************* POZNÁMKY **********************************
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ****************************** HISTÓRIA ZMIEN *******************************
// -----------------------------------------------------------------------------
// 21.03[28.12.2018] - Bola pridaná funkcia BtrCpyTmp (RZ)
// =============================================================================

interface

uses
  IcTypes, IcTools, IcConv, LinLst,
  NexBtrTable, NexPxTable, Windows, ComCtrls, DB, Controls, StdCtrls, SysUtils, Forms, ExtCtrls, Classes, IcProgressBar;

  function NewSerNum(pTable:TNexBtrTable;pBokNum:Str3;pDocYer:Str2):longint;
  function NewItmNum(pTable:TNexBtrTable;pDocNum:Str12):longint;

  procedure AddDocLst(pDocLst:TStrings;pDocNum:Str12);  // Pridá èíslo dokladu do zoznamu
  procedure AddNotLin(pTable:TNexBtrTable;pDocNum:Str12;pItmNum:word;pNotTyp:Str1;pLinNum:word;pNotLin:Str250);    // Uloží poznámkový riadok do dokladu
  procedure DelNotLst(pTable:TNexBtrTable;pDocNum:Str12;pItmNum:word;pNotTyp:Str1);  // Vymaže zadané poznámkové riadky
  procedure AddNotLst(pTable:TNexBtrTable;pDocNum:Str12;pItmNum:word;pNotTyp:Str1;pNotLst:TStrings);  // Uloží poznámky z memo do databáze
  procedure LodNotLst(pTable:TNexBtrTable;pDocNum:Str12;pItmNum:word;pNotTyp:Str1;pNotLst:TStrings);  // Naèíta poznámky z databáze do memo
  procedure AddPrnNot(ptDOCPRN:TNexPxTable;pLinNum:byte;pNotice:Str250); // Pridá poznémku do zadaného riadku
  procedure ClrTmpTab(pTable:TNexPxTable); // Vymaze obsah docasného súboru
  procedure ClrBtrTab(pTable:TNexBtrTable;pInd:TIcProgressBar); // Vymaze obsah zadaného súboru BTR
  procedure CrtLinLst(pLinDat:Str250;var pLinLst:TLinLst);
  procedure BtrCpyTmp(pBtrTab:TNexBtrTable;pTmpTab:TNexPxTable); // Prekopíruje aktuálny záznam zo súboru pBtrTab do doèasného súboru pTmpTab
  procedure BtrCpyBtr(pSrcTab,pTrgTab:TNexBtrTable); // Prekopíruje aktuálny záznam zo súboru pSrcTab do doèasného súboru pTrgTab
  procedure TmpCpyTmp(pSrcTab,pTrgTab:TNexPxTable); // Prekopíruje aktuálny záznam zo súboru pSrcTab do doèasného súboru pTrgTab

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
  // Kontrola èi dané poradové èíslo existuje
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
  // Kontrola èi dané èíslo položky existuje
  Repeat
    mFind:=pTable.FindKey([pDocNum,Result]);
    If mFind then Inc(Result);
    Application.ProcessMessages;
  until not mFind;
  pTable.RestoreIndex;
end;

procedure AddDocLst(pDocLst:TStrings;pDocNum:Str12);  // Pridá adresu hlavièky do zoznamu zákaziek, ktoré boli zmenené
var mExist:boolean;  I:word;
begin
  mExist:=FALSE;
  If pDocLst.Count>0 then begin  // Zoznam nie je prázdny
    For I:=0 to pDocLst.Count-1 do begin
      If pDocLst.Strings[I]=pDocNum then mExist:=TRUE;
    end
  end;
  If not mExist then pDocLst.Add(pDocNum);
end;

procedure AddNotLin(pTable:TNexBtrTable;pDocNum:Str12;pItmNum:word;pNotTyp:Str1;pLinNum:word;pNotLin:Str250);    // Uloží poznámkový riadok databáze
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

procedure DelNotLst(pTable:TNexBtrTable;pDocNum:Str12;pItmNum:word;pNotTyp:Str1);  // Vymaže zadané poznámkové riadky
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

procedure AddPrnNot(ptDOCPRN:TNexPxTable;pLinNum:byte;pNotice:Str250); // Pridá poznémku do zadaného riadku
begin
  ptDOCPRN.Edit;
  ptDOCPRN.FieldByName('Notice'+StrInt(pLinNum,1)).AsString:=pNotice;
  ptDOCPRN.Post;
end;

procedure ClrTmpTab(pTable:TNexPxTable); // Vymaze obsah docasného súboru
begin
  If pTable.RecordCount>0 then begin
    pTable.First;
    Repeat
      pTable.Delete;
    until pTable.Eof or (pTable.RecordCount=0);
  end;
end;

procedure ClrBtrTab(pTable:TNexBtrTable;pInd:TIcProgressBar); // Vymaze obsah zadaného súboru BTR
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

procedure BtrCpyBtr(pSrcTab,pTrgTab:TNexBtrTable); // Prekopíruje aktuálny záznam zo súboru pSrcTab do doèasného súboru pTrgTab
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

procedure TmpCpyTmp(pSrcTab,pTrgTab:TNexPxTable); // Prekopíruje aktuálny záznam zo súboru pSrcTab do doèasného súboru pTrgTab
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

