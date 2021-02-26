import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab9_firestore/showdetail.dart';

class BookPage extends StatelessWidget {
  final store = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: store.collection('books').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Books"),
            actions: <Widget>[buildAddButton(context)],
          ),
          body: snapshot.hasData
              ? buildBookList(snapshot.data)
              : Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }

  IconButton buildAddButton(context) {
    return IconButton(
        icon: Icon(Icons.add),
        onPressed: () {
          print("add icon press");
          Navigator.pushNamed(context, '/addbook');
        });
  }

  ListView buildBookList(QuerySnapshot data) {
    return ListView.builder(
      itemCount: data.size,
      itemBuilder: (BuildContext context, int index) {
        var model = data.docs.elementAt(index);
        return ListTile(
          title: Text(model['title'] + '  ' + model['author']),
          subtitle: Text(model['detail']),
          trailing: Text("${model['price']}"),
          onTap: () {
            print(model['title']);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BookDetail(model['title'])));
          },
        );
      },
    );
  }
}
