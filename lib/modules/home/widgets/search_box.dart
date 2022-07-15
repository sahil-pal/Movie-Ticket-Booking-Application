import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/themes/mytheme.dart';
import '../cubit/search_cubit.dart';

class SearchBox extends StatelessWidget {
  
  TextEditingController searchText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SearchCubit searchCubit = BlocProvider.of<SearchCubit>(context);
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            validator: ((value) {
              if(value?.length != 0 || value != null){
                return '';
              }
              return 'Input Invalid';
            }),
            autocorrect: false,
            style: MyTheme.currentTheme.textTheme.labelSmall,
            cursorHeight: 25,
            controller: searchText,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
              hintText: 'Search Movies, Shows... ',
              hintStyle: MyTheme.currentTheme.textTheme.bodyMedium,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.black.withOpacity(0.5), width: 2.0),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green, width: 2.0),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Container(
          height: 58,
          child: ElevatedButton(
            onPressed: () {
              if(searchText.text != ''){
                searchCubit.getResultsBySearch(searchText.text);
              }
            },
            style: ElevatedButton.styleFrom(primary: Colors.green),
            child: const Text("Search"),
          ),
        )
      ],
    );
  }
}