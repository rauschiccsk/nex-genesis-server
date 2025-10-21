unit QRep_;
{
bolo by dobre este zaviest zoznam pouzivanych slov ktore su pouzivane pri dokumnetacii a boli prevzate z anglictiny aby popisy modulov boli rovnake
napr 'Property' - bude vsade napr. vlastnost a nie niekde charakteristika alebo parameter
'Selected' - bude vzdy "vybrany" a nie niekde oznaceny alebo vyznaceny
}

interface

uses
  DB, NexPath,BtrTable,
  IcConst, IcTools, IcConv, Printers, QRPRNTR, qrexpr,Series,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, QuickRpt, Qrctrls, StdCtrls, QuickRep, Grids, ImgList,
  TeeProcs, TeEngine, Chart, DBChart, QrTee, Buttons, ComCtrls, ExtDlgs,
  IcButtons, barqr5;

type
  TCompData= record
    rLeft        :string;
    rTop         :string;
    rWidth       :string;
    rHeight      :string;
    rLeftMM      :string;
    rTopMM       :string;
    rWidthMM     :string;
    rHeightMM    :string;
    rAutoSize    :boolean;
    rAutoSizeE   :boolean;
    rAutoSizeF   :boolean;
    rAlignment   :TAlignment;
    rAlignmentE  :boolean;
    rAlignmentF  :boolean;
    rFontE       :boolean;
    rFontName    :string;
    rFontSize    :string;
    rFontStyle   :TFontStyles;
    rFontStyleBF :boolean;
    rFontStyleIF :boolean;
    rFontStyleUF :boolean;
    rFontColor   :TColor;
    rFontColorF  :boolean;
    rFontCharset :longint;
    rFrameWidth  :string;
    rFrameLeft   :boolean;
    rFrameLeftF  :boolean;
    rFrameTop    :boolean;
    rFrameTopF   :boolean;
    rFrameRight  :boolean;
    rFrameRightF :boolean;
    rFrameBottom :boolean;
    rFrameBottomF:boolean;
    rFrameColor  :TColor;
    rFrameColorF :boolean;
    rWordWrap    :boolean;
    rWordWrapE   :boolean;
    rWordWrapF   :boolean;
    rTransparent :boolean;
    rTransparentE:boolean;
    rTransparentF:boolean;
    rBkColor     :TColor;
    rBkColorE    :boolean;
    rBkColorF    :boolean;
  end;

  TSpecCompData = record
    rLabelCaption     :string;

    rDBTextDataSet    :string;
    rDBTextDataField  :string;
    rDBTextMask       :string;

    rExprExpression   :string;
    rExprMask         :string;
    rExprMaster       :string;
    rExprResetAfterPrint :boolean;
    rExprResetAfterPrintF:boolean;

    rSysDataText      :string;
    rSysDataType      :longint;

    rMemoLines        :TStrings;

    rShapeBrushStyle  :longint;
    rShapeBrushColor  :TColor;
    rShapeBrushColorF :boolean;
    rShapePenWidth    :string;
    rShapePenStyle    :longint;
    rShapePenColor    :TColor;
    rShapePenColorF   :boolean;
    rShapeType        :longint;

    rImageStretch     :longint;
    rImageStretchF    :boolean;

    rDBImageDataSet   :string;
    rDBImageDataField :string;
    rDBImageStretch   :longint;
    rDBImageStretchF  :boolean;

    rChartDataSet     :string;
    rChartXDataField  :string;
    rChartXDateTime   :boolean;
    rChartYDataField  :string;
    rChartYDateTime   :boolean;
    rChartStairs      :boolean;

    rBarCodeType      :longint;
    rBarCodeDataSet   :string;
    rBarCodeDataField :string;
    rBarCodeClearZone :boolean;
    rBarCodeText      :string;

    rBandBandType       :longint;
    rBandAlignToBottom  :boolean;
    rBandAlignToBottomF :boolean;
    rBandForceNewColumn :boolean;
    rBandForceNewColumnF:boolean;
    rBandForceNewPage   :boolean;
    rBandForceNewPageF  :boolean;
    rBandLinkBand       :string;

    rChildBandParentBand     :string;
    rChildBandAlignToBottom  :boolean;
    rChildBandAlignToBottomF :boolean;
    rChildBandForceNewColumn :boolean;
    rChildBandForceNewColumnF:boolean;
    rChildBandForceNewPage   :boolean;
    rChildBandForceNewPageF  :boolean;
    rChildBandLinkBand       :string;

    rSubDetailMaster         :string;
    rSubDetailDataSet        :string;
    rSubDetailHeaderBand     :string;
    rSubDetailFooterBand     :string;
    rSubDetailAlignToBottom  :boolean;
    rSubDetailAlignToBottomF :boolean;
    rSubDetailForceNewColumn :boolean;
    rSubDetailForceNewColumnF:boolean;
    rSubDetailForceNewPage   :boolean;
    rSubDetailForceNewPageF  :boolean;
    rSubDetailLinkBand       :string;
    rSubDetailPrintBefore    :boolean;
    rSubDetailPrintBeforeF   :boolean;
    rSubDetailPrintIfEmpty   :boolean;
    rSubDetailPrintIfEmptyF  :boolean;

    rGroupMaster           :string;
    rGroupFooterBand       :string;
    rGroupExpression       :string;
    rGroupAlignToBottom    :boolean;
    rGroupAlignToBottomF   :boolean;
    rGroupForceNewColumn   :boolean;
    rGroupForceNewColumnF  :boolean;
    rGroupForceNewPage     :boolean;
    rGroupForceNewPageF    :boolean;
    rGroupLinkBand         :string;
    rGroupReprintOnNewPage :boolean;
    rGroupReprintOnNewPageF:boolean;

    rQuickRepDataSet       :string;
    rQuickRepTopMargin     :string;
    rQuickRepBottomMargin  :string;
    rQuickRepLeftMargin    :string;
    rQuickRepRightMargin   :string;
    rQuickRepPaperSize     :longint;
    rQuickRepColumns       :string;
    rQuickRepColumnSpace   :string;
    rQuickRepPrintIfEmpty  :boolean;
    rQuickRepPrintIfEmptyF :boolean;
  end;

  TF_QRMain = class(TForm)
    CB_Main: TControlBar;
    Panel1: TPanel;
    SB_Arrow: TSpeedButton;
    SB_QRLabel: TSpeedButton;
    SB_QRDBText: TSpeedButton;
    SB_QRExpr: TSpeedButton;
    SB_QRSysData: TSpeedButton;
    SB_QRMemo: TSpeedButton;
    SB_QRShape: TSpeedButton;
    SB_QRImage: TSpeedButton;
    SB_QRDBImage: TSpeedButton;
    SB_QRChart: TSpeedButton;
    Panel2: TPanel;
    SB_QRNew: TSpeedButton;
    SB_QROpen: TSpeedButton;
    SB_QRSave: TSpeedButton;
    Panel3: TPanel;
    SB_QRBand: TSpeedButton;
    SB_QRChildBand: TSpeedButton;
    SB_QRSubDetail: TSpeedButton;
    SB_QRGroup: TSpeedButton;
    P_Fonts: TPanel;
    CB_Fonts: TComboBox;
    SB_FontColor: TSpeedButton;
    SB_BoldFont: TSpeedButton;
    SB_ItalicFont: TSpeedButton;
    SB_ULineFont: TSpeedButton;
    CB_FontSize: TComboBox;
    CB_FontCharset: TComboBox;
    Panel5: TPanel;
    E_LeftMM: TEdit;
    E_TopMM: TEdit;
    E_WidthMM: TEdit;
    E_HeightMM: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    P_Align: TPanel;
    SB_AlignLeft: TSpeedButton;
    SB_AlignCenter: TSpeedButton;
    SB_AlignRight: TSpeedButton;
    SB_AutoSize: TSpeedButton;
    P_Frame: TPanel;
    SB_FrameLeft: TSpeedButton;
    SB_FrameTop: TSpeedButton;
    SB_FrameRight: TSpeedButton;
    SB_FrameBottom: TSpeedButton;
    E_FrameWidth: TEdit;
    Panel8: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Image2: TImage;
    E_Left: TEdit;
    E_Top: TEdit;
    E_Width: TEdit;
    E_Height: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    SB_Color: TSpeedButton;
    Panel9: TPanel;
    CB_CompName: TComboBox;
    RB_CNName: TRadioButton;
    RB_CNType: TRadioButton;
    IL_Comp: TImageList;
    I_ActComp: TImage;
    SB_FrameColor: TSpeedButton;
    P_Zoom: TPanel;
    CB_Zoom: TComboBox;
    IL_Orientation: TImageList;
    P_QRLabel: TPanel;
    E_QRLabelCaption: TEdit;
    P_QRDBText: TPanel;
    CB_QRDBTextMask: TComboBox;
    CB_QRDBTextDataSet: TComboBox;
    CB_QRDBTextDataField: TComboBox;
    SB_WordWrap: TSpeedButton;
    IL_WordWrap: TImageList;
    CB_QRExprMask: TComboBox;
    P_QRExpr: TPanel;
    CB_QRExprMaster: TComboBox;
    E_QRExprExpression: TEdit;
    SB_QRExprResetAfterPrint: TSpeedButton;
    IL_QRSysDataType: TImageList;
    I_QRSysDataType: TImage;
    Bevel2: TBevel;
    E_QRSysDataText: TEdit;
    P_QRSysData: TPanel;
    M_QRMemo: TMemo;
    P_QRMemo: TPanel;
    SB_QRImageStretch: TSpeedButton;
    P_QRImage: TPanel;
    P_QRDBImage: TPanel;
    P_QRChart: TPanel;
    P_QRShape: TPanel;
    CD_Color: TColorDialog;
    SB_Transparent: TSpeedButton;
    IL_Transparent: TImageList;
    P_FrontBack: TPanel;
    SB_BringToFront: TSpeedButton;
    SB_SendToBack: TSpeedButton;
    E_ExitControl: TEdit;
    CB_QRSysDataType: TComboBox;
    Bevel1: TBevel;
    I_QRShapeBrushStyle: TImage;
    SB_QRShapeBrushStyle: TSpeedButton;
    SB_QRShapeBrushColor: TSpeedButton;
    IL_QRShape: TImageList;
    I_QRShapePenStyle: TImage;
    SB_QRShapePenStyle: TSpeedButton;
    Bevel3: TBevel;
    SB_QRShapePenColor: TSpeedButton;
    E_QRShapePenWidth: TEdit;
    I_QRShape: TImage;
    SB_QRShapeType: TSpeedButton;
    Bevel4: TBevel;
    IL_QRShapePenStyle: TImageList;
    IL_QRShapeBrushStyle: TImageList;
    IL_QRImage: TImageList;
    SB_QRImageOpen: TSpeedButton;
    OI_Image: TOpenPictureDialog;
    SB_QRDBImageStretch: TSpeedButton;
    CB_QRDBImageDataSet: TComboBox;
    CB_QRDBImageDataField: TComboBox;
    P_QuickRep: TPanel;
    P_QRChildBand: TPanel;
    P_QRGroup: TPanel;
    P_QRBand: TPanel;
    P_QRSubDetail: TPanel;
    IL_BandType: TImageList;
    CB_QuickRepDataSet: TComboBox;
    I_QRBandBandType: TImage;
    CB_QRBandBandType: TComboBox;
    Bevel5: TBevel;
    I_TBMargin: TImage;
    I_LRMargin: TImage;
    E_QuickRepTopMargin: TEdit;
    Label9: TLabel;
    E_QuickRepBottomMargin: TEdit;
    Label10: TLabel;
    E_QuickRepLeftMargin: TEdit;
    Label11: TLabel;
    E_QuickRepRightMargin: TEdit;
    Label12: TLabel;
    CB_PaperSize: TComboBox;
    SB_QRBandAlignToBottom: TSpeedButton;
    SB_QRBandForceNewColumn: TSpeedButton;
    SB_QRBandForceNewPage: TSpeedButton;
    CB_QRBandLinkBand: TComboBox;
    SB_QRChildBandAlignToBottom: TSpeedButton;
    SB_QRChildBandForceNewColumn: TSpeedButton;
    SB_QRChildBandForceNewPage: TSpeedButton;
    CB_QRChildBandLinkBand: TComboBox;
    CB_QRChildBandParentBand: TComboBox;
    SB_QRSubDetailAlignToBottom: TSpeedButton;
    SB_QRSubDetailForceNewColumn: TSpeedButton;
    SB_QRSubDetailForceNewPage: TSpeedButton;
    CB_QRSubDetailLinkBand: TComboBox;
    CB_QRSubDetailMaster: TComboBox;
    CB_QRSubDetailDataSet: TComboBox;
    SB_QRSubDetailPrintBefore: TSpeedButton;
    SB_QRSubDetailPrintIfEmpty: TSpeedButton;
    SB_QRGroupAlignToBottom: TSpeedButton;
    SB_QRGroupForceNewColumn: TSpeedButton;
    SB_QRGroupForceNewPage: TSpeedButton;
    CB_QRGroupLinkBand: TComboBox;
    CB_QRGroupMaster: TComboBox;
    SB_QRGroupReprintOnNewPage: TSpeedButton;
    CB_QRGroupFooterBand: TComboBox;
    E_QRGroupExpression: TEdit;
    CB_QRSubDetailHeaderBand: TComboBox;
    CB_QRSubDetailFooterBand: TComboBox;
    Label13: TLabel;
    E_QuickRepColumnSpace: TEdit;
    E_QuickRepColumns: TEdit;
    SB_QuickRepPrintIfEmpty: TSpeedButton;
    SB_QuickRepDescription: TSpeedButton;
    SB_QuickRepFunctions: TSpeedButton;
    I_Columns: TImage;
    IL_ForceNewColumn: TImageList;
    IL_ForceNewPage: TImageList;
    IL_PrintIfEmpty: TImageList;
    IL_ReprintOnNewPage: TImageList;
    IL_PrintBefore: TImageList;
    IL_AlignToBottom: TImageList;
    OD_File: TOpenDialog;
    SD_File: TSaveDialog;
    Panel4: TPanel;
    CB_Level: TComboBox;
    SB_QRNewSpec: TSpeedButton;
    CB_QRSubDetailDataModule: TComboBox;
    CB_QRDBImageDataModule: TComboBox;
    CB_QuickRepDataModule: TComboBox;
    CB_QRDBTextDataModule: TComboBox;
    P_QRBarCode: TPanel;
    CB_QRBarCodeType: TComboBox;
    CB_QRBarCodeDataSet: TComboBox;
    CB_QRBarCodeDataField: TComboBox;
    CB_QRBarCodeDataModule: TComboBox;
    SB_QRBarCode: TSpeedButton;
    Panel6: TPanel;
    SB_Orientation: TSpeedButton;
    SB_Preview: TSpeedButton;
    E_QRBarCodeText: TEdit;
    SB_QRBarCodeClearZone: TSpeedButton;
    IL_ClearZone: TImageList;
    CB_QRChartDataModule: TComboBox;
    CB_QRChartDataSet: TComboBox;
    CB_QRChartXDataField: TComboBox;
    CB_QRChartYDataField: TComboBox;
    SB_QRChartStairs: TSpeedButton;
    IL_ChartStairs: TImageList;
    ChB_ChartXDateTime: TCheckBox;
    ChB_ChartYDateTime: TCheckBox;
    CB_QRDBTextDataFullname: TComboBox;

    procedure IcQuickRepMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure IcQuickRepMouseDown (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

    procedure IcQRSubDetailMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure IcQRSubDetailMouseDown (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure IcQRBandMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure IcQRBandMouseDown (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure IcQRChildBandMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure IcQRChildBandMouseDown (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure IcQRGroupMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure IcQRGroupMouseDown (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

    procedure IcQRLabelMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure IcQRLabelMouseDown (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure IcQRDBTextMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure IcQRDBTextMouseDown (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure IcQRExprMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure IcQRExprMouseDown (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure IcQRSysDataMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure IcQRSysDataMouseDown (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure IcQRMemoMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure IcQRMemoMouseDown (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure IcQRShapeMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure IcQRShapeMouseDown (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure IcQRImageMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure IcQRImageMouseDown (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure IcQRDBImageMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure IcQRDBImageMouseDown (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure IcQRChartMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure IcQRChartMouseDown (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure IcQRBarCodeMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure IcQRBarCodeMouseDown (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

    procedure IcCompMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure IcCompMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure IcCompKeyDown (Sender: TObject; var Key: Word; Shift: TShiftState);

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SB_QRExprClick(Sender: TObject);
    procedure SB_QRNewClick(Sender: TObject);
    procedure SB_QRSubDetailClick(Sender: TObject);
    procedure SB_QRBandClick(Sender: TObject);
    procedure SB_QRChildBandClick(Sender: TObject);
    procedure SB_QRGroupClick(Sender: TObject);
    procedure SB_QRSaveClick(Sender: TObject);
    procedure SB_QROpenClick(Sender: TObject);
    procedure CB_CompNameClick(Sender: TObject);
    procedure SB_ArrowClick(Sender: TObject);
    procedure SB_SetButtFix(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SB_QRLabelClick(Sender: TObject);
    procedure SB_QRDBTextClick(Sender: TObject);
    procedure SB_QRSysDataClick(Sender: TObject);
    procedure SB_QRMemoClick(Sender: TObject);
    procedure SB_QRShapeClick(Sender: TObject);
    procedure SB_QRImageClick(Sender: TObject);
    procedure SB_QRDBImageClick(Sender: TObject);
    procedure SB_QRChartClick(Sender: TObject);
    procedure RB_CNTypeClick(Sender: TObject);
    procedure CB_CompNameChange(Sender: TObject);
    procedure CB_CompNameExit(Sender: TObject);
    procedure CB_ZoomClick(Sender: TObject);
    procedure SB_OrientationClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ReturnExit(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SB_PreviewClick(Sender: TObject);
    procedure E_LeftExit(Sender: TObject);
    procedure E_TopExit(Sender: TObject);
    procedure E_WidthExit(Sender: TObject);
    procedure E_HeightExit(Sender: TObject);
    procedure E_LeftMMExit(Sender: TObject);
    procedure E_TopMMExit(Sender: TObject);
    procedure E_WidthMMExit(Sender: TObject);
    procedure E_HeightMMExit(Sender: TObject);
    procedure SB_ColorClick(Sender: TObject);
    procedure SB_AlignClick(Sender: TObject);
    procedure SB_AutoSizeClick(Sender: TObject);
    procedure SB_WordWrapClick(Sender: TObject);
    procedure E_QRLabelCaptionChange(Sender: TObject);
    procedure CB_FontsExit(Sender: TObject);
    procedure SB_TransparentClick(Sender: TObject);
    procedure SB_BringToFrontClick(Sender: TObject);
    procedure SB_SendToBackClick(Sender: TObject);
    procedure CB_FontSizeExit(Sender: TObject);
    procedure SB_BoldFontClick(Sender: TObject);
    procedure SB_ItalicFontClick(Sender: TObject);
    procedure SB_ULineFontClick(Sender: TObject);
    procedure SB_FontColorClick(Sender: TObject);
    procedure CB_FontCharsetChange(Sender: TObject);
    procedure SB_FrameColorClick(Sender: TObject);
    procedure SB_FrameLeftClick(Sender: TObject);
    procedure SB_FrameTopClick(Sender: TObject);
    procedure SB_FrameRightClick(Sender: TObject);
    procedure SB_FrameBottomClick(Sender: TObject);
    procedure M_QRMemoChange(Sender: TObject);
    procedure CB_QRSysDataTypeChange(Sender: TObject);
    procedure E_QRSysDataTextChange(Sender: TObject);
    procedure SB_QRShapeBrushColorClick(Sender: TObject);
    procedure SB_QRShapeBrushStyleClick(Sender: TObject);
    procedure SB_QRShapePenColorClick(Sender: TObject);
    procedure SB_QRShapePenStyleClick(Sender: TObject);
    procedure SB_QRShapeTypeClick(Sender: TObject);
    procedure SB_QRImageOpenClick(Sender: TObject);
    procedure SB_QRImageStretchClick(Sender: TObject);
    procedure CB_QRDBTextDataSetChange(Sender: TObject);
    procedure CB_QRDBTextDataFieldChange(Sender: TObject);
    procedure CB_QRDBTextDataFullnameChange(Sender: TObject);
    procedure CB_QRDBTextMaskExit(Sender: TObject);
    procedure E_QRExprExpressionExit(Sender: TObject);
    procedure CB_QRExprMaskExit(Sender: TObject);
    procedure CB_QRExprMasterChange(Sender: TObject);
    procedure SB_QRExprResetAfterPrintClick(Sender: TObject);
    procedure CB_QRDBImageDataSetChange(Sender: TObject);
    procedure CB_QRDBImageDataFieldChange(Sender: TObject);
    procedure SB_QRDBImageStretchClick(Sender: TObject);
    procedure CB_QuickRepDataSetChange(Sender: TObject);
    procedure CB_QRBandBandTypeChange(Sender: TObject);
    procedure E_QuickRepTopMarginExit(Sender: TObject);
    procedure E_QuickRepBottomMarginExit(Sender: TObject);
    procedure E_QuickRepLeftMarginExit(Sender: TObject);
    procedure E_QuickRepRightMarginExit(Sender: TObject);
    procedure CB_PaperSizeChange(Sender: TObject);
    procedure CB_QRBandLinkBandChange(Sender: TObject);
    procedure SB_QRBandAlignToBottomClick(Sender: TObject);
    procedure SB_QRBandForceNewColumnClick(Sender: TObject);
    procedure SB_QRBandForceNewPageClick(Sender: TObject);
    procedure CB_QRChildBandParentBandChange(Sender: TObject);
    procedure SB_QRChildBandAlignToBottomClick(Sender: TObject);
    procedure SB_QRChildBandForceNewColumnClick(Sender: TObject);
    procedure SB_QRChildBandForceNewPageClick(Sender: TObject);
    procedure CB_QRChildBandLinkBandChange(Sender: TObject);
    procedure CB_QRSubDetailMasterChange(Sender: TObject);
    procedure CB_QRSubDetailDataSetChange(Sender: TObject);
    procedure CB_QRSubDetailHeaderBandChange(Sender: TObject);
    procedure CB_QRSubDetailFooterBandChange(Sender: TObject);
    procedure SB_QRSubDetailAlignToBottomClick(Sender: TObject);
    procedure SB_QRSubDetailForceNewColumnClick(Sender: TObject);
    procedure SB_QRSubDetailForceNewPageClick(Sender: TObject);
    procedure CB_QRSubDetailLinkBandChange(Sender: TObject);
    procedure SB_QRSubDetailPrintBeforeClick(Sender: TObject);
    procedure SB_QRSubDetailPrintIfEmptyClick(Sender: TObject);
    procedure CB_QRGroupMasterChange(Sender: TObject);
    procedure CB_QRGroupFooterBandChange(Sender: TObject);
    procedure E_QRGroupExpressionExit(Sender: TObject);
    procedure SB_QRGroupAlignToBottomClick(Sender: TObject);
    procedure SB_QRGroupForceNewColumnClick(Sender: TObject);
    procedure SB_QRGroupForceNewPageClick(Sender: TObject);
    procedure CB_QRGroupLinkBandChange(Sender: TObject);
    procedure SB_QRGroupReprintOnNewPageClick(Sender: TObject);
    procedure E_QuickRepColumnsExit(Sender: TObject);
    procedure SB_QuickRepPrintIfEmptyClick(Sender: TObject);
    procedure E_QuickRepColumnSpaceExit(Sender: TObject);
    procedure E_FrameWidthExit(Sender: TObject);
    procedure E_QRShapePenWidthExit(Sender: TObject);
    procedure SB_QuickRepDescriptionClick(Sender: TObject);
    procedure SB_QuickRepFunctionsClick(Sender: TObject);
    procedure CB_LevelChange(Sender: TObject);
    procedure SB_QRNewSpecClick(Sender: TObject);
    procedure CB_QRDBTextDataModuleChange(Sender: TObject);
    procedure CB_QRDBImageDataModuleChange(Sender: TObject);
    procedure CB_QRSubDetailDataModuleChange(Sender: TObject);
    procedure CB_QuickRepDataModuleChange(Sender: TObject);
    procedure SB_QRBarCodeClick(Sender: TObject);
    procedure SB_QRBarCodeClearZoneClick(Sender: TObject);
    procedure CB_QRBarCodeDataModuleChange(Sender: TObject);
    procedure CB_QRBarCodeDataSetChange(Sender: TObject);
    procedure CB_QRBarCodeDataFieldChange(Sender: TObject);
    procedure E_QRBarCodeTextExit(Sender: TObject);
    procedure CB_QRBarCodeTypeChange(Sender: TObject);
    procedure SB_QRChartStairsClick(Sender: TObject);
    procedure CB_QRChartDataModuleChange(Sender: TObject);
    procedure CB_QRChartDataSetChange(Sender: TObject);
    procedure CB_QRChartXDataFieldChange(Sender: TObject);
    procedure CB_QRChartYDataFieldChange(Sender: TObject);
    procedure ChB_ChartXDateTimeClick(Sender: TObject);
    procedure ChB_ChartYDateTimeClick(Sender: TObject);
  private
    oQuickRep:TIcQuickRep;
    oX      : longint;
    oY      : longint;
    oXC     : longint;           // X-ova poloha kurzora pri stlaceni tlacitka mysi
    oYC     : longint;           // Y-ova poloha kurzora pri stlaceni tlacitka mysi
    oButDown: boolean;           // urcuje ci bolo stalaene tlacitko mysi
    oShift  : TShiftState;       // stav naposledy stalcenej klavesy
    oCompList: TStringList;      // zoznam oznacenych komponentov
    oCopyList: TStringList;      // zoznam komponentov ktore sa budu kopirovat
    oCF      : Textfile;         // subor pre Export oznacenych komponentov
    oOldCompName: string;        // povodny nazov kopirovane komponentu
    oNewCompName: string;        // novy nazov kopirovaneho komponentu
    oReadLine   : string;        // nacitany riadok zo suboru copycomp.$$$
    oParentname : string;        // nazov Bandu na ktory sa kopiruju nove komponenty
    oSizingType:byte;            // sposob zmeny velkosti kompontu
    oAddComp: longint;           // urcuje aky typ komponnetu sa bude pridavat
    oCtrlMouse: boolean;         // urcuje ci bola stalcena kalvesa CTRL
    oBegX   : longint;           // X - laveho horneho rohu obdlznika vykreslovaneho pri oznacovani kommponentov s mysou + CTRL
    oBegY   : longint;           // Y - laveho horneho rohu obdlznika vykreslovaneho pri oznacovani kommponentov s mysou + CTRL
    oEndX   : longint;           // X - praveho dolneho rohu obdlznika vykreslovaneho pri oznacovani kommponentov s mysou + CTRL
    oEndY   : longint;           // Y - praveho dolneho rohu obdlznika vykreslovaneho pri oznacovani kommponentov s mysou + CTRL
    oXYList : TStringList;       // zoznam komponentov tlacovej zostavy
    oButtFix: boolean;           // viacnasobne vkladanie vybraneho komponentu po stalceni klavesu SHIFT s kliknutim mysi na prislusny typ komponentu
    oCompType    : longint;      // urcuje typ oznaceneho resp. oznacenych komponentov - ak su oznacene rozne druhy tak je "-1"
    oCompNameChange: boolean;    // urcuje ci bol zmeneny nazov komponentu
    oFirstActivate: boolean;     // urcuje ci bol aktivovany formular pri jeho vytvarani (t.j. po prvy krat) alebo pri zmene aktivneho okna
    oCompData    : TCompData;    // standarne parametre komponentu ktore su spolocne takmer pre vsetky typy komponentov
    oSpecCompData: TSpecCompData;// specialne parametre komponentu
    oRepFile     : string;       // nazov tlacovej zostavy
    oChange      : boolean;      // urcuej ci bola nejaka zmena v tlacovej zostave
    oShowing     : boolean;      // zobrazovanie parametrov spracovavaneho komponentu
    oRepMask     : string;       // nazov tlacovej zostavy

    procedure Fill_IL_QRShapePenStyle;   // vykreslenie ikony pre typ ciary v utvare
    procedure Fill_IL_QRShapeBrushStyle; // vykreslenie ikony pre typ vyplne v utvare
    procedure FillDataModules;           // nacitanie datamodulov do comboboxov
//    procedure FillDataSets;
    procedure FillDBTextDataSet;         // nacitanie databaz pouziteho datamodulu do Comboboxu pre vyber databazy pre komponent QRDBText
    procedure FillDBImageDataSet;        // nacitanie databaz pouziteho datamodulu do Comboboxu pre vyber databazy pre komponent QRDBImage
    procedure FillQuickRepDataSet;       // nacitanie databaz pouziteho datamodulu do Comboboxu pre vyber databazy pre tlacovu zostavu
    procedure FillSubDetailDataSet;      // nacitanie databaz pouziteho datamodulu do Comboboxu pre vyber databazy pre komponent QRSubDetail
    procedure FillChartDataSet;          // nacitanie databaz pouziteho datamodulu do Comboboxu pre vyber databazy pre komponent QRChart
    procedure FillBarCodeDataSet;        // nacitanie databaz pouziteho datamodulu do Comboboxu pre vyber databazy pre komponent QRBarCode
    procedure FillMaster;                // nacitanie subdetailbandov do comboboxu pre vyber pola MAster komponentov QRExpr QRSubdetailBand a QRGroupBand

    procedure SetTableActive (Value:boolean); // otvorenie vsetkych databaz puzitych v tlacovej zostave
    function  GetIndexPos (pStrings:TStrings; pS:string):longint; // vyhladanie pozicie vyskytu retazca v poli retazcov "TStrings"
    procedure IcCompMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer; pSelected:boolean);
    // Pohyb mysou nad komponentom tlacovej zostavy
    procedure IcCompClick(Sender: TObject);
    // kliknutie mysou nad komponentom tlacovej zostavy
    procedure CompRepaint (pName:string);           // prekreslenie zadaneho komponentu
    procedure SetSelected (pName:string;pSelected:boolean); // zaradi komponent do zoznamu vybranyh komponentov
    function  IsSelected (pName:string):boolean;    // vracia ci je zadany komponent oznaceny
    procedure SetActCompImage;                      // zobrazenie ikony vybraneho komponentu
    procedure FillActCompParam (pComp:string);      // nacitanie chrakteristik zadaneho komponentu
    procedure ShowActCompParam;                     // zobrazenie chrakteristik aktualneho komponentu
    procedure SetActCompParam (pScreenShow:boolean);// nacitanie a zobrazenie chrakteristik aktualneho komponentu

    procedure AddComponents (pName:string;pX,pY:longint); // pridanie komponentu na zadanu poziciu
    procedure AddLabel (pName:string);
    procedure AddDBText (pName:string);
    procedure AddExpr (pName:string);
    procedure AddSysData (pName:string);
    procedure AddMemo (pName:string);
    procedure AddShape (pName:string);
    procedure AddImage (pName:string);
    procedure AddDBImage (pName:string);
    procedure AddChart (pName:string);
    procedure AddBarCode (pName:string);

    procedure SelectComp (pName:string); // zaradenie komponentu do zoznamu vybranych komponentov
    procedure ClearSelectComp;           // zrusenie zoznamu vybranych komponentov
    procedure DeleteComponents;          // zrusenie oznacenych komponentov
    procedure CopyComponents;
    // zapisanie oznacenych komponentov do zoznamu CopyList
    procedure ExportActCompParam (pComp:string);
    // zapis property oznaceneho komponentu do textoveho suboru
    procedure PasteComponents(Sender: TObject);
    // vytvorenie novych komponentov z predtym oznacenych komponentov v CopyList
    procedure PasteQRLabel  ; // vlozi novy IcQRLabel    komponent
    procedure PasteQRDBText ; // vlozi novy IcQRDBtext   komponent
    procedure PasteQRExpr   ; // vlozi novy IcQRExpr     komponent
    procedure PasteQRSysData; // vlozi novy IcQRSysdata  komponent
    procedure PasteQRMemo   ; // vlozi novy IcQRmemo     komponent
    procedure PasteQRShape  ; // vlozi novy IcQRShape    komponent
    procedure PasteQRImage  ; // vlozi novy IcQRImage    komponent
    procedure PasteQRDBImage; // vlozi novy IcQRDBImage  komponent
    procedure PasteQRChart  ; // vlozi novy IcQRChart    komponent
    procedure PasteQRBarCode; // vlozi novy IcQRBarCode  komponent
    function  GetCharSetPos (pNum:longint):longint;
    function  GetResizeComp (Sender: TObject):boolean;

    procedure FillCompNames;  // naplnenie zoznamu komponentov
    procedure FillXYList;     // nacitanie komponento tlacovej zostavy zo zoznamu vsetkych komponentov
    function  FindInXYList (pName:string):longint; // vyhladanie komponentu v zozname vsetkych komponentov

    procedure MoveLeftSel;    // nastavenie kurzora na predosly komponenet pri stlaceni klavesy "<="
    procedure MoveRightSel;   // nastavenie kurzora na nasledujuci komponenet pri stlaceni klavesy "=>"
    procedure MoveUpComp;     // posun komponentu hore
    procedure MoveLeftComp;   // posun komponentu vlavo
    procedure MoveDownComp;   // posun komponentu dole
    procedure MoveRightComp;  // posun komponentu vpravo
    procedure HeightDecComp;  // zmensenie vysky komponentu
    procedure WidthDecComp;   // zmensenie sirky komponentu
    procedure HeightIncComp;  // zvacsenie vysky komponentu
    procedure WidthIncComp;   // zvacsenie sirky komponentu
    procedure ChangeCompCoord (pDX,pDY,pDW,pDH:longint); // posun resp. zmena vlekosti komponentu

    procedure ClearFontsParam;// nastavenie zakladnych parametrov pre pouzity typ pisma aktualneho kompobnentu
    procedure SetNotSelComponents; // nulovanie standardnych a specialnych parametrov komponentu

    procedure SetAlignPanel;       // nastavenie zobrazenia "ALIGN" parametrov vybraneho komponentu v tlacovom manageri
    procedure SetFontPanel;        // nastavenie zobrazenia "FONT"  parametrov vybraneho komponentu v tlacovom manageri
    procedure SetFramePanel;       // nastavenie zobrazenia "FRAME" parametrov vybraneho komponentu v tlacovom manageri
    procedure SetBkColor;          // nastavenie zobrazenia "COLOR" parametrov vybraneho komponentu v tlacovom manageri
    procedure SetWordWrap;         // nastavenie zobrazenia "zarovnania" vybraneho komponentu v tlacovom manageri
    procedure SetTransparent;      // nastavenie zobrazenia "priehladnosti" vybraneho komponentu v tlacovom manageri

    procedure HideAllSpecPanels;   // skryke vsetky panely s vlastnostami vybraneho komponentu v tlacovom manageri
    procedure ShowSpecParams;
    procedure ShowQRLabelParams;
    procedure ShowQRDBTextParams;
    procedure ShowQRExprParams;
    procedure ShowQRSysDataParams;
    procedure ShowQRMemoParams;
    procedure ShowQRShapeParams;
    procedure ShowQRImageParams;
    procedure ShowQRDBImageParams;
    procedure ShowQRChartParams;
    procedure ShowQRBarCodeParams;
    procedure ShowQuickRepParams;
    procedure ShowQRBandParams;
    procedure ShowQRChildBandParams;
    procedure ShowQRSubDetailParams;
    procedure ShowQRGroupParams;

    // nastavovanie jednotlivych parametrov komponentov
    procedure SetCompLeft (Value:longint);
    procedure SetCompTop (Value:longint);
    procedure SetCompWidth (Value:longint);
    procedure SetCompHeight (Value:longint);
    procedure SetCompLeftMM (Value:double);
    procedure SetCompTopMM (Value:double);
    procedure SetCompWidthMM (Value:double);
    procedure SetCompHeightMM (Value:double);
    procedure SetCompColor (Value:TColor);
    procedure SetCompAlign (Value:TAlignment);
    procedure SetCompAutoSize (Value:boolean);
    procedure SetCompWordWrap (Value:boolean);
    procedure SetCompTransparent (Value:boolean);
    procedure SetCompCaption (Value:string);
    procedure SetCompFontName (Value:string);
    procedure SetCompFontSize (Value:longint);
    procedure SetCompBoldFont (Value:boolean);
    procedure SetCompItalicFont (Value:boolean);
    procedure SetCompULineFont (Value:boolean);
    procedure SetCompFontColor (Value:TColor);
    procedure SetCompFontCharset (Value:longint);
    procedure SetCompFrameColor (Value:TColor);
    procedure SetCompFrameWidth (Value:longint);
    procedure SetCompFrameLeft (Value:boolean);
    procedure SetCompFrameTop (Value:boolean);
    procedure SetCompFrameRight (Value:boolean);
    procedure SetCompFrameBottom (Value:boolean);
    procedure SetCompMemo (Value:TStrings);
    procedure SetCompSysDataType (Value:longint);
    procedure SetCompSysDataText (Value:string);
    procedure SetCompShapeBrushStyle (Value:longint);
    procedure SetCompShapeBrushColor (Value:TColor);
    procedure SetCompShapePenWidth (Value:longint);
    procedure SetCompShapePenColor (Value:TColor);
    procedure SetCompShapePenStyle (Value:longint);
    procedure SetCompShapeType (Value:longint);
    procedure SetCompImageLoad (Value:string);
    procedure SetCompImageStretch (Value:longint);
    procedure SetCompDBTextFieldName (Value:string);
    procedure SetCompDBTextDataSet (Value:string);
    procedure SetCompDBTextMask (Value:string);
    procedure SetCompExprExpression (Value:string);
    procedure SetCompExprMask (Value:string);
    procedure SetCompExprMaster (Value:string);
    procedure SetCompExprResetAfterPrint (Value:boolean);
    procedure SetCompDBImageDataSet (Value:string);
    procedure SetCompDBImageFieldName (Value:string);
    procedure SetCompDBImageStretch (Value:longint);
    procedure SetCompQuickRepDataSet (Value:string);
    procedure SetCompBandBandType (Value:longint);
    procedure SetCompMargTop (Value:double);
    procedure SetCompMargBottom (Value:double);
    procedure SetCompMargLeft (Value:double);
    procedure SetCompMargRight (Value:double);
    procedure SetCompPaperSize (Value:longint);
    procedure SetCompQuickRepColumns (Value:longint);
    procedure SetCompQuickRepColumnSpace (Value:longint);
    procedure SetCompQuickRepPrintIfEmpty (Value:boolean);
    procedure SetCompBandLinkBand (Value:string);
    procedure SetCompBandAlignToBottom (Value:boolean);
    procedure SetCompBandForceNewColumn (Value:boolean);
    procedure SetCompBandForceNewPage (Value:boolean);
    procedure SetCompChildBandParentBand (Value:string);
    procedure SetCompChildBandLinkBand (Value:string);
    procedure SetCompChildBandAlignToBottom (Value:boolean);
    procedure SetCompChildBandForceNewColumn (Value:boolean);
    procedure SetCompChildBandForceNewPage (Value:boolean);
    procedure SetCompSubDetailMaster (Value:string);
    procedure SetCompSubDetailDataSet (Value:string);
    procedure SetCompSubDetailHeaderBand (Value:string);
    procedure SetCompSubDetailFooterBand (Value:string);
    procedure SetCompSubDetailAlignToBottom (Value:boolean);
    procedure SetCompSubDetailForceNewColumn (Value:boolean);
    procedure SetCompSubDetailForceNewPage (Value:boolean);
    procedure SetCompSubDetailLinkBand (Value:string);
    procedure SetCompSubDetailPrintBefore (Value:boolean);
    procedure SetCompSubDetailPrintIfEmpty (Value:boolean);
    procedure SetCompGroupMaster (Value:string);
    procedure SetCompGroupFooterBand (Value:string);
    procedure SetCompGroupExpression (Value:string);
    procedure SetCompGroupAlignToBottom (Value:boolean);
    procedure SetCompGroupForceNewColumn (Value:boolean);
    procedure SetCompGroupForceNewPage (Value:boolean);
    procedure SetCompGroupLinkBand (Value:string);
    procedure SetCompGroupReprintOnNewPage (Value:boolean);

    procedure SetCompChartDataSet (Value:string);
    procedure SetCompChartStairs (Value:boolean);
    procedure SetCompChartXFieldName (Value:string);
    procedure SetCompChartXDateTime (Value:boolean);
    procedure SetCompChartYFieldName (Value:string);
    procedure SetCompChartYDateTime (Value:boolean);

    procedure SetCompBarCodeDataSet (Value:string);
    procedure SetCompBarCodeFieldName (Value:string);
    procedure SetCompBarCodeClearZone (Value:boolean);
    procedure SetCompBarCodeText (Value:string);
    procedure SetCompBarCodeType (Value:longint);

    function  SetMultiLong (pText:string;pData:longint):string;
              // porovna pText a pData a ak su rovnake alebo pText='' tak vrati pData inak vrati ''
    function  SetMultiDoub (pText:string;pData:double):string;
              // porovna pText a pData a ak su rovnake alebo pText='' tak vrati pData inak vrati ''
    procedure SetMultiAutoSize (pEnabled,pAutoSize: boolean);
              // porovna pText a pData a ak su rovnake alebo pText='' tak vrati pData inak vrati ''
    procedure SetMultiAlignment (pEnabled: boolean; pAlignment: TAlignment);
              // nastavenie zarovnania a dostupnosti tlacitka pre zmenu zarovnania komponentov
    procedure SetMultiFont (pEnabled:boolean; pFont:TFont);
              // nastavenie fontu a dostupnosti poli managera pre zmenu fontu komponentov
    procedure SetMultiFontName (pFontName:string);
              // nastavenie nazvu fontu a dostupnosti vyberoveho pola managera pre zmenu nazvu fontu komponentov
    procedure SetMultiFontSize (pFontSize:longint);
              // nastavenie velkosti fontu a dostupnosti pola managera pre zmenu velkosti fontu komponentov
    procedure SetMultiFontStyle (pFontStyle:TFontStyles);
              // nastavenie typu fontu a dostupnosti poli managera pre zmenu typu fontu komponentov
    procedure SetMultiFontColor (pFontColor:TColor);
              // nastavenie farby fontu a dostupnosti pola managera pre zmenu farby fontu komponentov
    procedure SetMultiFontCharset (pFontCharset:longint);
              // nastavenie znakovej sady fontu a dostupnosti pola managera pre vyber zankovej sady fontu komponentov
    procedure SetMultiWordWrap (pEnabled,pWordWrap:boolean);
              // nastavenie rozdelovnia riadkov textu a dostupnosti pola managera pre nastavenie tohto parametra komponentov
    procedure SetMultiBkColor (pEnabled:boolean; pBkColor:TColor);
              // nastavenie farby pozadia a dostupnosti pola managera pre nastavenie tohto parametra komponentov
    procedure SetMultiTransparent (pEnabled,pTransparent:boolean);
              // nastavenie priehladnosti a dostupnosti pola managera pre nastavenie tohto parametra komponentov
    procedure SetMultiFrame (pFrame:TQRFrame);
              // nastavenie ramcekov a dostupnosti pola managera pre nastavenie ramcekov komponentov
    procedure SetMultiFrameWidth (pWidth:longint);
              // nastavenie sirky ramceka a dostupnosti pola managera pre nastavenie tohto parametra komponentov
    procedure SetMultiFrameLeft (pLeft:boolean);
              // nastavenie laveho ramceka a dostupnosti pola managera pre nastavenie tohto parametra komponentov
    procedure SetMultiFrameTop (pTop:boolean);
              // nastavenie horneho ramceka a dostupnosti pola managera pre nastavenie tohto parametra komponentov
    procedure SetMultiFrameRight (pRight:boolean);
              // nastavenie praveho ramceka a dostupnosti pola managera pre nastavenie tohto parametra komponentov
    procedure SetMultiFrameBottom (pBottom:boolean);
              // nastavenie dolneho ramceka a dostupnosti pola managera pre nastavenie tohto parametra komponentov
    procedure SetMultiFrameColor (pColor:TColor);
              // nastavenie farby ramceka a dostupnosti pola managera pre nastavenie tohto parametra komponentov

    procedure SetMultiLabelCaption (pLabel:string);
              // nastavenie titulku a dostupnosti pola managera pre nastavenie tohto parametra komponentov

    procedure SetMultiDBTextDataSet (pDataSet:string);
              // nastavenie databazy a dostupnosti pola managera pre vyber databazy komponentov
    procedure SetMultiDBTextDataField (pDataSet,pDataField:string);
              // nastavenie databazoveho pola a dostupnosti pola managera pre vyber databazoveho pola komponentov
    procedure SetMultiDBTextMask (pMask:string);
              // nastavenie masky databazoveho pola a dostupnosti pola managera pre nastavenie tohoto parametra komponentov

    procedure SetMultiExprExpression (pExpr:string);
    procedure SetMultiExprMask (pMask:string);
    procedure SetMultiExprMaster (pMaster:string);
    procedure SetMultiExprResetAfterPrint (pReset:boolean);

    procedure SetMultiSysDataText (pText:string);
    procedure SetMultiSysDataType (pType:TQRSysDataType);

    procedure SetMultiMemoLines (pMemo:TStrings);

    procedure SetMultiShapeBrushStyle (pBrushStyle:TBrushStyle);
    procedure SetMultiShapeBrushColor (pBrushColor:TColor);
    procedure SetMultiShapePenWidth (pPenWidth:longint);
    procedure SetMultiShapePenStyle (pPenStyle:TPenStyle);
    procedure SetMultiShapePenColor (pPenColor:TColor);
    procedure SetMultiShapeType (pShape:TQRShapeType);

    procedure SetMultiImageStretch (pStretch, pCenter:boolean);

    procedure SetMultiDBImageDataSet (pDataSet:string);
    procedure SetMultiDBImageDataField (pDataSet,pDataField:string);
    procedure SetMultiDBImageStretch (pStretch, pCenter:boolean);

    procedure SetMultiChartStairs (pChartStairs:boolean);
    procedure SetMultiChartDataSet (pDataSet:string);
    procedure SetMultiChartXDataField (pDataSet,pDataField:string);
    procedure SetMultiChartXDateTime (pDateTime:boolean);
    procedure SetMultiChartYDataField (pDataSet,pDataField:string);
    procedure SetMultiChartYDateTime (pDateTime:boolean);

    procedure SetMultiBarCodeType (pType:TBarCodeType);
    procedure SetMultiBarCodeText (pText:string);
    procedure SetMultiBarCodeClearZone (pClearZone:boolean);
    procedure SetMultiBarCodeDataSet (pDataSet:string);
    procedure SetMultiBarCodeDataField (pDataSet,pDataField:string);

    procedure SetMultiBandBandType (pBandType:TQRBandType);
    procedure SetMultiBandAlignToBottom (pAlignToBottom:boolean);
    procedure SetMultiBandForceNewColumn (pForceNewColumn:boolean);
    procedure SetMultiBandForceNewPage (pForceNewPage:boolean);
    procedure SetMultiBandLinkBand (pLinkBand:string);

    procedure SetMultiChildBandParentBand (pParentBand:string);
    procedure SetMultiChildBandAlignToBottom (pAlignToBottom:boolean);
    procedure SetMultiChildBandForceNewColumn (pForceNewColumn:boolean);
    procedure SetMultiChildBandForceNewPage (pForceNewPage:boolean);
    procedure SetMultiChildBandLinkBand (pLinkBand:string);

    procedure SetMultiSubDetailMaster (pMaster:string);
    procedure SetMultiSubDetailDataSet (pDataSet:string);
    procedure SetMultiSubDeatilHeaderBand (pHeaderBand:string);
    procedure SetMultiSubDetailFooterBand (pFooterBand:string);
    procedure SetMultiSubDetailAlignToBottom (pAlignToBottom:boolean);
    procedure SetMultiSubDetailForceNewColumn (pForceNewColumn:boolean);
    procedure SetMultiSubDetailForceNewPage (pForceNewPage:boolean);
    procedure SetMultiSubDetailLinkBand (pLinkBand:string);
    procedure SetMultiSubDetailPrintBefore (pPrintBefore:boolean);
    procedure SetMultiSubDetailPrintIfEmpty (pPrintIfEmpty:boolean);

    procedure SetMultiGroupMaster (pMaster:string);
    procedure SetMultiGroupFooterBand (pFooterBand:string);
    procedure SetMultiGroupExpression (pExpression:string);
    procedure SetMultiGroupAlignToBottom (pAlignToBottom:boolean);
    procedure SetMultiGroupForceNewColumn (pForceNewColumn:boolean);
    procedure SetMultiGroupForceNewPage (pForceNewPage:boolean);
    procedure SetMultiGroupLinkBand (pLinkBand:string);
    procedure SetMultiGroupReprintOnNewPage (pReprintOnNewPage:boolean);

    procedure SetMultiQuickRepDataSet (pDataSet:string);
    procedure SetMultiQuickRepTopMargin (pTopMargin:double);
    procedure SetMultiQuickRepBottomMargin (pBottomMargin:double);
    procedure SetMultiQuickRepLeftMargin (pLeftMargin:double);
    procedure SetMultiQuickRepRightMargin (pRightMargin:double);
    procedure SetMultiQuickRepPaperSize (pPaperSize:TQRPaperSize);
    procedure SetMultiQuickRepColumns (pColumns:longint);
    procedure SetMultiQuickRepColumnSpace (pColumnSpace:double);
    procedure SetMultiQuickRepPrintIfEmpty  (pPrintIfEmpty:boolean);
    procedure MyPreview (Sender:TObject);

    procedure ConvObjToText (pSrc,pTrg:string); // prevod DFM suboru z Objektoveho na Textovy
    procedure ConvTextToObj (pSrc,pTrg:string); // prevod DFM suboru z textoveho na Objektoveho

    // pridanie komponentov so specifikovanymi nastaveniami vlastnosti komponentov
    procedure AddSpecBand (Sender:TObject;pName:string;pType:TQRBandType;pHeight:longint);
    procedure AddSpecExpr (pName,pBand,pExpression,pMask:string;pAlign:TAlignment;pLeft,pTop,pWidth:longint);
    procedure AddSpecLabel (pName,pBand,pCaption:string;pAlign:TAlignment;pLeft,pTop,pWidth:longint;pFontSize:longint;pFontStyle:TFontStyles);
    procedure AddSpecSysData (pName,pBand:string;pData:TQRSysDataType;pAlign:TAlignment;pLeft,pTop,pWidth:longint);
    procedure AddSpecDBText (pName,pBand,pField,pMask:string;pDataSet:TDataSet;pAlign:TAlignment;pLeft,pTop,pWidth:longint);
    procedure AddSpecShape (pName,pBand:string;pLeft,pTop,pHeight:longint);

    // vytvorenie prednastavenej tlacovej zostavy so standardnymi komponentami
    procedure SetSpecTitleBand (Sender:TObject);
    procedure SetSpecPageFooter (Sender:TObject);
    procedure SetSpecItems (Sender:TObject);

    { Private declarations }
  public
    // samotne spustenie tlacoveho managera
    procedure Execute (pMask:string);
    // nacitani poli zadanej databazy do pola retazcov "TStrings"
    function  FillFieldNames (Value:string):TStrings;
    // nacitanie poli databazy do zoznamu
    function  FillFieldFullNames (Value:string):TStrings;
    // nacitanie celeho nazvu poli databazy do zoznamu
    function  GetTableObj (Value:string):TObject;

    { Public declarations }
  end;

var
  F_QRMain: TF_QRMain;

implementation

uses QRep2_, QRepIm_, QRepD_, QRepF_, Preview_, QRepN;

{$R *.DFM}

procedure TF_QRMain.Execute (pMask:string);
begin
  oRepMask := ExtractFileName (pMask);
  ShowModal;
end;

procedure TF_QRMain.IcQuickRepMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
begin
  IcCompMouseMove(Sender,Shift,X,Y,(Sender as TIcQuickRep).Selected);
end;

procedure TF_QRMain.IcQuickRepMouseDown (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IcCompMouseDown(Sender, Button, Shift, X, Y);
end;

procedure TF_QRMain.IcQRSubDetailMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
begin
  If oCtrlMouse then begin
    If (oEndX<>X) or (oEndY<>Y) then begin
      SelectComp ((Sender as TIcQRSubDetail).Name);
      oEndX := X;
      oEndY := Y;
      (Sender as TIcQRSubDetail).Canvas.Pen.Style := psDot;
      (Sender as TIcQRSubDetail).Canvas.Pen.Color := clWhite;
      (Sender as TIcQRSubDetail).Canvas.MoveTo (oBegX, oBegY);
      (Sender as TIcQRSubDetail).Canvas.LineTo (X, oBegY);
      (Sender as TIcQRSubDetail).Canvas.LineTo (X, Y);
      (Sender as TIcQRSubDetail).Canvas.LineTo (oBegX, Y);
      (Sender as TIcQRSubDetail).Canvas.LineTo (oBegX, oBegY);
    end;
  end else IcCompMouseMove(Sender,Shift,X,Y,(Sender as TIcQRSubDetail).Selected);
end;

procedure TF_QRMain.IcQRSubDetailMouseDown (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  If ssCtrl in Shift then begin
    // oznacenie viacerych komponentov pomocou mysi a CTRL
    oCtrlMouse := TRUE;
    oBegX := X;
    oBegY := Y;
    oEndX := oBegX;
    oEndY := oBegY;
  end else begin
    // oznaci Subdetail Bandako vybrany resp. prida komponent na SubdetailBand
    If oAddComp>0
      then AddComponents ((Sender as TIcQRSubDetail).Name, X, Y)
      else IcCompMouseDown(Sender, Button, Shift, X, Y);
  end;
end;

procedure TF_QRMain.IcQRBandMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
begin
  If oCtrlMouse then begin
    // vykresli ramcek pre vyber viacerych komponentov pomocou mysi a CTRL
    If (oEndX<>X) or (oEndY<>Y) then begin
      SelectComp ((Sender as TIcQRBand).Name);
      oEndX := X;
      oEndY := Y;
      (Sender as TIcQRBand).Canvas.Pen.Style := psDot;
      (Sender as TIcQRBand).Canvas.Pen.Color := clWhite;
      (Sender as TIcQRBand).Canvas.MoveTo (oBegX, oBegY);
      (Sender as TIcQRBand).Canvas.LineTo (X, oBegY);
      (Sender as TIcQRBand).Canvas.LineTo (X, Y);
      (Sender as TIcQRBand).Canvas.LineTo (oBegX, Y);
      (Sender as TIcQRBand).Canvas.LineTo (oBegX, oBegY);
    end;
  end else IcCompMouseMove(Sender,Shift,X,Y,(Sender as TIcQRBand).Selected);
end;

procedure TF_QRMain.IcQRBandMouseDown (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  If ssCtrl in Shift then begin
    // oznacenie viacerych komponentov pomocou mysi a CTRL
    oCtrlMouse := TRUE;
    oBegX := X;
    oBegY := Y;
    oEndX := oBegX;
    oEndY := oBegY;
  end else begin
    // oznaci Band ako vybrany resp. prida komponent na Band
    If oAddComp>0 then begin
      AddComponents ((Sender as TIcQRBand).Name, X, Y);
    end else IcCompMouseDown(Sender, Button, Shift, X, Y);
  end;
end;

procedure TF_QRMain.IcQRChildBandMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
begin
  If oCtrlMouse then begin
    // vykresli ramcek pre vyber viacerych komponentov pomocou mysi a CTRL
    If (oEndX<>X) or (oEndY<>Y) then begin
      SelectComp ((Sender as TIcQRChildBand).Name);
      oEndX := X;
      oEndY := Y;
      (Sender as TIcQRChildBand).Canvas.Pen.Style := psDot;
      (Sender as TIcQRChildBand).Canvas.Pen.Color := clWhite;
      (Sender as TIcQRChildBand).Canvas.MoveTo (oBegX, oBegY);
      (Sender as TIcQRChildBand).Canvas.LineTo (X, oBegY);
      (Sender as TIcQRChildBand).Canvas.LineTo (X, Y);
      (Sender as TIcQRChildBand).Canvas.LineTo (oBegX, Y);
      (Sender as TIcQRChildBand).Canvas.LineTo (oBegX, oBegY);
    end;
  end else IcCompMouseMove(Sender,Shift,X,Y,(Sender as TIcQRChildBand).Selected);
end;

procedure TF_QRMain.IcQRChildBandMouseDown (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  If ssCtrl in Shift then begin
    // oznacenie viacerych komponentov pomocou mysi a CTRL
    oCtrlMouse := TRUE;
    oBegX := X;
    oBegY := Y;
    oEndX := oBegX;
    oEndY := oBegY;
  end else begin
    // oznaci Band ako vybrany resp. prida komponent na ChildBand
    If oAddComp>0
      then AddComponents ((Sender as TIcQRChildBand).Name, X, Y)
      else IcCompMouseDown(Sender, Button, Shift, X, Y);
  end;
end;

procedure TF_QRMain.IcQRGroupMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
begin
  If oCtrlMouse then begin
    // vykresli ramcek pre vyber viacerych komponentov pomocou mysi a CTRL
    If (oEndX<>X) or (oEndY<>Y) then begin
      SelectComp ((Sender as TIcQRGroup).Name);
      oEndX := X;
      oEndY := Y;
      (Sender as TIcQRGroup).Canvas.Pen.Style := psDot;
      (Sender as TIcQRGroup).Canvas.Pen.Color := clWhite;
      (Sender as TIcQRGroup).Canvas.MoveTo (oBegX, oBegY);
      (Sender as TIcQRGroup).Canvas.LineTo (X, oBegY);
      (Sender as TIcQRGroup).Canvas.LineTo (X, Y);
      (Sender as TIcQRGroup).Canvas.LineTo (oBegX, Y);
      (Sender as TIcQRGroup).Canvas.LineTo (oBegX, oBegY);
    end;
  end else IcCompMouseMove(Sender,Shift,X,Y,(Sender as TIcQRGroup).Selected);
end;

procedure TF_QRMain.IcQRGroupMouseDown (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  If ssCtrl in Shift then begin
    // oznacenie viacerych komponentov pomocou mysi a CTRL
    oCtrlMouse := TRUE;
    oBegX := X;
    oBegY := Y;
    oEndX := oBegX;
    oEndY := oBegY;
  end else begin
    // oznaci GroupBand ako vybrany resp. prida komponent na GroupBand
    If oAddComp>0
      then AddComponents ((Sender as TIcQRGroup).Name, X, Y)
      else IcCompMouseDown(Sender, Button, Shift, X, Y);
  end;
end;

procedure TF_QRMain.IcQRLabelMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
begin
  IcCompMouseMove(Sender,Shift,X,Y,(Sender as TIcQRLabel).Selected);
end;

procedure TF_QRMain.IcQRLabelMouseDown (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IcCompMouseDown(Sender, Button, Shift, X, Y);
end;

procedure TF_QRMain.IcQRDBTextMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
begin
  IcCompMouseMove(Sender,Shift,X,Y,(Sender as TIcQRDBText).Selected);
end;

procedure TF_QRMain.IcQRDBTextMouseDown (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IcCompMouseDown(Sender, Button, Shift, X, Y);
end;

procedure TF_QRMain.IcQRExprMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
begin
  IcCompMouseMove(Sender,Shift,X,Y,(Sender as TIcQRExpr).Selected);
end;

procedure TF_QRMain.IcQRExprMouseDown (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IcCompMouseDown(Sender, Button, Shift, X, Y);
end;

procedure TF_QRMain.IcQRSysDataMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
begin
  IcCompMouseMove(Sender,Shift,X,Y,(Sender as TIcQRSysData).Selected);
end;

procedure TF_QRMain.IcQRSysDataMouseDown (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IcCompMouseDown(Sender, Button, Shift, X, Y);
end;

procedure TF_QRMain.IcQRMemoMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
begin
  IcCompMouseMove(Sender,Shift,X,Y,(Sender as TIcQRMemo).Selected);
end;

procedure TF_QRMain.IcQRMemoMouseDown (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IcCompMouseDown(Sender, Button, Shift, X, Y);
end;

procedure TF_QRMain.IcQRShapeMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
begin
  IcCompMouseMove(Sender,Shift,X,Y,(Sender as TIcQRShape).Selected);
end;

procedure TF_QRMain.IcQRShapeMouseDown (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IcCompMouseDown(Sender, Button, Shift, X, Y);
end;

procedure TF_QRMain.IcQRImageMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
begin
  IcCompMouseMove(Sender,Shift,X,Y,(Sender as TIcQRImage).Selected);
end;

procedure TF_QRMain.IcQRImageMouseDown (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IcCompMouseDown(Sender, Button, Shift, X, Y);
end;

procedure TF_QRMain.IcQRDBImageMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
begin
  IcCompMouseMove(Sender,Shift,X,Y,(Sender as TIcQRDBImage).Selected);
end;

procedure TF_QRMain.IcQRDBImageMouseDown (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IcCompMouseDown(Sender, Button, Shift, X, Y);
end;

procedure TF_QRMain.IcQRChartMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
begin
  IcCompMouseMove(Sender,Shift,X,Y,(Sender as TIcQRChart).Selected);
end;

procedure TF_QRMain.IcQRChartMouseDown (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IcCompMouseDown(Sender, Button, Shift, X, Y);
end;

procedure TF_QRMain.IcQRBarCodeMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
begin
  IcCompMouseMove(Sender,Shift,X,Y,(Sender as TIcQRBarCode).Selected);
end;

procedure TF_QRMain.IcQRBarCodeMouseDown (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IcCompMouseDown(Sender, Button, Shift, X, Y);
end;

procedure TF_QRMain.Fill_IL_QRShapePenStyle;
var
  I:longint;
  mImage:TBitmap;
begin
  mImage := TBitmap.Create;
  For I:=1 to 6 do begin
    IL_QRShapePenStyle.GetBitmap (0,mImage);
    mImage.Canvas.Brush.Color := clWhite;
    mImage.Canvas.FillRect (Rect (1,1,61,9));
    mImage.Canvas.Pen.Width := 1;
    mImage.Canvas.Pen.Color := clBlack;
    If I=1 then mImage.Canvas.Pen.Style := psDash;
    If I=2 then mImage.Canvas.Pen.Style := psDashDot;
    If I=3 then mImage.Canvas.Pen.Style := psDashDotDot;
    If I=4 then mImage.Canvas.Pen.Style := psDot;
    If I=5 then mImage.Canvas.Pen.Style := psSolid;
    If I=6 then mImage.Canvas.Pen.Style := psSolid;
    If I in [1..5] then begin
      mImage.Canvas.MoveTo(2, 4);
      mImage.Canvas.LineTo(60, 4);
      mImage.Canvas.MoveTo(2, 5);
      mImage.Canvas.LineTo(60, 5);
    end else begin
      mImage.Canvas.MoveTo(2, 6);
      mImage.Canvas.LineTo(60, 6);
      mImage.Canvas.MoveTo(2, 7);
      mImage.Canvas.LineTo(60, 7);
    end;
    IL_QRShapePenStyle.Add (mImage, nil);
  end;
  mImage.Free; mImage := nil;
end;

procedure TF_QRMain.Fill_IL_QRShapeBrushStyle;
var
  I:longint;
  mImage:TBitmap;
begin
  mImage := TBitmap.Create;
  For I:=1 to 7 do begin
    IL_QRShapeBrushStyle.GetBitmap (0,mImage);

    mImage.Canvas.Brush.Color := clWhite;
    mImage.Canvas.FillRect (Rect (2,2,22,22));
    mImage.Canvas.Brush.Color := clBlack;
    If I=0 then mImage.Canvas.Brush.Style := bsClear;
    If I=1 then mImage.Canvas.Brush.Style := bsHorizontal;
    If I=2 then mImage.Canvas.Brush.Style := bsVertical;
    If I=3 then mImage.Canvas.Brush.Style := bsCross;
    If I=4 then mImage.Canvas.Brush.Style := bsBDiagonal;
    If I=5 then mImage.Canvas.Brush.Style := bsFDiagonal;
    If I=6 then mImage.Canvas.Brush.Style := bsDiagCross;
    If I=7 then mImage.Canvas.Brush.Style := bsSolid;
    mImage.Canvas.FillRect (Rect (2,2,22,22));
    IL_QRShapeBrushStyle.Add (mImage, nil);
  end;
  mImage.Free; mImage := nil;
end;

procedure TF_QRMain.FillDataModules;
var I,J:longint;
begin
  CB_QRDBTextDataModule.Clear;
  CB_QRDBImageDataModule.Clear;
  CB_QuickRepDataModule.Clear;
  CB_QRSubDetailDataModule.Clear;
  CB_QRBarCodeDataModule.Clear;
  CB_QRChartDataModule.Clear;
  If Application.ComponentCount>0 then begin
    For I:=0 to Application.ComponentCount-1 do begin
      If Application.Components[I] is TDataModule then begin
        CB_QRDBTextDataModule.Items.Add (Application.Components[I].Name);
        CB_QRDBImageDataModule.Items.Add (Application.Components[I].Name);
        CB_QuickRepDataModule.Items.Add (Application.Components[I].Name);
        CB_QRSubDetailDataModule.Items.Add (Application.Components[I].Name);
        CB_QRBarCodeDataModule.Items.Add (Application.Components[I].Name);
        CB_QRChartDataModule.Items.Add (Application.Components[I].Name);
      end;
    end;
  end;
end;
(*
procedure TF_QRMain.FillDataSets;
var I,J:longint;
begin
  CB_QRDBTextDataSet.Clear;
  CB_QRDBImageDataSet.Clear;
  CB_QuickRepDataSet.Clear;
  CB_QRSubDetailDataSet.Clear;
  CB_QRBarCodeDataSet.Clear;

  If Application.ComponentCount>0 then begin
    For I:=0 to Application.ComponentCount-1 do begin
      If Application.Components[I] is TDataModule then begin
        If Application.Components[I].ComponentCount>0 then begin
          For J:=0 to Application.Components[I].ComponentCount-1 do begin
            If Application.Components[I].Components[J] is TDataSet then begin
              CB_QRDBTextDataSet.Items.Add (Application.Components[I].Name+'.'+Application.Components[I].Components[J].Name);
              CB_QRDBImageDataSet.Items.Add (Application.Components[I].Name+'.'+Application.Components[I].Components[J].Name);
              CB_QuickRepDataSet.Items.Add (Application.Components[I].Name+'.'+Application.Components[I].Components[J].Name);
              CB_QRSubDetailDataSet.Items.Add (Application.Components[I].Name+'.'+Application.Components[I].Components[J].Name);
              CB_QRBarCodeDataSet.Items.Add (Application.Components[I].Name+'.'+Application.Components[I].Components[J].Name);
            end;
          end;
        end;
      end;
    end;
  end;
end;
*)
procedure TF_QRMain.FillDBTextDataSet;
var J:longint;
begin
  CB_QRDBTextDataSet.Clear;
  If Application.FindComponent (CB_QRDBTextDataModule.Text) is TDataModule then begin
    For J:=0 to Application.FindComponent (CB_QRDBTextDataModule.Text).ComponentCount-1 do begin
      If Application.FindComponent (CB_QRDBTextDataModule.Text).Components[J] is TDataSet then begin
        CB_QRDBTextDataSet.Items.Add (Application.FindComponent (CB_QRDBTextDataModule.Text).Name+'.'+Application.FindComponent (CB_QRDBTextDataModule.Text).Components[J].Name);
      end;
    end;
  end;
end;

procedure TF_QRMain.FillDBImageDataSet;
var J:longint;
begin
  CB_QRDBImageDataSet.Clear;
  If Application.FindComponent (CB_QRDBImageDataModule.Text) is TDataModule then begin
    For J:=0 to Application.FindComponent (CB_QRDBImageDataModule.Text).ComponentCount-1 do begin
      If Application.FindComponent (CB_QRDBImageDataModule.Text).Components[J] is TDataSet then begin
        CB_QRDBImageDataSet.Items.Add (Application.FindComponent (CB_QRDBImageDataModule.Text).Name+'.'+Application.FindComponent (CB_QRDBImageDataModule.Text).Components[J].Name);
      end;
    end;
  end;
end;

procedure TF_QRMain.FillQuickRepDataSet;
var J:longint;
begin
  CB_QuickRepDataSet.Clear;
  If Application.FindComponent (CB_QuickRepDataModule.Text) is TDataModule then begin
    For J:=0 to Application.FindComponent (CB_QuickRepDataModule.Text).ComponentCount-1 do begin
      If Application.FindComponent (CB_QuickRepDataModule.Text).Components[J] is TDataSet then begin
        CB_QuickRepDataSet.Items.Add (Application.FindComponent (CB_QuickRepDataModule.Text).Name+'.'+Application.FindComponent (CB_QuickRepDataModule.Text).Components[J].Name);
      end;
    end;
  end;
end;

procedure TF_QRMain.FillSubDetailDataSet;
var J:longint;
begin
  CB_QRSubDetailDataSet.Clear;
  If Application.FindComponent (CB_QRSubDetailDataModule.Text) is TDataModule then begin
    For J:=0 to Application.FindComponent (CB_QRSubDetailDataModule.Text).ComponentCount-1 do begin
      If Application.FindComponent (CB_QRSubDetailDataModule.Text).Components[J] is TDataSet then begin
        CB_QRSubDetailDataSet.Items.Add (Application.FindComponent (CB_QRSubDetailDataModule.Text).Name+'.'+Application.FindComponent (CB_QRSubDetailDataModule.Text).Components[J].Name);
      end;
    end;
  end;
end;

procedure TF_QRMain.FillChartDataSet;
var J:longint;
begin
  CB_QRChartDataSet.Clear;
  If Application.FindComponent (CB_QRChartDataModule.Text) is TDataModule then begin
    For J:=0 to Application.FindComponent (CB_QRChartDataModule.Text).ComponentCount-1 do begin
      If Application.FindComponent (CB_QRChartDataModule.Text).Components[J] is TDataSet then begin
        CB_QRChartDataSet.Items.Add (Application.FindComponent (CB_QRChartDataModule.Text).Name+'.'+Application.FindComponent (CB_QRChartDataModule.Text).Components[J].Name);
      end;
    end;
  end;
end;

procedure TF_QRMain.FillBarCodeDataSet;
var J:longint;
begin
  CB_QRBarCodeDataSet.Clear;
  If Application.FindComponent (CB_QRBarCodeDataModule.Text) is TDataModule then begin
    For J:=0 to Application.FindComponent (CB_QRBarCodeDataModule.Text).ComponentCount-1 do begin
      If Application.FindComponent (CB_QRBarCodeDataModule.Text).Components[J] is TDataSet then begin
        CB_QRBarCodeDataSet.Items.Add (Application.FindComponent (CB_QRBarCodeDataModule.Text).Name+'.'+Application.FindComponent (CB_QRBarCodeDataModule.Text).Components[J].Name);
      end;
    end;
  end;
end;

function  TF_QRMain.FillFieldNames (Value:string):TStrings;
var
  mComp:TObject;
  I:longint;
  mOpen:boolean;
begin
  Result := TStringList.Create;
  Result.Clear;
  mComp := GetTableObj (Value);
  If mComp<>nil then begin
    If mComp is TDataSet then begin
      mOpen := (mComp as TDataSet).Active;
      If not mOpen then (mComp as TDataSet).Active := TRUE;
      If (mComp as TDataSet).FieldCount>0 then begin
        For I:=0 to (mComp as TDataSet).FieldCount-1 do begin
          Result.Add ((mComp as TDataSet).FieldDefs.Items[I].Name);
        end;
      end;
      If not mOpen then (mComp as TDataSet).Close;
    end;
  end;
end;

function  TF_QRMain.FillFieldFullNames (Value:string):TStrings;
var
  mComp:TObject;
  I:longint;
  mOpen:boolean;
begin
  Result := TStringList.Create;
  Result.Clear;
  mComp := GetTableObj (Value);
  If mComp<>nil then begin
    // Btrieve databaza
    If mComp is TBtrieveTable then begin
      mOpen := (mComp as TBtrieveTable).Active;
      If not mOpen then (mComp as TBtrieveTable).Active := TRUE;
      If (mComp as TBtrieveTable).FieldCount>0 then begin
        For I:=0 to (mComp as TBtrieveTable).FieldCount-1 do begin
          Result.Add ((mComp as TBtrieveTable).oFieldFullName[i]);
        end;
      end;
      If not mOpen then (mComp as TBtrieveTable).Close;
    // Standardna databaza  
    end else if mComp is Tdataset then begin
      mOpen := (mComp as TDataSet).Active;
      If not mOpen then (mComp as TDataSet).Active := TRUE;
      If (mComp as TDataSet).FieldCount>0 then begin
        For I:=0 to (mComp as TDataSet).FieldCount-1 do begin
          Result.Add ((mComp as TDataSet).Fields[I].FullName);
        end;
      end;
      If not mOpen then (mComp as TDataSet).Close;
    end;
  end;
end;

procedure TF_QRMain.FillMaster;
var I:longint;
begin
  CB_QRExprMaster.Clear;
  CB_QRSubDetailMaster.Clear;
  CB_QRGroupMaster.Clear;
  If F_QR.ComponentCount>0 then begin
    For I:=0 to F_QR.ComponentCount-1 do begin
      If (F_QR.Components[I] is TQuickRep) or (F_QR.Components[I] is TQRSubDetail) then begin
        CB_QRExprMaster.Items.Add (F_QR.Components[I].Name);
        CB_QRSubDetailMaster.Items.Add (F_QR.Components[I].Name);
        CB_QRGroupMaster.Items.Add (F_QR.Components[I].Name);
      end;
    end;
  end;
end;

procedure TF_QRMain.SetTableActive (Value:boolean);
var I:longint;
begin
  try
    If F_QR.ComponentCount>0 then begin
      For I:=0 to F_QR.ComponentCount-1 do begin
        If F_QR.Components[I] is TIcQuickRep then begin
          If (F_QR.Components[I] as TIcQuickRep).DataSet<>nil then begin
            If (F_QR.Components[I] as TIcQuickRep).DataSet.Active<>Value
              then (F_QR.Components[I] as TIcQuickRep).DataSet.Active := Value;
          end;
        end;
        If F_QR.Components[I] is TIcQRSubDetail then begin
          If (F_QR.Components[I] as TIcQRSubDetail).DataSet<>nil then begin
            If (F_QR.Components[I] as TIcQRSubDetail).DataSet.Active<>Value
              then (F_QR.Components[I] as TIcQRSubDetail).DataSet.Active := Value;
          end;
        end;
        If F_QR.Components[I] is TIcQRDBText then begin
          If (F_QR.Components[I] as TIcQRDBText).DataSet<>nil then begin
            If (F_QR.Components[I] as TIcQRDBText).DataSet.Active<>Value
              then (F_QR.Components[I] as TIcQRDBText).DataSet.Active := Value;
          end;
        end;
        If F_QR.Components[I] is TIcQRDBImage then begin
          If (F_QR.Components[I] as TIcQRDBImage).DataSet<>nil then begin
            If (F_QR.Components[I] as TIcQRDBImage).DataSet.Active<>Value
              then (F_QR.Components[I] as TIcQRDBImage).DataSet.Active := Value;
          end;
        end;
      end;
    end;
  except end;
end;

function  TF_QRMain.GetIndexPos (pStrings:TStrings; pS:string):longint;
var mCnt:longint;
begin
  Result := -1;
  If pStrings.Count>0 then begin
    mCnt := 0;
    While (mCnt<pStrings.Count-1) and (pStrings[mCnt]<>pS) do begin
      If pStrings[mCnt]<>pS then Inc (mCnt);
    end;
    If pStrings[mCnt]=pS then Result := mCnt;
  end;
end;

procedure TF_QRMain.IcCompMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var mW,mH:longint;
begin
  oSizingType := 0;
  If not oButDown then begin
    oXC := X;
    oYC := Y;
    mW := (Sender as TControl).Width;
    mH := (Sender as TControl).Height;
    If (X>=0) and (X<=5) and (Y>=0) and (Y<=5) then oSizingType := 1;
    If (X>=0) and (X<=5) and (Y>=(mH div 2 -2)) and (Y<=(mH div 2 +3)) then oSizingType := 2;
    If (X>=0) and (X<=5) and (Y>=mH-5) and (Y<=mH) then oSizingType := 3;
    If (X>=(mW div 2 -2)) and (X<=(mW div 2 +3)) and (Y>=0) and (Y<=5) then oSizingType := 4;
    If (X>=(mW div 2 -2)) and (X<=(mW div 2 +3)) and (Y>=mH-5) and (Y<=mH) then oSizingType := 5;
    If (X>=mW-5) and (X<=mW) and (Y>=0) and (Y<=5) then oSizingType := 6;
    If (X>=mW-5) and (X<=mW) and (Y>=(mH div 2 -2)) and (Y<=(mH div 2 +3)) then oSizingType := 7;
    If (X>=mW-5) and (X<=mW) and (Y>=mH-5) and (Y<=mH) then oSizingType := 8;
  end;
  oButDown := TRUE;
  oShift := Shift;
end;

procedure TF_QRMain.IcCompMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  I:longint;
  mX,mY,mW,mH: longint;
  mCnt:longint;
  mLastName:string;
begin
  oButDown := FALSE;
  If oCtrlMouse then begin
    If oBegX>oEndX then begin mX := oBegX; oBegX := oEndX; oEndX := mX; end;
    If oBegY>oEndY then begin mY := oBegY; oBegY := oEndY; oEndY := mY; end;
    If F_QR.ComponentCount>0 then begin
      ClearSelectComp;
      cqMultiSelect := TRUE;
      mCnt := 0;
      For I:=0 to F_QR.ComponentCount-1 do begin
        If F_QR.Components[I] is TControl then begin
          If (F_QR.Components[I] as TControl).Parent=Sender then begin
            mX := (F_QR.Components[I] as TControl).Left;
            mY := (F_QR.Components[I] as TControl).Top;
            mH := (F_QR.Components[I] as TControl).Height;
            mW := (F_QR.Components[I] as TControl).Width;
            If ((mX>=oBegX) and (mX<=oEndX) and (mY>=oBegY) and (mY<=oEndY))
               or ((mX+mW>=oBegX) and (mX+mW<=oEndX) and (mY>=oBegY) and (mY<=oEndY))
               or ((mX>=oBegX) and (mX<=oEndX) and (mY+mH>=oBegY) and (mY+mH<=oEndY))
               or ((mX+mW>=oBegX) and (mX+mW<=oEndX) and (mY+mH>=oBegY) and (mY+mH<=oEndY)) then begin
              Inc (mCnt);
              mLastName := F_QR.Components[I].Name;
              oCompList.Add (mLastName);
              SetSelected (mLastName, TRUE);
              CompRepaint (mLastName);
            end;
          end;
        end;
      end;
      If mCnt<2 then begin
        cqMultiSelect := FALSE;
        CompRepaint (mLastName);
      end;
      SetActCompParam (TRUE);
    end;
    CompRepaint ((Sender as TControl).Name);
    oCtrlMouse := FALSE;
  end else begin
    FillXYList;
  end;
  If not oButtFix and (oAddComp<>0) then begin
    SB_Arrow.Down := TRUE;
    oAddComp := 0;
  end;
  oShift := [];
end;

procedure TF_QRMain.IcCompKeyDown (Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Shift=[] then begin
    case Key of
      VK_UP,VK_LEFT   : MoveLeftSel;
      VK_DOWN,VK_RIGHT: MoveRightSel;
      VK_DELETE: DeleteComponents;
    end;
  end else begin
    If ssCtrl in Shift then begin
      case Key of
        VK_UP   : MoveUpComp;
        VK_LEFT : MoveLeftComp;
        VK_DOWN : MoveDownComp;
        VK_RIGHT: MoveRightComp;
        VK_INSERT:CopyComponents;
      end;
    end else begin
      If ssShift in Shift then begin
        case Key of
          VK_UP   : HeightDecComp;
          VK_LEFT : WidthDecComp;
          VK_DOWN : HeightIncComp;
          VK_RIGHT: WidthIncComp;
          VK_INSERT:PasteComponents(Sender);
        end;
      end;
    end;
  end;
end;

procedure TF_QRMain.IcCompMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer; pSelected:boolean);
var
  I:longint;
  mW,mH:longint;
  mX,mY:longint;
begin
  (Sender as TControl).Cursor := crDefault;
  If pSelected and not cqMultiSelect then begin
    mW := (Sender as TControl).Width;
    mH := (Sender as TControl).Height;
    // nastavenie typu kurzora mysi pre zmenu velksti komponentu
    If (X>=0) and (X<=5) and (Y>=0) and (Y<=5) then (Sender as TControl).Cursor := crSizeNWSE;
    If (X>=0) and (X<=5) and (Y>=(mH div 2 -2)) and (Y<=(mH div 2 +3)) then (Sender as TControl).Cursor := crSizeWE;
    If (X>=0) and (X<=5) and (Y>=mH-5) and (Y<=mH) then (Sender as TControl).Cursor := crSizeNESW;
    If (X>=(mW div 2 -2)) and (X<=(mW div 2 +3)) and (Y>=0) and (Y<=5) then (Sender as TControl).Cursor := crSizeNS;
    If (X>=(mW div 2 -2)) and (X<=(mW div 2 +3)) and (Y>=mH-5) and (Y<=mH) then (Sender as TControl).Cursor := crSizeNS;
    If (X>=mW-5) and (X<=mW) and (Y>=0) and (Y<=5) then (Sender as TControl).Cursor := crSizeNESW;
    If (X>=mW-5) and (X<=mW) and (Y>=(mH div 2 -2)) and (Y<=(mH div 2 +3)) then (Sender as TControl).Cursor := crSizeWE;
    If (X>=mW-5) and (X<=mW) and (Y>=mH-5) and (Y<=mH) then (Sender as TControl).Cursor := crSizeNWSE;

    If oButDown then begin
      oChange := TRUE;
      case oSizingType of
        0: begin
             If GetResizeComp (Sender) then begin
               (Sender as TControl).Left := (Sender as TControl).Left+X-oXC;
               (Sender as TControl).Top := (Sender as TControl).Top+Y-oYC;
             end;
           end;
        1: begin
             If GetResizeComp (Sender) then begin
               (Sender as TControl).Left := (Sender as TControl).Left+X-oXC;
               (Sender as TControl).Top := (Sender as TControl).Top+Y-oYC;
               (Sender as TControl).Width := (Sender as TControl).Width-(X-oXC);
               (Sender as TControl).Height := (Sender as TControl).Height-(Y-oYC);
             end;
           end;
        2: begin
             If GetResizeComp (Sender) then begin
               (Sender as TControl).Left := (Sender as TControl).Left+X-oXC;
               (Sender as TControl).Width := (Sender as TControl).Width-(X-oXC);
             end;
           end;
        3: begin
             If GetResizeComp (Sender) then begin
               (Sender as TControl).Left := (Sender as TControl).Left+X-oXC;
               (Sender as TControl).Width := (Sender as TControl).Width-(X-oXC);
               (Sender as TControl).Height := (Sender as TControl).Height+(Y-oYC);
               oYC := Y;
             end;
           end;
        4: begin
             If GetResizeComp (Sender) then begin
               (Sender as TControl).Top := (Sender as TControl).Top+Y-oYC;
               (Sender as TControl).Height := (Sender as TControl).Height-(Y-oYC);
             end;
           end;
        5: begin
             If GetResizeComp (Sender) then begin
               (Sender as TControl).Height := (Sender as TControl).Height+(Y-oYC);
               oYC := Y;
             end;
           end;
        6: begin
             If GetResizeComp (Sender) then begin
               (Sender as TControl).Top := (Sender as TControl).Top+Y-oYC;
               (Sender as TControl).Height := (Sender as TControl).Height-(Y-oYC);
               (Sender as TControl).Width := (Sender as TControl).Width+(X-oXC);
               oXC := X;
             end;
           end;
        7: begin
             If GetResizeComp (Sender) then begin
               (Sender as TControl).Width := (Sender as TControl).Width+(X-oXC);
               oXC := X;
             end;
           end;
        8: begin
             If GetResizeComp (Sender) then begin
               (Sender as TControl).Width := (Sender as TControl).Width+(X-oXC);
               (Sender as TControl).Height := (Sender as TControl).Height+(Y-oYC);
               oYC := Y;
               oXC := X;
             end;
           end;
      end;
      SetActCompParam (TRUE);
    end;
  end else begin
    If pSelected and cqMultiSelect and oButDown then begin
      (Sender as TControl).Cursor := crDefault;
      mX := (Sender as TControl).Left;
      mY := (Sender as TControl).Top;
      If GetResizeComp (Sender) then begin
        (Sender as TControl).Left := (Sender as TControl).Left+X-oXC;
        (Sender as TControl).Top := (Sender as TControl).Top+Y-oYC;
      end;
      If (mX<>(Sender as TControl).Left) or (mY<>(Sender as TControl).Top) then begin
        For I:=1 to oCompList.Count do begin
          If oCompList.Strings[I-1]<>(Sender as TControl).Name then begin
            If F_QR.FindComponent (oCompList.Strings[I-1])<>nil then begin
              If GetResizeComp (F_QR.FindComponent (oCompList.Strings[I-1])) then begin
                (F_QR.FindComponent (oCompList.Strings[I-1]) as TControl).Left := (F_QR.FindComponent (oCompList.Strings[I-1]) as TControl).Left+X-oXC;
                (F_QR.FindComponent (oCompList.Strings[I-1]) as TControl).Top := (F_QR.FindComponent (oCompList.Strings[I-1]) as TControl).Top+Y-oYC;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TF_QRMain.IcCompClick(Sender: TObject);
var
  I:longint;
  mFind:boolean;
  mS:string;
  mN,mName:string;
begin
  mName := (Sender as TControl).Name;
  If ssShift in oShift then begin
    CB_CompName.Text := '';
    If oCompList.Count = 0 then begin
      oCompList.Add (mName);
      SetSelected (mName,TRUE);
      CompRepaint (mName);
      CB_CompName.Text := mName;
      SetActCompParam (TRUE);
      SetActCompImage;
    end else begin
      mFind := IsSelected (mName);
      If not mFind then begin
        cqMultiSelect := TRUE;
        For I:=1 to oCompList.Count do begin
          CompRepaint (oCompList.Strings[I-1]);
        end;
        oCompList.Add (mName);
        SetSelected (mName,TRUE);
        CompRepaint (mName);
      end else begin
        mS := mName;
        If oCompList.Count>0 then begin
          I := 0;
          mFind := FALSE;
          While (I<oCompList.Count) and not mFind do begin
            mFind := mS=oCompList.Strings[I];
            If not mFind then Inc (I);
          end;
          If mFind then oCompList.Delete (I);
          If oCompList.Count=1 then begin
            cqMultiSelect := FALSE;
            CompRepaint (oCompList.Strings[0]);
          end;
        end;
        SetSelected (mName,FALSE);
        CompRepaint (mName);
      end;
      SetActCompParam (TRUE);
    end;
  end else begin
    If oAddComp=0 then begin
      mS := mName;
      mFind := FALSE;
      If oCompList.Count>0 then begin
        I := 0;
        mFind := FALSE;
        While (I<oCompList.Count) and not mFind do begin
          mFind := mS=oCompList.Strings[I];
          If not mFind then Inc (I);
        end;
      end;
      If not mFind then begin
        cqMultiSelect := FALSE;
        For I:=1 to oCompList.Count do begin
          mN := oCompList.Strings[I-1];
          If F_QR.FindComponent (mN)<>nil then begin
            If F_QR.FindComponent (mN) is TIcQuickRep then (F_QR.FindComponent (mN) as TIcQuickRep).Selected := FALSE;
            If F_QR.FindComponent (mN) is TIcQRSubDetail then (F_QR.FindComponent (mN) as TIcQRSubDetail).Selected := FALSE;
            If F_QR.FindComponent (mN) is TIcQRBand then (F_QR.FindComponent (mN) as TIcQRBand).Selected := FALSE;
            If F_QR.FindComponent (mN) is TIcQRChildBand then (F_QR.FindComponent (mN) as TIcQRChildBand).Selected := FALSE;
            If F_QR.FindComponent (mN) is TIcQRGroup then (F_QR.FindComponent (mN) as TIcQRGroup).Selected := FALSE;
            If F_QR.FindComponent (mN) is TIcQRLabel then (F_QR.FindComponent (mN) as TIcQRLabel).Selected := FALSE;
            If F_QR.FindComponent (mN) is TIcQRDBText then (F_QR.FindComponent (mN) as TIcQRDBText).Selected := FALSE;
            If F_QR.FindComponent (mN) is TIcQRExpr then (F_QR.FindComponent (mN) as TIcQRExpr).Selected := FALSE;
            If F_QR.FindComponent (mN) is TIcQRSysData then (F_QR.FindComponent (mN) as TIcQRSysData).Selected := FALSE;
            If F_QR.FindComponent (mN) is TIcQRMemo then (F_QR.FindComponent (mN) as TIcQRMemo).Selected := FALSE;
            If F_QR.FindComponent (mN) is TIcQRShape then (F_QR.FindComponent (mN) as TIcQRShape).Selected := FALSE;
            If F_QR.FindComponent (mN) is TIcQRImage then (F_QR.FindComponent (mN) as TIcQRImage).Selected := FALSE;
            If F_QR.FindComponent (mN) is TIcQRDBImage then (F_QR.FindComponent (mN) as TIcQRDBImage).Selected := FALSE;
            If F_QR.FindComponent (mN) is TIcQRChart then (F_QR.FindComponent (mN) as TIcQRChart).Selected := FALSE;
            If F_QR.FindComponent (mN) is TIcQRBarCode then (F_QR.FindComponent (mN) as TIcQRBarCode).Selected := FALSE;
          end;
          CompRepaint (mN);
        end;
        oCompList.Clear;
        oCompList.Add (mName);
        SetSelected (mName,TRUE);
        CompRepaint (mName);
      end;
      CB_CompName.Text := mName;
      SetActCompParam (TRUE);
      SetActCompImage;
    end;
  end;
end;

procedure TF_QRMain.CompRepaint (pName:string);
begin
  If F_QR.FindComponent (pName)<>nil then begin
    If F_QR.FindComponent (pName) is TIcQuickRep then (F_QR.FindComponent (pName) as TIcQuickRep).Repaint;
    If F_QR.FindComponent (pName) is TIcQRSubDetail then (F_QR.FindComponent (pName) as TIcQRSubDetail).Repaint;
    If F_QR.FindComponent (pName) is TIcQRBand then (F_QR.FindComponent (pName) as TIcQRBand).Repaint;
    If F_QR.FindComponent (pName) is TIcQRChildBand then (F_QR.FindComponent (pName) as TIcQRChildBand).Repaint;
    If F_QR.FindComponent (pName) is TIcQRGroup then (F_QR.FindComponent (pName) as TIcQRGroup).Repaint;
    If F_QR.FindComponent (pName) is TIcQRLabel then (F_QR.FindComponent (pName) as TIcQRLabel).Repaint;
    If F_QR.FindComponent (pName) is TIcQRDBText then (F_QR.FindComponent (pName) as TIcQRDBText).Repaint;
    If F_QR.FindComponent (pName) is TIcQRExpr then (F_QR.FindComponent (pName) as TIcQRExpr).Repaint;
    If F_QR.FindComponent (pName) is TIcQRSysData then (F_QR.FindComponent (pName) as TIcQRSysData).Repaint;
    If F_QR.FindComponent (pName) is TIcQRMemo then (F_QR.FindComponent (pName) as TIcQRMemo).Repaint;
    If F_QR.FindComponent (pName) is TIcQRShape then (F_QR.FindComponent (pName) as TIcQRShape).Repaint;
    If F_QR.FindComponent (pName) is TIcQRImage then (F_QR.FindComponent (pName) as TIcQRImage).Repaint;
    If F_QR.FindComponent (pName) is TIcQRDBImage then (F_QR.FindComponent (pName) as TIcQRDBImage).Repaint;
    If F_QR.FindComponent (pName) is TIcQRChart then (F_QR.FindComponent (pName) as TIcQRChart).Repaint;
    If F_QR.FindComponent (pName) is TIcQRBarCode then (F_QR.FindComponent (pName) as TIcQRBarCode).Repaint;
  end;
end;

procedure TF_QRMain.SetSelected (pName:string;pSelected:boolean);
begin
  If F_QR.FindComponent (pName)<>nil then begin
    If F_QR.FindComponent (pName) is TIcQuickRep then (F_QR.FindComponent (pName) as TIcQuickRep).Selected := pSelected;
    If F_QR.FindComponent (pName) is TIcQRSubDetail then (F_QR.FindComponent (pName) as TIcQRSubDetail).Selected := pSelected;
    If F_QR.FindComponent (pName) is TIcQRBand then (F_QR.FindComponent (pName) as TIcQRBand).Selected := pSelected;
    If F_QR.FindComponent (pName) is TIcQRChildBand then (F_QR.FindComponent (pName) as TIcQRChildBand).Selected := pSelected;
    If F_QR.FindComponent (pName) is TIcQRGroup then (F_QR.FindComponent (pName) as TIcQRGroup).Selected := pSelected;
    If F_QR.FindComponent (pName) is TIcQRLabel then (F_QR.FindComponent (pName) as TIcQRLabel).Selected := pSelected;
    If F_QR.FindComponent (pName) is TIcQRDBText then (F_QR.FindComponent (pName) as TIcQRDBText).Selected := pSelected;
    If F_QR.FindComponent (pName) is TIcQRExpr then (F_QR.FindComponent (pName) as TIcQRExpr).Selected := pSelected;
    If F_QR.FindComponent (pName) is TIcQRSysData then (F_QR.FindComponent (pName) as TIcQRSysData).Selected := pSelected;
    If F_QR.FindComponent (pName) is TIcQRMemo then (F_QR.FindComponent (pName) as TIcQRMemo).Selected := pSelected;
    If F_QR.FindComponent (pName) is TIcQRShape then (F_QR.FindComponent (pName) as TIcQRShape).Selected := pSelected;
    If F_QR.FindComponent (pName) is TIcQRImage then (F_QR.FindComponent (pName) as TIcQRImage).Selected := pSelected;
    If F_QR.FindComponent (pName) is TIcQRDBImage then (F_QR.FindComponent (pName) as TIcQRDBImage).Selected := pSelected;
    If F_QR.FindComponent (pName) is TIcQRChart then (F_QR.FindComponent (pName) as TIcQRChart).Selected := pSelected;
    If F_QR.FindComponent (pName) is TIcQRBarCode then (F_QR.FindComponent (pName) as TIcQRBarCode).Selected := pSelected;
  end;
end;

function  TF_QRMain.IsSelected (pName:string):boolean;
var mComp:TObject;
begin
  Result := FALSE;
  mComp := F_QR.FindComponent (pName);
  If  mComp<>nil then begin
    If mComp is TIcQuickRep then Result := (mComp as TIcQuickRep).Selected;
    If mComp is TIcQRBand then Result := (mComp as TIcQRBand).Selected;
    If mComp is TIcQRSubDetail then Result := (mComp as TIcQRSubDetail).Selected;
    If mComp is TIcQRChildBand then Result := (mComp as TIcQRChildBand).Selected;
    If mComp is TIcQRGroup then Result := (mComp as TIcQRGroup).Selected;
    If mComp is TIcQRLabel then Result := (mComp as TIcQRLabel).Selected;
    If mComp is TIcQRDBText then Result := (mComp as TIcQRDBText).Selected;
    If mComp is TIcQRExpr then Result := (mComp as TIcQRExpr).Selected;
    If mComp is TIcQRSysData then Result := (mComp as TIcQRSysData).Selected;
    If mComp is TIcQRMemo then Result := (mComp as TIcQRMemo).Selected;
    If mComp is TIcQRShape then Result := (mComp as TIcQRShape).Selected;
    If mComp is TIcQRImage then Result := (mComp as TIcQRImage).Selected;
    If mComp is TIcQRDBImage then Result := (mComp as TIcQRDBImage).Selected;
    If mComp is TIcQRChart then Result := (mComp as TIcQRChart).Selected;
    If mComp is TIcQRBarCode then Result := (mComp as TIcQRBarCode).Selected;
  end;
end;

procedure TF_QRMain.SetActCompImage;
var
  mImageInd:byte;
  mImage:TBitmap;
begin
  If F_QR.FindComponent (CB_CompName.Text)<>nil then begin
    mImageInd := 0;
    If F_QR.FindComponent (CB_CompName.Text) is TQuickRep then mImageInd := 0;
    If F_QR.FindComponent (CB_CompName.Text) is TQRBand then mImageInd := 1;
    If F_QR.FindComponent (CB_CompName.Text) is TQRChildBand then mImageInd := 2;
    If F_QR.FindComponent (CB_CompName.Text) is TQRSubDetail then mImageInd := 3;
    If F_QR.FindComponent (CB_CompName.Text) is TQRGroup then mImageInd := 4;
    If F_QR.FindComponent (CB_CompName.Text) is TQRLabel then mImageInd := 5;
    If F_QR.FindComponent (CB_CompName.Text) is TQRDBText then mImageInd := 6;
    If F_QR.FindComponent (CB_CompName.Text) is TQRExpr then mImageInd := 7;
    If F_QR.FindComponent (CB_CompName.Text) is TQRSysData then mImageInd := 8;
    If F_QR.FindComponent (CB_CompName.Text) is TQRMemo then mImageInd := 9;
    If F_QR.FindComponent (CB_CompName.Text) is TQRShape then mImageInd := 10;
    If F_QR.FindComponent (CB_CompName.Text) is TQRImage then mImageInd := 11;
    If F_QR.FindComponent (CB_CompName.Text) is TQRDBImage then mImageInd := 12;
    If F_QR.FindComponent (CB_CompName.Text) is TQRChart then mImageInd := 13;
    If F_QR.FindComponent (CB_CompName.Text) is TQRBarCode then mImageInd := 14;
    mImage := TBitmap.Create;
    IL_Comp.GetBitmap (mImageInd,mImage);
    I_ActComp.Picture.Assign (mImage);
    mImage.Free; mImage := nil;
  end else I_ActComp.Picture.Bitmap := nil;
end;

procedure TF_QRMain.FillActCompParam (pComp:string);
begin
  If F_QR.FindComponent (pComp)<>nil then begin
    oCompData.rLeft   := SetMultiLong (E_Left.Text,(F_QR.FindComponent (pComp) as TControl).Left);
    oCompData.rTop    := SetMultiLong (E_Top.Text, (F_QR.FindComponent (pComp) as TControl).Top);
    oCompData.rWidth  := SetMultiLong (E_Width.Text, (F_QR.FindComponent (pComp) as TControl).Width);
    oCompData.rHeight := SetMultiLong (E_Height.Text, (F_QR.FindComponent (pComp) as TControl).Height);
    If F_QR.FindComponent (pComp) is TQuickRep then begin
      If not cqMultiSelect then oCompType := 1 else If oCompType<>1 then oCompType := -1;
      oCompData.rLeftMM       := SetMultiDoub (E_LeftMM.Text, 0);
      oCompData.rTopMM        := SetMultiDoub (E_TopMM.Text, 0);
      oCompData.rWidthMM      := SetMultiDoub (E_WidthMM.Text, (F_QR.FindComponent (pComp) as TQuickRep).Page.Width);
      oCompData.rHeightMM     := SetMultiDoub (E_HeightMM.Text, (F_QR.FindComponent (pComp) as TQuickRep).Page.Length);
      SetMultiAutoSize (FALSE, FALSE);
      SetMultiAlignment (FALSE, taLeftJustify);
      SetMultiFont (TRUE, (F_QR.FindComponent (pComp) as TQuickRep).Font);
      SetMultiFrame ((F_QR.FindComponent (pComp) as TQuickRep).Frame);
      SetMultiWordWrap (FALSE, FALSE);
      SetMultiTransparent (FALSE, FALSE);
      SetMultiBkColor (FALSE, clWhite);

      If (F_QR.FindComponent (pComp) as TQuickRep).DataSet<>nil
        then SetMultiQuickRepDataSet ((F_QR.FindComponent (pComp) as TQuickRep).DataSet.Owner.Name+'.'+(F_QR.FindComponent (pComp) as TQuickRep).DataSet.Name)
        else SetMultiQuickRepDataSet ('');
      SetMultiQuickRepTopMargin ((F_QR.FindComponent (pComp) as TQuickRep).Page.TopMargin);
      SetMultiQuickRepBottomMargin ((F_QR.FindComponent (pComp) as TQuickRep).Page.BottomMargin);
      SetMultiQuickRepLeftMargin ((F_QR.FindComponent (pComp) as TQuickRep).Page.LeftMargin);
      SetMultiQuickRepRightMargin ((F_QR.FindComponent (pComp) as TQuickRep).Page.RightMargin);
      SetMultiQuickRepPaperSize ((F_QR.FindComponent (pComp) as TQuickRep).Page.PaperSize);
      SetMultiQuickRepColumns ((F_QR.FindComponent (pComp) as TQuickRep).Page.Columns);
      SetMultiQuickRepColumnSpace ((F_QR.FindComponent (pComp) as TQuickRep).Page.ColumnSpace);
      SetMultiQuickRepPrintIfEmpty  ((F_QR.FindComponent (pComp) as TQuickRep).PrintIfEmpty);
    end;
    If F_QR.FindComponent (pComp) is TQRBand then begin
      If not cqMultiSelect then oCompType := 2 else If oCompType<>2 then oCompType := -1;
      oCompData.rLeftMM       := SetMultiDoub (E_LeftMM.Text, 0);
      oCompData.rTopMM        := SetMultiDoub (E_TopMM.Text, 0);
      oCompData.rWidthMM      := SetMultiDoub (E_WidthMM.Text, (F_QR.FindComponent (pComp) as TQRBand).Size.Width);
      oCompData.rHeightMM     := SetMultiDoub (E_HeightMM.Text, (F_QR.FindComponent (pComp) as TQRBand).Size.Height);
      SetMultiAutoSize (FALSE, FALSE);
      SetMultiAlignment (FALSE, taLeftJustify);
      SetMultiFont (TRUE, (F_QR.FindComponent (pComp) as TQRBand).Font);
      SetMultiFrame ((F_QR.FindComponent (pComp) as TQRBand).Frame);
      SetMultiWordWrap (FALSE, FALSE);
      SetMultiTransparent (FALSE, FALSE);
      SetMultiBkColor (TRUE, (F_QR.FindComponent (pComp) as TQRBand).Color);

      SetMultiBandBandType ((F_QR.FindComponent (pComp) as TQRBand).BandType);
      SetMultiBandAlignToBottom ((F_QR.FindComponent (pComp) as TQRBand).AlignToBottom);
      SetMultiBandForceNewColumn ((F_QR.FindComponent (pComp) as TQRBand).ForceNewColumn);
      SetMultiBandForceNewPage ((F_QR.FindComponent (pComp) as TQRBand).ForceNewPage);
      If (F_QR.FindComponent (pComp) as TQRBand).LinkBand<>nil
        then SetMultiBandLinkBand ((F_QR.FindComponent (pComp) as TQRBand).LinkBand.Name)
        else SetMultiBandLinkBand ('');
    end;
    If F_QR.FindComponent (pComp) is TQRChildBand then begin
      If not cqMultiSelect then oCompType := 3 else If oCompType<>3 then oCompType := -1;
      oCompData.rLeftMM       := SetMultiDoub (E_LeftMM.Text, 0);
      oCompData.rTopMM        := SetMultiDoub (E_TopMM.Text, 0);
      oCompData.rWidthMM      := SetMultiDoub (E_WidthMM.Text, (F_QR.FindComponent (pComp) as TQRChildBand).Size.Width);
      oCompData.rHeightMM     := SetMultiDoub (E_HeightMM.Text, (F_QR.FindComponent (pComp) as TQRChildBand).Size.Height);
      SetMultiAutoSize (FALSE, FALSE);
      SetMultiAlignment (FALSE, taLeftJustify);
      SetMultiFont (TRUE, (F_QR.FindComponent (pComp) as TQRChildBand).Font);
      SetMultiFrame ((F_QR.FindComponent (pComp) as TQRChildBand).Frame);
      SetMultiWordWrap (FALSE, FALSE);
      SetMultiTransparent (FALSE, FALSE);
      SetMultiBkColor (TRUE, (F_QR.FindComponent (pComp) as TQRChildBand).Color);

      If (F_QR.FindComponent (pComp) as TQRChildBand).ParentBand<>nil
        then SetMultiChildBandParentBand ((F_QR.FindComponent (pComp) as TQRChildBand).ParentBand.Name)
        else SetMultiChildBandParentBand ('');
      SetMultiChildBandAlignToBottom ((F_QR.FindComponent (pComp) as TQRChildBand).AlignToBottom);
      SetMultiChildBandForceNewColumn ((F_QR.FindComponent (pComp) as TQRChildBand).ForceNewColumn);
      SetMultiChildBandForceNewPage ((F_QR.FindComponent (pComp) as TQRChildBand).ForceNewPage);
      If (F_QR.FindComponent (pComp) as TQRChildBand).LinkBand<>nil
        then SetMultiChildBandLinkBand ((F_QR.FindComponent (pComp) as TQRChildBand).LinkBand.Name)
        else SetMultiChildBandLinkBand ('');
    end;
    If F_QR.FindComponent (pComp) is TQRSubDetail then begin
      If not cqMultiSelect then oCompType := 4 else If oCompType<>4 then oCompType := -1;
      oCompData.rLeftMM       := SetMultiDoub (E_LeftMM.Text, 0);
      oCompData.rTopMM        := SetMultiDoub (E_TopMM.Text, 0);
      oCompData.rWidthMM      := SetMultiDoub (E_WidthMM.Text, (F_QR.FindComponent (pComp) as TQRSubDetail).Size.Width);
      oCompData.rHeightMM     := SetMultiDoub (E_HeightMM.Text, (F_QR.FindComponent (pComp) as TQRSubDetail).Size.Height);
      SetMultiAutoSize (FALSE, FALSE);
      SetMultiAlignment (FALSE, taLeftJustify);
      SetMultiFont (TRUE, (F_QR.FindComponent (pComp) as TQRSubDetail).Font);
      SetMultiFrame ((F_QR.FindComponent (pComp) as TQRSubDetail).Frame);
      SetMultiWordWrap (FALSE, FALSE);
      SetMultiTransparent (FALSE, FALSE);
      SetMultiBkColor (TRUE, (F_QR.FindComponent (pComp) as TQRSubDetail).Color);

      If (F_QR.FindComponent (pComp) as TQRSubDetail).Master<>nil
        then SetMultiSubDetailMaster ((F_QR.FindComponent (pComp) as TQRSubDetail).Master.Name)
        else SetMultiSubDetailMaster ('');
      If (F_QR.FindComponent (pComp) as TQRSubDetail).DataSet<>nil
        then SetMultiSubDetailDataSet ((F_QR.FindComponent (pComp) as TQRSubDetail).DataSet.Owner.Name+'.'+(F_QR.FindComponent (pComp) as TQRSubDetail).DataSet.Name)
        else SetMultiSubDetailDataSet ('');
      If (F_QR.FindComponent (pComp) as TQRSubDetail).HeaderBand<>nil
        then SetMultiSubDeatilHeaderBand ((F_QR.FindComponent (pComp) as TQRSubDetail).HeaderBand.Name)
        else SetMultiSubDeatilHeaderBand ('');
      If (F_QR.FindComponent (pComp) as TQRSubDetail).FooterBand<>nil
        then SetMultiSubDetailFooterBand ((F_QR.FindComponent (pComp) as TQRSubDetail).FooterBand.Name)
        else SetMultiSubDetailFooterBand ('');
      SetMultiSubDetailAlignToBottom ((F_QR.FindComponent (pComp) as TQRSubDetail).AlignToBottom);
      SetMultiSubDetailForceNewColumn ((F_QR.FindComponent (pComp) as TQRSubDetail).ForceNewColumn);
      SetMultiSubDetailForceNewPage ((F_QR.FindComponent (pComp) as TQRSubDetail).ForceNewPage);
      If (F_QR.FindComponent (pComp) as TQRSubDetail).LinkBand<>nil
        then SetMultiSubDetailLinkBand ((F_QR.FindComponent (pComp) as TQRSubDetail).LinkBand.Name)
        else SetMultiSubDetailLinkBand ('');
      SetMultiSubDetailPrintBefore ((F_QR.FindComponent (pComp) as TQRSubDetail).PrintBefore);
      SetMultiSubDetailPrintIfEmpty ((F_QR.FindComponent (pComp) as TQRSubDetail).PrintIfEmpty);
    end;
    If F_QR.FindComponent (pComp) is TQRGroup then begin
      If not cqMultiSelect then oCompType := 5 else If oCompType<>5 then oCompType := -1;
      oCompData.rLeftMM       := SetMultiDoub (E_LeftMM.Text, 0);
      oCompData.rTopMM        := SetMultiDoub (E_TopMM.Text, 0);
      oCompData.rWidthMM      := SetMultiDoub (E_WidthMM.Text, (F_QR.FindComponent (pComp) as TQRGroup).Size.Width);
      oCompData.rHeightMM     := SetMultiDoub (E_HeightMM.Text, (F_QR.FindComponent (pComp) as TQRGroup).Size.Height);
      SetMultiAutoSize (FALSE, FALSE);
      SetMultiAlignment (FALSE, taLeftJustify);
      SetMultiFont (TRUE, (F_QR.FindComponent (pComp) as TQRGroup).Font);
      SetMultiFrame ((F_QR.FindComponent (pComp) as TQRGroup).Frame);
      SetMultiWordWrap (FALSE, FALSE);
      SetMultiTransparent (FALSE, FALSE);
      SetMultiBkColor (TRUE, (F_QR.FindComponent (pComp) as TQRGroup).Color);

      If (F_QR.FindComponent (pComp) as TQRGroup).Master<>nil
        then SetMultiGroupMaster ((F_QR.FindComponent (pComp) as TQRGroup).Master.Name)
        else SetMultiGroupMaster ('');
      If (F_QR.FindComponent (pComp) as TQRGroup).FooterBand<>nil
        then SetMultiGroupFooterBand ((F_QR.FindComponent (pComp) as TQRGroup).FooterBand.Name)
        else SetMultiGroupFooterBand ('');
      SetMultiGroupExpression ((F_QR.FindComponent (pComp) as TQRGroup).Expression);
      SetMultiGroupAlignToBottom ((F_QR.FindComponent (pComp) as TQRGroup).AlignToBottom);
      SetMultiGroupForceNewColumn ((F_QR.FindComponent (pComp) as TQRGroup).ForceNewColumn);
      SetMultiGroupForceNewPage ((F_QR.FindComponent (pComp) as TQRGroup).ForceNewPage);
      If (F_QR.FindComponent (pComp) as TQRGroup).LinkBand<>nil
        then SetMultiGroupLinkBand ((F_QR.FindComponent (pComp) as TQRGroup).LinkBand.Name)
        else SetMultiGroupLinkBand ('');
      SetMultiGroupReprintOnNewPage ((F_QR.FindComponent (pComp) as TQRGroup).ReprintOnNewPage);
    end;
    If F_QR.FindComponent (pComp) is TQRLabel then begin
      If not cqMultiSelect then oCompType := 6 else If oCompType<>6 then oCompType := -1;
      oCompData.rLeftMM       := SetMultiDoub (E_LeftMM.Text, (F_QR.FindComponent (pComp) as TQRLabel).Size.Left);
      oCompData.rTopMM        := SetMultiDoub (E_TopMM.Text, (F_QR.FindComponent (pComp) as TQRLabel).Size.Top);
      oCompData.rWidthMM      := SetMultiDoub (E_WidthMM.Text, (F_QR.FindComponent (pComp) as TQRLabel).Size.Width);
      oCompData.rHeightMM     := SetMultiDoub (E_HeightMM.Text, (F_QR.FindComponent (pComp) as TQRLabel).Size.Height);
      SetMultiAutoSize (TRUE, (F_QR.FindComponent (pComp) as TQRLabel).AutoSize);
      SetMultiAlignment (TRUE, (F_QR.FindComponent (pComp) as TQRLabel).Alignment);
      SetMultiFont (TRUE, (F_QR.FindComponent (pComp) as TQRLabel).Font);
      SetMultiFrame ((F_QR.FindComponent (pComp) as TQRLabel).Frame);
      SetMultiWordWrap (TRUE, (F_QR.FindComponent (pComp) as TQRLabel).WordWrap);
      SetMultiTransparent (TRUE, (F_QR.FindComponent (pComp) as TQRLabel).Transparent);
      SetMultiBkColor (TRUE, (F_QR.FindComponent (pComp) as TQRLabel).Color);

      SetMultiLabelCaption ((F_QR.FindComponent (pComp) as TQRLabel).Caption);
    end;
    If F_QR.FindComponent (pComp) is TQRDBText then begin
      If not cqMultiSelect then oCompType := 7 else If oCompType<>7 then oCompType := -1;
      oCompData.rLeftMM       := SetMultiDoub (E_LeftMM.Text, (F_QR.FindComponent (pComp) as TQRDBText).Size.Left);
      oCompData.rTopMM        := SetMultiDoub (E_TopMM.Text, (F_QR.FindComponent (pComp) as TQRDBText).Size.Top);
      oCompData.rWidthMM      := SetMultiDoub (E_WidthMM.Text, (F_QR.FindComponent (pComp) as TQRDBText).Size.Width);
      oCompData.rHeightMM     := SetMultiDoub (E_HeightMM.Text, (F_QR.FindComponent (pComp) as TQRDBText).Size.Height);
      SetMultiAutoSize (TRUE, (F_QR.FindComponent (pComp) as TQRDBText).AutoSize);
      SetMultiAlignment (TRUE, (F_QR.FindComponent (pComp) as TQRDBText).Alignment);
      SetMultiFont (TRUE, (F_QR.FindComponent (pComp) as TQRDBText).Font);
      SetMultiFrame ((F_QR.FindComponent (pComp) as TQRDBText).Frame);
      SetMultiWordWrap (TRUE, (F_QR.FindComponent (pComp) as TQRDBText).WordWrap);
      SetMultiTransparent (TRUE, (F_QR.FindComponent (pComp) as TQRDBText).Transparent);
      SetMultiBkColor (TRUE, (F_QR.FindComponent (pComp) as TQRDBText).Color);

      If (F_QR.FindComponent (pComp) as TQRDBText).DataSet<>nil then begin
        SetMultiDBTextDataSet ((F_QR.FindComponent (pComp) as TQRDBText).DataSet.Owner.Name+'.'+(F_QR.FindComponent (pComp) as TQRDBText).DataSet.Name);
        SetMultiDBTextDataField ((F_QR.FindComponent (pComp) as TQRDBText).DataSet.Owner.Name+'.'+(F_QR.FindComponent (pComp) as TQRDBText).DataSet.Name, (F_QR.FindComponent (pComp) as TQRDBText).DataField);
      end else begin
        SetMultiDBTextDataSet ('');
        SetMultiDBTextDataField ('', '');
      end;
      SetMultiDBTextMask ((F_QR.FindComponent (pComp) as TQRDBText).Mask);
    end;
    If F_QR.FindComponent (pComp) is TQRExpr then begin
      If not cqMultiSelect then oCompType := 8 else If oCompType<>8 then oCompType := -1;
      oCompData.rLeftMM       := SetMultiDoub (E_LeftMM.Text, (F_QR.FindComponent (pComp) as TQRExpr).Size.Left);
      oCompData.rTopMM        := SetMultiDoub (E_TopMM.Text, (F_QR.FindComponent (pComp) as TQRExpr).Size.Top);
      oCompData.rWidthMM      := SetMultiDoub (E_WidthMM.Text, (F_QR.FindComponent (pComp) as TQRExpr).Size.Width);
      oCompData.rHeightMM     := SetMultiDoub (E_HeightMM.Text, (F_QR.FindComponent (pComp) as TQRExpr).Size.Height);
      SetMultiAutoSize (TRUE, (F_QR.FindComponent (pComp) as TQRExpr).AutoSize);
      SetMultiAlignment (TRUE, (F_QR.FindComponent (pComp) as TQRExpr).Alignment);
      SetMultiFont (TRUE, (F_QR.FindComponent (pComp) as TQRExpr).Font);
      SetMultiFrame ((F_QR.FindComponent (pComp) as TQRExpr).Frame);
      SetMultiWordWrap (TRUE, (F_QR.FindComponent (pComp) as TQRExpr).WordWrap);
      SetMultiTransparent (TRUE, (F_QR.FindComponent (pComp) as TQRExpr).Transparent);
      SetMultiBkColor (TRUE, (F_QR.FindComponent (pComp) as TQRExpr).Color);

      SetMultiExprExpression ((F_QR.FindComponent (pComp) as TQRExpr).Expression);
      SetMultiExprMask ((F_QR.FindComponent (pComp) as TQRExpr).Mask);
      If (F_QR.FindComponent (pComp) as TQRExpr).Master<>nil
        then SetMultiExprMaster ((F_QR.FindComponent (pComp) as TQRExpr).Master.Name)
        else SetMultiExprMaster ('');
      SetMultiExprResetAfterPrint ((F_QR.FindComponent (pComp) as TQRExpr).ResetAfterPrint);
    end;
    If F_QR.FindComponent (pComp) is TQRSysData then begin
      If not cqMultiSelect then oCompType := 9 else If oCompType<>9 then oCompType := -1;
      oCompData.rLeftMM       := SetMultiDoub (E_LeftMM.Text, (F_QR.FindComponent (pComp) as TQRSysData).Size.Left);
      oCompData.rTopMM        := SetMultiDoub (E_TopMM.Text, (F_QR.FindComponent (pComp) as TQRSysData).Size.Top);
      oCompData.rWidthMM      := SetMultiDoub (E_WidthMM.Text, (F_QR.FindComponent (pComp) as TQRSysData).Size.Width);
      oCompData.rHeightMM     := SetMultiDoub (E_HeightMM.Text, (F_QR.FindComponent (pComp) as TQRSysData).Size.Height);
      SetMultiAutoSize (TRUE, (F_QR.FindComponent (pComp) as TQRSysData).AutoSize);
      SetMultiAlignment (TRUE, (F_QR.FindComponent (pComp) as TQRSysData).Alignment);
      SetMultiFont (TRUE, (F_QR.FindComponent (pComp) as TQRSysData).Font);
      SetMultiFrame ((F_QR.FindComponent (pComp) as TQRSysData).Frame);
      SetMultiWordWrap (FALSE, FALSE);
      SetMultiTransparent (TRUE, (F_QR.FindComponent (pComp) as TQRSysData).Transparent);
      SetMultiBkColor (TRUE, (F_QR.FindComponent (pComp) as TQRSysData).Color);

      SetMultiSysDataText ((F_QR.FindComponent (pComp) as TQRSysData).Text);
      SetMultiSysDataType ((F_QR.FindComponent (pComp) as TQRSysData).Data);
    end;
    If F_QR.FindComponent (pComp) is TQRMemo then begin
      If not cqMultiSelect then oCompType := 10 else If oCompType<>10 then oCompType := -1;
      oCompData.rLeftMM       := SetMultiDoub (E_LeftMM.Text, (F_QR.FindComponent (pComp) as TQRMemo).Size.Left);
      oCompData.rTopMM        := SetMultiDoub (E_TopMM.Text, (F_QR.FindComponent (pComp) as TQRMemo).Size.Top);
      oCompData.rWidthMM      := SetMultiDoub (E_WidthMM.Text, (F_QR.FindComponent (pComp) as TQRMemo).Size.Width);
      oCompData.rHeightMM     := SetMultiDoub (E_HeightMM.Text, (F_QR.FindComponent (pComp) as TQRMemo).Size.Height);
      SetMultiAutoSize (TRUE, (F_QR.FindComponent (pComp) as TQRMemo).AutoSize);
      SetMultiAlignment (TRUE, (F_QR.FindComponent (pComp) as TQRMemo).Alignment);
      SetMultiFont (TRUE, (F_QR.FindComponent (pComp) as TQRMemo).Font);
      SetMultiFrame ((F_QR.FindComponent (pComp) as TQRMemo).Frame);
      SetMultiWordWrap (TRUE, (F_QR.FindComponent (pComp) as TQRMemo).WordWrap);
      SetMultiTransparent (TRUE, (F_QR.FindComponent (pComp) as TQRMemo).Transparent);
      SetMultiBkColor (TRUE, (F_QR.FindComponent (pComp) as TQRMemo).Color);

      SetMultiMemoLines ((F_QR.FindComponent (pComp) as TQRMemo).Lines);
    end;
    If F_QR.FindComponent (pComp) is TQRShape then begin
      If not cqMultiSelect then oCompType := 11 else If oCompType<>11 then oCompType := -1;
      oCompData.rLeftMM       := SetMultiDoub (E_LeftMM.Text, (F_QR.FindComponent (pComp) as TQRShape).Size.Left);
      oCompData.rTopMM        := SetMultiDoub (E_TopMM.Text, (F_QR.FindComponent (pComp) as TQRShape).Size.Top);
      oCompData.rWidthMM      := SetMultiDoub (E_WidthMM.Text, (F_QR.FindComponent (pComp) as TQRShape).Size.Width);
      oCompData.rHeightMM     := SetMultiDoub (E_HeightMM.Text, (F_QR.FindComponent (pComp) as TQRShape).Size.Height);
      SetMultiAutoSize (FALSE, FALSE);
      SetMultiAlignment (FALSE, taLeftJustify);
      SetMultiFont (FALSE, nil);
      SetMultiFrame ((F_QR.FindComponent (pComp) as TQRShape).Frame);
      SetMultiWordWrap (FALSE, FALSE);
      SetMultiTransparent (FALSE, FALSE);
      SetMultiBkColor (FALSE, clWhite);

      SetMultiShapeBrushStyle ((F_QR.FindComponent (pComp) as TQRShape).Brush.Style);
      SetMultiShapeBrushColor ((F_QR.FindComponent (pComp) as TQRShape).Brush.Color);
      SetMultiShapePenWidth ((F_QR.FindComponent (pComp) as TQRShape).Pen.Width);
      SetMultiShapePenStyle ((F_QR.FindComponent (pComp) as TQRShape).Pen.Style);
      SetMultiShapePenColor ((F_QR.FindComponent (pComp) as TQRShape).Pen.Color);
      SetMultiShapeType ((F_QR.FindComponent (pComp) as TQRShape).Shape);
    end;
    If F_QR.FindComponent (pComp) is TQRImage then begin
      If not cqMultiSelect then oCompType := 12 else If oCompType<>12 then oCompType := -1;
      oCompData.rLeftMM       := SetMultiDoub (E_LeftMM.Text, (F_QR.FindComponent (pComp) as TQRImage).Size.Left);
      oCompData.rTopMM        := SetMultiDoub (E_TopMM.Text, (F_QR.FindComponent (pComp) as TQRImage).Size.Top);
      oCompData.rWidthMM      := SetMultiDoub (E_WidthMM.Text, (F_QR.FindComponent (pComp) as TQRImage).Size.Width);
      oCompData.rHeightMM     := SetMultiDoub (E_HeightMM.Text, (F_QR.FindComponent (pComp) as TQRImage).Size.Height);
      SetMultiAutoSize (TRUE, (F_QR.FindComponent (pComp) as TQRImage).AutoSize);
      SetMultiAlignment (FALSE, taLeftJustify);
      SetMultiFont (FALSE, nil);
      SetMultiFrame ((F_QR.FindComponent (pComp) as TQRImage).Frame);
      SetMultiWordWrap (FALSE, FALSE);
      SetMultiTransparent (FALSE, FALSE);
      SetMultiBkColor (FALSE, clWhite);

      SetMultiImageStretch ((F_QR.FindComponent (pComp) as TQRImage).Stretch, (F_QR.FindComponent (pComp) as TQRImage).Center);
    end;
    If F_QR.FindComponent (pComp) is TQRDBImage then begin
      If not cqMultiSelect then oCompType := 13 else If oCompType<>13 then oCompType := -1;
      oCompData.rLeftMM       := SetMultiDoub (E_LeftMM.Text, (F_QR.FindComponent (pComp) as TQRDBImage).Size.Left);
      oCompData.rTopMM        := SetMultiDoub (E_TopMM.Text, (F_QR.FindComponent (pComp) as TQRDBImage).Size.Top);
      oCompData.rWidthMM      := SetMultiDoub (E_WidthMM.Text, (F_QR.FindComponent (pComp) as TQRDBImage).Size.Width);
      oCompData.rHeightMM     := SetMultiDoub (E_HeightMM.Text, (F_QR.FindComponent (pComp) as TQRDBImage).Size.Height);
      SetMultiAutoSize (FALSE, FALSE);
      SetMultiAlignment (FALSE, taLeftJustify);
      SetMultiFont (FALSE, nil);
      SetMultiFrame ((F_QR.FindComponent (pComp) as TQRDBImage).Frame);
      SetMultiWordWrap (FALSE, FALSE);
      SetMultiTransparent (FALSE, FALSE);
      SetMultiBkColor (FALSE, clWhite);

      If (F_QR.FindComponent (pComp) as TQRDBImage).DataSet<>nil then begin
        SetMultiDBImageDataSet ((F_QR.FindComponent (pComp) as TQRDBImage).DataSet.Owner.Name+'.'+(F_QR.FindComponent (pComp) as TQRDBImage).DataSet.Name);
        SetMultiDBImageDataField ((F_QR.FindComponent (pComp) as TQRDBImage).DataSet.Owner.Name+'.'+(F_QR.FindComponent (pComp) as TQRDBImage).DataSet.Name, (F_QR.FindComponent (pComp) as TQRDBImage).DataField);
      end else begin
        SetMultiDBImageDataSet ('');
        SetMultiDBImageDataField ('', '');
      end;
      SetMultiDBImageStretch ((F_QR.FindComponent (pComp) as TQRDBImage).Stretch, (F_QR.FindComponent (pComp) as TQRDBImage).Center);
    end;
    If F_QR.FindComponent (pComp) is TQRChart then begin
      If not cqMultiSelect then oCompType := 14 else If oCompType<>14 then oCompType := -1;
      oCompData.rLeftMM       := SetMultiDoub (E_LeftMM.Text, (F_QR.FindComponent (pComp) as TQRChart).Size.Left);
      oCompData.rTopMM        := SetMultiDoub (E_TopMM.Text, (F_QR.FindComponent (pComp) as TQRChart).Size.Top);
      oCompData.rWidthMM      := SetMultiDoub (E_WidthMM.Text, (F_QR.FindComponent (pComp) as TQRChart).Size.Width);
      oCompData.rHeightMM     := SetMultiDoub (E_HeightMM.Text, (F_QR.FindComponent (pComp) as TQRChart).Size.Height);
      SetMultiAutoSize (FALSE, FALSE);
      SetMultiAlignment (FALSE, taLeftJustify);
      SetMultiFont (TRUE, (F_QR.FindComponent (pComp) as TIcQRChart).Chart.LeftAxis.LabelsFont);
      SetMultiFrame ((F_QR.FindComponent (pComp) as TQRChart).Frame);
      SetMultiWordWrap (FALSE, FALSE);
      SetMultiTransparent (FALSE, FALSE);
      SetMultiBkColor (TRUE, ((F_QR.FindComponent (pComp) as TQRChart).Chart.Series[0] as TAreaSeries).SeriesColor);
      SetMultiChartStairs (((F_QR.FindComponent (pComp) as TQRChart).Chart.Series[0] as TAreaSeries).Stairs);
      SetMultiChartXDateTime (((F_QR.FindComponent (pComp) as TQRChart).Chart.Series[0] as TAreaSeries).XValues.DateTime);
      SetMultiChartYDateTime (((F_QR.FindComponent (pComp) as TQRChart).Chart.Series[0] as TAreaSeries).YValues.DateTime);

      If ((F_QR.FindComponent (pComp) as TQRChart).Chart.Series[0] as TAreaSeries).DataSource<>nil then begin
        SetMultiChartDataSet (((F_QR.FindComponent (pComp) as TQRChart).Chart.Series[0] as TAreaSeries).DataSource.Owner.Name+'.'+((F_QR.FindComponent (pComp) as TQRChart).Chart.Series[0] as TAreaSeries).DataSource.Name);
        SetMultiChartXDataField (((F_QR.FindComponent (pComp) as TQRChart).Chart.Series[0] as TAreaSeries).Owner.Name+'.'+((F_QR.FindComponent (pComp) as TQRChart).Chart.Series[0] as TAreaSeries).Name, ((F_QR.FindComponent (pComp) as TQRChart).Chart.Series[0] as TAreaSeries).XValues.ValueSource);
        SetMultiChartYDataField (((F_QR.FindComponent (pComp) as TQRChart).Chart.Series[0] as TAreaSeries).Owner.Name+'.'+((F_QR.FindComponent (pComp) as TQRChart).Chart.Series[0] as TAreaSeries).Name, ((F_QR.FindComponent (pComp) as TQRChart).Chart.Series[0] as TAreaSeries).YValues.ValueSource);
      end else begin
        SetMultiChartDataSet ('');
        SetMultiChartXDataField ('', '');
        SetMultiChartYDataField ('', '');
      end;
    end;
    If F_QR.FindComponent (pComp) is TQRBarCode then begin
      If not cqMultiSelect then oCompType := 15 else If oCompType<>15 then oCompType := -1;
      oCompData.rLeftMM       := SetMultiDoub (E_LeftMM.Text, (F_QR.FindComponent (pComp) as TQRBarCode).Size.Left);
      oCompData.rTopMM        := SetMultiDoub (E_TopMM.Text, (F_QR.FindComponent (pComp) as TQRBarCode).Size.Top);
      oCompData.rWidthMM      := SetMultiDoub (E_WidthMM.Text, (F_QR.FindComponent (pComp) as TQRBarCode).Size.Width);
      oCompData.rHeightMM     := SetMultiDoub (E_HeightMM.Text, (F_QR.FindComponent (pComp) as TQRBarCode).Size.Height);
      SetMultiAutoSize (FALSE, FALSE);
      SetMultiAlignment (FALSE, taLeftJustify);
      SetMultiFont (FALSE, nil);
      SetMultiFrame ((F_QR.FindComponent (pComp) as TQRBarCode).Frame);
      SetMultiWordWrap (FALSE, FALSE);
      SetMultiTransparent (FALSE, FALSE);
      SetMultiBkColor (TRUE, (F_QR.FindComponent (pComp) as TQRBarCode).BarColor);
      SetMultiBarCodeType ((F_QR.FindComponent (pComp) as TQRBarCode).BarCodeType);
      SetMultiBarCodeText ((F_QR.FindComponent (pComp) as TQRBarCode).Text);
      SetMultiBarCodeClearZone ((F_QR.FindComponent (pComp) as TQRBarCode).ClearZone);

      If (F_QR.FindComponent (pComp) as TQRBarCode).DataSet<>nil then begin
        SetMultiBarCodeDataSet ((F_QR.FindComponent (pComp) as TQRBarCode).DataSet.Owner.Name+'.'+(F_QR.FindComponent (pComp) as TQRBarCode).DataSet.Name);
        SetMultiBarCodeDataField ((F_QR.FindComponent (pComp) as TQRBarCode).DataSet.Owner.Name+'.'+(F_QR.FindComponent (pComp) as TQRBarCode).DataSet.Name, (F_QR.FindComponent (pComp) as TQRBarCode).DataField);
      end else begin
        SetMultiBarCodeDataSet ('');
        SetMultiBarCodeDataField ('', '');
      end;
    end;
  end;
end;

procedure TF_QRMain.ShowActCompParam;
begin
  E_Left.Text := oCompData.rLeft;
  E_Top.Text := oCompData.rTop;
  E_Width.Text := oCompData.rWidth;
  E_Height.Text := oCompData.rHeight;
  E_LeftMM.Text := oCompData.rLeftMM;
  E_TopMM.Text := oCompData.rTopMM;
  E_WidthMM.Text := oCompData.rWidthMM;
  E_HeightMM.Text := oCompData.rHeightMM;
  SB_AutoSize.Enabled:= oCompData.rAutoSizeE;
  SB_AutoSize.Down := oCompData.rAutoSize;
  SB_AutoSize.Flat:= oCompData.rAutoSizeF;
  SetAlignPanel;
  SetFontPanel;
  SetFramePanel;
  SetWordWrap;
  SetTransparent;
  SetBkColor;
end;

procedure TF_QRMain.SetActCompParam (pScreenShow:boolean);
var I:longint;
begin
  cqMultiSelect := FALSE;
  oCompType := 0;
  If oShowing then begin
    If oCompList.Count>0 then begin
      For I:=0 to oCompList.Count-1 do begin
        If I>0 then cqMultiSelect := TRUE;
        FillActCompParam (oCompList.Strings[I]);
      end;
    end else SetNotSelComponents;
    If pScreenShow then begin
      ShowActCompParam;
      ShowSpecParams;
    end;
  end;
end;

procedure TF_QRMain.AddComponents (pName:string;pX, pY:longint);
begin
  oChange := TRUE;
  oXC := pX;
  oYC := pY;
  If oAddComp=1 then AddLabel (pName);
  If oAddComp=2 then AddDBText (pName);
  If oAddComp=3 then AddExpr (pName);
  If oAddComp=4 then AddSysData (pName);
  If oAddComp=5 then AddMemo (pName);
  If oAddComp=6 then AddShape (pName);
  If oAddComp=7 then AddImage(pName);
  If oAddComp=8 then AddDBImage(pName);
  If oAddComp=9 then AddChart (pName);
  If oAddComp=10 then AddBarCode (pName);
  FillCompNames;
  FillXYList;
end;

procedure TF_QRMain.AddLabel (pName:string);
var
  mComp:TIcQRLabel;
  mCnt:longint;
begin
  mComp := TIcQRLabel.Create (F_QR);
  mComp.Left := oXC;
  mComp.Top := oYC;
  If F_QR.FindComponent (pName) is TIcQRSubDetail then mComp.Parent := (F_QR.FindComponent (pName) as TIcQRSubDetail);
  If F_QR.FindComponent (pName) is TIcQRBand then mComp.Parent := (F_QR.FindComponent (pName) as TIcQRBand);
  If F_QR.FindComponent (pName) is TIcQRChildBand then mComp.Parent := (F_QR.FindComponent (pName) as TIcQRChildBand);
  If F_QR.FindComponent (pName) is TIcQRGroup then mComp.Parent := (F_QR.FindComponent (pName) as TIcQRGroup);
  mCnt := 1;
  While F_QR.FindComponent ('Label'+StrInt (mCnt,0))<>nil do
    Inc (mCnt);
  mComp.Name := 'Label'+StrInt (mCnt,0);
  mComp.OnMouseMove := IcQRLabelMouseMove;
  mComp.OnMouseDown := IcQRLabelMouseDown;
  mComp.OnMouseUp := IcCompMouseUp;
  mComp.OnClick := IcCompClick;
  SelectComp (mComp.Name);
end;

procedure TF_QRMain.AddDBText (pName:string);
var
  mComp:TIcQRDBText;
  mCnt:longint;
begin
  mComp := TIcQRDBText.Create (F_QR);
  mComp.Left := oXC;
  mComp.Top := oYC;
  If F_QR.FindComponent (pName) is TIcQRSubDetail then mComp.Parent := (F_QR.FindComponent (pName) as TIcQRSubDetail);
  If F_QR.FindComponent (pName) is TIcQRBand then mComp.Parent := (F_QR.FindComponent (pName) as TIcQRBand);
  If F_QR.FindComponent (pName) is TIcQRChildBand then mComp.Parent := (F_QR.FindComponent (pName) as TIcQRChildBand);
  If F_QR.FindComponent (pName) is TIcQRGroup then mComp.Parent := (F_QR.FindComponent (pName) as TIcQRGroup);
  mCnt := 1;
  While F_QR.FindComponent ('DBText'+StrInt (mCnt,0))<>nil do
    Inc (mCnt);
  mComp.Name := 'DBText'+StrInt (mCnt,0);
  mComp.OnMouseMove := IcQRDBTextMouseMove;
  mComp.OnMouseDown := IcQRDBTextMouseDown;
  mComp.OnMouseUp := IcCompMouseUp;
  mComp.OnClick := IcCompClick;
  SelectComp (mComp.Name);
end;

procedure TF_QRMain.AddExpr (pName:string);
var
  mComp:TIcQRExpr;
  mCnt:longint;
begin
  mComp := TIcQRExpr.Create (F_QR);
  mComp.Left := oXC;
  mComp.Top := oYC;
  If F_QR.FindComponent (pName) is TIcQRSubDetail then mComp.Parent := (F_QR.FindComponent (pName) as TIcQRSubDetail);
  If F_QR.FindComponent (pName) is TIcQRBand then mComp.Parent := (F_QR.FindComponent (pName) as TIcQRBand);
  If F_QR.FindComponent (pName) is TIcQRChildBand then mComp.Parent := (F_QR.FindComponent (pName) as TIcQRChildBand);
  If F_QR.FindComponent (pName) is TIcQRGroup then mComp.Parent := (F_QR.FindComponent (pName) as TIcQRGroup);
  mCnt := 1;
  While F_QR.FindComponent ('Expr'+StrInt (mCnt,0))<>nil do
    Inc (mCnt);
  mComp.Name := 'Expr'+StrInt (mCnt,0);
  mComp.OnMouseMove := IcQRExprMouseMove;
  mComp.OnMouseDown := IcQRExprMouseDown;
  mComp.OnMouseUp := IcCompMouseUp;
  mComp.OnClick := IcCompClick;
  SelectComp (mComp.Name);
end;

procedure TF_QRMain.AddSysData (pName:string);
var
  mComp:TIcQRSysData;
  mCnt:longint;
begin
  mComp := TIcQRSysData.Create (F_QR);
  mComp.Left := oXC;
  mComp.Top := oYC;
  If F_QR.FindComponent (pName) is TIcQRSubDetail then mComp.Parent := (F_QR.FindComponent (pName) as TIcQRSubDetail);
  If F_QR.FindComponent (pName) is TIcQRBand then mComp.Parent := (F_QR.FindComponent (pName) as TIcQRBand);
  If F_QR.FindComponent (pName) is TIcQRChildBand then mComp.Parent := (F_QR.FindComponent (pName) as TIcQRChildBand);
  If F_QR.FindComponent (pName) is TIcQRGroup then mComp.Parent := (F_QR.FindComponent (pName) as TIcQRGroup);
  mCnt := 1;
  While F_QR.FindComponent ('SysData'+StrInt (mCnt,0))<>nil do
    Inc (mCnt);
  mComp.Name := 'SysData'+StrInt (mCnt,0);
  mComp.OnMouseMove := IcQRSysDataMouseMove;
  mComp.OnMouseDown := IcQRSysDataMouseDown;
  mComp.OnMouseUp := IcCompMouseUp;
  mComp.OnClick := IcCompClick;
  SelectComp (mComp.Name);
end;

procedure TF_QRMain.AddMemo (pName:string);
var
  mComp:TIcQRMemo;
  mCnt:longint;
begin
  mComp := TIcQRMemo.Create (F_QR);
  mComp.Left := oXC;
  mComp.Top := oYC;
  If F_QR.FindComponent (pName) is TIcQRSubDetail then mComp.Parent := (F_QR.FindComponent (pName) as TIcQRSubDetail);
  If F_QR.FindComponent (pName) is TIcQRBand then mComp.Parent := (F_QR.FindComponent (pName) as TIcQRBand);
  If F_QR.FindComponent (pName) is TIcQRChildBand then mComp.Parent := (F_QR.FindComponent (pName) as TIcQRChildBand);
  If F_QR.FindComponent (pName) is TIcQRGroup then mComp.Parent := (F_QR.FindComponent (pName) as TIcQRGroup);
  mCnt := 1;
  While F_QR.FindComponent ('Memo'+StrInt (mCnt,0))<>nil do
    Inc (mCnt);
  mComp.Name := 'Memo'+StrInt (mCnt,0);
  mComp.Lines.Add (mComp.Name);
  mComp.OnMouseMove := IcQRMemoMouseMove;
  mComp.OnMouseDown := IcQRMemoMouseDown;
  mComp.OnMouseUp := IcCompMouseUp;
  mComp.OnClick := IcCompClick;
  SelectComp (mComp.Name);
end;

procedure TF_QRMain.AddShape (pName:string);
var
  mComp:TIcQRShape;
  mCnt:longint;
begin
  mComp := TIcQRShape.Create (F_QR);
  mComp.Left := oXC;
  mComp.Top := oYC;
  If F_QR.FindComponent (pName) is TIcQRSubDetail then mComp.Parent := (F_QR.FindComponent (pName) as TIcQRSubDetail);
  If F_QR.FindComponent (pName) is TIcQRBand then mComp.Parent := (F_QR.FindComponent (pName) as TIcQRBand);
  If F_QR.FindComponent (pName) is TIcQRChildBand then mComp.Parent := (F_QR.FindComponent (pName) as TIcQRChildBand);
  If F_QR.FindComponent (pName) is TIcQRGroup then mComp.Parent := (F_QR.FindComponent (pName) as TIcQRGroup);
  mCnt := 1;
  While F_QR.FindComponent ('Shape'+StrInt (mCnt,0))<>nil do
    Inc (mCnt);
  mComp.Name := 'Shape'+StrInt (mCnt,0);
  mComp.OnMouseMove := IcQRShapeMouseMove;
  mComp.OnMouseDown := IcQRShapeMouseDown;
  mComp.OnMouseUp := IcCompMouseUp;
  mComp.OnClick := IcCompClick;
  SelectComp (mComp.Name);
end;

procedure TF_QRMain.AddImage (pName:string);
var
  mComp:TIcQRImage;
  mCnt:longint;
begin
  mComp := TIcQRImage.Create (F_QR);
  mComp.Left := oXC;
  mComp.Top := oYC;
  If F_QR.FindComponent (pName) is TIcQRSubDetail then mComp.Parent := (F_QR.FindComponent (pName) as TIcQRSubDetail);
  If F_QR.FindComponent (pName) is TIcQRBand then mComp.Parent := (F_QR.FindComponent (pName) as TIcQRBand);
  If F_QR.FindComponent (pName) is TIcQRChildBand then mComp.Parent := (F_QR.FindComponent (pName) as TIcQRChildBand);
  If F_QR.FindComponent (pName) is TIcQRGroup then mComp.Parent := (F_QR.FindComponent (pName) as TIcQRGroup);
  mCnt := 1;
  While F_QR.FindComponent ('Image'+StrInt (mCnt,0))<>nil do
    Inc (mCnt);
  mComp.Name := 'Image'+StrInt (mCnt,0);
  mComp.OnMouseMove := IcQRImageMouseMove;
  mComp.OnMouseDown := IcQRImageMouseDown;
  mComp.OnMouseUp := IcCompMouseUp;
  mComp.OnClick := IcCompClick;
  SelectComp (mComp.Name);
end;

procedure TF_QRMain.AddDBImage (pName:string);
var
  mComp:TIcQRDBImage;
  mCnt:longint;
begin
  mComp := TIcQRDBImage.Create (F_QR);
  mComp.Left := oXC;
  mComp.Top := oYC;
  If F_QR.FindComponent (pName) is TIcQRSubDetail then mComp.Parent := (F_QR.FindComponent (pName) as TIcQRSubDetail);
  If F_QR.FindComponent (pName) is TIcQRBand then mComp.Parent := (F_QR.FindComponent (pName) as TIcQRBand);
  If F_QR.FindComponent (pName) is TIcQRChildBand then mComp.Parent := (F_QR.FindComponent (pName) as TIcQRChildBand);
  If F_QR.FindComponent (pName) is TIcQRGroup then mComp.Parent := (F_QR.FindComponent (pName) as TIcQRGroup);
  mCnt := 1;
  While F_QR.FindComponent ('DBImage'+StrInt (mCnt,0))<>nil do
    Inc (mCnt);
  mComp.Name := 'DBImage'+StrInt (mCnt,0);
  mComp.OnMouseMove := IcQRDBImageMouseMove;
  mComp.OnMouseDown := IcQRDBImageMouseDown;
  mComp.OnMouseUp := IcCompMouseUp;
  mComp.OnClick := IcCompClick;
  SelectComp (mComp.Name);
end;

procedure TF_QRMain.AddChart (pName:string);
var
  mComp:TIcQRChart;
  mAreaSeries:TAreaSeries;
  mChart:TQRDBChart;
  mCnt:longint;
begin
  mComp := TIcQRChart.Create (F_QR);
  mComp.Left := oXC;
  mComp.Top := oYC;
  If F_QR.FindComponent (pName) is TIcQRSubDetail then mComp.Parent := (F_QR.FindComponent (pName) as TIcQRSubDetail);
  If F_QR.FindComponent (pName) is TIcQRBand then mComp.Parent := (F_QR.FindComponent (pName) as TIcQRBand);
  If F_QR.FindComponent (pName) is TIcQRChildBand then mComp.Parent := (F_QR.FindComponent (pName) as TIcQRChildBand);
  If F_QR.FindComponent (pName) is TIcQRGroup then mComp.Parent := (F_QR.FindComponent (pName) as TIcQRGroup);
  mCnt := 1;
  While F_QR.FindComponent ('Chart'+StrInt (mCnt,0))<>nil do
    Inc (mCnt);
  mComp.Name := 'Chart'+StrInt (mCnt,0);
  mComp.OnMouseMove := IcQRChartMouseMove;
  mComp.OnMouseDown := IcQRChartMouseDown;
  mComp.OnMouseUp := IcCompMouseUp;
  mComp.OnClick := IcCompClick;

  mChart := TQRDBChart.Create(F_QR);
  mChart.Parent := mComp;
  mComp.Chart.Title.Visible := FALSE;

  mAreaSeries := TAreaSeries.Create(mChart);
  mAreaSeries.ParentChart := mChart;
  mAreaSeries.Stairs := TRUE;
  mAreaSeries.ShowInLegend := FALSE;
  mAreaSeries.SeriesColor := clGreen;
  mComp.Chart.AddSeries(mAreaSeries);
  SelectComp (mComp.Name);
end;

procedure TF_QRMain.AddBarCode (pName:string);
var
  mComp:TIcQRBarCode;
  mCnt:longint;
begin
  mComp := TIcQRBarCode.Create (F_QR);
  mComp.Left := oXC;
  mComp.Top := oYC;
  If F_QR.FindComponent (pName) is TIcQRSubDetail then mComp.Parent := (F_QR.FindComponent (pName) as TIcQRSubDetail);
  If F_QR.FindComponent (pName) is TIcQRBand then mComp.Parent := (F_QR.FindComponent (pName) as TIcQRBand);
  If F_QR.FindComponent (pName) is TIcQRChildBand then mComp.Parent := (F_QR.FindComponent (pName) as TIcQRChildBand);
  If F_QR.FindComponent (pName) is TIcQRGroup then mComp.Parent := (F_QR.FindComponent (pName) as TIcQRGroup);
  mCnt := 1;
  While F_QR.FindComponent ('BarCode'+StrInt (mCnt,0))<>nil do
    Inc (mCnt);
  mComp.Name := 'BarCode'+StrInt (mCnt,0);
  mComp.OnMouseMove := IcQRBarCodeMouseMove;
  mComp.OnMouseDown := IcQRBarCodeMouseDown;
  mComp.OnMouseUp := IcCompMouseUp;
  mComp.OnClick := IcCompClick;
  SelectComp (mComp.Name);
end;

procedure TF_QRMain.SelectComp (pName:string);
begin
  ClearSelectComp;
  oCompList.Add (pName);
  SetSelected (pName, TRUE);
  CompRepaint (pName);
  CB_CompName.Text := pName;
  SetActCompParam (TRUE);
  SetActCompImage;
end;

procedure TF_QRMain.ClearSelectComp;
var
  I:longint;
  mN: string;
begin
  cqMultiSelect := FALSE;
  For I:=1 to oCompList.Count do begin
    mN := oCompList.Strings[I-1];
    If F_QR.FindComponent (mN)<>nil then begin
      If F_QR.FindComponent (mN) is TIcQuickRep then (F_QR.FindComponent (mN) as TIcQuickRep).Selected := FALSE;
      If F_QR.FindComponent (mN) is TIcQRSubDetail then (F_QR.FindComponent (mN) as TIcQRSubDetail).Selected := FALSE;
      If F_QR.FindComponent (mN) is TIcQRBand then (F_QR.FindComponent (mN) as TIcQRBand).Selected := FALSE;
      If F_QR.FindComponent (mN) is TIcQRChildBand then (F_QR.FindComponent (mN) as TIcQRChildBand).Selected := FALSE;
      If F_QR.FindComponent (mN) is TIcQRGroup then (F_QR.FindComponent (mN) as TIcQRGroup).Selected := FALSE;
      If F_QR.FindComponent (mN) is TIcQRLabel then (F_QR.FindComponent (mN) as TIcQRLabel).Selected := FALSE;
      If F_QR.FindComponent (mN) is TIcQRDBText then (F_QR.FindComponent (mN) as TIcQRDBText).Selected := FALSE;
      If F_QR.FindComponent (mN) is TIcQRExpr then (F_QR.FindComponent (mN) as TIcQRExpr).Selected := FALSE;
      If F_QR.FindComponent (mN) is TIcQRSysData then (F_QR.FindComponent (mN) as TIcQRSysData).Selected := FALSE;
      If F_QR.FindComponent (mN) is TIcQRMemo then (F_QR.FindComponent (mN) as TIcQRMemo).Selected := FALSE;
      If F_QR.FindComponent (mN) is TIcQRShape then (F_QR.FindComponent (mN) as TIcQRShape).Selected := FALSE;
      If F_QR.FindComponent (mN) is TIcQRImage then (F_QR.FindComponent (mN) as TIcQRImage).Selected := FALSE;
      If F_QR.FindComponent (mN) is TIcQRDBImage then (F_QR.FindComponent (mN) as TIcQRDBImage).Selected := FALSE;
      If F_QR.FindComponent (mN) is TIcQRChart then (F_QR.FindComponent (mN) as TIcQRChart).Selected := FALSE;
      If F_QR.FindComponent (mN) is TIcQRBarCode then (F_QR.FindComponent (mN) as TIcQRBarCode).Selected := FALSE;
    end;
    CompRepaint (mN);
  end;
  oCompList.Clear;
end;

procedure TF_QRMain.DeleteComponents;
var
  mCnt:longint;
  mPos:longint;
begin
  If F_QR.ComponentCount>0 then begin
    mPos := 0;
    oCompList.Clear;
    mCnt := F_QR.ComponentCount-1;
    While (F_QR.ComponentCount>0) and (mCnt>0) do begin
      If IsSelected (F_QR.Components[mCnt].Name) then begin
        mPos := FindInXYList (F_QR.Components[mCnt].Name);
        F_QR.Components[mCnt].Free;
      end;
      Dec (mCnt);
    end;
    FillCompNames;
    FillXYList;
    If mPos>=oXYList.Count then mPos := oXYList.Count-1;
    SelectComp (Copy (oXYList.Strings[mPos],13,Length (oXYList.Strings[mPos])));
  end;
end;

function  TF_QRMain.GetCharSetPos (pNum:longint):longint;
var
  I:longint;
  mFind:boolean;
begin
  Result := -1;
  I := 0;
  While (I<18) and not mFind do begin
    mFind := (cChDosToChWin[I]=pNum);
    If not mFind then Inc (I);
  end;
  If mFind then Result := I;
end;

function  TF_QRMain.GetResizeComp (Sender: TObject):boolean;
begin
  try
    Result := not (Sender is TQuickRep);
  except Result := FALSE end;
end;

procedure TF_QRMain.FillCompNames;
var
  I,J:longint;
  mName:string;
  mSel:boolean;
  mType:string;
begin
  CB_QRBandLinkBand.Clear;
  CB_QRBandLinkBand.Items.Add ('');
  CB_QRChildBandLinkBand.Clear;
  CB_QRChildBandLinkBand.Items.Add ('');
  CB_QRChildBandParentBand.Clear;
  CB_QRChildBandParentBand.Items.Add ('');
  CB_QRSubDetailLinkBand.Clear;
  CB_QRSubDetailLinkBand.Items.Add ('');
  CB_QRGroupLinkBand.Clear;
  CB_QRGroupLinkBand.Items.Add ('');
  CB_QRGroupFooterBand.Clear;
  CB_QRGroupFooterBand.Items.Add ('');
  CB_QRSubDetailHeaderBand.Clear;
  CB_QRSubDetailHeaderBand.Items.Add ('');
  CB_QRSubDetailFooterBand.Clear;
  CB_QRSubDetailFooterBand.Items.Add ('');
  CB_CompName.Sorted := FALSE;
  CB_CompName.Clear;
  For I:=0 to F_QR.ComponentCount-1 do begin
    mName := F_QR.Components[I].Name;
    mType := '';
    mSel := IsSelected (F_QR.Components[I].Name);
    If F_QR.Components[I] is TIcQuickRep then mType := '00';
    If F_QR.Components[I] is TIcQRBand then mType := '01';
    If F_QR.Components[I] is TIcQRSubDetail then mType := '02';
    If F_QR.Components[I] is TIcQRChildBand then mType := '03';
    If F_QR.Components[I] is TIcQRGroup then mType := '04';
    If F_QR.Components[I] is TIcQRLabel then mType := '05';
    If F_QR.Components[I] is TIcQRDBText then mType := '06';
    If F_QR.Components[I] is TIcQRExpr then mType := '07';
    If F_QR.Components[I] is TIcQRSysData then mType := '08';
    If F_QR.Components[I] is TIcQRMemo then mType := '09';
    If F_QR.Components[I] is TIcQRShape then mType := '10';;
    If F_QR.Components[I] is TIcQRImage then mType := '11';
    If F_QR.Components[I] is TIcQRDBImage then mType := '12';
    If F_QR.Components[I] is TIcQRChart then mType := '13';
    If F_QR.Components[I] is TIcQRBarCode then mType := '14';
    If mType<>'' then begin
      If RB_CNName.Checked
        then CB_CompName.Items.Add (mName)
        else CB_CompName.Items.Add (mType+mName);
    end;
    If mSel and not cqMultiSelect then CB_CompName.Text := mName;
    If (F_QR.Components[I] is TIcQRBand) or (F_QR.Components[I] is TIcQRChildBand) or (F_QR.Components[I] is TIcQRSubDetail) or (F_QR.Components[I] is TIcQRGroup) then begin
      If (F_QR.Components[I] is TIcQRBand) then CB_QRGroupFooterBand.Items.Add (mName);
      CB_QRBandLinkBand.Items.Add (mName);
      CB_QRChildBandLinkBand.Items.Add (mName);
      CB_QRChildBandParentBand.Items.Add (mName);
      CB_QRSubDetailLinkBand.Items.Add (mName);
      CB_QRGroupLinkBand.Items.Add (mName);
      CB_QRSubDetailHeaderBand.Items.Add (mName);
      CB_QRSubDetailFooterBand.Items.Add (mName);
    end;
  end;
  If CB_CompName.Items.Count>0 then begin
    CB_CompName.Sorted := TRUE;
    If RB_CNType.Checked then begin
      CB_CompName.Sorted := FALSE;
      For J:=0 to CB_CompName.Items.Count-1 do
        CB_CompName.Items[J] := Copy (CB_CompName.Items[J],3,Length (CB_CompName.Items[J]));
    end;
  end;
end;

procedure TF_QRMain.FillXYList;
var
  I:longint;
  mName:string;
  mSelName:boolean;
  mType:string;
  mParY:string;
begin
  oXYList.Sorted := FALSE;
  oXYList.Clear;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If (F_QR.Components[I] is TIcQuickRep) then begin
      oXYList.Add ('000000000000'+F_QR.Components[I].Name)
    end else begin
      If (F_QR.Components[I] is TIcQRBand) or (F_QR.Components[I] is TIcQRChildBand) or (F_QR.Components[I] is TIcQRSubDetail) or (F_QR.Components[I] is TIcQRGroup) then begin
        mParY := StrIntZero ((F_QR.Components[I] as TControl).Top,4);
        oXYList.Add (mParY+'0000'+mParY+F_QR.Components[I].Name)
      end else begin
        If F_QR.Components[I] is TControl then begin
          mParY := StrIntZero ((F_QR.Components[I] as TControl).Parent.Top,4);
          oXYList.Add (mParY+StrIntZero ((F_QR.Components[I] as TControl).Left,4)+StrIntZero ((F_QR.Components[I] as TControl).Top,4)+F_QR.Components[I].Name)
        end;
      end;
    end;
  end;
  oXYList.Sorted := TRUE;
end;

function  TF_QRMain.FindInXYList (pName:string):longint;
var
  I:longint;
  mFind:boolean;
begin
  Result := -1;
  I := 0;
  mFind := FALSE;
  While (oXYList.Count>0) and (I<oXYList.Count) and not mFind do begin
    mFind := Copy (oXYList.Strings[I],13,Length (oXYList.Strings[I]))=pName;
    If not mFind then Inc (I);
  end;
  If mFind then Result := I;
end;

procedure TF_QRMain.MoveLeftSel;
var mPos:longint;
begin
  If CB_CompName.Text<>'' then begin
    mPos := FindInXYList (CB_CompName.Text);
    If mPos>0 then Dec (mPos) else mPos := oXYList.Count-1;
    CB_CompName.Text := Copy (oXYList.Strings[mPos],13,Length (oXYList.Strings[mPos]));
    SelectComp (CB_CompName.Text);
  end;
end;

procedure TF_QRMain.MoveRightSel;
var mPos:longint;
begin
  If CB_CompName.Text<>'' then begin
    mPos := FindInXYList (CB_CompName.Text);
    If (mPos>-1) and (mPos<oXYList.Count-1) then Inc (mPos) else mPos := 0;
    CB_CompName.Text := Copy (oXYList.Strings[mPos],13,Length (oXYList.Strings[mPos]));
    SelectComp (CB_CompName.Text);
  end;
end;

procedure TF_QRMain.MoveUpComp;
begin
  ChangeCompCoord (0,-1,0,0);
end;

procedure TF_QRMain.MoveLeftComp;
begin
  ChangeCompCoord (-1,0,0,0);
end;

procedure TF_QRMain.MoveDownComp;
begin
  ChangeCompCoord (0,1,0,0);
end;

procedure TF_QRMain.MoveRightComp;
begin
  ChangeCompCoord (1,0,0,0);
end;

procedure TF_QRMain.HeightDecComp;
begin
  ChangeCompCoord (0,0,0,-1);
end;

procedure TF_QRMain.WidthDecComp;
begin
  ChangeCompCoord (0,0,-1,0);
end;

procedure TF_QRMain.HeightIncComp;
begin
  ChangeCompCoord (0,0,0,1);
end;

procedure TF_QRMain.WidthIncComp;
begin
  ChangeCompCoord (0,0,1,0);
end;

procedure TF_QRMain.ChangeCompCoord (pDX,pDY,pDW,pDH:longint);
var I:longint;
begin
  If F_QR.ComponentCount>0 then begin
    oChange := TRUE;
    For I:=0 to F_QR.ComponentCount-1 do begin
      If IsSelected (F_QR.Components[I].Name) then begin
        oChange := TRUE;
        If GetResizeComp (F_QR.Components[I]) then begin
          If pDX<>0 then (F_QR.Components[I] as TControl).Left := (F_QR.Components[I] as TControl).Left+pDX;
          If pDY<>0 then (F_QR.Components[I] as TControl).Top := (F_QR.Components[I] as TControl).Top+pDY;
          If pDW<>0 then (F_QR.Components[I] as TControl).Width := (F_QR.Components[I] as TControl).Width+pDW;
          If pDH<>0 then (F_QR.Components[I] as TControl).Height := (F_QR.Components[I] as TControl).Height+pDH;
        end;
      end;
    end;
  end;
  SetActCompParam (TRUE);
end;

procedure TF_QRMain.ClearFontsParam;
begin
  P_Fonts.Enabled := FALSE;
  CB_Fonts.Text := '';
  SB_BoldFont.Down := FALSE;
  SB_ItalicFont.Down := FALSE;
  SB_ULineFont.Down := FALSE;
  CB_FontCharset.Text := '';
  If SB_FontColor.Glyph.Canvas.Brush.Color<>clBlack then begin
    SB_FontColor.Glyph.Canvas.Brush.Color := clBlack;
    SB_FontColor.Glyph.Canvas.FillRect(Rect(1,17,23,23));
  end;
end;

procedure TF_QRMain.SetNotSelComponents;
begin
  oCompData.rLeft        := '';
  oCompData.rTop         := '';
  oCompData.rWidth       := '';
  oCompData.rHeight      := '';
  oCompData.rLeftMM      := '';
  oCompData.rTopMM       := '';
  oCompData.rWidthMM     := '';
  oCompData.rHeightMM    := '';
  oCompData.rAutoSize    := TRUE;
  oCompData.rAutoSizeE   := TRUE;
  oCompData.rAutoSizeF   := TRUE;
  oCompData.rAlignment   := taLeftJustify;
  oCompData.rAlignmentE  := TRUE;
  oCompData.rAlignmentF  := TRUE;
  oCompData.rFontE       := TRUE;
  oCompData.rFontName    := 'MS Sans Serif';
  oCompData.rFontSize    := '8';
  oCompData.rFontStyle   := [];
  oCompData.rFontStyleBF := TRUE;
  oCompData.rFontStyleIF := TRUE;
  oCompData.rFontStyleUF := TRUE;
  oCompData.rFontColor   := clBlack;
  oCompData.rFontColorF  := TRUE;
  oCompData.rFrameWidth  := '1';
  oCompData.rFrameLeft   := FALSE;
  oCompData.rFrameLeftF  := TRUE;
  oCompData.rFrameTop    := FALSE;
  oCompData.rFrameTopF   := TRUE;
  oCompData.rFrameBottom := FALSE;
  oCompData.rFrameBottomF:= TRUE;
  oCompData.rFrameRight  := FALSE;
  oCompData.rFrameRightF := TRUE;
  oCompData.rFrameColor  := clBlack;
  oCompData.rFrameColorF := TRUE;

  oCompData.rWordWrap    := TRUE;
  oCompData.rWordWrapE   := TRUE;
  oCompData.rWordWrapF   := TRUE;
  oCompData.rTransparent := TRUE;
  oCompData.rTransparentE:= TRUE;
  oCompData.rBkColor     := clBlack;
  oCompData.rBkColorE    := TRUE;
  oCompData.rBkColorF    := TRUE;

  oSpecCompData.rLabelCaption     := '';

  oSpecCompData.rDBTextDataSet    := '';
  oSpecCompData.rDBTextDataField  := '';
  oSpecCompData.rDBTextMask       := '';

  oSpecCompData.rExprExpression   := '';
  oSpecCompData.rExprMask         := '';
  oSpecCompData.rExprMaster       := '';
  oSpecCompData.rExprResetAfterPrint  := FALSE;
  oSpecCompData.rExprResetAfterPrintF := TRUE;

  oSpecCompData.rSysDataText      := '';
  oSpecCompData.rSysDataType      := 1;

  oSpecCompData.rMemoLines.Clear;

  oSpecCompData.rShapeBrushStyle  := 7;
  oSpecCompData.rShapeBrushColor  := clWhite;
  oSpecCompData.rShapeBrushColorF := TRUE;
  oSpecCompData.rShapePenWidth    := '1';
  oSpecCompData.rShapePenStyle    := 5;
  oSpecCompData.rShapePenColor    := clBlack;
  oSpecCompData.rShapePenColorF   := TRUE;
  oSpecCompData.rShapetype        := 0;

  oSpecCompData.rImageStretch     := 0;
  oSpecCompData.rImageStretchF    := TRUE;

  oSpecCompData.rDBImageDataSet   := '';
  oSpecCompData.rDBImageDataField := '';
  oSpecCompData.rDBImageStretch   := 0;
  oSpecCompData.rDBImageStretchF  := TRUE;

  oSpecCompData.rChartDataSet     := '';
  oSpecCompData.rChartXDataField  := '';
  oSpecCompData.rChartXDateTime   := FALSE;
  oSpecCompData.rChartYDataField  := '';
  oSpecCompData.rChartYDateTime   := FALSE;
  oSpecCompData.rChartStairs      := FALSE;

  oSpecCompData.rBarCodeType      := 0;
  oSpecCompData.rBarCodeDataSet   := '';
  oSpecCompData.rBarCodeDataField := '';
  oSpecCompData.rBarCodeClearZone := TRUE;
  oSpecCompData.rBarCodeText      := '';

  oSpecCompData.rBandBandType       := 2;
  oSpecCompData.rBandAlignToBottom  := FALSE;
  oSpecCompData.rBandAlignToBottomF := TRUE;
  oSpecCompData.rBandForceNewColumn := FALSE;
  oSpecCompData.rBandForceNewColumnF:= TRUE;
  oSpecCompData.rBandForceNewPage   := FALSE;
  oSpecCompData.rBandForceNewPageF  := TRUE;
  oSpecCompData.rBandLinkBand       := '';

  oSpecCompData.rChildBandParentBand     := '';
  oSpecCompData.rChildBandAlignToBottom  := FALSE;
  oSpecCompData.rChildBandAlignToBottomF := TRUE;
  oSpecCompData.rChildBandForceNewColumn := FALSE;
  oSpecCompData.rChildBandForceNewColumnF:= TRUE;
  oSpecCompData.rChildBandForceNewPage   := FALSE;
  oSpecCompData.rChildBandForceNewPageF  := TRUE;
  oSpecCompData.rChildBandLinkBand       := '';

  oSpecCompData.rSubDetailMaster         := '';
  oSpecCompData.rSubDetailDataSet        := '';
  oSpecCompData.rSubDetailHeaderBand     := '';
  oSpecCompData.rSubDetailFooterBand     := '';
  oSpecCompData.rSubDetailAlignToBottom  := FALSE;
  oSpecCompData.rSubDetailAlignToBottomF := TRUE;
  oSpecCompData.rSubDetailForceNewColumn := FALSE;
  oSpecCompData.rSubDetailForceNewColumnF:= TRUE;
  oSpecCompData.rSubDetailForceNewPage   := FALSE;
  oSpecCompData.rSubDetailForceNewPageF  := TRUE;
  oSpecCompData.rSubDetailLinkBand       := '';
  oSpecCompData.rSubDetailPrintBefore    := FALSE;
  oSpecCompData.rSubDetailPrintBeforeF   := TRUE;
  oSpecCompData.rSubDetailPrintIfEmpty   := TRUE;
  oSpecCompData.rSubDetailPrintIfEmptyF  := TRUE;

  oSpecCompData.rGroupMaster           := '';
  oSpecCompData.rGroupFooterBand       := '';
  oSpecCompData.rGroupExpression       := '';
  oSpecCompData.rGroupAlignToBottom    := FALSE;
  oSpecCompData.rGroupAlignToBottomF   := TRUE;
  oSpecCompData.rGroupForceNewColumn   := FALSE;
  oSpecCompData.rGroupForceNewColumnF  := TRUE;
  oSpecCompData.rGroupForceNewPage     := FALSE;
  oSpecCompData.rGroupForceNewPageF    := TRUE;
  oSpecCompData.rGroupLinkBand         := '';
  oSpecCompData.rGroupReprintOnNewPage := FALSE;
  oSpecCompData.rGroupReprintOnNewPageF:= TRUE;

  oSpecCompData.rQuickRepDataSet       := '';
  oSpecCompData.rQuickRepTopMargin     := '';
  oSpecCompData.rQuickRepBottomMargin  := '';
  oSpecCompData.rQuickRepLeftMargin    := '';
  oSpecCompData.rQuickRepRightMargin   := '';
  oSpecCompData.rQuickRepPaperSize     := 1;
  oSpecCompData.rQuickRepColumns       := '';
  oSpecCompData.rQuickRepColumnSpace   := '';
  oSpecCompData.rQuickRepPrintIfEmpty  := TRUE;
  oSpecCompData.rQuickRepPrintIfEmptyF := TRUE;
end;

procedure TF_QRMain.SetAlignPanel;
begin
  SB_AlignLeft.Down := (oCompData.rAlignment=taLeftJustify);
  SB_AlignCenter.Down := (oCompData.rAlignment=taCenter);
  SB_AlignRight.Down := (oCompData.rAlignment=taRightJustify);
  P_Align.Enabled := oCompData.rAlignmentE;
  SB_AlignLeft.Enabled := oCompData.rAlignmentE;
  SB_AlignCenter.Enabled := oCompData.rAlignmentE;
  SB_AlignRight.Enabled := oCompData.rAlignmentE;
  SB_AlignLeft.Flat := oCompData.rAlignmentF;
  SB_AlignCenter.Flat := oCompData.rAlignmentF;
  SB_AlignRight.Flat := oCompData.rAlignmentF;
end;

procedure TF_QRMain.SetFontPanel;
begin
  CB_Fonts.Text := oCompData.rFontName;
  CB_FontSize.Text := oCompData.rFontSize;
  SB_BoldFont.Flat := oCompData.rFontStyleBF;
  SB_BoldFont.Down := (fsBold in oCompData.rFontStyle);
  SB_ItalicFont.Flat := oCompData.rFontStyleIF;
  SB_ItalicFont.Down := (fsItalic in oCompData.rFontStyle);
  SB_ULineFont.Flat := oCompData.rFontStyleUF;
  SB_ULineFont.Down := (fsUnderline in oCompData.rFontStyle);
  If SB_FontColor.Glyph.Canvas.Brush.Color <> oCompData.rFontColor then begin
    SB_FontColor.Glyph.Canvas.Brush.Color := oCompData.rFontColor;
    SB_FontColor.Glyph.Canvas.FillRect(Rect(1,17,23,23));
  end;
  SB_FontColor.Flat := oCompData.rFontColorF;
  CB_FontCharset.ItemIndex := GetCharsetPos (oCompData.rFontCharset);

  P_Fonts.Enabled := oCompData.rFontE;
  CB_Fonts.Enabled := oCompData.rFontE;
  CB_FontSize.Enabled := oCompData.rFontE;
  SB_BoldFont.Enabled := oCompData.rFontE;
  SB_ItalicFont.Enabled := oCompData.rFontE;
  SB_ULineFont.Enabled := oCompData.rFontE;
  SB_FontColor.Enabled := oCompData.rFontE;
  CB_FontCharset.Enabled := oCompData.rFontE;
end;

procedure TF_QRMain.SetFramePanel;
begin
  E_FrameWidth.Text := oCompData.rFrameWidth;
  SB_FrameLeft.Down := oCompData.rFrameLeft;
  SB_FrameLeft.Flat := oCompData.rFrameLeftF;
  SB_FrameTop.Down := oCompData.rFrameTop;
  SB_FrameTop.Flat := oCompData.rFrameTopF;
  SB_FrameRight.Down := oCompData.rFrameRight;
  SB_FrameRight.Flat := oCompData.rFrameRightF;
  SB_FrameBottom.Down := oCompData.rFrameBottom;
  SB_FrameBottom.Flat := oCompData.rFrameBottomF;
  SB_FrameColor.Glyph.Canvas.Brush.Color := oCompData.rFrameColor;
  SB_FrameColor.Glyph.Canvas.FillRect(Rect(1,17,23,23));
  SB_FrameColor.Flat := oCompData.rFrameColorF;
end;

procedure TF_QRMain.SetBkColor;
begin
  SB_Color.Enabled := oCompData.rBkColorE;
  If SB_Color.Glyph.Canvas.Brush.Color<>oCompData.rBkColor then begin
    SB_Color.Glyph.Canvas.Brush.Color := oCompData.rBkColor;
    SB_Color.Glyph.Canvas.FillRect(Rect(1,17,23,23));
  end;
  SB_Color.Flat := oCompData.rBkColorF;
end;

procedure TF_QRMain.SetWordWrap;
var mImage:TBitmap;
begin
  SB_WordWrap.Enabled := oCompData.rWordWrapE;
  mImage := TBitmap.Create;
  If oCompData.rWordWrap then begin
    SB_WordWrap.Tag := 1;
    IL_WordWrap.GetBitmap (0,mImage)
  end else begin
    SB_WordWrap.Tag := 2;
    IL_WordWrap.GetBitmap (1,mImage);
  end;
  SB_WordWrap.Glyph.Assign (mImage);
  mImage.Free; mImage := nil;
  SB_WordWrap.Flat := oCompData.rWordWrapF;
end;

procedure TF_QRMain.SetTransparent;
var mImage:TBitmap;
begin
  SB_Transparent.Enabled := oCompData.rTransparentE;
  mImage := TBitmap.Create;
  If oCompData.rTransparent then begin
    SB_Transparent.Tag := 1;
    IL_Transparent.GetBitmap (0,mImage)
  end else begin
    SB_Transparent.Tag := 2;
    IL_Transparent.GetBitmap (1,mImage);
  end;
  SB_Transparent.Glyph.Assign (mImage);
  mImage.Free; mImage := nil;
  SB_Transparent.Flat := oCompData.rTransparentF;
end;

procedure TF_QRMain.HideAllSpecPanels;
begin
  If oCompType<>1  then P_QuickRep.Visible := FALSE;
  If oCompType<>2  then P_QRBand.Visible := FALSE;
  If oCompType<>3  then P_QRChildBand.Visible := FALSE;
  If oCompType<>4  then P_QRSubDetail.Visible := FALSE;
  If oCompType<>5  then P_QRGroup.Visible := FALSE;
  If oCompType<>6  then P_QRLabel.Visible := FALSE;
  If oCompType<>7  then P_QRDBText.Visible := FALSE;
  If oCompType<>8  then P_QRExpr.Visible := FALSE;
  If oCompType<>9  then P_QRSysData.Visible := FALSE;
  If oCompType<>10 then P_QRMemo.Visible := FALSE;
  If oCompType<>11 then P_QRShape.Visible := FALSE;
  If oCompType<>12 then P_QRImage.Visible := FALSE;
  If oCompType<>13 then P_QRDBImage.Visible := FALSE;
  If oCompType<>14 then P_QRChart.Visible := FALSE;
  If oCompType<>15 then P_QRBarCode.Visible := FALSE;
end;

procedure TF_QRMain.ShowSpecParams;
begin
  HideAllSpecPanels;
  case oCompType of
     1: ShowQuickRepParams;
     2: ShowQRBandParams;
     3: ShowQRChildBandParams;
     4: ShowQRSubDetailParams;
     5: ShowQRGroupParams;
     6: ShowQRLabelParams;
     7: ShowQRDBTextParams;
     8: ShowQRExprParams;
     9: ShowQRSysDataParams;
    10: ShowQRMemoParams;
    11: ShowQRShapeParams;
    12: ShowQRImageParams;
    13: ShowQRDBImageParams;
    14: ShowQRChartParams;
    15: ShowQRBarCodeParams;
  end;
end;

procedure TF_QRMain.ShowQRLabelParams;
begin
  P_QRLabel.Visible := TRUE;
  E_QRLabelCaption.Text := oSpecCompData.rLabelCaption;
end;

procedure TF_QRMain.ShowQRDBTextParams;
var mS:string;
begin
  P_QRDBText.Visible := TRUE;
  CB_QRDBTextMask.Text := oSpecCompData.rDBTextMask;
  If (CB_QRDBTextDataSet.Text<>oSpecCompData.rDBTextDataSet) or (CB_QRDBTextDataField.Text<>oSpecCompData.rDBTextDataField) then begin
    CB_QRDBTextDataModule.ItemIndex := -1;
    CB_QRDBTextDataSet.ItemIndex := -1;
    CB_QRDBTextDataField.ItemIndex := -1;
    If oSpecCompData.rDBTextDataSet<>'' then begin
      mS := Copy (oSpecCompData.rDBTextDataSet,1,Pos ('.',oSpecCompData.rDBTextDataSet)-1);
      CB_QRDBTextDataModule.ItemIndex := GetIndexPos (CB_QRDBTextDataModule.Items, mS);
      FillDBTextDataSet;
      CB_QRDBTextDataSet.ItemIndex := GetIndexPos (CB_QRDBTextDataSet.Items, oSpecCompData.rDBTextDataSet);
      If CB_QRDBTextDataSet.ItemIndex>=0 then begin
        CB_QRDBTextDataField.Items.Assign (FillFieldNames (CB_QRDBTextDataSet.Text));
        CB_QRDBTextDataFullName.Items.Assign (FillFieldFullNames (CB_QRDBTextDataSet.Text));
        CB_QRDBTextDataField.ItemIndex := GetIndexPos (CB_QRDBTextDataField.Items, oSpecCompData.rDBTextDataField);
        CB_QRDBTextDataFullName.ItemIndex := CB_QRDBTextDataField.ItemIndex;
      end;
    end else FillDBTextDataSet;
  end;
end;

procedure TF_QRMain.ShowQRExprParams;
begin
  P_QRExpr.Visible := TRUE;
  CB_QRExprMask.Text := oSpecCompData.rExprMask;
  CB_QRExprMaster.ItemIndex := -1;
  CB_QRExprMaster.ItemIndex := GetIndexPos (CB_QRExprMaster.Items, oSpecCompData.rExprMaster);
  E_QRExprExpression.Text := oSpecCompData.rExprExpression;
  SB_QRExprResetAfterPrint.Down := oSpecCompData.rExprResetAfterPrint;
  SB_QRExprResetAfterPrint.Flat := oSpecCompData.rExprResetAfterPrintF;
end;

procedure TF_QRMain.ShowQRSysDataParams;
var mImage:TBitmap;
begin
  P_QRSysData.Visible := TRUE;
  E_QRSysDataText.Text := oSpecCompData.rSysDataText;
  CB_QRSysDataType.ItemIndex := oSpecCompData.rSysDataType;
  If oSpecCompData.rSysDataType<>-1 then begin
    mImage := TBitmap.Create;
    IL_QRSysDataType.GetBitmap (oSpecCompData.rSysDataType,mImage);
    I_QRSysDataType.Picture.Assign (mImage);
    mImage.Free; mImage := nil;
  end else I_QRSysDataType.Picture := nil;
end;

procedure TF_QRMain.ShowQRMemoParams;
begin
  P_QRMemo.Visible := TRUE;
  M_QRMemo.Lines.Assign (oSpecCompData.rMemoLines);
end;

procedure TF_QRMain.ShowQRShapeParams;
var mImage:TBitmap;
begin
  P_QRShape.Visible := TRUE;
  mImage := TBitmap.Create;

  If oSpecCompData.rShapeBrushStyle<>-1 then begin
    IL_QRShapeBrushStyle.GetBitmap (oSpecCompData.rShapeBrushStyle,mImage);
    I_QRShapeBrushStyle.Picture.Assign (mImage);
  end else I_QRShapeBrushStyle.Picture := nil;
  I_QRShapeBrushStyle.Tag := oSpecCompData.rShapeBrushStyle;

  SB_QRShapeBrushColor.Flat := oSpecCompData.rShapeBrushColorF;
  SB_QRShapeBrushColor.Glyph.Canvas.Brush.Color := oSpecCompData.rShapeBrushColor;
  SB_QRShapeBrushColor.Glyph.Canvas.FillRect(Rect(1,17,23,23));

  E_QRShapePenWidth.Text := oSpecCompData.rShapePenWidth;

  If oSpecCompData.rShapePenStyle<>-1 then begin
    IL_QRShapePenStyle.GetBitmap (oSpecCompData.rShapePenStyle,mImage);
    I_QRShapePenStyle.Picture.Assign (mImage);
  end else I_QRShapePenStyle.Picture := nil;
  I_QRShapePenStyle.Tag := oSpecCompData.rShapePenStyle;

  SB_QRShapePenColor.Flat := oSpecCompData.rShapePenColorF;
  SB_QRShapePenColor.Glyph.Canvas.Brush.Color := oSpecCompData.rShapePenColor;
  SB_QRShapePenColor.Glyph.Canvas.FillRect(Rect(1,17,23,23));

  If oSpecCompData.rShapeType<>-1 then begin
    IL_QRShape.GetBitmap (oSpecCompData.rShapeType,mImage);
    I_QRShape.Picture.Assign (mImage);
  end else I_QRShape.Picture := nil;
  I_QRShape.Tag := oSpecCompData.rShapeType;

  mImage.Free; mImage := nil;
end;

procedure TF_QRMain.ShowQRImageParams;
var mImage:TBitmap;
begin
  P_QRImage.Visible := TRUE;
  SB_QRImageStretch.Tag := oSpecCompData.rImageStretch;
  SB_QRImageStretch.Flat := oSpecCompData.rImageStretchF;
  If oSpecCompData.rImageStretch<>-1 then begin
    mImage := TBitmap.Create;
    IL_QRImage.GetBitmap (oSpecCompData.rImageStretch,mImage);
    SB_QRImageStretch.Glyph.Assign (mImage);
    mImage.Free; mImage := nil;
  end else SB_QRImageStretch.Glyph := nil;
end;

procedure TF_QRMain.ShowQRDBImageParams;
var
  mImage:TBitmap;
  mS:string;
begin
  P_QRDBImage.Visible := TRUE;

  If (CB_QRDBImageDataSet.Text<>oSpecCompData.rDBImageDataSet) or (CB_QRDBImageDataField.Text<>oSpecCompData.rDBImageDataField) then begin
    CB_QRDBImageDataModule.ItemIndex := -1;
    CB_QRDBImageDataSet.ItemIndex := -1;
    CB_QRDBImageDataField.ItemIndex := -1;
    If oSpecCompData.rDBImageDataSet<>'' then begin
      mS := Copy (oSpecCompData.rDBImageDataSet,1,Pos ('.',oSpecCompData.rDBImageDataSet)-1);
      CB_QRDBImageDataModule.ItemIndex := GetIndexPos (CB_QRDBImageDataModule.Items, mS);
      FillDBImageDataSet;
      CB_QRDBImageDataSet.ItemIndex := GetIndexPos (CB_QRDBImageDataSet.Items, oSpecCompData.rDBImageDataSet);
      If CB_QRDBImageDataSet.ItemIndex>=0 then begin
        CB_QRDBImageDataField.Items.Assign (FillFieldNames (CB_QRDBImageDataSet.Text));
        CB_QRDBImageDataField.ItemIndex := GetIndexPos (CB_QRDBImageDataField.Items, oSpecCompData.rDBImageDataField);
      end;
    end else FillDBImageDataSet;
  end;
  SB_QRDBImageStretch.Tag := oSpecCompData.rDBImageStretch;
  SB_QRDBImageStretch.Flat := oSpecCompData.rDBImageStretchF;
  If oSpecCompData.rDBImageStretch<>-1 then begin
    mImage := TBitmap.Create;
    IL_QRImage.GetBitmap (oSpecCompData.rDBImageStretch,mImage);
    SB_QRDBImageStretch.Glyph.Assign (mImage);
    mImage.Free; mImage := nil;
  end else SB_QRDBImageStretch.Glyph := nil;
end;

procedure TF_QRMain.ShowQRChartParams;
var
  mS:string;
  mImage:TBitmap;
begin
  P_QRChart.Visible := TRUE;
  If oSpecCompData.rChartStairs
    then SB_QRChartStairs.Tag := 1
    else SB_QRChartStairs.Tag := 0;
  mImage := TBitmap.Create;
  IL_ChartStairs.GetBitmap (SB_QRChartStairs.Tag,mImage);
  SB_QRChartStairs.Glyph.Assign (mImage);
  mImage.Free; mImage := nil;
  SB_QRChartStairs.Flat := oSpecCompData.rChartStairs;
  ChB_ChartXDateTime.Checked := oSpecCompData.rChartXDateTime;
  ChB_ChartYDateTime.Checked := oSpecCompData.rChartYDateTime;

  If oSpecCompData.rChartDataSet<>'' then begin
    mS := Copy (oSpecCompData.rChartDataSet,1,Pos ('.',oSpecCompData.rChartDataSet)-1);
    CB_QRChartDataModule.ItemIndex := GetIndexPos (CB_QRChartDataModule.Items, mS);
    FillChartDataSet;
    CB_QRChartDataSet.ItemIndex := GetIndexPos (CB_QRChartDataSet.Items, oSpecCompData.rChartDataSet);
    If CB_QRChartDataSet.ItemIndex>=0 then begin
      CB_QRChartXDataField.Items.Assign (FillFieldNames (CB_QRChartDataSet.Text));
      CB_QRChartXDataField.ItemIndex := GetIndexPos (CB_QRChartXDataField.Items, oSpecCompData.rChartXDataField);
      CB_QRChartYDataField.Items.Assign (FillFieldNames (CB_QRChartDataSet.Text));
      CB_QRChartYDataField.ItemIndex := GetIndexPos (CB_QRChartYDataField.Items, oSpecCompData.rChartYDataField);
    end;
  end else FillChartDataSet;
end;

procedure TF_QRMain.ShowQRBarCodeParams;
var
  mS:string;
  mImage:TBitmap;
begin
  P_QRBarCode.Visible := TRUE;
  E_QRBarCodeText.Text := oSpecCompData.rBarCodeText;
  CB_QRBarCodeType.ItemIndex := oSpecCompData.rBarCodeType;
  If oSpecCompData.rBarCodeClearZone
    then SB_QRBarCodeClearZone.Tag := 0
    else SB_QRBarCodeClearZone.Tag := 1;
  mImage := TBitmap.Create;
  IL_ClearZone.GetBitmap (SB_QRBarCodeClearZone.Tag,mImage);
  SB_QRBarCodeClearZone.Glyph.Assign (mImage);
  mImage.Free; mImage := nil;
  SB_QRBarCodeClearZone.Flat := oSpecCompData.rBarCodeClearZone;
  If (CB_QRBarCodeDataSet.Text<>oSpecCompData.rBarCodeDataSet) or (CB_QRBarCodeDataField.Text<>oSpecCompData.rBarCodeDataField) then begin
    CB_QRBarCodeDataModule.ItemIndex := -1;
    CB_QRBarCodeDataSet.ItemIndex := -1;
    CB_QRBarCodeDataField.ItemIndex := -1;
    If oSpecCompData.rBarCodeDataSet<>'' then begin
      mS := Copy (oSpecCompData.rBarCodeDataSet,1,Pos ('.',oSpecCompData.rBarCodeDataSet)-1);
      CB_QRBarCodeDataModule.ItemIndex := GetIndexPos (CB_QRBarCodeDataModule.Items, mS);
      FillBarCodeDataSet;
      CB_QRBarCodeDataSet.ItemIndex := GetIndexPos (CB_QRBarCodeDataSet.Items, oSpecCompData.rBarCodeDataSet);
      If CB_QRBarCodeDataSet.ItemIndex>=0 then begin
        CB_QRBarCodeDataField.Items.Assign (FillFieldNames (CB_QRBarCodeDataSet.Text));
        CB_QRBarCodeDataField.ItemIndex := GetIndexPos (CB_QRBarCodeDataField.Items, oSpecCompData.rBarCodeDataField);
      end;
    end else FillBarCodeDataSet;
  end;
end;

procedure TF_QRMain.ShowQuickRepParams;
var
  mImage:TBitmap;
  mS:string;
begin
  P_QuickRep.Visible := TRUE;
  CB_QuickRepDataModule.ItemIndex := -1;
  CB_QuickRepDataSet.ItemIndex := -1;
  If oSpecCompData.rQuickRepDataSet<>'' then begin
    mS := Copy (oSpecCompData.rQuickRepDataSet,1,Pos ('.',oSpecCompData.rQuickRepDataSet)-1);
    If mS<>CB_QuickRepDataModule.Text then begin
      CB_QuickRepDataModule.ItemIndex := GetIndexPos (CB_QuickRepDataModule.Items, mS);
      FillQuickRepDataSet;
    end;
    CB_QuickRepDataSet.ItemIndex := GetIndexPos (CB_QuickRepDataSet.Items, oSpecCompData.rQuickRepDataSet);
  end else FillQuickRepDataSet;

  E_QuickRepTopMargin.Text := oSpecCompData.rQuickRepTopMargin;
  E_QuickRepBottomMargin.Text := oSpecCompData.rQuickRepBottomMargin;
  E_QuickRepLeftMargin.Text := oSpecCompData.rQuickRepLeftMargin;
  E_QuickRepRightMargin.Text := oSpecCompData.rQuickRepRightMargin;
  CB_PaperSize.ItemIndex := oSpecCompData.rQuickRepPaperSize;

  E_QuickRepColumns.Text := oSpecCompData.rQuickRepColumns;
  E_QuickRepColumnSpace.Text := oSpecCompData.rQuickRepColumnSpace;

  mImage := TBitmap.Create;
  If oSpecCompData.rQuickRepPrintIfEmptyF
    then SB_QuickRepPrintIfEmpty.Tag := 1
    else SB_QuickRepPrintIfEmpty.Tag := 0;
  IL_PrintIfEmpty.GetBitmap (SB_QuickRepPrintIfEmpty.Tag,mImage);
  SB_QuickRepPrintIfEmpty.Glyph.Assign (mImage);
  SB_QuickRepPrintIfEmpty.Flat := oSpecCompData.rQuickRepPrintIfEmptyF;
  If oQuickRep.Page.Orientation=poPortrait
    then IL_Orientation.GetBitmap (0,mImage)
    else IL_Orientation.GetBitmap (1,mImage);
  SB_Orientation.Glyph.Assign (mImage);
  mImage.Free; mImage := nil;
  CB_Zoom.Text := StrInt (oQuickRep.Zoom,0)+'%';
  CB_Level.ItemIndex := F_QR.Tag;
end;

procedure TF_QRMain.ShowQRBandParams;
var mImage:TBitmap;
begin
  P_QRBand.Visible := TRUE;
  CB_QRBandBandType.ItemIndex := oSpecCompData.rBandBandType;
  mImage := TBitmap.Create;
  If oSpecCompData.rBandBandType<>-1 then begin
    IL_BandType.GetBitmap (oSpecCompData.rBandBandType,mImage);
    I_QRBandBandType.Picture.Assign (mImage);
   end else I_QRBandBandType.Picture := nil;
  If oSpecCompData.rBandAlignToBottom
    then SB_QRBandAlignToBottom.Tag := 1
    else SB_QRBandAlignToBottom.Tag := 0;
  IL_AlignToBottom.GetBitmap (SB_QRBandAlignToBottom.Tag,mImage);
  SB_QRBandAlignToBottom.Glyph.Assign (mImage);
  SB_QRBandAlignToBottom.Flat := oSpecCompData.rBandAlignToBottomF;
  If oSpecCompData.rBandForceNewColumn
    then SB_QRBandForceNewColumn.Tag := 1
    else SB_QRBandForceNewColumn.Tag := 0;
  IL_ForceNewColumn.GetBitmap (SB_QRBandForceNewColumn.Tag,mImage);
  SB_QRBandForceNewColumn.Glyph.Assign (mImage);
  SB_QRBandForceNewColumn.Flat := oSpecCompData.rBandForceNewColumnF;
  If oSpecCompData.rBandForceNewPage
    then SB_QRBandForceNewPage.Tag := 1
    else SB_QRBandForceNewPage.Tag := 0;
  IL_ForceNewPage.GetBitmap (SB_QRBandForceNewPage.Tag,mImage);
  SB_QRBandForceNewPage.Glyph.Assign (mImage);
  SB_QRBandForceNewPage.Flat := oSpecCompData.rBandForceNewPageF;
  mImage.Free; mImage := nil;
  CB_QRBandLinkBand.ItemIndex := GetIndexPos (CB_QRBandLinkBand.Items, oSpecCompData.rBandLinkBand);
end;

procedure TF_QRMain.ShowQRChildBandParams;
var mImage:TBitmap;
begin
  P_QRChildBand.Visible := TRUE;
  mImage := TBitmap.Create;
  If oSpecCompdata.rChildBandParentBand=''
    then CB_QRChildBandParentBand.ItemIndex := -1
    else CB_QRChildBandParentBand.ItemIndex := GetIndexPos (CB_QRChildBandLinkBand.Items, oSpecCompdata.rChildBandParentBand);
  If oSpecCompData.rChildBandAlignToBottom
    then SB_QRChildBandAlignToBottom.Tag := 1
    else SB_QRChildBandAlignToBottom.Tag := 0;
  IL_AlignToBottom.GetBitmap (SB_QRChildBandAlignToBottom.Tag,mImage);
  SB_QRChildBandAlignToBottom.Glyph.Assign (mImage);
  SB_QRChildBandAlignToBottom.Flat := oSpecCompData.rChildBandAlignToBottomF;
  If oSpecCompData.rChildBandForceNewColumn
    then SB_QRChildBandForceNewColumn.Tag := 1
    else SB_QRChildBandForceNewColumn.Tag := 0;
  IL_ForceNewColumn.GetBitmap (SB_QRChildBandForceNewColumn.Tag,mImage);
  SB_QRChildBandForceNewColumn.Glyph.Assign (mImage);
  SB_QRChildBandForceNewColumn.Flat := oSpecCompData.rChildBandForceNewColumnF;
  If oSpecCompData.rChildBandForceNewPage
    then SB_QRChildBandForceNewPage.Tag := 1
    else SB_QRChildBandForceNewPage.Tag := 0;
  IL_ForceNewPage.GetBitmap (SB_QRChildBandForceNewPage.Tag,mImage);
  SB_QRChildBandForceNewPage.Glyph.Assign (mImage);
  SB_QRChildBandForceNewPage.Flat := oSpecCompData.rChildBandForceNewPageF;

  If oSpecCompdata.rChildBandLinkBand=''
    then CB_QRChildBandLinkBand.ItemIndex := -1
    else CB_QRChildBandLinkBand.ItemIndex := GetIndexPos (CB_QRChildBandLinkBand.Items, oSpecCompdata.rChildBandLinkBand);
  mImage.Free; mImage := nil;
end;

procedure TF_QRMain.ShowQRSubDetailParams;
var
  mName:string;
  mImage:TBitmap;
  mS:string;
begin
  P_QRSubDetail.Visible := TRUE;
  mImage := TBitmap.Create;
  CB_QRSubDetailMaster.ItemIndex := -1;
  If oSpecCompdata.rSubDetailMaster<>'' then CB_QRSubDetailMaster.ItemIndex := GetIndexPos (CB_QRSubDetailMaster.Items, oSpecCompdata.rSubDetailMaster);
  CB_QRSubDetailDataModule.ItemIndex := -1;
  CB_QRSubDetailDataSet.ItemIndex := -1;
  If oSpecCompdata.rSubDetailDataSet<>'' then begin
    mName := oSpecCompData.rSubDetailDataSet;
    mS := Copy (mName,1,Pos ('.',mName)-1);
    CB_QRSubDetailDataModule.ItemIndex := GetIndexPos (CB_QRSubDetailDataModule.Items, mS);
    FillSubDetailDataSet;
    CB_QRSubDetailDataSet.ItemIndex := GetIndexPos (CB_QRSubDetailDataSet.Items, mName);
  end;
  If oSpecCompdata.rSubDetailHeaderBand=''
    then CB_QRSubDetailHeaderBand.ItemIndex := -1
    else CB_QRSubDetailHeaderBand.ItemIndex := GetIndexPos (CB_QRSubDetailHeaderBand.Items, oSpecCompdata.rSubDetailHeaderBand);
  If oSpecCompdata.rSubDetailFooterBand=''
    then CB_QRSubDetailFooterBand.ItemIndex := -1
    else CB_QRSubDetailFooterBand.ItemIndex := GetIndexPos (CB_QRSubDetailFooterBand.Items, oSpecCompdata.rSubDetailFooterBand);

  If oSpecCompData.rSubDetailAlignToBottom
    then SB_QRSubDetailAlignToBottom.Tag := 1
    else SB_QRSubDetailAlignToBottom.Tag := 0;
  IL_AlignToBottom.GetBitmap (SB_QRSubDetailAlignToBottom.Tag,mImage);
  SB_QRSubDetailAlignToBottom.Glyph.Assign (mImage);
  SB_QRSubDetailAlignToBottom.Flat := oSpecCompData.rSubDetailAlignToBottomF;

  If oSpecCompData.rSubDetailForceNewColumn
    then SB_QRSubDetailForceNewColumn.Tag := 1
    else SB_QRSubDetailForceNewColumn.Tag := 0;
  IL_ForceNewColumn.GetBitmap (SB_QRSubDetailForceNewColumn.Tag,mImage);
  SB_QRSubDetailForceNewColumn.Glyph.Assign (mImage);
  SB_QRSubDetailForceNewColumn.Flat := oSpecCompData.rSubDetailForceNewColumnF;
  If oSpecCompData.rSubDetailForceNewPage
    then SB_QRSubDetailForceNewPage.Tag := 1
    else SB_QRSubDetailForceNewPage.Tag := 0;
  IL_ForceNewPage.GetBitmap (SB_QRSubDetailForceNewPage.Tag,mImage);
  SB_QRSubDetailForceNewPage.Glyph.Assign (mImage);
  SB_QRSubDetailForceNewPage.Flat := oSpecCompData.rSubDetailForceNewPageF;
  If oSpecCompdata.rSubDetailLinkBand=''
    then CB_QRSubDetailLinkBand.ItemIndex := -1
    else CB_QRSubDetailLinkBand.ItemIndex := GetIndexPos (CB_QRSubDetailLinkBand.Items, oSpecCompdata.rSubDetailLinkBand);

  If oSpecCompData.rSubDetailPrintBefore
    then SB_QRSubDetailPrintBefore.Tag := 1
    else SB_QRSubDetailPrintBefore.Tag := 0;
  IL_PrintBefore.GetBitmap (SB_QRSubDetailPrintBefore.Tag,mImage);
  SB_QRSubDetailPrintBefore.Glyph.Assign (mImage);
  SB_QRSubDetailPrintBefore.Flat := oSpecCompData.rSubDetailPrintBeforeF;

  If oSpecCompData.rSubDetailPrintIfEmpty
    then SB_QRSubDetailPrintIfEmpty.Tag := 1
    else SB_QRSubDetailPrintIfEmpty.Tag := 0;
  IL_PrintIfEmpty.GetBitmap (SB_QRSubDetailPrintIfEmpty.Tag,mImage);
  SB_QRSubDetailPrintIfEmpty.Glyph.Assign (mImage);
  SB_QRSubDetailPrintIfEmpty.Flat := oSpecCompData.rSubDetailPrintIfEmptyF;
  mImage.Free; mImage := nil;
end;

procedure TF_QRMain.ShowQRGroupParams;
var mImage:TBitmap;
begin
  P_QRGroup.Visible := TRUE;
  mImage := TBitmap.Create;
  CB_QRGroupMaster.ItemIndex := -1;
  If oSpecCompdata.rGroupMaster<>'' then CB_QRGroupMaster.ItemIndex := GetIndexPos (CB_QRGroupMaster.Items, oSpecCompdata.rGroupMaster);
  If oSpecCompdata.rGroupFooterBand=''
    then CB_QRGroupFooterBand.ItemIndex := -1
    else CB_QRGroupFooterBand.ItemIndex := GetIndexPos (CB_QRGroupFooterBand.Items, oSpecCompdata.rGroupFooterBand);
  E_QRGroupExpression.Text := oSpecCompdata.rGroupExpression;

  If oSpecCompData.rGroupAlignToBottom
    then SB_QRGroupAlignToBottom.Tag := 1
    else SB_QRGroupAlignToBottom.Tag := 0;
  IL_AlignToBottom.GetBitmap (SB_QRGroupAlignToBottom.Tag,mImage);
  SB_QRGroupAlignToBottom.Glyph.Assign (mImage);
  SB_QRGroupAlignToBottom.Flat := oSpecCompData.rGroupAlignToBottomF;

  If oSpecCompData.rGroupForceNewColumn
    then SB_QRGroupForceNewColumn.Tag := 1
    else SB_QRGroupForceNewColumn.Tag := 0;
  IL_ForceNewColumn.GetBitmap (SB_QRGroupForceNewColumn.Tag,mImage);
  SB_QRGroupForceNewColumn.Glyph.Assign (mImage);
  SB_QRGroupForceNewColumn.Flat := oSpecCompData.rGroupForceNewColumnF;

  If oSpecCompData.rGroupForceNewPage
    then SB_QRGroupForceNewPage.Tag := 1
    else SB_QRGroupForceNewPage.Tag := 0;
  IL_ForceNewPage.GetBitmap (SB_QRGroupForceNewPage.Tag,mImage);
  SB_QRGroupForceNewPage.Glyph.Assign (mImage);
  SB_QRGroupForceNewPage.Flat := oSpecCompData.rGroupForceNewPageF;

  If oSpecCompdata.rGroupLinkBand=''
    then CB_QRGroupLinkBand.ItemIndex := -1
    else CB_QRGroupLinkBand.ItemIndex := GetIndexPos (CB_QRGroupLinkBand.Items, oSpecCompdata.rGroupLinkBand);

  If oSpecCompData.rGroupReprintOnNewPage
    then SB_QRGroupReprintOnNewPage.Tag := 1
    else SB_QRGroupReprintOnNewPage.Tag := 0;
  IL_ReprintOnNewPage.GetBitmap (SB_QRGroupReprintOnNewPage.Tag,mImage);
  SB_QRGroupReprintOnNewPage.Glyph.Assign (mImage);
  SB_QRGroupReprintOnNewPage.Flat := oSpecCompData.rGroupReprintOnNewPageF;

  mImage.Free; mImage := nil;
end;

procedure TF_QRMain.SetCompLeft (Value:longint);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      (F_QR.Components[I] as TControl).Left := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompTop (Value:longint);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      (F_QR.Components[I] as TControl).Top := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompWidth (Value:longint);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      (F_QR.Components[I] as TControl).Width := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompHeight (Value:longint);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      (F_QR.Components[I] as TControl).Height := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompLeftMM (Value:double);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRLabel then (F_QR.Components[I] as TIcQRLabel).Size.Left := Value;
      If F_QR.Components[I] is TIcQRDBText then (F_QR.Components[I] as TIcQRDBText).Size.Left := Value;
      If F_QR.Components[I] is TIcQRExpr then (F_QR.Components[I] as TIcQRExpr).Size.Left := Value;
      If F_QR.Components[I] is TIcQRSysData then (F_QR.Components[I] as TIcQRSysData).Size.Left := Value;
      If F_QR.Components[I] is TIcQRMemo then (F_QR.Components[I] as TIcQRMemo).Size.Left := Value;
      If F_QR.Components[I] is TIcQRShape then (F_QR.Components[I] as TIcQRShape).Size.Left := Value;
      If F_QR.Components[I] is TIcQRImage then (F_QR.Components[I] as TIcQRImage).Size.Left := Value;
      If F_QR.Components[I] is TIcQRDBImage then (F_QR.Components[I] as TIcQRDBImage).Size.Left := Value;
      If F_QR.Components[I] is TIcQRChart then (F_QR.Components[I] as TIcQRChart).Size.Left := Value;
      If F_QR.Components[I] is TIcQRBarCode then (F_QR.Components[I] as TIcQRBarCode).Size.Left := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompTopMM (Value:double);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRLabel then (F_QR.Components[I] as TIcQRLabel).Size.Top := Value;
      If F_QR.Components[I] is TIcQRDBText then (F_QR.Components[I] as TIcQRDBText).Size.Top := Value;
      If F_QR.Components[I] is TIcQRExpr then (F_QR.Components[I] as TIcQRExpr).Size.Top := Value;
      If F_QR.Components[I] is TIcQRSysData then (F_QR.Components[I] as TIcQRSysData).Size.Top := Value;
      If F_QR.Components[I] is TIcQRMemo then (F_QR.Components[I] as TIcQRMemo).Size.Top := Value;
      If F_QR.Components[I] is TIcQRShape then (F_QR.Components[I] as TIcQRShape).Size.Top := Value;
      If F_QR.Components[I] is TIcQRImage then (F_QR.Components[I] as TIcQRImage).Size.Top := Value;
      If F_QR.Components[I] is TIcQRDBImage then (F_QR.Components[I] as TIcQRDBImage).Size.Top := Value;
      If F_QR.Components[I] is TIcQRChart then (F_QR.Components[I] as TIcQRChart).Size.Top := Value;
      If F_QR.Components[I] is TIcQRBarCode then (F_QR.Components[I] as TIcQRBarCode).Size.Top := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompWidthMM (Value:double);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRLabel then (F_QR.Components[I] as TIcQRLabel).Size.Width := Value;
      If F_QR.Components[I] is TIcQRDBText then (F_QR.Components[I] as TIcQRDBText).Size.Width := Value;
      If F_QR.Components[I] is TIcQRExpr then (F_QR.Components[I] as TIcQRExpr).Size.Width := Value;
      If F_QR.Components[I] is TIcQRSysData then (F_QR.Components[I] as TIcQRSysData).Size.Width := Value;
      If F_QR.Components[I] is TIcQRMemo then (F_QR.Components[I] as TIcQRMemo).Size.Width := Value;
      If F_QR.Components[I] is TIcQRShape then (F_QR.Components[I] as TIcQRShape).Size.Width := Value;
      If F_QR.Components[I] is TIcQRImage then (F_QR.Components[I] as TIcQRImage).Size.Width := Value;
      If F_QR.Components[I] is TIcQRDBImage then (F_QR.Components[I] as TIcQRDBImage).Size.Width := Value;
      If F_QR.Components[I] is TIcQRChart then (F_QR.Components[I] as TIcQRChart).Size.Width := Value;
      If F_QR.Components[I] is TIcQRBarCode then (F_QR.Components[I] as TIcQRBarCode).Size.Width := Value;
      If F_QR.Components[I] is TIcQuickRep then (F_QR.Components[I] as TIcQuickRep).Page.Width := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompHeightMM (Value:double);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRLabel then (F_QR.Components[I] as TIcQRLabel).Size.Height := Value;
      If F_QR.Components[I] is TIcQRDBText then (F_QR.Components[I] as TIcQRDBText).Size.Height := Value;
      If F_QR.Components[I] is TIcQRExpr then (F_QR.Components[I] as TIcQRExpr).Size.Height := Value;
      If F_QR.Components[I] is TIcQRSysData then (F_QR.Components[I] as TIcQRSysData).Size.Height := Value;
      If F_QR.Components[I] is TIcQRMemo then (F_QR.Components[I] as TIcQRMemo).Size.Height := Value;
      If F_QR.Components[I] is TIcQRShape then (F_QR.Components[I] as TIcQRShape).Size.Height := Value;
      If F_QR.Components[I] is TIcQRImage then (F_QR.Components[I] as TIcQRImage).Size.Height := Value;
      If F_QR.Components[I] is TIcQRDBImage then (F_QR.Components[I] as TIcQRDBImage).Size.Height := Value;
      If F_QR.Components[I] is TIcQRChart then (F_QR.Components[I] as TIcQRChart).Size.Height := Value;
      If F_QR.Components[I] is TIcQRBarCode then (F_QR.Components[I] as TIcQRBarCode).Size.Height := Value;
      If F_QR.Components[I] is TIcQRSubDetail then (F_QR.Components[I] as TIcQRSubDetail).Size.Height := Value;
      If F_QR.Components[I] is TIcQRBand then (F_QR.Components[I] as TIcQRBand).Size.Height := Value;
      If F_QR.Components[I] is TIcQRChildBand then (F_QR.Components[I] as TIcQRChildBand).Size.Height := Value;
      If F_QR.Components[I] is TIcQRGroup then (F_QR.Components[I] as TIcQRGroup).Size.Height := Value;
      If F_QR.Components[I] is TIcQuickRep then (F_QR.Components[I] as TIcQuickRep).Page.Length := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompColor (Value:TColor);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRLabel then (F_QR.Components[I] as TIcQRLabel).Color := Value;
      If F_QR.Components[I] is TIcQRDBText then (F_QR.Components[I] as TIcQRDBText).Color := Value;
      If F_QR.Components[I] is TIcQRExpr then (F_QR.Components[I] as TIcQRExpr).Color := Value;
      If F_QR.Components[I] is TIcQRSysData then (F_QR.Components[I] as TIcQRSysData).Color := Value;
      If F_QR.Components[I] is TIcQRChart then ((F_QR.Components[I] as TQRChart).Chart.Series[0] as TAreaSeries).SeriesColor := Value;
      If F_QR.Components[I] is TIcQRBarCode then (F_QR.Components[I] as TIcQRBarCode).BarColor := Value;
      If F_QR.Components[I] is TIcQRMemo then (F_QR.Components[I] as TIcQRMemo).Color := Value;
      If F_QR.Components[I] is TIcQRSubDetail then (F_QR.Components[I] as TIcQRSubDetail).Color := Value;
      If F_QR.Components[I] is TIcQRBand then (F_QR.Components[I] as TIcQRBand).Color := Value;
      If F_QR.Components[I] is TIcQRChildBand then (F_QR.Components[I] as TIcQRChildBand).Color := Value;
      If F_QR.Components[I] is TIcQRGroup then (F_QR.Components[I] as TIcQRGroup).Color := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompAlign (Value:TAlignment);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRLabel then (F_QR.Components[I] as TIcQRLabel).Alignment := Value;
      If F_QR.Components[I] is TIcQRDBText then (F_QR.Components[I] as TIcQRDBText).Alignment := Value;
      If F_QR.Components[I] is TIcQRExpr then (F_QR.Components[I] as TIcQRExpr).Alignment := Value;
      If F_QR.Components[I] is TIcQRSysData then (F_QR.Components[I] as TIcQRSysData).Alignment := Value;
      If F_QR.Components[I] is TIcQRMemo then (F_QR.Components[I] as TIcQRMemo).Alignment := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompAutoSize (Value:boolean);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRLabel then (F_QR.Components[I] as TIcQRLabel).AutoSize := Value;
      If F_QR.Components[I] is TIcQRDBText then (F_QR.Components[I] as TIcQRDBText).AutoSize := Value;
      If F_QR.Components[I] is TIcQRExpr then (F_QR.Components[I] as TIcQRExpr).AutoSize := Value;
      If F_QR.Components[I] is TIcQRSysData then (F_QR.Components[I] as TIcQRSysData).AutoSize := Value;
      If F_QR.Components[I] is TIcQRMemo then (F_QR.Components[I] as TIcQRMemo).AutoSize := Value;
      If F_QR.Components[I] is TIcQRImage then (F_QR.Components[I] as TIcQRImage).AutoSize := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompWordWrap (Value:boolean);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRLabel then (F_QR.Components[I] as TIcQRLabel).WordWrap := Value;
      If F_QR.Components[I] is TIcQRDBText then (F_QR.Components[I] as TIcQRDBText).WordWrap := Value;
      If F_QR.Components[I] is TIcQRExpr then (F_QR.Components[I] as TIcQRExpr).WordWrap := Value;
      If F_QR.Components[I] is TIcQRMemo then (F_QR.Components[I] as TIcQRMemo).WordWrap := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompTransparent (Value:boolean);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRLabel then (F_QR.Components[I] as TIcQRLabel).Transparent := Value;
      If F_QR.Components[I] is TIcQRDBText then (F_QR.Components[I] as TIcQRDBText).Transparent := Value;
      If F_QR.Components[I] is TIcQRExpr then (F_QR.Components[I] as TIcQRExpr).Transparent := Value;
      If F_QR.Components[I] is TIcQRSysData then (F_QR.Components[I] as TIcQRSysData).Transparent := Value;
      If F_QR.Components[I] is TIcQRMemo then (F_QR.Components[I] as TIcQRMemo).Transparent := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompCaption (Value:string);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRLabel then (F_QR.Components[I] as TIcQRLabel).Caption := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompFontName (Value:string);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRLabel then (F_QR.Components[I] as TIcQRLabel).Font.Name := Value;
      If F_QR.Components[I] is TIcQRDBText then (F_QR.Components[I] as TIcQRDBText).Font.Name := Value;
      If F_QR.Components[I] is TIcQRExpr then (F_QR.Components[I] as TIcQRExpr).Font.Name := Value;
      If F_QR.Components[I] is TIcQRSysData then (F_QR.Components[I] as TIcQRSysData).Font.Name := Value;
      If F_QR.Components[I] is TIcQRMemo then (F_QR.Components[I] as TIcQRMemo).Font.Name := Value;
      If F_QR.Components[I] is TIcQRChart then begin
        (F_QR.Components[I] as TIcQRChart).Chart.LeftAxis.LabelsFont.Name := Value;
        (F_QR.Components[I] as TIcQRChart).Chart.BottomAxis.LabelsFont.Name := Value;
      end;
      If F_QR.Components[I] is TIcQRSubDetail then (F_QR.Components[I] as TIcQRSubDetail).Font.Name := Value;
      If F_QR.Components[I] is TIcQRBand then (F_QR.Components[I] as TIcQRBand).Font.Name := Value;
      If F_QR.Components[I] is TIcQRChildBand then (F_QR.Components[I] as TIcQRChildBand).Font.Name := Value;
      If F_QR.Components[I] is TIcQRGroup then (F_QR.Components[I] as TIcQRGroup).Font.Name := Value;
      If F_QR.Components[I] is TIcQuickRep then (F_QR.Components[I] as TIcQuickRep).Font.Name := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompFontSize (Value:longint);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If Value<>0 then begin
        If F_QR.Components[I] is TIcQRLabel then (F_QR.Components[I] as TIcQRLabel).Font.Size := Value;
        If F_QR.Components[I] is TIcQRDBText then (F_QR.Components[I] as TIcQRDBText).Font.Size := Value;
        If F_QR.Components[I] is TIcQRExpr then (F_QR.Components[I] as TIcQRExpr).Font.Size := Value;
        If F_QR.Components[I] is TIcQRSysData then (F_QR.Components[I] as TIcQRSysData).Font.Size := Value;
        If F_QR.Components[I] is TIcQRMemo then (F_QR.Components[I] as TIcQRMemo).Font.Size := Value;
        If F_QR.Components[I] is TIcQRChart then begin
          (F_QR.Components[I] as TIcQRChart).Chart.LeftAxis.LabelsFont.Size := Value;
          (F_QR.Components[I] as TIcQRChart).Chart.BottomAxis.LabelsFont.Size := Value;
        end;
        If F_QR.Components[I] is TIcQRSubDetail then (F_QR.Components[I] as TIcQRSubDetail).Font.Size := Value;
        If F_QR.Components[I] is TIcQRBand then (F_QR.Components[I] as TIcQRBand).Font.Size := Value;
        If F_QR.Components[I] is TIcQRChildBand then (F_QR.Components[I] as TIcQRChildBand).Font.Size := Value;
        If F_QR.Components[I] is TIcQRGroup then (F_QR.Components[I] as TIcQRGroup).Font.Size := Value;
        If F_QR.Components[I] is TIcQuickRep then (F_QR.Components[I] as TIcQuickRep).Font.Size := Value;
      end;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompBoldFont (Value:boolean);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If Value then begin
        If F_QR.Components[I] is TIcQRLabel then (F_QR.Components[I] as TIcQRLabel).Font.Style := (F_QR.Components[I] as TIcQRLabel).Font.Style+[fsBold];
        If F_QR.Components[I] is TIcQRDBText then (F_QR.Components[I] as TIcQRDBText).Font.Style := (F_QR.Components[I] as TIcQRDBText).Font.Style+[fsBold];
        If F_QR.Components[I] is TIcQRExpr then (F_QR.Components[I] as TIcQRExpr).Font.Style := (F_QR.Components[I] as TIcQRExpr).Font.Style+[fsBold];
        If F_QR.Components[I] is TIcQRSysData then (F_QR.Components[I] as TIcQRSysData).Font.Style := (F_QR.Components[I] as TIcQRSysData).Font.Style+[fsBold];
        If F_QR.Components[I] is TIcQRMemo then (F_QR.Components[I] as TIcQRMemo).Font.Style := (F_QR.Components[I] as TIcQRMemo).Font.Style+[fsBold];
        If F_QR.Components[I] is TIcQRChart then begin
          (F_QR.Components[I] as TIcQRChart).Chart.LeftAxis.LabelsFont.Style := (F_QR.Components[I] as TIcQRChart).Chart.LeftAxis.LabelsFont.Style+[fsBold];
          (F_QR.Components[I] as TIcQRChart).Chart.BottomAxis.LabelsFont.Style := (F_QR.Components[I] as TIcQRChart).Chart.BottomAxis.LabelsFont.Style+[fsBold];
        end;
        If F_QR.Components[I] is TIcQRSubDetail then (F_QR.Components[I] as TIcQRSubDetail).Font.Style := (F_QR.Components[I] as TIcQRSubDetail).Font.Style+[fsBold];
        If F_QR.Components[I] is TIcQRBand then (F_QR.Components[I] as TIcQRBand).Font.Style := (F_QR.Components[I] as TIcQRBand).Font.Style+[fsBold];
        If F_QR.Components[I] is TIcQRChildBand then (F_QR.Components[I] as TIcQRChildBand).Font.Style := (F_QR.Components[I] as TIcQRChildBand).Font.Style+[fsBold];
        If F_QR.Components[I] is TIcQRGroup then (F_QR.Components[I] as TIcQRGroup).Font.Style := (F_QR.Components[I] as TIcQRGroup).Font.Style+[fsBold];
        If F_QR.Components[I] is TIcQuickRep then (F_QR.Components[I] as TIcQuickRep).Font.Style := (F_QR.Components[I] as TIcQuickRep).Font.Style+[fsBold];
      end else begin
        If F_QR.Components[I] is TIcQRLabel then (F_QR.Components[I] as TIcQRLabel).Font.Style := (F_QR.Components[I] as TIcQRLabel).Font.Style-[fsBold];
        If F_QR.Components[I] is TIcQRDBText then (F_QR.Components[I] as TIcQRDBText).Font.Style := (F_QR.Components[I] as TIcQRDBText).Font.Style-[fsBold];
        If F_QR.Components[I] is TIcQRExpr then (F_QR.Components[I] as TIcQRExpr).Font.Style := (F_QR.Components[I] as TIcQRExpr).Font.Style-[fsBold];
        If F_QR.Components[I] is TIcQRSysData then (F_QR.Components[I] as TIcQRSysData).Font.Style := (F_QR.Components[I] as TIcQRSysData).Font.Style-[fsBold];
        If F_QR.Components[I] is TIcQRMemo then (F_QR.Components[I] as TIcQRMemo).Font.Style := (F_QR.Components[I] as TIcQRMemo).Font.Style-[fsBold];
        If F_QR.Components[I] is TIcQRChart then begin
          (F_QR.Components[I] as TIcQRChart).Chart.LeftAxis.LabelsFont.Style := (F_QR.Components[I] as TIcQRChart).Chart.LeftAxis.LabelsFont.Style-[fsBold];
          (F_QR.Components[I] as TIcQRChart).Chart.BottomAxis.LabelsFont.Style := (F_QR.Components[I] as TIcQRChart).Chart.BottomAxis.LabelsFont.Style-[fsBold];
        end;
        If F_QR.Components[I] is TIcQRSubDetail then (F_QR.Components[I] as TIcQRSubDetail).Font.Style := (F_QR.Components[I] as TIcQRSubDetail).Font.Style-[fsBold];
        If F_QR.Components[I] is TIcQRBand then (F_QR.Components[I] as TIcQRBand).Font.Style := (F_QR.Components[I] as TIcQRBand).Font.Style-[fsBold];
        If F_QR.Components[I] is TIcQRChildBand then (F_QR.Components[I] as TIcQRChildBand).Font.Style := (F_QR.Components[I] as TIcQRChildBand).Font.Style-[fsBold];
        If F_QR.Components[I] is TIcQRGroup then (F_QR.Components[I] as TIcQRGroup).Font.Style := (F_QR.Components[I] as TIcQRGroup).Font.Style-[fsBold];
        If F_QR.Components[I] is TIcQuickRep then (F_QR.Components[I] as TIcQuickRep).Font.Style := (F_QR.Components[I] as TIcQuickRep).Font.Style-[fsBold];
      end;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompItalicFont (Value:boolean);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If Value then begin
        If F_QR.Components[I] is TIcQRLabel then (F_QR.Components[I] as TIcQRLabel).Font.Style := (F_QR.Components[I] as TIcQRLabel).Font.Style+[fsItalic];
        If F_QR.Components[I] is TIcQRDBText then (F_QR.Components[I] as TIcQRDBText).Font.Style := (F_QR.Components[I] as TIcQRDBText).Font.Style+[fsItalic];
        If F_QR.Components[I] is TIcQRExpr then (F_QR.Components[I] as TIcQRExpr).Font.Style := (F_QR.Components[I] as TIcQRExpr).Font.Style+[fsItalic];
        If F_QR.Components[I] is TIcQRSysData then (F_QR.Components[I] as TIcQRSysData).Font.Style := (F_QR.Components[I] as TIcQRSysData).Font.Style+[fsItalic];
        If F_QR.Components[I] is TIcQRMemo then (F_QR.Components[I] as TIcQRMemo).Font.Style := (F_QR.Components[I] as TIcQRMemo).Font.Style+[fsItalic];
        If F_QR.Components[I] is TIcQRChart then begin
          (F_QR.Components[I] as TIcQRChart).Chart.LeftAxis.LabelsFont.Style := (F_QR.Components[I] as TIcQRChart).Chart.LeftAxis.LabelsFont.Style+[fsItalic];
          (F_QR.Components[I] as TIcQRChart).Chart.BottomAxis.LabelsFont.Style := (F_QR.Components[I] as TIcQRChart).Chart.BottomAxis.LabelsFont.Style+[fsItalic];
        end;
        If F_QR.Components[I] is TIcQRSubDetail then (F_QR.Components[I] as TIcQRSubDetail).Font.Style := (F_QR.Components[I] as TIcQRSubDetail).Font.Style+[fsItalic];
        If F_QR.Components[I] is TIcQRBand then (F_QR.Components[I] as TIcQRBand).Font.Style := (F_QR.Components[I] as TIcQRBand).Font.Style+[fsItalic];
        If F_QR.Components[I] is TIcQRChildBand then (F_QR.Components[I] as TIcQRChildBand).Font.Style := (F_QR.Components[I] as TIcQRChildBand).Font.Style+[fsItalic];
        If F_QR.Components[I] is TIcQRGroup then (F_QR.Components[I] as TIcQRGroup).Font.Style := (F_QR.Components[I] as TIcQRGroup).Font.Style+[fsItalic];
        If F_QR.Components[I] is TIcQuickRep then (F_QR.Components[I] as TIcQuickRep).Font.Style := (F_QR.Components[I] as TIcQuickRep).Font.Style+[fsItalic];
      end else begin
        If F_QR.Components[I] is TIcQRLabel then (F_QR.Components[I] as TIcQRLabel).Font.Style := (F_QR.Components[I] as TIcQRLabel).Font.Style-[fsItalic];
        If F_QR.Components[I] is TIcQRDBText then (F_QR.Components[I] as TIcQRDBText).Font.Style := (F_QR.Components[I] as TIcQRDBText).Font.Style-[fsItalic];
        If F_QR.Components[I] is TIcQRExpr then (F_QR.Components[I] as TIcQRExpr).Font.Style := (F_QR.Components[I] as TIcQRExpr).Font.Style-[fsItalic];
        If F_QR.Components[I] is TIcQRSysData then (F_QR.Components[I] as TIcQRSysData).Font.Style := (F_QR.Components[I] as TIcQRSysData).Font.Style-[fsItalic];
        If F_QR.Components[I] is TIcQRMemo then (F_QR.Components[I] as TIcQRMemo).Font.Style := (F_QR.Components[I] as TIcQRMemo).Font.Style-[fsItalic];
        If F_QR.Components[I] is TIcQRChart then begin
          (F_QR.Components[I] as TIcQRChart).Chart.LeftAxis.LabelsFont.Style := (F_QR.Components[I] as TIcQRChart).Chart.LeftAxis.LabelsFont.Style-[fsItalic];
          (F_QR.Components[I] as TIcQRChart).Chart.BottomAxis.LabelsFont.Style := (F_QR.Components[I] as TIcQRChart).Chart.BottomAxis.LabelsFont.Style-[fsItalic];
        end;
        If F_QR.Components[I] is TIcQRSubDetail then (F_QR.Components[I] as TIcQRSubDetail).Font.Style := (F_QR.Components[I] as TIcQRSubDetail).Font.Style-[fsItalic];
        If F_QR.Components[I] is TIcQRBand then (F_QR.Components[I] as TIcQRBand).Font.Style := (F_QR.Components[I] as TIcQRBand).Font.Style-[fsItalic];
        If F_QR.Components[I] is TIcQRChildBand then (F_QR.Components[I] as TIcQRChildBand).Font.Style := (F_QR.Components[I] as TIcQRChildBand).Font.Style-[fsItalic];
        If F_QR.Components[I] is TIcQRGroup then (F_QR.Components[I] as TIcQRGroup).Font.Style := (F_QR.Components[I] as TIcQRGroup).Font.Style-[fsItalic];
        If F_QR.Components[I] is TIcQuickRep then (F_QR.Components[I] as TIcQuickRep).Font.Style := (F_QR.Components[I] as TIcQuickRep).Font.Style-[fsItalic];
      end;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompULineFont (Value:boolean);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If Value then begin
        If F_QR.Components[I] is TIcQRLabel then (F_QR.Components[I] as TIcQRLabel).Font.Style := (F_QR.Components[I] as TIcQRLabel).Font.Style+[fsUnderline];
        If F_QR.Components[I] is TIcQRDBText then (F_QR.Components[I] as TIcQRDBText).Font.Style := (F_QR.Components[I] as TIcQRDBText).Font.Style+[fsUnderline];
        If F_QR.Components[I] is TIcQRExpr then (F_QR.Components[I] as TIcQRExpr).Font.Style := (F_QR.Components[I] as TIcQRExpr).Font.Style+[fsUnderline];
        If F_QR.Components[I] is TIcQRSysData then (F_QR.Components[I] as TIcQRSysData).Font.Style := (F_QR.Components[I] as TIcQRSysData).Font.Style+[fsUnderline];
        If F_QR.Components[I] is TIcQRMemo then (F_QR.Components[I] as TIcQRMemo).Font.Style := (F_QR.Components[I] as TIcQRMemo).Font.Style+[fsUnderline];
        If F_QR.Components[I] is TIcQRChart then begin
          (F_QR.Components[I] as TIcQRChart).Chart.LeftAxis.LabelsFont.Style := (F_QR.Components[I] as TIcQRChart).Chart.LeftAxis.LabelsFont.Style+[fsUnderline];
          (F_QR.Components[I] as TIcQRChart).Chart.BottomAxis.LabelsFont.Style := (F_QR.Components[I] as TIcQRChart).Chart.BottomAxis.LabelsFont.Style+[fsUnderline];
        end;
        If F_QR.Components[I] is TIcQRSubDetail then (F_QR.Components[I] as TIcQRSubDetail).Font.Style := (F_QR.Components[I] as TIcQRSubDetail).Font.Style+[fsUnderline];
        If F_QR.Components[I] is TIcQRBand then (F_QR.Components[I] as TIcQRBand).Font.Style := (F_QR.Components[I] as TIcQRBand).Font.Style+[fsUnderline];
        If F_QR.Components[I] is TIcQRChildBand then (F_QR.Components[I] as TIcQRChildBand).Font.Style := (F_QR.Components[I] as TIcQRChildBand).Font.Style+[fsUnderline];
        If F_QR.Components[I] is TIcQRGroup then (F_QR.Components[I] as TIcQRGroup).Font.Style := (F_QR.Components[I] as TIcQRGroup).Font.Style+[fsUnderline];
        If F_QR.Components[I] is TIcQuickRep then (F_QR.Components[I] as TIcQuickRep).Font.Style := (F_QR.Components[I] as TIcQuickRep).Font.Style+[fsUnderline];
      end else begin
        If F_QR.Components[I] is TIcQRLabel then (F_QR.Components[I] as TIcQRLabel).Font.Style := (F_QR.Components[I] as TIcQRLabel).Font.Style-[fsUnderline];
        If F_QR.Components[I] is TIcQRDBText then (F_QR.Components[I] as TIcQRDBText).Font.Style := (F_QR.Components[I] as TIcQRDBText).Font.Style-[fsUnderline];
        If F_QR.Components[I] is TIcQRExpr then (F_QR.Components[I] as TIcQRExpr).Font.Style := (F_QR.Components[I] as TIcQRExpr).Font.Style-[fsUnderline];
        If F_QR.Components[I] is TIcQRSysData then (F_QR.Components[I] as TIcQRSysData).Font.Style := (F_QR.Components[I] as TIcQRSysData).Font.Style-[fsUnderline];
        If F_QR.Components[I] is TIcQRMemo then (F_QR.Components[I] as TIcQRMemo).Font.Style := (F_QR.Components[I] as TIcQRMemo).Font.Style-[fsUnderline];
        If F_QR.Components[I] is TIcQRChart then begin
          (F_QR.Components[I] as TIcQRChart).Chart.LeftAxis.LabelsFont.Style := (F_QR.Components[I] as TIcQRChart).Chart.LeftAxis.LabelsFont.Style-[fsUnderline];
          (F_QR.Components[I] as TIcQRChart).Chart.BottomAxis.LabelsFont.Style := (F_QR.Components[I] as TIcQRChart).Chart.BottomAxis.LabelsFont.Style-[fsUnderline];
        end;
        If F_QR.Components[I] is TIcQRSubDetail then (F_QR.Components[I] as TIcQRSubDetail).Font.Style := (F_QR.Components[I] as TIcQRSubDetail).Font.Style-[fsUnderline];
        If F_QR.Components[I] is TIcQRBand then (F_QR.Components[I] as TIcQRBand).Font.Style := (F_QR.Components[I] as TIcQRBand).Font.Style-[fsUnderline];
        If F_QR.Components[I] is TIcQRChildBand then (F_QR.Components[I] as TIcQRChildBand).Font.Style := (F_QR.Components[I] as TIcQRChildBand).Font.Style-[fsUnderline];
        If F_QR.Components[I] is TIcQRGroup then (F_QR.Components[I] as TIcQRGroup).Font.Style := (F_QR.Components[I] as TIcQRGroup).Font.Style-[fsUnderline];
        If F_QR.Components[I] is TIcQuickRep then (F_QR.Components[I] as TIcQuickRep).Font.Style := (F_QR.Components[I] as TIcQuickRep).Font.Style-[fsUnderline];
      end;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompFontColor (Value:TColor);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRLabel then (F_QR.Components[I] as TIcQRLabel).Font.Color := Value;
      If F_QR.Components[I] is TIcQRDBText then (F_QR.Components[I] as TIcQRDBText).Font.Color := Value;
      If F_QR.Components[I] is TIcQRExpr then (F_QR.Components[I] as TIcQRExpr).Font.Color := Value;
      If F_QR.Components[I] is TIcQRSysData then (F_QR.Components[I] as TIcQRSysData).Font.Color := Value;
      If F_QR.Components[I] is TIcQRMemo then (F_QR.Components[I] as TIcQRMemo).Font.Color := Value;
      If F_QR.Components[I] is TIcQRChart then begin
        (F_QR.Components[I] as TIcQRChart).Chart.LeftAxis.LabelsFont.Color := Value;
        (F_QR.Components[I] as TIcQRChart).Chart.BottomAxis.LabelsFont.Color := Value;
      end;
      If F_QR.Components[I] is TIcQRSubDetail then (F_QR.Components[I] as TIcQRSubDetail).Font.Color := Value;
      If F_QR.Components[I] is TIcQRBand then (F_QR.Components[I] as TIcQRBand).Font.Color := Value;
      If F_QR.Components[I] is TIcQRChildBand then (F_QR.Components[I] as TIcQRChildBand).Font.Color := Value;
      If F_QR.Components[I] is TIcQRGroup then (F_QR.Components[I] as TIcQRGroup).Font.Color := Value;
      If F_QR.Components[I] is TIcQuickRep then (F_QR.Components[I] as TIcQuickRep).Font.Color := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompFontCharset (Value:longint);
var I:longint;
begin
  If Value in [0..18] then begin
    oChange := TRUE;
    For I:=0 to F_QR.ComponentCount-1 do begin
      If IsSelected (F_QR.Components[I].Name) then begin
        If F_QR.Components[I] is TIcQRLabel then (F_QR.Components[I] as TIcQRLabel).Font.Charset := cChDosToChWin[Value];
        If F_QR.Components[I] is TIcQRDBText then (F_QR.Components[I] as TIcQRDBText).Font.Charset := cChDosToChWin[Value];
        If F_QR.Components[I] is TIcQRExpr then (F_QR.Components[I] as TIcQRExpr).Font.Charset := cChDosToChWin[Value];
        If F_QR.Components[I] is TIcQRSysData then (F_QR.Components[I] as TIcQRSysData).Font.Charset := cChDosToChWin[Value];
        If F_QR.Components[I] is TIcQRMemo then (F_QR.Components[I] as TIcQRMemo).Font.Charset := cChDosToChWin[Value];
        If F_QR.Components[I] is TIcQRChart then begin
          (F_QR.Components[I] as TIcQRChart).Chart.LeftAxis.LabelsFont.Charset := cChDosToChWin[Value];
          (F_QR.Components[I] as TIcQRChart).Chart.BottomAxis.LabelsFont.Charset := cChDosToChWin[Value];
        end;
        If F_QR.Components[I] is TIcQRSubDetail then (F_QR.Components[I] as TIcQRSubDetail).Font.Charset := cChDosToChWin[Value];
        If F_QR.Components[I] is TIcQRBand then (F_QR.Components[I] as TIcQRBand).Font.Charset := cChDosToChWin[Value];
        If F_QR.Components[I] is TIcQRChildBand then (F_QR.Components[I] as TIcQRChildBand).Font.Charset := cChDosToChWin[Value];
        If F_QR.Components[I] is TIcQRGroup then (F_QR.Components[I] as TIcQRGroup).Font.Charset := cChDosToChWin[Value];
        If F_QR.Components[I] is TIcQuickRep then (F_QR.Components[I] as TIcQuickRep).Font.Charset := cChDosToChWin[Value];
      end;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompFrameColor (Value:TColor);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRLabel then (F_QR.Components[I] as TIcQRLabel).Frame.Color := Value;
      If F_QR.Components[I] is TIcQRDBText then (F_QR.Components[I] as TIcQRDBText).Frame.Color := Value;
      If F_QR.Components[I] is TIcQRExpr then (F_QR.Components[I] as TIcQRExpr).Frame.Color := Value;
      If F_QR.Components[I] is TIcQRSysData then (F_QR.Components[I] as TIcQRSysData).Frame.Color := Value;
      If F_QR.Components[I] is TIcQRMemo then (F_QR.Components[I] as TIcQRMemo).Frame.Color := Value;
      If F_QR.Components[I] is TIcQRShape then (F_QR.Components[I] as TIcQRShape).Frame.Color := Value;
      If F_QR.Components[I] is TIcQRImage then (F_QR.Components[I] as TIcQRImage).Frame.Color := Value;
      If F_QR.Components[I] is TIcQRDBImage then (F_QR.Components[I] as TIcQRDBImage).Frame.Color := Value;
      If F_QR.Components[I] is TIcQRChart then (F_QR.Components[I] as TIcQRChart).Frame.Color := Value;
      If F_QR.Components[I] is TIcQRBarCode then (F_QR.Components[I] as TIcQRBarCode).Frame.Color := Value;
      If F_QR.Components[I] is TIcQRSubDetail then (F_QR.Components[I] as TIcQRSubDetail).Frame.Color := Value;
      If F_QR.Components[I] is TIcQRBand then (F_QR.Components[I] as TIcQRBand).Frame.Color := Value;
      If F_QR.Components[I] is TIcQRChildBand then (F_QR.Components[I] as TIcQRChildBand).Frame.Color := Value;
      If F_QR.Components[I] is TIcQRGroup then (F_QR.Components[I] as TIcQRGroup).Frame.Color := Value;
      If F_QR.Components[I] is TIcQuickRep then (F_QR.Components[I] as TIcQuickRep).Frame.Color := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompFrameWidth (Value:longint);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRLabel then (F_QR.Components[I] as TIcQRLabel).Frame.Width := Value;
      If F_QR.Components[I] is TIcQRDBText then (F_QR.Components[I] as TIcQRDBText).Frame.Width := Value;
      If F_QR.Components[I] is TIcQRExpr then (F_QR.Components[I] as TIcQRExpr).Frame.Width := Value;
      If F_QR.Components[I] is TIcQRSysData then (F_QR.Components[I] as TIcQRSysData).Frame.Width := Value;
      If F_QR.Components[I] is TIcQRMemo then (F_QR.Components[I] as TIcQRMemo).Frame.Width := Value;
      If F_QR.Components[I] is TIcQRShape then (F_QR.Components[I] as TIcQRShape).Frame.Width := Value;
      If F_QR.Components[I] is TIcQRImage then (F_QR.Components[I] as TIcQRImage).Frame.Width := Value;
      If F_QR.Components[I] is TIcQRDBImage then (F_QR.Components[I] as TIcQRDBImage).Frame.Width := Value;
      If F_QR.Components[I] is TIcQRChart then (F_QR.Components[I] as TIcQRChart).Frame.Width := Value;
      If F_QR.Components[I] is TIcQRBarCode then (F_QR.Components[I] as TIcQRBarCode).Frame.Width := Value;
      If F_QR.Components[I] is TIcQRSubDetail then (F_QR.Components[I] as TIcQRSubDetail).Frame.Width := Value;
      If F_QR.Components[I] is TIcQRBand then (F_QR.Components[I] as TIcQRBand).Frame.Width := Value;
      If F_QR.Components[I] is TIcQRChildBand then (F_QR.Components[I] as TIcQRChildBand).Frame.Width := Value;
      If F_QR.Components[I] is TIcQRGroup then (F_QR.Components[I] as TIcQRGroup).Frame.Width := Value;
      If F_QR.Components[I] is TIcQuickRep then (F_QR.Components[I] as TIcQuickRep).Frame.Width := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompFrameLeft (Value:boolean);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRLabel then (F_QR.Components[I] as TIcQRLabel).Frame.DrawLeft := Value;
      If F_QR.Components[I] is TIcQRDBText then (F_QR.Components[I] as TIcQRDBText).Frame.DrawLeft := Value;
      If F_QR.Components[I] is TIcQRExpr then (F_QR.Components[I] as TIcQRExpr).Frame.DrawLeft := Value;
      If F_QR.Components[I] is TIcQRSysData then (F_QR.Components[I] as TIcQRSysData).Frame.DrawLeft := Value;
      If F_QR.Components[I] is TIcQRMemo then (F_QR.Components[I] as TIcQRMemo).Frame.DrawLeft := Value;
      If F_QR.Components[I] is TIcQRShape then (F_QR.Components[I] as TIcQRShape).Frame.DrawLeft := Value;
      If F_QR.Components[I] is TIcQRImage then (F_QR.Components[I] as TIcQRImage).Frame.DrawLeft := Value;
      If F_QR.Components[I] is TIcQRDBImage then (F_QR.Components[I] as TIcQRDBImage).Frame.DrawLeft := Value;
      If F_QR.Components[I] is TIcQRChart then (F_QR.Components[I] as TIcQRChart).Frame.DrawLeft := Value;
      If F_QR.Components[I] is TIcQRBarCode then (F_QR.Components[I] as TIcQRBarCode).Frame.DrawLeft := Value;
      If F_QR.Components[I] is TIcQRSubDetail then (F_QR.Components[I] as TIcQRSubDetail).Frame.DrawLeft := Value;
      If F_QR.Components[I] is TIcQRBand then (F_QR.Components[I] as TIcQRBand).Frame.DrawLeft := Value;
      If F_QR.Components[I] is TIcQRChildBand then (F_QR.Components[I] as TIcQRChildBand).Frame.DrawLeft := Value;
      If F_QR.Components[I] is TIcQRGroup then (F_QR.Components[I] as TIcQRGroup).Frame.DrawLeft := Value;
      If F_QR.Components[I] is TIcQuickRep then (F_QR.Components[I] as TIcQuickRep).Frame.DrawLeft := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompFrameTop (Value:boolean);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRLabel then (F_QR.Components[I] as TIcQRLabel).Frame.DrawTop := Value;
      If F_QR.Components[I] is TIcQRDBText then (F_QR.Components[I] as TIcQRDBText).Frame.DrawTop := Value;
      If F_QR.Components[I] is TIcQRExpr then (F_QR.Components[I] as TIcQRExpr).Frame.DrawTop := Value;
      If F_QR.Components[I] is TIcQRSysData then (F_QR.Components[I] as TIcQRSysData).Frame.DrawTop := Value;
      If F_QR.Components[I] is TIcQRMemo then (F_QR.Components[I] as TIcQRMemo).Frame.DrawTop := Value;
      If F_QR.Components[I] is TIcQRShape then (F_QR.Components[I] as TIcQRShape).Frame.DrawTop := Value;
      If F_QR.Components[I] is TIcQRImage then (F_QR.Components[I] as TIcQRImage).Frame.DrawTop := Value;
      If F_QR.Components[I] is TIcQRDBImage then (F_QR.Components[I] as TIcQRDBImage).Frame.DrawTop := Value;
      If F_QR.Components[I] is TIcQRChart then (F_QR.Components[I] as TIcQRChart).Frame.DrawTop := Value;
      If F_QR.Components[I] is TIcQRBarCode then (F_QR.Components[I] as TIcQRBarCode).Frame.DrawTop := Value;
      If F_QR.Components[I] is TIcQRSubDetail then (F_QR.Components[I] as TIcQRSubDetail).Frame.DrawTop := Value;
      If F_QR.Components[I] is TIcQRBand then (F_QR.Components[I] as TIcQRBand).Frame.DrawTop := Value;
      If F_QR.Components[I] is TIcQRChildBand then (F_QR.Components[I] as TIcQRChildBand).Frame.DrawTop := Value;
      If F_QR.Components[I] is TIcQRGroup then (F_QR.Components[I] as TIcQRGroup).Frame.DrawTop := Value;
      If F_QR.Components[I] is TIcQuickRep then (F_QR.Components[I] as TIcQuickRep).Frame.DrawTop := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompFrameRight (Value:boolean);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRLabel then (F_QR.Components[I] as TIcQRLabel).Frame.DrawRight := Value;
      If F_QR.Components[I] is TIcQRDBText then (F_QR.Components[I] as TIcQRDBText).Frame.DrawRight := Value;
      If F_QR.Components[I] is TIcQRExpr then (F_QR.Components[I] as TIcQRExpr).Frame.DrawRight := Value;
      If F_QR.Components[I] is TIcQRSysData then (F_QR.Components[I] as TIcQRSysData).Frame.DrawRight := Value;
      If F_QR.Components[I] is TIcQRMemo then (F_QR.Components[I] as TIcQRMemo).Frame.DrawRight := Value;
      If F_QR.Components[I] is TIcQRShape then (F_QR.Components[I] as TIcQRShape).Frame.DrawRight := Value;
      If F_QR.Components[I] is TIcQRImage then (F_QR.Components[I] as TIcQRImage).Frame.DrawRight := Value;
      If F_QR.Components[I] is TIcQRDBImage then (F_QR.Components[I] as TIcQRDBImage).Frame.DrawRight := Value;
      If F_QR.Components[I] is TIcQRChart then (F_QR.Components[I] as TIcQRChart).Frame.DrawRight := Value;
      If F_QR.Components[I] is TIcQRBarCode then (F_QR.Components[I] as TIcQRBarCode).Frame.DrawRight := Value;
      If F_QR.Components[I] is TIcQRSubDetail then (F_QR.Components[I] as TIcQRSubDetail).Frame.DrawRight := Value;
      If F_QR.Components[I] is TIcQRBand then (F_QR.Components[I] as TIcQRBand).Frame.DrawRight := Value;
      If F_QR.Components[I] is TIcQRChildBand then (F_QR.Components[I] as TIcQRChildBand).Frame.DrawRight := Value;
      If F_QR.Components[I] is TIcQRGroup then (F_QR.Components[I] as TIcQRGroup).Frame.DrawRight := Value;
      If F_QR.Components[I] is TIcQuickRep then (F_QR.Components[I] as TIcQuickRep).Frame.DrawRight := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompFrameBottom (Value:boolean);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRLabel then (F_QR.Components[I] as TIcQRLabel).Frame.DrawBottom := Value;
      If F_QR.Components[I] is TIcQRDBText then (F_QR.Components[I] as TIcQRDBText).Frame.DrawBottom := Value;
      If F_QR.Components[I] is TIcQRExpr then (F_QR.Components[I] as TIcQRExpr).Frame.DrawBottom := Value;
      If F_QR.Components[I] is TIcQRSysData then (F_QR.Components[I] as TIcQRSysData).Frame.DrawBottom := Value;
      If F_QR.Components[I] is TIcQRMemo then (F_QR.Components[I] as TIcQRMemo).Frame.DrawBottom := Value;
      If F_QR.Components[I] is TIcQRShape then (F_QR.Components[I] as TIcQRShape).Frame.DrawBottom := Value;
      If F_QR.Components[I] is TIcQRImage then (F_QR.Components[I] as TIcQRImage).Frame.DrawBottom := Value;
      If F_QR.Components[I] is TIcQRDBImage then (F_QR.Components[I] as TIcQRDBImage).Frame.DrawBottom := Value;
      If F_QR.Components[I] is TIcQRChart then (F_QR.Components[I] as TIcQRChart).Frame.DrawBottom := Value;
      If F_QR.Components[I] is TIcQRBarCode then (F_QR.Components[I] as TIcQRBarCode).Frame.DrawBottom := Value;
      If F_QR.Components[I] is TIcQRSubDetail then (F_QR.Components[I] as TIcQRSubDetail).Frame.DrawBottom := Value;
      If F_QR.Components[I] is TIcQRBand then (F_QR.Components[I] as TIcQRBand).Frame.DrawBottom := Value;
      If F_QR.Components[I] is TIcQRChildBand then (F_QR.Components[I] as TIcQRChildBand).Frame.DrawBottom := Value;
      If F_QR.Components[I] is TIcQRGroup then (F_QR.Components[I] as TIcQRGroup).Frame.DrawBottom := Value;
      If F_QR.Components[I] is TIcQuickRep then (F_QR.Components[I] as TIcQuickRep).Frame.DrawBottom := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompMemo (Value:TStrings);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRMemo then begin
        (F_QR.Components[I] as TIcQRMemo).Lines.Assign (Value);
        (F_QR.Components[I] as TIcQRMemo).Repaint;
      end;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompSysDataType (Value:longint);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRSysData then begin
        If Value=0 then (F_QR.Components[I] as TIcQRSysData).Data := qrsDate;
        If Value=1 then (F_QR.Components[I] as TIcQRSysData).Data := qrsTime;
        If Value=2 then (F_QR.Components[I] as TIcQRSysData).Data := qrsDateTime;
        If Value=3 then (F_QR.Components[I] as TIcQRSysData).Data := qrsReportTitle;
        If Value=4 then (F_QR.Components[I] as TIcQRSysData).Data := qrsPageNumber;
        If Value=5 then (F_QR.Components[I] as TIcQRSysData).Data := qrsDetailNo;
        If Value=6 then (F_QR.Components[I] as TIcQRSysData).Data := qrsDetailCount;
      end;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompSysDataText (Value:string);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRSysData then (F_QR.Components[I] as TIcQRSysData).Text := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompShapeBrushStyle (Value:longint);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRShape then begin
        If Value=0 then (F_QR.Components[I] as TIcQRShape).Brush.Style := bsClear;
        If Value=1 then (F_QR.Components[I] as TIcQRShape).Brush.Style := bsHorizontal;
        If Value=2 then (F_QR.Components[I] as TIcQRShape).Brush.Style := bsVertical;
        If Value=3 then (F_QR.Components[I] as TIcQRShape).Brush.Style := bsCross;
        If Value=4 then (F_QR.Components[I] as TIcQRShape).Brush.Style := bsBDiagonal;
        If Value=5 then (F_QR.Components[I] as TIcQRShape).Brush.Style := bsFDiagonal;
        If Value=6 then (F_QR.Components[I] as TIcQRShape).Brush.Style := bsDiagCross;
        If Value=7 then (F_QR.Components[I] as TIcQRShape).Brush.Style := bsSolid;
      end;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompShapeBrushColor (Value:TColor);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRShape then (F_QR.Components[I] as TIcQRShape).Brush.Color := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompShapePenWidth (Value:longint);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRShape then (F_QR.Components[I] as TIcQRShape).Pen.Width := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompShapePenColor (Value:TColor);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRShape then (F_QR.Components[I] as TIcQRShape).Pen.Color := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompShapePenStyle (Value:longint);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRShape then begin
        If Value=0 then (F_QR.Components[I] as TIcQRShape).Pen.Style := psClear;
        If Value=1 then (F_QR.Components[I] as TIcQRShape).Pen.Style := psDash;
        If Value=2 then (F_QR.Components[I] as TIcQRShape).Pen.Style := psDashDot;
        If Value=3 then (F_QR.Components[I] as TIcQRShape).Pen.Style := psDashDotDot;
        If Value=4 then (F_QR.Components[I] as TIcQRShape).Pen.Style := psDot;
        If Value=5 then (F_QR.Components[I] as TIcQRShape).Pen.Style := psSolid;
        If Value=6 then (F_QR.Components[I] as TIcQRShape).Pen.Style := psInsideFrame;
      end;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompShapeType (Value:longint);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRShape then begin
        If Value=0 then (F_QR.Components[I] as TIcQRShape).Shape := qrsRectangle;
        If Value=1 then (F_QR.Components[I] as TIcQRShape).Shape := qrsCircle;
        If Value=2 then (F_QR.Components[I] as TIcQRShape).Shape := qrsHorLine;
        If Value=3 then (F_QR.Components[I] as TIcQRShape).Shape := qrsVertLine;
        If Value=4 then (F_QR.Components[I] as TIcQRShape).Shape := qrsTopAndBottom;
        If Value=5 then (F_QR.Components[I] as TIcQRShape).Shape := qrsRightAndLeft;
      end;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompImageLoad (Value:string);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRImage then (F_QR.Components[I] as TIcQRImage).Picture.LoadFromFile (Value);
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompImageStretch (Value:longint);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRImage then begin
        case Value of
          0: begin
               (F_QR.Components[I] as TIcQRImage).Center := FALSE;
               (F_QR.Components[I] as TIcQRImage).Stretch := FALSE;
             end;
          1: begin
               (F_QR.Components[I] as TIcQRImage).Center := FALSE;
               (F_QR.Components[I] as TIcQRImage).Stretch := TRUE;
             end;
          2: begin
               (F_QR.Components[I] as TIcQRImage).Center := TRUE;
               (F_QR.Components[I] as TIcQRImage).Stretch := FALSE;
             end;
        end;
      end;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompDBTextFieldName (Value:string);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRDBText then (F_QR.Components[I] as TIcQRDBText).DataField := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompDBTextDataSet (Value:string);
var
  I:longint;
  mComp:TObject;
begin
  mComp := GetTableObj (Value);
  If mComp is TDataSet then begin
    oChange := TRUE;
    For I:=0 to F_QR.ComponentCount-1 do begin
      If IsSelected (F_QR.Components[I].Name) then begin
        If F_QR.Components[I] is TIcQRDBText then begin
          try
            (F_QR.Components[I] as TIcQRDBText).DataSet := mComp as TDataSet;
          except end;
        end;
      end;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompDBTextMask (Value:string);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRDBText then (F_QR.Components[I] as TIcQRDBText).Mask := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompExprExpression (Value:string);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRExpr then (F_QR.Components[I] as TIcQRExpr).Expression := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompExprMask (Value:string);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRExpr then (F_QR.Components[I] as TIcQRExpr).Mask := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompExprMaster (Value:string);
var
  I:longint;
  mComp:TComponent;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRExpr then begin
        mComp := nil;
        If Value<>'' then mComp := F_QR.FindComponent (Value);
        (F_QR.Components[I] as TIcQRExpr).Master := mComp;
      end;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompExprResetAfterPrint (Value:boolean);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRExpr then (F_QR.Components[I] as TIcQRExpr).ResetAfterPrint := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompDBImageDataSet (Value:string);
var
  I:longint;
  mComp:TObject;
begin
  mComp := GetTableObj (Value);
  If mComp is TDataSet then begin
    oChange := TRUE;
    For I:=0 to F_QR.ComponentCount-1 do begin
      If IsSelected (F_QR.Components[I].Name) then begin
        If F_QR.Components[I] is TIcQRDBImage then begin
          try
            (F_QR.Components[I] as TIcQRDBImage).DataSet := mComp as TDataSet;
          except end;
        end;
      end;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompDBImageFieldName (Value:string);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRDBImage then (F_QR.Components[I] as TIcQRDBImage).DataField := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompDBImageStretch (Value:longint);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRDBImage then begin
        case Value of
          0: begin
               (F_QR.Components[I] as TIcQRDBImage).Center := FALSE;
               (F_QR.Components[I] as TIcQRDBImage).Stretch := FALSE;
             end;
          1: begin
               (F_QR.Components[I] as TIcQRDBImage).Center := FALSE;
               (F_QR.Components[I] as TIcQRDBImage).Stretch := TRUE;
             end;
          2: begin
               (F_QR.Components[I] as TIcQRDBImage).Center := TRUE;
               (F_QR.Components[I] as TIcQRDBImage).Stretch := FALSE;
             end;
        end;
      end;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompQuickRepDataSet (Value:string);
var
  I:longint;
  mComp:TObject;
begin
  mComp := GetTableObj (Value);
  If mComp is TDataSet then begin
    oChange := TRUE;
    For I:=0 to F_QR.ComponentCount-1 do begin
      If IsSelected (F_QR.Components[I].Name) then begin
        If F_QR.Components[I] is TIcQuickRep then begin
          try
            (F_QR.Components[I] as TIcQuickRep).DataSet := mComp as TDataSet;
          except end;
        end;
      end;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompBandBandType (Value:longint);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRBand then begin
        If Value=0 then (F_QR.Components[I] as TIcQRBand).BandType := rbPageHeader;
        If Value=1 then (F_QR.Components[I] as TIcQRBand).BandType := rbPageFooter;
        If Value=2 then (F_QR.Components[I] as TIcQRBand).BandType := rbTitle;
        If Value=3 then (F_QR.Components[I] as TIcQRBand).BandType := rbDetail;
        If Value=4 then (F_QR.Components[I] as TIcQRBand).BandType := rbSummary;
        If Value=5 then (F_QR.Components[I] as TIcQRBand).BandType := rbGroupHeader;
        If Value=6 then (F_QR.Components[I] as TIcQRBand).BandType := rbGroupFooter;
        If Value=7 then (F_QR.Components[I] as TIcQRBand).BandType := rbColumnHeader;
      end;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompMargTop (Value:double);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      (F_QR.Components[I] as TQuickRep).Page.TopMargin := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompMargBottom (Value:double);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      (F_QR.Components[I] as TQuickRep).Page.BottomMargin := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompMargLeft (Value:double);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      (F_QR.Components[I] as TQuickRep).Page.LeftMargin := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompMargRight (Value:double);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      (F_QR.Components[I] as TQuickRep).Page.RightMargin := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompPaperSize (Value:longint);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQuickRep then begin
        If Value=0 then (F_QR.Components[I] as TIcQuickRep).Page.PaperSize := A3;
        If Value=1 then (F_QR.Components[I] as TIcQuickRep).Page.PaperSize := A4;
        If Value=2 then (F_QR.Components[I] as TIcQuickRep).Page.PaperSize := A4Small;
        If Value=3 then (F_QR.Components[I] as TIcQuickRep).Page.PaperSize := A5;
        If Value=4 then (F_QR.Components[I] as TIcQuickRep).Page.PaperSize := B4;
        If Value=5 then (F_QR.Components[I] as TIcQuickRep).Page.PaperSize := B5;
        If Value=6 then (F_QR.Components[I] as TIcQuickRep).Page.PaperSize := CSheet;
        If Value=7 then (F_QR.Components[I] as TIcQuickRep).Page.PaperSize := Custom;
        If Value=8 then (F_QR.Components[I] as TIcQuickRep).Page.PaperSize := Default;
        If Value=9 then (F_QR.Components[I] as TIcQuickRep).Page.PaperSize := DSheet;
        If Value=10 then (F_QR.Components[I] as TIcQuickRep).Page.PaperSize := Env10;
        If Value=11 then (F_QR.Components[I] as TIcQuickRep).Page.PaperSize := Env11;
        If Value=12 then (F_QR.Components[I] as TIcQuickRep).Page.PaperSize := Env12;
        If Value=13 then (F_QR.Components[I] as TIcQuickRep).Page.PaperSize := Env14;
        If Value=14 then (F_QR.Components[I] as TIcQuickRep).Page.PaperSize := Env9;
        If Value=15 then (F_QR.Components[I] as TIcQuickRep).Page.PaperSize := ESheet;
        If Value=16 then (F_QR.Components[I] as TIcQuickRep).Page.PaperSize := Executive;
        If Value=17 then (F_QR.Components[I] as TIcQuickRep).Page.PaperSize := Folio;
        If Value=18 then (F_QR.Components[I] as TIcQuickRep).Page.PaperSize := Ledger;
        If Value=19 then (F_QR.Components[I] as TIcQuickRep).Page.PaperSize := Legal;
        If Value=20 then (F_QR.Components[I] as TIcQuickRep).Page.PaperSize := Letter;
        If Value=21 then (F_QR.Components[I] as TIcQuickRep).Page.PaperSize := LetterSmall;
        If Value=22 then (F_QR.Components[I] as TIcQuickRep).Page.PaperSize := Note;
        If Value=23 then (F_QR.Components[I] as TIcQuickRep).Page.PaperSize := qr10x14;
        If Value=24 then (F_QR.Components[I] as TIcQuickRep).Page.PaperSize := qr11x17;
        If Value=25 then (F_QR.Components[I] as TIcQuickRep).Page.PaperSize := Quarto;
        If Value=26 then (F_QR.Components[I] as TIcQuickRep).Page.PaperSize := Statement;
        If Value=27 then (F_QR.Components[I] as TIcQuickRep).Page.PaperSize := Tabloid;
      end;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompQuickRepColumns (Value:longint);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQuickRep then (F_QR.Components[I] as TIcQuickRep).Page.Columns := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompQuickRepColumnSpace (Value:longint);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQuickRep then (F_QR.Components[I] as TIcQuickRep).Page.ColumnSpace := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompQuickRepPrintIfEmpty (Value:boolean);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQuickRep then (F_QR.Components[I] as TIcQuickRep).PrintIfEmpty := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompBandLinkBand (Value:string);
var
  I:longint;
  mComp:TComponent;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRBand then begin
        mComp := nil;
        If Value<>'' then mComp := F_QR.FindComponent (Value);
        (F_QR.Components[I] as TIcQRBand).LinkBand := mComp as TQRCustomBand;
      end;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompBandAlignToBottom (Value:boolean);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRBand then (F_QR.Components[I] as TIcQRBand).AlignToBottom := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompBandForceNewColumn (Value:boolean);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRBand then (F_QR.Components[I] as TIcQRBand).ForceNewColumn := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompBandForceNewPage (Value:boolean);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRBand then (F_QR.Components[I] as TIcQRBand).ForceNewPage := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompChildBandParentBand (Value:string);
var
  I:longint;
  mComp:TComponent;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRChildBand then begin
        mComp := nil;
        If Value<>'' then mComp := F_QR.FindComponent (Value);
        (F_QR.Components[I] as TIcQRChildBand).ParentBand := mComp as TQRCustomBand;
      end;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompChildBandLinkBand (Value:string);
var
  I:longint;
  mComp:TComponent;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRChildBand then begin
        mComp := nil;
        If Value<>'' then mComp := F_QR.FindComponent (Value);
        (F_QR.Components[I] as TIcQRChildBand).LinkBand := mComp as TQRCustomBand;
      end;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompChildBandAlignToBottom (Value:boolean);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRChildBand then (F_QR.Components[I] as TIcQRChildBand).AlignToBottom := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompChildBandForceNewColumn (Value:boolean);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRChildBand then (F_QR.Components[I] as TIcQRChildBand).ForceNewColumn := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompChildBandForceNewPage (Value:boolean);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRChildBand then (F_QR.Components[I] as TIcQRChildBand).ForceNewPage := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompSubDetailMaster (Value:string);
var
  I:longint;
  mComp:TComponent;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRSubDetail then begin
        mComp := nil;
        If Value<>'' then mComp := F_QR.FindComponent (Value);
        (F_QR.Components[I] as TIcQRSubDetail).Master := mComp;
      end;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompSubDetailDataSet (Value:string);
var
  I:longint;
  mComp:TObject;
begin
  mComp := GetTableObj (Value);
  If mComp is TDataSet then begin
    oChange := TRUE;
    For I:=0 to F_QR.ComponentCount-1 do begin
      If IsSelected (F_QR.Components[I].Name) then begin
        If F_QR.Components[I] is TIcQRSubDetail then begin
          try
            (F_QR.Components[I] as TIcQRSubDetail).DataSet := mComp as TDataSet;
          except end;
        end;
      end;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompSubDetailHeaderBand (Value:string);
var
  I:longint;
  mComp:TComponent;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRSubDetail then begin
        mComp := nil;
        If Value<>'' then mComp := F_QR.FindComponent (Value);
        (F_QR.Components[I] as TIcQRSubDetail).HeaderBand := mComp as TQRCustomBand;
      end;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompSubDetailFooterBand (Value:string);
var
  I:longint;
  mComp:TComponent;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRSubDetail then begin
        mComp := nil;
        If Value<>'' then mComp := F_QR.FindComponent (Value);
        (F_QR.Components[I] as TIcQRSubDetail).FooterBand := mComp as TQRCustomBand;
      end;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompSubDetailAlignToBottom (Value:boolean);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRSubDetail then (F_QR.Components[I] as TIcQRSubDetail).AlignToBottom := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompSubDetailForceNewColumn (Value:boolean);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRSubDetail then (F_QR.Components[I] as TIcQRSubDetail).ForceNewColumn := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompSubDetailForceNewPage (Value:boolean);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRSubDetail then (F_QR.Components[I] as TIcQRSubDetail).ForceNewPage := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompSubDetailLinkBand (Value:string);
var
  I:longint;
  mComp:TComponent;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRSubDetail then begin
        mComp := nil;
        If Value<>'' then mComp := F_QR.FindComponent (Value);
        (F_QR.Components[I] as TIcQRSubDetail).LinkBand := mComp as TQRCustomBand;
      end;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompSubDetailPrintBefore (Value:boolean);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRSubDetail then (F_QR.Components[I] as TIcQRSubDetail).PrintBefore := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompSubDetailPrintIfEmpty (Value:boolean);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRSubDetail then (F_QR.Components[I] as TIcQRSubDetail).PrintIfEmpty := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompGroupMaster (Value:string);
var
  I:longint;
  mComp:TComponent;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRGroup then begin
        mComp := nil;
        If Value<>'' then mComp := F_QR.FindComponent (Value);
        (F_QR.Components[I] as TIcQRGroup).Master := mComp;
      end;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompGroupFooterBand (Value:string);
var
  I:longint;
  mComp:TComponent;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRGroup then begin
        mComp := nil;
        If Value<>'' then mComp := F_QR.FindComponent (Value);
        (F_QR.Components[I] as TIcQRGroup).FooterBand := mComp as TQRBand;
      end;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompGroupExpression (Value:string);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRGroup then (F_QR.Components[I] as TIcQRGroup).Expression := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompGroupAlignToBottom (Value:boolean);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRGroup then (F_QR.Components[I] as TIcQRGroup).AlignToBottom := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompGroupForceNewColumn (Value:boolean);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRGroup then (F_QR.Components[I] as TIcQRGroup).ForceNewColumn := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompGroupForceNewPage (Value:boolean);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRGroup then (F_QR.Components[I] as TIcQRGroup).ForceNewPage := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompGroupLinkBand (Value:string);
var
  I:longint;
  mComp:TComponent;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRGroup then begin
        mComp := nil;
        If Value<>'' then mComp := F_QR.FindComponent (Value);
        (F_QR.Components[I] as TIcQRGroup).LinkBand := mComp as TQRCustomBand;
      end;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompGroupReprintOnNewPage (Value:boolean);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRGroup then (F_QR.Components[I] as TIcQRGroup).ReprintOnNewPage := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompChartDataSet (Value:string);
var
  I:longint;
  mComp:TObject;
begin
  mComp := GetTableObj (Value);
  If mComp is TDataSet then begin
    oChange := TRUE;
    For I:=0 to F_QR.ComponentCount-1 do begin
      If IsSelected (F_QR.Components[I].Name) then begin
        If F_QR.Components[I] is TIcQRChart then begin
          try
            ((F_QR.Components[I] as TIcQRChart).Chart.Series[0] as TAreaSeries).DataSource := mComp as TDataSet;
          except end;
        end;
      end;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompChartStairs (Value:boolean);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRChart then begin
        If (F_QR.Components[I] as TIcQRChart).Chart.SeriesCount>0 then begin
          If (F_QR.Components[I] as TIcQRChart).Chart.Series[0] is TAreaSeries
            then ((F_QR.Components[I] as TIcQRChart).Chart.Series[0] as TAreaSeries).Stairs := Value;
        end;
      end;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompChartXFieldName (Value:string);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRChart then ((F_QR.Components[I] as TQRChart).Chart.Series[0] as TAreaSeries).XValues.ValueSource := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompChartXDateTime (Value:boolean);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRChart then ((F_QR.Components[I] as TQRChart).Chart.Series[0] as TAreaSeries).XValues.DateTime := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompChartYFieldName (Value:string);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRChart then ((F_QR.Components[I] as TQRChart).Chart.Series[0] as TAreaSeries).YValues.ValueSource := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompChartYDateTime (Value:boolean);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRChart then ((F_QR.Components[I] as TQRChart).Chart.Series[0] as TAreaSeries).YValues.DateTime := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompBarCodeDataSet (Value:string);
var
  I:longint;
  mComp:TObject;
begin
  mComp := GetTableObj (Value);
  If mComp is TDataSet then begin
    oChange := TRUE;
    For I:=0 to F_QR.ComponentCount-1 do begin
      If IsSelected (F_QR.Components[I].Name) then begin
        If F_QR.Components[I] is TIcQRBarCode then begin
          try
            (F_QR.Components[I] as TIcQRBarCode).DataSet := mComp as TDataSet;
          except end;
        end;
      end;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompBarCodeFieldName (Value:string);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRBarCode then (F_QR.Components[I] as TIcQRBarCode).DataField := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompBarCodeClearZone (Value:boolean);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRBarCode then (F_QR.Components[I] as TIcQRBarCode).ClearZone := Value;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompBarCodeText (Value:string);
var I:longint;
begin
  oChange := TRUE;
  If Value<>'' then begin
    CB_QRBarCodeDataModule.ItemIndex := -1;
    CB_QRBarCodeDataSet.ItemIndex := -1;
    CB_QRBarCodeDataField.ItemIndex := -1;
  end;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRBarCode then begin
        (F_QR.Components[I] as TIcQRBarCode).Text := Value;
        If Value<>'' then begin
          (F_QR.Components[I] as TIcQRBarCode).DataField := '';
          (F_QR.Components[I] as TIcQRBarCode).DataSet := nil;
        end;
      end;
    end;
  end;
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SetCompBarCodeType (Value:longint);
var I:longint;
begin
  oChange := TRUE;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If IsSelected (F_QR.Components[I].Name) then begin
      If F_QR.Components[I] is TIcQRBarCode then begin
        If Value=0 then (F_QR.Components[I] as TIcQRBarCode).BarCodeType := Code128;
        If Value=1 then (F_QR.Components[I] as TIcQRBarCode).BarCodeType := Code39;
        If Value=2 then (F_QR.Components[I] as TIcQRBarCode).BarCodeType := EAN;
        If Value=3 then (F_QR.Components[I] as TIcQRBarCode).BarCodeType := EAN128;
        If Value=4 then (F_QR.Components[I] as TIcQRBarCode).BarCodeType := EAN13;
        If Value=5 then (F_QR.Components[I] as TIcQRBarCode).BarCodeType := EAN8;
        If Value=6 then (F_QR.Components[I] as TIcQRBarCode).BarCodeType := FIMA;
        If Value=7 then (F_QR.Components[I] as TIcQRBarCode).BarCodeType := FIMB;
        If Value=8 then (F_QR.Components[I] as TIcQRBarCode).BarCodeType := FIMC;
        If Value=9 then (F_QR.Components[I] as TIcQRBarCode).BarCodeType := Interleaved2of5;
        If Value=10 then (F_QR.Components[I] as TIcQRBarCode).BarCodeType := ITF14;
        If Value=11 then (F_QR.Components[I] as TIcQRBarCode).BarCodeType := PostNet;
        If Value=12 then (F_QR.Components[I] as TIcQRBarCode).BarCodeType := Postnet11;
        If Value=13 then (F_QR.Components[I] as TIcQRBarCode).BarCodeType := PostnetZip;
        If Value=14 then (F_QR.Components[I] as TIcQRBarCode).BarCodeType := PostnetZipPlus4;
      end;
    end;
  end;
  SetActCompParam (FALSE);
end;

function  TF_QRMain.GetTableObj (Value:string):TObject;
var mDM, mTable:string;
begin
  Result := nil;
  mDM := Copy (Value,1, Pos ('.',Value)-1);
  mTable := Copy (Value,Pos ('.',Value)+1,Length (Value));
  If Application.FindComponent (mDM)<>nil then begin
    If Application.FindComponent (mDM).FindComponent (mTable)<>nil then begin
      Result := Application.FindComponent (mDM).FindComponent (mTable);
    end;
  end;
end;

procedure TF_QRMain.AddSpecBand (Sender:TObject;pName:string;pType:TQRBandType;pHeight:longint);
begin
  SB_QRBandClick (Sender);
  F_QR.FindComponent ('Band1').Name := pName;
  (F_QR.FindComponent (pName) as TIcQRBand).Selected := FALSE;
  (F_QR.FindComponent (pName) as TQRBand).BandType := pType;
  (F_QR.FindComponent (pName) as TQRBand).Height := pHeight;
  (F_QR.FindComponent (pName) as TQRBand).Font.Name := 'Times New Roman';
end;

procedure TF_QRMain.AddSpecExpr (pName,pBand,pExpression,pMask:string;pAlign:TAlignment;pLeft,pTop,pWidth:longint);
begin
  AddExpr (pBand);
  F_QR.FindComponent ('Expr1').Name := pName;
  (F_QR.FindComponent (pName) as TIcQRExpr).Selected := FALSE;
  (F_QR.FindComponent (pName) as TQRExpr).AutoSize := FALSE;
  (F_QR.FindComponent (pName) as TQRExpr).Expression := pExpression;
  (F_QR.FindComponent (pName) as TQRExpr).Mask := pMask;
  (F_QR.FindComponent (pName) as TQRExpr).Alignment := pAlign;
  (F_QR.FindComponent (pName) as TQRExpr).Left := pLeft;
  (F_QR.FindComponent (pName) as TQRExpr).Top := pTop;
  (F_QR.FindComponent (pName) as TQRExpr).Width := pWidth;
end;

procedure TF_QRMain.AddSpecLabel (pName,pBand,pCaption:string;pAlign:TAlignment;pLeft,pTop,pWidth:longint;pFontSize:longint;pFontStyle:TFontStyles);
begin
  AddLabel (pBand);
  F_QR.FindComponent ('Label1').Name := pName;
  (F_QR.FindComponent (pName) as TIcQRLabel).Selected := FALSE;
  (F_QR.FindComponent (pName) as TQRLabel).AutoSize := FALSE;
  (F_QR.FindComponent (pName) as TQRLabel).Caption := pCaption;
  (F_QR.FindComponent (pName) as TQRLabel).Alignment := pAlign;
  (F_QR.FindComponent (pName) as TQRLabel).Left := pLeft;
  (F_QR.FindComponent (pName) as TQRLabel).Top := pTop;
  (F_QR.FindComponent (pName) as TQRLabel).Width := pWidth;
  (F_QR.FindComponent (pName) as TQRLabel).Font.Size := pFontSize;
  (F_QR.FindComponent (pName) as TQRLabel).Font.Style := pFontStyle;
end;

procedure TF_QRMain.AddSpecSysData (pName,pBand:string;pData:TQRSysDataType;pAlign:TAlignment;pLeft,pTop,pWidth:longint);
begin
  AddSysData (pBand);
  F_QR.FindComponent ('SysData1').Name := pName;
  (F_QR.FindComponent (pName) as TIcQRSysData).Selected := FALSE;
  (F_QR.FindComponent (pName) as TQRSysData).AutoSize := FALSE;
  (F_QR.FindComponent (pName) as TQRSysData).Data := pData;
  (F_QR.FindComponent (pName) as TQRSysData).Alignment := pAlign;
  (F_QR.FindComponent (pName) as TQRSysData).Left := pLeft;
  (F_QR.FindComponent (pName) as TQRSysData).Top := pTop;
  (F_QR.FindComponent (pName) as TQRSysData).Width := pWidth;
end;

procedure TF_QRMain.AddSpecDBText (pName,pBand,pField,pMask:string;pDataSet:TDataSet;pAlign:TAlignment;pLeft,pTop,pWidth:longint);
begin
  AddDBText (pBand);
  F_QR.FindComponent ('DBText1').Name := pName;
  (F_QR.FindComponent (pName) as TIcQRDBText).Selected := FALSE;
  (F_QR.FindComponent (pName) as TQRDBText).AutoSize := FALSE;
  (F_QR.FindComponent (pName) as TQRDBText).DataField := pField;
  (F_QR.FindComponent (pName) as TQRDBText).Mask := pMask;
  (F_QR.FindComponent (pName) as TQRDBText).DataSet := pDataSet;
  (F_QR.FindComponent (pName) as TQRDBText).Alignment := pAlign;
  (F_QR.FindComponent (pName) as TQRDBText).Left := pLeft;
  (F_QR.FindComponent (pName) as TQRDBText).Top := pTop;
  (F_QR.FindComponent (pName) as TQRDBText).Width := pWidth;
end;

procedure TF_QRMain.AddSpecShape (pName,pBand:string;pLeft,pTop,pHeight:longint);
begin
  AddShape (pBand);
  F_QR.FindComponent ('Shape1').Name := pName;
  (F_QR.FindComponent (pName) as TIcQRShape).Selected := FALSE;
  (F_QR.FindComponent (pName) as TQRShape).Shape := qrsVertLine;
  (F_QR.FindComponent (pName) as TQRShape).Left := pLeft;
  (F_QR.FindComponent (pName) as TQRShape).Top := pTop;
  (F_QR.FindComponent (pName) as TQRShape).Height := pHeight;
  (F_QR.FindComponent (pName) as TQRShape).Width := 3;
end;

procedure TF_QRMain.SetSpecTitleBand (Sender:TObject);
begin
  If F_QRNewSpec.CB_PrintFirmaName.Checked or F_QRNewSpec.CB_PrintDate.Checked or F_QRNewSpec.CB_PrintTitle.Checked then begin
    If ((F_QRNewSpec.CB_PrintFirmaName.Checked or F_QRNewSpec.CB_PrintDate.Checked) and not F_QRNewSpec.CB_PrintTitle.Checked)
      or ((not F_QRNewSpec.CB_PrintFirmaName.Checked and not F_QRNewSpec.CB_PrintDate.Checked) and F_QRNewSpec.CB_PrintTitle.Checked)
        then AddSpecBand (Sender,'B_Title', rbTitle,21)
        else AddSpecBand (Sender,'B_Title', rbTitle,41);
    If F_QRNewSpec.RB_WithFrame.Checked then begin
      (F_QR.FindComponent ('B_Title') as TQRBand).Frame.DrawTop := TRUE;
      (F_QR.FindComponent ('B_Title') as TQRBand).Frame.DrawLeft := TRUE;
      (F_QR.FindComponent ('B_Title') as TQRBand).Frame.DrawRight := TRUE;
    end;
    If F_QRNewSpec.RB_MinFrame.Checked then begin
      (F_QR.FindComponent ('B_Title') as TQRBand).Frame.DrawTop := TRUE;
    end;
    If F_QRNewSpec.CB_PrintFirmaName.Checked then AddSpecExpr ('E_FirmaName','B_Title','FirmaName','',taLeftJustify, 2, 2, 300);
    If F_QRNewSpec.CB_PrintDate.Checked then begin
      AddSpecLabel ('L_PrintDate', 'B_Title', 'Dátum vyhotovenia tlaèovej zostavy:',taRightJustify, (F_QR.FindComponent ('B_Title') as TQRBand).Width-72-200-5,2,200, 10, []);
      AddSpecExpr ('E_PrintDate','B_Title','PrintDate','',taLeftJustify, (F_QR.FindComponent ('B_Title') as TQRBand).Width-72, 2, 70);
    end;
    If F_QRNewSpec.CB_PrintTitle.Checked then begin
      If (F_QRNewSpec.CB_PrintFirmaName.Checked or F_QRNewSpec.CB_PrintDate.Checked)
        then AddSpecLabel ('L_Title', 'B_Title', F_QRNewSpec.E_Title.Text,taCenter, 10, 20, (F_QR.FindComponent ('B_Title') as TQRBand).Width-20, 12, [fsBold])
        else AddSpecLabel ('L_Title', 'B_Title', F_QRNewSpec.E_Title.Text,taCenter, 10, 2, (F_QR.FindComponent ('B_Title') as TQRBand).Width-20, 12, [fsBold]);
    end;
  end;
end;

procedure TF_QRMain.SetSpecPageFooter (Sender:TObject);
var mPos:longint;
begin
  If F_QRNewSpec.CB_PrintActPgNum.Checked or F_QRNewSpec.CB_PrintActPgQnt.Checked or F_QRNewSpec.CB_PrintRepFile.Checked then begin
    AddSpecBand (Sender,'B_PageFooter', rbPageFooter,18);
    If F_QRNewSpec.RB_MinFrame.Checked then begin
      (F_QR.FindComponent ('B_PageFooter') as TQRBand).Frame.DrawTop := TRUE;
    end;
    If F_QRNewSpec.CB_PrintActPgNum.Checked then AddSpecSysData ('S_PageNum', 'B_PageFooter', qrsPageNumber, taCenter, ((F_QR.FindComponent ('B_PageFooter') as TQRBand).Width-60) div 2, 1, 60);
    If F_QRNewSpec.CB_PrintActPgQnt.Checked then begin
      mPos := ((F_QR.FindComponent ('B_PageFooter') as TQRBand).Width-126) div 2;
      AddSpecSysData ('S_PageNum', 'B_PageFooter', qrsPageNumber, taRightJustify, mPos, 1, 60);
      AddSpecLabel ('L_PageNum', 'B_PageFooter', '/',taCenter, mPos+60, 1, 6, 10, []);
      AddSpecExpr ('E_ActPgNum','B_PageFooter','PageCount','',taLeftJustify, mPos+66, 1, 60);
    end;
    If F_QRNewSpec.CB_PrintRepFile.Checked then AddSpecExpr ('E_RepFile','B_PageFooter','RepFile','',taRightJustify, (F_QR.FindComponent ('B_PageFooter') as TQRBand).Width-102, 1, 100);
  end;
end;

procedure TF_QRMain.SetSpecItems (Sender:TObject);
var
  mComp:TObject;
  mSum:boolean;
  I:longint;
  mFld:string;
  mPos:longint;
  mIndex:longint;
  mAlign:TAlignment;
begin
  If F_QRNewSpec.CB_DataSet.Text<>'' then begin
    mComp := GetTableObj (F_QRNewSpec.CB_DataSet.Text);
    If mComp is TDataSet then oQuickRep.DataSet := mComp as TDataSet;
    mSum := FALSE;
    For I:=0 to 200 do begin
      If F_QRNewSpec.oFldData[I].Fld<>'' then mSum := F_QRNewSpec.oFldData[I].Summary;
      If mSum then Break;
    end;
    AddSpecBand (Sender,'B_ColumnHeader', rbColumnHeader,21);
    AddSpecBand (Sender,'B_Detail', rbDetail,19);
    If mSum then AddSpecBand (Sender,'B_Summary', rbSummary,19);
    If F_QRNewSpec.RB_WithFrame.Checked then begin
      (F_QR.FindComponent ('B_ColumnHeader') as TQRBand).Frame.DrawTop := TRUE;
      (F_QR.FindComponent ('B_ColumnHeader') as TQRBand).Frame.DrawBottom := TRUE;
      (F_QR.FindComponent ('B_ColumnHeader') as TQRBand).Frame.DrawLeft := TRUE;
      (F_QR.FindComponent ('B_ColumnHeader') as TQRBand).Frame.DrawRight := TRUE;
      (F_QR.FindComponent ('B_Detail') as TQRBand).Frame.DrawLeft := TRUE;
      (F_QR.FindComponent ('B_Detail') as TQRBand).Frame.DrawRight := TRUE;
      If mSum then begin
        (F_QR.FindComponent ('B_Summary') as TQRBand).Frame.DrawBottom := TRUE;
        (F_QR.FindComponent ('B_Summary') as TQRBand).Frame.DrawTop := TRUE;
        (F_QR.FindComponent ('B_Summary') as TQRBand).Frame.DrawLeft := TRUE;
        (F_QR.FindComponent ('B_Summary') as TQRBand).Frame.DrawRight := TRUE;
      end;
    end;
    If F_QRNewSpec.RB_MinFrame.Checked then begin
      (F_QR.FindComponent ('B_ColumnHeader') as TQRBand).Frame.DrawTop := TRUE;
      (F_QR.FindComponent ('B_ColumnHeader') as TQRBand).Frame.DrawBottom := TRUE;
      If mSum then begin
        (F_QR.FindComponent ('B_Summary') as TQRBand).Frame.DrawTop := TRUE;
      end;
    end;
    If F_QRNewSpec.LB_PrintFields.Items.Count>0 then begin
      mPos := 2;
      For I:=0 to F_QRNewSpec.LB_PrintFields.Items.Count-1 do begin
        mFld := F_QRNewSpec.LB_PrintFields.Items.Strings[I];
        If Pos (' - ',mFld)>0 then mFld := Copy (mFld,1,Pos (' - ',mFld)-1);
        mIndex := F_QRNewSpec.FindFldData (mFld);
        mAlign := taLeftJustify;
        If F_QRNewSpec.oFldData[mIndex].NameAlign=1 then mAlign := taCenter;
        If F_QRNewSpec.oFldData[mIndex].NameAlign=2 then mAlign := taRightJustify;
        AddSpecLabel ('L_'+mFld, 'B_ColumnHeader', F_QRNewSpec.oFldData[mIndex].Name, mAlign, mPos, 2, F_QRNewSpec.oFldData[mIndex].Width, 10, [fsBold]);
        mAlign := taLeftJustify;
        If F_QRNewSpec.oFldData[mIndex].FiledAlign=1 then mAlign := taCenter;
        If F_QRNewSpec.oFldData[mIndex].FiledAlign=2 then mAlign := taRightJustify;
        AddSpecDBText ('DB_'+mFld, 'B_Detail', F_QRNewSpec.oFldData[mIndex].Fld, F_QRNewSpec.oFldData[mIndex].Mask, mComp as TDataSet, mAlign, mPos, 1, F_QRNewSpec.oFldData[mIndex].Width);
        If F_QRNewSpec.oFldData[mIndex].Summary then AddSpecExpr ('E_'+mFld,'B_Summary','Sum('+mFld+')',F_QRNewSpec.oFldData[mIndex].Mask, mAlign, mPos, 1, F_QRNewSpec.oFldData[mIndex].Width);
        mPos := mPos+F_QRNewSpec.oFldData[mIndex].Width;
        If F_QRNewSpec.RB_WithFrame.Checked then begin
          If I<>F_QRNewSpec.LB_PrintFields.Items.Count-1 then begin
            AddSpecShape ('SH_L'+mFld,'B_ColumnHeader',mPos,0,(F_QR.FindComponent ('B_ColumnHeader') as TQRBand).Height);
            AddSpecShape ('SH_DB'+mFld,'B_Detail',mPos,0,(F_QR.FindComponent ('B_Detail') as TQRBand).Height);
          end;
        end;
        mPos := mPos+3;
      end;
    end;
  end;
end;

procedure TF_QRMain.FormCreate(Sender: TObject);
var mScr:TScreen;
begin
  oShowing := TRUE;
  F_QRMain.Height := 170;
  oCopyList := TStringList.Create;
  oCompList := TStringList.Create;
  oXYList := TStringList.Create;
  oAddComp := 0;
  CB_Fonts.Clear;
  mScr := TScreen.Create (Self);
  mScr.ResetFonts;
  CB_Fonts.Items := mScr.Fonts;
  mScr.Free; mScr := nil;
  oCtrlMouse := FALSE;
  oButtFix := FALSE;
  SB_Arrow.Down := TRUE;
  oCompNameChange := FALSE;
  oFirstActivate := TRUE;
  oSpecCompData.rMemoLines := TStringList.Create;
  Fill_IL_QRShapePenStyle;
  Fill_IL_QRShapeBrushStyle;
  oRepMask := '';
end;

procedure TF_QRMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  If oChange then begin
    If MessageDlg ('Chcete ulozit otvorenú tlacovu masku?',mtConfirmation,[mbYes,mbNo], 0)=mrYes then begin
      SB_QRSaveClick (Sender);
    end;
  end;
  oSpecCompData.rMemoLines.Free; oSpecCompData.rMemoLines := nil;
  oCompList.Free; oCompList := nil;
  oXYList.Free; oXYList := nil;
  oCopyList.Free; oCopyList := nil;
end;

procedure TF_QRMain.SB_QRNewClick(Sender: TObject);
begin
  If oChange then begin
    If MessageDlg ('Chcete ulozit otvorenú tlacovu masku?',mtConfirmation,[mbYes,mbNo], 0)=mrYes then begin
      SB_QRSaveClick (Sender);
    end;
  end;
  F_QRMain.Caption := cMainHead+' - noname';
  oRepFile := '';
  F_QR.DestroyComponents;
  F_QR.Caption := '';
  F_QR.Show;
  F_QR.OnKeyDown := IcCompKeyDown;
  oQuickRep := TIcQuickRep.Create (F_QR);
  oQuickRep.Parent := F_QR;
  oQuickRep.Name := 'QuickRep';
  oQuickRep.Functions.AddFunction ('PAGECOUNT', '0');
  oQuickRep.Functions.AddFunction ('FIRMANAME', '');
  oQuickRep.Functions.AddFunction ('PRINTDATE', '');
  oQuickRep.Functions.AddFunction ('PRINTTIME', '');
  oQuickRep.Functions.AddFunction ('REPFILE', '');
  oQuickRep.OnMouseMove := IcQuickRepMouseMove;
  oQuickRep.OnMouseDown := IcQuickRepMouseDown;
  oQuickRep.OnMouseUp := IcCompMouseUp;
  oQuickRep.OnClick := IcCompClick;
  oQuickRep.OnPreview := MyPreview;
  F_QR.Tag := 0;
  SelectComp (oQuickRep.Name);
  FillCompNames;
  FillXYList;
  SetActCompParam (FALSE);
  F_QR.SetFocus;
  FillMaster;
  oChange := FALSE;
end;

procedure TF_QRMain.SB_QRSubDetailClick(Sender: TObject);
var
  mComp:TIcQRSubDetail;
  mCnt:longint;
begin
  If oQuickRep<>nil then begin
    oChange := TRUE;
    mComp := TIcQRSubDetail.Create (F_QR);
    mComp.Parent := oQuickRep;
    mCnt := 1;
    While F_QR.FindComponent ('SubDetail'+StrInt (mCnt,0))<>nil do
      Inc (mCnt);
    mComp.Name := 'SubDetail'+StrInt (mCnt,0);
    mComp.OnMouseMove := IcQRSubDetailMouseMove;
    mComp.OnMouseDown := IcQRSubDetailMouseDown;
    mComp.OnMouseUp := IcCompMouseUp;
    mComp.OnClick := IcCompClick;
    SelectComp (mComp.Name);
    FillCompNames;
    FillXYList;
    FillMaster;
  end;
end;

procedure TF_QRMain.SB_QRBandClick(Sender: TObject);
var
  mComp:TIcQRBand;
  mCnt:longint;
begin
  If oQuickRep<>nil then begin
    oChange := TRUE;
    mComp := TIcQRBand.Create (F_QR);
    mComp.Parent := oQuickRep;
    mCnt := 1;
    While F_QR.FindComponent ('Band'+StrInt (mCnt,0))<>nil do
      Inc (mCnt);
    mComp.Name := 'Band'+StrInt (mCnt,0);
    mComp.OnMouseMove := IcQRBandMouseMove;
    mComp.OnMouseDown := IcQRBandMouseDown;
    mComp.OnMouseUp := IcCompMouseUp;
    mComp.OnClick := IcCompClick;
    SelectComp (mComp.Name);
    FillCompNames;
    FillXYList;
  end;
end;

procedure TF_QRMain.SB_QRChildBandClick(Sender: TObject);
var
  mComp:TIcQRChildBand;
  mCnt:longint;
begin
  If oQuickRep<>nil then begin
    oChange := TRUE;
    mComp := TIcQRChildBand.Create (F_QR);
    mComp.Parent := oQuickRep;
    mCnt := 1;
    While F_QR.FindComponent ('ChildBand'+StrInt (mCnt,0))<>nil do
      Inc (mCnt);
    mComp.Name := 'ChildBand'+StrInt (mCnt,0);
    mComp.OnMouseMove := IcQRChildBandMouseMove;
    mComp.OnMouseDown := IcQRChildBandMouseDown;
    mComp.OnMouseUp := IcCompMouseUp;
    mComp.OnClick := IcCompClick;
    SelectComp (mComp.Name);
    FillCompNames;
    FillXYList;
  end;
end;

procedure TF_QRMain.SB_QRGroupClick(Sender: TObject);
var
  mComp:TIcQRGroup;
  mCnt:longint;
begin
  If oQuickRep<>nil then begin
    oChange := TRUE;
    mComp := TIcQRGroup.Create (F_QR);
    mComp.Parent := oQuickRep;
    mCnt := 1;
    While F_QR.FindComponent ('Group'+StrInt (mCnt,0))<>nil do
      Inc (mCnt);
    mComp.Name := 'Group'+StrInt (mCnt,0);
    mComp.OnMouseMove := IcQRGroupMouseMove;
    mComp.OnMouseDown := IcQRGroupMouseDown;
    mComp.OnMouseUp := IcCompMouseUp;
    mComp.OnClick := IcCompClick;
    SelectComp (mComp.Name);
    FillCompNames;
    FillXYList;
  end;
end;

procedure TF_QRMain.SB_QRSaveClick(Sender: TObject);
const
  mV: array [1..15] of string = ('TIcQuickRep','TIcQRBand','TIcQRChildBand','TIcQRSubDetail','TIcQRGroup',
      'TIcQRLabel','TIcQRDBText','TIcQRExpr','TIcQRSysData','TIcQRMemo','TIcQRShape','TIcQRImage','TIcQRDBImage','TIcQRChart','TIcQRBarCode');
var
  mTS,mTT:TextFile;
  mS:string;
  I:byte;
  mPos:longint;
  mSave:boolean;
begin
  SD_File.FileName := oRepFile;
  SD_File.Filter := '';
  If oRepMask<>'' then SD_File.Filter := 'QuickReport - '+oRepMask+'|'+oRepMask+'.Q??|';
  SD_File.Filter := SD_File.Filter+'QuickReport|*.Q*';
  SD_File.InitialDir := gPath.RepPath;
  If SD_File.Execute then begin
    oRepFile := SD_File.FileName;
    mSave := TRUE;
    If FileExists (oRepFile) then mSave := (MessageDlg ('Zadaná tlaèová maska už existuje!'+#13+'Chcete prepísa?',mtConfirmation,[mbYes,mbNo], 0)=mrYes);
    If mSave then begin
      F_QR.Visible := FALSE;
      WriteComponentResFile ('$$$SB.$$$',F_QR);
      F_QR.Visible := TRUE;
      ConvObjToText ('$$$SB.$$$','$$$ST1.$$$');
      AssignFile (mTS, '$$$ST1.$$$');
      Reset (mTS);
      AssignFile (mTT, '$$$ST2.$$$');
      Rewrite (mTT);
      Repeat
        ReadLn (mTS,mS);
        If Pos ('Selected =',mS)=0 then begin
          For I:=1 to 14 do begin
            If Pos (mV[I],mS)>0 then begin
              Delete (mS, Pos (mV[I],mS)+1, 2);
              Break;
            end;
          end;
          WriteLn (mTT, mS);
        end;
      until EOF (mTS);
      CloseFile (mTS);
      CloseFile (mTT);
      ConvTextToObj ('$$$ST2.$$$',SD_File.FileName);
      DeleteFile ('$$$SB.$$$');
      DeleteFile ('$$$ST1.$$$');
      DeleteFile ('$$$ST2.$$$');
      F_QRMain.Caption := cMainHead+' - '+ExtractFileName(oRepFile);
      oChange := FALSE;
    end;
  end;
end;

procedure TF_QRMain.SB_QROpenClick(Sender: TObject);
const
  mV: array [1..14] of string = ('TQuickRep','TQRBand','TQRChildBand','TQRSubDetail','TQRGroup',
      'TQRLabel','TQRDBText','TQRExpr','TQRSysData','TQRMemo','TQRShape','TQRImage','TQRDBImage','TQRChart');
var
  I:longint;
  mS:string;
  mTS,mTT:TextFile;
begin
  If oChange then begin
    If MessageDlg ('Chcete ulozit otvorenú tlacovu masku?',mtConfirmation,[mbYes,mbNo], 0)=mrYes then begin
      SB_QRSaveClick (Sender);
    end;
  end;
  OD_File.InitialDir := gPath.RepPath;
  OD_File.Filter := '';
  If oRepMask<>'' then OD_File.Filter := 'QuickReport - '+oRepMask+'|'+oRepMask+'.Q??|';
  OD_File.Filter := OD_File.Filter+'QuickReport|*.Q*';
  If OD_File.Execute then begin
    oRepFile := OD_File.FileName;
    F_QR.Hide;
    oCompList.Clear;
    oXYList.Clear;
    F_QR.DestroyComponents;
    ConvObjToText (OD_File.FileName, '$$$OT1.$$$');
    AssignFile (mTS, '$$$OT1.$$$');
    Reset (mTS);
    AssignFile (mTT, '$$$OT2.$$$');
    Rewrite (mTT);
    Repeat
      ReadLn (mTS,mS);
      For I:=1 to 14 do begin
        If Pos (mV[I],mS)>0 then begin
          Insert ('Ic', mS, Pos (mV[I],mS)+1);
          Break;
        end;
      end;
      WriteLn (mTT, mS);
    until EOF (mTS);
    CloseFile (mTS);
    CloseFile (mTT);
    ConvTextToObj ('$$$OT2.$$$', '$$$OB.$$$');
    ReadComponentResFile ('$$$OB.$$$', F_QR);
    F_QR.Visible := TRUE;
    DeleteFile ('$$$OB.$$$');
    DeleteFile ('$$$OT1.$$$');
    DeleteFile ('$$$OT2.$$$');
    For I:=0 to F_QR.ComponentCount-1 do begin
      If F_QR.Components[I] is TIcQuickRep then begin
        (F_QR.Components[I] as TIcQuickRep).OnMouseMove := IcQuickRepMouseMove;
        (F_QR.Components[I] as TIcQuickRep).OnMouseDown := IcQuickRepMouseDown;
        (F_QR.Components[I] as TIcQuickRep).OnMouseUp := IcCompMouseUp;
        (F_QR.Components[I] as TIcQuickRep).OnClick := IcCompClick;
        oQuickRep := (F_QR.Components[I] as TIcQuickRep);
        oQuickRep.OnPreview := MyPreview;
        oQuickRep.Units := MM;
      end;
      If F_QR.Components[I] is TIcQRBand then begin
        (F_QR.Components[I] as TIcQRBand).OnMouseMove := IcQRBandMouseMove;
        (F_QR.Components[I] as TIcQRBand).OnMouseDown := IcQRBandMouseDown;
        (F_QR.Components[I] as TIcQRBand).OnMouseUp := IcCompMouseUp;
        (F_QR.Components[I] as TIcQRBand).OnClick := IcCompClick;
      end;
      If F_QR.Components[I] is TIcQRChildBand then begin
        (F_QR.Components[I] as TIcQRChildBand).OnMouseMove := IcQRChildBandMouseMove;
        (F_QR.Components[I] as TIcQRChildBand).OnMouseDown := IcQRChildBandMouseDown;
        (F_QR.Components[I] as TIcQRChildBand).OnMouseUp := IcCompMouseUp;
        (F_QR.Components[I] as TIcQRChildBand).OnClick := IcCompClick;
      end;
      If F_QR.Components[I] is TIcQRSubDetail then begin
        (F_QR.Components[I] as TIcQRSubDetail).OnMouseMove := IcQRSubDetailMouseMove;
        (F_QR.Components[I] as TIcQRSubDetail).OnMouseDown := IcQRSubDetailMouseDown;
        (F_QR.Components[I] as TIcQRSubDetail).OnMouseUp := IcCompMouseUp;
        (F_QR.Components[I] as TIcQRSubDetail).OnClick := IcCompClick;
      end;
      If F_QR.Components[I] is TIcQRGroup then begin
        (F_QR.Components[I] as TIcQRGroup).OnMouseMove := IcQRGroupMouseMove;
        (F_QR.Components[I] as TIcQRGroup).OnMouseDown := IcQRGroupMouseDown;
        (F_QR.Components[I] as TIcQRGroup).OnMouseUp := IcCompMouseUp;
        (F_QR.Components[I] as TIcQRGroup).OnClick := IcCompClick;
      end;
      If F_QR.Components[I] is TIcQRLabel then begin
        (F_QR.Components[I] as TIcQRLabel).OnMouseMove := IcQRLabelMouseMove;
        (F_QR.Components[I] as TIcQRLabel).OnMouseDown := IcQRLabelMouseDown;
        (F_QR.Components[I] as TIcQRLabel).OnMouseUp := IcCompMouseUp;
        (F_QR.Components[I] as TIcQRLabel).OnClick := IcCompClick;
      end;
      If F_QR.Components[I] is TIcQRDBText then begin
        (F_QR.Components[I] as TIcQRDBText).OnMouseMove := IcQRDBTextMouseMove;
        (F_QR.Components[I] as TIcQRDBText).OnMouseDown := IcQRDBTextMouseDown;
        (F_QR.Components[I] as TIcQRDBText).OnMouseUp := IcCompMouseUp;
        (F_QR.Components[I] as TIcQRDBText).OnClick := IcCompClick;
      end;
      If F_QR.Components[I] is TIcQRExpr then begin
        (F_QR.Components[I] as TIcQRExpr).OnMouseMove := IcQRExprMouseMove;
        (F_QR.Components[I] as TIcQRExpr).OnMouseDown := IcQRExprMouseDown;
        (F_QR.Components[I] as TIcQRExpr).OnMouseUp := IcCompMouseUp;
        (F_QR.Components[I] as TIcQRExpr).OnClick := IcCompClick;
      end;
      If F_QR.Components[I] is TIcQRSysData then begin
        (F_QR.Components[I] as TIcQRSysData).OnMouseMove := IcQRSysDataMouseMove;
        (F_QR.Components[I] as TIcQRSysData).OnMouseDown := IcQRSysDataMouseDown;
        (F_QR.Components[I] as TIcQRSysData).OnMouseUp := IcCompMouseUp;
        (F_QR.Components[I] as TIcQRSysData).OnClick := IcCompClick;
      end;
      If F_QR.Components[I] is TIcQRMemo then begin
        (F_QR.Components[I] as TIcQRMemo).OnMouseMove := IcQRMemoMouseMove;
        (F_QR.Components[I] as TIcQRMemo).OnMouseDown := IcQRMemoMouseDown;
        (F_QR.Components[I] as TIcQRMemo).OnMouseUp := IcCompMouseUp;
        (F_QR.Components[I] as TIcQRMemo).OnClick := IcCompClick;
      end;
      If F_QR.Components[I] is TIcQRShape then begin
        (F_QR.Components[I] as TIcQRShape).OnMouseMove := IcQRShapeMouseMove;
        (F_QR.Components[I] as TIcQRShape).OnMouseDown := IcQRShapeMouseDown;
        (F_QR.Components[I] as TIcQRShape).OnMouseUp := IcCompMouseUp;
        (F_QR.Components[I] as TIcQRShape).OnClick := IcCompClick;
      end;
      If F_QR.Components[I] is TIcQRImage then begin
        (F_QR.Components[I] as TIcQRImage).OnMouseMove := IcQRImageMouseMove;
        (F_QR.Components[I] as TIcQRImage).OnMouseDown := IcQRImageMouseDown;
        (F_QR.Components[I] as TIcQRImage).OnMouseUp := IcCompMouseUp;
        (F_QR.Components[I] as TIcQRImage).OnClick := IcCompClick;
      end;
      If F_QR.Components[I] is TIcQRDBImage then begin
        (F_QR.Components[I] as TIcQRDBImage).OnMouseMove := IcQRDBImageMouseMove;
        (F_QR.Components[I] as TIcQRDBImage).OnMouseDown := IcQRDBImageMouseDown;
        (F_QR.Components[I] as TIcQRDBImage).OnMouseUp := IcCompMouseUp;
        (F_QR.Components[I] as TIcQRDBImage).OnClick := IcCompClick;
      end;
      If F_QR.Components[I] is TIcQRChart then begin
        (F_QR.Components[I] as TIcQRChart).OnMouseMove := IcQRChartMouseMove;
        (F_QR.Components[I] as TIcQRChart).OnMouseDown := IcQRChartMouseDown;
        (F_QR.Components[I] as TIcQRChart).OnMouseUp := IcCompMouseUp;
        (F_QR.Components[I] as TIcQRChart).OnClick := IcCompClick;
      end;
      If F_QR.Components[I] is TIcQRBarCode then begin
        (F_QR.Components[I] as TIcQRBarCode).OnMouseMove := IcQRBarCodeMouseMove;
        (F_QR.Components[I] as TIcQRBarCode).OnMouseDown := IcQRBarCodeMouseDown;
        (F_QR.Components[I] as TIcQRBarCode).OnMouseUp := IcCompMouseUp;
        (F_QR.Components[I] as TIcQRBarCode).OnClick := IcCompClick;
      end;
    end;
    F_QR.Show;
    oChange := FALSE;
    F_QRMain.Caption := cMainHead+' - '+ExtractFileName(oRepFile);
  end;
  SelectComp (oQuickRep.Name);
end;

procedure TF_QRMain.CB_CompNameClick(Sender: TObject);
begin
  If F_QR.FindComponent (CB_CompName.Text)<>nil then SelectComp (CB_CompName.Text);
end;

procedure TF_QRMain.SB_ArrowClick(Sender: TObject);
begin
  oAddComp := 0;
  SB_QRLabel.Flat := TRUE;
  SB_QRDBText.Flat := TRUE;
  SB_QRExpr.Flat := TRUE;
  SB_QRSysData.Flat := TRUE;
  SB_QRMemo.Flat := TRUE;
  SB_QRShape.Flat := TRUE;
  SB_QRImage.Flat := TRUE;
  SB_QRDBImage.Flat := TRUE;
  SB_QRChart.Flat := TRUE;
  SB_QRBarCode.Flat := TRUE;
  SB_Arrow.Down := TRUE;
end;

procedure TF_QRMain.SB_SetButtFix(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  If ssShift in Shift then oButtFix := TRUE else oButtFix := FALSE;
end;

procedure TF_QRMain.SB_QRLabelClick(Sender: TObject);
begin
  SB_ArrowClick(Sender);
  SB_QRLabel.Down := TRUE;
  If oButtFix then SB_QRLabel.Flat := FALSE;
  oAddComp := 1;
end;

procedure TF_QRMain.SB_QRDBTextClick(Sender: TObject);
begin
  SB_ArrowClick(Sender);
  SB_QRDBText.Down := TRUE;
  If oButtFix then SB_QRDBText.Flat := FALSE;
  oAddComp := 2;
end;

procedure TF_QRMain.SB_QRExprClick(Sender: TObject);
begin
  SB_ArrowClick(Sender);
  SB_QRExpr.Down := TRUE;
  If oButtFix then SB_QRExpr.Flat := FALSE;
  oAddComp := 3;
end;

procedure TF_QRMain.SB_QRSysDataClick(Sender: TObject);
begin
  SB_ArrowClick(Sender);
  SB_QRSysData.Down := TRUE;
  If oButtFix then SB_QRSysData.Flat := FALSE;
  oAddComp := 4;
end;

procedure TF_QRMain.SB_QRMemoClick(Sender: TObject);
begin
  SB_ArrowClick(Sender);
  SB_QRMemo.Down := TRUE;
  If oButtFix then SB_QRMemo.Flat := FALSE;
  oAddComp := 5;
end;

procedure TF_QRMain.SB_QRShapeClick(Sender: TObject);
begin
  SB_ArrowClick(Sender);
  SB_QRShape.Down := TRUE;
  If oButtFix then SB_QRShape.Flat := FALSE;
  oAddComp := 6;
end;

procedure TF_QRMain.SB_QRImageClick(Sender: TObject);
begin
  SB_ArrowClick(Sender);
  SB_QRImage.Down := TRUE;
  If oButtFix then SB_QRImage.Flat := FALSE;
  oAddComp := 7;
end;

procedure TF_QRMain.SB_QRDBImageClick(Sender: TObject);
begin
  SB_ArrowClick(Sender);
  SB_QRDBImage.Down := TRUE;
  If oButtFix then SB_QRDBImage.Flat := FALSE;
  oAddComp := 8;
end;

procedure TF_QRMain.SB_QRChartClick(Sender: TObject);
begin
  SB_ArrowClick(Sender);
  SB_QRChart.Down := TRUE;
  If oButtFix then SB_QRChart.Flat := FALSE;
  oAddComp := 9;
end;

procedure TF_QRMain.RB_CNTypeClick(Sender: TObject);
begin
  FillCompNames;
end;

procedure TF_QRMain.CB_CompNameChange(Sender: TObject);
begin
  oCompNameChange := TRUE;
end;

procedure TF_QRMain.CB_CompNameExit(Sender: TObject);
var mComp:TObject;
begin
  If oCompNameChange then begin
    If not cqMultiSelect then begin
      If oCompList.Count=1 then begin
        mComp := F_QR.FindComponent (oCompList.Strings[0]);
        If mComp<>nil then begin
          try
            (mComp as TControl).Name := CB_CompName.Text;
           except end;
          FillCompNames;
          If (mComp is TQuickRep) or (mComp is TQRSubDetail) then FillMaster;
        end;
      end;
    end;
  end;
  oCompNameChange := FALSE;
end;

procedure TF_QRMain.CB_ZoomClick(Sender: TObject);
begin
  CB_Zoom.Text := ReplaceStr (CB_Zoom.Text,' ','');
  CB_Zoom.Text := ReplaceStr (CB_Zoom.Text,'%','');
  oQuickRep.Zoom := ValInt (CB_Zoom.Text);
  CB_Zoom.Text := StrInt (oQuickRep.Zoom,0)+'%';
  SetActCompParam (FALSE);
end;

procedure TF_QRMain.SB_OrientationClick(Sender: TObject);
var mImage:TBitmap;
begin
  If oQuickRep.Page.Orientation=poPortrait
    then oQuickRep.Page.Orientation := poLandscape
    else oQuickRep.Page.Orientation := poPortrait;
  mImage := TBitmap.Create;
  If oQuickRep.Page.Orientation=poPortrait
    then IL_Orientation.GetBitmap (0,mImage)
    else IL_Orientation.GetBitmap (1,mImage);
  SB_Orientation.Glyph.Assign (mImage);
  mImage.Free; mImage := nil;
end;

procedure TF_QRMain.FormActivate(Sender: TObject);
begin
  If oFirstActivate then begin
    Left := 0;
    Top := 0;
    F_QR.Left := 0;
    F_QR.Top := 171;
    SB_QRNewClick(Sender);
    oFirstActivate := FALSE;
    FillDataModules;
    SetNotSelComponents;
    SetBkColor;
  end;
end;

procedure TF_QRMain.ReturnExit(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key=VK_RETURN) then begin
    E_ExitControl.SetFocus;
    (Sender as TWinControl).SetFocus;
  end;
end;

procedure TF_QRMain.SB_PreviewClick(Sender: TObject);
var
  mR:TQREvResult;
  mPC:boolean;
  I:longint;
begin
  F_QR.Hide;
//  SetTableActive (TRUE);
  mR.Kind := resInt;
  For I:=0 to F_QR.ComponentCount-1 do begin
    If F_QR.Components[I] is TQRExpr then begin
      mPC := Pos ('PAGECOUNT', UpString ((F_QR.Components[I] as TQRExpr).Expression))>0;
    end;
    If mPC then Break;
  end;
  oQuickRep.Functions.Prepare;
  If mPC then begin
    oQuickRep.Prepare;
    mR.intResult := oQuickRep.QRPrinter.PageCount;
    oQuickRep.QRPrinter.Free;
  end else mR.intResult := 0;
  oQuickRep.Functions.UpdateConstant ('PAGECOUNT',mR);
  mR.Kind := resString;
  mR.strResult := 'IdentCode Consulting s.r.o.';
  oQuickRep.Functions.UpdateConstant ('FIRMANAME',mR);
  mR.strResult := DateToStr (Date);
  oQuickRep.Functions.UpdateConstant ('PRINTDATE',mR);
  mR.strResult := TimeToStr (Time);
  oQuickRep.Functions.UpdateConstant ('PRINTTIME',mR);
  If oRepFile=''
    then mR.strResult := 'NONE'
    else mR.strResult := ExtractFileName(oRepFile);
  oQuickRep.Functions.UpdateConstant ('REPFILE',mR);
  oQuickRep.Preview;
//  SetTableActive (FALSE);
  F_QR.Show;
end;

procedure TF_QRMain.E_LeftExit(Sender: TObject);
begin
  If E_Left.Text<>'' then SetCompLeft (ValInt (E_Left.Text));
end;

procedure TF_QRMain.E_TopExit(Sender: TObject);
begin
  If E_Top.Text<>'' then SetCompTop (ValInt (E_Top.Text));
end;

procedure TF_QRMain.E_WidthExit(Sender: TObject);
begin
  If E_Width.Text<>'' then SetCompWidth (ValInt (E_Width.Text));
end;

procedure TF_QRMain.E_HeightExit(Sender: TObject);
begin
  If E_Height.Text<>'' then SetCompHeight (ValInt (E_Height.Text));
end;

procedure TF_QRMain.E_LeftMMExit(Sender: TObject);
begin
  If E_LeftMM.Text<>'' then SetCompLeftMM (ValDoub (E_LeftMM.Text));
end;

procedure TF_QRMain.E_TopMMExit(Sender: TObject);
begin
  If E_TopMM.Text<>'' then SetCompTopMM (ValDoub (E_TopMM.Text));
end;

procedure TF_QRMain.E_WidthMMExit(Sender: TObject);
begin
  If E_WidthMM.Text<>'' then SetCompWidthMM (ValDoub (E_WidthMM.Text));
end;

procedure TF_QRMain.E_HeightMMExit(Sender: TObject);
begin
  If E_HeightMM.Text<>'' then SetCompHeightMM (ValDoub (E_HeightMM.Text));
end;

procedure TF_QRMain.SB_ColorClick(Sender: TObject);
begin
  CD_Color.Color := SB_Color.Glyph.Canvas.Brush.Color;
  If CD_Color.Execute then begin
    SB_Color.Glyph.Canvas.Brush.Color := CD_Color.Color;
    SB_Color.Glyph.Canvas.FillRect(Rect(1,17,23,23));
    SetCompColor (SB_Color.Glyph.Canvas.Brush.Color);
  end;
end;

procedure TF_QRMain.SB_AlignClick(Sender: TObject);
begin
  If (Sender as TSpeedButton).Name='SB_AlignLeft' then SetCompAlign (taLeftJustify);
  If (Sender as TSpeedButton).Name='SB_AlignCenter' then SetCompAlign (taCenter);
  If (Sender as TSpeedButton).Name='SB_AlignRight' then SetCompAlign (taRightJustify);
end;

procedure TF_QRMain.SB_AutoSizeClick(Sender: TObject);
begin
  SetCompAutoSize (SB_AutoSize.Down);
end;

procedure TF_QRMain.SB_WordWrapClick(Sender: TObject);
begin
  oCompData.rWordWrap := not oCompData.rWordWrap;
  If oCompData.rWordWrap then SB_WordWrap.Tag := 2 else SB_WordWrap.Tag := 1;
  SetWordWrap;
  SetCompWordWrap ((SB_WordWrap.Tag=1));
end;

procedure TF_QRMain.E_QRLabelCaptionChange(Sender: TObject);
begin
  If E_QRLabelCaption.Focused then SetCompCaption (E_QRLabelCaption.Text);
end;

procedure TF_QRMain.CB_FontsExit(Sender: TObject);
begin
  SetCompFontName (CB_Fonts.Text);
end;

procedure TF_QRMain.SB_TransparentClick(Sender: TObject);
begin
  oCompData.rTransparent := not oCompData.rTransparent;
  If oCompData.rTransparent then SB_Transparent.Tag := 2 else SB_Transparent.Tag := 1;
  SetTransparent;
  SetCompTransparent ((SB_Transparent.Tag=1));
end;

procedure TF_QRMain.SB_BringToFrontClick(Sender: TObject);
begin
  If not cqMultiSelect and (CB_CompName.Text<>'') then begin
    If F_QR.FindComponent (CB_CompName.Text)<>nil then (F_QR.FindComponent (CB_CompName.Text) as TControl).BringToFront;
  end;
end;

procedure TF_QRMain.SB_SendToBackClick(Sender: TObject);
begin
  If not cqMultiSelect and (CB_CompName.Text<>'') then begin
    If F_QR.FindComponent (CB_CompName.Text)<>nil then (F_QR.FindComponent (CB_CompName.Text) as TControl).SendToBack;
  end;
end;

procedure TF_QRMain.CB_FontSizeExit(Sender: TObject);
begin
  SetCompFontSize (ValInt (CB_FontSize.Text));
end;

procedure TF_QRMain.SB_BoldFontClick(Sender: TObject);
begin
  SetCompBoldFont (SB_BoldFont.Down);
end;

procedure TF_QRMain.SB_ItalicFontClick(Sender: TObject);
begin
  SetCompItalicFont (SB_ItalicFont.Down);
end;

procedure TF_QRMain.SB_ULineFontClick(Sender: TObject);
begin
  SetCompULineFont (SB_ULineFont.Down);
end;

procedure TF_QRMain.SB_FontColorClick(Sender: TObject);
begin
  CD_Color.Color := SB_FontColor.Glyph.Canvas.Brush.Color;
  If CD_Color.Execute then begin
    SB_FontColor.Glyph.Canvas.Brush.Color := CD_Color.Color;
    SB_FontColor.Glyph.Canvas.FillRect(Rect(1,17,23,23));
    SetCompFontColor (SB_FontColor.Glyph.Canvas.Brush.Color);
  end;
end;

procedure TF_QRMain.CB_FontCharsetChange(Sender: TObject);
begin
  SetCompFontCharset (CB_FontCharset.ItemIndex);
end;

procedure TF_QRMain.SB_FrameColorClick(Sender: TObject);
begin
  CD_Color.Color := SB_FrameColor.Glyph.Canvas.Brush.Color;
  If CD_Color.Execute then begin
    SB_FrameColor.Glyph.Canvas.Brush.Color := CD_Color.Color;
    SB_FrameColor.Glyph.Canvas.FillRect(Rect(1,17,23,23));
    SetCompFrameColor (SB_FrameColor.Glyph.Canvas.Brush.Color);
  end;
end;

procedure TF_QRMain.SB_FrameLeftClick(Sender: TObject);
begin
  SetCompFrameLeft (SB_FrameLeft.Down);
end;

procedure TF_QRMain.SB_FrameTopClick(Sender: TObject);
begin
  SB_FrameTop.Flat := TRUE;
  SetCompFrameTop (SB_FrameTop.Down);
end;

procedure TF_QRMain.SB_FrameRightClick(Sender: TObject);
begin
  SetCompFrameRight (SB_FrameRight.Down);
end;

procedure TF_QRMain.SB_FrameBottomClick(Sender: TObject);
begin
  SetCompFrameBottom (SB_FrameBottom.Down);
end;

procedure TF_QRMain.M_QRMemoChange(Sender: TObject);
begin
  If M_QRMemo.Focused then SetCompMemo (M_QRMemo.Lines);
end;

procedure TF_QRMain.CB_QRSysDataTypeChange(Sender: TObject);
var
  mImage:TBitmap;
  mI:longint;
begin
  P_QRSysData.Visible := TRUE;
  mImage := TBitmap.Create;
  IL_QRSysDataType.GetBitmap (CB_QRSysDataType.ItemIndex, mImage);
  I_QRSysDataType.Picture.Assign (mImage);
  mImage.Free; mImage := nil;
  SetCompSysDataType (CB_QRSysDataType.ItemIndex);
end;

procedure TF_QRMain.E_QRSysDataTextChange(Sender: TObject);
begin
  If E_QRSysDataText.Focused then SetCompSysDataText (E_QRSysDataText.Text);
end;

procedure TF_QRMain.SB_QRShapeBrushColorClick(Sender: TObject);
begin
//  CD_Color.Color := SB_QRShapeBrushColor.Glyph.Canvas.Brush.Color;
  CD_Color.Color := oSpecCompData.rShapeBrushColor;
  If CD_Color.Execute then begin
    SB_QRShapeBrushColor.Glyph.Canvas.Brush.Color := CD_Color.Color;
    SB_QRShapeBrushColor.Glyph.Canvas.FillRect(Rect(1,17,23,23));
    SetCompShapeBrushColor (SB_QRShapeBrushColor.Glyph.Canvas.Brush.Color);
  end;
end;

procedure TF_QRMain.SB_QRShapeBrushStyleClick(Sender: TObject);
var
  mI:longint;
  mImage:TBitmap;
begin
  mI := F_ImageList.Execute (IL_QRShapeBrushStyle);
  If mI>=0 then begin
    mImage := TBitmap.Create;
    IL_QRShapeBrushStyle.GetBitmap (mI,mImage);
    I_QRShapeBrushStyle.Picture.Assign (mImage);
    I_QRShapeBrushStyle.Tag := mI;
    mImage.Free; mImage := nil;
    SetCompShapeBrushStyle (mI);
  end;
end;

procedure TF_QRMain.SB_QRShapePenColorClick(Sender: TObject);
begin
  CD_Color.Color := SB_QRShapePenColor.Glyph.Canvas.Brush.Color;
  If CD_Color.Execute then begin
    SB_QRShapePenColor.Glyph.Canvas.Brush.Color := CD_Color.Color;
    SB_QRShapePenColor.Glyph.Canvas.FillRect(Rect(1,17,23,23));
    SetCompShapePenColor (SB_QRShapePenColor.Glyph.Canvas.Brush.Color);
  end;
end;

procedure TF_QRMain.SB_QRShapePenStyleClick(Sender: TObject);
var
  mI:longint;
  mImage:TBitmap;
begin
  mI := F_ImageList.Execute (IL_QRShapePenStyle);
  If mI>=0 then begin
    mImage := TBitmap.Create;
    IL_QRShapePenStyle.GetBitmap (mI,mImage);
    I_QRShapePenStyle.Picture.Assign (mImage);
    I_QRShapePenStyle.Tag := mI;
    mImage.Free; mImage := nil;
    SetCompShapePenStyle (mI);
  end;
end;

procedure TF_QRMain.SB_QRShapeTypeClick(Sender: TObject);
var
  mI:longint;
  mImage:TBitmap;
begin
  mI := F_ImageList.Execute (IL_QRShape);
  If mI>=0 then begin
    mImage := TBitmap.Create;
    IL_QRShape.GetBitmap (mI,mImage);
    I_QRShape.Picture.Assign (mImage);
    I_QRShape.Tag := mI;
    mImage.Free; mImage := nil;
    SetCompShapeType (mI);
  end;
end;

procedure TF_QRMain.SB_QRImageOpenClick(Sender: TObject);
begin
  If OI_Image.Execute then begin
    SetCompImageLoad (OI_Image.FileName);
  end;
end;

procedure TF_QRMain.SB_QRImageStretchClick(Sender: TObject);
var mImage:TBitmap;
begin
  case SB_QRImageStretch.Tag of
    0: SB_QRImageStretch.Tag := 1;
    1: SB_QRImageStretch.Tag := 2;
    else SB_QRImageStretch.Tag := 0;
  end;
  mImage := TBitmap.Create;
  IL_QRImage.GetBitmap (SB_QRImageStretch.Tag,mImage);
  SB_QRImageStretch.Glyph.Assign (mImage);
  mImage.Free; mImage := nil;
  SetCompImageStretch (SB_QRImageStretch.Tag);
end;

procedure TF_QRMain.CB_QRDBTextDataSetChange(Sender: TObject);
begin
  CB_QRDBTextDataField.Items.Assign (FillFieldNames (CB_QRDBTextDataSet.Text));
  CB_QRDBTextDataFullname.Items.Assign (FillFieldFullNames (CB_QRDBTextDataSet.Text));
  SetCompDBTextDataSet (CB_QRDBTextDataSet.Text);
end;

procedure TF_QRMain.CB_QRDBTextDataFieldChange(Sender: TObject);
begin
  SetCompDBTextFieldName (CB_QRDBTextDataField.Text);
  CB_QRDBTextDataFullName.ItemIndex:=CB_QRDBTextDataField.ItemIndex;
end;

procedure TF_QRMain.CB_QRDBTextDataFullnameChange(Sender: TObject);
begin
  CB_QRDBTextDataField.ItemIndex:=CB_QRDBTextDataFullName.ItemIndex;
//  SetCompDBTextFieldName (CB_QRDBTextDataField.Text);
end;

procedure TF_QRMain.CB_QRDBTextMaskExit(Sender: TObject);
begin
  SetCompDBTextMask (CB_QRDBTextMask.Text);
end;

procedure TF_QRMain.E_QRExprExpressionExit(Sender: TObject);
begin
  SetCompExprExpression (E_QRExprExpression.Text);
end;

procedure TF_QRMain.CB_QRExprMaskExit(Sender: TObject);
begin
  SetCompExprMask (CB_QRExprMask.Text);
end;

procedure TF_QRMain.CB_QRExprMasterChange(Sender: TObject);
begin
  SetCompExprMaster (CB_QRExprMaster.Text);
end;

procedure TF_QRMain.SB_QRExprResetAfterPrintClick(Sender: TObject);
begin
  SetCompExprResetAfterPrint (SB_QRExprResetAfterPrint.Down);
end;

procedure TF_QRMain.CB_QRDBImageDataSetChange(Sender: TObject);
begin
  CB_QRDBImageDataField.Items.Assign (FillFieldNames (CB_QRDBImageDataSet.Text));
  SetCompDBImageDataSet (CB_QRDBImageDataSet.Text);
end;

procedure TF_QRMain.CB_QRDBImageDataFieldChange(Sender: TObject);
begin
  SetCompDBImageFieldName (CB_QRDBImageDataField.Text);
end;

procedure TF_QRMain.SB_QRDBImageStretchClick(Sender: TObject);
var mImage:TBitmap;
begin
  case SB_QRDBImageStretch.Tag of
    0: SB_QRDBImageStretch.Tag := 1;
    1: SB_QRDBImageStretch.Tag := 2;
    else SB_QRDBImageStretch.Tag := 0;
  end;
  mImage := TBitmap.Create;
  IL_QRImage.GetBitmap (SB_QRDBImageStretch.Tag,mImage);
  SB_QRDBImageStretch.Glyph.Assign (mImage);
  mImage.Free; mImage := nil;
  SetCompDBImageStretch (SB_QRDBImageStretch.Tag);
end;

procedure TF_QRMain.CB_QuickRepDataSetChange(Sender: TObject);
begin
  SetCompQuickRepDataSet (CB_QuickRepDataSet.Text);
end;

procedure TF_QRMain.CB_QRBandBandTypeChange(Sender: TObject);
var
  mImage:TBitmap;
  mI:longint;
begin
  P_QRBand.Visible := TRUE;
  mImage := TBitmap.Create;
  IL_BandType.GetBitmap (CB_QRBandBandType.ItemIndex, mImage);
  I_QRBandBandType.Picture.Assign (mImage);
  mImage.Free; mImage := nil;
  SetCompBandBandType (CB_QRBandBandType.ItemIndex);
end;

procedure TF_QRMain.E_QuickRepTopMarginExit(Sender: TObject);
begin
  SetCompMargTop (ValInt (E_QuickRepTopMargin.Text));
end;

procedure TF_QRMain.E_QuickRepBottomMarginExit(Sender: TObject);
begin
  SetCompMargBottom (ValInt (E_QuickRepBottomMargin.Text));
end;

procedure TF_QRMain.E_QuickRepLeftMarginExit(Sender: TObject);
begin
  SetCompMargLeft (ValInt (E_QuickRepLeftMargin.Text));
end;

procedure TF_QRMain.E_QuickRepRightMarginExit(Sender: TObject);
begin
  SetCompMargRight (ValInt (E_QuickRepRightMargin.Text));
end;

procedure TF_QRMain.CB_PaperSizeChange(Sender: TObject);
begin
  SetCompPaperSize (CB_PaperSize.ItemIndex);
end;

procedure TF_QRMain.CB_QRBandLinkBandChange(Sender: TObject);
begin
  SetCompBandLinkBand (CB_QRBandLinkBand.Text);
end;

procedure TF_QRMain.SB_QRBandAlignToBottomClick(Sender: TObject);
var mImage:TBitmap;
begin
  oSpecCompData.rBandAlignToBottom := not oSpecCompData.rBandAlignToBottom;
  If oSpecCompData.rBandAlignToBottom then SB_QRBandAlignToBottom.Tag := 1 else SB_QRBandAlignToBottom.Tag := 0;
  mImage := TBitmap.Create;
  IL_AlignToBottom.GetBitmap (SB_QRBandAlignToBottom.Tag,mImage);
  SB_QRBandAlignToBottom.Glyph.Assign (mImage);
  mImage.Free; mImage := nil;
  SB_QRBandAlignToBottom.Flat := TRUE;
  SetCompBandAlignToBottom (oSpecCompData.rBandAlignToBottom);
end;

procedure TF_QRMain.SB_QRBandForceNewColumnClick(Sender: TObject);
var mImage:TBitmap;
begin
  oSpecCompData.rBandForceNewColumn := not oSpecCompData.rBandForceNewColumn;
  If oSpecCompData.rBandForceNewColumn then SB_QRBandForceNewColumn.Tag := 1 else SB_QRBandForceNewColumn.Tag := 0;
  mImage := TBitmap.Create;
  IL_ForceNewColumn.GetBitmap (SB_QRBandForceNewColumn.Tag,mImage);
  SB_QRBandForceNewColumn.Glyph.Assign (mImage);
  mImage.Free; mImage := nil;
  SB_QRBandForceNewColumn.Flat := TRUE;
  SetCompBandForceNewColumn (oSpecCompData.rBandForceNewColumn);
end;

procedure TF_QRMain.SB_QRBandForceNewPageClick(Sender: TObject);
var mImage:TBitmap;
begin
  oSpecCompData.rBandForceNewPage := not oSpecCompData.rBandForceNewPage;
  If oSpecCompData.rBandForceNewPage then SB_QRBandForceNewPage.Tag := 1 else SB_QRBandForceNewPage.Tag := 0;
  mImage := TBitmap.Create;
  IL_ForceNewPage.GetBitmap (SB_QRBandForceNewPage.Tag,mImage);
  SB_QRBandForceNewPage.Glyph.Assign (mImage);
  mImage.Free; mImage := nil;
  SB_QRBandForceNewPage.Flat := TRUE;
  SetCompBandForceNewPage (oSpecCompData.rBandForceNewPage);
end;

procedure TF_QRMain.CB_QRChildBandParentBandChange(Sender: TObject);
begin
  SetCompChildBandParentBand (CB_QRChildBandParentBand.Text);
end;

procedure TF_QRMain.SB_QRChildBandAlignToBottomClick(Sender: TObject);
var mImage:TBitmap;
begin
  oSpecCompData.rChildBandAlignToBottom := not oSpecCompData.rChildBandAlignToBottom;
  If oSpecCompData.rChildBandAlignToBottom then SB_QRChildBandAlignToBottom.Tag := 1 else SB_QRChildBandAlignToBottom.Tag := 0;
  mImage := TBitmap.Create;
  IL_AlignToBottom.GetBitmap (SB_QRChildBandAlignToBottom.Tag,mImage);
  SB_QRChildBandAlignToBottom.Glyph.Assign (mImage);
  mImage.Free; mImage := nil;
  SB_QRChildBandAlignToBottom.Flat := TRUE;
  SetCompChildBandAlignToBottom (oSpecCompData.rChildBandAlignToBottom);
end;

procedure TF_QRMain.SB_QRChildBandForceNewColumnClick(Sender: TObject);
var mImage:TBitmap;
begin
  oSpecCompData.rChildBandForceNewColumn := not oSpecCompData.rChildBandForceNewColumn;
  If oSpecCompData.rChildBandForceNewColumn then SB_QRChildBandForceNewColumn.Tag := 1 else SB_QRChildBandForceNewColumn.Tag := 0;
  mImage := TBitmap.Create;
  IL_ForceNewColumn.GetBitmap (SB_QRChildBandForceNewColumn.Tag,mImage);
  SB_QRChildBandForceNewColumn.Glyph.Assign (mImage);
  mImage.Free; mImage := nil;
  SB_QRChildBandForceNewColumn.Flat := TRUE;
  SetCompChildBandForceNewColumn (oSpecCompData.rChildBandForceNewColumn);
end;

procedure TF_QRMain.SB_QRChildBandForceNewPageClick(Sender: TObject);
var mImage:TBitmap;
begin
  oSpecCompData.rChildBandForceNewPage := not oSpecCompData.rChildBandForceNewPage;
  If oSpecCompData.rChildBandForceNewPage then SB_QRChildBandForceNewPage.Tag := 1 else SB_QRChildBandForceNewPage.Tag := 0;
  mImage := TBitmap.Create;
  IL_ForceNewPage.GetBitmap (SB_QRChildBandForceNewPage.Tag,mImage);
  SB_QRChildBandForceNewPage.Glyph.Assign (mImage);
  mImage.Free; mImage := nil;
  SB_QRChildBandForceNewPage.Flat := TRUE;
  SetCompChildBandForceNewPage (oSpecCompData.rChildBandForceNewPage);
end;

procedure TF_QRMain.CB_QRChildBandLinkBandChange(Sender: TObject);
begin
  SetCompChildBandLinkBand (CB_QRBandLinkBand.Text);
end;

procedure TF_QRMain.CB_QRSubDetailMasterChange(Sender: TObject);
begin
  SetCompSubDetailMaster (CB_QRSubDetailMaster.Text);
end;

procedure TF_QRMain.CB_QRSubDetailDataSetChange(Sender: TObject);
begin
  SetCompSubDetailDataSet (CB_QRSubDetailDataSet.Text);
end;

procedure TF_QRMain.CB_QRSubDetailHeaderBandChange(Sender: TObject);
begin
  SetCompSubDetailHeaderBand (CB_QRSubDetailHeaderBand.Text);
end;

procedure TF_QRMain.CB_QRSubDetailFooterBandChange(Sender: TObject);
begin
  SetCompSubDetailFooterBand (CB_QRSubDetailFooterBand.Text);
end;

procedure TF_QRMain.SB_QRSubDetailAlignToBottomClick(Sender: TObject);
var mImage:TBitmap;
begin
  oSpecCompData.rSubDetailAlignToBottom := not oSpecCompData.rSubDetailAlignToBottom;
  If oSpecCompData.rSubDetailAlignToBottom then SB_QRSubDetailAlignToBottom.Tag := 1 else SB_QRSubDetailAlignToBottom.Tag := 0;
  mImage := TBitmap.Create;
  IL_AlignToBottom.GetBitmap (SB_QRSubDetailAlignToBottom.Tag,mImage);
  SB_QRSubDetailAlignToBottom.Glyph.Assign (mImage);
  mImage.Free; mImage := nil;
  SB_QRSubDetailAlignToBottom.Flat := TRUE;
  SetCompSubDetailAlignToBottom (oSpecCompData.rSubDetailAlignToBottom);
end;

procedure TF_QRMain.SB_QRSubDetailForceNewColumnClick(Sender: TObject);
var mImage:TBitmap;
begin
  oSpecCompData.rSubDetailForceNewColumn := not oSpecCompData.rSubDetailForceNewColumn;
  If oSpecCompData.rSubDetailForceNewColumn then SB_QRSubDetailForceNewColumn.Tag := 1 else SB_QRSubDetailForceNewColumn.Tag := 0;
  mImage := TBitmap.Create;
  IL_ForceNewColumn.GetBitmap (SB_QRSubDetailForceNewColumn.Tag,mImage);
  SB_QRSubDetailForceNewColumn.Glyph.Assign (mImage);
  mImage.Free; mImage := nil;
  SB_QRSubDetailForceNewColumn.Flat := TRUE;
  SetCompSubDetailForceNewColumn (oSpecCompData.rSubDetailForceNewColumn);
end;

procedure TF_QRMain.SB_QRSubDetailForceNewPageClick(Sender: TObject);
var mImage:TBitmap;
begin
  oSpecCompData.rSubDetailForceNewPage := not oSpecCompData.rSubDetailForceNewPage;
  If oSpecCompData.rSubDetailForceNewPage then SB_QRSubDetailForceNewPage.Tag := 1 else SB_QRSubDetailForceNewPage.Tag := 0;
  mImage := TBitmap.Create;
  IL_ForceNewPage.GetBitmap (SB_QRSubDetailForceNewPage.Tag,mImage);
  SB_QRSubDetailForceNewPage.Glyph.Assign (mImage);
  mImage.Free; mImage := nil;
  SB_QRSubDetailForceNewPage.Flat := TRUE;
  SetCompSubDetailForceNewPage (oSpecCompData.rSubDetailForceNewPage);
end;

procedure TF_QRMain.CB_QRSubDetailLinkBandChange(Sender: TObject);
begin
  SetCompSubDetailLinkBand (CB_QRSubDetailLinkBand.Text);
end;

procedure TF_QRMain.SB_QRSubDetailPrintBeforeClick(Sender: TObject);
var mImage:TBitmap;
begin
  oSpecCompData.rSubDetailPrintBefore := not oSpecCompData.rSubDetailPrintBefore;
  If oSpecCompData.rSubDetailPrintBefore then SB_QRSubDetailPrintBefore.Tag := 1 else SB_QRSubDetailPrintBefore.Tag := 0;
  mImage := TBitmap.Create;
  IL_PrintBefore.GetBitmap (SB_QRSubDetailPrintBefore.Tag,mImage);
  SB_QRSubDetailPrintBefore.Glyph.Assign (mImage);
  mImage.Free; mImage := nil;
  SB_QRSubDetailPrintBefore.Flat := TRUE;
  SetCompSubDetailPrintBefore (oSpecCompData.rSubDetailPrintBefore);
end;

procedure TF_QRMain.SB_QRSubDetailPrintIfEmptyClick(Sender: TObject);
var mImage:TBitmap;
begin
  oSpecCompData.rSubDetailPrintIfEmpty := not oSpecCompData.rSubDetailPrintIfEmpty;
  If oSpecCompData.rSubDetailPrintIfEmpty then SB_QRSubDetailPrintIfEmpty.Tag := 1 else SB_QRSubDetailPrintIfEmpty.Tag := 0;
  mImage := TBitmap.Create;
  IL_PrintIfEmpty.GetBitmap (SB_QRSubDetailPrintIfEmpty.Tag,mImage);
  SB_QRSubDetailPrintIfEmpty.Glyph.Assign (mImage);
  mImage.Free; mImage := nil;
  SB_QRSubDetailPrintIfEmpty.Flat := TRUE;
  SetCompSubDetailPrintIfEmpty (oSpecCompData.rSubDetailPrintIfEmpty);
end;

procedure TF_QRMain.CB_QRGroupMasterChange(Sender: TObject);
begin
  SetCompGroupMaster (CB_QRGroupMaster.Text);
end;

procedure TF_QRMain.CB_QRGroupFooterBandChange(Sender: TObject);
begin
  SetCompGroupFooterBand (CB_QRGroupFooterBand.Text);
end;

procedure TF_QRMain.E_QRGroupExpressionExit(Sender: TObject);
begin
  SetCompGroupExpression (E_QRGroupExpression.Text);
end;

procedure TF_QRMain.SB_QRGroupAlignToBottomClick(Sender: TObject);
var mImage:TBitmap;
begin
  oSpecCompData.rGroupAlignToBottom := not oSpecCompData.rGroupAlignToBottom;
  If oSpecCompData.rGroupAlignToBottom then SB_QRGroupAlignToBottom.Tag := 1 else SB_QRGroupAlignToBottom.Tag := 0;
  mImage := TBitmap.Create;
  IL_AlignToBottom.GetBitmap (SB_QRGroupAlignToBottom.Tag,mImage);
  SB_QRGroupAlignToBottom.Glyph.Assign (mImage);
  mImage.Free; mImage := nil;
  SB_QRGroupAlignToBottom.Flat := TRUE;
  SetCompGroupAlignToBottom (oSpecCompData.rGroupAlignToBottom);
end;

procedure TF_QRMain.SB_QRGroupForceNewColumnClick(Sender: TObject);
var mImage:TBitmap;
begin
  oSpecCompData.rGroupForceNewColumn := not oSpecCompData.rGroupForceNewColumn;
  If oSpecCompData.rGroupForceNewColumn then SB_QRGroupForceNewColumn.Tag := 1 else SB_QRGroupForceNewColumn.Tag := 0;
  mImage := TBitmap.Create;
  IL_ForceNewColumn.GetBitmap (SB_QRGroupForceNewColumn.Tag,mImage);
  SB_QRGroupForceNewColumn.Glyph.Assign (mImage);
  mImage.Free; mImage := nil;
  SB_QRGroupForceNewColumn.Flat := TRUE;
  SetCompGroupForceNewColumn (oSpecCompData.rGroupForceNewColumn);
end;

procedure TF_QRMain.SB_QRGroupForceNewPageClick(Sender: TObject);
var mImage:TBitmap;
begin
  oSpecCompData.rGroupForceNewPage := not oSpecCompData.rGroupForceNewPage;
  If oSpecCompData.rGroupForceNewPage then SB_QRGroupForceNewPage.Tag := 1 else SB_QRGroupForceNewPage.Tag := 0;
  mImage := TBitmap.Create;
  IL_ForceNewPage.GetBitmap (SB_QRGroupForceNewPage.Tag,mImage);
  SB_QRGroupForceNewPage.Glyph.Assign (mImage);
  mImage.Free; mImage := nil;
  SB_QRGroupForceNewPage.Flat := TRUE;
  SetCompGroupForceNewPage (oSpecCompData.rGroupForceNewPage);
end;

procedure TF_QRMain.CB_QRGroupLinkBandChange(Sender: TObject);
begin
  SetCompGroupLinkBand (CB_QRGroupLinkBand.Text);
end;

procedure TF_QRMain.SB_QRGroupReprintOnNewPageClick(Sender: TObject);
var mImage:TBitmap;
begin
  oSpecCompData.rGroupReprintOnNewPage := not oSpecCompData.rGroupReprintOnNewPage;
  If oSpecCompData.rGroupReprintOnNewPage then SB_QRGroupReprintOnNewPage.Tag := 1 else SB_QRGroupReprintOnNewPage.Tag := 0;
  mImage := TBitmap.Create;
  IL_ReprintOnNewPage.GetBitmap (SB_QRGroupReprintOnNewPage.Tag,mImage);
  SB_QRGroupReprintOnNewPage.Glyph.Assign (mImage);
  mImage.Free; mImage := nil;
  SB_QRGroupReprintOnNewPage.Flat := TRUE;
  SetCompGroupReprintOnNewPage (oSpecCompData.rGroupReprintOnNewPage);
end;

procedure TF_QRMain.E_QuickRepColumnsExit(Sender: TObject);
begin
  SetCompQuickRepColumns (ValInt (E_QuickRepColumns.Text));
end;

procedure TF_QRMain.SB_QuickRepPrintIfEmptyClick(Sender: TObject);
var mImage:TBitmap;
begin
  oSpecCompData.rQuickRepPrintIfEmpty := not oSpecCompData.rQuickRepPrintIfEmpty;
  If oSpecCompData.rQuickRepPrintIfEmpty then SB_QuickRepPrintIfEmpty.Tag := 1 else SB_QuickRepPrintIfEmpty.Tag := 0;
  mImage := TBitmap.Create;
  IL_PrintIfEmpty.GetBitmap (SB_QuickRepPrintIfEmpty.Tag,mImage);
  SB_QuickRepPrintIfEmpty.Glyph.Assign (mImage);
  mImage.Free; mImage := nil;
  SB_QuickRepPrintIfEmpty.Flat := TRUE;
  SetCompQuickRepPrintIfEmpty (oSpecCompData.rQuickRepPrintIfEmpty);
end;

procedure TF_QRMain.E_QuickRepColumnSpaceExit(Sender: TObject);
begin
  SetCompQuickRepColumnSpace (ValInt (E_QuickRepColumnSpace.Text));
end;

function TF_QRMain.SetMultiLong (pText:string;pData:longint):string;
begin
  Result := StrInt (pData,0);
  If cqMultiSelect then begin
    If pText<>'' then begin
      If Result<>pText then Result := '';
    end else Result := '';
  end;
end;

function TF_QRMain.SetMultiDoub (pText:string;pData:double):string;
begin
  Result := StrDoub (pData,0,1);
  If cqMultiSelect then begin
    If pText<>'' then begin
      If Result<>pText then Result := '';
    end else Result := '';
  end;
end;

procedure TF_QRMain.SetMultiAutoSize (pEnabled,pAutoSize: boolean);
begin
  If cqMultiSelect then begin
    If pEnabled and oCompData.rAutoSizeE then begin
      If oCompData.rAutoSizeF then begin
        If oCompData.rAutoSize<>pAutoSize then oCompData.rAutoSizeF := FALSE;
      end;
    end else begin
      oCompData.rAutoSizeF := TRUE;
      oCompData.rAutoSizeE := FALSE;
    end;
  end else begin
    oCompData.rAutoSize  := pAutoSize;
    oCompData.rAutoSizeE := pEnabled;
    oCompData.rAutoSizeF := TRUE;
  end;
end;

procedure TF_QRMain.SetMultiAlignment (pEnabled: boolean; pAlignment: TAlignment);
begin
  If cqMultiSelect then begin
    If pEnabled and oCompData.rAlignmentE then begin
      If oCompData.rAlignmentF then begin
        If oCompData.rAlignment<>pAlignment then oCompData.rAlignmentF := FALSE;
      end;
    end else begin
      oCompData.rAlignmentF := TRUE;
      oCompData.rAlignmentE := FALSE;
    end;
  end else begin
    oCompData.rAlignment  := pAlignment;
    oCompData.rAlignmentE := pEnabled;
    oCompData.rAlignmentF := TRUE;
  end;
end;

procedure TF_QRMain.SetMultiFont (pEnabled:boolean; pFont:TFont);
begin
  If cqMultiSelect then begin
    If oCompData.rFontE<>pEnabled then oCompData.rFontE := FALSE;
  end else oCompData.rFontE := pEnabled;
  If pFont<>nil then begin
    SetMultiFontName (pFont.Name);
    SetMultiFontSize (pFont.Size);
    SetMultiFontStyle (pFont.Style);
    SetMultiFontColor (pFont.Color);
    SetMultiFontCharset (pFont.Charset);
  end else begin
    SetMultiFontName ('');
    SetMultiFontSize (0);
    SetMultiFontStyle ([]);
    SetMultiFontColor (clBlack);
    SetMultiFontCharset (-1);
  end;
end;

procedure TF_QRMain.SetMultiFontName (pFontName:string);
begin
  If cqMultiSelect then begin
    If (pFontName<>'') and (oCompData.rFontName<>'') then begin
      If oCompData.rFontName<>pFontName then oCompData.rFontName := '';
    end else oCompData.rFontName := '';
  end else oCompData.rFontName := pFontName;
end;

procedure TF_QRMain.SetMultiFontSize (pFontSize:longint);
begin
  If cqMultiSelect then begin
    If (pFontSize<>0) and (oCompData.rFontSize<>'') then begin
      If oCompData.rFontSize<>StrInt (pFontSize,0) then oCompData.rFontSize := '';
    end else oCompData.rFontSize := '';
  end else oCompData.rFontSize := StrInt (pFontSize,0);
end;

procedure TF_QRMain.SetMultiFontStyle (pFontStyle:TFontStyles);
begin
  If cqMultiSelect then begin
    If oCompData.rFontStyleBF then begin
      If (fsBold in oCompData.rFontStyle)<>(fsBold in pFontStyle) then oCompData.rFontStyleBF := FALSE;
    end;
    If oCompData.rFontStyleIF then begin
      If (fsItalic in oCompData.rFontStyle)<>(fsItalic in pFontStyle) then oCompData.rFontStyleIF := FALSE;
    end;
    If oCompData.rFontStyleUF then begin
      If (fsUnderline in oCompData.rFontStyle)<>(fsUnderline in pFontStyle) then oCompData.rFontStyleUF := FALSE;
    end;
  end else begin
    oCompData.rFontStyle := pFontStyle;
    oCompData.rFontStyleBF := TRUE;
    oCompData.rFontStyleIF := TRUE;
    oCompData.rFontStyleUF := TRUE;
  end;
end;

procedure TF_QRMain.SetMultiFontColor (pFontColor:TColor);
begin
  If cqMultiSelect then begin
    If oCompData.rFontColorF then begin
      If oCompData.rFontColor<>pFontColor then oCompData.rFontColorF := FALSE;
    end;
  end else begin
    oCompData.rFontColor := pFontColor;
    oCompData.rFontColorF := TRUE;
  end;
end;

procedure TF_QRMain.SetMultiFontCharset (pFontCharset:longint);
begin
  If cqMultiSelect then begin
    If (pFontCharset<>-1) and (oCompData.rFontCharset<>-1) then begin
      If oCompData.rFontCharset<>pFontCharset then oCompData.rFontCharset := -1;
    end else oCompData.rFontCharset := -1;
  end else oCompData.rFontCharset := pFontCharset;
end;

procedure TF_QRMain.SetMultiWordWrap (pEnabled,pWordWrap:boolean);
begin
  If cqMultiSelect then begin
    If pEnabled and oCompData.rWordWrapE then begin
      If oCompData.rWordWrapF then begin
        If oCompData.rWordWrap<>pWordWrap then oCompData.rWordWrapF := FALSE;
      end;
    end else begin
      oCompData.rWordWrapF := TRUE;
      oCompData.rWordWrapE := FALSE;
    end;
  end else begin
    oCompData.rWordWrap  := pWordWrap;
    oCompData.rWordWrapE := pEnabled;
    oCompData.rWordWrapF := TRUE;
  end;
end;

procedure TF_QRMain.SetMultiBkColor (pEnabled:boolean; pBkColor:TColor);
begin
  If cqMultiSelect then begin
    If pEnabled and oCompData.rBkColorE then begin
      If oCompData.rBkColorF then begin
        If oCompData.rBkColor<>pBkColor then oCompData.rBkColorF := FALSE;
      end;
    end else begin
      oCompData.rBkColorF := TRUE;
      oCompData.rBkColorE := FALSE;
    end;
  end else begin
    oCompData.rBkColor  := pBkColor;
    oCompData.rBkColorE := pEnabled;
    oCompData.rBkColorF := TRUE;
  end;
end;

procedure TF_QRMain.SetMultiTransparent (pEnabled,pTransparent:boolean);
begin
  If cqMultiSelect then begin
    If pEnabled and oCompData.rTransparentE then begin
      If oCompData.rTransparentF then begin
        If oCompData.rTransparent<>pTransparent then oCompData.rTransparentF := FALSE;
      end;
    end else begin
      oCompData.rTransparentF := TRUE;
      oCompData.rTransparentE := FALSE;
    end;
  end else begin
    oCompData.rTransparent  := pTransparent;
    oCompData.rTransparentE := pEnabled;
    oCompData.rTransparentF := TRUE;
  end;
end;

procedure TF_QRMain.SetMultiFrame (pFrame:TQRFrame);
begin
  SetMultiFrameWidth (pFrame.Width);
  SetMultiFrameLeft (pFrame.DrawLeft);
  SetMultiFrameTop (pFrame.DrawTop);
  SetMultiFrameRight (pFrame.DrawRight);
  SetMultiFrameBottom (pFrame.DrawBottom);
  SetMultiFrameColor (pFrame.Color);
end;

procedure TF_QRMain.SetMultiFrameWidth (pWidth:longint);
begin
  If cqMultiSelect then begin
    If (pWidth<>0) and (oCompData.rFrameWidth<>'') then begin
      If oCompData.rFrameWidth<>StrInt (pWidth,0) then oCompData.rFrameWidth := '';
    end else oCompData.rFrameWidth := '';
  end else oCompData.rFrameWidth := StrInt (pWidth,0);
end;

procedure TF_QRMain.SetMultiFrameLeft (pLeft:boolean);
begin
  If cqMultiSelect then begin
    If oCompData.rFrameLeftF then begin
      If oCompData.rFrameLeft<>pLeft then oCompData.rFrameLeftF := FALSE;
    end;
  end else begin
    oCompData.rFrameLeft := pLeft;
    oCompData.rFrameLeftF := TRUE;
  end;
end;

procedure TF_QRMain.SetMultiFrameTop (pTop:boolean);
begin
  If cqMultiSelect then begin
    If oCompData.rFrameTopF then begin
      If oCompData.rFrameTop<>pTop then oCompData.rFrameTopF := FALSE;
    end;
  end else begin
    oCompData.rFrameTop := pTop;
    oCompData.rFrameTopF := TRUE;
  end;
end;

procedure TF_QRMain.SetMultiFrameRight (pRight:boolean);
begin
  If cqMultiSelect then begin
    If oCompData.rFrameRightF then begin
      If oCompData.rFrameRight<>pRight then oCompData.rFrameRightF := FALSE;
    end;
  end else begin
    oCompData.rFrameRight := pRight;
    oCompData.rFrameRightF := TRUE;
  end;
end;

procedure TF_QRMain.SetMultiFrameBottom (pBottom:boolean);
begin
  If cqMultiSelect then begin
    If oCompData.rFrameBottomF then begin
      If oCompData.rFrameBottom<>pBottom then oCompData.rFrameBottomF := FALSE;
    end;
  end else begin
    oCompData.rFrameBottom := pBottom;
    oCompData.rFrameBottomF := TRUE;
  end;
end;

procedure TF_QRMain.SetMultiFrameColor (pColor:TColor);
begin
  If cqMultiSelect then begin
    If oCompData.rFrameColorF then begin
      If oCompData.rFrameColor<>pColor then oCompData.rFrameColorF := FALSE;
    end;
  end else begin
    oCompData.rFrameColor := pColor;
    oCompData.rFrameColorF := TRUE;
  end;
end;

procedure TF_QRMain.SetMultiLabelCaption (pLabel:string);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rLabelCaption<>pLabel then oSpecCompData.rLabelCaption := '';
  end else begin
    oSpecCompData.rLabelCaption := pLabel;
  end;
end;

procedure TF_QRMain.SetMultiDBTextDataSet (pDataSet:string);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rDBTextDataSet<>pDataSet then oSpecCompData.rDBTextDataSet := '';
  end else begin
    oSpecCompData.rDBTextDataSet := pDataSet;
  end;
end;

procedure TF_QRMain.SetMultiDBTextDataField (pDataSet,pDataField:string);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rDBTextDataField<>'' then begin
      If (oSpecCompData.rDBTextDataField<>pDataField) or (oSpecCompData.rDBTextDataSet<>pDataSet)
        then oSpecCompData.rDBTextDataField := '';
    end;
  end else begin
    oSpecCompData.rDBTextDataField := pDataField;
  end;
end;

procedure TF_QRMain.SetMultiDBTextMask (pMask:string);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rDBTextMask<>pMask then oSpecCompData.rDBTextMask := '';
  end else begin
    oSpecCompData.rDBTextMask := pMask;
  end;
end;

procedure TF_QRMain.SetMultiExprExpression (pExpr:string);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rExprExpression<>'' then begin
      If UpString (oSpecCompData.rExprExpression)<>UpString (pExpr) then oSpecCompData.rExprExpression := '';
    end;
  end else begin
    oSpecCompData.rExprExpression := pExpr;
  end;
end;

procedure TF_QRMain.SetMultiExprMask (pMask:string);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rExprMask<>pMask then oSpecCompData.rExprMask := '';
  end else begin
    oSpecCompData.rExprMask := pMask;
  end;
end;

procedure TF_QRMain.SetMultiExprMaster (pMaster:string);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rExprMaster<>'' then begin
      If oSpecCompData.rExprMaster<>pMaster then oSpecCompData.rExprMaster := '';
    end;
  end else begin
    oSpecCompData.rExprMaster := pMaster;
  end;
end;

procedure TF_QRMain.SetMultiExprResetAfterPrint (pReset:boolean);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rExprResetAfterPrintF then begin
      If oSpecCompData.rExprResetAfterPrint<>pReset then oSpecCompData.rExprResetAfterPrintF := FALSE;
    end;
  end else begin
    oSpecCompData.rExprResetAfterPrint := pReset;
    oSpecCompData.rExprResetAfterPrintF := TRUE;
  end;
end;

procedure TF_QRMain.SetMultiSysDataText (pText:string);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rSysDataText<>pText then oSpecCompData.rSysDataText := '';
  end else begin
    oSpecCompData.rSysDataText := pText;
  end;
end;

procedure TF_QRMain.SetMultiSysDataType (pType:TQRSysDataType);
var mI:longint;
begin
  mI:=0;
  If pType = qrsDate then mI := 0;
  If pType = qrsTime then mI := 1;
  If pType = qrsDateTime then mI := 2;
  If pType = qrsReportTitle then mI := 3;
  If pType = qrsPageNumber then mI := 4;
  If pType = qrsDetailNo then mI := 5;
  If pType = qrsDetailCount then mI := 6;
  If cqMultiSelect then begin
    If oSpecCompData.rSysDataType<>mI then oSpecCompData.rSysDataType := -1;
  end else begin
    oSpecCompData.rSysDataType := mI;
  end;
end;

procedure TF_QRMain.SetMultiMemoLines (pMemo:TStrings);
var
  I:longint;
  mOK:boolean;
begin
  If cqMultiSelect then begin
    mOK := FALSE;
    If (oSpecCompData.rMemoLines.Count>0) and (pMemo.Count>0) then begin
      If oSpecCompData.rMemoLines.Count=pMemo.Count then begin
        I := 0;
        Repeat
          mOK := (oSpecCompData.rMemoLines.Strings[I]=pMemo.Strings[I]);
          Inc (I);
        until not mOK or (I>=oSpecCompData.rMemoLines.Count);
      end;
    end;
    If not mOK then oSpecCompData.rMemoLines.Clear;
  end else begin
    oSpecCompData.rMemoLines.Assign (pMemo);
  end;
end;

procedure TF_QRMain.SetMultiShapeBrushStyle (pBrushStyle:TBrushStyle);
var mI:longint;
begin
  mI:=0;
  If pBrushStyle = bsClear then mI := 0;
  If pBrushStyle = bsHorizontal then mI := 1;
  If pBrushStyle = bsVertical then mI := 2;
  If pBrushStyle = bsCross then mI := 3;
  If pBrushStyle = bsBDiagonal then mI := 4;
  If pBrushStyle = bsFDiagonal then mI := 5;
  If pBrushStyle = bsDiagCross then mI := 6;
  If pBrushStyle = bsSolid then mI := 7;
  If cqMultiSelect then begin
    If oSpecCompData.rShapeBrushStyle<>mI then oSpecCompData.rShapeBrushStyle := -1;
  end else begin
    oSpecCompData.rShapeBrushStyle := mI;
  end;
end;

procedure TF_QRMain.SetMultiShapeBrushColor (pBrushColor:TColor);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rShapeBrushColorF then begin
      If oSpecCompData.rShapeBrushColor<>pBrushColor then oSpecCompData.rShapeBrushColorF := FALSE;
    end;
  end else begin
    oSpecCompData.rShapeBrushColor := pBrushColor;
    oSpecCompData.rShapeBrushColorF := TRUE;
  end;
end;

procedure TF_QRMain.SetMultiShapePenWidth (pPenWidth:longint);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rShapePenWidth<>StrInt (pPenWidth,0) then oSpecCompData.rShapePenWidth := '';
  end else begin
    oSpecCompData.rShapePenWidth := StrInt (pPenWidth,0);
  end;
end;

procedure TF_QRMain.SetMultiShapePenStyle (pPenStyle:TPenStyle);
var mI:longint;
begin
  mI:=0;
  If pPenStyle = psClear then mI := 0;
  If pPenStyle = psDash then mI := 1;
  If pPenStyle = psDashDot then mI := 2;
  If pPenStyle = psDashDotDot then mI := 3;
  If pPenStyle = psDot then mI := 4;
  If pPenStyle = psSolid then mI := 5;
  If pPenStyle = psInsideFrame then mI := 6;
  If cqMultiSelect then begin
    If oSpecCompData.rShapePenStyle<>mI then oSpecCompData.rShapePenStyle := -1;
  end else begin
    oSpecCompData.rShapePenStyle := mI;
  end;
end;

procedure TF_QRMain.SetMultiShapePenColor (pPenColor:TColor);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rShapePenColorF then begin
      If oSpecCompData.rShapePenColor<>pPenColor then oSpecCompData.rShapePenColorF := FALSE;
    end;
  end else begin
    oSpecCompData.rShapePenColor := pPenColor;
    oSpecCompData.rShapePenColorF := TRUE;
  end;
end;

procedure TF_QRMain.SetMultiShapeType (pShape:TQRShapeType);
var mI:longint;
begin
  mI:=0;
  If pShape = qrsRectangle then mI := 0;
  If pShape = qrsCircle then mI := 1;
  If pShape = qrsHorLine then mI := 2;
  If pShape = qrsVertLine then mI := 3;
  If pShape = qrsTopAndBottom then mI := 4;
  If pShape = qrsRightAndLeft then mI := 5;
  If cqMultiSelect then begin
    If oSpecCompData.rShapeType<>mI then oSpecCompData.rShapeType := -1;
  end else begin
    oSpecCompData.rShapeType := mI;
  end;
end;

procedure TF_QRMain.SetMultiImageStretch (pStretch, pCenter:boolean);
var mI:longint;
begin
  mI := 0;
  If pCenter then mI := 2;
  If pStretch then mI := 1;
  If cqMultiSelect then begin
    If oSpecCompData.rImageStretch<>mI then oSpecCompData.rImageStretchF := FALSE;
  end else begin
    oSpecCompData.rImageStretch := mI;
    oSpecCompData.rImageStretchF := TRUE;
  end;
end;

procedure TF_QRMain.SetMultiDBImageDataSet (pDataSet:string);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rDBImageDataSet<>pDataSet then oSpecCompData.rDBImageDataSet := '';
  end else begin
    oSpecCompData.rDBImageDataSet := pDataSet;
  end;
end;

procedure TF_QRMain.SetMultiDBImageDataField (pDataSet,pDataField:string);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rDBImageDataField<>'' then begin
      If (oSpecCompData.rDBImageDataField<>pDataField) or (oSpecCompData.rDBImageDataSet<>pDataSet)
        then oSpecCompData.rDBImageDataField := '';
    end;
  end else begin
    oSpecCompData.rDBImageDataField := pDataField;
  end;
end;

procedure TF_QRMain.SetMultiDBImageStretch (pStretch, pCenter:boolean);
var mI:longint;
begin
  mI := 0;
  If pCenter then mI := 2;
  If pStretch then mI := 1;
  If cqMultiSelect then begin
    If oSpecCompData.rDBImageStretch<>mI then oSpecCompData.rDBImageStretchF := FALSE;
  end else begin
    oSpecCompData.rDBImageStretch := mI;
    oSpecCompData.rDBImageStretchF := TRUE;
  end;
end;

procedure TF_QRMain.SetMultiBarCodeType (pType:TBarCodeType);
var mI:longint;
begin
  mI:=0;
  If pType = Code128 then mI := 0;
  If pType = Code39 then mI := 1;
  If pType = EAN then mI := 2;
  If pType = EAN128 then mI := 3;
  If pType = EAN13 then mI := 4;
  If pType = EAN8 then mI := 5;
  If pType = FIMA then mI := 6;
  If pType = FIMB then mI := 7;
  If pType = FIMC then mI := 8;
  If pType = Interleaved2of5 then mI := 9;
  If pType = ITF14 then mI := 10;
  If pType = PostNet then mI := 11;
  If pType = Postnet11 then mI := 12;
  If pType = PostnetZip then mI := 13;
  If pType = PostnetZipPlus4 then mI := 14;
  If cqMultiSelect then begin
    If oSpecCompData.rBarCodeType<>mI then oSpecCompData.rBarCodeType := -1;
  end else begin
    oSpecCompData.rBarCodeType := mI;
  end;
end;

procedure TF_QRMain.SetMultiChartStairs (pChartStairs:boolean);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rChartStairs<>pChartStairs then oSpecCompData.rChartStairs := FALSE;
  end else begin
    oSpecCompData.rChartStairs := pChartStairs;
  end;
end;

procedure TF_QRMain.SetMultiChartDataSet (pDataSet:string);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rChartDataSet<>pDataSet then oSpecCompData.rChartDataSet := '';
  end else begin
    oSpecCompData.rChartDataSet := pDataSet;
  end;
end;

procedure TF_QRMain.SetMultiChartXDataField (pDataSet,pDataField:string);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rChartXDataField<>'' then begin
      If (oSpecCompData.rChartXDataField<>pDataField) or (oSpecCompData.rChartDataSet<>pDataSet)
        then oSpecCompData.rChartXDataField := '';
    end;
  end else begin
    oSpecCompData.rChartXDataField := pDataField;
  end;
end;

procedure TF_QRMain.SetMultiChartXDateTime (pDateTime:boolean);
begin
  If cqMultiSelect then begin
    If (oSpecCompData.rChartXDateTime<>pDateTime) or (oSpecCompData.rChartXDateTime<>pDateTime)
      then oSpecCompData.rChartXDateTime := FALSE;
  end else begin
    oSpecCompData.rChartXDateTime := pDateTime;
  end;
end;

procedure TF_QRMain.SetMultiChartYDataField (pDataSet,pDataField:string);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rChartYDataField<>'' then begin
      If (oSpecCompData.rChartYDataField<>pDataField) or (oSpecCompData.rChartDataSet<>pDataSet)
        then oSpecCompData.rChartYDataField := '';
    end;
  end else begin
    oSpecCompData.rChartYDataField := pDataField;
  end;
end;

procedure TF_QRMain.SetMultiChartYDateTime (pDateTime:boolean);
begin
  If cqMultiSelect then begin
    If (oSpecCompData.rChartYDateTime<>pDateTime) or (oSpecCompData.rChartYDateTime<>pDateTime)
      then oSpecCompData.rChartYDateTime := FALSE;
  end else begin
    oSpecCompData.rChartYDateTime := pDateTime;
  end;
end;

procedure TF_QRMain.SetMultiBarCodeText (pText:string);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rBarCodeText<>pText then oSpecCompData.rBarCodeText := '';
  end else begin
    oSpecCompData.rBarCodeText := pText;
  end;
end;

procedure TF_QRMain.SetMultiBarCodeClearZone (pClearZone:boolean);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rBarCodeClearZone<>pClearZone then oSpecCompData.rBarCodeClearZone := TRUE;
  end else begin
    oSpecCompData.rBarCodeClearZone := pClearZone;
  end;
end;

procedure TF_QRMain.SetMultiBarCodeDataSet (pDataSet:string);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rBarCodeDataSet<>pDataSet then oSpecCompData.rBarCodeDataSet := '';
  end else begin
    oSpecCompData.rBarCodeDataSet := pDataSet;
  end;
end;

procedure TF_QRMain.SetMultiBarCodeDataField (pDataSet,pDataField:string);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rBarCodeDataField<>'' then begin
      If (oSpecCompData.rBarCodeDataField<>pDataField) or (oSpecCompData.rBarCodeDataSet<>pDataSet)
        then oSpecCompData.rBarCodeDataField := '';
    end;
  end else begin
    oSpecCompData.rBarCodeDataField := pDataField;
  end;
end;

procedure TF_QRMain.SetMultiBandBandType (pBandType:TQRBandType);
var mI:longint;
begin
  mI:=0;
  If pBandType = rbPageHeader then mI := 0;
  If pBandType = rbPageFooter then mI := 1;
  If pBandType = rbTitle then mI := 2;
  If pBandType = rbDetail then mI := 3;
  If pBandType = rbSummary then mI := 4;
  If pBandType = rbGroupHeader then mI := 5;
  If pBandType = rbGroupFooter then mI := 6;
  If pBandType = rbColumnHeader then mI := 7;
  If cqMultiSelect then begin
    If oSpecCompData.rBandBandType<>mI then oSpecCompData.rBandBandType := -1;
  end else begin
    oSpecCompData.rBandBandType := mI;
  end;
end;

procedure TF_QRMain.SetMultiBandAlignToBottom (pAlignToBottom:boolean);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rBandAlignToBottomF then begin
      If oSpecCompData.rBandAlignToBottom<>pAlignToBottom then oSpecCompData.rBandAlignToBottomF := FALSE;
    end;
  end else begin
    oSpecCompData.rBandAlignToBottom := pAlignToBottom;
    oSpecCompData.rBandAlignToBottomF := TRUE;
  end;
end;

procedure TF_QRMain.SetMultiBandForceNewColumn (pForceNewColumn:boolean);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rBandForceNewColumnF then begin
      If oSpecCompData.rBandForceNewColumn<>pForceNewColumn then oSpecCompData.rBandForceNewColumnF := FALSE;
    end;
  end else begin
    oSpecCompData.rBandForceNewColumn := pForceNewColumn;
    oSpecCompData.rBandForceNewColumnF := TRUE;
  end;
end;

procedure TF_QRMain.SetMultiBandForceNewPage (pForceNewPage:boolean);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rBandForceNewPageF then begin
      If oSpecCompData.rBandForceNewPage<>pForceNewPage then oSpecCompData.rBandForceNewPageF := FALSE;
    end;
  end else begin
    oSpecCompData.rBandForceNewPage := pForceNewPage;
    oSpecCompData.rBandForceNewPageF := TRUE;
  end;
end;

procedure TF_QRMain.SetMultiBandLinkBand (pLinkBand:string);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rBandLinkBand<>pLinkBand then oSpecCompData.rBandLinkBand := '';
  end else begin
    oSpecCompData.rBandLinkBand := pLinkBand;
  end;
end;

procedure TF_QRMain.SetMultiChildBandParentBand (pParentBand:string);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rChildBandParentBand<>pParentBand then oSpecCompData.rChildBandParentBand := '';
  end else begin
    oSpecCompData.rChildBandParentBand := pParentBand;
  end;
end;

procedure TF_QRMain.SetMultiChildBandAlignToBottom (pAlignToBottom:boolean);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rChildBandAlignToBottomF then begin
      If oSpecCompData.rChildBandAlignToBottom<>pAlignToBottom then oSpecCompData.rChildBandAlignToBottomF := FALSE;
    end;
  end else begin
    oSpecCompData.rChildBandAlignToBottom := pAlignToBottom;
    oSpecCompData.rChildBandAlignToBottomF := TRUE;
  end;
end;

procedure TF_QRMain.SetMultiChildBandForceNewColumn (pForceNewColumn:boolean);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rChildBandForceNewColumnF then begin
      If oSpecCompData.rChildBandForceNewColumn<>pForceNewColumn then oSpecCompData.rChildBandForceNewColumnF := FALSE;
    end;
  end else begin
    oSpecCompData.rChildBandForceNewColumn := pForceNewColumn;
    oSpecCompData.rChildBandForceNewColumnF := TRUE;
  end;
end;

procedure TF_QRMain.SetMultiChildBandForceNewPage (pForceNewPage:boolean);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rChildBandForceNewPageF then begin
      If oSpecCompData.rChildBandForceNewPage<>pForceNewPage then oSpecCompData.rChildBandForceNewPageF := FALSE;
    end;
  end else begin
    oSpecCompData.rChildBandForceNewPage := pForceNewPage;
    oSpecCompData.rChildBandForceNewPageF := TRUE;
  end;
end;

procedure TF_QRMain.SetMultiChildBandLinkBand (pLinkBand:string);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rChildBandLinkBand<>pLinkBand then oSpecCompData.rChildBandLinkBand := '';
  end else begin
    oSpecCompData.rChildBandLinkBand := pLinkBand;
  end;
end;

procedure TF_QRMain.SetMultiSubDetailMaster (pMaster:string);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rSubDetailMaster<>pMaster then oSpecCompData.rSubDetailMaster := '';
  end else begin
    oSpecCompData.rSubDetailMaster := pMaster;
  end;
end;

procedure TF_QRMain.SetMultiSubDetailDataSet (pDataSet:string);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rSubDetailDataSet<>pDataSet then oSpecCompData.rSubDetailDataSet := '';
  end else begin
    oSpecCompData.rSubDetailDataSet := pDataSet;
  end;
end;

procedure TF_QRMain.SetMultiSubDeatilHeaderBand (pHeaderBand:string);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rSubDetailHeaderBand<>pHeaderBand then oSpecCompData.rSubDetailHeaderBand := '';
  end else begin
    oSpecCompData.rSubDetailHeaderBand := pHeaderBand;
  end;
end;

procedure TF_QRMain.SetMultiSubDetailFooterBand (pFooterBand:string);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rSubDetailFooterBand<>pFooterBand then oSpecCompData.rSubDetailFooterBand := '';
  end else begin
    oSpecCompData.rSubDetailFooterBand := pFooterBand;
  end;
end;

procedure TF_QRMain.SetMultiSubDetailAlignToBottom (pAlignToBottom:boolean);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rSubDetailAlignToBottomF then begin
      If oSpecCompData.rSubDetailAlignToBottom<>pAlignToBottom then oSpecCompData.rSubDetailAlignToBottomF := FALSE;
    end;
  end else begin
    oSpecCompData.rSubDetailAlignToBottom := pAlignToBottom;
    oSpecCompData.rSubDetailAlignToBottomF := TRUE;
  end;
end;

procedure TF_QRMain.SetMultiSubDetailForceNewColumn (pForceNewColumn:boolean);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rSubDetailForceNewColumnF then begin
      If oSpecCompData.rSubDetailForceNewColumn<>pForceNewColumn then oSpecCompData.rSubDetailForceNewColumnF := FALSE;
    end;
  end else begin
    oSpecCompData.rSubDetailForceNewColumn := pForceNewColumn;
    oSpecCompData.rSubDetailForceNewColumnF := TRUE;
  end;
end;

procedure TF_QRMain.SetMultiSubDetailForceNewPage (pForceNewPage:boolean);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rSubDetailForceNewPageF then begin
      If oSpecCompData.rSubDetailForceNewPage<>pForceNewPage then oSpecCompData.rSubDetailForceNewPageF := FALSE;
    end;
  end else begin
    oSpecCompData.rSubDetailForceNewPage := pForceNewPage;
    oSpecCompData.rSubDetailForceNewPageF := TRUE;
  end;
end;

procedure TF_QRMain.SetMultiSubDetailLinkBand (pLinkBand:string);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rSubDetailLinkBand<>pLinkBand then oSpecCompData.rSubDetailLinkBand := '';
  end else begin
    oSpecCompData.rSubDetailLinkBand := pLinkBand;
  end;
end;

procedure TF_QRMain.SetMultiSubDetailPrintBefore (pPrintBefore:boolean);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rSubDetailPrintBeforeF then begin
      If oSpecCompData.rSubDetailPrintBefore<>pPrintBefore then oSpecCompData.rSubDetailPrintBeforeF := FALSE;
    end;
  end else begin
    oSpecCompData.rSubDetailPrintBefore := pPrintBefore;
    oSpecCompData.rSubDetailPrintBeforeF := TRUE;
  end;
end;

procedure TF_QRMain.SetMultiSubDetailPrintIfEmpty (pPrintIfEmpty:boolean);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rSubDetailPrintIfEmptyF then begin
      If oSpecCompData.rSubDetailPrintIfEmpty<>pPrintIfEmpty then oSpecCompData.rSubDetailPrintIfEmptyF := FALSE;
    end;
  end else begin
    oSpecCompData.rSubDetailPrintIfEmpty := pPrintIfEmpty;
    oSpecCompData.rSubDetailPrintIfEmptyF := TRUE;
  end;
end;

procedure TF_QRMain.SetMultiGroupMaster (pMaster:string);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rGroupMaster<>pMaster then oSpecCompData.rGroupMaster := '';
  end else begin
    oSpecCompData.rGroupMaster := pMaster;
  end;
end;

procedure TF_QRMain.SetMultiGroupFooterBand (pFooterBand:string);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rGroupFooterBand<>pFooterBand then oSpecCompData.rGroupFooterBand := '';
  end else begin
    oSpecCompData.rGroupFooterBand := pFooterBand;
  end;
end;

procedure TF_QRMain.SetMultiGroupExpression (pExpression:string);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rGroupExpression<>pExpression then oSpecCompData.rGroupExpression := '';
  end else begin
    oSpecCompData.rGroupExpression := pExpression;
  end;
end;

procedure TF_QRMain.SetMultiGroupAlignToBottom (pAlignToBottom:boolean);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rGroupAlignToBottomF then begin
      If oSpecCompData.rGroupAlignToBottom<>pAlignToBottom then oSpecCompData.rGroupAlignToBottomF := FALSE;
    end;
  end else begin
    oSpecCompData.rGroupAlignToBottom := pAlignToBottom;
    oSpecCompData.rGroupAlignToBottomF := TRUE;
  end;
end;

procedure TF_QRMain.SetMultiGroupForceNewColumn (pForceNewColumn:boolean);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rGroupForceNewColumnF then begin
      If oSpecCompData.rGroupForceNewColumn<>pForceNewColumn then oSpecCompData.rGroupForceNewColumnF := FALSE;
    end;
  end else begin
    oSpecCompData.rGroupForceNewColumn := pForceNewColumn;
    oSpecCompData.rGroupForceNewColumnF := TRUE;
  end;
end;

procedure TF_QRMain.SetMultiGroupForceNewPage (pForceNewPage:boolean);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rGroupForceNewPageF then begin
      If oSpecCompData.rGroupForceNewPage<>pForceNewPage then oSpecCompData.rGroupForceNewPageF := FALSE;
    end;
  end else begin
    oSpecCompData.rGroupForceNewPage := pForceNewPage;
    oSpecCompData.rGroupForceNewPageF := TRUE;
  end;
end;

procedure TF_QRMain.SetMultiGroupLinkBand (pLinkBand:string);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rGroupLinkBand<>pLinkBand then oSpecCompData.rGroupLinkBand := '';
  end else begin
    oSpecCompData.rGroupLinkBand := pLinkBand;
  end;
end;

procedure TF_QRMain.SetMultiGroupReprintOnNewPage (pReprintOnNewPage:boolean);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rGroupReprintOnNewPageF then begin
      If oSpecCompData.rGroupReprintOnNewPage<>pReprintOnNewPage then oSpecCompData.rGroupReprintOnNewPageF := FALSE;
    end;
  end else begin
    oSpecCompData.rGroupReprintOnNewPage := pReprintOnNewPage;
    oSpecCompData.rGroupReprintOnNewPageF := TRUE;
  end;
end;

procedure TF_QRMain.SetMultiQuickRepDataSet (pDataSet:string);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rQuickRepDataSet<>pDataSet then oSpecCompData.rQuickRepDataSet := '';
  end else begin
    oSpecCompData.rQuickRepDataSet := pDataSet;
  end;
end;

procedure TF_QRMain.SetMultiQuickRepTopMargin (pTopMargin:double);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rQuickRepTopMargin<>StrDoub (pTopMargin,0,1) then oSpecCompData.rQuickRepTopMargin := '';
  end else begin
    oSpecCompData.rQuickRepTopMargin := StrDoub (pTopMargin,0,1);
  end;
end;

procedure TF_QRMain.SetMultiQuickRepBottomMargin (pBottomMargin:double);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rQuickRepBottomMargin<>StrDoub (pBottomMargin,0,1) then oSpecCompData.rQuickRepBottomMargin := '';
  end else begin
    oSpecCompData.rQuickRepBottomMargin := StrDoub (pBottomMargin,0,1);
  end;
end;

procedure TF_QRMain.SetMultiQuickRepLeftMargin (pLeftMargin:double);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rQuickRepLeftMargin<>StrDoub (pLeftMargin,0,1) then oSpecCompData.rQuickRepLeftMargin := '';
  end else begin
    oSpecCompData.rQuickRepLeftMargin := StrDoub (pLeftMargin,0,1);
  end;
end;

procedure TF_QRMain.SetMultiQuickRepRightMargin (pRightMargin:double);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rQuickRepRightMargin<>StrDoub (pRightMargin,0,1) then oSpecCompData.rQuickRepRightMargin := '';
  end else begin
    oSpecCompData.rQuickRepRightMargin := StrDoub (pRightMargin,0,1);
  end;
end;

procedure TF_QRMain.SetMultiQuickRepPaperSize (pPaperSize:TQRPaperSize);
var mI:longint;
begin
  mI:=0;
  If pPaperSize = A3 then mI := 0;
  If pPaperSize = A4 then mI := 1;
  If pPaperSize = A4Small then mI := 2;
  If pPaperSize = A5 then mI := 3;
  If pPaperSize = B4 then mI := 4;
  If pPaperSize = B5 then mI := 5;
  If pPaperSize = CSheet then mI := 6;
  If pPaperSize = Custom then mI := 7;
  If pPaperSize = Default then mI := 8;
  If pPaperSize = DSheet then mI := 9;
  If pPaperSize = Env10 then mI := 10;
  If pPaperSize = Env11 then mI := 11;
  If pPaperSize = Env12 then mI := 12;
  If pPaperSize = Env14 then mI := 13;
  If pPaperSize = Env9 then mI := 14;
  If pPaperSize = ESheet then mI := 15;
  If pPaperSize = Executive then mI := 16;
  If pPaperSize = Folio then mI := 17;
  If pPaperSize = Ledger then mI := 18;
  If pPaperSize = Legal then mI := 19;
  If pPaperSize = Letter then mI := 20;
  If pPaperSize = LetterSmall then mI := 21;
  If pPaperSize = Note then mI := 22;
  If pPaperSize = qr10x14 then mI := 23;
  If pPaperSize = qr11x17 then mI := 24;
  If pPaperSize = Quarto then mI := 25;
  If pPaperSize = Statement then mI := 26;
  If pPaperSize = Tabloid then mI := 27;
  If cqMultiSelect then begin
    If oSpecCompData.rQuickRepPaperSize<>mI then oSpecCompData.rQuickRepPaperSize := -1;
  end else begin
    oSpecCompData.rQuickRepPaperSize := mI;
  end;
end;

procedure TF_QRMain.SetMultiQuickRepColumns (pColumns:longint);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rQuickRepColumns<>StrInt (pColumns,0) then oSpecCompData.rQuickRepColumns := '';
  end else begin
    oSpecCompData.rQuickRepColumns := StrInt (pColumns,0);
  end;
end;

procedure TF_QRMain.SetMultiQuickRepColumnSpace (pColumnSpace:double);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rQuickRepColumnSpace<>StrDoub (pColumnSpace,0,1) then oSpecCompData.rQuickRepColumnSpace := '';
  end else begin
    oSpecCompData.rQuickRepColumnSpace := StrDoub (pColumnSpace,0,1)
  end;
end;

procedure TF_QRMain.SetMultiQuickRepPrintIfEmpty  (pPrintIfEmpty:boolean);
begin
  If cqMultiSelect then begin
    If oSpecCompData.rQuickRepPrintIfEmptyF then begin
      If oSpecCompData.rQuickRepPrintIfEmpty<>pPrintIfEmpty then oSpecCompData.rQuickRepPrintIfEmptyF := FALSE;
    end;
  end else begin
    oSpecCompData.rQuickRepPrintIfEmpty := pPrintIfEmpty;
    oSpecCompData.rQuickRepPrintIfEmptyF := TRUE;
  end;
end;

procedure TF_QRMain.MyPreview (Sender:TObject);
begin
  F_Preview.QP_Preview.QRPrinter := TQRPrinter(Sender);
  F_Preview.Show;
end;

procedure TF_QRMain.ConvObjToText (pSrc,pTrg:string);
var  mA,mB:TFileStream;
begin
  mA := TFileStream.Create (pSrc,fmOpenRead);
  mB := TFileStream.Create (pTrg,fmCreate);
  ObjectResourceToText (mA,mB);
  mB.Free;
  mA.Free;
end;

procedure TF_QRMain.ConvTextToObj (pSrc,pTrg:string);
var  mA,mB:TFileStream;
begin
  mA := TFileStream.Create (pSrc,fmOpenRead);
  mB := TFileStream.Create (pTrg,fmCreate);
  ObjectTextToResource (mA,mB);
  mB.Free;
  mA.Free;
end;

procedure TF_QRMain.E_FrameWidthExit(Sender: TObject);
begin
  SetCompFrameWidth (ValInt (E_FrameWidth.Text));
end;

procedure TF_QRMain.E_QRShapePenWidthExit(Sender: TObject);
begin
  SetCompShapePenWidth (ValInt (E_QRShapePenWidth.Text));
end;

procedure TF_QRMain.SB_QuickRepDescriptionClick(Sender: TObject);
begin
  F_Description.E_ReportTitle.Text := oQuickRep.ReportTitle;
  F_Description.M_Description.Clear;
  F_Description.M_Description.Lines.Assign (oQuickRep.Description);
  If F_Description.Execute then begin
    oQuickRep.ReportTitle := F_Description.E_ReportTitle.Text;
    oQuickRep.Description.Assign (F_Description.M_Description.Lines);
    F_QR.Caption := F_Description.E_ReportTitle.Text;
  end;
end;

procedure TF_QRMain.SB_QuickRepFunctionsClick(Sender: TObject);
var
  I:longint;
  mT:TextFile;
  mS:string;
  mExit:boolean;
begin
  F_Functions.SG_Functions.Cells[0,0] := 'Name';
  F_Functions.SG_Functions.Cells[1,0] := 'Expression';
  If oQuickRep.Functions.Count<2
    then F_Functions.SG_Functions.RowCount := 2
    else F_Functions.SG_Functions.RowCount := oQuickRep.Functions.Count+1;
  If oQuickRep.Functions.Count>0 then begin
    For I:=0 to oQuickRep.Functions.Count-1 do
      F_Functions.SG_Functions.Cells[0,I+1] := oQuickRep.Functions.Strings[I];
    WriteComponentResFile ('$$$.$$1',oQuickRep);
    ConvObjToText ('$$$.$$1','$$$.$$2');
    AssignFile (mT, '$$$.$$2');
    Reset (mT);
    mExit := FALSE;
    I := 0;
    Repeat
      ReadLn (mT, mS);
      If Pos ('Functions.DATA = (', mS)>0 then begin
        Repeat
          ReadLn (mT, mS);
          mExit := Pos (')',mS)=Length (mS);
          If mExit then Delete (mS, Length (mS), 1);
          mS := RemLeftSpaces (RemRightSpaces (mS));
          While Pos ('#39', mS)>0 do
            Delete (mS,Pos ('#39', mS), 3);
          While Pos (Chr (39), mS)>0 do
            Delete (mS,Pos (Chr (39), mS), 1);
          Inc (I);
          F_Functions.SG_Functions.Cells[1,I] := mS;
        until EOF (mT) or mExit;
      end;
    until EOF (mT) or mExit;
    CloseFile (mT);
    DeleteFile ('$$$.$$1');
    DeleteFile ('$$$.$$2');
  end;
  If F_Functions.Execute then begin
    oQuickRep.Functions.Clear;
    If F_Functions.SG_Functions.RowCount>1 then begin
      For I:=1 to F_Functions.SG_Functions.RowCount do
        oQuickRep.Functions.AddFunction (F_Functions.SG_Functions.Cells[0,I],F_Functions.SG_Functions.Cells[1,I]);
    end;
  end;
end;

procedure TF_QRMain.CB_LevelChange(Sender: TObject);
begin
  F_QR.Tag := ValInt (CB_Level.Items.Strings[CB_Level.ItemIndex]);
end;

procedure TF_QRMain.SB_QRNewSpecClick(Sender: TObject);
begin
  oShowing := FALSE;
  SB_QRNewClick(Sender);
  F_QR.Hide;
  F_QRNewSpec.CB_DataSet.Clear;
  F_QRNewSpec.CB_DataSet.Items.AddStrings (CB_QuickRepDataSet.Items);
  F_QRNewSpec.CB_DataModule.Items.AddStrings (CB_QRSubDetailDataModule.Items);
  If F_QRNewSpec.Execute then begin
    oQuickRep.Units := MM;
    oQuickRep.ReportTitle := F_QRNewSpec.E_RepName.Text;
    SetSpecTitleBand (Sender);
    SetSpecPageFooter (Sender);
    SetSpecItems (Sender);
  end;
  F_QR.Show;
  oShowing := TRUE;
end;

procedure TF_QRMain.CB_QRDBTextDataModuleChange(Sender: TObject);
begin
  FillDBTextDataSet;
end;

procedure TF_QRMain.CB_QRDBImageDataModuleChange(Sender: TObject);
begin
  FillDBImageDataSet;
end;

procedure TF_QRMain.CB_QRSubDetailDataModuleChange(Sender: TObject);
begin
  FillSubDetailDataSet;
end;

procedure TF_QRMain.CB_QuickRepDataModuleChange(Sender: TObject);
begin
  FillQuickRepDataSet;
end;

procedure TF_QRMain.SB_QRBarCodeClick(Sender: TObject);
begin
  SB_ArrowClick(Sender);
  SB_QRBarCode.Down := TRUE;
  If oButtFix then SB_QRBarCode.Flat := FALSE;
  oAddComp := 10;
end;

procedure TF_QRMain.SB_QRBarCodeClearZoneClick(Sender: TObject);
var mImage:TBitmap;
begin
  oSpecCompData.rBarCodeClearZone := not oSpecCompData.rBarCodeClearZone;
  If oSpecCompData.rBarCodeClearZone then SB_QRBarCodeClearZone.Tag := 0 else SB_QRBarCodeClearZone.Tag := 1;
  mImage := TBitmap.Create;
  IL_ClearZone.GetBitmap (SB_QRBarCodeClearZone.Tag,mImage);
  SB_QRBarCodeClearZone.Glyph.Assign (mImage);
  mImage.Free; mImage := nil;
  SB_QRBarCodeClearZone.Flat := TRUE;
  SetCompBarCodeClearZone (oSpecCompData.rBarCodeClearZone);
end;

procedure TF_QRMain.CB_QRBarCodeDataModuleChange(Sender: TObject);
begin
  FillBarCodeDataSet;
end;

procedure TF_QRMain.CB_QRBarCodeDataSetChange(Sender: TObject);
begin
  CB_QRBarCodeDataField.Items.Assign (FillFieldNames (CB_QRBarCodeDataSet.Text));
  SetCompBarCodeDataSet (CB_QRBarCodeDataSet.Text);
end;

procedure TF_QRMain.CB_QRBarCodeDataFieldChange(Sender: TObject);
begin
  SetCompBarCodeFieldName (CB_QRBarCodeDataField.Text);
end;

procedure TF_QRMain.E_QRBarCodeTextExit(Sender: TObject);
begin
  SetCompBarCodeText (E_QRBarCodeText.Text);
end;

procedure TF_QRMain.CB_QRBarCodeTypeChange(Sender: TObject);
begin
  SetCompBarCodeType (CB_QRBarCodeType.ItemIndex);
end;

procedure TF_QRMain.SB_QRChartStairsClick(Sender: TObject);
var mImage:TBitmap;
begin
  oSpecCompData.rChartStairs := not oSpecCompData.rChartStairs;
  If oSpecCompData.rChartStairs then SB_QRChartStairs.Tag := 1 else SB_QRChartStairs.Tag := 0;
  mImage := TBitmap.Create;
  IL_ChartStairs.GetBitmap (SB_QRChartStairs.Tag,mImage);
  SB_QRChartStairs.Glyph.Assign (mImage);
  mImage.Free; mImage := nil;
  SB_QRChartStairs.Flat := TRUE;
  SetCompChartStairs (oSpecCompData.rChartStairs);
end;

procedure TF_QRMain.CB_QRChartDataModuleChange(Sender: TObject);
begin
  FillChartDataSet;
end;

procedure TF_QRMain.CB_QRChartDataSetChange(Sender: TObject);
begin
  CB_QRChartXDataField.Items.Assign (FillFieldNames (CB_QRChartDataSet.Text));
  CB_QRChartYDataField.Items.Assign (FillFieldNames (CB_QRChartDataSet.Text));
  SetCompChartDataSet (CB_QRChartDataSet.Text);
end;

procedure TF_QRMain.CB_QRChartXDataFieldChange(Sender: TObject);
begin
  SetCompChartXFieldName (CB_QRChartXDataField.Text);
end;

procedure TF_QRMain.CB_QRChartYDataFieldChange(Sender: TObject);
begin
  SetCompChartYFieldName (CB_QRChartYDataField.Text);
end;

procedure TF_QRMain.ChB_ChartXDateTimeClick(Sender: TObject);
begin
  SetCompChartXDateTime (ChB_ChartXDateTime.Checked);
end;

procedure TF_QRMain.ChB_ChartYDateTimeClick(Sender: TObject);
begin
  SetCompChartYDateTime (ChB_ChartYDateTime.Checked);
end;

procedure TF_QRMain.CopyComponents;
var
  mI    : byte;
begin
  AssignFile(oCF,'copycomp.$$$');
  Rewrite(oCF);
  oCopyList.Clear;
  for mI:=0 to oCompList.Count-1 do begin
    oCopyList.Add(oCompList.Strings[mI]);
    ExportActCompParam(oCompList.Strings[mI]);
  end;
  CloseFile(oCF);
end;

procedure TF_QRMain.PasteComponents;
var
  mI    : byte;
  mx,my : integer;
begin
  If FileExists ('copycomp.$$$') then begin
    oCopyList.Clear;
    If F_QR.FindComponent (oCompList.Strings[0]) is TQRBand
      then oParentName:=oCompList.Strings[0]
      else oParentName:=(F_QR.FindComponent (oCompList.Strings[0]) as TControl).Parent.Name;
    AssignFile(oCF,'copycomp.$$$');
    Reset (oCF);
   readLn(oCF,oReadLine);
    while not EOF (oCF) do begin
      oOldCompName:=Copy(oReadLine,2,Length(oReadLine)-2);
      ReadLn(oCF,oReadLine);
      If oReadLine='QRLabel'          then PasteQRLabel
      else if oReadLine='QRDBText'    then PasteQRDBText
      else if oReadLine='QRExpr'      then PasteQRExpr
      else if oReadLine='QRSysData'   then PasteQRSysData
      else if oReadLine='QRMemo'      then PasteQRMemo
      else if oReadLine='QRShape'     then PasteQRShape
      else if oReadLine='QRImage'     then PasteQRImage
      else if oReadLine='QRDBImage'   then PasteQRDBImage
      else if oReadLine='QRChart'     then PasteQRChart
      else if oReadLine='QRBarCode'   then PasteQRBarCode;
      while not EOF (oCF) and (oReadLine[1]<>'[') do readLn(oCF,oReadLine)
    end;
    CloseFile(oCF);

    cqMultiSelect := TRUE;
    CB_CompName.Text := '';
    oCompList.Clear;
    oCompList.Add (oCopyList.Strings[0]);
    SetSelected (oCopyList.Strings[0],TRUE);
    CompRepaint (oCopyList.Strings[0]);
    CB_CompName.Text := oCopyList.Strings[0];
    SetActCompParam (TRUE);
    SetActCompImage;

    for mI:= 1 to oCopyList.Count-1 do begin
      cqMultiSelect := TRUE;
      oCompList.Add (oCopyList.Strings[mI]);
      SetSelected (oCopyList.Strings[mI],TRUE);
      CompRepaint (oCopyList.Strings[mI]);
      SetActCompParam (TRUE);
    end;
{
        For I:=1 to oCompList.Count do begin
          CompRepaint (oCompList.Strings[I-1]);
        end;
}
    oAddComp:=0
  end;
(*
  mX:=9999;mY:=9999;
  mSN:=(Sender as TControl).Name;
  for mI:=0 to oCopyList.Count-1 do begin
    mS:= oCopyList.Strings[mI];
    If F_QR.FindComponent (mS)<>nil then begin
      If mX>(F_QR.FindComponent (mS) as TControl).Left then mX:=(F_QR.FindComponent (mS) as TControl).Left;
      If mY>(F_QR.FindComponent (mS) as TControl).Top  then mY:=(F_QR.FindComponent (mS) as TControl).Top;
    end;
  end;
  If oAddComp=10 then AddBarCode (pName);
  *)
end;

procedure TF_QRMain.ExportActCompParam (pComp:string);
var
  I     : integer;
begin
  If F_QR.FindComponent (pComp)<>nil then begin
    Writeln(oCF,'['+pComp+']');
    If F_QR.FindComponent (pComp) is TIcQRLabel then begin
      Writeln(oCF,'QRLabel');
      Writeln(oCF,'LeftMM        = '+FloatToStr((F_QR.FindComponent (pComp) as TQRLabel).Size.Left));
      Writeln(oCF,'TopMM         = '+FloatToStr((F_QR.FindComponent (pComp) as TQRLabel).Size.Top));
      Writeln(oCF,'WidthMM       = '+FloatToStr((F_QR.FindComponent (pComp) as TQRLabel).Size.Width));
      Writeln(oCF,'HeightMM      = '+FloatToStr((F_QR.FindComponent (pComp) as TQRLabel).Size.Height));
      Writeln(oCF,'AutoSize      = '+BoolToStr((F_QR.FindComponent (pComp) as TQRLabel).AutoSize));
      Writeln(oCF,'WordWrap      = '+BoolToStr((F_QR.FindComponent (pComp) as TQRLabel).WordWrap));
      Writeln(oCF,'Transparent   = '+BoolToStr((F_QR.FindComponent (pComp) as TQRLabel).transparent));
      Writeln(oCF,'Caption       = '+(F_QR.FindComponent (pComp) as TQRLabel).Caption);
      Writeln(oCF,'Alignment     = '+IcConv.AlignmentToStr ((F_QR.FindComponent (pComp) as TQRLabel).Alignment));
      Writeln(oCF,'FontName      = '+(F_QR.FindComponent (pComp) as TQRLabel).Font.Name);
      Writeln(oCF,'FontSize      = '+IntToStr((F_QR.FindComponent (pComp) as TQRLabel).Font.Size));
      Writeln(oCF,'FontStyle     = '+FontStyleToStr((F_QR.FindComponent (pComp) as TQRLabel).Font.Style));
      Writeln(oCF,'FontColor     = '+ColorToString((F_QR.FindComponent (pComp) as TQRLabel).Font.Color));
      Writeln(oCF,'FontCharset   = '+IntToStr((F_QR.FindComponent (pComp) as TQRLabel).Font.Charset));
      Writeln(oCF,'FrameStyle    = '+FrameStyleToStr((F_QR.FindComponent (pComp) as TQRLabel).Frame.Style));
      Writeln(oCF,'FrameColor    = '+ColorToString((F_QR.FindComponent (pComp) as TQRLabel).Frame.Color));
      Writeln(oCF,'FrameWidth    = '+IntToStr((F_QR.FindComponent (pComp) as TQRLabel).Frame.Width));
      Writeln(oCF,'FrameDrawleft = '+BoolToStr((F_QR.FindComponent (pComp) as TQRLabel).Frame.DrawLeft));
      Writeln(oCF,'FrameDrawTop  = '+BoolToStr((F_QR.FindComponent (pComp) as TQRLabel).Frame.DrawTop));
      Writeln(oCF,'FrameDrawRight= '+BoolToStr((F_QR.FindComponent (pComp) as TQRLabel).Frame.DrawRight));
      Writeln(oCF,'FrameDrawBottom= '+BoolToStr((F_QR.FindComponent (pComp) as TQRLabel).Frame.DrawBottom));
      Writeln(oCF,'BkColor       = '+ColorToString((F_QR.FindComponent (pComp) as TQRLabel).Color));
    end;
    If F_QR.FindComponent (pComp) is TIcQRDBText then begin
      Writeln(oCF,'QRDBText');
      Writeln(oCF,'LeftMM        = '+FloatToStr((F_QR.FindComponent (pComp) as TQRDBText).Size.Left));
      Writeln(oCF,'TopMM         = '+FloatToStr((F_QR.FindComponent (pComp) as TQRDBText).Size.Top));
      Writeln(oCF,'WidthMM       = '+FloatToStr((F_QR.FindComponent (pComp) as TQRDBText).Size.Width));
      Writeln(oCF,'HeightMM      = '+FloatToStr((F_QR.FindComponent (pComp) as TQRDBText).Size.Height));
      Writeln(oCF,'AutoSize      = '+BoolToStr((F_QR.FindComponent (pComp) as TQRDBText).AutoSize));
      Writeln(oCF,'WordWrap      = '+BoolToStr((F_QR.FindComponent (pComp) as TQRDBText).WordWrap));
      Writeln(oCF,'Transparent   = '+BoolToStr((F_QR.FindComponent (pComp) as TQRDBText).transparent));
      Writeln(oCF,'Caption       = '+(F_QR.FindComponent (pComp) as TQRDBText).Caption);
      Writeln(oCF,'Alignment     = '+AlignmentToStr ((F_QR.FindComponent (pComp) as TQRDBText).Alignment));
      Writeln(oCF,'FontName      = '+(F_QR.FindComponent (pComp) as TQRDBText).Font.Name);
      Writeln(oCF,'FontSize      = '+IntToStr((F_QR.FindComponent (pComp) as TQRDBText).Font.Size));
      Writeln(oCF,'FontStyle     = '+FontStyleToStr((F_QR.FindComponent (pComp) as TQRDBText).Font.Style));
      Writeln(oCF,'FontColor     = '+ColorToString((F_QR.FindComponent (pComp) as TQRDBText).Font.Color));
      Writeln(oCF,'FontCharset   = '+IntToStr((F_QR.FindComponent (pComp) as TQRDBText).Font.Charset));
      Writeln(oCF,'FrameStyle    = '+FrameStyleToStr((F_QR.FindComponent (pComp) as TQRDBText).Frame.Style));
      Writeln(oCF,'FrameColor    = '+ColorToString((F_QR.FindComponent (pComp) as TQRDBText).Frame.Color));
      Writeln(oCF,'FrameWidth    = '+IntToStr((F_QR.FindComponent (pComp) as TQRDBText).Frame.Width));
      Writeln(oCF,'FrameDrawleft = '+BoolToStr((F_QR.FindComponent (pComp) as TQRDBText).Frame.DrawLeft));
      Writeln(oCF,'FrameDrawTop  = '+BoolToStr((F_QR.FindComponent (pComp) as TQRDBText).Frame.DrawTop));
      Writeln(oCF,'FrameDrawRight= '+BoolToStr((F_QR.FindComponent (pComp) as TQRDBText).Frame.DrawRight));
      Writeln(oCF,'FrameDrawBottom= '+BoolToStr((F_QR.FindComponent (pComp) as TQRDBText).Frame.DrawBottom));
      Writeln(oCF,'BkColor       = '+ColorToString((F_QR.FindComponent (pComp) as TQRDBText).Color));

      If (F_QR.FindComponent (pComp) as TQRDBText).DataSet<>nil then begin
        Writeln(oCF,'DataSet       = '+((F_QR.FindComponent (pComp) as TQRDBText).DataSet.Owner.Name+'.'+(F_QR.FindComponent (pComp) as TQRDBText).DataSet.Name));
        Writeln(oCF,'DataField     = '+((F_QR.FindComponent (pComp) as TQRDBText).DataField));
      end else begin
        Writeln(oCF,'DataSet       = ');
        Writeln(oCF,'DataField     = ');
      end;
      Writeln(oCF,'DBTextMask      = '+((F_QR.FindComponent (pComp) as TQRDBText).Mask));
    end;
    If F_QR.FindComponent (pComp) is TIcQRExpr then begin
      Writeln(oCF,'QRExpr');
      Writeln(oCF,'LeftMM        = '+FloatToStr((F_QR.FindComponent (pComp) as TQRExpr).Size.Left));
      Writeln(oCF,'TopMM         = '+FloatToStr((F_QR.FindComponent (pComp) as TQRExpr).Size.Top));
      Writeln(oCF,'WidthMM       = '+FloatToStr((F_QR.FindComponent (pComp) as TQRExpr).Size.Width));
      Writeln(oCF,'HeightMM      = '+FloatToStr((F_QR.FindComponent (pComp) as TQRExpr).Size.Height));
      Writeln(oCF,'AutoSize      = '+BoolToStr((F_QR.FindComponent (pComp) as TQRExpr).AutoSize));
      Writeln(oCF,'WordWrap      = '+BoolToStr((F_QR.FindComponent (pComp) as TQRExpr).WordWrap));
      Writeln(oCF,'Transparent   = '+BoolToStr((F_QR.FindComponent (pComp) as TQRExpr).transparent));
      Writeln(oCF,'Caption       = '+(F_QR.FindComponent (pComp) as TQRExpr).Caption);
      Writeln(oCF,'Alignment     = '+AlignmentToStr ((F_QR.FindComponent (pComp) as TQRExpr).Alignment));
      Writeln(oCF,'FontName      = '+(F_QR.FindComponent (pComp) as TQRExpr).Font.Name);
      Writeln(oCF,'FontSize      = '+IntToStr((F_QR.FindComponent (pComp) as TQRExpr).Font.Size));
      Writeln(oCF,'FontStyle     = '+FontStyleToStr((F_QR.FindComponent (pComp) as TQRExpr).Font.Style));
      Writeln(oCF,'FontColor     = '+ColorToString((F_QR.FindComponent (pComp) as TQRExpr).Font.Color));
      Writeln(oCF,'FontCharset   = '+IntToStr((F_QR.FindComponent (pComp) as TQRExpr).Font.Charset));
      Writeln(oCF,'FrameStyle    = '+FrameStyleToStr((F_QR.FindComponent (pComp) as TQRExpr).Frame.Style));
      Writeln(oCF,'FrameColor    = '+ColorToString((F_QR.FindComponent (pComp) as TQRExpr).Frame.Color));
      Writeln(oCF,'FrameWidth    = '+IntToStr((F_QR.FindComponent (pComp) as TQRExpr).Frame.Width));
      Writeln(oCF,'FrameDrawleft = '+BoolToStr((F_QR.FindComponent (pComp) as TQRExpr).Frame.DrawLeft));
      Writeln(oCF,'FrameDrawTop  = '+BoolToStr((F_QR.FindComponent (pComp) as TQRExpr).Frame.DrawTop));
      Writeln(oCF,'FrameDrawRight= '+BoolToStr((F_QR.FindComponent (pComp) as TQRExpr).Frame.DrawRight));
      Writeln(oCF,'FrameDrawBottom= '+BoolToStr((F_QR.FindComponent (pComp) as TQRExpr).Frame.DrawBottom));
      Writeln(oCF,'BkColor       = '+ColorToString((F_QR.FindComponent (pComp) as TQRExpr).Color));

      Writeln(oCF,'ExprExpression  = '+((F_QR.FindComponent (pComp) as TQRExpr).Expression));
      Writeln(oCF,'ExprMask        = '+((F_QR.FindComponent (pComp) as TQRExpr).Mask));
      If (F_QR.FindComponent (pComp) as TQRExpr).Master<>nil
        then Writeln(oCF,'ExprMaster      = '+((F_QR.FindComponent (pComp) as TQRExpr).Master.Name))
        else Writeln(oCF,'ExprMaster      = ');
      Writeln(oCF,'ExprResetAfterPrint = '+BoolToStr((F_QR.FindComponent (pComp) as TQRExpr).ResetAfterPrint));
    end;
    If F_QR.FindComponent (pComp) is TIcQRSysData then begin
      Writeln(oCF,'QRSysData');
      Writeln(oCF,'LeftMM        = '+FloatToStr((F_QR.FindComponent (pComp) as TQRSysData).Size.Left));
      Writeln(oCF,'TopMM         = '+FloatToStr((F_QR.FindComponent (pComp) as TQRSysData).Size.Top));
      Writeln(oCF,'WidthMM       = '+FloatToStr((F_QR.FindComponent (pComp) as TQRSysData).Size.Width));
      Writeln(oCF,'HeightMM      = '+FloatToStr((F_QR.FindComponent (pComp) as TQRSysData).Size.Height));
      Writeln(oCF,'AutoSize      = '+BoolToStr((F_QR.FindComponent (pComp) as TQRSysData).AutoSize));
      Writeln(oCF,'WordWrap      = '+BoolToStr((F_QR.FindComponent (pComp) as TQRSysData).WordWrap));
      Writeln(oCF,'Transparent   = '+BoolToStr((F_QR.FindComponent (pComp) as TQRSysData).transparent));
      Writeln(oCF,'Caption       = '+(F_QR.FindComponent (pComp) as TQRSysData).Caption);
      Writeln(oCF,'Alignment     = '+AlignmentToStr ((F_QR.FindComponent (pComp) as TQRSysData).Alignment));
      Writeln(oCF,'FontName      = '+(F_QR.FindComponent (pComp) as TQRSysData).Font.Name);
      Writeln(oCF,'FontSize      = '+IntToStr((F_QR.FindComponent (pComp) as TQRSysData).Font.Size));
      Writeln(oCF,'FontStyle     = '+FontStyleToStr((F_QR.FindComponent (pComp) as TQRSysData).Font.Style));
      Writeln(oCF,'FontColor     = '+ColorToString((F_QR.FindComponent (pComp) as TQRSysData).Font.Color));
      Writeln(oCF,'FontCharset   = '+IntToStr((F_QR.FindComponent (pComp) as TQRSysData).Font.Charset));
      Writeln(oCF,'FrameStyle    = '+FrameStyleToStr((F_QR.FindComponent (pComp) as TQRSysData).Frame.Style));
      Writeln(oCF,'FrameColor    = '+ColorToString((F_QR.FindComponent (pComp) as TQRSysData).Frame.Color));
      Writeln(oCF,'FrameWidth    = '+IntToStr((F_QR.FindComponent (pComp) as TQRSysData).Frame.Width));
      Writeln(oCF,'FrameDrawleft = '+BoolToStr((F_QR.FindComponent (pComp) as TQRSysData).Frame.DrawLeft));
      Writeln(oCF,'FrameDrawTop  = '+BoolToStr((F_QR.FindComponent (pComp) as TQRSysData).Frame.DrawTop));
      Writeln(oCF,'FrameDrawRight= '+BoolToStr((F_QR.FindComponent (pComp) as TQRSysData).Frame.DrawRight));
      Writeln(oCF,'FrameDrawBottom= '+BoolToStr((F_QR.FindComponent (pComp) as TQRSysData).Frame.DrawBottom));
      Writeln(oCF,'BkColor       = '+ColorToString((F_QR.FindComponent (pComp) as TQRSysData).Color));

      Writeln(oCF,'SysDataText   = '+((F_QR.FindComponent (pComp) as TQRSysData).Text));
      Writeln(oCF,'SysDataType   = '+SysDataTypeToStr((F_QR.FindComponent (pComp) as TQRSysData).Data));
    end;
    If F_QR.FindComponent (pComp) is TQRMemo then begin
      Writeln(oCF,'QRMemo');
      Writeln(oCF,'LeftMM        = '+FloatToStr((F_QR.FindComponent (pComp) as TQRMemo).Size.Left));
      Writeln(oCF,'TopMM         = '+FloatToStr((F_QR.FindComponent (pComp) as TQRMemo).Size.Top));
      Writeln(oCF,'WidthMM       = '+FloatToStr((F_QR.FindComponent (pComp) as TQRMemo).Size.Width));
      Writeln(oCF,'HeightMM      = '+FloatToStr((F_QR.FindComponent (pComp) as TQRMemo).Size.Height));
      Writeln(oCF,'AutoSize      = '+BoolToStr((F_QR.FindComponent (pComp) as TQRMemo).AutoSize));
      Writeln(oCF,'WordWrap      = '+BoolToStr((F_QR.FindComponent (pComp) as TQRMemo).WordWrap));
      Writeln(oCF,'Transparent   = '+BoolToStr((F_QR.FindComponent (pComp) as TQRMemo).transparent));
      Writeln(oCF,'Caption       = '+(F_QR.FindComponent (pComp) as TQRMemo).Caption);
      Writeln(oCF,'Alignment     = '+AlignmentToStr ((F_QR.FindComponent (pComp) as TQRMemo).Alignment));
      Writeln(oCF,'FontName      = '+(F_QR.FindComponent (pComp) as TQRMemo).Font.Name);
      Writeln(oCF,'FontSize      = '+IntToStr((F_QR.FindComponent (pComp) as TQRMemo).Font.Size));
      Writeln(oCF,'FontStyle     = '+FontStyleToStr((F_QR.FindComponent (pComp) as TQRMemo).Font.Style));
      Writeln(oCF,'FontColor     = '+ColorToString((F_QR.FindComponent (pComp) as TQRMemo).Font.Color));
      Writeln(oCF,'FontCharset   = '+IntToStr((F_QR.FindComponent (pComp) as TQRMemo).Font.Charset));
      Writeln(oCF,'FrameStyle    = '+FrameStyleToStr((F_QR.FindComponent (pComp) as TQRMemo).Frame.Style));
      Writeln(oCF,'FrameColor    = '+ColorToString((F_QR.FindComponent (pComp) as TQRMemo).Frame.Color));
      Writeln(oCF,'FrameWidth    = '+IntToStr((F_QR.FindComponent (pComp) as TQRMemo).Frame.Width));
      Writeln(oCF,'FrameDrawleft = '+BoolToStr((F_QR.FindComponent (pComp) as TQRMemo).Frame.DrawLeft));
      Writeln(oCF,'FrameDrawTop  = '+BoolToStr((F_QR.FindComponent (pComp) as TQRMemo).Frame.DrawTop));
      Writeln(oCF,'FrameDrawRight= '+BoolToStr((F_QR.FindComponent (pComp) as TQRMemo).Frame.DrawRight));
      Writeln(oCF,'FrameDrawBottom= '+BoolToStr((F_QR.FindComponent (pComp) as TQRMemo).Frame.DrawBottom));
      Writeln(oCF,'BkColor       = '+ColorToString((F_QR.FindComponent (pComp) as TQRMemo).Color));
    Writeln(oCF,'Left   = '+IntToStr((F_QR.FindComponent (pComp) as TControl).Left));
    Writeln(oCF,'Top    = '+IntToStr((F_QR.FindComponent (pComp) as TControl).Top));
    Writeln(oCF,'Width  = '+IntToStr((F_QR.FindComponent (pComp) as TControl).Width));
    Writeln(oCF,'Height = '+IntToStr((F_QR.FindComponent (pComp) as TControl).Height));

      for I:=0 to (F_QR.FindComponent (pComp) as TQRMemo).Lines.Count-1 do
        Writeln(oCF,'Line'+StrIntZero(I,2)+'       = '+(F_QR.FindComponent (pComp) as TQRMemo).Lines[I]);
    end;
    If F_QR.FindComponent (pComp) is TQRShape then begin
      Writeln(oCF,'QRShape');
      Writeln(oCF,'LeftMM        = '+FloatToStr((F_QR.FindComponent (pComp) as TQRshape).Size.Left));
      Writeln(oCF,'TopMM         = '+FloatToStr((F_QR.FindComponent (pComp) as TQRshape).Size.Top));
      Writeln(oCF,'WidthMM       = '+FloatToStr((F_QR.FindComponent (pComp) as TQRshape).Size.Width));
      Writeln(oCF,'HeightMM      = '+FloatToStr((F_QR.FindComponent (pComp) as TQRshape).Size.Height));
      Writeln(oCF,'FrameStyle    = '+FrameStyleToStr((F_QR.FindComponent (pComp) as TQRShape).Frame.Style));
      Writeln(oCF,'FrameColor    = '+ColorToString((F_QR.FindComponent (pComp) as TQRshape).Frame.Color));
      Writeln(oCF,'FrameWidth    = '+IntToStr((F_QR.FindComponent (pComp) as TQRshape).Frame.Width));
      Writeln(oCF,'FrameDrawleft = '+BoolToStr((F_QR.FindComponent (pComp) as TQRshape).Frame.DrawLeft));
      Writeln(oCF,'FrameDrawTop  = '+BoolToStr((F_QR.FindComponent (pComp) as TQRshape).Frame.DrawTop));
      Writeln(oCF,'FrameDrawRight= '+BoolToStr((F_QR.FindComponent (pComp) as TQRshape).Frame.DrawRight));
      Writeln(oCF,'FrameDrawBottom= '+BoolToStr((F_QR.FindComponent (pComp) as TQRshape).Frame.DrawBottom));

      Writeln(oCF,'BrushStyle    = '+BrushStyletoStr((F_QR.FindComponent (pComp) as TQRShape).Brush.Style));
      Writeln(oCF,'BrushColor    = '+ColorToString((F_QR.FindComponent (pComp) as TQRShape).Brush.Color));
      Writeln(oCF,'PenWidth      = '+IntToStr((F_QR.FindComponent (pComp) as TQRShape).Pen.Width));
      Writeln(oCF,'PenStyle      = '+PenStyleToStr((F_QR.FindComponent (pComp) as TQRShape).Pen.Style));
      Writeln(oCF,'PenColor      = '+ColorToString((F_QR.FindComponent (pComp) as TQRShape).Pen.Color));
      Writeln(oCF,'Shape         = '+ShapeTypeToStr((F_QR.FindComponent (pComp) as TQRShape).Shape));
    end;
    If F_QR.FindComponent (pComp) is TQRImage then begin
      Writeln(oCF,'QRImage');
      Writeln(oCF,'LeftMM        = '+FloatToStr((F_QR.FindComponent (pComp) as TQRImage).Size.Left));
      Writeln(oCF,'TopMM         = '+FloatToStr((F_QR.FindComponent (pComp) as TQRImage).Size.Top));
      Writeln(oCF,'WidthMM       = '+FloatToStr((F_QR.FindComponent (pComp) as TQRImage).Size.Width));
      Writeln(oCF,'HeightMM      = '+FloatToStr((F_QR.FindComponent (pComp) as TQRImage).Size.Height));
      Writeln(oCF,'AutoSize      = '+BoolToStr((F_QR.FindComponent (pComp) as TQRImage).AutoSize));
      Writeln(oCF,'FrameStyle    = '+FrameStyleToStr((F_QR.FindComponent (pComp) as TQRImage).Frame.Style));
      Writeln(oCF,'FrameColor    = '+ColorToString((F_QR.FindComponent (pComp) as TQRImage).Frame.Color));
      Writeln(oCF,'FrameWidth    = '+IntToStr((F_QR.FindComponent (pComp) as TQRImage).Frame.Width));
      Writeln(oCF,'FrameDrawleft = '+BoolToStr((F_QR.FindComponent (pComp) as TQRImage).Frame.DrawLeft));
      Writeln(oCF,'FrameDrawTop  = '+BoolToStr((F_QR.FindComponent (pComp) as TQRImage).Frame.DrawTop));
      Writeln(oCF,'FrameDrawRight= '+BoolToStr((F_QR.FindComponent (pComp) as TQRImage).Frame.DrawRight));
      Writeln(oCF,'FrameDrawBottom= '+BoolToStr((F_QR.FindComponent (pComp) as TQRImage).Frame.DrawBottom));

      Writeln(oCF,'Stretch       = '+BoolToStr((F_QR.FindComponent (pComp) as TQRImage).Stretch));
      Writeln(oCF,'Center        = '+BoolToStr((F_QR.FindComponent (pComp) as TQRImage).Center));
      (F_QR.FindComponent (pComp) as TQRImage).Picture.SaveToFile(pComp+'.BMP');
      Writeln(oCF,'Bitmap        = '+pComp+'.BMP');
    end;
    If F_QR.FindComponent (pComp) is TQRDBImage then begin
      Writeln(oCF,'QRDBImage');
      Writeln(oCF,'LeftMM        = '+FloatToStr((F_QR.FindComponent (pComp) as TQRDBImage).Size.Left));
      Writeln(oCF,'TopMM         = '+FloatToStr((F_QR.FindComponent (pComp) as TQRDBImage).Size.Top));
      Writeln(oCF,'WidthMM       = '+FloatToStr((F_QR.FindComponent (pComp) as TQRDBImage).Size.Width));
      Writeln(oCF,'HeightMM      = '+FloatToStr((F_QR.FindComponent (pComp) as TQRDBImage).Size.Height));
      Writeln(oCF,'AutoSize      = 0');
      Writeln(oCF,'FrameStyle    = '+FrameStyleToStr((F_QR.FindComponent (pComp) as TQRDBImage).Frame.Style));
      Writeln(oCF,'FrameColor    = '+ColorToString((F_QR.FindComponent (pComp) as TQRDBImage).Frame.Color));
      Writeln(oCF,'FrameWidth    = '+IntToStr((F_QR.FindComponent (pComp) as TQRDBImage).Frame.Width));
      Writeln(oCF,'FrameDrawleft = '+BoolToStr((F_QR.FindComponent (pComp) as TQRDBImage).Frame.DrawLeft));
      Writeln(oCF,'FrameDrawTop  = '+BoolToStr((F_QR.FindComponent (pComp) as TQRDBImage).Frame.DrawTop));
      Writeln(oCF,'FrameDrawRight= '+BoolToStr((F_QR.FindComponent (pComp) as TQRDBImage).Frame.DrawRight));
      Writeln(oCF,'FrameDrawBottom= '+BoolToStr((F_QR.FindComponent (pComp) as TQRDBImage).Frame.DrawBottom));
      Writeln(oCF,'Stretch       = '+BoolToStr((F_QR.FindComponent (pComp) as TQRDBImage).Stretch));
      Writeln(oCF,'Center        = '+BoolToStr((F_QR.FindComponent (pComp) as TQRDBImage).Center));
      (F_QR.FindComponent (pComp) as TQRDBImage).Picture.SaveToFile(pComp+'.BMP');
      Writeln(oCF,'Bitmap        = '+pComp+'.BMP');

      If (F_QR.FindComponent (pComp) as TQRDBImage).DataSet<>nil then begin
        Writeln(oCF,'DataSet       = '+((F_QR.FindComponent (pComp) as TQRDBImage).DataSet.Owner.Name+'.'+(F_QR.FindComponent (pComp) as TQRDBImage).DataSet.Name));
        Writeln(oCF,'DataField     = '+((F_QR.FindComponent (pComp) as TQRDBImage).DataField));
      end else begin
        Writeln(oCF,'DataSet       = ');
        Writeln(oCF,'DataField     = ');
      end;
    end;
    If F_QR.FindComponent (pComp) is TQRChart then begin
      Writeln(oCF,'QRChart');
      Writeln(oCF,'LeftMM        = '+FloatToStr((F_QR.FindComponent (pComp) as TQRChart).Size.Left));
      Writeln(oCF,'TopMM         = '+FloatToStr((F_QR.FindComponent (pComp) as TQRChart).Size.Top));
      Writeln(oCF,'WidthMM       = '+FloatToStr((F_QR.FindComponent (pComp) as TQRChart).Size.Width));
      Writeln(oCF,'HeightMM      = '+FloatToStr((F_QR.FindComponent (pComp) as TQRChart).Size.Height));
      Writeln(oCF,'FrameStyle    = '+FrameStyleToStr((F_QR.FindComponent (pComp) as TQRChart).Frame.Style));
      Writeln(oCF,'FrameColor    = '+ColorToString((F_QR.FindComponent (pComp) as TQRChart).Frame.Color));
      Writeln(oCF,'FrameWidth    = '+IntToStr((F_QR.FindComponent (pComp) as TQRChart).Frame.Width));
      Writeln(oCF,'FrameDrawleft = '+BoolToStr((F_QR.FindComponent (pComp) as TQRChart).Frame.DrawLeft));
      Writeln(oCF,'FrameDrawTop  = '+BoolToStr((F_QR.FindComponent (pComp) as TQRChart).Frame.DrawTop));
      Writeln(oCF,'FrameDrawRight= '+BoolToStr((F_QR.FindComponent (pComp) as TQRChart).Frame.DrawRight));
      Writeln(oCF,'FrameDrawBottom= '+BoolToStr((F_QR.FindComponent (pComp) as TQRChart).Frame.DrawBottom));


      Writeln(oCF,'ChartStairs   = '+BoolToStr(((F_QR.FindComponent (pComp) as TQRChart).Chart.Series[0] as TAreaSeries).Stairs));
      Writeln(oCF,'ChartXDateTime= '+BoolToStr(((F_QR.FindComponent (pComp) as TQRChart).Chart.Series[0] as TAreaSeries).XValues.DateTime));
      Writeln(oCF,'ChartYDateTime= '+BoolToStr(((F_QR.FindComponent (pComp) as TQRChart).Chart.Series[0] as TAreaSeries).YValues.DateTime));

      If ((F_QR.FindComponent (pComp) as TQRChart).Chart.Series[0] as TAreaSeries).DataSource<>nil then begin
        Writeln(oCF,'ChartDataSet   = '+(((F_QR.FindComponent (pComp) as TQRChart).Chart.Series[0] as TAreaSeries).DataSource.Owner.Name+'.'+((F_QR.FindComponent (pComp) as TQRChart).Chart.Series[0] as TAreaSeries).DataSource.Name));
        Writeln(oCF,'ChartXDataField= '+(((F_QR.FindComponent (pComp) as TQRChart).Chart.Series[0] as TAreaSeries).XValues.ValueSource));
        Writeln(oCF,'ChartYDataField= '+(((F_QR.FindComponent (pComp) as TQRChart).Chart.Series[0] as TAreaSeries).YValues.ValueSource));
      end else begin
        Writeln(oCF,'ChartDataSet   = ');
        Writeln(oCF,'ChartXDataField= ');
        Writeln(oCF,'ChartYDataField= ');
      end;
    end;
    If F_QR.FindComponent (pComp) is TQRBarCode then begin
      Writeln(oCF,'QRBarCode');
      Writeln(oCF,'LeftMM        = '+FloatToStr((F_QR.FindComponent (pComp) as TQRBarCode).Size.Left));
      Writeln(oCF,'TopMM         = '+FloatToStr((F_QR.FindComponent (pComp) as TQRBarCode).Size.Top));
      Writeln(oCF,'WidthMM       = '+FloatToStr((F_QR.FindComponent (pComp) as TQRBarCode).Size.Width));
      Writeln(oCF,'HeightMM      = '+FloatToStr((F_QR.FindComponent (pComp) as TQRBarCode).Size.Height));
      Writeln(oCF,'FrameStyle    = '+FrameStyleToStr((F_QR.FindComponent (pComp) as TQRBarCode).Frame.Style));
      Writeln(oCF,'FrameColor    = '+ColorToString((F_QR.FindComponent (pComp) as TQRBarCode).Frame.Color));
      Writeln(oCF,'FrameWidth    = '+IntToStr((F_QR.FindComponent (pComp) as TQRBarCode).Frame.Width));
      Writeln(oCF,'FrameDrawleft = '+BoolToStr((F_QR.FindComponent (pComp) as TQRBarCode).Frame.DrawLeft));
      Writeln(oCF,'FrameDrawTop  = '+BoolToStr((F_QR.FindComponent (pComp) as TQRBarCode).Frame.DrawTop));
      Writeln(oCF,'FrameDrawRight= '+BoolToStr((F_QR.FindComponent (pComp) as TQRBarCode).Frame.DrawRight));
      Writeln(oCF,'FrameDrawBottom= '+BoolToStr((F_QR.FindComponent (pComp) as TQRBarCode).Frame.DrawBottom));

      Writeln(oCF,'BarCodeType   = '+BarCodeTypeToStr((F_QR.FindComponent (pComp) as TQRBarCode).BarCodeType));
      Writeln(oCF,'BarCodeText   = '+((F_QR.FindComponent (pComp) as TQRBarCode).Text));
      Writeln(oCF,'BarCodeClearZone= '+BoolToStr((F_QR.FindComponent (pComp) as TQRBarCode).ClearZone));

      If (F_QR.FindComponent (pComp) as TQRBarCode).DataSet<>nil then begin
        Writeln(oCF,'BarCodeDataSet  = '+((F_QR.FindComponent (pComp) as TQRBarCode).DataSet.Owner.Name+'.'+(F_QR.FindComponent (pComp) as TQRBarCode).DataSet.Name));
        Writeln(oCF,'BarCodeDataField= '+((F_QR.FindComponent (pComp) as TQRBarCode).DataField));
      end else begin
        Writeln(oCF,'BarCodeDataSet  = ');
        Writeln(oCF,'BarCodeDataField= ');
      end;
    end;
    Writeln(oCF,'Left   = '+IntToStr((F_QR.FindComponent (pComp) as TControl).Left));
    Writeln(oCF,'Top    = '+IntToStr((F_QR.FindComponent (pComp) as TControl).Top));
    Writeln(oCF,'Width  = '+IntToStr((F_QR.FindComponent (pComp) as TControl).Width));
    Writeln(oCF,'Height = '+IntToStr((F_QR.FindComponent (pComp) as TControl).Height));
  end; // F_QR.FindComponent (pComp)<>nil
end;

procedure TF_QRMain.PasteQRLabel;
var
  mS      : string;
  mI      : byte;
begin
  oChange := TRUE;
  mS:='|';
  for mI :=1 to cLabelLineCount do begin
    ReadLn (oCF,oReadLine);
    mS:=mS+Copy(oReadLine,Pos('=',oReadLine)+1,Length(oReadLine)-Pos('=',oReadLine))+'|';
  end;
  while POS('| ',mS)>0 do Delete(mS,Pos('| ',mS)+1,1);
  oXC := StrToInt(LineElement(mS,cLabelLineCount-3,'|'))+10; // left
  oYC := StrToInt(LineElement(mS,cLabelLineCount-2,'|'))+10; // top
  oAddComp:=1;
  AddLabel (oParentName);
  oCopyList.Add(oCompList.Strings[0]);
  // ColorTo
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRLabel).Size.Left       := StrToFloat      (LineElement(mS, 1,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRLabel).Size.Top        := StrToFloat      (LineElement(mS, 2,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRLabel).Size.Width      := StrToFloat      (LineElement(mS, 3,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRLabel).Size.Height     := StrToFloat      (LineElement(mS, 4,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRLabel).AutoSize        := StrToBool       (LineElement(mS, 5,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRLabel).WordWrap        := StrToBool       (LineElement(mS, 6,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRLabel).transparent     := StrToBool       (LineElement(mS, 7,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRLabel).Caption         :=                  LineElement(mS, 8,'|');
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRLabel).Alignment       := StrToAlignment  (LineElement(mS, 9,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRLabel).Font.Name       :=                  LineElement(mS,10,'|');
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRLabel).Font.Size       := StrToInt        (LineElement(mS,11,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRLabel).Font.Style      := StrToFontStyle  (LineElement(mS,12,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRLabel).Font.Color      := StringToColor   (LineElement(mS,13,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRLabel).Font.Charset    := StrToInt        (LineElement(mS,14,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRLabel).Frame.Style     := StrToFrameStyle (LineElement(mS,15,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRLabel).Frame.Color     := StringToColor   (LineElement(mS,16,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRLabel).Frame.Width     := StrToInt        (LineElement(mS,17,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRLabel).Frame.DrawLeft  := StrToBool       (LineElement(mS,18,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRLabel).Frame.DrawTop   := StrToBool       (LineElement(mS,19,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRLabel).Frame.DrawRight := StrToBool       (LineElement(mS,20,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRLabel).Frame.DrawBottom:= StrToBool       (LineElement(mS,21,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRLabel).Color           := StringToColor   (LineElement(mS,22,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRLabel).Left            := StrToInt        (LineElement(mS,23,'|'))+10;
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRLabel).Top             := StrToInt        (LineElement(mS,24,'|'))+10;
  ReadLn (oCF,oReadLine);
  FillCompNames;
  FillXYList;
end;

procedure TF_QRMain.PasteQRDBText;
var
  mS,mAct : string;
  mI      : byte;
  mComp   : TObject;
begin
  oChange := TRUE;
  mS:='|';
  for mI :=1 to cDBTextLineCount do begin
    ReadLn (oCF,oReadLine);
    mS:=mS+Copy(oReadLine,Pos('=',oReadLine)+1,Length(oReadLine)-Pos('=',oReadLine))+'|';
  end;
  while POS('| ',mS)>0 do Delete(mS,Pos('| ',mS)+1,1);
  oXC := StrToInt(LineElement(mS,cDBTextLineCount-3,'|'))+10; // left
  oYC := StrToInt(LineElement(mS,cDBTextLineCount-2,'|'))+10; // top
  oAddComp:=2;
  AddDBText (oParentName);
  oCopyList.Add(oCompList.Strings[0]);
  // ColorTo
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBText).Size.Left       := StrToFloat      (LineElement(mS, 1,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBText).Size.Top        := StrToFloat      (LineElement(mS, 2,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBText).Size.Width      := StrToFloat      (LineElement(mS, 3,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBText).Size.Height     := StrToFloat      (LineElement(mS, 4,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBText).AutoSize        := StrToBool       (LineElement(mS, 5,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBText).WordWrap        := StrToBool       (LineElement(mS, 6,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBText).transparent     := StrToBool       (LineElement(mS, 7,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBText).Caption         :=                  LineElement(mS, 8,'|');
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBText).Alignment       := StrToAlignment  (LineElement(mS, 9,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBText).Font.Name       :=                  LineElement(mS,10,'|');
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBText).Font.Size       := StrToInt        (LineElement(mS,11,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBText).Font.Style      := StrToFontStyle  (LineElement(mS,12,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBText).Font.Color      := StringToColor   (LineElement(mS,13,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBText).Font.Charset    := StrToInt        (LineElement(mS,14,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBText).Frame.Style     := StrToFrameStyle (LineElement(mS,15,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBText).Frame.Color     := StringToColor   (LineElement(mS,16,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBText).Frame.Width     := StrToInt        (LineElement(mS,17,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBText).Frame.DrawLeft  := StrToBool       (LineElement(mS,18,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBText).Frame.DrawTop   := StrToBool       (LineElement(mS,19,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBText).Frame.DrawRight := StrToBool       (LineElement(mS,20,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBText).Frame.DrawBottom:= StrToBool       (LineElement(mS,21,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBText).Color           := StringToColor   (LineElement(mS,22,'|'));
  mAct:=LineElement(mS,23,'|');
  mComp := GetTableObj (mAct);
  If mComp is TDataSet then begin
    try
     (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBText).DataSet := mComp as TDataSet;
     mAct:=LineElement(mS,24,'|');
     (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBText).DataField       := mAct;
    except end;
  end;
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBText).Mask            :=                  LineElement(mS,25,'|');
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBText).Left            := StrToInt        (LineElement(mS,26,'|'))+10;
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBText).Top             := StrToInt        (LineElement(mS,27,'|'))+10;
  ReadLn (oCF,oReadLine);
  FillCompNames;
  FillXYList;
end;

procedure TF_QRMain.PasteQRExpr;
var
  mS,mAct : string;
  mI      : byte;
  mComp   : TObject;
begin
  oChange := TRUE;
  mS:='|';
  for mI :=1 to cExprLineCount do begin
    ReadLn (oCF,oReadLine);
    mS:=mS+Copy(oReadLine,Pos('=',oReadLine)+1,Length(oReadLine)-Pos('=',oReadLine))+'|';
  end;
  while POS('| ',mS)>0 do Delete(mS,Pos('| ',mS)+1,1);
  oXC := StrToInt(LineElement(mS,cExprLineCount-3,'|'))+10; // left
  oYC := StrToInt(LineElement(mS,cExprLineCount-2,'|'))+10; // top
  oAddComp:=3;
  AddExpr (oParentName);
  oCopyList.Add(oCompList.Strings[0]);
  // ColorTo
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRExpr).Size.Left       := StrToFloat      (LineElement(mS, 1,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRExpr).Size.Top        := StrToFloat      (LineElement(mS, 2,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRExpr).Size.Width      := StrToFloat      (LineElement(mS, 3,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRExpr).Size.Height     := StrToFloat      (LineElement(mS, 4,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRExpr).AutoSize        := StrToBool       (LineElement(mS, 5,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRExpr).WordWrap        := StrToBool       (LineElement(mS, 6,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRExpr).transparent     := StrToBool       (LineElement(mS, 7,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRExpr).Caption         :=                  LineElement(mS, 8,'|');
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRExpr).Alignment       := StrToAlignment  (LineElement(mS, 9,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRExpr).Font.Name       :=                  LineElement(mS,10,'|');
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRExpr).Font.Size       := StrToInt        (LineElement(mS,11,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRExpr).Font.Style      := StrToFontStyle  (LineElement(mS,12,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRExpr).Font.Color      := StringToColor   (LineElement(mS,13,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRExpr).Font.Charset    := StrToInt        (LineElement(mS,14,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRExpr).Frame.Style     := StrToFrameStyle (LineElement(mS,15,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRExpr).Frame.Color     := StringToColor   (LineElement(mS,16,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRExpr).Frame.Width     := StrToInt        (LineElement(mS,17,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRExpr).Frame.DrawLeft  := StrToBool       (LineElement(mS,18,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRExpr).Frame.DrawTop   := StrToBool       (LineElement(mS,19,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRExpr).Frame.DrawRight := StrToBool       (LineElement(mS,20,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRExpr).Frame.DrawBottom:= StrToBool       (LineElement(mS,21,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRExpr).Color           := StringToColor   (LineElement(mS,22,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRExpr).Expression      :=                  LineElement(mS,23,'|');
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRExpr).Mask            :=                  LineElement(mS,24,'|');
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRExpr).Master          := F_QR.FindComponent (LineElement(mS,25,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRExpr).ResetAfterPrint:= StrToBool        (LineElement(mS,26,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRExpr).Left            := StrToInt        (LineElement(mS,27,'|'))+10;
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRExpr).Top             := StrToInt        (LineElement(mS,28,'|'))+10;
  ReadLn (oCF,oReadLine);
  FillCompNames;
  FillXYList;
end;

procedure TF_QRMain.PasteQRSysData;
var
  mS,mAct : string;
  mI      : byte;
  mComp   : TObject;
begin
  oChange := TRUE;
  mS:='|';
  for mI :=1 to cSysDataLineCount do begin
    ReadLn (oCF,oReadLine);
    mS:=mS+Copy(oReadLine,Pos('=',oReadLine)+1,Length(oReadLine)-Pos('=',oReadLine))+'|';
  end;
  while POS('| ',mS)>0 do Delete(mS,Pos('| ',mS)+1,1);
  oXC := StrToInt(LineElement(mS,cSysDataLineCount-3,'|'))+10; // left
  oYC := StrToInt(LineElement(mS,cSysDataLineCount-2,'|'))+10; // top
  oAddComp:=4;
  AddSysData (oParentName);
  oCopyList.Add(oCompList.Strings[0]);
  // ColorTo
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRSysData).Size.Left       := StrToFloat      (LineElement(mS, 1,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRSysData).Size.Top        := StrToFloat      (LineElement(mS, 2,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRSysData).Size.Width      := StrToFloat      (LineElement(mS, 3,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRSysData).Size.Height     := StrToFloat      (LineElement(mS, 4,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRSysData).AutoSize        := StrToBool       (LineElement(mS, 5,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRSysData).WordWrap        := StrToBool       (LineElement(mS, 6,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRSysData).transparent     := StrToBool       (LineElement(mS, 7,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRSysData).Caption         :=                  LineElement(mS, 8,'|');
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRSysData).Alignment       := StrToAlignment  (LineElement(mS, 9,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRSysData).Font.Name       :=                  LineElement(mS,10,'|');
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRSysData).Font.Size       := StrToInt        (LineElement(mS,11,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRSysData).Font.Style      := StrToFontStyle  (LineElement(mS,12,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRSysData).Font.Color      := StringToColor   (LineElement(mS,13,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRSysData).Font.Charset    := StrToInt        (LineElement(mS,14,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRSysData).Frame.Style     := StrToFrameStyle (LineElement(mS,15,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRSysData).Frame.Color     := StringToColor   (LineElement(mS,16,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRSysData).Frame.Width     := StrToInt        (LineElement(mS,17,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRSysData).Frame.DrawLeft  := StrToBool       (LineElement(mS,18,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRSysData).Frame.DrawTop   := StrToBool       (LineElement(mS,19,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRSysData).Frame.DrawRight := StrToBool       (LineElement(mS,20,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRSysData).Frame.DrawBottom:= StrToBool       (LineElement(mS,21,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRSysData).Color           := StringToColor   (LineElement(mS,22,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRSysData).Text            := LineElement(mS,23,'|');
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRSysData).Data            := StrToSysDataType(LineElement(mS,24,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRSysData).Left            := StrToInt        (LineElement(mS,25,'|'))+10;
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRSysData).Top             := StrToInt        (LineElement(mS,26,'|'))+10;
  ReadLn (oCF,oReadLine);
  FillCompNames;
  FillXYList;
end;

procedure TF_QRMain.PasteQRMemo;
var
  mS,mAct : string;
  mI      : byte;
  mComp   : TObject;
begin
  oChange := TRUE;
  mS:='|';
  for mI :=1 to cMemoLineCount do begin
    ReadLn (oCF,oReadLine);
    mS:=mS+Copy(oReadLine,Pos('=',oReadLine)+1,Length(oReadLine)-Pos('=',oReadLine))+'|';
  end;
  while POS('| ',mS)>0 do Delete(mS,Pos('| ',mS)+1,1);
  oXC := StrToInt(LineElement(mS,cMemoLineCount-3,'|'))+10; // left
  oYC := StrToInt(LineElement(mS,cMemoLineCount-2,'|'))+10; // top
  oAddComp:=5;
  AddMemo (oParentName);
  oCopyList.Add(oCompList.Strings[0]);
  // ColorTo
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRMemo).Size.Left       := StrToFloat      (LineElement(mS, 1,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRMemo).Size.Top        := StrToFloat      (LineElement(mS, 2,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRMemo).Size.Width      := StrToFloat      (LineElement(mS, 3,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRMemo).Size.Height     := StrToFloat      (LineElement(mS, 4,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRMemo).AutoSize        := StrToBool       (LineElement(mS, 5,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRMemo).WordWrap        := StrToBool       (LineElement(mS, 6,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRMemo).transparent     := StrToBool       (LineElement(mS, 7,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRMemo).Caption         :=                  LineElement(mS, 8,'|');
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRMemo).Alignment       := StrToAlignment  (LineElement(mS, 9,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRMemo).Font.Name       :=                  LineElement(mS,10,'|');
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRMemo).Font.Size       := StrToInt        (LineElement(mS,11,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRMemo).Font.Style      := StrToFontStyle  (LineElement(mS,12,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRMemo).Font.Color      := StringToColor   (LineElement(mS,13,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRMemo).Font.Charset    := StrToInt        (LineElement(mS,14,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRMemo).Frame.Style     := StrToFrameStyle (LineElement(mS,15,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRMemo).Frame.Color     := StringToColor   (LineElement(mS,16,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRMemo).Frame.Width     := StrToInt        (LineElement(mS,17,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRMemo).Frame.DrawLeft  := StrToBool       (LineElement(mS,18,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRMemo).Frame.DrawTop   := StrToBool       (LineElement(mS,19,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRMemo).Frame.DrawRight := StrToBool       (LineElement(mS,20,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRMemo).Frame.DrawBottom:= StrToBool       (LineElement(mS,21,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRMemo).Color           := StringToColor   (LineElement(mS,22,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRMemo).Left            := StrToInt        (LineElement(mS,23,'|'))+10;
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRMemo).Top             := StrToInt        (LineElement(mS,24,'|'))+10;
  ReadLn (oCF,oReadLine);
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRMemo).Lines.Clear;
  while not EOF (oCF) and (Pos('Line',oReadLine)=1) do begin
    (F_QR.FindComponent (oCompList.Strings[0]) as TQRMemo).Lines.Add(LineElement(oReadLine,1,'='));
    ReadLn (oCF,oReadLine);
  end;
  ReadLn (oCF,oReadLine);
  ReadLn (oCF,oReadLine);
  ReadLn (oCF,oReadLine);
  ReadLn (oCF,oReadLine);
  FillCompNames;
  FillXYList;
end;

procedure TF_QRMain.PasteQRShape;
var
  mS      : string;
  mI      : byte;
begin
  oChange := TRUE;
  mS:='|';
  for mI :=1 to cShapeLineCount do begin
    ReadLn (oCF,oReadLine);
    mS:=mS+Copy(oReadLine,Pos('=',oReadLine)+1,Length(oReadLine)-Pos('=',oReadLine))+'|';
  end;
  while POS('| ',mS)>0 do Delete(mS,Pos('| ',mS)+1,1);
  oXC := StrToInt(LineElement(mS,cShapeLineCount-3,'|'))+10; // left
  oYC := StrToInt(LineElement(mS,cShapeLineCount-2,'|'))+10; // top
  oAddComp:=6;
  AddShape (oParentName);
  oCopyList.Add(oCompList.Strings[0]);
  // ColorTo
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRShape).Size.Left       := StrToFloat      (LineElement(mS, 1,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRShape).Size.Top        := StrToFloat      (LineElement(mS, 2,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRShape).Size.Width      := StrToFloat      (LineElement(mS, 3,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRShape).Size.Height     := StrToFloat      (LineElement(mS, 4,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRShape).Frame.Style     := StrToFrameStyle (LineElement(mS, 5,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRShape).Frame.Color     := StringToColor   (LineElement(mS, 6,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRShape).Frame.Width     := StrToInt        (LineElement(mS, 7,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRShape).Frame.DrawLeft  := StrToBool       (LineElement(mS, 8,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRShape).Frame.DrawTop   := StrToBool       (LineElement(mS, 9,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRShape).Frame.DrawRight := StrToBool       (LineElement(mS,10,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRShape).Frame.DrawBottom:= StrToBool       (LineElement(mS,11,'|'));

  (F_QR.FindComponent (oCompList.Strings[0]) as TQRShape).Brush.Style     := StrToBrushStyle (LineElement(mS,12,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRShape).Brush.Color     := StringToColor   (LineElement(mS,13,'|'));

  (F_QR.FindComponent (oCompList.Strings[0]) as TQRShape).Pen.Width       := StrToInt        (LineElement(mS,14,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRShape).Pen.Style       := StrToPenStyle   (LineElement(mS,15,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRShape).Pen.Color       := StringToColor   (LineElement(mS,16,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRShape).Shape           := StrToShapeType      (LineElement(mS,17,'|'));

  (F_QR.FindComponent (oCompList.Strings[0]) as TQRShape).Left            := StrToInt        (LineElement(mS,18,'|'))+10;
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRShape).Top             := StrToInt        (LineElement(mS,19,'|'))+10;
  ReadLn (oCF,oReadLine);
  FillCompNames;
  FillXYList;
end;

procedure TF_QRMain.PasteQRImage;
var
  mS      : string;
  mI      : byte;
begin
  oChange := TRUE;
  mS:='|';
  for mI :=1 to cImageLineCount do begin
    ReadLn (oCF,oReadLine);
    mS:=mS+Copy(oReadLine,Pos('=',oReadLine)+1,Length(oReadLine)-Pos('=',oReadLine))+'|';
  end;
  while POS('| ',mS)>0 do Delete(mS,Pos('| ',mS)+1,1);
  oXC := StrToInt(LineElement(mS,cImageLineCount-3,'|'))+10; // left
  oYC := StrToInt(LineElement(mS,cImageLineCount-2,'|'))+10; // top
  oAddComp:=7;
  AddImage (oParentName);
  oCopyList.Add(oCompList.Strings[0]);
  // ColorTo
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRImage).Size.Left       := StrToFloat      (LineElement(mS, 1,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRImage).Size.Top        := StrToFloat      (LineElement(mS, 2,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRImage).Size.Width      := StrToFloat      (LineElement(mS, 3,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRImage).Size.Height     := StrToFloat      (LineElement(mS, 4,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRImage).AutoSize        := StrToBool       (LineElement(mS, 5,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRImage).Frame.Style     := StrToFrameStyle (LineElement(mS, 6,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRImage).Frame.Color     := StringToColor   (LineElement(mS, 7,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRImage).Frame.Width     := StrToInt        (LineElement(mS, 8,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRImage).Frame.DrawLeft  := StrToBool       (LineElement(mS, 9,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRImage).Frame.DrawTop   := StrToBool       (LineElement(mS,10,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRImage).Frame.DrawRight := StrToBool       (LineElement(mS,11,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRImage).Frame.DrawBottom:= StrToBool       (LineElement(mS,12,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRImage).Stretch         := StrToBool       (LineElement(mS,13,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRImage).Center          := StrToBool       (LineElement(mS,14,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRImage).Picture.LoadFromFile (LineElement(mS,15,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRImage).Left            := StrToInt        (LineElement(mS,16,'|'))+10;
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRImage).Top             := StrToInt        (LineElement(mS,17,'|'))+10;
  ReadLn (oCF,oReadLine);
  FillCompNames;
  FillXYList;
end;

procedure TF_QRMain.PasteQRDBImage;
var
  mS,mAct : string;
  mI      : byte;
  mComp   : TObject;
begin
  oChange := TRUE;
  mS:='|';
  for mI :=1 to cDBImageLineCount do begin
    ReadLn (oCF,oReadLine);
    mS:=mS+Copy(oReadLine,Pos('=',oReadLine)+1,Length(oReadLine)-Pos('=',oReadLine))+'|';
  end;
  while POS('| ',mS)>0 do Delete(mS,Pos('| ',mS)+1,1);
  oXC := StrToInt(LineElement(mS,cDBImageLineCount-3,'|'))+10; // left
  oYC := StrToInt(LineElement(mS,cDBImageLineCount-2,'|'))+10; // top
  oAddComp:=8;
  AddDBImage (oParentName);
  oCopyList.Add(oCompList.Strings[0]);
  // ColorTo
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBImage).Size.Left       := StrToFloat      (LineElement(mS, 1,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBImage).Size.Top        := StrToFloat      (LineElement(mS, 2,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBImage).Size.Width      := StrToFloat      (LineElement(mS, 3,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBImage).Size.Height     := StrToFloat      (LineElement(mS, 4,'|'));
{  (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBImage).AutoSize        := StrToBool       (LineElement(mS, 5,'|'));}
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBImage).Frame.Style     := StrToFrameStyle (LineElement(mS, 6,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBImage).Frame.Color     := StringToColor   (LineElement(mS, 7,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBImage).Frame.Width     := StrToInt        (LineElement(mS, 8,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBImage).Frame.DrawLeft  := StrToBool       (LineElement(mS, 9,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBImage).Frame.DrawTop   := StrToBool       (LineElement(mS,10,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBImage).Frame.DrawRight := StrToBool       (LineElement(mS,11,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBImage).Frame.DrawBottom:= StrToBool       (LineElement(mS,12,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBImage).Stretch         := StrToBool       (LineElement(mS,13,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBImage).Center          := StrToBool       (LineElement(mS,14,'|'));
{  (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBImage).Picture.LoadFromFile (LineElement(mS,15,'|'));}
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBImage).Left            := StrToInt        (LineElement(mS,18,'|'))+10;
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBImage).Top             := StrToInt        (LineElement(mS,19,'|'))+10;

  mAct:=LineElement(mS,16,'|');
  mComp := GetTableObj (mAct);
  If mComp is TDataSet then begin
    try
     (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBImage).DataSet := mComp as TDataSet;
     mAct:=LineElement(mS,17,'|');
     (F_QR.FindComponent (oCompList.Strings[0]) as TQRDBImage).DataField       :=  mAct;
    except end;
  end;
  ReadLn (oCF,oReadLine);
  FillCompNames;
  FillXYList;
end;

procedure TF_QRMain.PasteQRChart;
var
  mS,mAct : string;
  mI      : byte;
  mComp   : TObject;
begin
  oChange := TRUE;
  mS:='|';
  for mI :=1 to cChartLineCount do begin
    ReadLn (oCF,oReadLine);
    mS:=mS+Copy(oReadLine,Pos('=',oReadLine)+1,Length(oReadLine)-Pos('=',oReadLine))+'|';
  end;
  while POS('| ',mS)>0 do Delete(mS,Pos('| ',mS)+1,1);
  oXC := StrToInt(LineElement(mS,cChartLineCount-3,'|'))+10; // left
  oYC := StrToInt(LineElement(mS,cChartLineCount-2,'|'))+10; // top
  oAddComp:=9;
  AddChart (oParentName);
  oCopyList.Add(oCompList.Strings[0]);
  // ColorTo

  (F_QR.FindComponent (oCompList.Strings[0]) as TQRChart).Size.Left       := StrToFloat      (LineElement(mS, 1,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRChart).Size.Top        := StrToFloat      (LineElement(mS, 2,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRChart).Size.Width      := StrToFloat      (LineElement(mS, 3,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRChart).Size.Height     := StrToFloat      (LineElement(mS, 4,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRChart).Frame.Style     := StrToFrameStyle (LineElement(mS, 5,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRChart).Frame.Color     := StringToColor   (LineElement(mS, 6,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRChart).Frame.Width     := StrToInt        (LineElement(mS, 7,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRChart).Frame.DrawLeft  := StrToBool       (LineElement(mS, 8,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRChart).Frame.DrawTop   := StrToBool       (LineElement(mS, 9,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRChart).Frame.DrawRight := StrToBool       (LineElement(mS,10,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRChart).Frame.DrawBottom:= StrToBool       (LineElement(mS,11,'|'));

 ((F_QR.FindComponent (oCompList.Strings[0]) as TQRChart).Chart.Series[0] as TAreaSeries).Stairs           := StrToBool       (LineElement(mS,12,'|'));
 ((F_QR.FindComponent (oCompList.Strings[0]) as TQRChart).Chart.Series[0] as TAreaSeries).XValues.DateTime := StrToBool       (LineElement(mS,13,'|'));
 ((F_QR.FindComponent (oCompList.Strings[0]) as TQRChart).Chart.Series[0] as TAreaSeries).YValues.DateTime := StrToBool       (LineElement(mS,14,'|'));

  mAct:=LineElement(mS,15,'|');
  mComp := GetTableObj (mAct);
  If mComp is TDataSet then begin
    try
     ((F_QR.FindComponent (oCompList.Strings[0]) as TQRChart).Chart.Series[0] as TAreaSeries).DataSource := mComp as TDataSet;
     mAct:=LineElement(mS,16,'|');
     ((F_QR.FindComponent (oCompList.Strings[0]) as TQRChart).Chart.Series[0] as TAreaSeries).XValues.ValueSource      := mAct;
     mAct:=LineElement(mS,17,'|');
     ((F_QR.FindComponent (oCompList.Strings[0]) as TQRChart).Chart.Series[0] as TAreaSeries).YValues.ValueSource      := mAct;
    except end;
  end;
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRChart).Left            := StrToInt        (LineElement(mS,18,'|'))+10;
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRChart).Top             := StrToInt        (LineElement(mS,19,'|'))+10;
  ReadLn (oCF,oReadLine);
  FillCompNames;
  FillXYList;
end;

procedure TF_QRMain.PasteQRBarCode;
var
  mS,mAct : string;
  mI      : byte;
  mComp   : TObject;
begin
  oChange := TRUE;
  mS:='|';
  for mI :=1 to cBarCodeLineCount do begin
    ReadLn (oCF,oReadLine);
    mS:=mS+Copy(oReadLine,Pos('=',oReadLine)+1,Length(oReadLine)-Pos('=',oReadLine))+'|';
  end;
  while POS('| ',mS)>0 do Delete(mS,Pos('| ',mS)+1,1);
  oXC := StrToInt(LineElement(mS,cBarCodeLineCount-3,'|'))+10; // left
  oYC := StrToInt(LineElement(mS,cBarCodeLineCount-2,'|'))+10; // top
  oAddComp:=2;
  AddBarCode (oParentName);
  oCopyList.Add(oCompList.Strings[0]);
  // ColorTo
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRBarCode).Size.Left       := StrToFloat      (LineElement(mS, 1,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRBarCode).Size.Top        := StrToFloat      (LineElement(mS, 2,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRBarCode).Size.Width      := StrToFloat      (LineElement(mS, 3,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRBarCode).Size.Height     := StrToFloat      (LineElement(mS, 4,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRBarCode).Frame.Style     := StrToFrameStyle (LineElement(mS, 5,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRBarCode).Frame.Color     := StringToColor   (LineElement(mS, 6,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRBarCode).Frame.Width     := StrToInt        (LineElement(mS, 7,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRBarCode).Frame.DrawLeft  := StrToBool       (LineElement(mS, 8,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRBarCode).Frame.DrawTop   := StrToBool       (LineElement(mS, 9,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRBarCode).Frame.DrawRight := StrToBool       (LineElement(mS,10,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRBarCode).Frame.DrawBottom:= StrToBool       (LineElement(mS,11,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRBarCode).BarCodeType     := StrToBarCodeType(LineElement(mS,12,'|'));
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRBarCode).Text            :=                  LineElement(mS,13,'|');
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRBarCode).ClearZone       := StrToBool       (LineElement(mS,14,'|'));


  mAct:=LineElement(mS,15,'|');
  mComp := GetTableObj (mAct);
  If mComp is TDataSet then begin
    try
     (F_QR.FindComponent (oCompList.Strings[0]) as TQRBarCode).DataSet := mComp as TDataSet;
     mAct:=LineElement(mS,16,'|');
     (F_QR.FindComponent (oCompList.Strings[0]) as TQRBarCode).DataField       := mAct;
    except end;
  end;
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRBarCode).Left            := StrToInt        (LineElement(mS,17,'|'))+10;
  (F_QR.FindComponent (oCompList.Strings[0]) as TQRBarCode).Top             := StrToInt        (LineElement(mS,18,'|'))+10;
  ReadLn (oCF,oReadLine);
  FillCompNames;
  FillXYList;
end;

end.
