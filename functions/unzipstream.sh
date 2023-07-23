#!/bin/bash

alias unzipstream='_unzipstream'

# From an idea online:

# import zipfile
# import sys
# import StringIO
# data = StringIO.StringIO(sys.stdin.read())
# z = zipfile.ZipFile(data)
# dest = sys.argv[1] if len(sys.argv) == 2 else '.'
# z.extractall(dest)

_unzipstream() {
    python -c "import zipfile,sys,StringIO;zipfile.ZipFile(StringIO.StringIO(sys.stdin.read())).extractall(sys.argv[1] if len(sys.argv) == 2 else '.')"
}
