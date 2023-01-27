unit Model.Main.Icones.Fields;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Menus,
  Vcl.Controls;

type
  TModelMainIconesFields = class
  private
    FCaption: String;
    FComponentName: String;
    FFontSize: Integer;
    FHint: String;
    FOnClickViewMain: TNotifyEvent;
    FOnMouseMoveViewMain: TMouseMoveEvent;
    FPopupMenu: TPopupMenu;
    FResourceName: String;
    FTag: Integer;
    FVisible: Boolean;
  public
    function Caption(AValue: String): TModelMainIconesFields; overload;
    function Caption: String; overload;
    function ComponentName(AValue: String): TModelMainIconesFields; overload;
    function ComponentName: String; overload;
    function FontSize(AValue: Integer): TModelMainIconesFields; overload;
    function FontSize: Integer; overload;
    function Hint(AValue: String): TModelMainIconesFields; overload;
    function Hint: String; overload;
    function OnClickViewMain(AValue: TNotifyEvent): TModelMainIconesFields; overload;
    function OnClickViewMain: TNotifyEvent; overload;
    function OnMouseMoveViewMain(AValue: TMouseMoveEvent): TModelMainIconesFields; overload;
    function OnMouseMoveViewMain: TMouseMoveEvent; overload;
    function PopupMenu(AValue: TPopupMenu): TModelMainIconesFields; overload;
    function PopupMenu: TPopupMenu; overload;
    function ResourceName(AValue: String): TModelMainIconesFields; overload;
    function ResourceName: String; overload;
    function Tag(AValue: Integer): TModelMainIconesFields; overload;
    function Tag: Integer; overload;
    function Visible(AValue: Boolean): TModelMainIconesFields; overload;
    function Visible: Boolean; overload;
    constructor Create;
  end;

implementation

constructor TModelMainIconesFields.Create;
begin
   FCaption         := '';
   FComponentName   := '';
   FFontSize        := 9;
   FHint            := '';
   FOnClickViewMain := nil;
   FPopupMenu       := nil;
   FResourceName    := '';
   FTag             := 0;
   FVisible         := False;
end;

function TModelMainIconesFields.Caption(AValue: String): TModelMainIconesFields;
begin
   Result   := Self;
   FCaption := AValue.Trim;
end;

function TModelMainIconesFields.Caption: String;
begin
   Result := FCaption;
end;

function TModelMainIconesFields.ComponentName(AValue: String): TModelMainIconesFields;
begin
   Result         := Self;
   FComponentName := AValue.Trim;
end;

function TModelMainIconesFields.ComponentName: String;
begin
   Result := FComponentName;
end;

function TModelMainIconesFields.FontSize(AValue: Integer): TModelMainIconesFields;
begin
   Result    := Self;
   FFontSize := AValue;
end;

function TModelMainIconesFields.FontSize: Integer;
begin

   Result := FFontSize;
end;

function TModelMainIconesFields.Hint(AValue: String): TModelMainIconesFields;
begin
   Result := Self;
   FHint  := AValue.Trim;
end;

function TModelMainIconesFields.Hint: String;
begin
   if(FHint.IsEmpty)then
     Self.Hint(Self.Caption);

   Result := FHint;
end;

function TModelMainIconesFields.OnClickViewMain(AValue: TNotifyEvent): TModelMainIconesFields;
begin
   Result           := Self;
   FOnClickViewMain := AValue;
end;

function TModelMainIconesFields.OnClickViewMain: TNotifyEvent;
begin
   Result := FOnClickViewMain;
end;

function TModelMainIconesFields.OnMouseMoveViewMain(AValue: TMouseMoveEvent): TModelMainIconesFields;
begin
   Result               := Self;
   FOnMouseMoveViewMain := AValue;
end;

function TModelMainIconesFields.OnMouseMoveViewMain: TMouseMoveEvent;
begin
   Result := FOnMouseMoveViewMain;
end;

function TModelMainIconesFields.PopupMenu(AValue: TPopupMenu): TModelMainIconesFields;
begin
   Result     := Self;
   FPopupMenu := AValue;
end;

function TModelMainIconesFields.PopupMenu: TPopupMenu;
begin
   Result := FPopupMenu;
end;

function TModelMainIconesFields.ResourceName(AValue: String): TModelMainIconesFields;
begin
   Result        := Self;
   FResourceName := AValue.Trim;
end;

function TModelMainIconesFields.ResourceName: String;
begin
   Result := FResourceName;
end;

function TModelMainIconesFields.Tag(AValue: Integer): TModelMainIconesFields;
begin
   Result := Self;
   FTag   := AValue;
end;

function TModelMainIconesFields.Tag: Integer;
begin
   if(FTag < 0)then
     Self.Tag(0);

   Result := FTag;
end;

function TModelMainIconesFields.Visible(AValue: Boolean): TModelMainIconesFields;
begin
   Result   := Self;
   FVisible := AValue;
end;

function TModelMainIconesFields.Visible: Boolean;
begin
   Result := FVisible;
end;

end.

