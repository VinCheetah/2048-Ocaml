# 2048 OCaml

## Description

This OCaml code is an implementation of the classic game "2048". The game is played on a 4x4 grid, where the player can make moves in four directions: up, down, left, and right. Tiles with the same value merge when they collide, and the goal is to reach the 2048 tile or the highest possible value by making strategic moves.

## Functions

### `decaler_gauche`

This function is responsible for shifting all non-zero elements in a list to the left, merging identical adjacent elements if necessary.

### `fusionner_gauche`

This function is used to merge identical elements that are adjacent after using the `decaler_gauche` function.

### `decaler_droite`

This function works similarly to `decaler_gauche`, but it shifts elements to the right.

### `fusionner_droite`

This function merges identical elements after using the `decaler_droite` function.

### `decaler_haut`

This function is used for shifting elements upward in a 2D array.

### `decaler_bas`

Similar to `decaler_haut`, this function shifts elements downward in a 2D array.

### `fusionner_bas` and `fusionner_haut`

These functions are responsible for merging identical elements after using the corresponding `decaler_bas` or `decaler_haut` function.

### `reperageListe`

A helper function that finds the positions of all zero elements in a 2D array and returns them as a list of coordinates.

### `choix_random`

This function chooses a random position from the list of zero elements returned by `reperageListe` and returns it. It is used to place a new tile (with value 2 or 4) on the board after each valid move.

### `copie_degeu_mais_geniale`

A helper function that creates a deep copy of a 2D array.

### `espaces`

A helper function to generate a string of spaces.

### `print_array`

This function is used to print the 2D array representation of the game board.

### `game`

This is the main game loop that takes user input, updates the game board based on the chosen direction, and places a new tile on the board. The loop continues until either the game is won (2048 tile achieved) or there are no more valid moves (game over).

### `launch_2048`

A function to start the 2048 game. It initializes the board with two random tiles (value 2) and calls the `game` function to begin the game loop.

## Usage

To play the 2048 game, simply call the `launch_2048` function. The game will prompt you to enter a direction (up, down, left, or right) for each move. The game will continue until you reach the 2048 tile or run out of valid moves.

Enjoy playing 2048 in OCaml!
