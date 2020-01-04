CFLAGS=-Wall -Werror -Os -I/usr/local/include
LDFLAGS=-L /usr/local/lib -lmosquitto -lgps -lm

BINDIR = /usr/local/bin
MANDIR  = /usr/local/man

OBJS = json.o

all: ocli

ocli: ocli.c $(OBJS)
	$(CC) $(CFLAGS) -o ocli ocli.c $(OBJS) $(LDFLAGS)

json.o: json.c json.h
ocli.o: json.h ocli.c utarray.h utstring.h

ocli.pdf: ocli.1
	groff -Tps -man ocli.1 > ocli.tmp_ && pstopdf -i ocli.tmp_ -o ocli.pdf && rm -f ocli.tmp_

install: ocli ocli.1
	install -m755 ocli $(DESTDIR)$(BINDIR)/ocli
	install -m644 ocli.1 $(DESTDIR)$(MANDIR)/man1/ocli.1

clean:
	rm -f *.o

clobber: clean
	rm -f ocli
