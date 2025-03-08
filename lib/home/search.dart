import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Search Tab UI'),
          backgroundColor: Color.fromARGB(255, 254, 240, 159),
          actions: [
            IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () {
                // Add your filter action here
              },
            ),
          ],
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    onChanged: (query) {
                      // Handle search query changes
                    },
                    onSubmitted: (query) {
                      // Handle search submission
                    },
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text('Search Result $index'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Add content for Tab 2 here
            Center(child: Text('Tab 2 Content')),
          ],
        ),
      ),
    );
  }
}
