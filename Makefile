SPK_NAME = Watcher
SPK_VERS = $(shell date +%Y%m%d)
SPK_REV = 8
SPK_ICON = src/watcher.png

DEPENDS  =
SPK_DEPENDS = "python>3.0.0-4:git"

MAINTAINER = jrizza911
DESCRIPTION = Watcher is an automated movie NZB & Torrent searcher and snatcher. You can add a list of wanted movies and Watcher will automatically send the NZB or Torrent to your download client. Watcher also has basic post-processing capabilities such as renaming and moving. Watcher is a work in progress and plans to add more features in the future, but we will always prioritize speed and stability over features.
RELOAD_UI = yes
DISPLAY_NAME = Watcher
CHANGELOG = "Integrate with DSM5+6 Generic Service support and added to 'sc-download' group."

HOMEPAGE   = https://github.com/nosmokingbandit/Watcher3
LICENSE    = GPLv3
STARTABLE  = yes

SERVICE_USER = auto
SERVICE_SETUP = src/service-setup.sh
SERVICE_PORT = 9090
SERVICE_PORT_TITLE = $(DISPLAY_NAME)

# Admin link for in DSM UI
ADMIN_PORT = $(SERVICE_PORT)

WIZARDS_DIR = src/wizard/

COPY_TARGET = nop
POST_STRIP_TARGET = watcher_extra_install

# Pure Python package, make sure ARCH is not defined
override ARCH=

include ../../mk/spksrc.spk.mk

.PHONY: watcher_extra_install
watcher_extra_install: $(STAGING_DIR)/share/Watcher3
	install -m 755 -d $(STAGING_DIR)/var
	install -m 600 src/config.ini $(STAGING_DIR)/var/config.ini

$(STAGING_DIR)/share/Watcher:
	install -m 755 -d $(STAGING_DIR)/share
	cd $(STAGING_DIR)/share && git clone --depth=1 https://github.com/nosmokingbandit/Watcher3.git Watcher3
