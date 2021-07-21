# nchnroutes

Similar to chnroutes, but instead generates routes that are not originating from Mainland
China and generates result in BIRD static route format

Both IPv4 and IPv6 are supported.

As of Jul 2021, the size of generated table is roughly 11000-12000 entries for IPv4 (depends on the IP list used) and 14000 for
IPv6. On a Raspberry Pi 4 with BIRD, full loading and convergence over OSPF with RouterOS running
on Mikrotik hEX takes around 5 seconds.

For practical usage, check out my blog post (available in Chinese only):
https://idndx.com/use-routeros-ospf-and-raspberry-pi-to-create-split-routing-for-different-ip-ranges/

Requires Python 3, no additional dependencies.

```
$ python3 produce.py -h

usage: produce.py [-h] [--exclude [CIDR [CIDR ...]]] [--next INTERFACE OR IP]
                  [--ipv4-list [{apnic,ipip} [{apnic,ipip} ...]]]

Generate non-China routes for BIRD.

optional arguments:
  -h, --help            show this help message and exit
  --exclude [CIDR [CIDR ...]]
                        IPv4 ranges to exclude in CIDR format
  --next INTERFACE OR IP
                        next hop for where non-China IP address, this is
                        usually the tunnel interface
  --ipv4-list [{apnic,ipip} [{apnic,ipip} ...]]
                        IPv4 lists to use when subtracting China based IP,
                        multiple lists can be used at the same time (default:
                        apnic ipip)
```

To specify China IPv4 list to use, use the `--ipv4-list` as the following:

* `python3 produce.py --ipv4-list ipip` - only use list [from ipip.net](https://github.com/17mon/china_ip_list)
* `python3 produce.py --ipv4-list apnic` - only use list [from APNIC](https://ftp.apnic.net/stats/apnic/delegated-apnic-latest)
* `python3 produce.py --ipv4-list apnic ipip` - use both lists **(default)**

If you want to run this automatically, you can first edit `Makefile` and uncomment the BIRD reload code
at the end, then:

```
sudo crontab -e
```

and add `0 0 * * 0 make -C /path/to/nchnroutes` to the file.

This will re generate the table every Sunday at midnight and reload BIRD afterwards.
