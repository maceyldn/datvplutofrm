################################################################################
#
# libsrt
#
################################################################################

LIBSRT_VERSION = 1.5.0
LIBSRT_SITE = https://github.com/Haivision/srt/archive/refs/tags
LIBSRT_SOURCE = v$(LIBSRT_VERSION).tar.gz
LIBSRT_LICENSE = LGPL-2.1+
LIBSRT_LICENSE_FILES = COPYING
LIBSRT_INSTALL_STAGING = YES
LIBSRT_CONF_OPTS= -DENABLE_ENCRYPTION=on -DENABLE_APPS=OFF
LIBSRT_DEPENDENCIES += openssl host-pkgconf

$(eval $(cmake-package))
