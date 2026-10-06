import 'package:flutter/material.dart';

import '../../features/dashboard/dashboard_screen.dart';
import '../../core/constants/app_colors.dart';
import '../../data/question_model.dart';
import '../../data/questions.dart';

class QuestionnaireScreen extends StatefulWidget {
  const QuestionnaireScreen({super.key});

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  int _currentIndex = 0;

  final Map<int, dynamic> _answers = {};

  final TextEditingController _textController = TextEditingController();

  Question get _currentQuestion => questions[_currentIndex];

  bool get _isLastQuestion => _currentIndex == questions.length - 1;

  @override
  void initState() {
    super.initState();
    _loadTextAnswer();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  // --------------------------------------------------
  // LOAD TEXT ANSWER
  // --------------------------------------------------

  void _loadTextAnswer() {
    final question = _currentQuestion;

    if (question.type == QuestionType.shortAnswer ||
        question.type == QuestionType.longAnswer) {
      _textController.text =
          (_answers[question.id] as String?) ?? '';
    } else {
      _textController.clear();
    }
  }

  // --------------------------------------------------
  // SAVE CURRENT ANSWER
  // --------------------------------------------------

  void _saveCurrentAnswer() {
    final question = _currentQuestion;

    if (question.type == QuestionType.shortAnswer ||
        question.type == QuestionType.longAnswer) {
      _answers[question.id] = _textController.text.trim();
    }
  }

  // --------------------------------------------------
  // VALIDATE CURRENT QUESTION
  // --------------------------------------------------

  bool _validateCurrentQuestion() {
    final question = _currentQuestion;

    // Optional questions can always continue.
    if (!question.required) {
      return true;
    }

    final answer = _answers[question.id];

    if (question.type == QuestionType.shortAnswer ||
        question.type == QuestionType.longAnswer) {
      return _textController.text.trim().isNotEmpty;
    }

    if (question.type == QuestionType.singleChoice ||
        question.type == QuestionType.colour) {
      return answer != null;
    }

    if (question.type == QuestionType.multipleChoice) {
      return answer != null && (answer as List).isNotEmpty;
    }

    return true;
  }

  // --------------------------------------------------
  // NEXT QUESTION
  // --------------------------------------------------

  void _nextQuestion() {
    _saveCurrentAnswer();

    if (!_validateCurrentQuestion()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.accentRed,
          content: Text(
            'Please answer this question before continuing.',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
      return;
    }

    // If this is the final question,
    // finish the questionnaire and open Dashboard.
    if (_isLastQuestion) {
      _finishQuestionnaire();
      return;
    }

    // Otherwise move to the next question.
    setState(() {
      _currentIndex++;
      _loadTextAnswer();
    });
  }

  // --------------------------------------------------
  // PREVIOUS QUESTION
  // --------------------------------------------------

  void _previousQuestion() {
    _saveCurrentAnswer();

    if (_currentIndex == 0) {
      Navigator.pop(context);
      return;
    }

    setState(() {
      _currentIndex--;
      _loadTextAnswer();
    });
  }

  // --------------------------------------------------
  // SKIP QUESTION
  // --------------------------------------------------

  void _skipQuestion() {
    final question = _currentQuestion;

    // Remove any existing answer.
    _answers.remove(question.id);

    if (_isLastQuestion) {
      _finishQuestionnaire();
      return;
    }

    setState(() {
      _currentIndex++;
      _loadTextAnswer();
    });
  }

  // --------------------------------------------------
  // FINISH QUESTIONNAIRE
  // --------------------------------------------------

  void _finishQuestionnaire() {
    _saveCurrentAnswer();

    debugPrint('Questionnaire answers: $_answers');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const DashboardScreen(),
      ),
    );
  }

  // --------------------------------------------------
  // SINGLE CHOICE
  // --------------------------------------------------

  void _selectSingleChoice(String option) {
    setState(() {
      _answers[_currentQuestion.id] = option;
    });
  }

  // --------------------------------------------------
  // MULTIPLE CHOICE
  // --------------------------------------------------

  void _toggleMultipleChoice(String option) {
    final questionId = _currentQuestion.id;

    final List<String> selected = List<String>.from(
      (_answers[questionId] as List?) ?? [],
    );

    if (selected.contains(option)) {
      selected.remove(option);
    } else {
      selected.add(option);
    }

    setState(() {
      _answers[questionId] = selected;
    });
  }

  // --------------------------------------------------
  // COLOUR
  // --------------------------------------------------

  void _selectColour(String colour) {
    setState(() {
      _answers[_currentQuestion.id] = colour;
    });
  }

  // --------------------------------------------------
  // BUILD
  // --------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final question = _currentQuestion;
    final progress = (_currentIndex + 1) / questions.length;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // --------------------------------------------------
            // TOP BAR
            // --------------------------------------------------

            Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                18,
                20,
                10,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: _previousQuestion,
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'Getting to Know You',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            // --------------------------------------------------
            // PROGRESS
            // --------------------------------------------------

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 28,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Question ${_currentIndex + 1} of ${questions.length}',
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        '${(progress * 100).round()}%',
                        style: const TextStyle(
                          color: AppColors.highlightGold,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                    backgroundColor:
                        AppColors.textSecondary
                            .withValues(alpha: 0.15),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(
                      AppColors.accentRed,
                    ),
                    borderRadius:
                        BorderRadius.circular(10),
                  ),
                ],
              ),
            ),

            // --------------------------------------------------
            // QUESTION CONTENT
            // --------------------------------------------------

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  28,
                  40,
                  28,
                  20,
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      question.section.toUpperCase(),
                      style: const TextStyle(
                        color: AppColors.highlightGold,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),

                    const SizedBox(height: 14),

                    Text(
                      question.question,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),

                    // --------------------------------------------------
                    // OPTIONAL LABEL
                    // --------------------------------------------------

                    if (!question.required) ...[
                      const SizedBox(height: 10),
                      const Text(
                        'Optional',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],

                    const SizedBox(height: 30),

                    _buildQuestionInput(question),
                  ],
                ),
              ),
            ),

            // --------------------------------------------------
            // BOTTOM NAVIGATION
            // --------------------------------------------------

            Padding(
              padding: const EdgeInsets.fromLTRB(
                28,
                10,
                28,
                25,
              ),
              child: Row(
                children: [
                  // --------------------------------------------------
                  // BACK
                  // --------------------------------------------------

                  if (_currentIndex > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _previousQuestion,
                        style: OutlinedButton.styleFrom(
                          minimumSize:
                              const Size(double.infinity, 54),
                          side: BorderSide(
                            color: AppColors.textSecondary
                                .withValues(alpha: 0.35),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'Back',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                  if (_currentIndex > 0)
                    const SizedBox(width: 12),

                  // --------------------------------------------------
                  // SKIP
                  // --------------------------------------------------

                  if (!question.required)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _skipQuestion,
                        style: OutlinedButton.styleFrom(
                          minimumSize:
                              const Size(double.infinity, 54),
                          side: BorderSide(
                            color: AppColors.textSecondary
                                .withValues(alpha: 0.35),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'Skip',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                  if (!question.required)
                    const SizedBox(width: 12),

                  // --------------------------------------------------
                  // NEXT / FINISH
                  // --------------------------------------------------

                  Expanded(
                    child: ElevatedButton(
                      onPressed: _nextQuestion,
                      style: ElevatedButton.styleFrom(
                        minimumSize:
                            const Size(double.infinity, 54),
                        backgroundColor:
                            AppColors.accentRed,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        _isLastQuestion
                            ? 'Finish'
                            : 'Next',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------
  // QUESTION INPUT
  // --------------------------------------------------

  Widget _buildQuestionInput(
    Question question,
  ) {
    switch (question.type) {
      // --------------------------------------------------
      // SHORT ANSWER
      // --------------------------------------------------

      case QuestionType.shortAnswer:
        return TextField(
          controller: _textController,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 15,
          ),
          maxLines: 1,
          decoration: InputDecoration(
            hintText: 'Type your answer...',
            hintStyle: const TextStyle(
              color: AppColors.textSecondary,
            ),
            filled: true,
            fillColor: AppColors.background,
            enabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(14),
              borderSide: BorderSide(
                color: AppColors.textSecondary
                    .withValues(alpha: 0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: AppColors.accentRed,
              ),
            ),
          ),
        );

      // --------------------------------------------------
      // LONG ANSWER
      // --------------------------------------------------

      case QuestionType.longAnswer:
        return TextField(
          controller: _textController,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 15,
          ),
          maxLines: 6,
          decoration: InputDecoration(
            hintText:
                'Tell me anything you would like to share...',
            hintStyle: const TextStyle(
              color: AppColors.textSecondary,
            ),
            filled: true,
            fillColor: AppColors.background,
            enabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(14),
              borderSide: BorderSide(
                color: AppColors.textSecondary
                    .withValues(alpha: 0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: AppColors.accentRed,
              ),
            ),
          ),
        );

      // --------------------------------------------------
      // SINGLE CHOICE
      // --------------------------------------------------

      case QuestionType.singleChoice:
        final selected =
            _answers[question.id] as String?;

        return Column(
          children: question.options.map(
            (option) {
              final isSelected =
                  selected == option;

              return _choiceButton(
                text: option,
                selected: isSelected,
                onTap: () =>
                    _selectSingleChoice(option),
              );
            },
          ).toList(),
        );

      // --------------------------------------------------
      // MULTIPLE CHOICE
      // --------------------------------------------------

      case QuestionType.multipleChoice:
        final selected = List<String>.from(
          (_answers[question.id] as List?) ?? [],
        );

        return Column(
          children: question.options.map(
            (option) {
              final isSelected =
                  selected.contains(option);

              return _choiceButton(
                text: option,
                selected: isSelected,
                multiple: true,
                onTap: () =>
                    _toggleMultipleChoice(option),
              );
            },
          ).toList(),
        );

      // --------------------------------------------------
      // COLOUR
      // --------------------------------------------------

      case QuestionType.colour:
        return _buildColourPicker();
    }
  }

  // --------------------------------------------------
  // CHOICE BUTTON
  // --------------------------------------------------

  Widget _choiceButton({
    required String text,
    required bool selected,
    required VoidCallback onTap,
    bool multiple = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      width: double.infinity,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 16,
          ),
          decoration: BoxDecoration(
            color: selected
                ? AppColors.accentRed
                    .withValues(alpha: 0.15)
                : Colors.transparent,
            borderRadius:
                BorderRadius.circular(14),
            border: Border.all(
              color: selected
                  ? AppColors.accentRed
                  : AppColors.textSecondary
                      .withValues(alpha: 0.3),
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                multiple
                    ? (selected
                        ? Icons.check_box_rounded
                        : Icons
                            .check_box_outline_blank_rounded)
                    : (selected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off),
                color: selected
                    ? AppColors.accentRed
                    : AppColors.textSecondary,
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    color:
                        AppColors.textPrimary,
                    fontSize: 15,
                    fontWeight: selected
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --------------------------------------------------
  // COLOUR PICKER
  // --------------------------------------------------

  Widget _buildColourPicker() {
    final colours = <String, Color>{
      'Red': Colors.red,
      'Blue': Colors.blue,
      'Green': Colors.green,
      'Yellow': Colors.yellow,
      'Purple': Colors.purple,
      'Pink': Colors.pink,
      'Black': Colors.black,
      'White': Colors.white,
      'Orange': Colors.orange,
    };

    final selected =
        _answers[_currentQuestion.id] as String?;

    return Wrap(
      spacing: 14,
      runSpacing: 14,
      children: colours.entries.map(
        (entry) {
          final isSelected =
              selected == entry.key;

          return GestureDetector(
            onTap: () =>
                _selectColour(entry.key),
            child: Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                color: entry.value,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.accentRed
                      : AppColors.textSecondary
                          .withValues(alpha: 0.3),
                  width: isSelected ? 4 : 1,
                ),
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      color: entry.key == 'White' ||
                              entry.key == 'Yellow'
                          ? Colors.black
                          : Colors.white,
                    )
                  : null,
            ),
          );
        },
      ).toList(),
    );
  }
}