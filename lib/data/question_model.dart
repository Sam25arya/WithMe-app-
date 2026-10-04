enum QuestionType {
  shortAnswer,
  singleChoice,
  multipleChoice,
  colour,
  longAnswer,
}

class Question {
  final int id;
  final String section;
  final String question;
  final QuestionType type;
  final List<String> options;
  final bool required;

  const Question({
    required this.id,
    required this.section,
    required this.question,
    required this.type,
    this.options = const [],
    this.required = false,
  });
}