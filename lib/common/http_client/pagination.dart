import 'dart:async';
import 'package:meta/meta.dart';

class Pagination<T> {
  int perPage = 15;
  bool hasMore = true;
  List<T> data;

  Pagination({
    required this.hasMore,
    required this.perPage,
    required this.data
  });

  List<T> getData() {
    return this.data;
  }

}