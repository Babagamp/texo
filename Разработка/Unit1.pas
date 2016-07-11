unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ExtCtrls, StdCtrls;

type
  TForm1 = class(TForm)
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
    Label1: TLabel;
    Edit1: TEdit;
    Panel1: TPanel;
    procedure SpeedButton34Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.SpeedButton34Click(Sender: TObject);
var Substr,Dest: string;
    i:integer;
begin
SubStr:=(Sender as TSpeedButton).Caption;
Dest:=VarToStr(Edit1.Text);
i:=Edit1.SelStart+1;
Insert(Substr, Dest, i);
Edit1.Text:=Dest;
Edit1.SelStart:=i;
Label1.Caption:=IntToStr(Edit1.SelStart);

end;

end.
