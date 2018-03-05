include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ActiHastebin
ActiHastebin_FILES = Tweak.m
ActiHastebin_FRAMEWORKS = UIKit
ActiHastebin_LIBRARIES = activator
ActiHastebin_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	killall -9 SpringBoard
