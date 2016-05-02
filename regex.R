# grepl(pattern = <regex>, x = <string>)

animals <- c("cat", "moose", "impala", "ant", "kiwi")

# Look for vector containing "a"
grepl("a", animals)

# Look for vector beginning with "a"
grepl("^a", animals)

# Look for vector finishing with "a"
grepl("a$", animals)


# grep find location of vectors matching pattern, can be used to isolate data
grep("a", animals)
animals[grepl("a", animals)]

# sub(pattern = <regex>, replacement = <str>, x = <str>) stop at first match per vector, gsub() for all match

# email regex, (.) any character, (*) any amount of previous character "\\" escape caracter to include (.)
emails <- c("john.doe@ivyleague.edu", "education@world.gov", "dalai.lama@peace.org", 
            "invalid.edu", "quant@bigdatacollege.edu", "cookie.monster@sesame.tv")
grep("@.*\\.edu$", emails)

# RegEx
# ^ starting with character on the right
# $ ending with character on the left
# .*: A usual suspect! It can be read as "any character that is matched zero or more times".
# \ escape character for "
# \\s: Match a space. The "s" is normally a character, escaping it (\\) makes it a metacharacter.
# [0-9]+: Match the numbers 0 to 9, at least once (+).
# ([0-9]+): The parentheses are used to make parts of the matching string available to define the replacement. The \\1 in the replacement argument of sub() gets set to the string that is captured by the regular expression [0-9]+.

awards <- c("Won 1 Oscar.",
            "Won 1 Oscar. Another 9 wins & 24 nominations.",
            "1 win and 2 nominations.",
            "2 wins & 3 nominations.",
            "Nominated for 2 Golden Globes. 1 more win & 2 nominations.",
            "4 wins & 1 nomination.")

sub(".*\\s([0-9]+)\\snomination.*$", "\\1", awards)

# remove Sepal. from colnames of iris
gsub("Sepal.", "", colnames(iris))
