class ExpenseCategoryCreationRequest {
  final String name;
  final String icon;

  ExpenseCategoryCreationRequest({ required this.name, required this.icon});

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "icon": icon
    };
  }
}