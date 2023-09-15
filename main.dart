import dart::io
import 'dart:io' show Platform;

class pSQL{
  void shell(){
    print("pSQL Shell 0.0.1");
    print("Type 'help' for help.");
    print("pSQL$ ")
    while true{
      var command = stdin.readLineSync();
      if command == "help"{
        print("""
        pSQL Shell 0.0.1

        pSQL Shell is where you can interact with the database using the pSQL (pickaxe Structured Query language). For more 
        information on how to use pSQL, please visit the website: (Soon!)

        Commands:
         select/sel (DQL): Selects data from a table in the database.
         insert/ins (DML): Inserts data into a table in the database.
         update/up (DML): Updates data in a table in the database.
         delete/del (DML): Deletes data from a table in the database.
         create/cre (DDL): Creates a table in the database.
         alter/alt (DDL): Modifies a table in the database.
         deltable/delt (DDL): Deletes a table in the database.

        """);
      }
      else if command == "exit"{
        break;
      }
      else if command == "select" or "sel" or "SELECT"{
        pSQL.main.select
      }

      else if command == "insert" or "ins" or "INSERT"{
        pSQL.main.insert
      }

      else if command == "update" or "up" or "UPDATE"{
        pSQL.main.update
      }

      else if command == "delete" or "del" or "DELETE"{
        pSQL.main.delete
      }

      else if command == "create" or "cre" or "CREATE"{
        pSQL.main.create
      }

      else if command == "alter" or "alt" or "ALTER"{
        pSQL.main.alter
      }

      else if command == "deltable" or "delt" or "DELTABLE"{
        pSQL.main.deltable
      }

      else{
        print("Invalid command. Type 'help' for help.");
      }

    }
  }

  class main{
    void select(){
      // TO-DO
    }

    void insert(){
      // TO-DO
    }

    void update(){
      // TO-DO
    }

    void delete(){
      // TO-DO
    }
    
void create(String TableName) {
  String regularPath;
  String filePath;

  if (Platform.isWindows) {
    var user = Platform.environment['USERNAME'];
    regularPath = "C:/Users/$user/.psql";
    filePath = "$regularPath/main.psql";
    print("pSQL: Creating Table $TableName");
  } else if (Platform.isLinux) {
    regularPath = "~/.local/share/pSQL";
    filePath = "$regularPath/main.psql";
    print("pSQL: Creating Table $TableName");
  } else {
    print("pSQL: Operating system not supported. Please use Windows or Linux.");
    return;
  }

  final file = File(filePath);

  if (!file.existsSync()) {
    try {
      final content = """
<Header Section>
-------------------------------
pSQL Format 1

<Master Schema Section>
---------------------------------------------
| type        | name      
|-------------|-----------|
| table       | $TableName |
---------------------------------------------

<Table Data Section>
--------------------------------
Table: $TableName
---------------------------------------------
| id | name       | value           |
|----|------------|-----------------|
---------------------------------------------
""";

      file.createSync(recursive: true);
      file.writeAsStringSync(content);

      print('Table $TableName created successfully!');
      print(content);
    } catch (e) {
      print('An error occurred while creating the Table or Main Database: $e');
    }
  } else {
    try {
      final existingContent = file.readAsStringSync();
      final newContent = """
$existingContent

<Master Schema Section>
---------------------------------------------
| type        | name      
|-------------|-----------|
| table       | $TableName |
---------------------------------------------

<Table Data Section>
--------------------------------
Table: $TableName
---------------------------------------------
| id | name       | value           |
|----|------------|-----------------|
---------------------------------------------
""";

      file.writeAsStringSync(newContent);

      print('Table $TableName added to the existing database!');
      print(newContent);
    } catch (e) {
      print('An error occurred while adding the Table to the existing Main Database: $e');
    }
  }
}


    void alter(){
      // TO-DO
    }

    void deltable(){
      // TO-DO
    }
  }

}

void main(args[shell, help, about]){
    print("""
    pSQL 0.0.1
    usage: pSQL <command> [args]
    
    pSQL or pickaxeSQL is a simple that uses a modified version of SQL
   (most specifically, MySQL) intended to be more simple and intuitive to store data.
    It technically is similar to other SQL DBMSs like SQLite,
    MySQL, MariaDB, PostgreSQL and MsSQL but it is more simple and inuitive.

    Commands:
     shell: enters the pSQL shell.
     help: Shows this message.
     about: Shows the about pSQL page, containing credits and contribuitors.

    By default, all the databases in pSQL are stored in  the "~/.local/share/ṕSQL/"
    folder for Linux and "C:/Users/(User)/.tdb" for Microsoft Windows (No macOS support planned so fuck you macfags!). 
    For more information, please visit us in the website: (Soon!)
    """);
  if args[1] == "shell"{
    pSQL.shell
 }
}