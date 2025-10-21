unit QuickRep;

interface

uses
  BARQR5, QRTee, Graphics,Classes, QuickRpt, Qrctrls;

const
  cqMultiSelect:boolean = FALSE;

type
  TIcQuickRep = class(TQuickRep)
  private
    oSelected :boolean;
  public
    procedure  Paint; override;
  published
    property Selected:boolean read oSelected write oSelected default FALSE;
    property OnMouseMove;
    property OnMouseDown;
    property OnMouseUp;
    property OnClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property Canvas;
  end;

  TIcQRSubDetail = class(TQRSubDetail)
  private
    oSelected :boolean;
  public
    procedure  Paint; override;
  published
    property Selected:boolean read oSelected write oSelected default FALSE;
    property OnMouseMove;
    property OnMouseDown;
    property OnMouseUp;
    property OnClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property Canvas;
  end;

  TIcQRBand = class(TQRBand)
  private
    oSelected :boolean;
  public
    procedure  Paint; override;
  published
    property Selected:boolean read oSelected write oSelected default FALSE;
    property OnMouseMove;
    property OnMouseDown;
    property OnMouseUp;
    property OnClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property Canvas;
  end;

  TIcQRChildBand = class(TQRChildBand)
  private
    oSelected :boolean;
  public
    procedure  Paint; override;
  published
    property Selected:boolean read oSelected write oSelected default FALSE;
    property OnMouseMove;
    property OnMouseDown;
    property OnMouseUp;
    property OnClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property Canvas;
  end;

  TIcQRGroup = class(TQRGroup)
  private
    oSelected :boolean;
  public
    procedure  Paint; override;
  published
    property Selected:boolean read oSelected write oSelected default FALSE;
    property OnMouseMove;
    property OnMouseDown;
    property OnMouseUp;
    property OnClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property Canvas;
  end;

  TIcQRLabel = class(TQRLabel)
  private
    oSelected :boolean;
  public
    procedure  Paint; override;
  published
    property Selected:boolean read oSelected write oSelected default FALSE;
    property OnMouseMove;
    property OnMouseDown;
    property OnMouseUp;
    property OnClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
  end;

  TIcQRDBText = class(TQRDBText)
  private
    oSelected :boolean;
  public
    procedure  Paint; override;
  published
    property Selected:boolean read oSelected write oSelected default FALSE;
    property OnMouseMove;
    property OnMouseDown;
    property OnMouseUp;
    property OnClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
  end;

  TIcQRExpr = class(TQRExpr)
  private
    oSelected :boolean;
  public
    procedure  Paint; override;
  published
    property Selected:boolean read oSelected write oSelected default FALSE;
    property OnMouseMove;
    property OnMouseDown;
    property OnMouseUp;
    property OnClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
  end;

  TIcQRSysData = class(TQRSysData)
  private
    oSelected :boolean;
  public
    procedure  Paint; override;
  published
    property Selected:boolean read oSelected write oSelected default FALSE;
    property OnMouseMove;
    property OnMouseDown;
    property OnMouseUp;
    property OnClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
  end;

  TIcQRMemo = class(TQRMemo)
  private
    oSelected :boolean;
  public
    procedure  Paint; override;
  published
    property Selected:boolean read oSelected write oSelected default FALSE;
    property OnMouseMove;
    property OnMouseDown;
    property OnMouseUp;
    property OnClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
  end;

  TIcQRShape = class(TQRShape)
  private
    oSelected :boolean;
  public
    procedure  Paint; override;
  published
    property Selected:boolean read oSelected write oSelected default FALSE;
    property OnMouseMove;
    property OnMouseDown;
    property OnMouseUp;
    property OnClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
  end;

  TIcQRImage = class(TQRImage)
  private
    oSelected :boolean;
  public
    procedure  Paint; override;
  published
    property Selected:boolean read oSelected write oSelected default FALSE;
    property OnMouseMove;
    property OnMouseDown;
    property OnMouseUp;
    property OnClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
  end;

  TIcQRDBImage = class(TQRDBImage)
  private
    oSelected :boolean;
  public
    procedure  Paint; override;
  published
    property Selected:boolean read oSelected write oSelected default FALSE;
    property OnMouseMove;
    property OnMouseDown;
    property OnMouseUp;
    property OnClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
  end;

  TIcQRChart = class(TQRChart)
  private
    oSelected :boolean;
  public
    procedure  Paint; override;
  published
    property Selected:boolean read oSelected write oSelected default FALSE;
    property OnMouseMove;
    property OnMouseDown;
    property OnMouseUp;
    property OnClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
  end;

  TIcQRBarCode = class(TQRBarCode)
  private
    oSelected :boolean;
  public
    procedure  Paint; override;
  published
    property Selected:boolean read oSelected write oSelected default FALSE;
    property OnMouseMove;
    property OnMouseDown;
    property OnMouseUp;
    property OnClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('IcQuickRep', [TIcQuickRep]);
  RegisterComponents('IcQuickRep', [TIcQRSubDetail]);
  RegisterComponents('IcQuickRep', [TIcQRBand]);
  RegisterComponents('IcQuickRep', [TIcQRChildBand]);
  RegisterComponents('IcQuickRep', [TIcQRGroup]);
  RegisterComponents('IcQuickRep', [TIcQRLabel]);
  RegisterComponents('IcQuickRep', [TIcQRDBText]);
  RegisterComponents('IcQuickRep', [TIcQRExpr]);
  RegisterComponents('IcQuickRep', [TIcQRSysData]);
  RegisterComponents('IcQuickRep', [TIcQRMemo]);
  RegisterComponents('IcQuickRep', [TIcQRShape]);
  RegisterComponents('IcQuickRep', [TIcQRImage]);
  RegisterComponents('IcQuickRep', [TIcQRDBImage]);
  RegisterComponents('IcQuickRep', [TIcQRChart]);
  RegisterComponents('IcQuickRep', [TIcQRBarCode]);
end;

procedure TIcQuickRep.Paint;
begin
  inherited;
  If Selected then begin
    If cqMultiSelect then begin
      Canvas.Brush.Color := clGray;
    end else begin
      Canvas.Brush.Color := clBlack;
      Canvas.FillRect(Rect((Width div 2)-2,0,(Width div 2)+3,5));
      Canvas.FillRect(Rect((Width div 2)-2,Height-5,(Width div 2)+3,Height));
      Canvas.FillRect(Rect(0,(Height div 2)-2,5,(Height div 2)+3));
      Canvas.FillRect(Rect(Width-5,(Height div 2)-2,Width,(Height div 2)+3));
    end;
    Canvas.FillRect(Rect(0,0,5,5));
    Canvas.FillRect(Rect(0,Height-5,5,Height));
    Canvas.FillRect(Rect(Width-5,0,Width,5));
    Canvas.FillRect(Rect(Width-5,Height-5,Width,Height));
  end;
end;

procedure TIcQRSubDetail.Paint;
begin
  inherited;
  If Selected then begin
    If cqMultiSelect then begin
      Canvas.Brush.Color := clGray;
    end else begin
      Canvas.Brush.Color := clBlack;
      Canvas.FillRect(Rect((Width div 2)-2,0,(Width div 2)+3,5));
      Canvas.FillRect(Rect((Width div 2)-2,Height-5,(Width div 2)+3,Height));
      Canvas.FillRect(Rect(0,(Height div 2)-2,5,(Height div 2)+3));
      Canvas.FillRect(Rect(Width-5,(Height div 2)-2,Width,(Height div 2)+3));
    end;
    Canvas.FillRect(Rect(0,0,5,5));
    Canvas.FillRect(Rect(0,Height-5,5,Height));
    Canvas.FillRect(Rect(Width-5,0,Width,5));
    Canvas.FillRect(Rect(Width-5,Height-5,Width,Height));
  end;
end;

procedure TIcQRBand.Paint;
begin
  inherited;
  If Selected then begin
    If cqMultiSelect then begin
      Canvas.Brush.Color := clGray;
    end else begin
      Canvas.Brush.Color := clBlack;
      Canvas.FillRect(Rect((Width div 2)-2,0,(Width div 2)+3,5));
      Canvas.FillRect(Rect((Width div 2)-2,Height-5,(Width div 2)+3,Height));
      Canvas.FillRect(Rect(0,(Height div 2)-2,5,(Height div 2)+3));
      Canvas.FillRect(Rect(Width-5,(Height div 2)-2,Width,(Height div 2)+3));
    end;
    Canvas.FillRect(Rect(0,0,5,5));
    Canvas.FillRect(Rect(0,Height-5,5,Height));
    Canvas.FillRect(Rect(Width-5,0,Width,5));
    Canvas.FillRect(Rect(Width-5,Height-5,Width,Height));
  end;
end;

procedure TIcQRChildBand.Paint;
begin
  inherited;
  If Selected then begin
    If cqMultiSelect then begin
      Canvas.Brush.Color := clGray;
    end else begin
      Canvas.Brush.Color := clBlack;
      Canvas.FillRect(Rect((Width div 2)-2,0,(Width div 2)+3,5));
      Canvas.FillRect(Rect((Width div 2)-2,Height-5,(Width div 2)+3,Height));
      Canvas.FillRect(Rect(0,(Height div 2)-2,5,(Height div 2)+3));
      Canvas.FillRect(Rect(Width-5,(Height div 2)-2,Width,(Height div 2)+3));
    end;
    Canvas.FillRect(Rect(0,0,5,5));
    Canvas.FillRect(Rect(0,Height-5,5,Height));
    Canvas.FillRect(Rect(Width-5,0,Width,5));
    Canvas.FillRect(Rect(Width-5,Height-5,Width,Height));
  end;
end;

procedure TIcQRGroup.Paint;
begin
  inherited;
  If Selected then begin
    If cqMultiSelect then begin
      Canvas.Brush.Color := clGray;
    end else begin
      Canvas.Brush.Color := clBlack;
      Canvas.FillRect(Rect((Width div 2)-2,0,(Width div 2)+3,5));
      Canvas.FillRect(Rect((Width div 2)-2,Height-5,(Width div 2)+3,Height));
      Canvas.FillRect(Rect(0,(Height div 2)-2,5,(Height div 2)+3));
      Canvas.FillRect(Rect(Width-5,(Height div 2)-2,Width,(Height div 2)+3));
    end;
    Canvas.FillRect(Rect(0,0,5,5));
    Canvas.FillRect(Rect(0,Height-5,5,Height));
    Canvas.FillRect(Rect(Width-5,0,Width,5));
    Canvas.FillRect(Rect(Width-5,Height-5,Width,Height));
  end;
end;

procedure TIcQRLabel.Paint;
begin
  inherited;
  If Selected then begin
    If cqMultiSelect then begin
      Canvas.Brush.Color := clGray;
    end else begin
      Canvas.Brush.Color := clBlack;
      Canvas.FillRect(Rect((Width div 2)-2,0,(Width div 2)+3,5));
      Canvas.FillRect(Rect((Width div 2)-2,Height-5,(Width div 2)+3,Height));
      Canvas.FillRect(Rect(0,(Height div 2)-2,5,(Height div 2)+3));
      Canvas.FillRect(Rect(Width-5,(Height div 2)-2,Width,(Height div 2)+3));
    end;
    Canvas.FillRect(Rect(0,0,5,5));
    Canvas.FillRect(Rect(0,Height-5,5,Height));
    Canvas.FillRect(Rect(Width-5,0,Width,5));
    Canvas.FillRect(Rect(Width-5,Height-5,Width,Height));
  end;
end;

procedure TIcQRDBText.Paint;
begin
  inherited;
  If Selected then begin
    If cqMultiSelect then begin
      Canvas.Brush.Color := clGray;
    end else begin
      Canvas.Brush.Color := clBlack;
      Canvas.FillRect(Rect((Width div 2)-2,0,(Width div 2)+3,5));
      Canvas.FillRect(Rect((Width div 2)-2,Height-5,(Width div 2)+3,Height));
      Canvas.FillRect(Rect(0,(Height div 2)-2,5,(Height div 2)+3));
      Canvas.FillRect(Rect(Width-5,(Height div 2)-2,Width,(Height div 2)+3));
    end;
    Canvas.FillRect(Rect(0,0,5,5));
    Canvas.FillRect(Rect(0,Height-5,5,Height));
    Canvas.FillRect(Rect(Width-5,0,Width,5));
    Canvas.FillRect(Rect(Width-5,Height-5,Width,Height));
  end;
end;

procedure TIcQRExpr.Paint;
begin
  inherited;
  If Selected then begin
    If cqMultiSelect then begin
      Canvas.Brush.Color := clGray;
    end else begin
      Canvas.Brush.Color := clBlack;
      Canvas.FillRect(Rect((Width div 2)-2,0,(Width div 2)+3,5));
      Canvas.FillRect(Rect((Width div 2)-2,Height-5,(Width div 2)+3,Height));
      Canvas.FillRect(Rect(0,(Height div 2)-2,5,(Height div 2)+3));
      Canvas.FillRect(Rect(Width-5,(Height div 2)-2,Width,(Height div 2)+3));
    end;
    Canvas.FillRect(Rect(0,0,5,5));
    Canvas.FillRect(Rect(0,Height-5,5,Height));
    Canvas.FillRect(Rect(Width-5,0,Width,5));
    Canvas.FillRect(Rect(Width-5,Height-5,Width,Height));
  end;
end;

procedure TIcQRSysData.Paint;
begin
  inherited;
  If Selected then begin
    If cqMultiSelect then begin
      Canvas.Brush.Color := clGray;
    end else begin
      Canvas.Brush.Color := clBlack;
      Canvas.FillRect(Rect((Width div 2)-2,0,(Width div 2)+3,5));
      Canvas.FillRect(Rect((Width div 2)-2,Height-5,(Width div 2)+3,Height));
      Canvas.FillRect(Rect(0,(Height div 2)-2,5,(Height div 2)+3));
      Canvas.FillRect(Rect(Width-5,(Height div 2)-2,Width,(Height div 2)+3));
    end;
    Canvas.FillRect(Rect(0,0,5,5));
    Canvas.FillRect(Rect(0,Height-5,5,Height));
    Canvas.FillRect(Rect(Width-5,0,Width,5));
    Canvas.FillRect(Rect(Width-5,Height-5,Width,Height));
  end;
end;

procedure TIcQRMemo.Paint;
begin
  inherited;
  If Selected then begin
    If cqMultiSelect then begin
      Canvas.Brush.Color := clGray;
    end else begin
      Canvas.Brush.Color := clBlack;
      Canvas.FillRect(Rect((Width div 2)-2,0,(Width div 2)+3,5));
      Canvas.FillRect(Rect((Width div 2)-2,Height-5,(Width div 2)+3,Height));
      Canvas.FillRect(Rect(0,(Height div 2)-2,5,(Height div 2)+3));
      Canvas.FillRect(Rect(Width-5,(Height div 2)-2,Width,(Height div 2)+3));
    end;
    Canvas.FillRect(Rect(0,0,5,5));
    Canvas.FillRect(Rect(0,Height-5,5,Height));
    Canvas.FillRect(Rect(Width-5,0,Width,5));
    Canvas.FillRect(Rect(Width-5,Height-5,Width,Height));
  end;
end;

procedure TIcQRShape.Paint;
begin
  inherited;
  If Selected then begin
    Canvas.Brush.Style := bsSolid;
    If cqMultiSelect then begin
      Canvas.Brush.Color := clGray;
    end else begin
      Canvas.Brush.Color := clBlack;
      Canvas.FillRect(Rect((Width div 2)-2,0,(Width div 2)+3,5));
      Canvas.FillRect(Rect((Width div 2)-2,Height-5,(Width div 2)+3,Height));
      Canvas.FillRect(Rect(0,(Height div 2)-2,5,(Height div 2)+3));
      Canvas.FillRect(Rect(Width-5,(Height div 2)-2,Width,(Height div 2)+3));
    end;
    Canvas.FillRect(Rect(0,0,5,5));
    Canvas.FillRect(Rect(0,Height-5,5,Height));
    Canvas.FillRect(Rect(Width-5,0,Width,5));
    Canvas.FillRect(Rect(Width-5,Height-5,Width,Height));
  end;
end;

procedure TIcQRImage.Paint;
begin
  inherited;
(*
  Canvas.Pen.Color := clBlack;
  Canvas.Pen.Style := psDot;
  Canvas.Rectangle (0, 0, Width, Height);

  If Selected then begin
    If cqMultiSelect then begin
      Canvas.Brush.Color := clGray;
    end else begin
      Canvas.Brush.Color := clBlack;
      Canvas.FillRect(Rect((Width div 2)-2,0,(Width div 2)+3,5));
      Canvas.FillRect(Rect((Width div 2)-2,Height-5,(Width div 2)+3,Height));
      Canvas.FillRect(Rect(0,(Height div 2)-2,5,(Height div 2)+3));
      Canvas.FillRect(Rect(Width-5,(Height div 2)-2,Width,(Height div 2)+3));
    end;
    Canvas.FillRect(Rect(0,0,5,5));
    Canvas.FillRect(Rect(0,Height-5,5,Height));
    Canvas.FillRect(Rect(Width-5,0,Width,5));
    Canvas.FillRect(Rect(Width-5,Height-5,Width,Height));
  end;
  Canvas.Brush.Color := clWhite;
*)
end;

procedure TIcQRDBImage.Paint;
begin
  inherited;
  If Selected then begin
    If cqMultiSelect then begin
      Canvas.Brush.Color := clGray;
    end else begin
      Canvas.Brush.Color := clBlack;
      Canvas.FillRect(Rect((Width div 2)-2,0,(Width div 2)+3,5));
      Canvas.FillRect(Rect((Width div 2)-2,Height-5,(Width div 2)+3,Height));
      Canvas.FillRect(Rect(0,(Height div 2)-2,5,(Height div 2)+3));
      Canvas.FillRect(Rect(Width-5,(Height div 2)-2,Width,(Height div 2)+3));
    end;
    Canvas.FillRect(Rect(0,0,5,5));
    Canvas.FillRect(Rect(0,Height-5,5,Height));
    Canvas.FillRect(Rect(Width-5,0,Width,5));
    Canvas.FillRect(Rect(Width-5,Height-5,Width,Height));
  end;
end;

procedure TIcQRChart.Paint;
begin
  inherited;
  If Selected then begin
    If cqMultiSelect then begin
      Canvas.Brush.Color := clGray;
    end else begin
      Canvas.Brush.Color := clBlack;
      Canvas.FillRect(Rect((Width div 2)-2,0,(Width div 2)+3,5));
      Canvas.FillRect(Rect((Width div 2)-2,Height-5,(Width div 2)+3,Height));
      Canvas.FillRect(Rect(0,(Height div 2)-2,5,(Height div 2)+3));
      Canvas.FillRect(Rect(Width-5,(Height div 2)-2,Width,(Height div 2)+3));
    end;
    Canvas.FillRect(Rect(0,0,5,5));
    Canvas.FillRect(Rect(0,Height-5,5,Height));
    Canvas.FillRect(Rect(Width-5,0,Width,5));
    Canvas.FillRect(Rect(Width-5,Height-5,Width,Height));
  end;
end;

procedure TIcQRBarCode.Paint;
begin
//  inherited;
  DrawBarCode(Self,0);

  If Selected then begin
    If cqMultiSelect then begin
      Canvas.Brush.Color := clGray;
    end else begin
      Canvas.Brush.Color := clBlack;
      Canvas.FillRect(Rect((Width div 2)-2,0,(Width div 2)+3,5));
      Canvas.FillRect(Rect((Width div 2)-2,Height-5,(Width div 2)+3,Height));
      Canvas.FillRect(Rect(0,(Height div 2)-2,5,(Height div 2)+3));
      Canvas.FillRect(Rect(Width-5,(Height div 2)-2,Width,(Height div 2)+3));
    end;
    Canvas.FillRect(Rect(0,0,5,5));
    Canvas.FillRect(Rect(0,Height-5,5,Height));
    Canvas.FillRect(Rect(Width-5,0,Width,5));
    Canvas.FillRect(Rect(Width-5,Height-5,Width,Height));
  end;
end;

initialization
  Classes.RegisterClass(TIcQuickRep);
  Classes.RegisterClass(TIcQRSubDetail);
  Classes.RegisterClass(TIcQRBand);
  Classes.RegisterClass(TIcQRChildBand);
  Classes.RegisterClass(TIcQRGroup);
  Classes.RegisterClass(TIcQRLabel);
  Classes.RegisterClass(TIcQRDBText);
  Classes.RegisterClass(TIcQRExpr);
  Classes.RegisterClass(TIcQRSysData);
  Classes.RegisterClass(TIcQRMemo);
  Classes.RegisterClass(TIcQRShape);
  Classes.RegisterClass(TIcQRImage);
  Classes.RegisterClass(TIcQRDBImage);
  Classes.RegisterClass(TIcQRChart);
  Classes.RegisterClass(TIcQRBarCode);
finalization
  Classes.UnRegisterClass(TIcQuickRep);
  Classes.UnRegisterClass(TIcQRSubDetail);
  Classes.UnRegisterClass(TIcQRBand);
  Classes.UnRegisterClass(TIcQRChildBand);
  Classes.UnRegisterClass(TIcQRGroup);
  Classes.UnRegisterClass(TIcQRLabel);
  Classes.UnRegisterClass(TIcQRDBText);
  Classes.UnRegisterClass(TIcQRExpr);
  Classes.UnRegisterClass(TIcQRSysData);
  Classes.UnRegisterClass(TIcQRMemo);
  Classes.UnRegisterClass(TIcQRShape);
  Classes.UnRegisterClass(TIcQRImage);
  Classes.UnRegisterClass(TIcQRDBImage);
  Classes.UnRegisterClass(TIcQRChart);
  Classes.UnRegisterClass(TIcQRBarCode);
end.
