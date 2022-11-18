unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleServer, PowerPointXP, PresenTimer, Contnrs,
  ExtCtrls;

type
  TPptWatchMainForm = class(TForm)
    PptApp: TPowerPointApplication;
    OpenDialog1: TOpenDialog;
    Memo1: TMemo;
    btnStartPresentation: TButton;
    VisualPanel: TPanel;
    procedure btnStartPresentationClick(Sender: TObject);
    procedure PptAppSlideShowNextSlide(ASender: TObject;
      const Wn: SlideShowWindow);
    procedure PptAppSlideShowBegin(ASender: TObject;
      const Wn: SlideShowWindow);
    procedure PptAppSlideShowEnd(ASender: TObject;
      const Pres: _Presentation);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private �錾 }
    FLastPos: Integer;
    timers: TPresentationTimerList;
  public
    { Public �錾 }
    function makeLogString(header: string; seconds: integer): string;
    function makeLogStringCumulative(header: string; seconds, cumulative: integer): string;
  end;

var
  PptWatchMainForm: TPptWatchMainForm;

implementation

uses StrUtils, FormatSeconds;

{$R *.dfm}

const
    IDX_TOTAL_SLIDE = 0;

function TPptWatchMainForm.makeLogString(header: string; seconds: integer): string;
begin
    Result := Format('%-10s %5d %9s', [header, seconds, FormatSecondsToMinSec(seconds)]);
end;

function TPptWatchMainForm.makeLogStringCumulative(header: string; seconds, cumulative: integer): string;
begin
    Result := Format('%-10s %5d %9s %9s', [header, seconds, FormatSecondsToMinSec(seconds), FormatSecondsToMinSec(cumulative)]);
end;

procedure TPptWatchMainForm.btnStartPresentationClick(Sender: TObject);
begin
    PptApp.Activate;
    PptApp.Connect;
end;

procedure TPptWatchMainForm.PptAppSlideShowNextSlide(ASender: TObject;
  const Wn: SlideShowWindow);
var
    timer: TPresentationTimer;
begin
    if Wn = nil then exit;

    // �O�̃X���C�h�̃^�C�}�[���~�߂�
    if FLastPos <> IDX_TOTAL_SLIDE then begin
        timer := timers.getTimerBySlideIndex(Wn.Presentation.Name, FLastPos);
        if (timer <> nil) then timer.stop;
    end;
    
    // �\�����ꂽ�X���C�h�̃^�C�}�[�𓮂���
    FLastPos := Wn.View.CurrentShowPosition;
    timer := timers.getTimerBySlideIndex(Wn.Presentation.Name, FLastPos);
    if (timer = nil) then
        timers.addTimer(Wn.Presentation.Name, FLastPos)
    else
        timer.restart;

    // �X���C�h�؂�ւ����L�^
    Memo1.Lines.Add(makeLogString(IntToStr(Wn.View.CurrentShowPosition),
                       timers.getTimerBySlideIndex(Wn.Presentation.Name, IDX_TOTAL_SLIDE).getLength));

end;

procedure TPptWatchMainForm.PptAppSlideShowBegin(ASender: TObject;
  const Wn: SlideShowWindow);
begin
    // �X���C�h�V���[�J�n���L�^
    timers.addTimer(Wn.Presentation.Name, IDX_TOTAL_SLIDE);
    Memo1.Lines.Add(Wn.Presentation.Name);
    Memo1.Lines.Add( 'BEGIN: ' + TimeToStr(Now));
end;

procedure TPptWatchMainForm.PptAppSlideShowEnd(ASender: TObject;
  const Pres: _Presentation);
const
    LINE = '--------------------------------------------------------';

var
    i: integer;
    timer: TPresentationTimer;
    ms: LongInt;

    list: TObjectList;
begin
    // �X���C�h�V���[�I�����L�^
    Memo1.Lines.Add(makeLogString('End', timers.getTimerBySlideIndex(Pres.Name, IDX_TOTAL_SLIDE).getLength));
    //Memo1.Lines.Add( 'End: ' + Pres.Name );
    Memo1.Lines.Add( LINE );
    Memo1.Lines.Add( 'presentation: ' + Pres.Name );
    Memo1.Lines.Add( LINE );

    // �֌W�̂���^�C�}�[�����ׂĎ��o���Ă���
    list := TObjectList.Create;
    timers.ExtractTimers(pres.Name, list);

    // �o��
    ms := 0;
    for i:=0 to list.Count-1 do begin
        timer := list.Items[i] as TPresentationTimer;
        if timer.SlideIndex = IDX_TOTAL_SLIDE then
            Memo1.Lines.Add(makeLogString('Total', timer.getLength))
        else begin
            ms := ms + timer.getMiliSeconds;
            Memo1.Lines.Add(makeLogStringCumulative('Slide ' + IntToStr(Timer.SlideIndex), timer.getLength, ms div 1000));
        end;
    end;
    list.Free; // �����Ń^�C�}�[�I�u�W�F�N�g���j�������

    Memo1.Lines.Add( LINE );

end;

procedure TPptWatchMainForm.FormCreate(Sender: TObject);
begin
    timers := TPresentationTimerList.Create;
end;

procedure TPptWatchMainForm.FormDestroy(Sender: TObject);
begin
    timers.Free;
end;

end.
