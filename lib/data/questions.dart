import 'question_model.dart';

const List<Question> questions = [
  // ------------------------------------------------------------
  // SECTION 1 — ABOUT YOU
  // ------------------------------------------------------------

  Question(
    id: 1,
    section: 'About You',
    question: 'What should I call you?'"🥰",
    type: QuestionType.shortAnswer,
    required: true,
  ),

  Question(
    id: 2,
    section: 'About You',
    question: 'What language would you like me to speak with you in?',
    type: QuestionType.singleChoice,
    options: [
      'English',
      'Hindi',
      'Marathi',
      'Hinglish',
      'Other',
    ],
    required: true,
  ),

  Question(
    id: 3,
    section: 'About You',
    question: 'What would you like to call your WithMe companion?',
    type: QuestionType.shortAnswer,
    required: true,
  ),

  // ------------------------------------------------------------
  // SECTION 2 — GETTING TO KNOW YOU
  // ------------------------------------------------------------

  Question(
    id: 4,
    section: 'Getting to Know You',
    question: 'What are your favourite hobbies?',
    type: QuestionType.multipleChoice,
    options: [
      'Music',
      'Gaming',
      'Reading',
      'Drawing',
      'Sports',
      'Cooking',
      'Watching Movies',
      'Travelling',
      'Other',
    ],
    required: true,
  ),

  Question(
    id: 5,
    section: 'Getting to Know You',
    question: 'What do you usually enjoy doing in your free time?',
    type: QuestionType.shortAnswer,
  ),

  Question(
    id: 6,
    section: 'Getting to Know You',
    question: 'What is your favourite colour?',
    type: QuestionType.colour,
  ),

  Question(
    id: 7,
    section: 'Getting to Know You',
    question: 'What is your favourite food?',
    type: QuestionType.shortAnswer,
  ),

  Question(
    id: 8,
    section: 'Getting to Know You',
    question: 'What is your favourite movie or series?',
    type: QuestionType.shortAnswer,
  ),

  Question(
    id: 9,
    section: 'Getting to Know You',
    question: 'What kind of music or songs do you like?',
    type: QuestionType.shortAnswer,
  ),

  Question(
    id: 10,
    section: 'Getting to Know You',
    question: 'What is something that always makes you happy?',
    type: QuestionType.shortAnswer,
  ),

  Question(
    id: 11,
    section: 'Getting to Know You',
    question: 'What is something you don\'t like or prefer to avoid?',
    type: QuestionType.shortAnswer,
  ),

  // ------------------------------------------------------------
  // SECTION 3 — PERSONALITY & COMMUNICATION
  // ------------------------------------------------------------

  Question(
    id: 12,
    section: 'Personality & Communication',
    question: 'How would you describe yourself?',
    type: QuestionType.singleChoice,
    options: [
      'Introvert',
      'Extrovert',
      'Somewhere in between',
    ],
    required: true,
  ),

  Question(
    id: 13,
    section: 'Personality & Communication',
    question: 'How would you prefer WithMe to communicate with you?',
    type: QuestionType.singleChoice,
    options: [
      'Friendly & casual',
      'Calm & gentle',
      'Funny & energetic',
      'Straightforward',
    ],
    required: true,
  ),

  Question(
    id: 14,
    section: 'Personality & Communication',
    question: 'Do you prefer long or short conversations?',
    type: QuestionType.singleChoice,
    options: [
      'Long',
      'Short',
      'Depends on my mood',
    ],
    required: true,
  ),

  Question(
    id: 15,
    section: 'Personality & Communication',
    question: 'How comfortable are you opening up to someone?',
    type: QuestionType.singleChoice,
    options: [
      'Very comfortable',
      'I open up slowly',
      'Only with trusted people',
      'Rarely',
    ],
    required: true,
  ),

  // ------------------------------------------------------------
  // SECTION 4 — THINKING & BEHAVIOUR
  // ------------------------------------------------------------

  Question(
    id: 16,
    section: 'Thinking & Behaviour',
    question: 'Do you usually think before speaking or speak freely?',
    type: QuestionType.singleChoice,
    options: [
      'Think first',
      'Speak freely',
      'Depends',
    ],
  ),

  Question(
    id: 17,
    section: 'Thinking & Behaviour',
    question: 'What do you usually do during a disagreement?',
    type: QuestionType.multipleChoice,
    options: [
      'Listen and understand',
      'Explain my side',
      'Avoid the argument',
      'Get upset',
      'Depends',
    ],
  ),

  Question(
    id: 18,
    section: 'Thinking & Behaviour',
    question: 'When something goes wrong, what do you usually do?',
    type: QuestionType.multipleChoice,
    options: [
      'Stay calm and solve it',
      'Get frustrated first',
      'Ask for help',
      'Take a break',
      'Overthink',
    ],
  ),

  Question(
    id: 19,
    section: 'Thinking & Behaviour',
    question: 'What matters most when making an important decision?',
    type: QuestionType.singleChoice,
    options: [
      'Logic and facts',
      'Feelings',
      'Advice from others',
      'A mix of everything',
      'Depends',
    ],
  ),

  Question(
    id: 20,
    section: 'Thinking & Behaviour',
    question: 'What is the first thing you usually do when making an important decision?',
    type: QuestionType.singleChoice,
    options: [
      'Think alone',
      'Talk to someone',
      'Research',
      'Follow my instinct',
      'Take my time',
    ],
  ),

  // ------------------------------------------------------------
  // SECTION 5 — STRESS & EMOTIONS
  // ------------------------------------------------------------

  Question(
    id: 21,
    section: 'Stress & Emotions',
    question: 'What is your biggest source of stress?',
    type: QuestionType.multipleChoice,
    options: [
      'Studies / Work',
      'Relationships',
      'Future / Career',
      'Social situations',
      'Family',
      'Other',
    ],
  ),

  Question(
    id: 22,
    section: 'Stress & Emotions',
    question: 'What do you usually do when you are stressed?',
    type: QuestionType.multipleChoice,
    options: [
      'Talk to someone',
      'Stay alone',
      'Distract myself',
      'Try to solve the problem',
      'Overthink',
    ],
  ),

  Question(
    id: 23,
    section: 'Stress & Emotions',
    question: 'What makes you feel understood?',
    type: QuestionType.singleChoice,
    options: [
      'Being listened to',
      'Getting advice',
      'Emotional support',
      'Someone simply staying with me',
    ],
  ),

  Question(
    id: 24,
    section: 'Stress & Emotions',
    question: 'What do you usually want when you are feeling low?',
    type: QuestionType.multipleChoice,
    options: [
      'Someone to talk to',
      'Music',
      'Time alone',
      'Something funny',
      'Encouragement',
      'Something else',
    ],
  ),

  Question(
    id: 25,
    section: 'Stress & Emotions',
    question: 'When you are upset, what would you prefer?',
    type: QuestionType.singleChoice,
    options: [
      'Check on me',
      'Give me space',
      'Depends',
    ],
  ),

  Question(
    id: 26,
    section: 'Stress & Emotions',
    question: 'What helps you feel better?',
    type: QuestionType.shortAnswer,
  ),

  // ------------------------------------------------------------
  // SECTION 6 — HOW WITHME SHOULD INTERACT
  // ------------------------------------------------------------

  Question(
    id: 27,
    section: 'How WithMe Should Interact',
    question: 'How would you like WithMe to interact with you?',
    type: QuestionType.singleChoice,
    options: [
      'Like a friend',
      'Like a companion',
      'Like an assistant',
      'A mix of all',
    ],
    required: true,
  ),

  Question(
    id: 28,
    section: 'How WithMe Should Interact',
    question: 'Would you like WithMe to remind you about things?',
    type: QuestionType.singleChoice,
    options: [
      'Yes',
      'Only important things',
      'Ask me first',
      'No',
    ],
    required: true,
  ),

  Question(
    id: 29,
    section: 'How WithMe Should Interact',
    question: 'What should WithMe remember about you?',
    type: QuestionType.shortAnswer,
  ),

  Question(
    id: 30,
    section: 'How WithMe Should Interact',
    question: 'Is there anything you do not want WithMe to remember?',
    type: QuestionType.shortAnswer,
  ),

  // ------------------------------------------------------------
  // SECTION 7 — GOALS & PERSONAL GROWTH
  // ------------------------------------------------------------

  Question(
    id: 31,
    section: 'Goals & Personal Growth',
    question: 'What is your current goal?',
    type: QuestionType.shortAnswer,
  ),

  Question(
    id: 32,
    section: 'Goals & Personal Growth',
    question: 'What is one thing WithMe can help you with?',
    type: QuestionType.shortAnswer,
  ),

  Question(
    id: 33,
    section: 'Goals & Personal Growth',
    question: 'What is one thing you would like to improve about yourself?',
    type: QuestionType.shortAnswer,
  ),

  Question(
    id: 34,
    section: 'Goals & Personal Growth',
    question: 'What is something you wish people understood about you?',
    type: QuestionType.shortAnswer,
  ),

  // ------------------------------------------------------------
  // SECTION 8 — ANYTHING ELSE
  // ------------------------------------------------------------

  Question(
    id: 35,
    section: 'Anything Else',
    question: 'Is there anything else WithMe should know about you?',
    type: QuestionType.longAnswer,
  ),
];