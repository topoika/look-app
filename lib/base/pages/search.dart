import 'package:flutter/material.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/Helper/strings.dart';
import 'package:look/base/controllers/search_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';
import './../models/user_model.dart' as userModel;

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends StateMVC<Search> {
  late SearchController _con;

  _SearchState() : super(SearchController()) {
    _con = controller as SearchController;
  }
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
      leading: CircleAvatar(
        radius: 30.0,
        backgroundImage: NetworkImage(user.image ?? noImage),
        backgroundColor: Colors.transparent,
      ),
      contentPadding: EdgeInsets.all(0),
      title: Text(user.name ?? ""),
      subtitle: Text(user.location ?? ""),
      trailing: TextButton(
        child: Text(S.of(context).message_text),
        onPressed: () => _con.sendMessage(context, user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textstyle = TextStyle(
      fontSize: getHorizontal(context) * 0.035,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        title: Text(
          S.of(context).search,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: getHorizontal(context) * 0.045),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        width: double.infinity,
        padding:
            EdgeInsets.symmetric(horizontal: getHorizontal(context) * 0.05),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black.withOpacity(.2),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchText,
                      style: textstyle,
                      onChanged: (val) {
                        _con.initiateSearch(searchText.text);
                      },
                      decoration: InputDecoration(
                          hintText: S.of(context).search_username + "...",
                          hintStyle: TextStyle(
                            fontSize: getHorizontal(context) * 0.035,
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _con.initiateSearch(searchText.text),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [Color(0x36FFFFFF), Color(0x0FFFFFFF)],
                              begin: FractionalOffset.topLeft,
                              end: FractionalOffset.bottomRight),
                          borderRadius: BorderRadius.circular(40)),
                      padding: const EdgeInsets.all(12),
                      child: const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            ),
            userList()
          ],
        ),
      ),
    );
  }
}
