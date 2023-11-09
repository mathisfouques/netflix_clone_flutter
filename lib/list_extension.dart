extension IterableExtension<T> on Iterable<T> {
  bool doesNotContain(T element) => !contains(element);

  List<E> mapToList<E>(E Function(T) convert) => map(convert).toList();
}

extension ListExtension<T> on List<T> {
  List<T> spaced(T element, {bool addLast = false, bool addFirst = false}) {
    final result = <T>[if (addFirst) element];
    for (T t in this) {
      result.add(t);
      result.add(element);
    }
    if (!addLast && isNotEmpty) result.removeLast();
    return result;
  }
}
