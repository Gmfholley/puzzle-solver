# Solve puzzles

This repo solves a [Scramble Squares](https://www.amazon.com/B-Dazzle-Scramble-Squares-Kittens/dp/B000021Z0M) puzzle.  These puzzles are notoriously hard, with 9! * 4^9 possible solutions.

I tried and failed to solve this puzzle IRL, so I wrote this program. 😅


The solution to my puzzle is:

```
----------SOLVED------------
----------Card 3------------
Map:
  o   |   G   |   G  
S   s | S   o | O   s
  G   |   c   |   C  
  g   |   C   |   c  
G   o | O   s | S   o
  C   |   g   |   G  
  c   |   G   |   g  
C   O | o   S | s   c
  S   |   C   |   o 

```


It can also solve more generic puzzles.

It solves the placement of n cards on a map of defined tesselating shapes, where the cards have half of an image on each edge, either the top or bottom half.

```
 /⎻d⎻\ d d /
/D   D\_d_/
\d   d/ D \
 \_d_/D   d\

# Hexagonal tesselations


      /⎻⎻⎻\
     /     \
 /⎻⎻⎻\     /⎻⎻⎻\
/     \___/     \
\     /   \     /
 \___/     \___/
 /   \     /   \
/     \___/     \
\     /   \     /
 \___/     \___/
     \     /
      \___/


# Triangular tesselations


\⎻G⎻⎻/\⎻⎻H⎻/
 \so/OO\og/
  \/_d__\/
   \ D  /
    \dd/
     \/



\⎻⎻⎻⎻/\⎻⎻⎻⎻/
 \  /  \  /
  \/____\/
   \    /
    \  /
     \/
```


# Development Requirements

This repo requires ruby (see `.ruby-version` for version) and bundler.

`$ bundle install`


Use irb to work in a repl environment, and then require `app.rb` to work with any file in this repo.

```
$ irb
> require './app.rb'

=> true
pry>

```

# Testing

Tests are written in ruby unit test.

Require the `test/test.rb` file in your test file.

Run a test by running it as a ruby file:

```
$ ruby test/path/to/my_test.rb
=> Test results
```

# TODO

- [ ] Expand Solver to work for more than one set out of moves
- [ ] Create result object
- [ ] Update adjacent so it works in case values are 1/2 values or less than or equal to 1
- [ ] Add map to_s service
- [ ] Add tests

