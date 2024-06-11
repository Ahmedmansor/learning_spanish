class EducationItemModel {
  final String title;
  final String image;
  final List<Map> words;
  final List<String> answers;
  final List<String> questions;
  final String? videoUrl;

  EducationItemModel({
    required this.title,
    required this.image,
    required this.words,
    required this.answers,
    required this.questions,
    required this.videoUrl,
  });
}

List<EducationItemModel> educationItems = [
  EducationItemModel(
    title: 'school',
    image: 'assets/images/image1.jpg',
    words: [
      {
        'english': 'book',
        'espanol': 'libro',
      },
      {
        'english': 'history',
        'espanol': 'historia',
      },
      {
        'english': 'paper',
        'espanol': 'papel',
      },
    ],
    questions: ['book', 'history', 'paper'],
    answers: ['libro', 'historia', 'papel'],
    videoUrl: null,
  ),
  EducationItemModel(
    title: 'high school',
    image: 'assets/images/image2.jpg',
    words: [
      {
        'english': 'to think',
        'espanol': 'pensar',
      },
      {
        'english': 'course',
        'espanol': 'curso',
      },
      {
        'english': 'writing',
        'espanol': 'escribiendo',
      },
    ],
    questions: ['to think', 'course', 'writing'],
    answers: ['pensar', 'curso', 'escribiendo'],
    videoUrl: null,
  ),
  EducationItemModel(
    title: 'university',
    image: 'assets/images/image3.jpg',
    words: [
      {
        'english': 'tape',
        'espanol': 'cinta',
      },
      {
        'english': 'portofolio',
        'espanol': 'portafolio',
      },
      {
        'english': 'thesis',
        'espanol': 'tesis',
      },
    ],
    questions: ['tape', 'portofolio', 'thesis'],
    answers: ['cinta', 'portafolio', 'tesis'],
    videoUrl: null,
  ),
];
