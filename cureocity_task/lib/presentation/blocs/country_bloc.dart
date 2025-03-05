import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/repositories/countries_repository.dart';
import '../../domain/entities/country_entity.dart';
import 'country_event.dart';
import 'country_state.dart';

// BLoC
class CountryBloc extends Bloc<CountryEvent, CountryState> {
  final CountriesRepository repository;

  CountryBloc({required this.repository}) : super(CountryInitialState()) {
    on<FetchCountriesEvent>(_onFetchCountries);
    on<SearchCountriesEvent>(_onSearchCountries);
  }

  Future<void> _onFetchCountries(
      FetchCountriesEvent event, Emitter<CountryState> emit) async {
    emit(CountryLoadingState());
    try {
      final countries = await repository.getCountries();
      emit(CountryLoadedState(countries, countries));
    } catch (e) {
      emit(CountryErrorState(e.toString()));
    }
  }

  Future<void> _onSearchCountries(
      SearchCountriesEvent event, Emitter<CountryState> emit) async {
    if (state is CountryLoadedState) {
      final currentState = state as CountryLoadedState;
      final filteredCountries = currentState.countries
          .where((country) =>
              country.name.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      emit(CountryLoadedState(currentState.countries, filteredCountries));
    }
  }
}
