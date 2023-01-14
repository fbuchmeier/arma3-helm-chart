# A list of Known Issues and their Solution

- Problem: `No more slot to add connection at XXX` in log output
  - Explanation: This occurs when no more ports are available for a client to
    connect to. For example when on a single server (or pod), ports 2302 and
    2502 are both occupied by the game and multiple headless clients try to
    connect.
  - Solution: Move the second process occupying port 2502 to e.g. 3002 to
    reserve enough room for ARMA 3

- Problem: `FileNotFoundError: [Errno 2] No such file or directory:
  '/arma3/arma3server'` on startup in log output

    ```text
    Logging in user 'noLookupWhenTemplating' to Steam Public...FAILED (Invalid Password)
    Installing ARMA 3
    Headless Clients: 0
    LAUNCHING ARMA SERVER WITH /arma3/arma3server -limitFPS=100 -world=empty
    -mod=""  -config="/arma3/configs/main.cfg" -port=2302 -name="main"
    -profiles="/arma3/configs/profiles"
    Traceback (most recent call last):
    File "/launch.py", line 144, in <module>
        with subprocess.Popen((launch.split(' ')), stdout=subprocess.PIPE,
        bufsize=1, universal_newlines=True,
        stderr=subprocess.STDOUT) as process:
    File "/usr/lib/python3.9/subprocess.py", line 951, in __init__
        self._execute_child(args, executable, preexec_fn, close_fds,
    File "/usr/lib/python3.9/subprocess.py", line 1823, in_execute_child
        raise child_exception_type(errno_num, err_msg, err_filename)
    ```

  - Explanation: The actual error is `Logging in user 'noLookupWhenTemplating'
    to Steam Public...FAILED (Invalid Password)`

  - Solution: Make sure to either set`credentials.steamUser` and
    `credentials.steamPassword` OR `useExistingSecret.enabled=true` when
    installing the chart.
    
- Problem: `ErrorMessage: Cannot open file '/arma3/steamapps/workshop/content/107410/1397683809\\addons\\anz_reducedhazemod'`

  - Explanation: Somehow the server (or the mods?) have problems loading upper-case files within mods. The above mentioned file is present, but with CamelCase: `/arma3/steamapps/workshop/content/107410/1397683809/addons/ANZ_ReducedHazeMod.pbo`

  - Solution: For any mod affected, create symlinks with lowercase filenames
    ```
    for m in 2554978758 2867537125 1397683809 ; do
      for i in /arma3/steamapps/workshop/content/107410/"$m"/addons/* ; do 
          ln -s "$i" "$(echo "$i" | tr '[:upper:]' '[:lower:]')" 
      done
    done
    ```
