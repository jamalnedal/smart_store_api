import 'package:flutter/material.dart';
import 'Information_cart_dp_controller.dart';
import 'information_cart.dart';

class InformationCartProvider extends ChangeNotifier {
  List<InformationCart> contact = <InformationCart>[];
  InformationCartDpController r = InformationCartDpController();

  Future<void> read() async {
    contact = await r.read();
    notifyListeners();
  }

  Future<bool> create({required InformationCart c}) async {
    int id = await r.create(c);
    if (id != 0) {
      c.id = id;
      contact.add(c);
      notifyListeners();
    }
    return id != 0;
  }

  Future<bool> delete(int id) async {
    bool deleted = await r.delete(id);
    if (deleted) {
      // contact.removeWhere((element) => element.id==id);
      int index = contact.indexWhere((element) => element.id == id);
      if (index != -1) {
        contact.removeAt(index);
        notifyListeners();
      }
    }
    return deleted;
  }

  Future<bool> update({required InformationCart contacts}) async {
    bool udating = await r.update(contacts);
    if (udating) {
      // contact.removeWhere((element) => element.id==id);
      int index = contact.indexWhere((element) => element.id == contacts.id);
      if (index != 1) {
        contact[index] = contacts;
        notifyListeners();
      }
    }
    return udating;
  }
}
