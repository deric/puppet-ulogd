# puppet-ulogd

[![Puppet Forge](http://img.shields.io/puppetforge/v/deric/tuned.svg)](https://forge.puppet.com/modules/deric/ulogd) [![Tests](https://github.com/deric/puppet-ulogd/actions/workflows/test.yml/badge.svg)](https://github.com/deric/puppet-ulogd/actions/workflows/test.yml)

`ulogd` is a userspace logging daemon into which you can feed netfilter data and have it log it in a flexible way, to multiple different formats and destinations.

## Usage

```puppet
include ulogd
```

Following config:
```
ulogd::config:
  global:
    stack: log2:NFLOG,base1:BASE,ifi1:IFINDEX,ip2str1:IP2STR,print1:PRINTPKT,emu1:LOGEMU
  log2:
    group: 2
  emu1:
    file: /var/log/firewall.log
    sync: 1
```

can be used to log iptables rules with `-j NFLOG --nflog-group 2`
```
-A INPUT -m limit --limit 1/s -p icmp -j NFLOG --nflog-group 2 --nflog-prefix "ICMP:"
```

`nflog-group` number needs to match log group in `ulogd` config.
