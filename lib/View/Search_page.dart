import 'package:flutter/material.dart';
import 'package:weather/widgets/Weather_card_view_Builder.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  String? searchdata;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: "Search here",
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
                style: const TextStyle(fontSize: 18, color: Colors.white),
                onSubmitted: (value) {
                  setState(() {
                    searchdata = value.trim();
                    isSearching = false; // رجع للوضع العادي بعد البحث
                  });
                },
              )
            : const Text(
                "Search by Country",
                style: TextStyle(color: Colors.white),
              ),
        actions: [
          IconButton(
            icon: Icon(
              isSearching ? Icons.close : Icons.search,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                if (isSearching) {
                  // رجع للوضع العادي + امسح التكست
                  isSearching = false;
                  _searchController.clear();
                  // متصفرش searchdata => النتيجة تفضل
                } else {
                  isSearching = true;
                }
              });
            },
          ),
        ],
      ),
      backgroundColor: const Color(0xff04082D),
      body: (searchdata != null && searchdata!.isNotEmpty)
          ? SingleChildScrollView(
            child: SizedBox(
              height: size.height*0.82,
              child: WeatherCardViewBuilder(contry: searchdata!)),
          )
          : const Center(
              child: Text(
                "Search About Your Specific Country",
                style: TextStyle(color: Colors.white),
              ),
            ),
    );
  }
}
