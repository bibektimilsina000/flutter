import 'package:epasal/providers/product.dart';
import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final imageUrlcontroller = TextEditingController();
  final imageUrlFocus = FocusNode();
  final form = GlobalKey();
  var editedProduct =
      Product(id: '', title: '', description: '', price: 0.0, imageUrl: '');

  @override
  void initState() {
    imageUrlFocus.addListener(updateImage);
    super.initState();
  }

  void updateImage() {
    if (!imageUrlFocus.hasFocus) {
      setState(() {});
    }
  }

  void saveForm() {
    form.currentState;
    print(editedProduct.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [IconButton(onPressed: saveForm, icon: Icon(Icons.done))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: form,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(label: Text('Title')),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) {},
                onSaved: (newValue) {
                  editedProduct = Product(
                      id: editedProduct.id,
                      title: newValue.toString(),
                      description: editedProduct.description,
                      price: editedProduct.price,
                      imageUrl: editedProduct.imageUrl);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(label: Text('Price')),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                onSaved: (newValue) {
                  editedProduct = Product(
                      id: editedProduct.id,
                      title: editedProduct.title,
                      description: editedProduct.description,
                      price: double.parse(newValue!),
                      imageUrl: editedProduct.imageUrl);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(label: Text('Description')),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                onSaved: (newValue) {
                  editedProduct = Product(
                      id: editedProduct.id,
                      title: editedProduct.title,
                      description: editedProduct.description,
                      price: editedProduct.price,
                      imageUrl: newValue.toString());
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 10, right: 15),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey)),
                      child: imageUrlcontroller.text.isEmpty
                          ? Center(
                              child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: FittedBox(
                                  child: Text(
                                'Enter Image Url',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              )),
                            ))
                          : Image.network(
                              imageUrlcontroller.text,
                              fit: BoxFit.cover,
                            )),
                  Expanded(
                    child: TextFormField(
                      decoration:
                          const InputDecoration(label: Text('Image Url')),
                      textInputAction: TextInputAction.done,
                      controller: imageUrlcontroller,
                      focusNode: imageUrlFocus,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}