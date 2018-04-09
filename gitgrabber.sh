#!/bin/sh

# Pardon the mess - My experience with bash is well... not great
# Tested on Mac OSX 10.12 w/ Homebrew (wget)

if [ $# -eq 0 ]; then
    echo "Usage ./gitgrabber.sh <url>"
    echo "eg: ./gitgrabber.sh https://domain.com/.git/"
    exit 1
fi

url=$1
domain=$(echo $url | cut -d '/' -f 3)

if [ -d "$domain" ]; then
    echo "[ERROR]" $domain "directory already exists. Aborting..."
    exit 1
fi

# Figure out what kind of URL you threw in (via magic case statement)
# Append slashes, .git, etc as needed
case $url in
    *.git) url="${url}/";;
    *.git/) url="${url}";;
    */) url="${url}.git/";;
    *) url="${url}/.git/";;
esac

# Make sure we can actually find a .git directory
# Rudimentary testing, but any nonzero from wget == exit
echo "[INFO] Testing $url for .git access"
if wget -qO- $url &> /dev/null; then
    echo "[SUCCESS] .git directory found, looks good"
else
    echo "[ERROR] .git directory not found"
    exit 1
fi

echo "[INFO] Beginning download from" $url
echo "This may take a bit..."

mkdir -p $domain
cd $domain
wget -q -r -nH --no-parent --show-progress --reject "index.html*" "$url"

echo "[SUCCESS] Git directory downloaded"
echo "[INFO] Checking out master"
git checkout master .
echo "[SUCCESS] Branch: master checked out"
echo "Loot located at: $(pwd)"

