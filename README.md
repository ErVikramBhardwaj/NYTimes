New York Times
A simple app to hit the NY Times Most Popular Articles API and show a list of articles,
That shows details when items on the list are tapped (a typical master/detail app).
Getting Started
Prerequisites
•	Lastest version of Xcode must be installed.
•	See https://developer.nytimes.com/ for details of APIs exposed by The New York Times.
Documentation
Parameters:
“all-sections” for the section path component in the URL above and 7 for period (available period values are 1, 7 and 30, which represents how far back, in days, the API returns results for).
Sample-key could be found via registering a user on API console of “The New York Times”.
Example:
http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?apikey=sample-key
On parsing the response from api, user will be able to get the list of all most viewed articles and user can select any article to view details.
Build Dependencies
NA
 Versioning
1.0
