unit FormatSeconds;

interface

uses
    SysUtils;

    function FormatSecondsToMinSec(seconds: integer): string;

implementation


function FormatSecondsToMinSec(seconds: integer): string;
begin
    Result := Format('%d:%2.2d', [seconds div 60, seconds mod 60]);
end;


end.
 