class Expense{
  final int Id;
  final String title;
  final double amount;
  final DateTime date;
  final String category;

  Expense({
    required this.Id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category});

    Map<String, dynamic> toMap() => {
      'title': title,
      'amount': amount.toString(),
      'date': date.toString(),
      'category': category,
      };
  factory Expense.toString(Map<String, dynamic> value) =>
   Expense(
    Id: value['id'],
    title: value['title'],
    amount: double.parse(value['amount'],),
    date: DateTime.parse(value['date'],),
    category: value['category'],);
    
}