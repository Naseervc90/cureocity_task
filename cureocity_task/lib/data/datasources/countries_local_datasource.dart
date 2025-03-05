import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/entities/country_entity.dart';

class CountriesLocalDataSource {
  static const String _boxName = 'countries_box';

  Future<void> cacheCountries(List<Country> countries) async {
    final box = await Hive.openBox<Map>(_boxName);
    await box.clear();

    for (var country in countries) {
      await box.add({
        'code': country.code,
        'name': country.name,
        'emoji': country.emoji,
      });
    }
  }

  Future<List<Country>> getCachedCountries() async {
    final box = await Hive.openBox<Map>(_boxName);
    return box.values
        .map((countryMap) => Country(
              code: countryMap['code'],
              name: countryMap['name'],
              emoji: countryMap['emoji'],
            ))
        .toList();
  }
}
