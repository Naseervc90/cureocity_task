// Events
import 'package:equatable/equatable.dart';

abstract class CountryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchCountriesEvent extends CountryEvent {}

class SearchCountriesEvent extends CountryEvent {
  final String query;
  SearchCountriesEvent(this.query);

  @override
  List<Object> get props => [query];
}
