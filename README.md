Plugin Metadata
===============

Plugin metadata for the Light Table plugin manager

Submit A Plugin
===============

To submit a plugin, a plugin file must be added to this project. The file should be
`PLUGIN_NAME/VERSION/plugin.edn` or `PLUGIN_NAME/VERSION/plugin.json` where VERSION is the
new version number e.g. 0.1.2. You can open an issue with the github url of your plugin or a pull
request with the given file. Don't forget that your plugin's repository must be tagged with `VERSION`
in order to be installed.

For Committers
==============

There is a `submit-plugin.rb` script to create the plugin file given a github\_url and version
e.g. `./submit-plugin.rb https://github.com/LightTable/Emmet 0.0.2`.
This script does _not_ verify the submission is authorized i.e. not clobbering an existing plugin -
you still need to do that manually. To use the script, make sure you are using ruby >= 2.0 and install the edn gem: `gem install edn`.

License
=======

See [LICENSE](LICENSE)
