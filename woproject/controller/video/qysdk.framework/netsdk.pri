
INCLUDEPATH += $$PWD

HEADERS += \
    $$PWD/netsdk.h \
    $$PWD/kernel.h \
    $$PWD/socket.h \
    $$PWD/netsdkerr.h \
    $$PWD/netsdkdeffn.h \
    $$PWD/message.h \
    $$PWD/buffer.h \
    $$PWD/rbtree_augmented.h \
    $$PWD/requestqueue.h \
    $$PWD/session.h \
    $$PWD/relay.h \
    $$PWD/netsdkqueue.h \
    $$PWD/netsdk_st.h \
    $$PWD/local.h

SOURCES += \
    $$PWD/netsdk.c \
    $$PWD/kernel.c \
    $$PWD/socket.c \
    $$PWD/netsdkdeffn.c \
    $$PWD/message.c \
    $$PWD/buffer.c \
    $$PWD/rbtree.c \
    $$PWD/requestqueue.c \
    $$PWD/session.c \
    $$PWD/netsdkqueue.c \
    $$PWD/relay.c \
    $$PWD/local.c


win32: LIBS += -lws2_32


