class Filter {
  final String id;
  final String name;
  final bool isSelected;

  Filter({
    required this.id,
    required this.name,
    required this.isSelected,
  });

  Filter copyWith({String? id, String? name, bool? isSelected}) {
    return Filter(
      id: id ?? this.id,
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}