class FrequentlyAskedQuestionEntity{
  final String title;
  final String desc;
  bool isOpen;

  FrequentlyAskedQuestionEntity(
      {required this.title, required this.desc,this.isOpen = false});
}