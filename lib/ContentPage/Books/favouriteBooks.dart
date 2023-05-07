import 'package:flutter/material.dart';

class Book {
  final String title;
  final String author;
  final String imageUrl;

  Book({required this.title, required this.author, required this.imageUrl});
}

class KibabiiLibraryPage extends StatefulWidget {
  const KibabiiLibraryPage({Key? key}) : super(key: key);

  @override
  _KibabiiLibraryPageState createState() => _KibabiiLibraryPageState();
}

class _KibabiiLibraryPageState extends State<KibabiiLibraryPage> {
  List<Book> _books = [
    Book(
      title: 'To Kill a Mockingbird',
      author: 'Harper Lee',
      imageUrl:
      'https://images.blinkist.io/images/books/63fc4bfa0ec20100080b21fb/1_1/470.jpg',
    ),
    Book(
      title: 'The Great Gatsby',
      author: 'F. Scott Fitzgerald',
      imageUrl:
      'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/The_Great_Gatsby_Cover_1925_Retouched.jpg/220px-The_Great_Gatsby_Cover_1925_Retouched.jpg',
    ),
    Book(
      title: 'Pride and Prejudice',
      author: 'Jane Austen',
      imageUrl:
      'https://upload.wikimedia.org/wikipedia/commons/thumb/1/17/PrideAndPrejudiceTitlePage.jpg/220px-PrideAndPrejudiceTitlePage.jpg',
    ),
    Book(
      title: 'Good to Great',
      author: 'Jim Collins',
      imageUrl:
      'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTcxfbTzVZGYXqkPnoKWALpoiMKk938QeB1I4dpQca1YpJjWbde',
    ),
    Book(
      title: 'Deep Work',
      author: 'Cal Newport',
      imageUrl:
      'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTlj6mvrmQaChErPKyXN7KC3KDj4U-RxR2gHGvcTIsp6lUfqsG4',
    ),
    Book(
      title: 'The Design of Everything',
      author: 'Don Norman',
      imageUrl:
      'https://m.media-amazon.com/images/I/61QICOkQ5sL.jpg',
    ),
    Book(
      title: 'Thinking, Fast and Slow',
      author: 'Daniel Kahneman',
      imageUrl:
      'https://images.blinkist.io/images/books/512750e7e4b0714805cbbe9d/1_1/470.jpg',
    ),
    Book(
      title: 'The Lean Startup',
      author: 'Eric Ries',
      imageUrl:
      'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcScpS9dtMChvpksbeqyLbv_CJ0dZuOPK81mmpFhfAly1vEzYBSt',
    ),
    Book(
      title: 'Sapiens: A Brief History of Humankind',
      author: 'Yuval Noah Harari',
      imageUrl:
      'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcS4E0vVn6DX552o0XnrlZ3CLgjl6MU7cLrxuZVzIEw1Bk63-4VV',
    ),
    Book(
      title: 'Distance Education Learners Support Services',
      author: 'Dr. Jotham Wasike',
      imageUrl:
      'https://library.kibu.ac.ke/wp-content/uploads/2017/04/Delss.png',
    ),
    Book(
      title: 'Fundamentals of Information Storage and Retrieval.',
      author: 'Dr. Jotham Wasike',
      imageUrl:
      'https://library.kibu.ac.ke/wp-content/uploads/2017/04/Capture.png',
    ),
  ];

  List<Book> _favoriteBooks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kibabii Library Books'),
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
        itemCount: _books.length,
        itemBuilder: (context, index) {
          final book = _books[index];
          final isFavorite = _favoriteBooks.contains(book);

          return ListTile(
            leading: Image.network(book.imageUrl),
            title: Text(book.title),
            subtitle: Text(book.author),
            trailing: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : null,
              ),
              onPressed: () {
                setState(() {
                  if (isFavorite) {
                    _favoriteBooks.remove(book);
                  } else {
                    _favoriteBooks.add(book);
                  }
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.favorite),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FavoriteBooksPage(books: _favoriteBooks),
            ),
          );
        },
      ),
    );
  }
}

class FavoriteBooksPage extends StatelessWidget {
  final List<Book> books;

  const FavoriteBooksPage({Key? key, required this.books}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Books'),
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];

          return ListTile(
            leading: Image.network(book.imageUrl),
            title: Text(book.title),
            subtitle: Text(book.author),
          );
        },
      ),
    );
  }
}
