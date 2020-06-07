# Mazes for Programmers - Ruby Implementations

This repository contains Ruby implementations of maze algorithms, copied or based upon those in the EXCELLENT book "Mazes for Programmers"

<https://pragprog.com/book/jbmaze/mazes-for-programmers> 

## Installing and Running Stuff

Work it out yourself! My only tip here is that you should use VS Code, at which point the Dev Container that's defined in this repository will
set you up with a Ruby development environment in which these scripts an be run.

Each of the algorithms has a demo script. So, assuming you have your Ruby environment set up you should be able to run...

... and this will generate two files in the `output` folder:

1. a `.png` containing an image of the maze
2. a `.txt` file containing an ASCII text represention of the maze

## Example Output

``` bash
ruby sidewinder_demo.rb
```

### Example Image Output
![](examples/sidewinder.png)

### Example Text Output

``` text
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
|                                                           |
+   +---+   +---+---+   +   +---+   +   +---+---+   +---+   +
|       |   |           |       |   |           |   |       |
+   +   +---+   +   +---+---+   +---+---+   +   +   +   +   +
|   |   |       |           |       |       |   |   |   |   |
+---+---+   +---+   +---+---+---+---+---+---+---+   +---+---+
|               |   |                                       |
+   +   +---+   +   +---+   +   +---+   +---+---+---+   +   +
|   |       |   |   |       |       |               |   |   |
+   +   +---+   +   +---+---+---+---+   +   +   +---+---+   +
|   |       |   |   |                   |   |   |           |
+   +   +---+---+   +---+---+   +---+   +   +---+---+   +   +
|   |           |           |       |   |   |           |   |
+   +---+   +   +   +   +---+---+   +---+---+---+   +---+   +
|       |   |   |   |   |                   |       |       |
+   +   +   +   +---+---+   +---+   +---+   +---+---+   +   +
|   |   |   |   |               |   |       |           |   |
+   +   +   +   +---+   +---+   +   +---+   +   +   +---+   +
|   |   |   |       |       |   |       |   |   |   |       |
+   +   +   +---+   +---+---+   +   +---+   +   +---+---+---+
|   |   |   |               |   |       |   |               |
+   +   +   +   +   +---+---+---+   +---+   +---+---+---+   +
|   |   |   |   |               |   |               |       |
+   +   +   +---+   +---+   +---+   +   +   +   +---+---+   +
|   |   |   |           |   |       |   |   |       |       |
+   +---+---+---+   +   +   +   +   +---+   +   +   +   +---+
|               |   |   |   |   |       |   |   |   |       |
+   +   +   +---+---+---+   +---+---+---+---+   +---+---+---+
|   |   |               |               |                   |
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+

```
 