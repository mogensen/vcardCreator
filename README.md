# vCardCreator

Contains:

### excelToCSV.applescript

An AppleScript to convert an excel sheet to a CSV file.
The resulting CSV file is with:

* Strings escaped with "
* Values separated with ,
* Linux line feeds

### vcardCreator.pl

A Perl script to generate a vCard file from a CSV file.

## Known issues

* You have to define in the `excelToCSV.applescript` file which columns are integers, to get integers instead off scientific number format (calling the phone number "6,1707E+9" really sucks :D )
* `vCardCreator.pl` only supports danish CSV files at the moment
* Should use a libery - like `Text::vCard` to generate the vCards
