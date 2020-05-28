final String X = "X";
final String O = "O";
final String EMPTY_POSITION = "";
final String TITLE = "Tic Tac Toe";
final String PLACE_NOT_EMPTY_ERROR = "There is already a symbol!";
final String WINNING_MESSAGE = "Current Player has won the game";

final List<String> INITIAL_BOARD = <String>[
  EMPTY_POSITION,
  EMPTY_POSITION,
  EMPTY_POSITION,
  EMPTY_POSITION,
  EMPTY_POSITION,
  EMPTY_POSITION,
  EMPTY_POSITION,
  EMPTY_POSITION,
  EMPTY_POSITION,
  EMPTY_POSITION
];
final WINNING_COMBINATIONS = [
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9],
  [1, 4, 7],
  [2, 5, 8],
  [3, 6, 9],
  [1, 5, 9],
  [3, 5, 7]
];
final SYMBOLS = <String>[X, O];
