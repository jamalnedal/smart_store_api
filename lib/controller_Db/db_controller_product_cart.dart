import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
class DbControllerProductCart{
  static final DbControllerProductCart _dbControllerCart= DbControllerProductCart._internal();
  DbControllerProductCart._internal();
  late Database _database;
  Database get database=> _database;
  factory DbControllerProductCart(){
    return _dbControllerCart;
  }
  Future<void> initDataBase()async{
    Directory directory= await getApplicationDocumentsDirectory();
    String path= join(directory.path,'app_db');
    _database= await openDatabase(
      path,
      version:12,
      onCreate:(Database db,int version) async {
         //  await db.execute('DROP TABLE IF EXISTS cartproduct');
        // 'CREATE TABLE cart('
        // 'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        // 'name TEXT NOT NULL,'
        // 'image TEXT NOT NULL,'
        // 'price INTEGER NOT NULL,'
        // 'count INTEGER NOT NULL'
        // ')');
        // await db.execute('CREATE TABLE cartShop('
        //     'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        //     'idproduct INTEGER NOT NULL,'
        //     'name TEXT NOT NULL,'
        //     'image TEXT NOT NULL,'
        //     'price INTEGER NOT NULL,'
        //     'count INTEGER NOT NULL'
        //     ')');
         await db.execute('CREATE TABLE cartproducts('
             'id INTEGER PRIMARY KEY AUTOINCREMENT,'
             'idproduct INTEGER NOT NULL,'
             'name TEXT NOT NULL,'
             'quantity INTEGER NOT NULL,'
             'iduser INTEGER NOT NULL,'
             'image TEXT NOT NULL,'
             'nameAr TEXT NOT NULL,'
             'infoEn TEXT NOT NULL,'
             'infoAr TEXT NOT NULL,'
             'price INTEGER NOT NULL,'
             'count INTEGER NOT NULL,'
             'overalRate INTEGER NOT NULL,'
             'subCategoryId INTEGER NOT NULL,'
             'productRate INTEGER NOT NULL,'
             'offerPrice INTEGER NOT NULL,'
             'isFavorite INTEGER NOT NULL'
             ')');


      } ,
      onUpgrade:(Database db,int oldVersion,int newVersion)async {
        if (oldVersion == 11) {
          await db.execute('CREATE TABLE cartproducts('
              'id INTEGER PRIMARY KEY AUTOINCREMENT,'
              'idproduct INTEGER NOT NULL,'
              'name TEXT NOT NULL,'
              'quantity INTEGER NOT NULL,'
              'iduser INTEGER NOT NULL,'
              'image TEXT NOT NULL,'
              'nameAr TEXT NOT NULL,'
              'infoEn TEXT NOT NULL,'
              'infoAr TEXT NOT NULL,'
              'price INTEGER NOT NULL,'
              'count INTEGER NOT NULL,'
              'overalRate INTEGER NOT NULL,'
              'subCategoryId INTEGER NOT NULL,'
              'productRate INTEGER NOT NULL,'
              'offerPrice INTEGER NOT NULL,'
              'isFavorite INTEGER NOT NULL'
              ')');
          //await db.execute('DROP TABLE IF EXISTS cartproduct');
          print('cnihruhchurshu');
        }
       //   await db.execute('CREATE TABLE cartproducts('
       //       'id INTEGER PRIMARY KEY AUTOINCREMENT,'
       //       'idproduct INTEGER NOT NULL,'
       //       'name TEXT NOT NULL,'
       //       'quantity INTEGER NOT NULL,'
       //       'iduser INTEGER NOT NULL,'
       //       'image TEXT NOT NULL,'
       //       'nameAr TEXT NOT NULL,'
       //       'infoEn TEXT NOT NULL,'
       //       'infoAr TEXT NOT NULL,'
       //       'price INTEGER NOT NULL,'
       //       'count INTEGER NOT NULL,'
       //       'overalRate INTEGER NOT NULL,'
       //       'subCategoryId INTEGER NOT NULL,'
       //       'productRate INTEGER NOT NULL,'
       //       'offerPrice INTEGER NOT NULL,'
       //       'isFavorite INTEGER NOT NULL'
       //       ')');
       //   //await db.execute('DROP TABLE IF EXISTS cartproduct');
       //   print('lxeeeeeelxeleeeeeeeee');
       // }
       //
       //  print('slsllslssssssssssssssssssssssss');
      },
     //   await db.execute('CREATE TABLE cartproduct('
     //       'id INTEGER PRIMARY KEY AUTOINCREMENT,'
     //       'idproduct INTEGER NOT NULL,'
     //       'name TEXT NOT NULL,'
     //       'quantity INTEGER NOT NULL,'
     //       'image TEXT NOT NULL,'
     //       'nameAr TEXT NOT NULL,'
     //       'infoEn TEXT NOT NULL,'
     //       'infoAr TEXT NOT NULL,'
     //       'price INTEGER NOT NULL,'
     //       'count INTEGER NOT NULL,'
     //       'overalRate INTEGER NOT NULL,'
     //       'subCategoryId INTEGER NOT NULL,'
     //       'productRate INTEGER NOT NULL,'
     //       'offerPrice INTEGER NOT NULL,'
     //       'isFavorite INTEGER NOT NULL'
     //       ')');
     //  print('eiiiiiiiiiiiiiiiiiiiiiiiii');


    //   await db.execute('CREATE TABLE cartShopnew('
    //       'id INTEGER PRIMARY KEY AUTOINCREMENT,'
    //       'idproduct INTEGER NOT NULL,'
    //       'name TEXT NOT NULL,'
    //       'addcart INTEGER NOT NULL,'
    //       'image TEXT NOT NULL,'
    //       'price INTEGER NOT NULL,'
    //       'count INTEGER NOT NULL'
    //       ')');
   //   print('rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');

      onDowngrade:(Database db,int oldVersion,int newVersion){},


    );
  }



}