Experimental docker box for Shopware

# Setup

- Install docker:
  * https://docs.docker.com/engine/installation/
  * https://docs.docker.com/engine/installation/linux/linux-postinstall/
- Install docker-compose:
  * https://docs.docker.com/compose/install/
  
- Prepare development environment structure:
  * composer/cache, <not required for complete projects, but mapped>
  * htdocs <doc root of the showpare project>
- Check main _docker-compose.yml_ for more detail regarding mappings and base setup.

# Usage

- Before starting, make sure your "htdocs" contains all the required structure to start the Shopware application like:
   * var/cache
   * var/log
   * config.php
- Enter _docker/_ folder
- Run _docker-compose up --build_
- Adjust Shopware _config.php_ to use the mysql container service:
```
    'db' => array(
        'username' => 'shopware',
        'password' => 'shopware',
        'dbname' => 'shopware5',
        'host' => 'sw-mysql',
        'port' => '3306'
    ),
```
  * *NOTE:* An empty DB will be created together with the mysql server container on
    its first-run.
  * The default settings are visible in the above _config.php_ snippet.
- Adjust Shopware "mailer" to use "mailhog" (Basic settings->Shop settings->Mailer):
  * Sending method: smtp
  * Mail host: sw-mailhog
  * Default port: 1025

- The terminal window will be binded to the container's output.
- To stop the docker development environment use _CTRL+C_ on the terminal.
- To start the environment afterwards just run: _docker-compose up_ inside the _docker_ folder.

# PHPStorm settings

- To access the mysql server from PHPStorm use the following settings:
  ```
  Host: localhost
  Port: 3307
  Database: shopware5
  User: shopware
  Password: shopware
  ```

- Deployment settings | connection
  * Type: "Local or mounted folder"
  * Upload/download project files: <project_path>/htdocs

- Xdebug should work out-of-the-box
  * To tweak configuration go to: docker/phpdockerio-apache/xdebug-ini-overrides.ini
  * You need to rebuild the containers after ini changes (_docker-compose up --build_)
  * No data is lost on this process if mappings are correctly set.

# Known issues

- Tested with Showpare > 5.2.0.
- **If your user/group ID is not 1001, adjust the scripts, its not dynamic at the moment.**
- Uses the following ports on localhost _8085_ for webserver and _3307_ for mysql.
  Adjust these if you have local servers running already on those.

