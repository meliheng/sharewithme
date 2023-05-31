class PageState {
  final bool showNavigationBar;
  PageState({
    required this.showNavigationBar,
  });

  factory PageState.initial() {
    return PageState(
      showNavigationBar: true,
    );
  }

  PageState copyWith({
    bool? showNavigationBar,
  }) {
    return PageState(
      showNavigationBar: showNavigationBar ?? this.showNavigationBar,
    );
  }

  @override
  bool operator ==(covariant PageState other) {
    if (identical(this, other)) return true;

    return other.showNavigationBar == showNavigationBar;
  }

  @override
  int get hashCode => showNavigationBar.hashCode;
}
