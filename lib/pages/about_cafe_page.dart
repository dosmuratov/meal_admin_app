import 'package:flutter/material.dart';
import 'package:meal_admin_app/models/shop_info.dart';
import 'package:meal_admin_app/repository/provider_repository.dart';

class AboutCafePage extends StatefulWidget {
  const AboutCafePage({super.key});

  @override
  State<AboutCafePage> createState() => _AboutCafePageState();
}

class _AboutCafePageState extends State<AboutCafePage> {
  final Future<ShopModel> aboutCafe = ProviderRepository().getShopInfo();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Map<String, dynamic> _data = {};
  bool toAddChecker = false;

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Colors.blue;
    return Scaffold(
      appBar: AppBar(
        title: const Text('О заведении'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                toAddChecker = !toAddChecker;
              });
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: FutureBuilder(
        future: aboutCafe,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            final ShopModel info = snapshot.data!;
            return Form(
              key: formKey,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width / 1.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: primaryColor,
                          ),
                        ),
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            TextFormField(
                              readOnly: !toAddChecker,
                              controller: nameController,
                              decoration: InputDecoration(
                                label: toAddChecker
                                    ? const Text('Название заведения')
                                    : Text(info.name),
                                border: toAddChecker
                                    ? OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: primaryColor,
                                        ),
                                      )
                                    : const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(255, 255, 255, 1),
                                        ),
                                      ),
                              ),
                              validator: (value) {
                                if (value == null) {
                                  return 'Введите название заведения';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              readOnly: !toAddChecker,
                              controller: descriptionController,
                              maxLines: 3,
                              decoration: InputDecoration(
                                label: toAddChecker
                                    ? const Text('Подробное описание')
                                    : Text(info.description),
                                border: toAddChecker
                                    ? OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: primaryColor,
                                        ),
                                      )
                                    : const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(255, 255, 255, 1),
                                        ),
                                      ),
                              ),
                              validator: (value) {
                                if (value == null) {
                                  return 'Введите описание о заведении';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              readOnly: !toAddChecker,
                              controller: timeController,
                              maxLines: 3,
                              decoration: InputDecoration(
                                label: toAddChecker
                                    ? const Text('Время работы')
                                    : Text(info.timesOfWork),
                                border: toAddChecker
                                    ? OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: primaryColor,
                                        ),
                                      )
                                    : const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(255, 255, 255, 1),
                                        ),
                                      ),
                              ),
                              validator: (value) {
                                if (value == null) {
                                  return 'Введите время работы';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      toAddChecker
                          ? OutlinedButton.icon(
                              onPressed: () async {
                                formKey.currentState!.validate();
                                _data.addAll(
                                  {'Название': nameController.text},
                                );
                                _data.addAll(
                                  {'Описание': descriptionController.text},
                                );
                                _data.addAll(
                                  {'Время работы': timeController.text},
                                );
                                nameController.clear();
                                descriptionController.clear();
                                timeController.clear();
                                final respStatus = await ProviderRepository()
                                    .addShopInfo(_data);
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: respStatus
                                        ? const Text('Данные успешно добавлены')
                                        : const Text(
                                            'Произошла ошибка, повторите снова'),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.done),
                              label: const Text('Сохранить'),
                            )
                          : const Center(),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: Text('Обратитесь к разработчикам'),
            );
          }
        },
      ),
    );
  }
}
