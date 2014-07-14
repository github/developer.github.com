adsf
====

adsf (A Dead Simple Fileserver) is a tiny static file server that you can launch instantly in any directory, like this:

	▸ ls -l
	total 0
	drwxr-xr-x  2 ddfreyne  staff  68 May 29 10:04 about
	drwxr-xr-x  2 ddfreyne  staff  68 May 29 10:04 contact
	-rw-r--r--  1 ddfreyne  staff   0 May 29 10:04 index.html
	drwxr-xr-x  2 ddfreyne  staff  68 May 29 10:04 projects

	▸ adsf
	2009-05-29 10:04:44] INFO  WEBrick 1.3.1
	[2009-05-29 10:04:44] INFO  ruby 1.8.7 (2008-08-11) [i686-darwin9.6.1]
	[2009-05-29 10:04:44] INFO  WEBrick::HTTPServer#start: pid=2757 port=3000

… and now you can go to http://localhost:3000/ and start browsing.

You can specify a custom web root with `-r` or `--root`; the server will be started in that directory (e.g. `adsf -r public/`). If you want to specificy custom index filenames (other than the default `index.html`), you can use the `-i` or `--index-filename` option, which is a comma-separated list of filenames (e.g. `adsf -i index.html,index.xml`).

adsf has one dependency, namely on Rack. It is licenced under the MIT license. Patches are always welcome; check my contact e-mail address at the bottom of this document.

Using adsf programmatically
---------------------------

You can use adsf programmatically in your Rack applications. [nanoc](http://nanoc.stoneship.org/) uses adsf for its “view” command, for example. adsf consists of one middleware class that finds index filenames, and rewrites these requests so that Rack::File can be used to serve these files.

Here’s an example middleware/application stack that runs a web server with the "public/" directory as its web root:

	use Adsf::Rack::IndexFileFinder, :root => "public/"
	run Rack::File.new("public/")

The `:root` option is required; it should contain the path to the web root.

You can also specify an `:index_filenames` option, containing the names of the index filenames that will be served when a directory containing an index file is requested. Usually, this will simply be `[ 'index.html' ]`, but under different circumstances (when using IIS, for exmaple), the array may have to be modified to include index filenames such as `default.html` or `index.xml`. Here’s an example middleware/application stack that uses custom index filenames:

	use Adsf::Rack::IndexFileFinder,
	  :root => "public/",
	  :index_filenames => %w( index.html index.xhtml index.xml )
	run Rack::File.new("public/")

Authors
-------

* Denis Defreyne
* Mark Meves

Contact
-------

You can reach me at <denis.defreyne@stoneship.org>.
