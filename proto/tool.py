#!/usr/bin/python
# -*- coding: UTF-8 -*-

def dealMessageId():
    file_object = open("./messageIds.proto", "r")
    try:
        all = file_object.read()
    finally:
        file_object.close()

    all = all.split("enum MessageId")

    dest = ""
    start = "M = {}\n" + "msg_map = {}\n" + "M = "
    dest = start + all[1]
    end = "\n\nfor msgname, msgid in pairs(M) do \n   msg_map[msgid] = \"pb.\"..msgname \nend\n\nfunction M.get_name(msgid)\n   return msg_map[msgid]\nend\n\nreturn M"
    dest = dest + end

    dest_object = open("./msgdefine.lua", "w+")
    dest_object.truncate(0)
    dest_object.write(dest)

    return

def dealErrorCode():
    return

def dealCmds():
    file_object = open("./messageIds.proto", "r")
    try:
        all = file_object.read()
    finally:
        file_object.close()

    all = all.split("enum MessageId")
    
    return

def __main__():
    dealMessageId()
    dealErrorCode()
    dealCmds()
    return

__main__()