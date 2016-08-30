# Dupfinder

A short script for finding duplicates.

## The problem

You have a collection of files (such as photos) which contain duplicates. You want to save space but retain all your files.

## The solution

This script efficiently identifies duplicate files by

1) Checking the size of the files.

2) Computing the SHA-256 checksum of the files.

The efficient part is that we only compute checksums for files identified as potential duplicates by the size check.

## How it works

First, generate a list of candidate files:

    find ~/Pictures -type f > /tmp/files.txt
    
Then, run the script. The script is non-destructive and its output is a shell script.

    ruby dupes.rb > make_space.sh
    
Next, inspect the resulting script and make sure it's going to do what you want. If it looks good, run it:

    sh make_space.sh
    
    