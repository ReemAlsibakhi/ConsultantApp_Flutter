class SearchPost {
  final int statusId;
  final int catId;

  SearchPost(this.statusId, this.catId);

  @override
  String toString() {
    return 'SearchPost{statusId: $statusId, catId: $catId}';
  }
}
