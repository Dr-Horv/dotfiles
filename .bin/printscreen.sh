#!/bin/bash
img=$(mktemp '/tmp/img-XXXXXX.png')
import $img && cat $img | xclip -selection clipboard -t image/png 
