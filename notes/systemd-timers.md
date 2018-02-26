
# User Timers

## WARNING

 If you call any bin exec, make sure the bin PATH is known.
 


```
Environment="PATH=/usr/local/bin:/usr/bin:/bin:/snap/bin:/usr/local/openresty/bin:%h/bin:%h/projects/grantmacken/bin"
```


systemctl --user daemon-reload

systemctl list-timers --user --all



- to check on run status

systemctl  --no-pager --user status stockQuote.service
systemctl start stockQuote.service


ref:
[systemd.time](https://www.freedesktop.org/software/systemd/man/systemd.time.html#)
stockQuote.service
https://niels.kobschaetzki.net/post/2015-11-11-creating-systemd-timers-instead-of-a-personal-crontab/

# # weekly Pacific/Auckland
