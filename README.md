**Requirements**

- Hack font
- aspell on Unix-like and husnpell for Windows

**Bash Function**

*OS X*

``` bash
EMACSPATH=/usr/local/Cellar/emacs/26.1_1/Emacs.app

function emacs {
    if ! (emacsclient --eval "t"  2> /dev/null > /dev/null)
    then
        # There is no server available so,
        # Start Emacs.app detached from the terminal
        # and change Emac's directory to PWD

        open -a ${EMACSPATH} --args --chdir "${PWD}" "${@}"
    else
        # The emacs server is available so use emacsclient

        if [ -z "${@}" ]
        then
            # There are no arguments, so
            # tell emacs to open a new window

            open -a ${EMACSPATH} --args --chdir "${PWD}" "${@}"
        else
            # There are arguments, so
            # tell emacs to open them

            command emacsclient --no-wait "${@}"
        fi

        # Bring emacs to the foreground

        command emacsclient --eval "(x-focus-frame nil)"
    fi

}
```

*UNIX-LIKE*


Not tested.

``` bash
function emacs {
    if ! (emacsclient --eval "t"  2> /dev/null > /dev/null)
    then
        # There is no server available so,
        # Start Emacs.app detached from the terminal
        # and change Emac's directory to PWD

        command nohup ${EMACSPATH} --chdir "${PWD}" "${@}" 2>&1 > /dev/null &
    else
        # The emacs server is available so use emacsclient

        if [ -z "${@}" ]
        then
            # There are no arguments, so
            # tell emacs to open a new window

            command emacsclient --eval "(list-directory \"${PWD}\")"
        else
            # There are arguments, so
            # tell emacs to open them

            command emacsclient --no-wait "${@}"
        fi

        # Bring emacs to the foreground

        command emacsclient --eval "(x-focus-frame nil)"
    fi

}
```
