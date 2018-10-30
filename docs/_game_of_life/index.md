---
title: Game of Life in Every Language
layout: default
---

# Game of Life

For those of you that don't know, the Game of Life is basically a cell
simulation where cells are arranged in an infinite grid. Each cell has one
of two states: alive or dead.

At each turn, all cells are evaluated using the following rules:

- Any live cell with fewer than two live neighbors dies, as if caused by underpopulation.
- Any live cell with two or three live neighbors lives on to the next generation.
- Any live cell with more than three live neighbors dies, as if by overpopulation.
- Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.

For more information, check out the [Wikipedia page for Conway's Game of Life][1].

Of course, for the purposes of the repo, here are the requirements for a contribution:

1. Source code must fit in a single file
2. Grid must wrap-around on the edges (think [asteroids][2])
3. The program must support the following command line arguments
    - Grid width (assume square grid)
    - Frame rate (frames/second)
    - Total number of frames
    - Spawn rate (% of living vs. dead as decimal between 0 and 1)
4. Simulation must be a GUI
    - An exception to this rule can be made for languages where it's impossible
      or impractical to have an actual GUI. In that case, a terminal application
      is sufficient.

Beyond that, there's really no hard-and-fast requirements. All I ask is that
solutions are minimal. In other words, don't worry about command line options or
GUI elements. Keep it simple. Remember, the goal is to show off language features.

Also, I ask that you don't use external libraries. I like for these files to
be as easy as possible to test, so limiting dependencies is helpful.

[1]: https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life
[2]: https://en.wikipedia.org/wiki/Asteroids_(video_game)
