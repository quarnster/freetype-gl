# ============================================================================
# Freetype GL - A C OpenGL Freetype engine
# Platform:    Any
# API version: 1.0
# WWW:         http://code.google.com/p/freetype-gl/
# ----------------------------------------------------------------------------
# Copyright (c) 2011 Nicolas P. Rougier <Nicolas.Rougier@inria.fr>
# 
# This  program is free  software: you  can redistribute  it and/or  modify it
# under the terms  of the GNU General Public License as  published by the Free
# Software Foundation,  either version 3 of  the License, or  (at your option)
# any later version.
#
# This program is distributed in the  hope that it will be useful, but WITHOUT
# ANY  WARRANTY;  without even  the  implied  warranty  of MERCHANTABILITY  or
# FITNESS FOR  A PARTICULAR PURPOSE.  See  the GNU General  Public License for
# more details.
#
# You should have received a copy of the GNU General Public License along with
# this program. If not, see <http://www.gnu.org/licenses/>.
# ============================================================================
PLATFORM		= $(shell uname)
CC				= gcc
CFLAGS			= -Wall `freetype-config --cflags` `pkg-config --cflags fontconfig`
LIBS			= -lGL -lglut -lGLU \
	              `freetype-config --libs` `pkg-config --libs fontconfig`
ifeq ($(PLATFORM), Darwin)
	LIBS		= -framework OpenGL -framework GLUT \
	               `freetype-config --libs` `pkg-config --libs fontconfig`
endif

TARGETS := demo-font demo-texture demo-label demo-cube
#TARGETS := $($(wildcard demo-*.c):.c=)
HEADERS:= $(wildcard *.h)
SOURCES:= $(filter-out $(wildcard demo-*.c), $(wildcard *.c))
OBJECTS:= $(SOURCES:.c=.o)


all: ${TARGETS}

demo-font: ${OBJECTS} ${HEADERS} demo-font.o
	@echo -n "Building $@... "
	@$(CC) ${OBJECTS} demo-font.o $(LIBS) -o $@
	@echo "done."

demo-texture: ${OBJECTS} ${HEADERS} demo-texture.o
	@echo -n "Building $@... "
	@$(CC) ${OBJECTS} demo-texture.o $(LIBS) -o $@
	@echo "done."

demo-label: ${OBJECTS} ${HEADERS} demo-label.o
	@echo -n "Building $@... "
	@$(CC) ${OBJECTS} demo-label.o $(LIBS) -o $@
	@echo "done."

demo-cube: ${OBJECTS} ${HEADERS} demo-cube.o
	@echo -n "Building $@... "
	@$(CC) ${OBJECTS} demo-cube.o $(LIBS) -o $@
	@echo "done."

%.o : %.c
	@echo -n "Building $@... "
	@$(CC) -c $(CFLAGS) $< -o $@ 
	@echo "done."

clean:
	@-rm -f $(TARGETS) *.o

distclean: clean
	@-rm -f *~
