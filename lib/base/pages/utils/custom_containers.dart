import 'package:flutter/material.dart';
import 'package:look/base/models/country_model.dart';

Widget countryItemWidget(BuildContext context, Country country) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: Theme.of(context).accentColor,
    ),
    child: Row(
      children: <Widget>[
        Image.network(
          "https://flagcdn.com/${country.code!.toLowerCase()}.svg",
          fit: BoxFit.cover,
        ),
        Text(country.short_name ?? ""),
      ],
    ),
  );
}
