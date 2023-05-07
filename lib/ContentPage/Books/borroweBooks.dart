import 'package:flutter/material.dart';

class BorrowedBook {
  String title;
  DateTime borrowedDate;

  BorrowedBook({required this.title, required this.borrowedDate});
}

class BorrowedList extends StatelessWidget {
  final List<BorrowedBook> borrowedBooks = [
    BorrowedBook(title: "The Alchemist", borrowedDate: DateTime(2022, 04, 15)),
    BorrowedBook(title: "The Great Gatsby", borrowedDate: DateTime(2022, 04, 28)),
    BorrowedBook(title: "To Kill a Mockingbird", borrowedDate: DateTime(2022, 05, 05)),
    BorrowedBook(title: "Pride and Prejudice", borrowedDate: DateTime(2022, 05, 10)),
    BorrowedBook(title: "The Catcher in the Rye", borrowedDate: DateTime(2022, 05, 15)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Borrowed Books"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pushReplacementNamed(context,'trial');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: borrowedBooks.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(borrowedBooks[index].title),
            subtitle: Text("Borrowed on: ${borrowedBooks[index].borrowedDate}"),
          );
        },
      ),
    );
  }
}
