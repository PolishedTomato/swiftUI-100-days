ReadMe

This is a app that display live weather information within 5 days depend on the geographic location such as longitude, latitude/ city name, zip code

Challenges:

In iOS, parsing a json object which return from API is tricky. Therefore, I have to create many classes to accommodate this challenge.

When using APIs with Data(contensof:url) or URLsession.share.data(), and the url is insecure, we need to add a option in plist of Xcode, plist->add transportation security setting -> add row -> add allow arbitrary load -> set it true. In addition to that, when using city name within api, we need to replace all white space with %20. Done by using addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed).
