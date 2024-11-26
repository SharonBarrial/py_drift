//paso 1 importar libreias
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get email => text().named('email')();
  TextColumn get password => text().named('password')();
}

LazyDatabase openConection(){
  return LazyDatabase(() async{
    //ruta de grabado
    final dbFolder = await getApplicationDocumentsDirectory();

    //unir la ruta con la bd
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Users])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConection());

  @override
  int get schemaVersion => 1;
}

//Nota: el archivo database.g.dart se genera automáticamente al ejecutar el comando *flutter packages pub run build_runner build* en la terminal.
//Nota: el archivo database.g.dart se genera automáticamente al ejecutar el comando *dart run build_runner build* en la terminal.
