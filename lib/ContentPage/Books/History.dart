import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class NewBooks extends StatefulWidget {
  const NewBooks({Key? key}) : super(key: key);

  @override
  State<NewBooks> createState() => _NewBooksState();
}

class _NewBooksState extends State<NewBooks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold
      (
      appBar:AppBar
        (
        title: Text('Books'),
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
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Card(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListTile(
                  leading: Image.network('https://images.blinkist.io/images/books/63fc4bfa0ec20100080b21fb/1_1/470.jpg'),
                  title:  const Text('To Kill a Mockingbird'),
                  onTap:()async
                  {
                    launchUrl(
                        Uri.parse(
                        'https://en.wikipedia.org/wiki/To_Kill_a_Mockingbird')
                    );

                  }
                ),
              ),
              const SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListTile(
                  leading: Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/The_Great_Gatsby_Cover_1925_Retouched.jpg/220px-The_Great_Gatsby_Cover_1925_Retouched.jpg'),
                  title:  const Text('The Great Gatsby'),
                  onTap:()async
                  {
                   launchUrl(
                    Uri.parse(
                  'https://en.wikipedia.org/wiki/The_Great_Gatsby')
                 );

            }
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListTile(
                    leading: Image.network('https://m.media-amazon.com/images/I/61QICOkQ5sL.jpg'),
                    title:  const Text('The Design of Everything'),
                    onTap:()async
                    {
                      launchUrl(
                          Uri.parse(
                              'https://www.amazon.com/Design-Everyday-Things-Revised-Expanded/dp/0465050654')
                      );

                    }
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListTile(
                    leading: Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/1/17/PrideAndPrejudiceTitlePage.jpg/220px-PrideAndPrejudiceTitlePage.jpg'),
                    title:  const Text('Pride and Prejudice'),
                    onTap:()async
                    {
                      launchUrl(
                          Uri.parse(
                              'https://en.wikipedia.org/wiki/Pride_and_Prejudice')
                      );

                    }
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
