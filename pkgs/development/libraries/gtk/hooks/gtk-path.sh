# shellcheck shell=bash

makeGtkPath() {
    if [ -d "$1/lib/gtk-3.0" ]; then
        addToSearchPath GTK_PATH "$1/lib/gtk-3.0"
    fi

    if [ -d "$1/lib/gtk-2.0" ]; then
        addToSearchPath GTK_PATH "$1/lib/gtk-2.0"
    fi
}

addEnvHooks "${hostOffset:?}" makeGtkPath
