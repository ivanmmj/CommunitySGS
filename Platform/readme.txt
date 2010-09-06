How to build


1. Get android open source. 
    : version info - Android eclair 2.1 (android-2.1_r2)
     ( Download site : http://source.android.com )

2. Overwrite modules that you want to build.

3. Add the following lines at the end of build/target/board/generic/BoardConfig.mk

BOARD_HAVE_BLUETOOTH := true
BT_USE_BTL_IF := true
BT_ALT_STACK := true
BRCM_BTL_INCLUDE_A2DP := true
BRCM_BT_USE_BTL_IF := true

4. make update-api
5. make
