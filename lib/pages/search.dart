import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soko_fresh/Service/database.dart'; // Import your DatabaseMethods if needed
import 'package:soko_fresh/pages/details.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});


  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _searchController;
  Stream? searchResultStream;
   String _selectedCategory = 'Farmer';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
      searchItems(_selectedCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for items...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    String searchText = _searchController.text.trim();
                    if (searchText.isNotEmpty) {
                      searchItems(searchText);
                    }
                  },
                ),
              ),
            ),
          ),
                 const SizedBox(width: 20),
              DropdownButton<String>(
                value: _selectedCategory,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedCategory = newValue;
                    });
                    searchItems(newValue);
                  }
                },
                items: <String>['Farmer', 'Distributor', 'Grocery Store', 'Consumer']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
          Expanded(
            child: _buildSearchResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return StreamBuilder(
      stream: searchResultStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
          return const Center(child: Text('No results found'));
        }
        return ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data.docs[index];
            return ListTile(
              title: Text(ds['Name']),
              
              subtitle: Text('Price: Ksh ${ds['Price']}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Details(
                      detail: ds['Detail'],
                      image: ds['Image'],
                      name: ds['Name'],
                      price: ds['Price'], phoneNumber: ds['PhoneNumber'],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  void searchItems(String searchText) async {
    searchResultStream = await DatabaseMethods().searchFoodItem(searchText);
    setState(() {});
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
