import 'package:hive/hive.dart';
part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  final String name;

  @HiveField(2)
  final String imageUrl;

  @HiveField(3)
  final String valOperation;

  @HiveField(4)
  final DateTime selectedDate;

  Todo({
    required this.name,
    required this.imageUrl,
    required this.valOperation,
    required this.selectedDate,
  });
}