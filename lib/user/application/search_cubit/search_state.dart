import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class SearchState {
  final String filterText;
  final CollectionReference<Map<String, dynamic>> userCollection;
  final List<DocumentSnapshot<Map<String, dynamic>>> documents;
  SearchState({
    required this.filterText,
    required this.userCollection,
    required this.documents,
  });

  factory SearchState.initial() {
    return SearchState(
      filterText: '',
      userCollection: FirebaseFirestore.instance.collection('users'),
      documents: [],
    );
  }

  SearchState copyWith({
    String? filterText,
    CollectionReference<Map<String, dynamic>>? userCollection,
    List<DocumentSnapshot<Map<String, dynamic>>>? documents,
  }) {
    return SearchState(
      filterText: filterText ?? this.filterText,
      userCollection: userCollection ?? this.userCollection,
      documents: documents ?? this.documents,
    );
  }

  @override
  bool operator ==(covariant SearchState other) {
    if (identical(this, other)) return true;

    return other.filterText == filterText &&
        other.userCollection == userCollection &&
        listEquals(other.documents, documents);
  }

  @override
  int get hashCode =>
      filterText.hashCode ^ userCollection.hashCode ^ documents.hashCode;
}
