# comment these to toggle them as one sees fit.
# WARNINGS will spam hundreds of warnings, mostly safe, if turned on
# DEBUG is best turned on if you plan to debug in gdb -- please do!
# PROFILE is for use with gprof or a similar program -- don't bother generally
WARNINGS = -Wall -Wextra -Wno-switch -Wno-sign-compare -Wno-char-subscripts -Wno-unused-parameter
DEBUG = -g
#PROFILE = -pg
#OTHERS = -O3

ODIR = obj
DDIR = .deps

CUSSED_TARGET = cussed
CUSSTEST_TARGET = cusstest

OS  = $(shell uname -o)
CXX = g++

CFLAGS = $(WARNINGS) $(DEBUG) $(PROFILE) $(OTHERS)

ifeq ($(OS), Msys)
LDFLAGS = -static -lpdcurses
else 
LDFLAGS = -lncurses
endif

CUSSED_SOURCES = cuss.cpp cuss_editor.cpp window.cpp glyph.cpp color.cpp stringfunc.cpp files.cpp
CUSSTEST_SOURCES = cuss.cpp cusstest.cpp window.cpp glyph.cpp color.cpp stringfunc.cpp files.cpp
_CUSSED_OBJS = $(CUSSED_SOURCES:.cpp=.o)
_CUSSTEST_OBJS = $(CUSSTEST_SOURCES:.cpp=.o)
CUSSED_OBJS = $(patsubst %,$(ODIR)/%,$(_CUSSED_OBJS))
CUSSTEST_OBJS = $(patsubst %,$(ODIR)/%,$(_CUSSTEST_OBJS))

all: $(CUSSED_TARGET) $(CUSSTEST_TARGET)
	@

$(CUSSED_TARGET): $(ODIR) $(DDIR) $(CUSSED_OBJS)
	$(CXX) -o $(CUSSED_TARGET) $(CFLAGS) $(CUSSED_OBJS) $(LDFLAGS) 

$(CUSSTEST_TARGET): $(ODIR) $(DDIR) $(CUSSTEST_OBJS)
	$(CXX) -o $(CUSSTEST_TARGET) $(CFLAGS) $(CUSSTEST_OBJS) $(LDFLAGS) 

$(ODIR):
	mkdir $(ODIR)

$(DDIR):
	@mkdir $(DDIR)

$(ODIR)/%.o: %.cpp
	$(CXX) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(CUSSED_TARGET) $(CUSSTEST_TARGET) $(ODIR)/*.o

-include $(SOURCES:%.cpp=$(DEPDIR)/%.P)
