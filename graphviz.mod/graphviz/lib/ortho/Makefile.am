## Process this file with automake to produce Makefile.in

AM_CPPFLAGS = \
	-I$(top_srcdir)/lib \
	-I$(top_srcdir)/lib/common \
	-I$(top_srcdir)/lib/gvc \
	-I$(top_srcdir)/lib/pack \
	-I$(top_srcdir)/lib/pathplan \
	-I$(top_srcdir)/lib/cgraph \
	-I$(top_srcdir)/lib/cdt

if WITH_ORTHO
AM_CFLAGS = -DGVC_EXPORTS
endif

noinst_HEADERS = fPQ.h ortho.h maze.h partition.h rawgraph.h sgraph.h structures.h trap.h

if WITH_ORTHO
noinst_LTLIBRARIES = libortho_C.la
endif

libortho_C_la_SOURCES = fPQ.c maze.c ortho.c partition.c rawgraph.c sgraph.c trapezoid.c
