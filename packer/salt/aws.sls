aws-stack:
  pkg.installed:
    - pkgs:
      - python-pip
      - ruby2.0
      - awscli

codedeploy-install-script-downloaded:
  cmd.run:
    - name: aws s3 cp s3://aws-codedeploy-eu-west-1/latest/install /tmp/codedeploy-install --region eu-west-1
    - creates: /tmp/codedeploy-install
    - require:
      - pkg: aws-stack

codedeploy-install-script-executable:
  file.managed:
    - name: /tmp/codedeploy-install
    - mode: 755
    - require:
      - cmd: codedeploy-install-script-downloaded

codedeploy-installed:
  cmd.wait:
    - name: /tmp/codedeploy-install auto
    - watch:
      - file: codedeploy-install-script-executable


