import 'dart:io';
import 'package:path/path.dart' as path;

pSQL psql = pSQL(); // Create an instance of the pSQL class

class pSQL {
 void shell() {
  print("pSQL Shell 0.0.1");
  print("Type 'help' for help.");
  while (true) {
    stdout.write("pSQL --> ");
    var input = stdin.readLineSync();
    if (input == null) {
      break; // Exit the shell if input is null (e.g., user presses Ctrl+C)
    }

    // Split the input into command and arguments
    final parts = input.split(' ');
    final command = parts.isNotEmpty ? parts[0] : '';
    final arguments = parts.length > 1 ? parts.sublist(1) : <String>[];

    // Process the command and arguments
    switch (command.toLowerCase()) {
      case 'help':
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
        break;
      case 'exit':
        return; // Exit the shell
      case 'select':
      case 'sel':
        psql.select();
        break;
      case 'insert':
      case 'ins':
        psql.insert();
        break;
      case 'update':
      case 'up':
        psql.update();
        break;
      case 'delete':
      case 'del':
        psql.delTable(arguments.isNotEmpty ? arguments[0] : '');
        break;
      case 'create':
      case 'cre':
        psql.createTable(arguments.isNotEmpty ? arguments[0] : '');
        break;
      case 'alter':
      case 'alt':
        psql.alter();
        break;
      default:
        print("Invalid command. Type 'help' for help.");
        break;
    }
  }
}

  void select() {
    // TO-DO
  }

  void insert() {
    // TO-DO
  }

  void update() {
    // TO-DO
  }

  void delete() {
    // TO-DO
  }

  void alter() {
    // TO-DO
  }

  Future<void> delTable(String tableName) async {
    if (tableName.isEmpty || tableName.contains(RegExp(r'[^\w\d]'))) {
      print(
          'pSQL: The name given is invalid or null, please enter a valid name.');
      return;
    }

    final user =
        Platform.environment['USERNAME'] ?? Platform.environment['USER'];
    final filePath = Platform.isWindows
        ? path.join('C:/Users', user, '.psql')
        : path.join('~', '.local/share/pSQL');

    // Read the database file into memory
    final file = File(filePath);
    if (!file.existsSync()) {
      print(
          'pSQL: Main database file was not found, please use the create command to create a new database and primary table.');
      return;
    }

    // Read the contents of the file
    String fileContent = file.readAsStringSync();

    // Identify the table section within the content
    final tablePattern = RegExp(
        r'<Master Schema Section>(.*?)<Table Data Section>[\s\S]*?Table:\s+$tableName[\s\S]*?--\s+End\s+of\s+Table',
        multiLine: true);
    final tableMatch = tablePattern.firstMatch(fileContent);

    if (tableMatch == null) {
      print('pSQL: Table $tableName not found in the database.');
      return;
    }

    // Remove the identified table section from the content
    fileContent = fileContent.replaceFirst(tableMatch.group(0) as Pattern, '');

    // Write the modified content back to the file
    file.writeAsStringSync(fileContent);

    print('pSQL: Table $tableName deleted successfully.');
  }

  Future<void> createTable(tableName) async {
    // Validate input
    if (tableName.isEmpty || tableName.contains(RegExp(r'[^\w\d]'))) {
      print('pSQL: Please enter a valid name');
      return;
    }

    // Define platform-independent paths
    final user =
        Platform.environment['USERNAME'] ?? Platform.environment['USER'];
    final regularPath = Platform.isWindows
        ? path.join('C:/Users', user, '.psql')
        : path.join('~', '.local/share/pSQL');

    final filePath = path.join(regularPath, 'main.psql');
    print("pSQL: Creating Table $tableName...");

    // Create or append to the file
    final file = File(filePath);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }

    // Prepare table content
    final tableContent = """
    <Master Schema Section>
    ---------------------------------------------
    | type        | name      
    |-------------|-----------|
    | table       | $tableName |
    ---------------------------------------------

    <Table Data Section>
    --------------------------------
    Table: $tableName
    ---------------------------------------------
    | id | name       | value           |
    |----|------------|-----------------|
    ---------------------------------------------
    """;

    // Append content to the file
    file.writeAsStringSync(tableContent, mode: FileMode.append);

    print('Table $tableName created successfully!');
    print(tableContent);
  }
}
