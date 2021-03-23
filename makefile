CC=gcc
CFLAGS=-I.
DEPS = custom-rts.h mbp-config.h serial.h
PREFIX = /usr/local

all: options compile

options:
	@echo mbp build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "CC       = ${CC}"

%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

compile: mbp.o custom-rts.o serial.o
	$(CC) -Wall -lmodbus -o mbp mbp.o custom-rts.o serial.o

install: all
	mkdir -p ${DESTDIR}${PREFIX}/bin
	cp -f mbp ${DESTDIR}${PREFIX}/bin
	chmod 755 ${DESTDIR}${PREFIX}/bin/mbp

clean:
	rm -f mbp *.o

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/mbp
