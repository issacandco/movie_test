extension IterableExtension<E> on Iterable<E> {
  Map<T, List<E>> groupBy<T>(T Function(E) keyFunction) {
    return fold(<T, List<E>>{}, (Map<T, List<E>> map, E element) {
      return map..putIfAbsent(keyFunction(element), () => <E>[]).add(element);
    });
  }

  Iterable<E> distinctBy(Function(E) getCompareValue) {
    var result = <E>[];
    forEach((element) {
      if (!result.any((x) => getCompareValue(x) == getCompareValue(element))) result.add(element);
    });

    return result;
  }
}
