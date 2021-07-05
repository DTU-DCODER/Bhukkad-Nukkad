import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products.dart';

class NewProduct {
  String? title;
  double? price;
  String? imageUrl;
  String? description;
  NewProduct({
    this.title = "",
    this.price = 0,
    this.imageUrl = "",
    this.description = "",
  });
}

class EditProductScreen extends StatefulWidget {
  static const routeName = "/edit-product";
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var newProduct = NewProduct();
  bool _isInit = true;
  bool _isLoading = false;
  Product? chosenProduct;
  bool get isImageValid {
    String url = _imageUrlController.text;

    bool _validURL = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    if (url.isNotEmpty &&
        _validURL &&
        (url.endsWith('.jpg') ||
            url.endsWith('.jpeg') ||
            url.endsWith('.png'))) {
      return true;
    }
    return false;
  }

  void _updateImageUrl() {
    if (isImageValid && !_imageUrlFocusNode.hasFocus) setState(() {});
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  void _saveForm() {
    print("On saved triggered");
    bool areAllValid = _form.currentState!.validate();
    if (!areAllValid) {
      return;
    }
    final productsData = Provider.of<Products>(context, listen: false);
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    final toBeAddedProduct = Product(
      id: chosenProduct!.id == ""
          ? "p" + (productsData.itemsLength + 1).toString()
          : chosenProduct!.id,
      description: newProduct.description,
      imageUrl: newProduct.imageUrl,
      price: newProduct.price,
      title: newProduct.title,
      isFavorite: chosenProduct!.isFavorite,
    );
    if (chosenProduct!.id == "") {
      productsData.addProduct(toBeAddedProduct).catchError((error) {
        return showDialog<Null>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("An error occured!"),
            content: Text("Something went wrong"),
            actions: [
              TextButton(
                child: Text("Okay"),
                onPressed: () => Navigator.of(ctx).pop(),
              )
            ],
          ),
        );
      }).then((_) {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      });
    } else {
      productsData.updateProduct(chosenProduct!.id, toBeAddedProduct).then((_) {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      });
    }
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments;
      if (productId != null) {
        chosenProduct =
            Provider.of<Products>(context).findById(productId as String);
        newProduct.price = chosenProduct!.price;
        newProduct.description = chosenProduct!.description;
        newProduct.title = chosenProduct!.title;
        _imageUrlController.text = chosenProduct!.imageUrl!;
      } else {
        chosenProduct = Product(
          description: "",
          id: "",
          imageUrl: "",
          price: 0,
          title: "",
        );
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Products"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: newProduct.title,
                        decoration: InputDecoration(
                          labelText: "Title",
                        ),
                        textInputAction: TextInputAction.next,
                        onSaved: (value) => newProduct.title = value,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Title cannot be empty";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: newProduct.price != 0
                            ? newProduct.price.toString()
                            : "",
                        decoration: InputDecoration(
                          labelText: "Price",
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        onSaved: (value) =>
                            newProduct.price = double.parse(value!),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Price cannot be empty!";
                          }
                          if (double.tryParse(value) == null) {
                            return "Enter a valid number!";
                          }
                          if (double.parse(value) <= 0) {
                            return "Price should be above zero!";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: newProduct.description,
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          labelText: "Description",
                        ),
                        onSaved: (value) => newProduct.description = value,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Description cannot be empty";
                          }
                          if (value.length < 10) {
                            return "At least 10 characters required";
                          }
                          return null;
                        },
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                              top: 8,
                              right: 10,
                            ),
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.grey,
                              ),
                            ),
                            child: _imageUrlController.text.isEmpty
                                ? Center(
                                    child: FittedBox(
                                      child: Text("No URL Entered"),
                                    ),
                                  )
                                : isImageValid
                                    ? FittedBox(
                                        child: Hero(
                                          tag: "user" + chosenProduct!.id!,
                                          child: Image.network(
                                            _imageUrlController.text,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    : Center(
                                        child: Text(
                                          "Invalid URL",
                                          style: TextStyle(
                                              color:
                                                  Theme.of(context).errorColor),
                                        ),
                                      ),
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: "Image URL",
                              ),
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              controller: _imageUrlController,
                              focusNode: _imageUrlFocusNode,
                              onEditingComplete: () => setState(() {}),
                              onChanged: (_) => setState(() {}),
                              onFieldSubmitted: (_) => _saveForm(),
                              onSaved: (value) => newProduct.imageUrl = value,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Image URL cannot be empty";
                                }
                                if (!isImageValid) {
                                  return "Invalid URL";
                                }
                                return null;
                              },
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
