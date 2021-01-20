class HomeDB {
  final String id;
  final String poster;
  final String title;

  final String content;
  final String category;
  final Map user;
  final String time;
  HomeDB(
      {this.id,
      this.category,
      this.content,
      this.poster,
      this.time,
      this.title,
      this.user,
      });
  Map<String, dynamic> toMap() {
    return {
      'id': id,

      'category': category,
      'poster': poster,
      'title': title,
      'time': time,
      'user': user,


      'content': content,

    };
  }

  factory HomeDB.fromJson(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    } else {
      return HomeDB(

        id: data['id'],
        category: data['category'],
        poster: data['poster'],
        title: data['title'],
        time: data['time'],
        user: data['user'],
        content: data['content'],

      );
    }
  }
}
