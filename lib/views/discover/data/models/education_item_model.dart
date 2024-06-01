class EducationItemModel {
  final String title;
  final String image;
  final List<Map> words;

  EducationItemModel(
      {required this.title, required this.image, required this.words});
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
  ),
];
