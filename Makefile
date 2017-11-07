DEBUG = 0
ARCHS = armv7 arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ActiHastebin
ActiHastebin_FILES = Tweak.xm
ActiHastebin_FRAMEWORKS = UIKit
ActiHastebin_LDFLAGS = -lactivator
ActiHastebin_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	killall -9 SpringBoard
