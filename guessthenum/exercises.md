# Lesson 2 & 3: Guess the Number: Exercises

This week, there are a couple of coding exercises. You are required to do *all* of the exercises.

Submit your exercises to us through email, to either of us. Our contacts are available on the website.

The dateline is by lesson 4, or 30/7/15.

**NOTICE: PLEASE DISCUSS THE PROBLEMS WITH YOUR CLASSMATES, BUT DO NOT SHARE CODE!**

## 1. Multiples of 3 and 5

Adapted from [Project Euler: Problem 1](https://projecteuler.net/problem=1).

If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.

Write a function, `problem1(n)`, that returns the sum of all the multiples of 3 or 5 below an integer `n`.

### Tips

When solving problems such as these, you will want to reduce the problem into a series of subproblems that can be easily solved. In this case, you have these two subproblems:

1. Divisiblity checks (i.e. is a number a multiple of `k`)
2. Iterate through all numbers below `n`.

## 2. Even Fibonacci Numbers

Adapted from [Project Euler: Problem 2](https://projecteuler.net/problem=2).

Each new term in the Fibonacci sequence is generated by adding the previous two terms. By starting with 1 and 2, the first 10 terms will be:

    1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...

Write a function, `problem2(n)`, that finds the sum of the even-valued terms in the Fibonacci sequence whose values do not exceed an integer `n`.

### Tips

Checking if a term is even is easy. Generating the Fibonacci sequence might not be.

Try rewriting each number of the Fibonacci sequence as the sum of the previous two terms.

    1, 2, 1 + 2 = 3, 2 + 3 = 5, 3 + 5 = 8, 5 + 8 = 13, ...

This should give you an idea as to how to generate the Fibonacci numbers.

## 3. Balanced Brackets

Adapted from [Rosetta Code: Balanced brackets](http://rosettacode.org/wiki/Balanced_brackets).

A string is balanced if it consists entirely of pairs of opening and closing brackets (in that order), none of which mis-nest.

For example, `((()())())` is balanced, but `(()))` is not.

Write a function, `problem3(cs)`, that takes in a string and checks if it is balanced.

### Notes

Arrays have not been covered yet. For now, use the following code:

```js
function problem3(cs) {
	// ...
	for (var i = 0; i < cs.length; ++i) {
		var c = cs[i]; // current character
		// ...
	}
	// ...
}
```

This will allow you to go through each character in the string.

### Tips

To solve this problem, observe the pattern of a balanced string. A balanced string has two properties:

1. As we iterate through the string, at no point should there be more closing brackets than opening brackets.
2. At the end, there should be an equal number of opening and closing brackets.

Think of why this is the case, and use these properties to solve the problem.
