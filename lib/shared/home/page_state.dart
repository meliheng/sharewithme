class PageState {
  final int activeTabIndex;
  PageState({
    required this.activeTabIndex,
  });

  factory PageState.initial() {
    return PageState(
      activeTabIndex: 0,
    );
  }

  PageState copyWith({
    int? activeTabIndex,
  }) {
    return PageState(
      activeTabIndex: activeTabIndex ?? this.activeTabIndex,
    );
  }

  @override
  bool operator ==(covariant PageState other) {
    if (identical(this, other)) return true;

    return other.activeTabIndex == activeTabIndex;
  }

  @override
  int get hashCode => activeTabIndex.hashCode;
}
