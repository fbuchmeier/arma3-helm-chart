# A list of Known Issues and their Solution

- Problem: `No more slot to add connection at XXX` in log output
  - Explanation: This occurs when no more ports are available for a client to
    connect to. For example when on a single server (or pod), ports 2302 and
    2502 are both occupied by the game and multiple headless clients try to
    connect.
  - Solution: Move the second process occupying port 2502 to e.g. 3002 to
    reserve enough room for ARMA 3
