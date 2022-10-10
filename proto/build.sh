#/bin/bash
protoc --descriptor_set_out=messages.pb messages.proto commons.proto
/usr/bin/python ./tool.py