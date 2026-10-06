import 'dart:math';

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class EmojiGuessQuestion {
  final String emojis;
  final String answer;
  final List<String> options;

  const EmojiGuessQuestion({
    required this.emojis,
    required this.answer,
    required this.options,
  });
}

class EmojiGuessScreen extends StatefulWidget {
  const EmojiGuessScreen({super.key});

  @override
  State<EmojiGuessScreen> createState() => _EmojiGuessScreenState();
}

class _EmojiGuessScreenState extends State<EmojiGuessScreen> {
  static const int questionsPerGame = 15;

  final Random _random = Random();

  // ---------------------------------------------------------------------------
  // 50 UNIQUE QUESTIONS
  // ---------------------------------------------------------------------------

  static const List<EmojiGuessQuestion> _questionBank = [
    EmojiGuessQuestion(
      emojis: '🦁 👑',
      answer: 'The Lion King',
      options: [
        'The Lion King',
        'Jungle Book',
        'Madagascar',
        'Zootopia',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '❄️ 👸 ⛄',
      answer: 'Frozen',
      options: [
        'Frozen',
        'Tangled',
        'Moana',
        'Brave',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '🕷️ 👨',
      answer: 'Spider-Man',
      options: [
        'Spider-Man',
        'Batman',
        'Superman',
        'Iron Man',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '🚢 💔 🌊',
      answer: 'Titanic',
      options: [
        'Titanic',
        'Avatar',
        'Jaws',
        'The Notebook',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '🧙 ⚡ 👓',
      answer: 'Harry Potter',
      options: [
        'Harry Potter',
        'The Hobbit',
        'Percy Jackson',
        'Narnia',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '🐠 🔍 🌊',
      answer: 'Finding Nemo',
      options: [
        'Finding Nemo',
        'Moana',
        'Shark Tale',
        'The Little Mermaid',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '🤖 ❤️ 🌱',
      answer: 'WALL-E',
      options: [
        'WALL-E',
        'Robots',
        'Big Hero 6',
        'Transformers',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '👻 🚫',
      answer: 'Ghostbusters',
      options: [
        'Ghostbusters',
        'Casper',
        'The Conjuring',
        'Beetlejuice',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '🦖 🏝️',
      answer: 'Jurassic Park',
      options: [
        'Jurassic Park',
        'King Kong',
        'Godzilla',
        'Avatar',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '🧸 🤠 🚀',
      answer: 'Toy Story',
      options: [
        'Toy Story',
        'Inside Out',
        'Cars',
        'Up',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '👸 🐸 💋',
      answer: 'The Princess and the Frog',
      options: [
        'The Princess and the Frog',
        'Cinderella',
        'Tangled',
        'Enchanted',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '🎈 🏠 ☁️',
      answer: 'Up',
      options: [
        'Up',
        'Inside Out',
        'Home',
        'Up in the Air',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '🐼 🥋',
      answer: 'Kung Fu Panda',
      options: [
        'Kung Fu Panda',
        'Mulan',
        'Kung Fu Hustle',
        'Zootopia',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '🧜‍♀️ 🌊 🐚',
      answer: 'The Little Mermaid',
      options: [
        'The Little Mermaid',
        'Moana',
        'Finding Nemo',
        'Aquaman',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '🦸‍♂️ 🛡️',
      answer: 'Captain America',
      options: [
        'Captain America',
        'Iron Man',
        'Thor',
        'Superman',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '🦸‍♂️ ⚡',
      answer: 'Superman',
      options: [
        'Superman',
        'Thor',
        'Captain America',
        'The Flash',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '🔨 ⚡ 👱‍♂️',
      answer: 'Thor',
      options: [
        'Thor',
        'Iron Man',
        'Superman',
        'Hulk',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '🦇 🌃',
      answer: 'Batman',
      options: [
        'Batman',
        'Spider-Man',
        'Superman',
        'Daredevil',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '🤖 🦸‍♂️ ❤️',
      answer: 'Iron Man',
      options: [
        'Iron Man',
        'Robocop',
        'Batman',
        'Ant-Man',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '👸 🍎 😴',
      answer: 'Snow White',
      options: [
        'Snow White',
        'Cinderella',
        'Sleeping Beauty',
        'Tangled',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '👸 🏹 🐻',
      answer: 'Brave',
      options: [
        'Brave',
        'Frozen',
        'Mulan',
        'Tangled',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '🌊 🏝️ 🐚',
      answer: 'Moana',
      options: [
        'Moana',
        'Frozen',
        'The Little Mermaid',
        'Luca',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '🐀 👨‍🍳 🍲',
      answer: 'Ratatouille',
      options: [
        'Ratatouille',
        'Cars',
        'Chef',
        'The Incredibles',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '🚗 🏁',
      answer: 'Cars',
      options: [
        'Cars',
        'Fast & Furious',
        'Turbo',
        'Speed Racer',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '👹 🧅',
      answer: 'Shrek',
      options: [
        'Shrek',
        'Monsters Inc.',
        'Hulk',
        'Trolls',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '👹 🚪 👁️',
      answer: 'Monsters Inc.',
      options: [
        'Monsters Inc.',
        'Shrek',
        'Hotel Transylvania',
        'Toy Story',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '🎈 🤡',
      answer: 'It',
      options: [
        'It',
        'The Conjuring',
        'Annabelle',
        'Scream',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '🔪 😱',
      answer: 'Scream',
      options: [
        'Scream',
        'Halloween',
        'It',
        'Friday the 13th',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '🧠 ❤️ 🎭',
      answer: 'Inside Out',
      options: [
        'Inside Out',
        'Soul',
        'Up',
        'Coco',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '💀 🎸 🇲🇽',
      answer: 'Coco',
      options: [
        'Coco',
        'Soul',
        'Encanto',
        'The Book of Life',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '🧞‍♂️ 🪔 👸',
      answer: 'Aladdin',
      options: [
        'Aladdin',
        'Hercules',
        'The Lion King',
        'Mulan',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '🌹 👸 🐻',
      answer: 'Beauty and the Beast',
      options: [
        'Beauty and the Beast',
        'Cinderella',
        'Frozen',
        'Tangled',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '👸 🐎 🗼',
      answer: 'Tangled',
      options: [
        'Tangled',
        'Cinderella',
        'Frozen',
        'Brave',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '🧑‍🚀 🌌 🚀',
      answer: 'Interstellar',
      options: [
        'Interstellar',
        'Gravity',
        'The Martian',
        'Avatar',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '🚀 🌌 👽',
      answer: 'Star Wars',
      options: [
        'Star Wars',
        'Star Trek',
        'Interstellar',
        'Avatar',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '🧑‍🚀 🔴 🌌',
      answer: 'The Martian',
      options: [
        'The Martian',
        'Interstellar',
        'Gravity',
        'Apollo 13',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '🦈 🌊',
      answer: 'Jaws',
      options: [
        'Jaws',
        'Finding Nemo',
        'Shark Tale',
        'The Meg',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '🦍 🏙️',
      answer: 'King Kong',
      options: [
        'King Kong',
        'Godzilla',
        'Jurassic Park',
        'Rampage',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '🦎 🏙️',
      answer: 'Godzilla',
      options: [
        'Godzilla',
        'King Kong',
        'Jurassic Park',
        'Pacific Rim',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '🧑‍🚀 🌕 🚀',
      answer: 'Apollo 13',
      options: [
        'Apollo 13',
        'Interstellar',
        'The Martian',
        'Gravity',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '🎤 👑',
      answer: 'Bohemian Rhapsody',
      options: [
        'Bohemian Rhapsody',
        'Elvis',
        'Rocketman',
        'A Star Is Born',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '🎤 🚀',
      answer: 'Rocketman',
      options: [
        'Rocketman',
        'Bohemian Rhapsody',
        'Elvis',
        'Yesterday',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '🧑‍🎤 ⭐ 🎤',
      answer: 'A Star Is Born',
      options: [
        'A Star Is Born',
        'Rocketman',
        'La La Land',
        'Elvis',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '🦸‍♀️ ⭐ 🛡️',
      answer: 'Wonder Woman',
      options: [
        'Wonder Woman',
        'Captain Marvel',
        'Black Widow',
        'Supergirl',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '🕶️ 💊 💻',
      answer: 'The Matrix',
      options: [
        'The Matrix',
        'Inception',
        'Avatar',
        'Tron',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '🧠 💤 🏙️',
      answer: 'Inception',
      options: [
        'Inception',
        'The Matrix',
        'Interstellar',
        'Shutter Island',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '🎩 🐇 ⏰',
      answer: 'Alice in Wonderland',
      options: [
        'Alice in Wonderland',
        'Peter Pan',
        'The Wizard of Oz',
        'Narnia',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '👧 🐺 🌲',
      answer: 'Red Riding Hood',
      options: [
        'Red Riding Hood',
        'Snow White',
        'Brave',
        'Alice in Wonderland',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '👨‍👩‍👧‍👦 🏠 ✨',
      answer: 'Encanto',
      options: [
        'Encanto',
        'Coco',
        'Moana',
        'Turning Red',
      ],
    ),

    EmojiGuessQuestion(
      emojis: '🐼 ❤️ 👨‍👧',
      answer: 'Turning Red',
      options: [
        'Turning Red',
        'Kung Fu Panda',
        'Encanto',
        'Brave',
      ],
    ),
  ];

  List<EmojiGuessQuestion> _gameQuestions = [];

  int _currentQuestion = 0;
  int _score = 0;
  int _correctAnswers = 0;
  int _wrongAnswers = 0;

  String? _selectedAnswer;
  bool _hasAnswered = false;

  @override
  void initState() {
    super.initState();
    _startNewGame();
  }

  // ---------------------------------------------------------------------------
  // START NEW GAME
  // ---------------------------------------------------------------------------

  void _startNewGame() {
    final shuffledQuestions =
        List<EmojiGuessQuestion>.from(_questionBank);

    // Randomize all 50 questions.
    shuffledQuestions.shuffle(_random);

    // Pick 15 different questions for this game.
    _gameQuestions =
        shuffledQuestions.take(questionsPerGame).map((question) {
      final shuffledOptions =
          List<String>.from(question.options);

      // Randomize answer choices too.
      shuffledOptions.shuffle(_random);

      return EmojiGuessQuestion(
        emojis: question.emojis,
        answer: question.answer,
        options: shuffledOptions,
      );
    }).toList();

    setState(() {
      _currentQuestion = 0;
      _score = 0;
      _correctAnswers = 0;
      _wrongAnswers = 0;
      _selectedAnswer = null;
      _hasAnswered = false;
    });
  }

  // ---------------------------------------------------------------------------
  // ANSWER QUESTION
  // ---------------------------------------------------------------------------

  void _selectAnswer(String answer) {
    if (_hasAnswered) return;

    final question = _gameQuestions[_currentQuestion];

    final isCorrect = answer == question.answer;

    setState(() {
      _selectedAnswer = answer;
      _hasAnswered = true;

      if (isCorrect) {
        _score++;
        _correctAnswers++;
      } else {
        _wrongAnswers++;
      }
    });
  }

  // ---------------------------------------------------------------------------
  // NEXT QUESTION
  // ---------------------------------------------------------------------------

  void _nextQuestion() {
    if (!_hasAnswered) return;

    if (_currentQuestion == _gameQuestions.length - 1) {
      _showResults();
      return;
    }

    setState(() {
      _currentQuestion++;
      _selectedAnswer = null;
      _hasAnswered = false;
    });
  }

  // ---------------------------------------------------------------------------
  // RESULTS
  // ---------------------------------------------------------------------------

  void _showResults() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => EmojiGuessResultScreen(
          score: _score,
          correctAnswers: _correctAnswers,
          wrongAnswers: _wrongAnswers,
          totalQuestions: _gameQuestions.length,
          onPlayAgain: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const EmojiGuessScreen(),
              ),
            );
          },
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // BACK TO GAMES
  // ---------------------------------------------------------------------------

  void _backToGames() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final question = _gameQuestions[_currentQuestion];

    final progress =
        (_currentQuestion + 1) / _gameQuestions.length;

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
          onPressed: _backToGames,
        ),
        title: const Text(
          'Emoji Guess',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
          child: Column(
            children: [
              // QUESTION + SCORE
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Question ${_currentQuestion + 1} / ${_gameQuestions.length}',
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Score: $_score',
                    style: const TextStyle(
                      color: AppColors.accentRed,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // PROGRESS
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 7,
                  backgroundColor: const Color(0xFF252A36),
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(
                    AppColors.accentRed,
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // EMOJI CARD
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 40,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF161A24),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppColors.accentRed
                        .withValues(alpha: 0.22),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accentRed
                          .withValues(alpha: 0.08),
                      blurRadius: 25,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'What do these emojis mean?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 25),

                    Text(
                      question.emojis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 55,
                        height: 1.25,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // ANSWER OPTIONS
              ...question.options.map(
                (option) => _answerButton(
                  option,
                  question.answer,
                ),
              ),

              const SizedBox(height: 20),

              // FEEDBACK
              if (_hasAnswered)
                _feedbackCard(question.answer),

              const SizedBox(height: 16),

              // NEXT BUTTON
              if (_hasAnswered)
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _nextQuestion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accentRed,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      _currentQuestion ==
                              _gameQuestions.length - 1
                          ? 'See Results'
                          : 'Next Question',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // ANSWER BUTTON
  // ---------------------------------------------------------------------------

  Widget _answerButton(
    String option,
    String correctAnswer,
  ) {
    final isSelected = _selectedAnswer == option;
    final isCorrect = option == correctAnswer;

    Color borderColor =
        AppColors.textSecondary.withValues(alpha: 0.18);

    Color backgroundColor = const Color(0xFF161A24);

    IconData? icon;

    if (_hasAnswered) {
      if (isCorrect) {
        borderColor = Colors.greenAccent;
        backgroundColor =
            Colors.green.withValues(alpha: 0.12);
        icon = Icons.check_circle_rounded;
      } else if (isSelected) {
        borderColor = Colors.redAccent;
        backgroundColor =
            Colors.red.withValues(alpha: 0.12);
        icon = Icons.cancel_rounded;
      }
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: _hasAnswered
            ? null
            : () => _selectAnswer(option),
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration:
              const Duration(milliseconds: 220),
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 17,
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: borderColor,
              width: 1.3,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  option,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              if (icon != null)
                Icon(
                  icon,
                  color: isCorrect
                      ? Colors.greenAccent
                      : Colors.redAccent,
                  size: 22,
                ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // FEEDBACK CARD
  // ---------------------------------------------------------------------------

  Widget _feedbackCard(String correctAnswer) {
    final isCorrect = _selectedAnswer == correctAnswer;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: isCorrect
            ? Colors.green.withValues(alpha: 0.10)
            : Colors.red.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCorrect
              ? Colors.greenAccent.withValues(alpha: 0.35)
              : Colors.redAccent.withValues(alpha: 0.35),
        ),
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Icon(
            isCorrect
                ? Icons.check_circle_rounded
                : Icons.info_outline_rounded,
            color: isCorrect
                ? Colors.greenAccent
                : Colors.redAccent,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  isCorrect
                      ? 'Correct! 🎉'
                      : 'Not quite!',
                  style: TextStyle(
                    color: isCorrect
                        ? Colors.greenAccent
                        : Colors.redAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),

                if (!isCorrect) ...[
                  const SizedBox(height: 5),
                  Text(
                    'Correct answer: $correctAnswer',
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// RESULTS SCREEN
// =============================================================================

class EmojiGuessResultScreen extends StatelessWidget {
  final int score;
  final int correctAnswers;
  final int wrongAnswers;
  final int totalQuestions;
  final VoidCallback onPlayAgain;

  const EmojiGuessResultScreen({
    super.key,
    required this.score,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.totalQuestions,
    required this.onPlayAgain,
  });

  @override
  Widget build(BuildContext context) {
    final percentage =
        ((correctAnswers / totalQuestions) * 100).round();

    String message;

    if (percentage == 100) {
      message = 'Perfect score! 🏆';
    } else if (percentage >= 80) {
      message = 'Amazing job! 🔥';
    } else if (percentage >= 60) {
      message = 'Great work! 🎉';
    } else if (percentage >= 40) {
      message = 'Good try! 💪';
    } else {
      message = 'Keep practicing! 😊';
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Game Results',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.accentRed
                        .withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.accentRed
                          .withValues(alpha: 0.35),
                    ),
                  ),
                  child: const Icon(
                    Icons.emoji_events_rounded,
                    color: AppColors.accentRed,
                    size: 50,
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  'Game Over!',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  message,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 30),

                // SCORE
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF161A24),
                    borderRadius:
                        BorderRadius.circular(22),
                    border: Border.all(
                      color: AppColors.accentRed
                          .withValues(alpha: 0.22),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'FINAL SCORE',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        '$score / $totalQuestions',
                        style: const TextStyle(
                          color: AppColors.accentRed,
                          fontSize: 42,
                          fontWeight: FontWeight.w900,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        '$percentage%',
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // STATS
                Row(
                  children: [
                    Expanded(
                      child: _resultStat(
                        icon: Icons.check_circle_rounded,
                        title: 'Correct',
                        value:
                            correctAnswers.toString(),
                        color: Colors.greenAccent,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: _resultStat(
                        icon: Icons.cancel_rounded,
                        title: 'Wrong',
                        value:
                            wrongAnswers.toString(),
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // PLAY AGAIN
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: onPlayAgain,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          AppColors.accentRed,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Play Again',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // BACK TO GAMES
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor:
                          AppColors.textPrimary,
                      side: BorderSide(
                        color: AppColors.textSecondary
                            .withValues(alpha: 0.3),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Back to Games',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _resultStat({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF161A24),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 26,
          ),

          const SizedBox(height: 7),

          Text(
            value,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 3),

          Text(
            title,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}