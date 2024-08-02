#!/bin/bash

# Default values
filename="stringlist.txt"
directory_path="."
string_length=8
string_characters="a-z0-9"
lines=1000
protocol="https://"
prefix="media.company.xyz/docs/6/3/0/0/5/p_63005"
url_prefix="$protocol$prefix"
postfix=".pdf"
encode32_prefix=false
encode32_string=false
encode32_all=false
encode64_prefix=false
encode64_string=false
encode64_all=false
encode0x0_prefix=false
encode0x0_string=false
encode0x0_all=false

# ANSI color codes
TURQUOISE='\033[0;36m'
REDWHITE='\033[1;37;41m'
GREENWHITE='\033[1;37;42m'
NC='\033[0m' # No Color

# Function to display help
display_help() {
    echo "Usage: $0 [OPTIONS]"
    echo "Generate a wordlist of random strings with various options."
    echo
    echo "Options:"
    echo "  -f, --filename FILE       Specify the output filename (default: stringlist.txt)"
    echo "  -d, --directory-path DIR  Specify the output directory (default: current directory)"
    echo "  -s, --string-length NUM   Specify the length of random strings (default: 8)"
    echo "  -c, --characters CHAR's   Specify the characters[(a-z)/(a-Z)/(0-9)] used to generate the random strings (default: a-z0-9)"
    echo "  -l, --lines NUM           Specify the number of Stringlines to generate (default: 1000)"
    echo "  -u, --url-prefix PREFIX   Specify the URL prefix (default: https://media.company.xyz/docs/6/3/0/0/5/p_63005)"
    echo "  -p, --postfix POSTFIX     Specify the postfix (default: .pdf)"
    echo "  -e32p, --encode32-prefix  Encode the prefix in base32"
    echo "  -e32s, --encode32-string  Encode the randomly generated string in base32"
    echo "  -e32a, --encode32-all     Encode the entire string (including postfix) in base32"
    echo "  -e64p, --encode64-prefix  Encode the prefix in base64"
    echo "  -e64s, --encode64-string  Encode the randomly generated string in base64"
    echo "  -e64a, --encode64-all     Encode the entire string (including postfix) in base64"
    echo "  -0x0p, --encode0x0-prefix Encode the prefix in Hex"
    echo "  -0x0s, --encode0x0-string Encode the randomly generated string in Hex"
    echo "  -0x0a, --encode0x0-all    Encode the entire string (including postfix) in Hex"
    echo "  -h, --help                Display this help message"
    echo
    echo "Examples:"
    echo "  1. Generate default wordlist:"
    echo "     $0"
    echo
    echo "  2. Generate 100 strings of length 10 with custom characters:"
    echo "     $0 -l 100 -s 10 -c 'A-Z0-9'"
    echo
    echo "  3. Generate wordlist with custom filename and directory:"
    echo "     $0 -f custom_list.txt -d /path/to/directory"
    echo
    echo "  4. Generate wordlist with custom URL prefix and postfix:"
    echo "     $0 -u 'https://example.com/' -p '.html'"
    echo
    echo "  5. Generate wordlist with base64 encoding of the entire string:"
    echo "     $0 -e64a"
    echo
    echo "  6. Generate wordlist with hexadecimal encoding of the random string:"
    echo "     $0 -0x0s"
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -f|--filename) filename="$2"; shift 2 ;;
        -d|--directory-path) directory_path="$2"; shift 2 ;;
        -s|--string-length) string_length="$2"; shift 2 ;;
        -c|--characters) string_characters="$2"; shift 2 ;;
        -l|--lines) lines="$2"; shift 2 ;;
        -u|--url-prefix) url_prefix="$2"; shift 2 ;;
        -p|--postfix) postfix="$2"; shift 2 ;;
        -e32p|--encode32-prefix) encode32_prefix=true; shift ;;
        -e32s|--encode32-string) encode32_string=true; shift ;;
        -e32a|--encode32-all) encode32_all=true; shift ;;
        -e64p|--encode64-prefix) encode64_prefix=true; shift ;;
        -e64s|--encode64-string) encode64_string=true; shift ;;
        -e64a|--encode64-all) encode64_all=true; shift ;;
        -0x0p|--encode0x0-prefix) encode0x0_prefix=true; shift ;;
        -0x0s|--encode0x0-string) encode0x0_string=true; shift ;;
        -0x0a|--encode0x0-all) encode0x0_all=true; shift ;;
        -h|--help) display_help; exit 0 ;;
        *) echo "Unknown option: $1"; display_help; exit 1 ;;
    esac
done

# Ensure directory path exists
mkdir -p "$directory_path"

# Full path to the output file
output_file="$directory_path/$filename"

# Function to generate a random string
generate_random_string() {
    LC_ALL=C tr -dc "$string_characters" < /dev/urandom | head -c "$string_length"
}

# Function to encode string in base32
encode_base32() {
    echo -n "$1" | base32
}

# Function to encode string in base64
encode_base64() {
    echo -n "$1" | base64
}

# Function to encode string in hexadecimal
encode_hex() {
    echo -n "$1" | xxd -p | tr -d '\n'
}

# Signal handler for SIGINT (Ctrl+C)
cleanup() {
    echo -e "\n${REDWHITE}Aborted by user. Wordlist generation stopped.${NC}"
    exit 1
}

# Register signal handler
trap cleanup SIGINT

# Remove existing output file if it exists
[ -f "$output_file" ] && rm "$output_file"

# Main loop to create the wordlist
count=0
while [ $count -lt $lines ]; do
    random_string=$(generate_random_string)
    
    if ! LC_ALL=C grep -qF "$random_string" "$output_file"; then
        full_string="$url_prefix$random_string$postfix"
        
        if $encode32_prefix; then
            encoded_prefix=$(encode_base32 "$url_prefix")
            full_string="$encoded_prefix$random_string$postfix"
        fi
        
        if $encode32_string; then
            encoded_string=$(encode_base32 "$random_string")
            full_string="$url_prefix$encoded_string$postfix"
        fi
        
        if $encode32_all; then
            full_string=$(encode_base32 "$full_string")
        fi
        
        if $encode64_prefix; then
            encoded_prefix=$(encode_base64 "$url_prefix")
            full_string="$encoded_prefix$random_string$postfix"
        fi
        
        if $encode64_string; then
            encoded_string=$(encode_base64 "$random_string")
            full_string="$url_prefix$encoded_string$postfix"
        fi
        
        if $encode64_all; then
            full_string=$(encode_base64 "$full_string")
        fi
        
        if $encode0x0_prefix; then
            encoded_prefix=$(encode_hex "$url_prefix")
            full_string="$encoded_prefix$random_string$postfix"
        fi
        
        if $encode0x0_string; then
            encoded_string=$(encode_hex "$random_string")
            full_string="$url_prefix$encoded_string$postfix"
        fi
        
        if $encode0x0_all; then
            full_string=$(encode_hex "$full_string")
        fi
        
        echo "$full_string" >> "$output_file"
        ((count++))
        echo -e "${TURQUOISE}Added ${REDWHITE}$count ${TURQUOISE}entries to wordlist:${NC} ${GREENWHITE}$full_string${NC}"
    fi
    
    sleep 0.005
done

echo -e "${GREENWHITE}Wordlist generation completed. Output saved to $output_file${NC}"
