class PageState {
  final int currentIndex;
  PageState({
    required this.currentIndex,
  });

  factory PageState.initial() {
    return PageState(
      currentIndex: 0,
    );
  }

  PageState copyWith({
    int? currentIndex,
  }) {
    return PageState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  bool operator ==(covariant PageState other) {
    if (identical(this, other)) return true;

    return other.currentIndex == currentIndex;
  }

  @override
  int get hashCode => currentIndex.hashCode;
}
