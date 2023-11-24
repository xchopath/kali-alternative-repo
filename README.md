# kali-alternative-repo
Kali Linux Alternative Repositories.

----------

## Find a Kali Repository with Google Dork

```
inurl:"/kali/dists" "Index Of"
```

**Beware!** Please use a trusted repository.

----------

Sample file `/etc/apt/sources.list`:

```
deb [trusted=yes] https://xsrv.moratelindo.io/kali kali-rolling main contrib non-free non-free-firmware
deb-src [trusted=yes] https://xsrv.moratelindo.io/kali kali-rolling main contrib non-free non-free-firmware
```

## Repository Speedtest

You can also conduct download speedtest  with `speedtest-repo.sh` script.

![Donwload Speedtest](docs/speedtest-repo.png)


### Setup

```
git clone https://github.com/xchopath/kali-alternative-repo
cd kali-alternative-repo/
```

Have a great day!
