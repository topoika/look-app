import 'package:flutter/material.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/controllers/search_controller.dart';
import 'package:look/constant/theme.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import './../models/user_model.dart' as userModel;

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends StateMVC<Search> {
  final SearchController _con = SearchController();
  _SearchState() : super(SearchController());
  TextEditingController searchText = TextEditingController();

  Widget userList() {
    return _con.searchResult.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: _con.searchResult.length,
            itemBuilder: (context, index) {
              var user = _con.searchResult[index];
              return userTile(user);
            })
        : Container();
  }

  Widget userTile(userModel.User user) {
    return ListTile(
      title: Text(user.name ?? ""),
      subtitle: Text(user.location ?? ""),
      trailing: TextButton(
        child: const Text('Message'),
        onPressed: () => _con.sendMessage(user.name ?? ""),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textstyle = TextStyle(
        fontSize: getHorizontal(context) * 0.041,
        fontWeight: FontWeight.bold,
        fontFamily: 'PopR');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          color: theme().mPurple,
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Search",
          style: TextStyle(
              color: theme().mPurple,
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            color: Colors.grey[100],
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchText,
                    style: textstyle,
                    decoration: InputDecoration(
                        hintText: "search username ...",
                        hintStyle: TextStyle(
                          color: theme().mC,
                          fontSize: 16,
                        ),
                        border: InputBorder.none),
                  ),
                ),
                GestureDetector(
                  onTap: () => _con.initiateSearch(searchText.text),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Color(0x36FFFFFF), Color(0x0FFFFFFF)],
                            begin: FractionalOffset.topLeft,
                            end: FractionalOffset.bottomRight),
                        borderRadius: BorderRadius.circular(40)),
                    padding: const EdgeInsets.all(12),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.search,
                        color: theme().lightmC,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          userList()
        ],
      ),
    );
  }
}
