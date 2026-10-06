import 'dart:math';

import 'package:flutter/material.dart';

class TicTacToeScreen extends StatefulWidget {
  const TicTacToeScreen({super.key});

  @override
  State<TicTacToeScreen> createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen>
    with SingleTickerProviderStateMixin {
  // ============================================================
  // COLORS
  // ============================================================

  static const Color background = Color(0xFF0B0D12);
  static const Color surface = Color(0xFF161A24);
  static const Color card = Color(0xFF101827);
  static const Color crimson = Color(0xFFE52535);

  // ============================================================
  // GAME VARIABLES
  // ============================================================

  bool isSinglePlayer = true;

  String playerSymbol = 'X';
  String opponentSymbol = 'O';

  List<String> board = List.filled(9, '');

  bool gameOver = false;
  bool isPlayerTurn = true;

  String? winner;
  List<int> winningCells = [];

  int playerScore = 0;
  int opponentScore = 0;
  int draws = 0;

  final Random random = Random();

  late AnimationController celebrationController;

  // ============================================================
  // INIT
  // ============================================================

  @override
  void initState() {
    super.initState();

    celebrationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
  }

  @override
  void dispose() {
    celebrationController.dispose();
    super.dispose();
  }

  // ============================================================
  // NEW GAME
  // ============================================================

  void startNewGame() {
    setState(() {
      board = List.filled(9, '');
      gameOver = false;
      winner = null;
      winningCells = [];

      if (isSinglePlayer) {
        isPlayerTurn = playerSymbol == 'X';
      } else {
        isPlayerTurn = true;
      }
    });

    // If player selected O, WithMe starts automatically.
    if (isSinglePlayer && playerSymbol == 'O') {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted && !gameOver) {
          makeComputerMove();
        }
      });
    }
  }

  // ============================================================
  // PLAYER MOVE
  // ============================================================

  void playMove(int index) {
    if (gameOver) return;

    if (board[index].isNotEmpty) return;

    // Prevent player from moving while computer is thinking.
    if (isSinglePlayer && !isPlayerTurn) return;

    final String symbol = isSinglePlayer
        ? playerSymbol
        : (isPlayerTurn ? 'X' : 'O');

    setState(() {
      board[index] = symbol;
    });

    checkGame();

    if (gameOver) return;

    // ----------------------------------------------------------
    // SINGLE PLAYER
    // ----------------------------------------------------------

    if (isSinglePlayer) {
      setState(() {
        isPlayerTurn = false;
      });

      Future.delayed(const Duration(milliseconds: 450), () {
        if (mounted && !gameOver) {
          makeComputerMove();
        }
      });
    }

    // ----------------------------------------------------------
    // TWO PLAYERS
    // ----------------------------------------------------------

    else {
      setState(() {
        isPlayerTurn = !isPlayerTurn;
      });
    }
  }

  // ============================================================
  // COMPUTER MOVE
  // ============================================================

  void makeComputerMove() {
    if (gameOver) return;

    final List<int> available = [];

    for (int i = 0; i < board.length; i++) {
      if (board[i].isEmpty) {
        available.add(i);
      }
    }

    if (available.isEmpty) return;

    int move = findBestMove();

    if (move == -1) {
      move = available[random.nextInt(available.length)];
    }

    setState(() {
      board[move] = opponentSymbol;
      isPlayerTurn = true;
    });

    checkGame();
  }

  // ============================================================
  // SMART AI
  // ============================================================

  int findBestMove() {
    // 1. Try to win.
    for (int i = 0; i < 9; i++) {
      if (board[i].isEmpty) {
        board[i] = opponentSymbol;

        final bool canWin =
            checkWinnerWithoutChangingState(opponentSymbol);

        board[i] = '';

        if (canWin) {
          return i;
        }
      }
    }

    // 2. Block the player.
    for (int i = 0; i < 9; i++) {
      if (board[i].isEmpty) {
        board[i] = playerSymbol;

        final bool playerCanWin =
            checkWinnerWithoutChangingState(playerSymbol);

        board[i] = '';

        if (playerCanWin) {
          return i;
        }
      }
    }

    // 3. Take center.
    if (board[4].isEmpty) {
      return 4;
    }

    // 4. Take a random available corner.
    final List<int> corners = [0, 2, 6, 8];

    final List<int> availableCorners = corners
        .where((index) => board[index].isEmpty)
        .toList();

    if (availableCorners.isNotEmpty) {
      return availableCorners[
          random.nextInt(availableCorners.length)];
    }

    // 5. No special move.
    return -1;
  }

  // ============================================================
  // CHECK WINNER WITHOUT CHANGING GAME
  // ============================================================

  bool checkWinnerWithoutChangingState(String symbol) {
    const List<List<int>> patterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (final pattern in patterns) {
      if (board[pattern[0]] == symbol &&
          board[pattern[1]] == symbol &&
          board[pattern[2]] == symbol) {
        return true;
      }
    }

    return false;
  }

  // ============================================================
  // CHECK GAME
  // ============================================================

  void checkGame() {
    String? gameWinner;
    List<int> cells = [];

    const List<List<int>> patterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (final pattern in patterns) {
      final String a = board[pattern[0]];
      final String b = board[pattern[1]];
      final String c = board[pattern[2]];

      if (a.isNotEmpty && a == b && b == c) {
        gameWinner = a;
        cells = pattern;
        break;
      }
    }

    // Someone won.
    if (gameWinner != null) {
      finishGame(gameWinner, cells);
      return;
    }

    // Draw.
    if (!board.contains('')) {
      setState(() {
        gameOver = true;
        winner = 'Draw';
        draws++;
      });

      showResultDialog(
        title: 'It’s a Draw 🤝',
        message: 'That was a close game!',
        isWin: false,
      );
    }
  }

  // ============================================================
  // FINISH GAME
  // ============================================================

  void finishGame(
    String gameWinner,
    List<int> cells,
  ) {
    final bool userWon = isSinglePlayer
        ? gameWinner == playerSymbol
        : gameWinner == 'X';

    setState(() {
      gameOver = true;
      winner = gameWinner;
      winningCells = cells;

      if (userWon) {
        playerScore++;
      } else {
        opponentScore++;
      }
    });

    // Celebration when player wins.
    if (userWon) {
      celebrationController.forward(from: 0);

      showResultDialog(
        title: 'You Win! 🎉',
        message: 'Amazing move! You won this round.',
        isWin: true,
      );
    } else {
      showResultDialog(
        title: isSinglePlayer
            ? 'WithMe Wins 🤖'
            : 'Player $gameWinner Wins!',
        message: isSinglePlayer
            ? 'Nice try! Let’s play another round.'
            : 'That was a great game!',
        isWin: false,
      );
    }
  }

  // ============================================================
  // GAME STATUS
  // ============================================================

  String getGameStatusText() {
    if (!gameOver) {
      if (isSinglePlayer) {
        return isPlayerTurn
            ? 'Your Turn'
            : 'WithMe is thinking...';
      }

      return 'Player ${isPlayerTurn ? 'X' : 'O'} Turn';
    }

    if (winner == 'Draw') {
      return 'It’s a Draw 🤝';
    }

    if (isSinglePlayer) {
      if (winner == playerSymbol) {
        return 'You Won! 🎉';
      }

      return 'WithMe Won 🤖';
    }

    return 'Player $winner Won!';
  }

  // ============================================================
  // RESULT DIALOG
  // ============================================================

  void showResultDialog({
    required String title,
    required String message,
    required bool isWin,
  }) {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            backgroundColor: surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Celebration.
                  if (isWin)
                    AnimatedBuilder(
                      animation: celebrationController,
                      builder: (context, child) {
                        final double scale =
                            1 + celebrationController.value * 0.25;

                        return Transform.scale(
                          scale: scale,
                          child: const Text(
                            '🎉',
                            style: TextStyle(fontSize: 60),
                          ),
                        );
                      },
                    )
                  else
                    Text(
                      winner == 'Draw' ? '🤝' : '🤖',
                      style: const TextStyle(fontSize: 55),
                    ),

                  const SizedBox(height: 16),

                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Score.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _dialogScore(
                        'You',
                        playerScore,
                      ),
                      const SizedBox(width: 35),
                      _dialogScore(
                        isSinglePlayer ? 'WithMe' : 'Player O',
                        opponentScore,
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),

                  Row(
                    children: [
                      Expanded(
                        child: _dialogButton(
                          text: 'Play Again',
                          filled: true,
                          onTap: () {
                            Navigator.pop(context);
                            startNewGame();
                          },
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: _dialogButton(
                          text: 'Exit',
                          filled: false,
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  // ============================================================
  // MODE SELECTOR
  // ============================================================

  void showModeSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Choose Game Mode',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 20),

              // 1 PLAYER
              _modeButton(
                icon: Icons.person_rounded,
                title: '1 Player',
                subtitle: 'Play against WithMe 🤖',
                onTap: () {
                  Navigator.pop(context);

                  setState(() {
                    isSinglePlayer = true;
                  });

                  showSymbolSelector();
                },
              ),

              const SizedBox(height: 12),

              // 2 PLAYERS
              _modeButton(
                icon: Icons.people_rounded,
                title: '2 Players',
                subtitle: 'Play with a friend',
                onTap: () {
                  Navigator.pop(context);

                  setState(() {
                    isSinglePlayer = false;
                    playerSymbol = 'X';
                    opponentSymbol = 'O';
                  });

                  startNewGame();
                },
              ),

              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  // ============================================================
  // SYMBOL SELECTOR
  // ============================================================

  void showSymbolSelector() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: const Text(
            'Choose Your Symbol',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _symbolButton(
                symbol: 'X',
                onTap: () {
                  Navigator.pop(context);

                  setState(() {
                    playerSymbol = 'X';
                    opponentSymbol = 'O';
                  });

                  startNewGame();
                },
              ),

              const SizedBox(width: 20),

              _symbolButton(
                symbol: 'O',
                onTap: () {
                  Navigator.pop(context);

                  setState(() {
                    playerSymbol = 'O';
                    opponentSymbol = 'X';
                  });

                  startNewGame();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // ============================================================
  // MAIN UI
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      // ----------------------------------------------------------
      // APP BAR
      // ----------------------------------------------------------

      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          'Tic-Tac-Toe',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),

        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings_rounded,
              color: Colors.white70,
            ),
            onPressed: showModeSelector,
          ),
        ],
      ),

      // ----------------------------------------------------------
      // BODY
      // ----------------------------------------------------------

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
          child: Column(
            children: [
              // --------------------------------------------------
              // SCORE
              // --------------------------------------------------

              Row(
                children: [
                  Expanded(
                    child: _scoreCard(
                      title: 'You',
                      symbol: playerSymbol,
                      score: playerScore,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _scoreCard(
                      title:
                          isSinglePlayer ? 'WithMe' : 'Player O',
                      symbol: opponentSymbol,
                      score: opponentScore,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // --------------------------------------------------
              // MODE LABEL
              // --------------------------------------------------

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  color: surface,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.05),
                  ),
                ),
                child: Text(
                  isSinglePlayer
                      ? '1 Player • You: $playerSymbol'
                      : '2 Players',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // --------------------------------------------------
              // STATUS
              // --------------------------------------------------

              Text(
                getGameStatusText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 16),

              // --------------------------------------------------
              // BOARD
              // --------------------------------------------------

              _buildBoard(),

              const SizedBox(height: 20),

              // --------------------------------------------------
              // BUTTONS
              // --------------------------------------------------

              Row(
                children: [
                  Expanded(
                    child: _actionButton(
                      icon: Icons.refresh_rounded,
                      text: 'New Game',
                      onTap: startNewGame,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: _actionButton(
                      icon: Icons.swap_horiz_rounded,
                      text: 'Change Mode',
                      onTap: showModeSelector,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              Text(
                isSinglePlayer
                    ? 'You are $playerSymbol • WithMe is $opponentSymbol'
                    : 'Player X starts the game',
                style: const TextStyle(
                  color: Colors.white38,
                  fontSize: 12,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                'Draws: $draws',
                style: const TextStyle(
                  color: Colors.white30,
                  fontSize: 11,
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // BOARD
  // ============================================================

  Widget _buildBoard() {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double availableWidth =
              constraints.maxWidth;

          // Keep board compact on desktop.
          final double boardSize =
              min(availableWidth, 390);

          return SizedBox(
            width: boardSize,
            height: boardSize,
            child: Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: crimson.withValues(alpha: 0.18),
                ),
                boxShadow: [
                  BoxShadow(
                    color: crimson.withValues(alpha: 0.08),
                    blurRadius: 25,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: GridView.builder(
                physics:
                    const NeverScrollableScrollPhysics(),
                itemCount: 9,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  final bool isWinning =
                      winningCells.contains(index);

                  return GestureDetector(
                    onTap: () => playMove(index),
                    child: AnimatedContainer(
                      duration:
                          const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color: isWinning
                            ? crimson.withValues(alpha: 0.25)
                            : card,
                        borderRadius:
                            BorderRadius.circular(16),
                        border: Border.all(
                          color: isWinning
                              ? crimson
                              : Colors.white
                                  .withValues(alpha: 0.06),
                          width: isWinning ? 2 : 1,
                        ),
                        boxShadow: isWinning
                            ? [
                                BoxShadow(
                                  color: crimson
                                      .withValues(alpha: 0.25),
                                  blurRadius: 15,
                                ),
                              ]
                            : null,
                      ),
                      child: Center(
                        child: AnimatedScale(
                          scale:
                              board[index].isEmpty ? 0.7 : 1,
                          duration: const Duration(
                            milliseconds: 180,
                          ),
                          child: Text(
                            board[index],
                            style: TextStyle(
                              color: board[index] == 'X'
                                  ? crimson
                                  : Colors.white,
                              fontSize: boardSize < 330
                                  ? 38
                                  : 42,
                              fontWeight:
                                  FontWeight.w900,
                              shadows:
                                  board[index].isNotEmpty
                                      ? [
                                          Shadow(
                                            color: board[
                                                        index] ==
                                                    'X'
                                                ? crimson
                                                    .withValues(
                                                        alpha:
                                                            0.5)
                                                : Colors
                                                    .white
                                                    .withValues(
                                                        alpha:
                                                            0.25),
                                            blurRadius: 12,
                                          ),
                                        ]
                                      : null,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // SCORE CARD
  // ============================================================

  Widget _scoreCard({
    required String title,
    required String symbol,
    required int score,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.06),
        ),
      ),
      child: Column(
        children: [
          Text(
            symbol,
            style: TextStyle(
              color:
                  symbol == 'X' ? crimson : Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 3),

          Text(
            title,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 2),

          Text(
            '$score',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ACTION BUTTON
  // ============================================================

  Widget _actionButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(
        icon,
        size: 18,
      ),
      label: Text(
        text,
        overflow: TextOverflow.ellipsis,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: surface,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          vertical: 13,
          horizontal: 10,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  // ============================================================
  // MODE BUTTON
  // ============================================================

  Widget _modeButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: card,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.07),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: crimson.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                icon,
                color: crimson,
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white38,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SYMBOL BUTTON
  // ============================================================

  Widget _symbolButton({
    required String symbol,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 85,
        height: 85,
        decoration: BoxDecoration(
          color: card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: symbol == 'X'
                ? crimson
                : Colors.white24,
            width: 2,
          ),
          boxShadow: symbol == 'X'
              ? [
                  BoxShadow(
                    color: crimson.withValues(alpha: 0.15),
                    blurRadius: 15,
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            symbol,
            style: TextStyle(
              color: symbol == 'X'
                  ? crimson
                  : Colors.white,
              fontSize: 42,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // DIALOG SCORE
  // ============================================================

  Widget _dialogScore(
    String title,
    int score,
  ) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 12,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          '$score',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // DIALOG BUTTON
  // ============================================================

  Widget _dialogButton({
    required String text,
    required bool filled,
    required VoidCallback onTap,
  }) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            filled ? crimson : card,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          vertical: 14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
