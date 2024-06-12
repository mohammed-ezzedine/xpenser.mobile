class AccountOpeningResponse {
  final String id;

  const AccountOpeningResponse({ required this.id });

  factory AccountOpeningResponse.fromJson(Map<String, dynamic> json) {
    return AccountOpeningResponse(id: json["id"]);
  }
}