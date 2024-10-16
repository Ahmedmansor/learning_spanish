class AjHogModel {
  final String title;
  final List<Map> words;
  final List<String> answers;
  final List<String> questions;
  final String? mainSubtitleFile;
  final String? vocabSubtitleFile;
  final String? msSubtitleFile;
  final String? povSubtitleFile;
  final String? mainSubtitleAudioFile;
  final String? vocabSubtitleAudioFile;
  final String? msSubtitleAudioFile;
  final String? povSubtitleAudioFile;

  AjHogModel({
    required this.title,
    required this.words,
    required this.answers,
    required this.questions,
    required this.mainSubtitleFile,
    required this.vocabSubtitleFile,
    required this.msSubtitleFile,
    required this.povSubtitleFile,
    required this.mainSubtitleAudioFile,
    required this.vocabSubtitleAudioFile,
    required this.msSubtitleAudioFile,
    required this.povSubtitleAudioFile,
  });
}

List<AjHogModel> ajHogList = [
  AjHogModel(
    title: 'Intro',
    words: [
      {
        "Arabic": "متحمس – متفائل",
        "english": "Enthusiastic",
        "Example":
            "I think principally we're looking for people who are enthusiastic.\n \n أعتقد أننا نبحث بشكل أساسي عن أشخاص متحمسين."
      },
      {
        "Arabic": "اكتساب اللغة – تحصيل اللغة",
        "english": "language acquisition",
        "Example":
            "The problem of language acquisition is extremely complex.\n \n مشكلة اكتساب اللغة معقدة للغاية."
      },
      {
        "Arabic": "في النهاية",
        "english": "ultimately",
        "Example":
            "people, which is ultimately what we care about.\n \n الناس، وهو ما نهتم به في النهاية."
      },
      {
        "Arabic": "طقوس",
        "english": "ritual",
        "Example":
            "Because this ritual had such an impact on me.\n \n لأن هذه الطقوس كان لها مثل هذا التأثير علي."
      },
      {
        "Arabic": "يعزز",
        "english": "strengthen",
        "Example":
            "how we are going to strengthen the middle class in this country.\n \n كيف سنقوم بتعزيز الطبقة المتوسطة في هذه البلد."
      },
      {
        "Arabic": "لغوي – علم اللغة",
        "english": "linguistic",
        "Example":
            "Also, the system has to have linguistic capacities.\n \n كما يجب أن يكون للنظام قدرات لغوية."
      },
      {
        "Arabic": "عنصر – عامل",
        "english": "factor",
        "Example":
            "the biggest environmental factor is without doubt smoking.\n \n العامل البيئي الأكبر هو بلا شك التدخين."
      },
      {
        "Arabic": "عوامل لغوية",
        "english": "linguistic factors",
        "Example":
            "What are the environmental and linguistic factors that contribute to a child's language ability?\n \n ما هي العوامل البيئية واللغوية التي تساهم في قدرة الطفل اللغوية؟"
      },
      {
        "Arabic": "من ناحية أخرى",
        "english": "on the other hand",
        "Example":
            "I on the other hand don't necessarily see it that way.\n \n من ناحية أخرى، لا أرى الأمر بهذه الطريقة بالضرورة."
      },
      {
        "Arabic": "العقل الباطن",
        "english": "subconscious",
        "Example":
            "but your subconscious is completely incapable of discerning the difference between bad and good.\n \n لكن عقلك الباطن غير قادر تمامًا على تمييز الفرق بين السيئ والجيد."
      },
      {
        "Arabic": "مرادف",
        "english": "synonym",
        "Example":
            "they use the word depression as a synonym for sadness.\n \n يستخدمون كلمة الاكتئاب كمرادف للحزن."
      },
      {
        "Arabic": "تواصل – تفاعل – انخراط",
        "english": "engage",
        "Example":
            "engage in serious and meaningful discussions with you.\n \n الدخول في مناقشات جادة وهادفة معك."
      },
      {
        "Arabic": "ذروة",
        "english": "peak",
        "Example":
            "to generate electricity during peak demand periods.\n \n لتوليد الكهرباء خلال فترات ذروة الطلب."
      },
      {
        "Arabic": "لاعب – رياضي",
        "english": "athlete",
        "Example":
            "Even if you don't consider yourself an athlete.\n \n حتى لو كنت لا تعتبر نفسك رياضي."
      },
      {
        "Arabic": "عقلية – فكرية",
        "english": "intellectual",
        "Example":
            "The major barrier to learn something new is not intellectual.\n \n العائق الرئيسي لتعلم شيء جديد ليس فكريًا."
      },
    ],
    answers: [
      'Enthusiastic',
      "language acquisition",
      "ultimately",
      "ritual",
      "strengthen",
      "linguistic",
      "factor",
      "linguistic factors",
      "on the other hand",
      "subconscious",
      "synonym",
      "engage",
      "peak",
      "athlete",
      "intellectual",
    ],
    questions: [
      'متحمس – متفائل',
      "اكتساب اللغة – تحصيل اللغة",
      "في النهاية",
      "طقوس",
      "يعزز",
      "لغوي – علم اللغة",
      "عنصر – عامل",
      "عوامل لغوية",
      "من ناحية أخرى",
      "العقل الباطن",
      "مرادف",
      "تواصل – تفاعل – انخراط",
      "ذروة",
      "لاعب – رياضي",
      "عقلية – فكرية",
    ],
    mainSubtitleAudioFile: 'songs/1-Intro MAIN.MP3',
    vocabSubtitleFile: 'assets/lyrics/2-Intro VOCAB.srt',
    msSubtitleFile: 'assets/lyrics/3-Intro MS.srt',
    povSubtitleFile: null,
    mainSubtitleFile: 'assets/lyrics/1-Intro MAIN.srt',
    vocabSubtitleAudioFile: 'songs/2-Intro VOCAB.mp3',
    msSubtitleAudioFile: 'songs/3-Intro MS.mp3',
    povSubtitleAudioFile: null,
  ),
];
