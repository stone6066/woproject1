TEMPLATE = app
CONFIG += console
CONFIG -= app_bundle
CONFIG -= qt

SOURCES += main.c

include(../library/libevent/libevent.pri)
include(../library/json-c/json-c.pri)
include(../library/des/des.pri)
include(netsdk.pri)

mingw: QMAKE_LFLAGS += -static
