class NavigationBarState {
  final int currentIndex;
  NavigationBarState({
    required this.currentIndex,
  });

  factory NavigationBarState.initial() {
    return NavigationBarState(
      currentIndex: 0,
    );
  }

  NavigationBarState copyWith({
    int? currentIndex,
  }) {
    return NavigationBarState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  bool operator ==(covariant NavigationBarState other) {
    if (identical(this, other)) return true;

    return other.currentIndex == currentIndex;
  }

  @override
  int get hashCode => currentIndex.hashCode;
}
