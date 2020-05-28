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
    board[position] = symbols[currentPlayerIndex];
  }

  void updateTurn() {
    currentPlayerIndex = 1 - currentPlayerIndex;
  }

  void setNewState(position) {
    addPositionToPlayerMoves(position);
    placeSymbolOnBoard(position);
    if (hasWon()) {
      Scaffold.of(context).showSnackBar(_errorSnakeBar());
    }
    updateTurn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
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
          Scaffold.of(context).showSnackBar(_errorSnakeBar());
          return;
        }
        setNewState(position);
      });
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 150, 20, 150),
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
        ),
        children: <Widget>[
          for (var position = 1; position <= 9; position++)
            Box(
              onTap: () => onTap(position),
              symbol: board[position],
            ),
        ],
      ),
    );
  }
}

Widget _errorSnakeBar() {
  return SnackBar(content: Text(PLACE_NOT_EMPTY_ERROR));
}
