# Word Counter

## Possible inputs

1. URL (starts with 'http')
2. File name (anywhere in the system)
3. String

## How to use

### Parsing text

Execute the word_counte.rb file and enter any of the input types by either entering them as console line arguments,
or when prompted if no command line arguments were entered.
The database will be created upon first use in the db directory.

### Getting a word count

Execute the word_instances.rb file and enter a word to search for in the database by either entering it as a console
line argument, or when prompted if no command line argument was entered.

### Specs

Run with `rspec name_of_program/spec

### An existing file not found?

the mlocate database used by the locate command is outdated, run `sudo updatedb` to update it then try again.
