# nchnroutes

Similar to chnroutes, but instead generates routes that are not originating from Mainland
China and generates result in BIRD static route format

Both IPv4 and IPv6 are supported.

As of Dec 2020, the size of generated table is roughly 11000 entries for IPv4 and 14000 for
IPv6. On a Raspberry Pi 4 with BIRD, full loading and convergence over OSPF with RouterOS running
on Mikrotik hEX takes around 5 seconds.

For practical usage, check out my blog post (available in Chinese only):
https://idndx.com/use-routeros-ospf-and-raspberry-pi-to-create-split-routing-for-different-ip-ranges/

Requires Python 3, no additional dependencies.

```
usage: produce.py [-h] [--exclude [CIDR [CIDR ...]]] [--next INTERFACE OR IP]

Generate non-China routes for BIRD.

optional arguments:
  -h, --help            show this help message and exit
  --exclude [CIDR [CIDR ...]]
                        IPv4 ranges to exclude in CIDR format
  --next INTERFACE OR IP
                        next hop for where non-China IP address, this is
                        usually the tunnel interface
```

If you want to run this automatically, you can first edit `Makefile` and uncomment the BIRD reload code
at the end, then:

```
sudo crontab -e
```

and add `0 0 * * 0 make -C /path/to/nchnroutes` to the file.

This will re generate the table every Sunday at midnight and reload BIRD afterwards.
