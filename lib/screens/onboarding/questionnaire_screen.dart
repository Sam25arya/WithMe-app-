
import 'package:flutter/material.dart';

import '../../features/dashboard/dashboard_screen.dart';
import '../../data/question_model.dart';
import '../../data/questions.dart';

class QuestionnaireScreen extends StatefulWidget {
  const QuestionnaireScreen({super.key});

  @override
  State<QuestionnaireScreen> createState() =>
      _QuestionnaireScreenState();
}

class _QuestionnaireScreenState
    extends State<QuestionnaireScreen> {
  int _currentIndex = 0;

  final Map<int, dynamic> _answers = {};
  final TextEditingController _textController =
      TextEditingController();

  static const Color _lavender = Color(0xFFB7A0FF);
  static const Color _panel = Color(0xDD272830);

  Question get _currentQuestion => questions[_currentIndex];

  bool get _isLastQuestion =>
      _currentIndex == questions.length - 1;

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

  void _saveCurrentAnswer() {
    final question = _currentQuestion;

    if (question.type == QuestionType.shortAnswer ||
        question.type == QuestionType.longAnswer) {
      _answers[question.id] = _textController.text.trim();
    }
  }

  bool _validateCurrentQuestion() {
    final question = _currentQuestion;

    if (!question.required) return true;

    if (question.type == QuestionType.shortAnswer ||
        question.type == QuestionType.longAnswer) {
      return _textController.text.trim().isNotEmpty;
    }

    final answer = _answers[question.id];

    if (question.type == QuestionType.singleChoice ||
        question.type == QuestionType.colour) {
      return answer != null;
    }

    if (question.type == QuestionType.multipleChoice) {
      return answer != null && (answer as List).isNotEmpty;
    }

    return true;
  }

  void _nextQuestion() {
    _saveCurrentAnswer();

    if (!_validateCurrentQuestion()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please answer this question before continuing.',
          ),
          backgroundColor: Color(0xFFB94D68),
        ),
      );
      return;
    }

    if (_isLastQuestion) {
      _finishQuestionnaire();
      return;
    }

    setState(() {
      _currentIndex++;
      _loadTextAnswer();
    });
  }

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

  void _skipQuestion() {
    final question = _currentQuestion;

    _answers.remove(question.id);

    if (question.type == QuestionType.shortAnswer ||
        question.type == QuestionType.longAnswer) {
      _textController.clear();
    }

    if (_isLastQuestion) {
      _finishQuestionnaire();
      return;
    }

    setState(() {
      _currentIndex++;
      _loadTextAnswer();
    });
  }

  void _finishQuestionnaire() {
    _saveCurrentAnswer();

    debugPrint('Questionnaire answers: $_answers');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const DashboardScreen(),
      ),
    );
  }

  void _selectSingleChoice(String option) {
    setState(() {
      _answers[_currentQuestion.id] = option;
    });
  }

  void _toggleMultipleChoice(String option) {
    final id = _currentQuestion.id;

    final selected = List<String>.from(
      (_answers[id] as List?) ?? [],
    );

    if (selected.contains(option)) {
      selected.remove(option);
    } else {
      selected.add(option);
    }

    setState(() {
      _answers[id] = selected;
    });
  }

  void _selectColour(String colour) {
    setState(() {
      _answers[_currentQuestion.id] = colour;
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = _currentQuestion;
    final progress = (_currentIndex + 1) / questions.length;

    return Scaffold(
      backgroundColor: const Color(0xFF101116),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF27282E),
              Color(0xFF18191F),
              Color(0xFF0B0C11),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top navigation and progress.
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  10, 8, 12, 8,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: _previousQuestion,
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 19,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${_currentIndex + 1}/${questions.length}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 6),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: LinearProgressIndicator(
                              value: progress,
                              minHeight: 3,
                              backgroundColor: Colors.white24,
                              valueColor:
                                  const AlwaysStoppedAnimation<Color>(
                                _lavender,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: _skipQuestion,
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Question content.
              Expanded(
                child: GestureDetector(
                  onHorizontalDragEnd: (details) {
                    final velocity =
                        details.primaryVelocity ?? 0;

                    if (velocity < -350) {
                      _nextQuestion();
                    } else if (velocity > 350) {
                      _previousQuestion();
                    }
                  },
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      22, 26, 22, 18,
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          question.section.toUpperCase(),
                          style: const TextStyle(
                            color: _lavender,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          question.question,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            height: 1.28,
                          ),
                        ),
                        if (!question.required) ...[
                          const SizedBox(height: 9),
                          const Text(
                            'Optional · You can skip this question',
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 12,
                            ),
                          ),
                        ],
                        const SizedBox(height: 24),
                        _buildQuestionInput(question),
                        const SizedBox(height: 18),
                        Center(
                          child: Text(
                            'Question ${_currentIndex + 1} of ${questions.length}',
                            style: const TextStyle(
                              color: Colors.white38,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        // Yuki will be added here after the
                        // correct character widget is available.
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),

              // Bottom navigation.
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  18, 8, 18, 18,
                ),
                child: Row(
                  children: [
                    if (_currentIndex > 0) ...[
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _previousQuestion,
                          style: OutlinedButton.styleFrom(
                            minimumSize:
                                const Size.fromHeight(52),
                            foregroundColor: Colors.white,
                            side: const BorderSide(
                              color: Colors.white30,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text('Back'),
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _nextQuestion,
                        style: ElevatedButton.styleFrom(
                          minimumSize:
                              const Size.fromHeight(52),
                          backgroundColor: _lavender,
                          foregroundColor:
                              const Color(0xFF251E35),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(16),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            Text(
                              _isLastQuestion ? 'Finish' : 'Next',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.arrow_forward_rounded,
                              size: 19,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionInput(Question question) {
    switch (question.type) {
      case QuestionType.shortAnswer:
        return _textField(
          hint: 'Enter your answer...',
          maxLines: 1,
        );

      case QuestionType.longAnswer:
        return _textField(
          hint: 'Tell me anything you would like to share...',
          maxLines: 5,
        );

      case QuestionType.singleChoice:
        final selected = _answers[question.id] as String?;

        return Column(
          children: question.options.map((option) {
            return _choiceButton(
              text: option,
              selected: selected == option,
              onTap: () => _selectSingleChoice(option),
            );
          }).toList(),
        );

      case QuestionType.multipleChoice:
        final selected = List<String>.from(
          (_answers[question.id] as List?) ?? [],
        );

        return Column(
          children: question.options.map((option) {
            return _choiceButton(
              text: option,
              selected: selected.contains(option),
              multiple: true,
              onTap: () => _toggleMultipleChoice(option),
            );
          }).toList(),
        );

      case QuestionType.colour:
        return _buildColourPicker();
    }
  }

  Widget _textField({
    required String hint,
    required int maxLines,
  }) {
    return TextField(
      controller: _textController,
      maxLines: maxLines,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 15,
      ),
      cursorColor: _lavender,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: Colors.white54,
          fontSize: 14,
        ),
        filled: true,
        fillColor: _panel,
        contentPadding: const EdgeInsets.all(17),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Colors.white24,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: _lavender,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _choiceButton({
    required String text,
    required bool selected,
    required VoidCallback onTap,
    bool multiple = false,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 11),
      child: Material(
        color: selected
            ? const Color(0x443D3261)
            : _panel,
        borderRadius: BorderRadius.circular(15),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: selected
                    ? _lavender
                    : Colors.white24,
                width: selected ? 1.5 : 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  multiple
                      ? (selected
                          ? Icons.check_box_rounded
                          : Icons.check_box_outline_blank_rounded)
                      : (selected
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off),
                  color: selected
                      ? _lavender
                      : Colors.white60,
                  size: 21,
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
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
      ),
    );
  }

  Widget _buildColourPicker() {
    const colours = <String, Color>{
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

    final selected = _answers[_currentQuestion.id] as String?;

    return Wrap(
      spacing: 14,
      runSpacing: 14,
      children: colours.entries.map((entry) {
        final isSelected = selected == entry.key;

        return GestureDetector(
          onTap: () => _selectColour(entry.key),
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: entry.value,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? _lavender : Colors.white38,
                width: isSelected ? 4 : 1,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: _lavender.withOpacity(0.35),
                        blurRadius: 12,
                      ),
                    ]
                  : null,
            ),
            child: isSelected
                ? Icon(
                    Icons.check_rounded,
                    color: entry.key == 'White' ||
                            entry.key == 'Yellow'
                        ? Colors.black
                        : Colors.white,
                  )
                : null,
          ),
        );
      }).toList(),
    );
  }
}
