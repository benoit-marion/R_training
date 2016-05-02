## get date and time function - default : (x ,format  = "%Y-%m-%d") or "%Y/%m/%d"
## calculate on days for date and sec for time
# based on epoch if unclassed
# %Y: 4-digit year (1982)
# %y: 2-digit year (82)
# %m: 2-digit month (01)
# %d: 2-digit day of the month (13)
# %A: weekday (Wednesday)
# %a: abbreviated weekday (Wed)
# %B: month (January)
# %b: abbreviated month (Jan)
## Similar but for time expression ------------------- ?strptime
# %H: hours as a decimal number (00-23)
# %M: minutes as a decimal number
# %S: seconds as a decimal number
# %T: shorthand notation for the typical format %H:%M:%S
## Store value using as.Date() and as.POSIXct()


Sys.Date()
# [1] "2016-01-23"
Sys.time()
# [1] "2016-01-23 13:14:01 CET"

format(Sys.Date(), format = "Today is a %A!")
#[1] "Today is a Saturday!"

format(as.Date("1977-06-30"), format = "My birthday was a %A!")
# [1] "My birthday was a Thursday!"

## Calculate time difference of a serie, in days
diff(c(Sys.Date(), Sys.Date() + 3, Sys.Date() + 12 ))
# Time differences in days
# [1] 3 9
