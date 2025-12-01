class Address {
  final String id;
  final String name;
  final String city;
  final String? details;
  final String? phone;
  final String? region;
  final String? notes;

  Address({
    required this.id,
    required this.name,
    required this.city,
    this.details,
    this.phone,
    this.region,
    this.notes,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      city: json["city"] ?? "",
      details: json["details"],
      phone: json["phone"],
      region: json["region"],
      notes: json["notes"],
    );
  }
}

class AddressesResponse {
  final String status;
  final String? message;
  final int? results;
  final List<Address> data;

  AddressesResponse({
    required this.status,
    this.message,
    this.results,
    required this.data,
  });

  factory AddressesResponse.fromJson(Map<String, dynamic> json) {
    final rawData = json["data"];

    List<Address> addresses = [];

    if (rawData == null) {
      addresses = [];
    }
    else if (rawData is List) {
      addresses = rawData.map((e) => Address.fromJson(e)).toList();
    }
    else if (rawData is Map<String, dynamic>) {
      addresses = [Address.fromJson(rawData)];
    }

    return AddressesResponse(
      status: json["status"] ?? "",
      message: json["message"],
      results: json["results"],
      data: addresses,
    );
  }
}
