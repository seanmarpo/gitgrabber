# Gitgrabber

Simple bash script to automate the process of downloading and checking out a publicly available .git directory from a website.

Simple put, this runs a recursively wget against the website's .git directory, then it performs a `git checkout master` on the resulting files.

Assuming everything goes as planned, you will receieve a directory named after the domain of the site which contains the source code from the downloaded .git directory.

## Installation

`wget` is required. Mac users, you can grab this from homebrew.

## Usage

`./gitgrabber.sh <url>`

The URL bit is very, very lenient. You can include the .git directory or not. I try my best to parse your input and make some kind of sense of it.


Some example runs:

`./gitgrabber.sh https://domain.com`

`./gitgrabber.sh https://domain.com/.git`


### Changelog
1.0 - Initial commit
