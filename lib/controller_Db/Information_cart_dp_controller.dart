import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'db_controller_product_cart.dart';
import 'dp_operation.dart';
import 'information_cart.dart';

class InformationCartDpController implements DpOperation<InformationCart>{
  Database informationCart=DbControllerProductCart().database;
  @override
  Future<int> create(object)async {
    // TODO: implement creat
    int newRowId=await informationCart.insert('cartproducts', object.toMap());
    return newRowId;
    throw UnimplementedError();
  }

  @override
  Future<bool> delete(int id) async {
    int nomDeleteRow=await informationCart.delete('cartproducts', where:'id = ?',whereArgs: [id]);
    return nomDeleteRow>0;

  }

  @override
  Future<List <InformationCart>> read() async {
    List<Map<String, dynamic>> rows = await informationCart.query('cartproducts');
    return rows.map((rowMap) => InformationCart.fromMap(rowMap)).toList();

  }

  @override
  Future<InformationCart?> show(int id) async {
    List<Map<String, dynamic>> rows = await informationCart.query('cartproducts', where: 'id ?',whereArgs: [id]);
    return rows.isNotEmpty? InformationCart.fromMap(rows.first):null;

  }

  @override
  Future<bool> update(object)async {
    int numOfUpdateRows= await informationCart.update('cartproducts',object.toMap(),where: 'id = ?',whereArgs: [object.id]);
  return numOfUpdateRows>0;

  }}
  //crud=> Creat,Read,Update,Delet

