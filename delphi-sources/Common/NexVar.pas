unit NexVar;

interface

uses IcTypes, IniFiles;

var  
  gvDocIM: Str2 = 'SP';  { Skladove prijemky }
  gvDocOM: Str2 = 'SV';  { Skladove vydajky  }
  gvDocRM: Str2 = 'MP';  { Medziskladovy presun }
  gvDocTS: Str2 = 'DD';  { Dosle dodacie listy }
  gvDocTC: Str2 = 'OD';  { Odoslane dodacie lsity }
  gvDocIS: Str2 = 'DF';  { Dosle faktury }
  gvDocIC: Str2 = 'OF';  { Odoslane faktury }
  gvDocIZ: Str2 = 'ZF';  { Dosle zalohove faktury }
  gvDocIP: Str2 = 'PF';  { Odoslane zalohove faktury }
  gvDocOS: Str2 = 'OB';  { Dosle objednavky }
  gvDocOC: Str2 = 'ZK';  { Odolane objednavky }
  gvDocIV: Str2 = 'IN';  { Inventarne doklady }
  gvDocTB: Str2 = 'TP';  { Trzby registravnych pokladni }
  gvDocOP: Str2 = 'VZ';  { Vyrobne zakazky }
  gvDocID: Str2 = 'ID';  { Interne uctovne doklady }
  gvDocSA: Str2 = 'BV';  { Bankove vypisy }
  gvDocCI: Str2 = 'PP';  { Prijmove pokladnicne doklady }
  gvDocCE: Str2 = 'PV';  { Vydavkove pokladnicne doklady }
  gvDocSH: Str2 = 'DM';  { Drobny majetok }
  gvDocIH: Str2 = 'HM';  { Hmotny a nehmotny investicnym majetok }
  gvDocAC: Str2 = 'AC';  { Precenovacie doklady - akcie }

implementation

end.
