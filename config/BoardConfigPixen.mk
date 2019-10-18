include vendor/pixen/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/pixen/config/BoardConfigQcom.mk
endif

include vendor/pixen/config/BoardConfigSoong.mk
