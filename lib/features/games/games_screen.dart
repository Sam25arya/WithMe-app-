import 'package:flutter/material.dart';

import 'tic_tac_toe_screen.dart';
import 'emoji_guess_screen.dart';
import '../../core/constants/app_colors.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final games = [
      {
        'title': 'Tic-Tac-Toe',
        'description': 'Challenge a friend to a classic match.',
        'icon': Icons.grid_3x3_rounded,
      },
      {
        'title': '20 Questions',
        'description': 'Think of something and let With Me guess it!',
        'icon': Icons.help_outline_rounded,
      },
      {
        'title': 'Guess the Word',
        'description': 'Can you guess the hidden word?',
        'icon': Icons.text_fields_rounded,
      },
      {
        'title': 'Emoji Guess',
        'description': 'Guess the movie, song or word from emojis.',
        'icon': Icons.emoji_emotions_outlined,
      },
      {
        'title': 'Memory Game',
        'description': 'Test your memory with matching cards.',
        'icon': Icons.memory_rounded,
      },
      {
        'title': 'This or That',
        'description': 'Choose between two fun options.',
        'icon': Icons.compare_arrows_rounded,
      },
      {
        'title': 'Story Builder',
        'description': 'Create a fun story together with With Me.',
        'icon': Icons.auto_stories_outlined,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: AppColors.textPrimary,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Games',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Let’s have some fun 🎮',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Choose a game to play with With Me.',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 28),

            Expanded(
              child: GridView.builder(
                itemCount: games.length,
                gridDelegate:
                    const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 350,
                  mainAxisExtent: 170,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  final game = games[index];

                  return _gameCard(
                    context,
                    title: game['title'] as String,
                    description: game['description'] as String,
                    icon: game['icon'] as IconData,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gameCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              if (title == 'Tic-Tac-Toe') {
                return const TicTacToeScreen();
              }

              if (title == 'Emoji Guess') {
                return const EmojiGuessScreen();
              }

              return GamePlayScreen(gameTitle: title);
            },
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF101827),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: AppColors.textSecondary.withValues(alpha: 0.18),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: AppColors.accentRed.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                color: AppColors.accentRed,
                size: 28,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 7),

                  Text(
                    description,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.textSecondary,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// GAME PLAY SCREEN
// -----------------------------------------------------------------------------

class GamePlayScreen extends StatelessWidget {
  final String gameTitle;

  const GamePlayScreen({
    super.key,
    required this.gameTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: AppColors.textPrimary,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          gameTitle,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.sports_esports_rounded,
                color: AppColors.accentRed,
                size: 70,
              ),

              const SizedBox(height: 24),

              Text(
                gameTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'Game screen coming next 🎮',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}