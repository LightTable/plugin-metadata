Plugin Metadata
===============

Plugin metadata for the Light Table plugin manager

Submit A Plugin
===============

To submit a plugin, open an issue and provide the plugin's github url and the version to release
e.g. 0.1.2.  Your plugin's repository must be tagged with the requested version. See [the
docs](http://docs.lighttable.com/#submit-a-plugin) for more.

For Committers
==============

In order for a plugin to have a new release, a plugin file must be added to this project. The file
should be `PLUGIN_NAME/VERSION/plugin.edn` or `PLUGIN_NAME/VERSION/plugin.json` where VERSION is the
new version number e.g. 0.1.2.

There is a `script/submit-plugin.rb` script to create the plugin file given a github\_url and version e.g.
`script/submit-plugin.rb https://github.com/LightTable/Emmet 0.0.2`.  This script does _not_ verify the
submission is authorized i.e. not clobbering an existing plugin - you still need to do that
manually. To use the script, make sure you are using ruby >= 2.0 and install the edn gem: `gem
install edn`.

To verify if all metadata files are at the correct path, run `script/verify-paths.rb`.

License
=======

See [LICENSE](LICENSE)
