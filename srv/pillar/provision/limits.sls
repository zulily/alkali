limits:
  conf: []
  d:
    - 01-defaults:
      - '*':
        - { type: "-", item: "nproc", value: 24576 }
        - { type: "-", item: "nofile", value: 196608 }
