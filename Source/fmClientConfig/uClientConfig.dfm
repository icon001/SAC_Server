inherited fmClientConfig: TfmClientConfig
  Left = 429
  Top = 345
  BorderIcons = [biSystemMenu]
  Caption = #54872#44221#49444#51221
  ClientHeight = 396
  ClientWidth = 533
  Font.Charset = HANGEUL_CHARSET
  Font.Height = -12
  OldCreateOrder = True
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  ExplicitWidth = 549
  ExplicitHeight = 434
  PixelsPerInch = 96
  TextHeight = 15
  inherited ExcelEnImage: TImage
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
  end
  inherited ExcelDisImage: TImage
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
  end
  inherited Img_Stop: TImage
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
  end
  inherited img_Start: TImage
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
  end
  object MediaPlayer1: TMediaPlayer [4]
    Left = 45
    Top = 235
    Width = 316
    Height = 38
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    AutoEnable = False
    Visible = False
    TabOrder = 1
  end
  object PageControl1: TPageControl [5]
    Left = 0
    Top = 0
    Width = 533
    Height = 343
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    ActivePage = tab_regPort
    Align = alTop
    Font.Charset = HANGEUL_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #47569#51008' '#44256#46357
    Font.Style = []
    MultiLine = True
    ParentFont = False
    TabOrder = 0
    object tab_regPort: TTabSheet
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = #54532#47196#44536#47016#49444#51221
      ImageIndex = 6
      object lb_cardPort: TLabel
        Left = 10
        Top = 37
        Width = 60
        Height = 15
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = #46321#47197#44592#54252#53944
      end
      object Label1: TLabel
        Left = 10
        Top = 74
        Width = 54
        Height = 15
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = 'ENQ Time'
      end
      object Label2: TLabel
        Left = 338
        Top = 69
        Width = 12
        Height = 15
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = #52488
      end
      object cmb_Comport: TComboBox
        Left = 170
        Top = 32
        Width = 161
        Height = 22
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Style = csOwnerDrawFixed
        ImeName = 'Microsoft Office IME 2007'
        TabOrder = 0
      end
    end
  end
  object btn_Save: TAdvGlowButton [6]
    Left = 148
    Top = 350
    Width = 100
    Height = 25
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = #51200#51109
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #47569#51008' '#44256#46357
    Font.Style = []
    NotesFont.Charset = DEFAULT_CHARSET
    NotesFont.Color = clWindowText
    NotesFont.Height = -11
    NotesFont.Name = 'Tahoma'
    NotesFont.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btn_SaveClick
    Appearance.ColorChecked = 16111818
    Appearance.ColorCheckedTo = 16367008
    Appearance.ColorDisabled = 15921906
    Appearance.ColorDisabledTo = 15921906
    Appearance.ColorDown = 16111818
    Appearance.ColorDownTo = 16367008
    Appearance.ColorHot = 16117985
    Appearance.ColorHotTo = 16372402
    Appearance.ColorMirrorHot = 16107693
    Appearance.ColorMirrorHotTo = 16775412
    Appearance.ColorMirrorDown = 16102556
    Appearance.ColorMirrorDownTo = 16768988
    Appearance.ColorMirrorChecked = 16102556
    Appearance.ColorMirrorCheckedTo = 16768988
    Appearance.ColorMirrorDisabled = 11974326
    Appearance.ColorMirrorDisabledTo = 15921906
  end
  object btn_Close: TAdvGlowButton [7]
    Left = 255
    Top = 350
    Width = 100
    Height = 25
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = #45803#44592
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #47569#51008' '#44256#46357
    Font.Style = []
    NotesFont.Charset = DEFAULT_CHARSET
    NotesFont.Color = clWindowText
    NotesFont.Height = -11
    NotesFont.Name = 'Tahoma'
    NotesFont.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = btn_CloseClick
    Appearance.ColorChecked = 16111818
    Appearance.ColorCheckedTo = 16367008
    Appearance.ColorDisabled = 15921906
    Appearance.ColorDisabledTo = 15921906
    Appearance.ColorDown = 16111818
    Appearance.ColorDownTo = 16367008
    Appearance.ColorHot = 16117985
    Appearance.ColorHotTo = 16372402
    Appearance.ColorMirrorHot = 16107693
    Appearance.ColorMirrorHotTo = 16775412
    Appearance.ColorMirrorDown = 16102556
    Appearance.ColorMirrorDownTo = 16768988
    Appearance.ColorMirrorChecked = 16102556
    Appearance.ColorMirrorCheckedTo = 16768988
    Appearance.ColorMirrorDisabled = 11974326
    Appearance.ColorMirrorDisabledTo = 15921906
  end
  object ed_ENQTime: TEdit [8]
    Left = 175
    Top = 92
    Width = 160
    Height = 23
    TabOrder = 6
    Text = '30'
  end
  object RzOpenDialog1: TOpenDialog
    Left = 36
    Top = 212
  end
  object fdmsADOQuery: TADOQuery
    Parameters = <>
    Left = 440
    Top = 112
  end
  object FindFile: TFindFile
    Left = 105
    Top = 215
  end
  object AdvOfficeTabSetOfficeStyler1: TAdvOfficeTabSetOfficeStyler
    ButtonBorderColor = clNone
    GlowButtonAppearance.BorderColor = 13948116
    GlowButtonAppearance.BorderColorHot = 15381630
    GlowButtonAppearance.BorderColorDown = 15048022
    GlowButtonAppearance.BorderColorChecked = 16750899
    GlowButtonAppearance.BorderColorDisabled = 11316396
    GlowButtonAppearance.ColorTo = clNone
    GlowButtonAppearance.ColorChecked = 16750899
    GlowButtonAppearance.ColorCheckedTo = clNone
    GlowButtonAppearance.ColorDisabled = 15658734
    GlowButtonAppearance.ColorDisabledTo = clNone
    GlowButtonAppearance.ColorDown = 16573128
    GlowButtonAppearance.ColorDownTo = clNone
    GlowButtonAppearance.ColorHot = 16576740
    GlowButtonAppearance.ColorHotTo = clNone
    GlowButtonAppearance.ColorMirror = clWhite
    GlowButtonAppearance.ColorMirrorTo = clNone
    GlowButtonAppearance.ColorMirrorHot = 16576740
    GlowButtonAppearance.ColorMirrorHotTo = clNone
    GlowButtonAppearance.ColorMirrorDown = 16573128
    GlowButtonAppearance.ColorMirrorDownTo = clNone
    GlowButtonAppearance.ColorMirrorChecked = 16750899
    GlowButtonAppearance.ColorMirrorCheckedTo = clNone
    GlowButtonAppearance.ColorMirrorDisabled = 15658734
    GlowButtonAppearance.ColorMirrorDisabledTo = 15921906
    GlowButtonAppearance.GradientHot = ggVertical
    GlowButtonAppearance.GradientMirrorHot = ggVertical
    GlowButtonAppearance.GradientDown = ggVertical
    GlowButtonAppearance.GradientMirrorDown = ggVertical
    GlowButtonAppearance.GradientChecked = ggVertical
    TabRounding = 0
    Style = tsOffice2013White
    TabAppearance.BorderColor = clNone
    TabAppearance.BorderColorHot = clNone
    TabAppearance.BorderColorSelected = 13948116
    TabAppearance.BorderColorSelectedHot = 13948116
    TabAppearance.BorderColorDisabled = clNone
    TabAppearance.BorderColorDown = 13948116
    TabAppearance.Color = clBtnFace
    TabAppearance.ColorTo = clWhite
    TabAppearance.ColorSelected = clWhite
    TabAppearance.ColorSelectedTo = clNone
    TabAppearance.ColorDisabled = 15658734
    TabAppearance.ColorDisabledTo = clNone
    TabAppearance.ColorHot = clWhite
    TabAppearance.ColorHotTo = clNone
    TabAppearance.ColorMirror = clWhite
    TabAppearance.ColorMirrorTo = clWhite
    TabAppearance.ColorMirrorHot = clWhite
    TabAppearance.ColorMirrorHotTo = clNone
    TabAppearance.ColorMirrorSelected = clWhite
    TabAppearance.ColorMirrorSelectedTo = clNone
    TabAppearance.ColorMirrorDisabled = 15658734
    TabAppearance.ColorMirrorDisabledTo = clNone
    TabAppearance.Font.Charset = DEFAULT_CHARSET
    TabAppearance.Font.Color = clWindowText
    TabAppearance.Font.Height = -11
    TabAppearance.Font.Name = 'Tahoma'
    TabAppearance.Font.Style = []
    TabAppearance.Gradient = ggVertical
    TabAppearance.GradientMirror = ggVertical
    TabAppearance.GradientHot = ggVertical
    TabAppearance.GradientMirrorHot = ggVertical
    TabAppearance.GradientSelected = ggVertical
    TabAppearance.GradientMirrorSelected = ggVertical
    TabAppearance.GradientDisabled = ggVertical
    TabAppearance.GradientMirrorDisabled = ggVertical
    TabAppearance.TextColor = clBlack
    TabAppearance.TextColorHot = clBlack
    TabAppearance.TextColorSelected = clBlack
    TabAppearance.TextColorDisabled = clGray
    TabAppearance.ShadowColor = clNone
    TabAppearance.HighLightColorSelected = clNone
    TabAppearance.HighLightColorHot = clNone
    TabAppearance.HighLightColorSelectedHot = clNone
    TabAppearance.HighLightColorDown = clNone
    TabAppearance.BackGround.Color = clWhite
    TabAppearance.BackGround.ColorTo = clNone
    TabAppearance.BackGround.Direction = gdHorizontal
    Left = 112
    Top = 120
  end
  object AdvToolBarOfficeStyler1: TAdvToolBarOfficeStyler
    AppColor.AppButtonColor = 13005312
    AppColor.AppButtonHoverColor = 16755772
    AppColor.TextColor = clWhite
    AppColor.HoverColor = 16246477
    AppColor.HoverTextColor = clBlack
    AppColor.HoverBorderColor = 15187578
    AppColor.SelectedColor = 15187578
    AppColor.SelectedTextColor = clBlack
    AppColor.SelectedBorderColor = 15187578
    Style = bsOffice2013White
    BackGroundDisplay = bdStretch
    BorderColor = clSilver
    BorderColorHot = 15590880
    ButtonAppearance.Color = clWhite
    ButtonAppearance.ColorTo = 15590880
    ButtonAppearance.ColorChecked = 7131391
    ButtonAppearance.ColorCheckedTo = 7131391
    ButtonAppearance.ColorDown = 7131391
    ButtonAppearance.ColorDownTo = 8122111
    ButtonAppearance.ColorHot = 9102333
    ButtonAppearance.ColorHotTo = 14285309
    ButtonAppearance.BorderDownColor = 3181250
    ButtonAppearance.BorderHotColor = 5819121
    ButtonAppearance.BorderCheckedColor = 3181250
    ButtonAppearance.CaptionFont.Charset = DEFAULT_CHARSET
    ButtonAppearance.CaptionFont.Color = clWindowText
    ButtonAppearance.CaptionFont.Height = -11
    ButtonAppearance.CaptionFont.Name = 'Segoe UI'
    ButtonAppearance.CaptionFont.Style = []
    CaptionAppearance.CaptionColor = 15921133
    CaptionAppearance.CaptionColorTo = 15921133
    CaptionAppearance.CaptionTextColor = 6774616
    CaptionAppearance.CaptionBorderColor = 15921133
    CaptionAppearance.CaptionColorHot = 16250355
    CaptionAppearance.CaptionColorHotTo = 16250355
    CaptionAppearance.CaptionTextColorHot = 6774616
    CaptionAppearance.CaptionBorderColorHot = 15921133
    CaptionFont.Charset = DEFAULT_CHARSET
    CaptionFont.Color = clWindowText
    CaptionFont.Height = -11
    CaptionFont.Name = 'Segoe UI'
    CaptionFont.Style = []
    ContainerAppearance.LineColor = clBtnShadow
    ContainerAppearance.Line3D = True
    Color.Color = clWhite
    Color.ColorTo = clWhite
    Color.Direction = gdVertical
    Color.Mirror.Color = 16777214
    Color.Mirror.ColorTo = 16777214
    Color.Mirror.ColorMirror = 16777214
    Color.Mirror.ColorMirrorTo = 15921133
    ColorHot.Color = 16777214
    ColorHot.ColorTo = 16777214
    ColorHot.Direction = gdVertical
    ColorHot.Mirror.Color = 16777214
    ColorHot.Mirror.ColorTo = 16777214
    ColorHot.Mirror.ColorMirror = 16777214
    ColorHot.Mirror.ColorMirrorTo = 16250355
    CompactGlowButtonAppearance.BorderColor = 13815240
    CompactGlowButtonAppearance.BorderColorHot = 5819121
    CompactGlowButtonAppearance.BorderColorDown = 3181250
    CompactGlowButtonAppearance.BorderColorChecked = 3181250
    CompactGlowButtonAppearance.ColorTo = 15590880
    CompactGlowButtonAppearance.ColorChecked = 14285309
    CompactGlowButtonAppearance.ColorCheckedTo = 7131391
    CompactGlowButtonAppearance.ColorDisabled = clNone
    CompactGlowButtonAppearance.ColorDisabledTo = clNone
    CompactGlowButtonAppearance.ColorDown = 7131391
    CompactGlowButtonAppearance.ColorDownTo = 8122111
    CompactGlowButtonAppearance.ColorHot = 9102333
    CompactGlowButtonAppearance.ColorHotTo = 14285309
    CompactGlowButtonAppearance.ColorMirror = 15590880
    CompactGlowButtonAppearance.ColorMirrorTo = 15590880
    CompactGlowButtonAppearance.ColorMirrorHot = 14285309
    CompactGlowButtonAppearance.ColorMirrorHotTo = 9102333
    CompactGlowButtonAppearance.ColorMirrorDown = 8122111
    CompactGlowButtonAppearance.ColorMirrorDownTo = 7131391
    CompactGlowButtonAppearance.ColorMirrorChecked = 7131391
    CompactGlowButtonAppearance.ColorMirrorCheckedTo = 7131391
    CompactGlowButtonAppearance.ColorMirrorDisabled = clNone
    CompactGlowButtonAppearance.ColorMirrorDisabledTo = clNone
    CompactGlowButtonAppearance.GradientHot = ggVertical
    CompactGlowButtonAppearance.GradientMirrorHot = ggVertical
    CompactGlowButtonAppearance.GradientDown = ggVertical
    CompactGlowButtonAppearance.GradientMirrorDown = ggVertical
    CompactGlowButtonAppearance.GradientChecked = ggVertical
    DockColor.Color = clWhite
    DockColor.ColorTo = clWhite
    DockColor.Direction = gdHorizontal
    DockColor.Steps = 128
    FloatingWindowBorderColor = 13486790
    Font.Charset = HANGEUL_CHARSET
    Font.Color = clBlack
    Font.Height = -27
    Font.Name = 'Segoe UI'
    Font.Style = []
    GlowButtonAppearance.BorderColor = clWhite
    GlowButtonAppearance.BorderColorHot = 15187578
    GlowButtonAppearance.BorderColorDown = 15187578
    GlowButtonAppearance.BorderColorChecked = 15187578
    GlowButtonAppearance.ColorTo = clNone
    GlowButtonAppearance.ColorChecked = 15187578
    GlowButtonAppearance.ColorCheckedTo = clNone
    GlowButtonAppearance.ColorDisabled = clNone
    GlowButtonAppearance.ColorDisabledTo = clNone
    GlowButtonAppearance.ColorDown = 15187578
    GlowButtonAppearance.ColorDownTo = clNone
    GlowButtonAppearance.ColorHot = 16246477
    GlowButtonAppearance.ColorHotTo = clNone
    GlowButtonAppearance.ColorMirror = clNone
    GlowButtonAppearance.ColorMirrorTo = clNone
    GlowButtonAppearance.ColorMirrorHot = clNone
    GlowButtonAppearance.ColorMirrorHotTo = clNone
    GlowButtonAppearance.ColorMirrorDown = clNone
    GlowButtonAppearance.ColorMirrorDownTo = clNone
    GlowButtonAppearance.ColorMirrorChecked = clNone
    GlowButtonAppearance.ColorMirrorCheckedTo = clNone
    GlowButtonAppearance.ColorMirrorDisabled = clNone
    GlowButtonAppearance.ColorMirrorDisabledTo = clNone
    GlowButtonAppearance.GradientHot = ggVertical
    GlowButtonAppearance.GradientMirrorHot = ggVertical
    GlowButtonAppearance.GradientDown = ggVertical
    GlowButtonAppearance.GradientMirrorDown = ggVertical
    GlowButtonAppearance.GradientChecked = ggVertical
    GroupAppearance.Background = clInfoBk
    GroupAppearance.BorderColor = 1340927
    GroupAppearance.Color = 4636927
    GroupAppearance.ColorTo = 4636927
    GroupAppearance.ColorMirror = 4636927
    GroupAppearance.ColorMirrorTo = 4636927
    GroupAppearance.Font.Charset = DEFAULT_CHARSET
    GroupAppearance.Font.Color = clWindowText
    GroupAppearance.Font.Height = -11
    GroupAppearance.Font.Name = 'Segoe UI'
    GroupAppearance.Font.Style = []
    GroupAppearance.Gradient = ggVertical
    GroupAppearance.GradientMirror = ggVertical
    GroupAppearance.TextColor = clWhite
    GroupAppearance.CaptionAppearance.CaptionColor = 15921133
    GroupAppearance.CaptionAppearance.CaptionColorTo = 15921133
    GroupAppearance.CaptionAppearance.CaptionTextColor = 6774616
    GroupAppearance.CaptionAppearance.CaptionBorderColor = 15921133
    GroupAppearance.CaptionAppearance.CaptionColorHot = 16250355
    GroupAppearance.CaptionAppearance.CaptionColorHotTo = 16250355
    GroupAppearance.CaptionAppearance.CaptionTextColorHot = 6774616
    GroupAppearance.CaptionAppearance.CaptionBorderColorHot = 15921133
    GroupAppearance.PageAppearance.BorderColor = 15921133
    GroupAppearance.PageAppearance.Color = 16777214
    GroupAppearance.PageAppearance.ColorTo = 16777214
    GroupAppearance.PageAppearance.ColorMirror = 16777214
    GroupAppearance.PageAppearance.ColorMirrorTo = 15921133
    GroupAppearance.PageAppearance.Gradient = ggVertical
    GroupAppearance.PageAppearance.GradientMirror = ggVertical
    GroupAppearance.PageAppearance.ShadowColor = clGray
    GroupAppearance.PageAppearance.HighLightColor = clSilver
    GroupAppearance.TabAppearance.BorderColor = 13815240
    GroupAppearance.TabAppearance.BorderColorHot = 1340927
    GroupAppearance.TabAppearance.BorderColorSelected = 1340927
    GroupAppearance.TabAppearance.BorderColorSelectedHot = 1340927
    GroupAppearance.TabAppearance.BorderColorDisabled = clNone
    GroupAppearance.TabAppearance.BorderColorDown = 14404026
    GroupAppearance.TabAppearance.Color = clWhite
    GroupAppearance.TabAppearance.ColorTo = clWhite
    GroupAppearance.TabAppearance.ColorSelected = 16777214
    GroupAppearance.TabAppearance.ColorSelectedTo = 16777214
    GroupAppearance.TabAppearance.ColorDisabled = 15921906
    GroupAppearance.TabAppearance.ColorDisabledTo = 15921906
    GroupAppearance.TabAppearance.ColorHot = 16777214
    GroupAppearance.TabAppearance.ColorHotTo = 16777214
    GroupAppearance.TabAppearance.ColorMirror = clWhite
    GroupAppearance.TabAppearance.ColorMirrorTo = clWhite
    GroupAppearance.TabAppearance.ColorMirrorHot = 16777214
    GroupAppearance.TabAppearance.ColorMirrorHotTo = 16777214
    GroupAppearance.TabAppearance.ColorMirrorSelected = 16777214
    GroupAppearance.TabAppearance.ColorMirrorSelectedTo = 16777214
    GroupAppearance.TabAppearance.ColorMirrorDisabled = 15921906
    GroupAppearance.TabAppearance.ColorMirrorDisabledTo = 15921906
    GroupAppearance.TabAppearance.Font.Charset = DEFAULT_CHARSET
    GroupAppearance.TabAppearance.Font.Color = clWindowText
    GroupAppearance.TabAppearance.Font.Height = -11
    GroupAppearance.TabAppearance.Font.Name = 'Segoe UI'
    GroupAppearance.TabAppearance.Font.Style = []
    GroupAppearance.TabAppearance.Gradient = ggVertical
    GroupAppearance.TabAppearance.GradientMirror = ggVertical
    GroupAppearance.TabAppearance.GradientHot = ggVertical
    GroupAppearance.TabAppearance.GradientMirrorHot = ggVertical
    GroupAppearance.TabAppearance.GradientSelected = ggVertical
    GroupAppearance.TabAppearance.GradientMirrorSelected = ggVertical
    GroupAppearance.TabAppearance.GradientDisabled = ggVertical
    GroupAppearance.TabAppearance.GradientMirrorDisabled = ggVertical
    GroupAppearance.TabAppearance.TextColor = 6381406
    GroupAppearance.TabAppearance.TextColorHot = 6774616
    GroupAppearance.TabAppearance.TextColorSelected = 6774616
    GroupAppearance.TabAppearance.TextColorDisabled = clGray
    GroupAppearance.TabAppearance.ShadowColor = 12565174
    GroupAppearance.TabAppearance.HighLightColor = 16775871
    GroupAppearance.TabAppearance.HighLightColorHot = 16777214
    GroupAppearance.TabAppearance.HighLightColorSelected = 13815240
    GroupAppearance.TabAppearance.HighLightColorSelectedHot = 15590880
    GroupAppearance.TabAppearance.HighLightColorDown = 16119026
    GroupAppearance.ToolBarAppearance.BorderColor = 15921133
    GroupAppearance.ToolBarAppearance.BorderColorHot = 13092807
    GroupAppearance.ToolBarAppearance.Color.Color = 16777214
    GroupAppearance.ToolBarAppearance.Color.ColorTo = 15921133
    GroupAppearance.ToolBarAppearance.Color.Direction = gdHorizontal
    GroupAppearance.ToolBarAppearance.ColorHot.Color = 16777214
    GroupAppearance.ToolBarAppearance.ColorHot.ColorTo = 16250355
    GroupAppearance.ToolBarAppearance.ColorHot.Direction = gdHorizontal
    PageAppearance.BorderColor = 15921133
    PageAppearance.Color = 16777214
    PageAppearance.ColorTo = 16777214
    PageAppearance.ColorMirror = 16777214
    PageAppearance.ColorMirrorTo = 15921133
    PageAppearance.Gradient = ggVertical
    PageAppearance.GradientMirror = ggVertical
    PageAppearance.ShadowColor = clGray
    PageAppearance.HighLightColor = clSilver
    PagerCaption.BorderColor = 13815240
    PagerCaption.Color = 13946827
    PagerCaption.ColorTo = 13946827
    PagerCaption.ColorMirror = 13946827
    PagerCaption.ColorMirrorTo = 13946827
    PagerCaption.Gradient = ggVertical
    PagerCaption.GradientMirror = ggVertical
    PagerCaption.TextColor = clGray
    PagerCaption.TextColorExtended = clBlue
    PagerCaption.Font.Charset = DEFAULT_CHARSET
    PagerCaption.Font.Color = clWindowText
    PagerCaption.Font.Height = -13
    PagerCaption.Font.Name = 'Segoe UI'
    PagerCaption.Font.Style = []
    QATAppearance.BorderColor = 13815240
    QATAppearance.Color = clWhite
    QATAppearance.ColorTo = 15590880
    QATAppearance.FullSizeBorderColor = 13815240
    QATAppearance.FullSizeColor = clWhite
    QATAppearance.FullSizeColorTo = 15590880
    RightHandleColor = clSilver
    RightHandleColorTo = clSilver
    RightHandleColorHot = clGray
    RightHandleColorHotTo = clGray
    RightHandleColorDown = clGray
    RightHandleColorDownTo = clGray
    TabAppearance.BorderColor = 13815240
    TabAppearance.BorderColorHot = 12236209
    TabAppearance.BorderColorSelected = 12565174
    TabAppearance.BorderColorSelectedHot = 12236209
    TabAppearance.BorderColorDisabled = clNone
    TabAppearance.BorderColorDown = 14404026
    TabAppearance.Color = clWhite
    TabAppearance.ColorTo = clWhite
    TabAppearance.ColorSelected = 16777214
    TabAppearance.ColorSelectedTo = 16777214
    TabAppearance.ColorDisabled = 15921906
    TabAppearance.ColorDisabledTo = 15921906
    TabAppearance.ColorHot = 16777214
    TabAppearance.ColorHotTo = 16777214
    TabAppearance.ColorMirror = clWhite
    TabAppearance.ColorMirrorTo = clWhite
    TabAppearance.ColorMirrorHot = 16777214
    TabAppearance.ColorMirrorHotTo = 16777214
    TabAppearance.ColorMirrorSelected = 16777214
    TabAppearance.ColorMirrorSelectedTo = 16777214
    TabAppearance.ColorMirrorDisabled = 15921906
    TabAppearance.ColorMirrorDisabledTo = 15921906
    TabAppearance.Font.Charset = DEFAULT_CHARSET
    TabAppearance.Font.Color = clWindowText
    TabAppearance.Font.Height = -11
    TabAppearance.Font.Name = 'Segoe UI'
    TabAppearance.Font.Style = []
    TabAppearance.Gradient = ggVertical
    TabAppearance.GradientMirror = ggVertical
    TabAppearance.GradientHot = ggVertical
    TabAppearance.GradientMirrorHot = ggVertical
    TabAppearance.GradientSelected = ggVertical
    TabAppearance.GradientMirrorSelected = ggVertical
    TabAppearance.GradientDisabled = ggVertical
    TabAppearance.GradientMirrorDisabled = ggVertical
    TabAppearance.TextColor = 6381406
    TabAppearance.TextColorHot = 6774616
    TabAppearance.TextColorSelected = 6774616
    TabAppearance.TextColorDisabled = clGray
    TabAppearance.ShadowColor = 12565174
    TabAppearance.HighLightColor = 16775871
    TabAppearance.HighLightColorHot = 16777214
    TabAppearance.HighLightColorSelected = 13815240
    TabAppearance.HighLightColorSelectedHot = 15590880
    TabAppearance.HighLightColorDown = 16119026
    TabAppearance.BackGround.Color = 16446701
    TabAppearance.BackGround.ColorTo = 16710906
    TabAppearance.BackGround.Direction = gdVertical
    Left = 116
    Top = 76
  end
  object AdvFormStyler1: TAdvFormStyler
    MetroColor = clSkyBlue
    Style = tsOffice2013White
    Left = 190
    Top = 120
  end
end
