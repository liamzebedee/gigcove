docker-mail
===========

docker-mail is a simple Docker container for a Postfix mail server. 

## Install/Usage
I prefer to use Fig, otherwise you can simply run the Dockerfile. Here's an example Fig service:
```
mail:
  build: "./docker-mail"
  command: "service postfix start"
  ports:
    - "25"
```

The main config file for Postfix is here `main.cf`. If you are using a domain (which is very likely), you should Ctrl+F 'gigcove.com' in `main.cf` and `mailname` and replace it with your domain name.

## Testing
When you run `nc localhost 25` you should get:
`> 220 aca80064.ipt.aol.com ESMTP Postfix`

Try sending a test email `date | mail -s test email@domain.com`