class Record {
  int? id;
  final int amount;
  final String category;
  final String type;
  final DateTime date;

  Record({
    this.id,
    required this.amount,
    required this.category,
    required this.type,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'category': category,
      'type': type,
      'date': date.toIso8601String(),
    };
  }

  factory Record.fromMap(Map<String, dynamic> map) {
    return Record(
      id: map['id'] as int?,
      amount: map['amount'] as int,
      category: map['category'] as String,
      type: map['type'] as String,
      date: DateTime.parse(map['date'] as String),
    );
  }
}
