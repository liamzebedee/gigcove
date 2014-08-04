#!/bin/bash
service postfix start

# terrible hack to wait on stuff TODO
tail -F /var/log/faillog && wait