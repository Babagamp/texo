unit Unit_InputName;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ExtCtrls, StdCtrls;

type
 TFormInputName = class(TForm)
    SpeedButton01: TSpeedButton;
    SpeedButton02: TSpeedButton;
    SpeedButton03: TSpeedButton;
    SpeedButton05: TSpeedButton;
    SpeedButton06: TSpeedButton;
    SpeedButton07: TSpeedButton;
    SpeedButton08: TSpeedButton;
    SpeedButton09: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton13: TSpeedButton;
    SpeedButton14: TSpeedButton;
    SpeedButton15: TSpeedButton;
    SpeedButton16: TSpeedButton;
    SpeedButton17: TSpeedButton;
    SpeedButton18: TSpeedButton;
    SpeedButton19: TSpeedButton;
    SpeedButton20: TSpeedButton;
    SpeedButton21: TSpeedButton;
    SpeedButton22: TSpeedButton;
    SpeedButton23: TSpeedButton;
    SpeedButton24: TSpeedButton;
    SpeedButton25: TSpeedButton;
    SpeedButton26: TSpeedButton;
    SpeedButton27: TSpeedButton;
    SpeedButton28: TSpeedButton;
    SpeedButton29: TSpeedButton;
    SpeedButton30: TSpeedButton;
    SpeedButton31: TSpeedButton;
    SpeedButton32: TSpeedButton;
    SpeedButton33: TSpeedButton;
    SpeedButton34: TSpeedButton;
    SpeedButton04: TSpeedButton;
    EditInput: TEdit;
    PanelKeyboard: TPanel;
    SpeedButton37: TSpeedButton;
    SpeedButton38: TSpeedButton;
    SpeedButton39: TSpeedButton;
    SpeedButton40: TSpeedButton;
    SpeedButton41: TSpeedButton;
    SpeedButton42: TSpeedButton;
    SpeedButton43: TSpeedButton;
    SpeedButton44: TSpeedButton;
    SpeedButton45: TSpeedButton;
    SpeedButton35: TSpeedButton;
    SpeedButton36: TSpeedButton;
    SpeedButton46: TSpeedButton;
    SpeedButton47: TSpeedButton;
    SpeedButton48: TSpeedButton;
    SpeedButton49: TSpeedButton;
    SpeedButtonOk: TSpeedButton;
    SpeedButtonCancel: TSpeedButton;
    procedure SpeedButtonPressKey(Sender: TObject);
    procedure SpeedButtonBackSpace(Sender: TObject);
    procedure SpeedButtonUpDownCase(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButtonOkClick(Sender: TObject);
    procedure SpeedButtonCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormInputName: TFormInputName;

implementation

{$R *.dfm}

// ����� � ������ ��������������
procedure TFormInputName.SpeedButtonPressKey(Sender: TObject);
var Substr,Dest: string;
    i:integer;
begin
SubStr:=(Sender as TSpeedButton).Caption;
Dest:=VarToStr(EditInput.Text);
i:=EditInput.SelStart+1;
Insert(Substr, Dest, i);
EditInput.Text:=Dest;
EditInput.SelStart:=i;
end;

// �������� ������� ����� � ������ ��������������
procedure TFormInputName.SpeedButtonBackSpace(Sender: TObject);
var str: String;
    i:integer;
begin
str := EditInput.Text;
i:=EditInput.SelStart;
Delete(Str,i,1);
EditInput.Text:=str;
EditInput.SelStart:=i-1;
end;

// ����������� ���� �������-��������� ����
procedure TFormInputName.SpeedButtonUpDownCase(Sender: TObject);
var count: integer;
begin
    If SpeedButton49.Caption = '��������' then
      Begin
        for Count:=0 to PanelKeyboard.ControlCount-1 do
          Begin
             (PanelKeyboard.Controls[count] as TSpeedButton).Caption:=AnsiLowerCase((PanelKeyboard.Controls[count] as TSpeedButton).Caption);
          end;
        SpeedButton49.Caption:='���������';
        //SpeedButton34.Caption:='������';
        SpeedButton45.Caption:='�������';
      end
      else
      Begin
        for Count:=0 to PanelKeyboard.ControlCount-1 do
          Begin
             (PanelKeyboard.Controls[count] as TSpeedButton).Caption:=AnsiUpperCase((PanelKeyboard.Controls[count] as TSpeedButton).Caption);
          end;
        SpeedButton49.Caption:='��������';
        //SpeedButton34.Caption:='������';
        SpeedButton45.Caption:='�������';
      end;
end;

procedure TFormInputName.FormCreate(Sender: TObject);
    var x,y:integer; //��� ����������� ��� �������� ���������
begin
    // ������� ���� �� ���� �����
    FormInputName.BorderStyle:= bsNone;
    FormInputName.WindowState:= wsMaximized;

    //��������� ���� � �������� �� ������
    y:=(FormInputName.ClientHeight - PanelKeyboard.Height);
    x:=(FormInputName.ClientWidth - PanelKeyboard.Width) div 2;
    PanelKeyboard.Left := x;
    PanelKeyboard.Top := y;

   //��������� ������ ����� � �������� �� ������
    y:=(FormInputName.ClientHeight - EditInput.Height) div 2;
    x:=(FormInputName.ClientWidth - EditInput.Width) div 2;
    EditInput.Left := x;
    EditInput.Top := y;

   // SpeedButtonOk. := mrOK;

end;

procedure TFormInputName.SpeedButtonOkClick(Sender: TObject);
begin
FormInputName.ModalResult:=mrOk;
end;

procedure TFormInputName.SpeedButtonCancelClick(Sender: TObject);
begin
FormInputName.ModalResult:=mrCancel;
end;

end.
