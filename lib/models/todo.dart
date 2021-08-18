class Todo {
  final String id, title;

  const Todo(this.id, this.title);

  Map<String, String> toJson() {
    return {
      "id": id,
      "title": title,
    };
  }
}
