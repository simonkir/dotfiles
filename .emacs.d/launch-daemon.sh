#!/usr/bin/env fish

while emacs --fg-daemon; and test $status != 123
end
