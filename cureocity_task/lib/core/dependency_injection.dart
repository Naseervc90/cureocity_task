import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../data/datasources/countries_local_datasource.dart';
import '../data/datasources/countries_remote_datasource.dart';
import '../data/repositories/countries_repository.dart';
import '../presentation/blocs/country_bloc.dart';

final getIt = GetIt.instance;

void setupDependencyInjection() {
  // GraphQL Client
  getIt.registerLazySingleton<GraphQLClient>(() {
    final HttpLink httpLink = HttpLink('https://countries.trevorblades.com/');
    return GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),
    );
  });

  // Data Sources
  getIt.registerLazySingleton<CountriesRemoteDataSource>(
      () => CountriesRemoteDataSource(getIt<GraphQLClient>()));

  getIt.registerLazySingleton<CountriesLocalDataSource>(
      () => CountriesLocalDataSource());

  // Connectivity
  getIt.registerLazySingleton<Connectivity>(() => Connectivity());

  // Repository
  getIt.registerLazySingleton<CountriesRepository>(() => CountriesRepository(
        remoteDataSource: getIt<CountriesRemoteDataSource>(),
        localDataSource: getIt<CountriesLocalDataSource>(),
        connectivity: getIt<Connectivity>(),
      ));

  // BLoC
  getIt.registerFactory<CountryBloc>(
      () => CountryBloc(repository: getIt<CountriesRepository>()));
}
