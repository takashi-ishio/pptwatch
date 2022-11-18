object PptWatchMainForm: TPptWatchMainForm
  Left = 192
  Top = 114
  Width = 484
  Height = 351
  Caption = 'PptWatch: '#12503#12524#12476#12531#12486#12540#12471#12519#12531#26178#38291#35336#28204#12484#12540#12523
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    476
    317)
  PixelsPerInch = 96
  TextHeight = 12
  object Memo1: TMemo
    Left = 8
    Top = 56
    Width = 458
    Height = 249
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = SHIFTJIS_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #65325#65331' '#12468#12471#12483#12463
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object btnStartPresentation: TButton
    Left = 8
    Top = 8
    Width = 458
    Height = 33
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Activate and Connect To Microsoft Power Point'
    TabOrder = 1
    OnClick = btnStartPresentationClick
  end
  object VisualPanel: TPanel
    Left = 8
    Top = 272
    Width = 457
    Height = 33
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 2
    Visible = False
  end
  object PptApp: TPowerPointApplication
    AutoConnect = True
    ConnectKind = ckRunningOrNew
    AutoQuit = False
    OnSlideShowBegin = PptAppSlideShowBegin
    OnSlideShowNextSlide = PptAppSlideShowNextSlide
    OnSlideShowEnd = PptAppSlideShowEnd
    Top = 40
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Microsoft Power Point '#12503#12524#12476#12531#12486#12540#12471#12519#12531' (*.ppt)|ppt'
    Top = 72
  end
end
