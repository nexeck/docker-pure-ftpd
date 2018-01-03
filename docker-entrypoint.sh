#!/bin/sh

if [ ! -d "${FTP_DIR}" ]; then
	echo "Create root dir : ${FTP_DIR}"
	mkdir -p ${FTP_DIR}
  mkdir -p ${FTP_DIR}/data
fi

# Create user
echo "Create new user : ${USERNAME}"
expect -c "
  spawn pure-pw useradd ${USERNAME} -u ftpv -d ${FTP_DIR}/data
  expect {
    Password {
      send \"${PASSWORD}\r\"
      exp_continue
    }
    again {
      send \"${PASSWORD}\r\"
      exp_continue
    }
  }
"

# Update puredb
echo "Create puredb"
pure-pw mkdb ${FTP_DIR}/pureftpd.pdb

/usr/sbin/syslog-stdout &

# Option explanations :
#	-c <int> : Allow maximum of clients to be connected
#	-C <int> : Limit the number of simultaneous connections coming from the same IP address.
#	-E : Only allow authenticated users. Anonymous logins are prohibited.
#	-j : If the home directory of a user doesn't exist, automatically create it.
#	-l <puredb:path> : PureDB file
echo "Starting pure-ftpd"
exec /usr/sbin/pure-ftpd -c 50 -C 5 -l puredb:${FTP_DIR}/pureftpd.pdb -j -E -p 30000:30009 -d
