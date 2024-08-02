# Stringfluencer

Stringfluencer is a powerful and flexible Bash script for generating customized wordlists. It's designed to create lists of random strings with various encoding options, making it ideal for a wide range of applications including security testing, data generation, and more.

## Table of Contents

1. [Features](#features)
2. [Requirements](#requirements)
3. [Installation](#installation)
4. [Usage](#usage)
5. [Options](#options)
6. [Examples](#examples)
7. [Advanced Usage](#advanced-usage)
8. [Troubleshooting](#troubleshooting)
9. [Contributing](#contributing)
10. [License](#license)

## Features

- Generate wordlists with customizable string length and character set
- Specify custom URL prefixes and postfixes
- Apply various encoding methods (Base32, Base64, Hexadecimal) to different parts of the generated strings
- Colorized output for better readability
- Configurable output directory and filename
- Built-in duplicate prevention

## Requirements

- Bash shell (version 4.0 or later recommended)
- Standard Unix utilities: tr, head, grep, base32, base64, xxd

## Installation

1. Download the `stringfluencer.sh` script:

   ```
   curl -O https://raw.githubusercontent.com/yourusername/StringfluencerX/main/StringfluencerX.sh
   ```

2. Make the script executable:

   ```
   chmod +x stringfluencer.sh
   ```

3. (Optional) Move the script to a directory in your PATH for easy access:

   ```
   sudo mv stringfluencer.sh /usr/local/bin/stringfluencerx
   ```

## Usage

Basic usage:

```
./stringfluencer.sh [OPTIONS]
```

If you moved the script to your PATH, you can run it from anywhere:

```
stringfluencer [OPTIONS]
```

## Options

- `-f, --filename FILE`: Specify the output filename (default: stringlist.txt)
- `-d, --directory-path DIR`: Specify the output directory (default: current directory)
- `-s, --string-length NUM`: Specify the length of random strings (default: 8)
- `-c, --characters CHAR's`: Specify the characters used to generate the random strings (default: a-z0-9)
- `-l, --lines NUM`: Specify the number of lines to generate (default: 1000)
- `-u, --url-prefix PREFIX`: Specify the URL prefix (default: https://media.company.xyz/docs/6/3/0/0/5/p_63005)
- `-p, --postfix POSTFIX`: Specify the postfix (default: .pdf)
- `-e32p, --encode32-prefix`: Encode the prefix in base32
- `-e32s, --encode32-string`: Encode the randomly generated string in base32
- `-e32a, --encode32-all`: Encode the entire string (including postfix) in base32
- `-e64p, --encode64-prefix`: Encode the prefix in base64
- `-e64s, --encode64-string`: Encode the randomly generated string in base64
- `-e64a, --encode64-all`: Encode the entire string (including postfix) in base64
- `-0x0p, --encode0x0-prefix`: Encode the prefix in Hex
- `-0x0s, --encode0x0-string`: Encode the randomly generated string in Hex
- `-0x0a, --encode0x0-all`: Encode the entire string (including postfix) in Hex
- `-h, --help`: Display the help message

## Examples

1. Generate default wordlist:
   ```
   ./stringfluencer.sh
   ```

2. Generate 100 strings of length 10 with custom characters:
   ```
   ./stringfluencer.sh -l 100 -s 10 -c 'A-Z0-9'
   ```

3. Generate wordlist with custom filename and directory:
   ```
   ./stringfluencer.sh -f custom_list.txt -d /path/to/directory
   ```

4. Generate wordlist with custom URL prefix and postfix:
   ```
   ./stringfluencer.sh -u 'https://example.com/' -p '.html'
   ```

5. Generate wordlist with base64 encoding of the entire string:
   ```
   ./stringfluencer.sh -e64a
   ```

6. Generate wordlist with hexadecimal encoding of the random string:
   ```
   ./stringfluencer.sh -0x0s
   ```

## Advanced Usage

### Combining Encoding Options

You can combine multiple encoding options to create complex string patterns. For example:

```
./stringfluencer.sh -e64p -0x0s -e32a
```

This will encode the prefix in Base64, the random string in Hex, and then encode the entire resulting string (including postfix) in Base32.

### Using Custom Character Sets

The `-c` option allows you to specify custom character sets for generating random strings. You can use ranges or list specific characters:

```
./stringfluencer.sh -c 'A-Za-z0-9!@#$%^&*'
```

This will generate strings using uppercase and lowercase letters, numbers, and the specified special characters.

### Generating Large Wordlists

For generating very large wordlists, you may want to increase the number of lines and adjust the string length:

```
./StringfluencerX.sh -l 1000000 -s 16
```

This will generate a wordlist with 1 million entries, each 16 characters long.

## Troubleshooting

- If you encounter "command not found" errors, ensure the script is executable and in your PATH.
- For "permission denied" errors, check the permissions of the output directory and file.
- If the script seems slow, consider reducing the number of lines or the complexity of the encoding options.

## Contributing

Contributions to StringfluencerX are welcome! Please follow these steps:

1. Fork the repository
2. Create a new branch for your feature
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request

## License

Stringfluencer is released under the MIT License. See the LICENSE file for more details.
