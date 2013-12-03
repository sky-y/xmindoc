# Xmindoc

Exports XMind Mindmap to any documents with Pandoc.

Copyright (c) 2013 Yuki Fujiwara \<sky.y.0079@gmail.com\>


* XMind (English): <http://www.xmind.net/>
* XMind (Japanese): <http://jp.xmind.net/>


## Requirement
* Ruby 1.9.3 or above
* Pandoc 1.9.4.2 or above
	* See installation: <http://johnmacfarlane.net/pandoc/installing.html>
	* You can choose either:
		* cabal install (with Haskell Platform, I prefer personally) or
		* Pandoc Package Installer (without Haskell Platform)


## Install
### libiconv
#### Mac (Homebrew)

	$ brew tap homebrew/dupes
	$ brew install libiconv
	$ brew link --force libiconv 

#### Linux

	$ wget http://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.14.tar.gz
	$ tar zxvf libiconv-1.14.tar.gz
	$ cd libiconv-1.14
	$ ./configure
	$ make
	$ su -
	# make install

### Xmindoc
	$ gem install xmindoc

## Usage

	Usage: ruby XMorgDown.rb [options] input.xmind
    -o, --output FILE                Output Filename
    -t, --to=FORMAT                  Output formats: markdown, org, html, latex, rst,  ... 
    -w, --write=FORMAT               Output formats: markdown, org, html, latex, rst,  ... 
        --pandoc-options=OPTIONS     Pandoc options (Use double quotes like "--atx-headers")
    -h, --help                       Display this screen

* For detail of formats and Pandoc options: See [Pandoc User's Guide](http://johnmacfarlane.net/pandoc/README.html)


## Examples
Sample files are in `samples/` directory.

### Example 1 (Japanese: 寿限無)
	xmindoc -t markdown -o test1.md samples/test1.xmind --pandoc-options="--atx-headers"

* It makes a file "test1.md" as in Markdown (ATX-headered) style.

#### Example files

* Original XMind file: test1.xmind (test1.png as image)
* Sample Result (Org File): test1.org
* Sample Result (Markdown File): test1.md
* "--atx-headers": use `#` and `##` as `<h1>` and `<h2>` header output 


### Example 2 (English: Lorem Ipsum)
	xmindoc -t org -o test2.org samples/test2.xmind

* It makes a file "test2.org" in Org style.

#### Example files

* Original XMind file: test2.xmind (test2.png as image)
* Result (Org File): test2.org
* Result (Markdown File): test2.md

