unit unit_config;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, xmldom, XMLIntf, msxmldom, XMLDoc, StdCtrls, ExtCtrls, DB,
  DBClient, ComCtrls, Spin, Mask;

type
  TFormConfig = class(TForm)
    XMLDoc: TXMLDocument;
    GroupBoxCash: TGroupBox;
    CheckBox10rub: TCheckBox;
    CheckBox50rub: TCheckBox;
    CheckBox100rub: TCheckBox;
    CheckBox500rub: TCheckBox;
    CheckBox1000rub: TCheckBox;
    CheckBox5000rub: TCheckBox;
    ButtonSave: TButton;
    ButtonClose: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    SpinEdit1: TSpinEdit;
    Label2: TLabel;
    Edit1: TEdit;
    procedure ButtonCloseClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormConfig: TFormConfig;

implementation

{$R *.dfm}

procedure TFormConfig.ButtonCloseClick(Sender: TObject);
begin
 FormConfig.Close
end;

procedure TFormConfig.ButtonSaveClick(Sender: TObject);
   var i: integer;
begin

   if not TryStrToInt(Edit1.Text,i) then
     begin
       ShowMessage('Ошибка. Введите правильное число секунд');
       Exit;
     end;

   ShowMessage('Сохраняем в xml');
   XMLDoc.Active := true;

   XMLDoc.Version := '1.0';
   XMLDoc.Encoding := 'windows-1251';

   XMLDoc.AddChild('config');

   With  XMLDoc.ChildNodes['config'] do
   begin
     AddChild('COM');
     ChildValues['COM'] := IntToStr(SpinEdit1.Value);

     AddChild('TimeOut');
     ChildValues['TimeOut'] := Edit1.Text;

     AddChild('cash');
     For i:=0 to GroupBoxCash.ControlCount - 1 do
     Begin
       ChildNodes['cash'].AddChild(GroupBoxCash.Controls[i].Name);
       ChildNodes['cash'].ChildValues[GroupBoxCash.Controls[i].Name] := (GroupBoxCash.Controls[i] as TCheckBox).Checked;
     end;

   end;

   XMLDoc.SaveToFile('config.xml');

   XMLDoc.Active := false;
   //XMLDoc.CleanupInstance;

   //XMLDoc.Free;  // Глюк какой-то после этого....
end;

procedure TFormConfig.FormCreate(Sender: TObject);
 var i: integer;

begin

  // Проверка на существование файла (но ее недостаточно?)
  If FileExists('config.xml') then
  begin
    XMLDoc.Active := true;
    XMLDoc.LoadFromFile('config.xml');
    // Здесь нужно сделать проверку на существование Этих нод, а то может быть ошибка
    With  XMLDoc.ChildNodes['config'] do
    begin
      For i := 0 to ChildNodes['cash'].ChildNodes.Count-1 do
      begin
       (GroupBoxCash.Controls[i] as TCheckBox).Checked := ChildNodes['cash'].ChildNodes[(GroupBoxCash.Controls[i] as TCheckBox).Name].NodeValue;
      end;

      SpinEdit1.Value := ChildNodes['COM'].NodeValue;
      Edit1.Text := ChildNodes['TimeOut'].NodeValue;

    end;
    XMLDoc.Active := false;
    XMLDoc.CleanupInstance;   // Не знаю надо ли это?
  end
  else
    FormConfig.ButtonSaveClick(Sender);
End;

End.
