QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

CONFIG += c++11

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
    ../source/cencode.c \
    ../source/onvif.c \
    ../source/sha1.c \
    main.cpp \
    mainwindow.cpp

HEADERS += \
    ../source/cencode.h \
    ../source/onvif.h \
    ../source/sha1.h \
    mainwindow.h

FORMS += \
    mainwindow.ui

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

# Linux with static libxml2, i.e. Ubuntu
# install libxml2 and libxml2-devel with apt
#unix {
#    message("build linux static libxml2")
#    INCLUDEPATH += ../libonvif


    #INCLUDEPATH += /usr/lib/x86_64-linux-gnu
    #DEPENDPATH += /usr/lib/x86_64-linux-gnu

    #unix:!macx: LIBS += -L/usr/lib/x86_64-linux-gnu/ -lxml2

#    INCLUDEPATH += /usr/include/libxml2
    #DEPENDPATH += /usr/include/libxml2

    #unix:!macx: PRE_TARGETDEPS += /usr/lib/x86_64-linux-gnu/libxml2.a
#}

# Linux with static libxml2, i.e. Ubuntu
# install libxml2 and libxml2-devel with apt
unix {
    message("build linux shared libxml2")
    unix:!macx: LIBS += -L/usr/lib64/ -lxml2

    INCLUDEPATH += ../source
    INCLUDEPATH += /usr/include/libxml2
    INCLUDEPATH += /usr/lib64
    DEPENDPATH += /usr/lib64
}

win32-g++ {
    message("Build win32-g++")
    INCLUDEPATH += $$PWD/../libxml2/win64-debug/bin.mingw
    DEPENDPATH += $$PWD/../libxml2/win64-debug/bin.mingw

    INCLUDEPATH += ..\libonvif
    INCLUDEPATH += ..\libxml2\include\

    INCLUDEPATH += C:/Qt/mingw-w64/mingw64/x86_64-w64-mingw32/include
    DEPENDPATH += C:/Qt/mingw-w64/mingw64/x86_64-w64-mingw32/include

    LIBS += -L$$PWD/../libxml2/win64-debug/bin.mingw/ -lxml2
    LIBS += -LC:/Qt/mingw-w64/mingw64/x86_64-w64-mingw32/lib/ -lws2_32
    LIBS += -LC:/Qt/mingw-w64/mingw64/x86_64-w64-mingw32/lib/ -liphlpapi
    LIBS += -LC:/Qt/mingw-w64/mingw64/x86_64-w64-mingw32/lib/ -liconv

    PRE_TARGETDEPS += $$PWD/../libxml2/win64-debug/bin.mingw/libxml2.a
    PRE_TARGETDEPS += C:/Qt/mingw-w64/mingw64/x86_64-w64-mingw32/lib/libws2_32.a
    PRE_TARGETDEPS += C:/Qt/mingw-w64/mingw64/x86_64-w64-mingw32/lib/libiphlpapi.a
    PRE_TARGETDEPS += C:/Qt/mingw-w64/mingw64/x86_64-w64-mingw32/lib/libiconv.a
}

win32:!win32-g++ {
    message("Build !win32-g++")
    INCLUDEPATH += ..\libonvif
    INCLUDEPATH += ..\libxml2\include\
    INCLUDEPATH += ..\libonvif\libxml2\os400\iconv

    LIBS += -L$$PWD/../libxml2/win64-debug/bin.msvc/ -llibxml2

    INCLUDEPATH += $$PWD/../libxml2/win64-debug/bin.msvc
    DEPENDPATH += $$PWD/../libxml2/win64-debug/bin.msvc

    PRE_TARGETDEPS += $$PWD/../libxml2/win64-debug/bin.msvc/libxml2.lib
}

unix:!macx: LIBS += -L$$PWD/../../../../../usr/lib64/ -lxml2

INCLUDEPATH += $$PWD/../../../../../usr/lib64
DEPENDPATH += $$PWD/../../../../../usr/lib64
