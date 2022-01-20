final String tableTasks = 'tasks';

class TasksField{
  static final List<String> values = [
    id, title, date, color, type
  ];

  static final String id = '_id';
  static final String title = 'title';
  static final String date = 'date';
  static final String color = 'color';
  static final String type = 'type';
}

class Task {
  final int id;
  final String title;
  final DateTime date;
  final String color;
  final String type;

  Task({
    this.id,
    this.title, 
    this.date,
    this.color,
    this.type
  });

  Task copy({
    int id,
    String title,
    String date,
    String color,
    String type

  }) => (
    Task(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      color: color ?? this.color,
      type: type ?? this.type

    )
  );

  static Task fromJson(Map<String, Object> json) => Task(
    id: json[TasksField.id] as int,
    title: json[TasksField.title] as String,
    color: json[TasksField.color] as String,
    type: json[TasksField.type] as String,
    date: DateTime.parse(json[TasksField.date] as String) 
  );

  Map<String, Object> toJson() => {
    TasksField.id : id,
    TasksField.title : title,
    TasksField.color : color,
    TasksField.type : type,
    TasksField.date : date.toIso8601String()
  };

}