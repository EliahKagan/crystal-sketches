puts <<-DONT_AT_ME
Personally, I don't much care for any users on this computer.
Except for #{`getent passwd "$(whoami)" | cut -d: -f5 | cut -d, -f1`.chomp}, I mean.
That user is awesome.
DONT_AT_ME
