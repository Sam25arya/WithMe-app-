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
    question: 'What is your favourite colour?',
    type: QuestionType.colour,
  ),

  Question(
    id: 6,
    section: 'Getting to Know You',
    question: 'What is your favourite food?',
    type: QuestionType.shortAnswer,
  ),

  Question(
    id: 7,
    section: 'Getting to Know You',
    question: 'What is your favourite movie or series?',
    type: QuestionType.shortAnswer,
  ),

  Question(
    id: 8,
    section: 'Getting to Know You',
    question: 'What kind of music or songs do you like?',
    type: QuestionType.shortAnswer,
  ),

  
  Question(
    id: 9,
    section: 'Getting to Know You',
    question: 'What is something you don\'t like or prefer to avoid?',
    type: QuestionType.shortAnswer,
  ),

  // ------------------------------------------------------------
  // SECTION 3 — PERSONALITY & COMMUNICATION
  // ------------------------------------------------------------

  Question(
    id: 10,
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
    id: 11,
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
    id: 12,
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

  

  // ------------------------------------------------------------
  // SECTION 4 — THINKING & BEHAVIOUR
  // ------------------------------------------------------------

  

 

  

  Question(
    id: 13,
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

 

  // ------------------------------------------------------------
  // SECTION 5 — STRESS & EMOTIONS
  // ------------------------------------------------------------

 

  

 

  Question(
    id: 14,
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
    id: 16,
    section: 'Stress & Emotions',
    question: 'When you are upset, what would you prefer?',
    type: QuestionType.singleChoice,
    options: [
      'Check on me',
      'Give me space',
      'Depends',
    ],
  ),

  

  // ------------------------------------------------------------
  // SECTION 6 — HOW WITHME SHOULD INTERACT
  // ------------------------------------------------------------

 

  Question(
    id: 16,
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

 

  

  // ------------------------------------------------------------
  // SECTION 7 — ANYTHING ELSE
  // ------------------------------------------------------------

  Question(
    id: 17,
    section: 'Anything Else',
    question: 'Is there anything else WithMe should know about you?',
    type: QuestionType.longAnswer,
  ),
];