# Lesson 6 & 7: Snake

For two weeks, you'll need to work on your own to produce a game. The game we're going to implement is [Snake](http://playsnake.org/). If you don't know what it is, visit the link to play the game and familiarize yourself with the rules.

Firstly, we'll start off with the backend, before we create a UI.

The way this is done is that you'll be given a long specification of the game mechanics, and then you need to write an object that satisfies the criteria. But you'll get some freedom in how you write the program.

# Specifications

You need the following values:

```js
Snake#grid = null;
Snake#gameState = null;
Snake#score = 0;
```

You can add more if you want. But the UI will use only these 3.

And you need the following functions:

```js
Snake(m, n);
Snake#step(dir);
```

That's all to it. But be warned: it is not easy to implement the functions.

## `Snake#grid`

Each element of the grid can be one of the following:

* null - Empty grid.
* 'F' - Food of the Snake.
* 'S' - Snake.

## `Snake#gameState`

`gameState` can take on any of these values:

* null - Game is ongoing.
* 'died' - The snake died, and the game has ended.

## `Snake#score`

This is the score of the game. You can implement the score in any way, as long as it makes sense.

## `Snake(m, n)`

The constructor takes in `m` and `n` which indicate the number of rows and columns respectively. You must create a grid with these dimensions.

Throw an error if the grid is smaller than 10 x 10.

You should also initialize the snake. The starting position can be anywhere you want.

## `Snake#step(dir)`

This function moves the snake forward by a step. Before we continue, we need to look at how the Snake is implemented.

### Stacks

Imagine a stack of plates.

![stack.gif](http://www.electronics.dit.ie/staff/tscarff/stack/stack.gif)

When you place a plate on top of a stack of plates (or the end of an array), we call this a `push` operation. This adds a plate onto the stack.

When we remove a plate, we'd usually remove it from the top (or the end of an array). This is called a `pop` operation`.

This is know as FIFO, or first in first out.

### Queues

Now, think of a human queue.

![queue.png](https://2.bp.blogspot.com/-9HpDYPgpmf8/UfRjeh_OU1I/AAAAAAAABdI/9Ja0p3ToUU0/s1600/queue.png)

When you join a queue at the start (or the start of an array), we call this `enqueue`, or `unshift` in JavaScript.

When you leave a queue at the end (or the end of an array), we call this `dequeue`, or `shift` in JavaScript.

### API

For more information on how to do these operations on a standard `Array`, [check the docs](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array).

### How does this relate to a snake?

If you played the game, you'll realize that on every "step" of the game, the snake "moves" forward by one step.

The way it moves is by removing the last element of the snake, and appending another element to the head of the snake.

And that mean the snake is a queue. This gives us an idea of how to implement the snake. Let's try it out.

```js
[
  {i: 0, j: 0},
  {i: 0, j: 1},
  {i: 0, j: 2},
  {i: 0, j: 3},
  {i: 0, j: 4}
]
```

This is a horizontal snake, starting from the top left corner and taking up 5 squares. In the snake game, it looks like:

[TO BE ADDED]

If we're moving west, all we need to do is to find the new head. This is:

```js
{i: 0, j: 5}
```

We derived this from the previous head, by adding 1 to the `j` value.

Next, we remove the tail. This results in a snake that looks like this:

```js
[
  {i: 0, j: 1},
  {i: 0, j: 2},
  {i: 0, j: 3},
  {i: 0, j: 4},
  {i: 0, j: 5}
]
```

and in the game:

[TO BE ADDED]

The mechanism of moving is slightly more complex than that, but at least we have a general idea of how to implement the snake: using an array of coordinates.

### Cases

There're a couple of cases that you need to handle very carefully.

There are four scenarios:
1. The snake makes an invalid move.
2. The snake dies on the next move (either by hitting the wall or eating itself).
3. The snake eats food and moves.
4. The snake moves.

And this is how you check for them:

1. The snake makes an invalid move when it moves in the opposite direction of its previous move. (Why is this the case? This is for you to figure out.)
2. Check if the new coordinate of the head is out of bounds or already occupied by the snake itself.
3. This happens when the new coordinate of the head is occupied by food. When the snake eats it, you don't delete its tail and add on the new head. This extends its length by one.
4. Delete the tail and add on the new head.

You'll find that Snake is actually simpler than Tic Tac Toe to implement, but more tricky.

## Testing

Make sure you do some testing on the console before you proceed to the next part.

# UI

[TO BE ADDED]
