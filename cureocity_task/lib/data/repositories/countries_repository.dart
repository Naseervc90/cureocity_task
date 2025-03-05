import 'package:connectivity_plus/connectivity_plus.dart';
import '../../domain/entities/country_entity.dart';
import '../datasources/countries_local_datasource.dart';
import '../datasources/countries_remote_datasource.dart';

class CountriesRepository {
  final CountriesRemoteDataSource remoteDataSource;
  final CountriesLocalDataSource localDataSource;
  final Connectivity connectivity;

  CountriesRepository({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.connectivity,
  });

  Future<List<Country>> getCountries() async {
    final connectivityResult = await connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      return await localDataSource.getCachedCountries();
    }

    try {
      final countries = await remoteDataSource.fetchCountries();
      await localDataSource.cacheCountries(countries);
      return countries;
    } catch (e) {
      // If fetch fails, return cached data
      return await localDataSource.getCachedCountries();
    }
  }
}
