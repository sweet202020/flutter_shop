import 'package:flutter/material.dart';
import '../providers/product.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});

  static const routename = '/edit-product';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceNodeFocus = FocusNode();
  final _descriptionNodeFocus = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    description: '',
    id: '',
    imageUrl: '',
    price: 0,
    title: '',
  );

  /* @override */
  /*  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  } */

  @override
  void dispose() {
    /* _imageUrlFocusNode.removeListener(_updateImageUrl); */
    _priceNodeFocus.dispose();
    _descriptionNodeFocus.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  /* void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  } */

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    /*   print(_editedProduct.title);
    print(_editedProduct.price);
    print(_editedProduct.description);
    print(_editedProduct.imageUrl); */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(onPressed: _saveForm, icon: const Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceNodeFocus);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a value';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedProduct = Product(
                    description: _editedProduct.description,
                    id: '',
                    imageUrl: _editedProduct.imageUrl,
                    price: _editedProduct.price,
                    title: value.toString(),
                  );
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                focusNode: _priceNodeFocus,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionNodeFocus);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Please enter a number greather than 0';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedProduct = Product(
                      description: _editedProduct.description,
                      id: '',
                      imageUrl: _editedProduct.imageUrl,
                      price: double.tryParse(value ?? '') ?? 0,
                      title: _editedProduct.title);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionNodeFocus,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a descrption';
                  }
                  if (value.length <= 10) {
                    return 'Should be at least 10 characters long';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  _editedProduct = Product(
                      description: value.toString(),
                      id: '',
                      imageUrl: _editedProduct.imageUrl,
                      price: _editedProduct.price,
                      title: _editedProduct.title);
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(
                      top: 8,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? const Text('enter a url')
                        : FittedBox(
                            fit: BoxFit.contain,
                            child: Image.network(_imageUrlController.text),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Image Url'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      /*  focusNode: _imageUrlFocusNode, */
                      onFieldSubmitted: (_) => _saveForm(),
                      onEditingComplete: () {
                        setState(() {});
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter an image Url';
                        }
                        if (!value.startsWith('http') &&
                            !value.startsWith('https') &&
                            !value.endsWith('png') &&
                            !value.endsWith('jpg') &&
                            !value.endsWith('jpeg')) {
                          return 'Please entera valid Url image';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          description: _editedProduct.description,
                          id: '',
                          imageUrl: value.toString(),
                          price: _editedProduct.price,
                          title: _editedProduct.title,
                        );
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
