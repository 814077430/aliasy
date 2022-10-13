.PHONY: all test clean

TOP=.

all: jps.so

LUA_BIN = /home/liangbowei/aliasy/skynet/3rd/lua/lua

CFLAGS = $(CFLAG)
CFLAGS += -g3 -O2 -rdynamic -Wall -fPIC -shared

jps.so: jps.c fibheap.c
	gcc $(CFLAGS) -o $@ $^

clean:
	rm jps.so

export LUA_CPATH=$(TOP)/?.so
export LUA_PATH=$(TOP)/test/?.lua

test:
	$(LUA_BIN) test/test.lua
