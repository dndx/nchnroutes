produce:
	git pull
	curl -o delegated-apnic-latest https://ftp.apnic.net/stats/apnic/delegated-apnic-latest
	python3 produce.py
	# sudo mv routes4.conf /etc/bird/routes4.conf
	# sudo mv routes6.conf /etc/bird/routes6.conf
	# sudo birdc configure
	# sudo birdc6 configure
