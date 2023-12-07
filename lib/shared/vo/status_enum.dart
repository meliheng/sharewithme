enum Status {
  initial,
  submitting,
  success,
  error,
}

extension StatusEnumX on Status {
  bool get isSubmitting => this == Status.submitting;
}
