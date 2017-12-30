# TheMovieApp
[![Build Status](https://travis-ci.org/mehul90/TheMovieApp.svg?branch=master)](https://travis-ci.org/mehul90/TheMovieApp)

This is a demo app that lets you seach for movies from themoviedb.org, displays the paginated results, and saves your recent successful searches. It is designed using VIPER architecture, with a slight twist that introduces a combination of coordinators and routers to take care of navigation and data transfer between modules.

### The high-level architecture of the app is as follows:

![](Architecture.png)

Here, the router is a wrapper around a container view controller (here, UINavigationController), whereas the coordinators are responsible for presenting the views for their respective modules within the router.

The coding styleguide adhered to is the one enforced by the swiftlint.

I have added unit-tests for important parts of the code, but some parts were skipped to save time.

The integrated travis CI ensures the tests stay green and that I don't accidently break anything !!
