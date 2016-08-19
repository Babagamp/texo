object FormPay: TFormPay
  Left = 564
  Top = 140
  Width = 869
  Height = 852
  Caption = #1055#1088#1080#1077#1084' '#1087#1083#1072#1090#1077#1078#1072' '#1079#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PInput: TPanel
    Left = 112
    Top = 96
    Width = 673
    Height = 625
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -80
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label2: TLabel
      Left = 88
      Top = 54
      Width = 161
      Height = 37
      Caption = #1050' '#1054#1055#1051#1040#1058#1045
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -33
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 424
      Top = 54
      Width = 175
      Height = 37
      Caption = #1054#1057#1058#1040#1051#1054#1057#1068
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -33
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 224
      Top = 280
      Width = 214
      Height = 46
      Caption = #1054#1055#1051#1040#1063#1045#1053#1054
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -40
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
    end
    object Button1: TButton
      Left = 432
      Top = 536
      Width = 201
      Height = 65
      Caption = #1053#1040#1047#1040#1044
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = Button1Click
    end
    object PReceive: TPanel
      Left = 152
      Top = 352
      Width = 353
      Height = 145
      Caption = '0000'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -107
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object PLeftover: TPanel
      Left = 384
      Top = 104
      Width = 240
      Height = 100
      Caption = '000'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -53
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object PPay: TPanel
      Left = 48
      Top = 104
      Width = 240
      Height = 100
      Caption = '000'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -53
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
  end
end
