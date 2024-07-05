import 'dart:async';

import 'package:isar/isar.dart';
import 'package:note_app/data/entity/note_entity.dart';

abstract class ObserverData<T> {
  void listener(Function(T value) callback);

  void cancelListen();
}

abstract class SingleStreamObserverData<T> extends ObserverData<T> {
  StreamSubscription<T>? _subscription;

  StreamSubscription<T>? get subscription => _subscription;

  void setSubscription(StreamSubscription<T> subscription) {
    _subscription?.cancel();
    _subscription = subscription;
  }

  @override
  void cancelListen() {
    _subscription?.cancel();
  }

  void onPause() {
    _subscription?.pause();
  }

  void onResume() {
    _subscription?.resume();
  }
}
