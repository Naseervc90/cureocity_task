import 'package:graphql_flutter/graphql_flutter.dart';
import '../../domain/entities/country_entity.dart';

class CountriesRemoteDataSource {
  final GraphQLClient client;

  CountriesRemoteDataSource(this.client);

  Future<List<Country>> fetchCountries() async {
    const String query = r'''
      query {
        countries {
          code
          name
          emoji
        }
      }
    ''';

    final QueryResult result = await client.query(
      QueryOptions(document: gql(query)),
    );

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final List<dynamic> countriesData = result.data?['countries'] ?? [];
    return countriesData
        .map((country) => Country(
              code: country['code'],
              name: country['name'],
              emoji: country['emoji'],
            ))
        .toList();
  }
}
