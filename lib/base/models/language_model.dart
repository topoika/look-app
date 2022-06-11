// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:look/base/Helper/strings.dart';

class Language {
  String? name;
  String? localName;
  String? code;
  String? image;
  Language({
    this.name,
    this.localName,
    this.code,
    this.image,
  });
}

List<Language> languages = [
  Language(name: "English", localName: "영어", code: "en", image: english),
  Language(name: "Korean", localName: "한국인", code: "ko", image: korean),
];
