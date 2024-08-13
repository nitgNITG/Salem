import 'package:flutter/material.dart';

extension TapCallbackExtension on Widget {
  Widget onTap(VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: this,
    );
  }
}

extension ListExtension<T> on List<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }
}
extension IndexedMap<T, R> on List<T> {
  Iterable<R> mapIndexed<R>(R Function(int index, T element) mapper) {
    return asMap().entries.map((entry) => mapper(entry.key, entry.value));
  }
}
