disy:
  targeted_defaults:
    mariadb:
      /backups/db:
        operation: directory
        parameters:
          - user: root
          - group: root
          - mode: 755
          - makedirs: True
  defaults:
    default:
      /backups:
        operation: directory
        parameters:
          - user: root
          - group: root
          - mode: 755
      /bin/env:
        operation: symlink
        parameters:
          - target: /usr/bin/env
          - force: True
          - user: root
          - group: root
