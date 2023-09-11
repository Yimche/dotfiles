#!/bin/sh
echo -n $(hostname -i | awk '{print $2}')
