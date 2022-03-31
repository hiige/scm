PREFIX = "/usr/local"
BINDIR = "$(PREFIX)/bin"
CHIBI = $(shell which chibi-scheme)
CHIBIDIR = $(shell ls -d $(PREFIX)/share/chibi /usr/local/share/chibi/ /usr/share/chibi/ 2>/dev/null | cut -d ' ' -f 1)
LIBDIR = $(PREFIX)/lib/scm
IMG = "$(CHIBIDIR)/scm.img"

scm.img :
	chibi-scheme -I src -xchibi -mscm.img -d scm.img
scm :
	sed '1i\
'"#!$(CHIBI) -iscm.img" < src/scm.scm |\
sed '2a\
'"(libdir \"$(LIBDIR)\")" > scm
all : scm.img scm
install : all
	install -o 0644 scm.img "$(IMG)"
	install -o 0755 scm $(BINDIR)
	touch /etc/scmrc ~/.scmrc
	install -d $(LIBDIR)/scm
	install -o 644 src/scm/*.s[cl][dm] $(LIBDIR)/scm
clean :
	rm scm* 2>/dev/null
