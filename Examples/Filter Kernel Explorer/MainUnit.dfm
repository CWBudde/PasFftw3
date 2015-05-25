object FormFilterKernelExplorer: TFormFilterKernelExplorer
  Left = 0
  Top = 0
  Caption = 'Filter Kernel Explorer'
  ClientHeight = 645
  ClientWidth = 894
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Chart: TChart
    Left = 0
    Top = 72
    Width = 894
    Height = 573
    Legend.Visible = False
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    BottomAxis.Automatic = False
    BottomAxis.AutomaticMinimum = False
    View3D = False
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ColorPaletteIndex = 13
  end
  object PanelControl: TPanel
    Left = 0
    Top = 0
    Width = 894
    Height = 72
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      894
      72)
    object LabelLow: TLabel
      Left = 16
      Top = 9
      Width = 77
      Height = 13
      Caption = 'Low Frequency:'
    end
    object LabelHigh: TLabel
      Left = 16
      Top = 42
      Width = 79
      Height = 13
      Caption = 'High Frequency:'
    end
    object TrackBarLow: TTrackBar
      Left = 101
      Top = 6
      Width = 788
      Height = 28
      Anchors = [akLeft, akTop, akRight]
      Max = 50
      Position = 10
      TabOrder = 0
      ThumbLength = 16
      OnChange = TrackBarChange
    end
    object TrackBarHigh: TTrackBar
      Left = 101
      Top = 40
      Width = 788
      Height = 28
      Anchors = [akLeft, akTop, akRight]
      Max = 50
      Position = 40
      TabOrder = 1
      ThumbLength = 16
      OnChange = TrackBarChange
    end
  end
  object MainMenu: TMainMenu
    Left = 64
    Top = 80
    object MenuItemFile: TMenuItem
      Caption = '&File'
      object MenuItemExit: TMenuItem
        Action = ActionFileExit
      end
    end
    object MenuItemDomain: TMenuItem
      Caption = '&Domain'
      object MenuItemDomainFilterKernel: TMenuItem
        Action = ActionDomainFilterKernel
        AutoCheck = True
        GroupIndex = 1
        RadioItem = True
      end
      object N1: TMenuItem
        Caption = '-'
        GroupIndex = 1
      end
      object MenuItemDomainReal: TMenuItem
        Action = ActionDomainComplex
        AutoCheck = True
        GroupIndex = 1
        RadioItem = True
      end
      object MenuItemDomainFrequencyDomain: TMenuItem
        Action = ActionDomainMagnitude
        AutoCheck = True
        GroupIndex = 1
        RadioItem = True
      end
      object MenuItemDomainPhase: TMenuItem
        Action = ActionDomainPhase
        AutoCheck = True
        GroupIndex = 1
        RadioItem = True
      end
    end
  end
  object ActionList: TActionList
    Left = 16
    Top = 80
    object ActionFileExit: TFileExit
      Category = 'File'
      Caption = 'E&xit'
      Hint = 'Exit|Closes Application'
      ImageIndex = 43
    end
    object ActionDomainFilterKernel: TAction
      Category = 'Domain'
      AutoCheck = True
      Caption = 'Filter Kernel'
      Checked = True
      GroupIndex = 1
      OnExecute = ActionDomainFilterKernelExecute
    end
    object ActionDomainComplex: TAction
      Category = 'Domain'
      AutoCheck = True
      Caption = '&Complex'
      GroupIndex = 1
      OnExecute = ActionDomainComplexExecute
    end
    object ActionDomainMagnitude: TAction
      Category = 'Domain'
      AutoCheck = True
      Caption = '&Magnitude'
      GroupIndex = 1
      OnExecute = ActionDomainMagnitudeExecute
    end
    object ActionDomainPhase: TAction
      Category = 'Domain'
      AutoCheck = True
      Caption = '&Phase'
      GroupIndex = 1
      OnExecute = ActionDomainPhaseExecute
    end
  end
end
