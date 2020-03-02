export my_ps="linux-desktop"

if [ -n "${DISPLAY}" ]; then
    export BROWSER=google-chrome
else
    export BROWSER=lynx
fi
