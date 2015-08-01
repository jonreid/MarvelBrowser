Marvel Browser
==============

This is slowly becoming an iOS sample app to showcase Test Driven Development
(TDD). The commit log shows you my sub-steps and thoughts as I progress.

To build the project:

  1. Get your own keys from http://developer.marvel.com
  2. Create a folder MarvelBrowserKeys next to the MarvelBrowser folder
  3. Inside MarvelBrowserKeys, create a file MarvelKeys.m that looks like this:

    static NSString *const MarvelPublicKey = @"your-public-key-here";
    static NSString *const MarvelPrivateKey = @"your-private-key-here";

Relevant posts so far:

  1. [TDD Sample App: 20 Topics that May Spill Out](http://qualitycoding.org/tdd-sample-app/)
  2. [Xcode Warnings: Turn Them Up to Eleven](http://qualitycoding.org/xcode-warnings/)
  3. [7 Spike Solution Techniques](http://qualitycoding.org/spike-solution-techniques/)
  4. [Is Apple Stuffing Your Code with Cruft?](http://qualitycoding.org/template-code-clutter/)
  5. [How to Rearrange Xcode Projects to Increase Testing](http://qualitycoding.org/rearrange-project-test-code/)
  6. [How to Easily Switch Your App Delegate for Testing](http://qualitycoding.org/app-delegate-for-tests/)
  7. [TDD Case Study: Is Fast Better than Perfect?](http://qualitycoding.org/tdd-deferred-design/)
