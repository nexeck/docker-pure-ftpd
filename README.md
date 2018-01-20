```sh
docker run -d -e "USERNAME=ftp-user" -e "PASSWORD=TopSecretPassword" --name pure-ftpd -p 21:21 -p 30000-30009:30000-30009 nexeck/pure-ftpd
```
