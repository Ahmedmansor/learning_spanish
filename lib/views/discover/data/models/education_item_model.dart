class EducationItemModel {
  final String title;
  final String image;
  final List<Map> words;
  final List<String> answers;

  EducationItemModel(
      {required this.title,
      required this.image,
      required this.words,
      required this.answers});
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
    answers: ['book', 'history', 'paper'],
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
    answers: ['to think', 'course', 'writing'],
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
    answers: ['tape', 'portofolio', 'thesis'],
  ),
];
