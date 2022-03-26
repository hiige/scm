PREFIX = "/usr/local"
BINDIR = "$(PREFIX)/bin"
CHIBI = $(shell which chibi-scheme)
CHIBIDIR = $(shell ls -d $(PREFIX)/share/chibi /usr/local/share/chibi/ /usr/share/chibi/ 2>/dev/null | cut -d ' ' -f 1)
IMG := "$(CHIBIDIR)/scm.img"

scm.img :
	chibi-scheme -I src -xchibi -mscm.img -d scm.img
scm :
	sed '1i\
'"#!$(CHIBI) -iscm.img" < src/scm.scm > scm
all : scm.img scm
install : all
	install -o 0644 scm.img "$(IMG)"
	install -o 0755 scm $(BINDIR)
	touch /etc/scmrc ~/.scmrc
clean :
	rm scm* 2>/dev/null
