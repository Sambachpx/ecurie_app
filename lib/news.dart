import 'package:flutter/material.dart';

class News {
  String name;
  String content;
  String date;

  News(this.name,this.content, this.date);
}

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<News> news = [];

  void _addContact() {
    setState(() {
      news.add(News('Nouveau contact', 'Numéro de téléphone','cc'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: news.map((news) {
          return Card(
            margin: EdgeInsets.all(16.0),
            child: ListTile(
              title: Text(news.name),
              subtitle: Text(news.content),
            ),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addContact,
        child: Icon(Icons.add),
      ),
    );
  }
}

