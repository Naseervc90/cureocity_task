import 'package:flutter/material.dart';
import '../../domain/entities/country_entity.dart';

class CountryListItem extends StatelessWidget {
  final Country country;

  const CountryListItem({Key? key, required this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(country.emoji, style: const TextStyle(fontSize: 24)),
      title: Text(country.name),
      trailing: Text(country.code),
    );
  }
}
