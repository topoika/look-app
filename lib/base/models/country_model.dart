class Country {
  int? id;
  String? name;
  String? code;
  String? phoneCode;
  String? short_name;
  Country({
    this.id,
    this.name,
    this.code,
    this.phoneCode,
    this.short_name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'phoneCode': phoneCode,
      'short_name': short_name,
    };
  }

  factory Country.fromMap(Map<String, dynamic> map) {
    return Country(
      id: map['id']?.toInt(),
      name: map['name'],
      code: map['code'],
      phoneCode: map['phoneCode'],
      short_name: map['short_name'],
    );
  }
}

List<Country> countries = [
  Country(
    id: 1,
    name: "Korea",
    code: "KR",
    phoneCode: "+82",
    short_name: "kor",
  ),
  Country(
    id: 2,
    name: "United States",
    code: "US",
    phoneCode: "+1",
    short_name: "usa",
  ),
  Country(
    id: 3,
    name: "France",
    code: "FR",
    phoneCode: "+34",
    short_name: "fra",
  ),
  Country(
    id: 4,
    name: "Ukraine",
    code: "UA",
    phoneCode: "+60",
    short_name: "ukr",
  ),
  Country(
    id: 5,
    name: "Argentina",
    code: "AR",
    phoneCode: "+20",
    short_name: "arg",
  ),
  Country(
    id: 6,
    name: "Brazil",
    code: "BR",
    phoneCode: "+63",
    short_name: "BRZ",
  ),
  Country(
    id: 7,
    name: "China",
    code: "hk",
    phoneCode: "+40",
    short_name: "hkg",
  ),
  Country(
    id: 8,
    name: "Kenya",
    code: "ke",
    phoneCode: "+254",
    short_name: "ken",
  ),
  Country(
    id: 9,
    name: "Kenya",
    code: "ke",
    phoneCode: "+254",
    short_name: "ken",
  ),
];
