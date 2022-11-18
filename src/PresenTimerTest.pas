unit PresenTimerTest;

interface

uses
    Contnrs,
    PresenTimer,
    TestFrameWork; // TTestCase Ç»Ç«ÇéQè∆Ç∑ÇÈÇÃÇ…ïKóv

type
    TPresenTimerListTest = class(TTestCase)
    private
        List: TPresentationTimerList;
    protected
        procedure SetUp; override;
        procedure TearDown; override;
    published
        procedure TestAdd;
        procedure TestCount;
        procedure TestGetTimerBySlideIndex;
        procedure TestExtractTimers;
        procedure TestExtractTimersWithInvalidArg;
    end;

implementation

procedure TPresenTimerListTest.SetUp;
begin
    List := TPresentationTimerList.Create;
    List.addTimer('TEST', 0);
    List.addTimer('TEST', 1);
    List.addTimer('TEST2', 2);
    List.addTimer('TEST2', 3);
    List.addTimer('TEST', 4);
end;

procedure TPresenTimerListTest.TearDown;
begin
    List.Free;
end;

procedure TPresenTimerListTest.TestCount;
begin
    CheckEquals(5, List.Count, 'Test-Count');
end;

procedure TPresenTimerListTest.TestAdd;
begin
    CheckTrue(List.addTimer('TEST', 2), 'Test-Add-success');
    CheckFalse(List.addTimer('TEST', 0), 'Test-Add-fail');
end;

procedure TPresenTimerListTest.TestGetTimerBySlideIndex;
begin
    CheckEquals(0,List.getTimerBySlideIndex('TEST', 0).SlideIndex, 'SlideIndex - 0');
    CheckEquals(2, List.getTimerBySlideIndex('TEST2', 2).SlideIndex, 'SlideIndex - 2');
    CheckNull(List.getTimerBySlideIndex('TEST', 22), 'SlideIndex - nil-1');
    CheckNull(List.getTimerBySlideIndex('HOGE', 0), 'SlideIndex - nil-2');
end;

procedure TPresenTimerListTest.TestExtractTimers;
var
    l: TObjectList;
begin
    l := TObjectList.Create;
    List.ExtractTimers('TEST', l);
    CheckEquals(3, l.Count, 'Extract-TEST-Count');
    CheckEquals(2, List.Count, 'Extract-TEST-list-count');
    CheckEquals(0, (l[0] as TPresentationTimer).SlideIndex, 'Extract-TEST-0');
    CheckEquals(1, (l[1] as TPresentationTimer).SlideIndex, 'Extract-TEST-1');
    CheckEquals(4, (l[2] as TPresentationTimer).SlideIndex, 'Extract-TEST-2');
    l.Free;

    l := TObjectList.Create;
    List.ExtractTimers('TEST2', l);
    CheckEquals(2, l.Count, 'Extract-TEST2-Count');
    CheckEquals(0, List.Count, 'Extract-TEST2-list-count');
    CheckEquals(2, (l[0] as TPresentationTimer).SlideIndex, 'Extract-TEST2-0');
    CheckEquals(3, (l[1] as TPresentationTimer).SlideIndex, 'Extract-TEST2-1');
    l.Free;
end;


procedure TPresenTimerListTest.TestExtractTimersWithInvalidArg;
var
    l: TObjectList;
begin
    l := TObjectList.Create;
    List.ExtractTimers('HOGE', l);  // This method call extracts no timers.
    CheckEquals(0, l.Count, 'Extract-Hoge-0');
    CheckEquals(5, list.Count, 'Extract-Hoge-Result');
    l.Free;
end;

initialization
    TestFramework.RegisterTest(TPresenTimerListTest.Suite);


end.
 