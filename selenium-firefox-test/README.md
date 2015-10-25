In order to run a standalone UI test:

```
docker run --rm -it -p 5901:5900 cisetup_seleniumfirefoxtest bash

# or /opt/bin/entry_point.sh
/test.sh

# vnc viewer for Windows available at https://www.realvnc.com/download/viewer/
# pass: secret
vncviewer 192.168.99.104:5901
```

