import 'package:noteapp/repostory/local_repository.dart';

// Lớp trừu tượng để cho các model thừa kế và dùng cho trong việc REST
abstract class Responsitory<T> {
  LocalRepository localRepository;

  Future<dynamic> insert(T item);
  Future<dynamic> update(T item);
  Future<dynamic> delete(T item);
  Future<List<T>> items(T item);
}
