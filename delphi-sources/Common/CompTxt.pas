unit CompTxt;

interface

const
  ctGridSum_BadField:string ='Vybrané pole sa nedá zosumarizova!';
  ctGridSum_HeadS   :string ='Súèet všetkıch poloiek';
  ctGridSum_HeadO   :string ='Súèet poloiek od aktuálneho záznamu';
  ctGridSum_HeadD   :string ='Súèet poloiek do aktuálneho záznamu';
  ctGridSum_HeadSel :string ='Súèet oznaèenıch poloiek';
  ctGridSum_FldText :string ='Zosumarizované pole';
  ctGridSum_ItmNum  :string ='Poèet záznamov';
  ctGridSum_Val     :string ='Súèet poloiek';
  ctGridSum_Avg     :string ='Aritmetickı priemer';
  ctGridSum_Min     :string ='Najmenšia hodnota';
  ctGridSum_Max     :string ='Najväèšia hodnota';
  ctGridSum_All     :string ='Sumarizácia';
  ctGridSum_To      :string ='Sumarizácia do';
  ctGridSum_From    :string ='Sumarizácia od';
  ctGridSum_Sel     :string ='Sumarizácia vybranıch poloiek';
  ctGridSum_SelectItm:string ='Oznaèenie/odznaèenie poloky';
  ctGridSum_SelectAll:string ='Oznaèenie všetkıch poloiek';
  ctGridSum_DeselectAll:string ='Odznaèenie všetkıch poloiek';
  ctGridSum_Clipb   :string ='Naèíta údaje do pamäte';
  ctGridSum_HeadPISum:string ='Sumarizácia vybraného po¾a';
  ctGridSum_HeadPISel:string ='Oznaèenie všetkıch poloiek';
  ctGridSum_XLS   :string ='Vloi údaje do XLS';

  ctDBSrGrid_Index  :string ='Zoradi pod¾a';

  ctAdvGrid_ViewerSetEdit:string ='Zmeni zoznam';
  ctAdvGrid_ViewerSetSave:string ='Uloi zmeny';
  ctAdvGrid_ViewerSetDel :string ='Zruši nastavenie';
  ctAdvGrid_ColorInfo    :string ='Informácie o farbách';

  ctGridDG_Caption       :string = 'Zmena nastavenia zoznamov';
  ctGridDG_SetList       :string = 'Vıber nadefinovanıch zoznamov';
  ctGridDG_SetNumTxt     :string = 'Oznaèenie';
  ctGridDG_SetName       :string = 'Názov nastavenia';
  ctGridDG_ViewerHead    :string = 'Hlavièka tabu¾ky';
  ctGridDG_Database      :string = 'Databáza';
  ctGridDG_Show          :string = 'Zobrazi';
  ctGridDG_Name          :string = 'Názov';
  ctGridDG_Width         :string = 'Šírka';
  ctGridDG_DisplayWidth  :string = 'pixely';
  ctGridDG_DisplayWidthChar:string = 'znaky';
  ctGridDG_Alignment     :string = 'Zarovnáva údaje';
  ctGridDG_Format        :string = 'Formát';
  ctGridDG_EditFld       :string = 'Modifikovate¾né pole';
  ctGridDG_CopySelItm    :string = 'Zobrazi vybrané poloky';
  ctGridDG_RemoveSelItm  :string = 'Skry vybrané poloky';
  ctGridDG_CopyAllItm    :string = 'Zobrazi všetkıch poloiek';
  ctGridDG_RemoveAllItm  :string = 'Skry všetkıch poloiek';
  ctGridDG_Up            :string = 'Posun smerom hore';
  ctGridDG_Down          :string = 'Posun smerom dole';
  ctGridDG_AlignmentLeft :string = 'do ¾ava';
  ctGridDG_AlignmentCent :string = 'do stredu';
  ctGridDG_AlignmentRight:string = 'do prava';
  ctGridDG_EditFldYes    :string = 'Áno';
  ctGridDG_EditFldNo     :string = 'Nie';
  ctGridDG_NewDef        :string = 'Nové základné';
  ctGridDG_NewUser       :string = 'Nové uívate¾ské';
  ctGridDG_ShowOnlyUserSet:string = 'Zobrazi len vlastné zoznamy';
  ctGridDG_Delete        :string = 'Zruši';
  ctGridDG_Save          :string = 'Uloi';
  ctGridDG_Exit          :string = 'Opusti';
  ctGridDG_DefEdit       :string = 'Zmena základnıch údajov';

  ctGridDef_Caption       :string = 'Definovanie základnıch parametrov polí databáz';
  ctGridDef_Name          :string = 'Názov';
  ctGridDef_Width         :string = 'Šírka';
  ctGridDef_DisplayWidth  :string = 'pixely';
  ctGridDef_DisplayWidthChar:string = 'znaky';
  ctGridDef_Alignment     :string = 'Zarovnáva údaje';
  ctGridDef_Format        :string = 'Formát';
  ctGridDef_EditFld       :string = 'Modifikovate¾né pole';
  ctGridDef_Up            :string = 'Posun smerom hore';
  ctGridDef_Down          :string = 'Posun smerom dole';
  ctGridDef_AlignmentLeft :string = 'do ¾ava';
  ctGridDef_AlignmentCent :string = 'do stredu';
  ctGridDef_AlignmentRight:string = 'do prava';
  ctGridDef_EditFldYes    :string = 'Áno';
  ctGridDef_EditFldNo     :string = 'Nie';
  ctGridDef_Save          :string = 'Uloi';
  ctGridDef_Exit          :string = 'Opusti';

implementation

end.
