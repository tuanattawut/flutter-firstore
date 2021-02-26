import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddBookPage extends StatefulWidget {
  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final _form = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _detail = TextEditingController();
  final _author = TextEditingController();
  final _price = TextEditingController();
  final store = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add book'),
      ),
      body: Form(
        key: _form,
        child: ListView(
          children: <Widget>[
            buildTitleField(),
            buildAuthorField(),
            buildDetailField(),
            buildPriceField(),
            buildSaveButton()
          ],
        ),
      ),
    );
  }

  RaisedButton buildSaveButton() {
    return RaisedButton(
        child: Text('Save'),
        onPressed: () async {
          if (this._form.currentState.validate()) {
            print('save button press');
            Map<String, dynamic> data = {
              'title': _title.text,
              'author': _author.text,
              'detail': _detail.text,
              'price': double.parse(_price.text)
            };
            try {
              DocumentReference ref =
                  await this.store.collection('books').add(data);
              print('save id = ${ref.id}');
              Navigator.pop(context);
            } catch (e) {
              Scaffold.of(this._form.currentContext).showSnackBar(
                SnackBar(
                  content: Text('Error $e'),
                ),
              );
            }
          } else {
            Scaffold.of(this._form.currentContext).showSnackBar(
              SnackBar(
                content: Text('Please validate value'),
              ),
            );
          }
        });
  }

  TextFormField buildAuthorField() {
    return TextFormField(
      controller: _author,
      decoration: InputDecoration(
        labelText: 'author',
        icon: Icon(Icons.people),
      ),
      validator: (value) => value.isEmpty ? 'Please fill in author' : null,
    );
  }

  TextFormField buildTitleField() {
    return TextFormField(
      controller: _title,
      decoration: InputDecoration(
        labelText: 'title',
        icon: Icon(Icons.book),
      ),
      validator: (value) => value.isEmpty ? 'Please fill in title' : null,
    );
  }

  TextFormField buildDetailField() {
    return TextFormField(
      controller: _detail,
      decoration: InputDecoration(
        labelText: 'detail',
        icon: Icon(Icons.list),
      ),
      validator: (value) => value.isEmpty ? 'Please fill in detail' : null,
    );
  }

  TextFormField buildPriceField() {
    return TextFormField(
        controller: _price,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'price',
          icon: Icon(Icons.list),
        ),
        validator: (value) {
          if (value.isEmpty)
            return 'Please fill in price';
          else {
            double price = double.parse(value);
            if (price < 0)
              return 'Please fill in price';
            else
              return null;
          }
        });
  }
}
