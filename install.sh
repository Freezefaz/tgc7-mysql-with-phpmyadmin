# Prevent phpmyadmin from being added to github
touch .gitignore
echo "public/phpmyadmin" >> .gitignore

mkdir public
cd public
git clone https://github.com/phpmyadmin/phpmyadmin.git
cd phpmyadmin
composer update --no-dev
yarn install
cp config.sample.inc.php config.inc.php
# Remember to set AllowNoPassword (line 32 in config.inc.php) to false