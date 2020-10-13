# Smart Log Analyzer (**SLA**)

## What is SLA?
SLA is a little Log analyzer. It counts the number of page views, total and unique, of in a Web Log.

"Unique" means that it does not count multiple visits from the same IP. 

This is an example of a Web log:

```
/help_page/1 126.318.035.038
/contact 184.123.665.067
/home 184.123.665.067
/about/2 444.701.448.104
/help_page/1 929.398.951.889
```

## How can I run it?
From the shell, run `smart_log_analyzer`.
The only arg to provide is the filename to analyze.
For example: 

`> ./smart_log_analyzer.rb lib/log_analyzer.rb`

## How does it work?
SLA is composed by three classes and a script.

The classes:
- LogParser: this class reads the file row by row and parse it using a *REGEX*.
  It is fault-tolerant: if a row does not match the *REGEX* to extract the page name and IP, it skips the line.
- LogAnalyzer: this class counts the number of visits, total and unique.
- StatsPrinter: this class prints on screen the statistics about the visits.

The executable ruby script `smart_log_analyzer.rb`
- provides information about the usage
- gets the filename provided to the script
- and performs the analysis using the classes (see above)

## Ideas for possible improvements
- More analytics: showing the activities based on the IPs. What are the IPs more active, what's the avg number of page views, what are outliers, ...
- Add the timestamp on the log. This would expand the possibilities for the analysis and even spot simple DOS attacks.
- Make it nicer: Generate bars graph of the visits and unique views.
