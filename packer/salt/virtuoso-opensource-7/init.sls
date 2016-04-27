virtuoso-repository:
  pkgrepo.managed:
    - humanname: virtuoso-repository 
    - name: deb http://packages.comsode.eu/debian/ jessie main 
    - file: /etc/apt/sources.list.d/virtuoso.list
    - key_url: https://packages.comsode.eu/key/odn.gpg.key

virtuoso-server:
  pkg.installed:
    - refresh: True
  service.running:
    - require:
      - file: virtuoso-default-file-installed

virtuoso-default-file-installed:
  file.managed:
    - name: /etc/default/virtuoso-opensource-7
    - source: salt://virtuoso-opensource-7/default
    - require:
      - pkg: virtuoso-server

unixodbc:
  pkg.installed

/usr/local/etc/subsite/subsite.tmp.ini:
  file.append:
    - makedirs: True
    - text:
      - "sparql.host=localhost"
      - "sparql.port=8890"
      - "sparql.user=dba"
      - "sparql.dsn=VOS"
      - "sparql.password={{ grains['virtuoso_password'] }}"




