// States
import 'package:equatable/equatable.dart';

import '../../domain/entities/country_entity.dart';

abstract class CountryState extends Equatable {
  @override
  List<Object> get props => [];
}

class CountryInitialState extends CountryState {}

class CountryLoadingState extends CountryState {}

class CountryLoadedState extends CountryState {
  final List<Country> countries;
  final List<Country> filteredCountries;

  CountryLoadedState(this.countries, this.filteredCountries);

  @override
  List<Object> get props => [countries, filteredCountries];
}

class CountryErrorState extends CountryState {
  final String message;
  CountryErrorState(this.message);

  @override
  List<Object> get props => [message];
}
