// To parse this JSON data, do
//
//     final quotes = quotesFromJson(jsonString);

import 'dart:convert';

List<Quotes> quotesFromJson(String str) =>
    List<Quotes>.from(json.decode(str).map((x) => Quotes.fromJson(x)));

String quotesToJson(List<Quotes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Quotes {
  final String? quote;
  final String? author;

  Quotes({
    this.quote,
    this.author,
  });

  factory Quotes.fromJson(Map<String, dynamic> json) => Quotes(
        quote: json["quote"],
        author: json["author"],
      );

  Map<String, dynamic> toJson() => {
        "quote": quote,
        "author": author,
      };
}
