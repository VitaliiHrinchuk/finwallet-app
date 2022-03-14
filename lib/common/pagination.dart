// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:meta/meta.dart';
//
// class Pagination<T> {
//   static const ITEMS_PER_PAGE = 15;
//
//   final Query<T> _query;
//
//   StreamSubscription? _subscription;
//   DocumentSnapshot? _lastDocument;
//
//   bool _hasMore = true;
//   final StreamController<List<T>> _streamController = StreamController<List<T>>.broadcast();
//   final List<T> _cache = <T>[];
//
//   Pagination({
//     required query,
//   }) : _query = query;
//
//   Stream<List<T>> get stream => _streamController.stream;
//
//   bool get hasMore => this._hasMore;
//
//   Future<void> get() async {
//     await _subscription?.cancel();
//
//     _subscription = _query.snapshots().listen(_handleInputStream);
//   }
//
//   Future<void> next() async {
//     if (_lastDocument == null) return;
//     await _subscription?.cancel();
//     _subscription = _query.startAfterDocument(_lastDocument!).snapshots().listen(_handleInputStream);
//   }
//
//   void removeItem(T obj){
//     _cache.removeWhere((element) => element == obj);
//     _streamController.sink.add(_cache);
//   }
//
//   void _handleInputStream (QuerySnapshot<T> snap) {
//     if (snap.docs.isEmpty) {
//       _lastDocument = null;
//       _hasMore = false;
//     } else {
//       _lastDocument = snap.docs.last;
//       _hasMore = snap.docs.length >= ITEMS_PER_PAGE;
//       _cache.addAll(snap.docs.map((doc) => doc.data()).toList());
//     }
//
//     _streamController.sink.add(_cache);
//   }
//
//   @mustCallSuper
//   Future<void> dispose() async {
//     await _subscription?.cancel();
//     await _streamController.close();
//   }
//
// }