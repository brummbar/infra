mysql-server:
  pkg.installed


mysql-service:
  service.running:
    - name: mysql

mysql_set_root_pw:
  mysql_user.present:
    - name: root
    - host: "%"
    - password: "{{ grains['mysql_password'] }}"
    - require:
      - service: mysql-service
    - connection_default_file: /etc/mysql/debian.cnf

mysql_set_root_pw_grants:
   mysql_grants.present:
    - grant: ALL
    - database: "*.*"
    - user: root
    - host: "%"
    - require:
      - mysql_user: mysql_set_root_pw
    - connection_default_file: /etc/mysql/debian.cnf



cloudformation-mysql-tmp-config:
  file.append:
    - name: /usr/local/etc/subsite/subsite.tmp.ini
    - makedirs: True
    - text:
      - "drupal.db.host=localhost"
      - "drupal.db.name=subsite"
      - "drupal.db.user=root"
      - "drupal.db.password={{ grains['mysql_password'] }}"
