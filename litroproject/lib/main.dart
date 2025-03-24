import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  List<String> readBooks = [];
  List<String> favoriteBooks = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _addToRead(String book) {
    setState(() {
      readBooks.add(book);
    });
  }

  void _addToFavorites(String book) {
    setState(() {
      favoriteBooks.add(book);
    });
  }

  void _showAddDialog(Function(String) addFunction) {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Добавить произведение'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: 'Название произведения'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  addFunction(controller.text);
                }
                Navigator.of(context).pop();
              },
              child: Text('Добавить'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Жанр', icon: Icon(Icons.menu_book)),
            Tab(text: 'Год выпуска', icon: Icon(Icons.calendar_today)),
            Tab(text: 'Прочитанные', icon: Icon(Icons.bookmark)),
            Tab(text: 'Избранные', icon: Icon(Icons.favorite)),
          ],
          indicatorColor: Colors.green,
          labelColor: Colors.green,
        ),
        title: Text('Список литературы'),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          GenreTab(addToRead: _addToRead, launchURL: _launchURL),
          YearTab(launchURL: _launchURL),
          ReadTab(readBooks: readBooks, showAddDialog: _showAddDialog),
          FavoritesTab(favoriteBooks: favoriteBooks, showAddDialog: _showAddDialog),
        ],
      ),
    );
  }
}

class GenreTab extends StatelessWidget {
  final Function(String) addToRead;
  final Function(String) launchURL;

  GenreTab({required this.addToRead, required this.launchURL});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text('Роман'),
          onTap: () {},
        ),
        ListTile(
          title: Text('Евгений Онегин'),
          subtitle: Text('Подробнее'),
          onTap: () => launchURL('https://azbyka.ru/fiction/evgenij-onegin/'),
          onLongPress: () => addToRead('Евгений Онегин'),
        ),
        ListTile(
          title: Text('Комедия'),
          onTap: () {},
        ),
        ListTile(
          title: Text('Ревизор'),
          subtitle: Text('Подробнее'),
          onTap: () => launchURL('https://azbyka.ru/fiction/revizor-nikolaj-gogol/'),
          onLongPress: () => addToRead('Ревизор'),
        ),
        ListTile(
          title: Text('Повесть'),
          onTap: () {},
        ),
        ListTile(
          title: Text('Повесть временных лет'),
          subtitle: Text('Подробнее'),
          onTap: () => launchURL('https://azbyka.ru/otechnik/Nestor_Letopisets/povest-vremennyh-let/'),
          onLongPress: () => addToRead('Повесть временных лет'),
        ),
      ],
    );
  }
}

class YearTab extends StatelessWidget {
  final Function(String) launchURL;

  YearTab({required this.launchURL});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text('1600 – 1700'),
          onTap: () => launchURL('https://ru.wikipedia.org/wiki/Категория:Русская_литература_XVII_века'),
        ),
        ListTile(
          title: Text('1700 – 1800'),
          onTap: () => launchURL('https://ru.wikipedia.org/wiki/Категория:Русская_литература_XVIII_века'),
        ),
        ListTile(
          title: Text('1800 – 1900'),
          onTap: () => launchURL('https://ru.wikipedia.org/wiki/Золотой_век_русской_литературы'),
        ),
        ListTile(
          title: Text('1900 – 2000'),
          onTap: () => launchURL('https://ru.wikipedia.org/wiki/Русская_литература#Советский_период_русской_литературы_(1917—1991)'),
        ),
      ],
    );
  }
}

class ReadTab extends StatelessWidget {
  final List<String> readBooks;
  final Function(Function(String)) showAddDialog;

  ReadTab({required this.readBooks, required this.showAddDialog});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => showAddDialog(_addToRead),
          child: Text('Добавить'),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: readBooks.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(readBooks[index]),
              );
            },
          ),
        ),
      ],
    );
  }

  void _addToRead(String book) {
    readBooks.add(book);
  }
}

class FavoritesTab extends StatelessWidget {
  final List<String> favoriteBooks;
  final Function(Function(String)) showAddDialog;

  FavoritesTab({required this.favoriteBooks, required this.showAddDialog});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => showAddDialog(_addToFavorites),
          child: Text('Добавить'),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: favoriteBooks.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(favoriteBooks[index]),
              );
            },
          ),
        ),
      ],
    );
  }

  void _addToFavorites(String book) {
    favoriteBooks.add(book);
  }
}
