# ## Process this file with automake to produce Makefile.in

AM_CPPFLAGS = \
	-I$(top_srcdir)/lib \
	-I$(top_srcdir)/lib/common \
	$(GTK_CFLAGS:-I%=-isystem%) $(GLUT_CFLAGS) $(GTKGL_CFLAGS) $(GLADE_CFLAGS) $(FREETYPE2_CFLAGS) $(XRENDER_CFLAGS)

if WITH_SMYRNA
noinst_HEADERS = glcompbutton.h glcompdefs.h glcomplabel.h \
	glcomppanel.h glcompset.h glcomptexture.h \
	glpangofont.h glcomptextpng.h glcompfont.h glcompmouse.h \
	glutils.h glcompimage.h opengl.h

noinst_LTLIBRARIES = libglcomp_C.la
endif

libglcomp_C_la_SOURCES = glcompbutton.c glcomplabel.c \
	glcomppanel.c glcompset.c glcomptexture.c glcomptextpng.c\
	glpangofont.c glutils.c glcompimage.c glcompmouse.c glcompfont.c
