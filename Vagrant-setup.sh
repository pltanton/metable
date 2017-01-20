#!/bin/sh -e

# Update packages
pacman -Syu --noconfirm
echo "================ System updated ================"
# Install postgres
pacman -S postgresql --noconfirm
echo "============= Postgress installed =============="

# Initialize postgresql database
su - postgres -c "initdb --locale $LANG -E UTF8 -D '/var/lib/postgres/data'"
echo "============= Postgress installed =============="
# Configure postgres to connect remotely
sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" /var/lib/postgres/data/postgresql.conf
echo "host   all   all   all   md5" >> /var/lib/postgres/data/pg_hba.conf
echo "client_encoding = utf8" >> /var/lib/postgres/data/postgresql.conf
echo "============= Postgress configured =============="
# Start and enable database
systemctl enable postgresql
systemctl start postgresql
echo "=========== Postgress service enabled ==========="

# Create vagrant user in postgresql and database
cat << EOF | su - postgres -c psql
-- Credate database user
CREATE USER vagrant WITH PASSWORD 'vagrant';
-- Create test and development databases for metable
CREATE DATABASE metable_dev WITH OWNER=vagrant
                                 LC_COLLATE='en_US.utf8'
                                 LC_CTYPE='en_US.utf8'
                                 ENCODING='UTF8'
                                 TEMPLATE=template0;
CREATE DATABASE metable_test WITH OWNER=vagrant
                                  LC_COLLATE='en_US.utf8'
                                  LC_CTYPE='en_US.utf8'
                                  ENCODING='UTF8'
                                  TEMPLATE=template0;
EOF
echo "========= Database user and db created ==========="

