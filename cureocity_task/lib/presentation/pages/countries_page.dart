import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/country_entity.dart';

import '../blocs/country_bloc.dart';
import '../blocs/country_event.dart';
import '../blocs/country_state.dart';
import '../widgets/countries_list_item.dart';

class CountriesPage extends StatefulWidget {
  const CountriesPage({Key? key}) : super(key: key);

  @override
  _CountriesPageState createState() => _CountriesPageState();
}

class _CountriesPageState extends State<CountriesPage> {
  late CountryBloc _countryBloc;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _countryBloc = GetIt.instance<CountryBloc>();
    _countryBloc.add(FetchCountriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countries'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search countries...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (query) {
                _countryBloc.add(SearchCountriesEvent(query));
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<CountryBloc, CountryState>(
              bloc: _countryBloc,
              builder: (context, state) {
                if (state is CountryLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is CountryErrorState) {
                  return Center(
                    child: Text(
                      'Error: ${state.message}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                if (state is CountryLoadedState) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      _countryBloc.add(FetchCountriesEvent());
                    },
                    child: ListView.builder(
                      itemCount: state.filteredCountries.length,
                      itemBuilder: (context, index) {
                        final country = state.filteredCountries[index];
                        return CountryListItem(country: country);
                      },
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _countryBloc.close();
    super.dispose();
  }
}
