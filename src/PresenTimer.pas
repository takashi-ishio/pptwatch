unit PresenTimer;

interface

uses Classes, Contnrs, StrUtils, SysUtils;

type

  TPresentationTimer = class
  private
    FStartTime: TDateTime;
    FEndTime:   TDateTime;
    FStopped:   boolean;
    FCumulativeMiliSeconds : LongInt;
    FSlideIndex: integer;
  public
    constructor Create(slide_index: integer);
    destructor Destroy; override;
    procedure stop;
    procedure restart;                        
    function getLength: integer;
    function getMin: integer;
    function getSec: integer;
    function getMiliSeconds: LongInt;
    property SlideIndex: integer read FSlideIndex;
  end;

  TPresentationTimerList = class
  private
    timers: TStringList;

    function getTimer(idx: integer): TPresentationTimer;
    function makeTimerName(name: string; slide_index: integer): string;
  public
    constructor Create;
    destructor Destroy; override;
    function getTimerBySlideIndex(name: string; slide_index: integer): TPresentationTimer;
    function addTimer(name: string; slide_index: integer): boolean;
    procedure ExtractTimers(name: string; var list: TObjectList);
    function Count: integer;
  end;

implementation

uses DateUtils;

const
    SEPARATOR = '|';

constructor TPresentationTimerList.Create;
begin
    timers := TStringList.Create;
end;

destructor TPresentationTimerList.Destroy;
var
    i: integer;
begin
    for i:=0 to timers.Count-1 do timers.Objects[i].Free;
    timers.Free;
end;

function TPresentationTimerList.makeTimerName(name: string; slide_index: integer): string;
begin
    Result := name + SEPARATOR + IntToStr(slide_index);
end;

function sortBySlideIndex(item1, item2: Pointer): integer;
begin
    Result := TPresentationTimer(item1).SlideIndex - TPresentationTimer(item2).SlideIndex;
end;

procedure TPresentationTimerList.ExtractTimers(name: string; var list: TObjectList);
var
    i: integer;
    timer : TPresentationTimer;
begin
    i := 0;
    while i < Count do begin
        timer := getTimer(i);
        if AnsiStartsText(name + SEPARATOR, timers.Strings[i]) then begin
            timer.stop;
            list.Add(timer);
            timers.Delete(i)
        end else begin
            inc(i);
        end;
    end;

    list.Sort(sortBySlideIndex);
end;

function TPresentationTimerList.getTimer(idx: integer): TPresentationTimer;
begin
    result := timers.Objects[idx] as TPresentationTimer;
end;

function TPresentationTimerList.Count: integer;
begin
    Result := timers.Count;
end;

function TPresentationTimerList.getTimerBySlideIndex(name: string; slide_index: integer): TPresentationTimer;
var
    idx: integer;
begin
    idx := timers.IndexOf(makeTimerName(name, slide_index));
    if idx >= 0 then begin
        Result := timers.Objects[idx] as TPresentationTimer;
    end else begin
        Result := nil;
    end;
end;


function TPresentationTimerList.addTimer(name: string; slide_index: integer): boolean;
begin
    if getTimerBySlideIndex(name, slide_index) = nil then begin
        timers.AddObject(makeTimerName(name, slide_index), TPresentationTimer.Create(slide_index));
        Result := true;
    end else begin
        Result := false;
    end;
end;



constructor TPresentationTimer.Create(slide_index: integer);
begin
    FStartTime := Now;
    FStopped := false;
    FCumulativeMiliSeconds := 0;
    FSlideIndex := slide_index;
end;

destructor TPresentationTimer.Destroy;
begin

end;

procedure TPresentationTimer.restart;
begin
    FStartTime := Now;
    FStopped := false;
end;

procedure TPresentationTimer.stop;
begin
    if FStopped then exit;
    FEndTime := Now;
    FStopped := true;
    FCumulativeMiliSeconds := FCumulativeMiliSeconds + MilliSecondsBetween(FStartTime, FEndTime);
end;

function TPresentationTimer.getLength: integer;
begin
    if FStopped then Result := FCumulativeMiliSeconds div 1000
    else Result := SecondsBetween(FStartTime, Now);
end;

function TPresentationTimer.getMiliSeconds: LongInt;
begin
    Result := FCumulativeMiliSeconds;
end;

function TPresentationTimer.getMin: integer;
begin
    Result := getLength div 60;
end;

function TPresentationTimer.getSec: integer;
begin
    Result := getLength mod 60;
end;

end.
