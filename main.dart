import 'psql.dart' show pSQL;

void main(List<String> args) {
  if (args.isNotEmpty && args[0] != "shell") {
    print("""
    pSQL 0.0.1
    usage: pSQL <command> [args]
    
    pSQL or pickaxeSQL is a simple that uses a modified version of SQL
   (most specifically, MySQL) intended to be more simple and intuitive to store data.
    It technically is similar to other SQL DBMSs like SQLite,
    MySQL, MariaDB, PostgreSQL and MsSQL but it is more simple and intuitive.

    Commands:
     shell: enters the pSQL shell.
     help: Shows this message.
     about: Shows the about pSQL page, containing credits and contributors.

    By default, all the databases in pSQL are stored in  the "~/.local/share/pSQL/"
    folder for Linux and "C:/Users/(User)/.psql" for Microsoft Windows (No macOS support planned so use Windows or Linux). 
    For more information, please visit us on the website: (Soon!)
    """);
  }

  if (args.isNotEmpty && args[0] == "shell") {
    pSQL().shell();
  }
}
