import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class Student {
  String id;
  String name;
  int score;
  //构造方法
  Student({
    required this.id,
    required this.name,
    required this.score,
  });
  //用于将JSON字典转换成类对象的工厂类方法
  factory Student.fromJson(Map<String, dynamic> parsedJson) {
    return Student(
      id: parsedJson['id'],
      name: parsedJson['name'],
      score: parsedJson['score'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'score': score,
    };
  }
}

class _MyHomePageState extends State<MyHomePage> {
  var student1 = Student(id: '123', name: '张三', score: 110);

  query_database(id) {
    Future<Student?> user = query_by_id(id);
    user.then((t) {
      print("单用户查询成功");
      print('the sroce is : ' + t!.score.toString());
      student1.score = t!.score;
    });
  }

  //插入数据
  Future<void> insertStudent(Student std) async {
    final Database? db = await database;
    await db!.insert(
      'students',
      std.toJson(),
      //插入冲突策略，新的替换旧的
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Student?> query_by_id(String id) async {
    final Database? db = await database;
    List<Map<String, dynamic>> maps =
        await db!.query('students', columns: ['id', 'name', 'score'], where: 'id = ?', whereArgs: [id]);
    if (maps.length > 0) {
      print("根据id查到了数据");
      return Student.fromJson(maps.first);
    }
    print("根据id没有查到数据");
    return null;
  }

  //初始化数据库方法
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "students_database.db");

    return await openDatabase(path, version: 1, onOpen: (db) {}, onCreate: (Database db, int version) async {
      await db.execute('''
            CREATE TABLE students(id TEXT PRIMARY KEY, name TEXT, score INTEGER)
            ''');
    });
  }

  Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      print(_database);
      return _database;
    }

    _database = await initDB();
    print("创建新数据库");
    return _database;
  }

  void _incrementCounter() async {
    student1.score += 1;
    await insertStudent(student1);

    setState(() {});
  }

  Future<List<Student>> students() async {
    final Database? db = await database;
    final List<Map<String, dynamic>> maps = await db!.query('students');
    return List.generate(maps.length, (i) => Student.fromJson(maps[i]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SQL Demo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              student1.score.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() async {
    // TODO: implement dispose
    super.dispose();
    final Database? db = await database;

    db!.close();
  }
}
