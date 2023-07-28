// ignore_for_file: public_member_api_docs, sort_constructors_first
class Contact {
  final int id;
  final String name;
  final int accountNumber;

  Contact(
    this.id,
    this.name,
    this.accountNumber,
  );

  @override
  String toString() {
    return 'Contact{id: $id, name: $name, accountNumber: $accountNumber}';
  }

  Contact.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        accountNumber = json['accountNumber'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'accountNumber': accountNumber,
      };

  @override
  bool operator ==(covariant Contact other) {
    if (identical(this, other)) return true;

    return other.name == name && other.accountNumber == accountNumber;
  }

  @override
  int get hashCode => name.hashCode ^ accountNumber.hashCode;
}
