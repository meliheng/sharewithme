abstract class ValueObject<T> {
  T get value;
}

extension ValueObjectStringX on ValueObject<String> {
  bool contains(String text) {
    return value.toLowerCase().contains(text.toLowerCase());
  }
}
