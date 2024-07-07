class Article {
  Article({
    required this.id,
    required this.title,
    required this.content,
    required this.image,
    required this.date,
    this.view = 0,
  });
  
  final String id;
  final String title;
  final String content;
  final String image;
  final DateTime date;
  final int view;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'image': image,
      'date': date.toIso8601String(),
      'view': view,
    };
  }

  static Article fromMap(Map<String, dynamic> map) {
    return Article(
      id: map['id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      image: map['image'] as String,
      date: DateTime.parse(map['date'] as String),
      view: map['view'] as int,
    );
  }
}
