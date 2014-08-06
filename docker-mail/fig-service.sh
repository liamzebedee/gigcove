#!/bin/bash
service postfix start
tail -F /var/log/mail.log && wait