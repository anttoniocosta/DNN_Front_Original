extension MyIterable<E> on Iterable<E> {
  Iterable<E> sortedBy(Comparable key(E e)) =>
      toList()..sort((a, b) => key(a).compareTo(key(b)));

  Iterable<E> sortedByDesc(Comparable key(E e)) =>
      toList()..sort((a, b) => key(b).compareTo(key(a)));
}
