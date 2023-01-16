
import 'package:mysql1/mysql1.dart';

class DBCredentials{

   Future mySqlConnnect()async{
     final conn = await MySqlConnection.connect(ConnectionSettings(
       host: '10.0.2.2',
       port: 3306,
       user: "root",
       db: "weather_app",
     ));
   }
   Future<dynamic> insert(String name, String email, dynamic password)async{
     final conn = await MySqlConnection.connect(ConnectionSettings(
       host: '10.0.2.2',
       port: 3306,
       user: "root",
       db: "weather_app",
     ));
     var result = await conn.query('insert into users (name, email, password) values (?,?,?)', [name.toString(), email.toString(), password.toString()]);
     print(result.affectedRows);
     print(result.insertId);

     await conn.close();
   }
   Future<dynamic> retrieve(String name, dynamic password)async{
     final conn = await MySqlConnection.connect(ConnectionSettings(
       host: '10.0.2.2',
       port: 3306,
       user: "root",
       db: "weather_app",
     ));
     var user1 = 3;
    //var result = await conn.query('select name, password from users where id = ?', [user1]);
      var result = await conn.query('select name, password from users where name = ? and password = ?',
         [name.toString(), password.toString()]);
     print(result.affectedRows);
     print(result.insertId);
     print("result result of the object  $result");

     if(result.length == 0){

     }else{
     }

     await conn.close();
   }
}