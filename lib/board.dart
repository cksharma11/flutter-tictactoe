import 'package:flutter/material.dart';
import 'package:tictactoe/constants.dart';
import './box.dart';

class Board extends StatefulWidget {
  @override
  BoardState createState() => BoardState();
}

class BoardState extends State<Board> {
  final xMoves = <int>{};
  final oMoves = <int>{};
  var board = INITIAL_BOARD;
  var currentPlayerIndex = 0;
  var isFinished = false;

  void _reset() {
    xMoves.clear();
    oMoves.clear();
    for (var i = 0; i < board.length; i++) {
      board[i] = EMPTY_POSITION;
    }
    currentPlayerIndex = 0;
    isFinished = false;
    print(board);
  }

  bool hasWon() {
    var moves = currentPlayerIndex == 0 ? xMoves : oMoves;
    return WINNING_COMBINATIONS.any(
        (combination) => combination.every((move) => moves.contains(move)));
  }

  bool isPositionEmpty(position) {
    return board[position] != EMPTY_POSITION;
  }

  void addPositionToPlayerMoves(position) {
    currentPlayerIndex == 0 ? xMoves.add(position) : oMoves.add(position);
  }

  void placeSymbolOnBoard(position) {
    board[position] = SYMBOLS[currentPlayerIndex];
  }

  void updateTurn() {
    currentPlayerIndex = 1 - currentPlayerIndex;
  }

  void setNewState(position, context) {
    addPositionToPlayerMoves(position);
    placeSymbolOnBoard(position);
    if (hasWon()) {
      Scaffold.of(context)
          .showSnackBar(_snakeBarMessage(WINNING_MESSAGE, false));
      isFinished = true;
      return;
    }
    updateTurn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text(TITLE),
      ),
      body: Builder(
        builder: (BuildContext bc) {
          return _buildBoxes(bc);
        },
      ),
    );
  }

  Widget _buildBoxes(BuildContext context) {
    void onTap(position) {
      setState(() {
        if (isPositionEmpty(position)) {
          Scaffold.of(context)
              .showSnackBar(_snakeBarMessage(PLACE_NOT_EMPTY_ERROR, true));
          return;
        }
        setNewState(position, context);
      });
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(30.0, 100, 30.0, 0),
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
        ),
        children: <Widget>[
          for (var position = 1; position <= 9; position++)
            Box(
              onTap: () {
                if (isFinished) return;
                onTap(position);
              },
              symbol: board[position],
            ),
          Icon(
            isFinished ? Icons.done : Icons.directions_run,
            color: Colors.white,
            size: 30,
          ),
          _message(SYMBOLS[currentPlayerIndex], 25),
          IconButton(
            icon: Icon(Icons.refresh),
            color: Colors.white,
            onPressed: () {
              setState(() {
                _reset();
              });
            },
          ),
        ],
      ),
    );
  }
}

Widget _message(String message, double fontSize) {
  return Center(
    child: Text(message,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
        )),
  );
}

Widget _snakeBarMessage(String message, bool error) {
  return SnackBar(
    content: Text(message),
    backgroundColor: error ? Colors.red : Colors.green,
  );
}
