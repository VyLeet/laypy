#!/bin/zsh

if [ $# -eq 0 ]; then
    echo "❌ No arguments provided"
    exit 1
fi

if ! command -v python3 &> /dev/null; then
    echo "❌ python3 could not be found"
    exit 1
fi

if ! command -v pip3 &> /dev/null; then
    echo "❌ pip3 could not be found"
    exit 1
fi

if [ -d "python" ]; then
    echo "❌ Directory called python already exists"
    exit 1
fi

if mkdir python; then
    echo "✅ Directory created successfully"
else
    echo "❌ Failed to create directory"
    exit 1
fi

cd python

if pip3 install "$@" -t .; then
    echo "✅ Successfully installed $@"
else
    cd ..
    rm -rf python
    echo "❌ Failed to install $@"
    exit 1
fi

cd ..

if zip -r dependency_layer.zip python; then
    echo "✅ Successfully zipped python directory"
else
    echo "❌ Failed to zip python directory"
    rm -rf python
    exit 1
fi

rm -rf python
exit 0
