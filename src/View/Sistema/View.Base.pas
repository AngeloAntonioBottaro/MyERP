unit View.Base;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls;

type
  TViewBase = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
  public
    procedure SystemTerminate;
  end;

var
  ViewBase: TViewBase;

implementation

{$R *.dfm}

uses
  Utils.MyFormLibrary;

procedure TViewBase.FormCreate(Sender: TObject);
begin
   TMyFormLibrary.New.ConfForm(Self);
end;

procedure TViewBase.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   TMyFormLibrary.New.DefaultKeyDown(Self, Key, Shift);
end;

procedure TViewBase.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if(Key = #13)then
   begin
      Perform(CM_DialogKey, VK_TAB, 0);
      Key := #0;
   end;
end;

procedure TViewBase.SystemTerminate;
begin
   Application.Terminate;
   Abort;
end;

end.
