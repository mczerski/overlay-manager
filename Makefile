
PREFIX ?= /usr/local
CRONDIR = /etc/cron.hourly
INITDIR_SYSTEMD = /etc/systemd/system
BINDIR = $(PREFIX)/bin

RM = rm
INSTALL = install -p
INSTALL_PROGRAM = $(INSTALL) -m755
INSTALL_SCRIPT = $(INSTALL) -m755
INSTALL_DATA = $(INSTALL) -m644
INSTALL_DIR = $(INSTALL) -d

Q = @

help:
	$(Q)echo "install - install scripts"
	$(Q)echo "uninstall - uninstall scripts"

install:
	$(Q)echo -e '\033[1;32mInstalling main scripts...\033[0m'
	$(INSTALL_DIR) "$(BINDIR)"
	$(INSTALL_PROGRAM) bin/overlay_install "$(BINDIR)/overlay_install"
	$(INSTALL_PROGRAM) bin/overlay_mount "$(BINDIR)/overlay_mount"
	$(INSTALL_PROGRAM) bin/overlay_synch "$(BINDIR)/overlay_synch"
	$(Q)echo -e '\033[1;32mInstalling cronjob...\033[0m'
	$(INSTALL_DIR) "$(CRONDIR)"
	$(INSTALL_SCRIPT) cron/overlay_synch "$(CRONDIR)/overlay_synch"
	$(Q)echo -e '\033[1;32mInstalling systemd files...\033[0m'

uninstall:
	$(RM) "$(CRONDIR)/overlay_synch"
	$(RM) "$(BINDIR)/overlay_synch"
	$(RM) "$(BINDIR)/overlay_mount"
	$(RM) "$(BINDIR)/overlay_install"

.PHONY: install uninstall
