## 🏁 No Longer Being Maintained - DO500 Old Content 🌇
This project is being deprecated and will no longer receive updates or contributions. OpenShift has moved on to version 4.x and this project was used when enabling on Red Hat OpenShift 3.x

For new TL500 content which uses Tekton, GitOps etc checkout the links here
 - 🐙 [TL500 - Tech Exercise Source](https://github.com/rht-labs/tech-exercise)  🐙
 - ⚓️ [TL500 - Deployed Exercises](http://rht-labs.com/tech-exercise)  ⚓️

# Red Hat Open Innovation Labs Enablement Materials

This repo will house all the slides and lab exercises for the Enablement. It will also be used to track issues, features and new additions to the Enablement.

[Course Content](https://rht-labs.github.io/enablement-docs/#/)

## Slides
Please navigate to the "Slides" folder and follow the ReadMe instructions on how to render and view the slides.

## Requirements
NodeJS is needed to run this project, you can download it from [NodeJS](https://nodejs.org/en/download/)

## Exercises

Exercises are created using [Docsify](https://docsify.js.org/#/). Write docs in Markdown and use [Docsify](https://github.com/QingWei-Li/docsify-cli) cli to serve them. Store your lab exercises in the `exercises/<lab-number>` dir.

A template layout for the lab exercise with headings and what should be included is stored in `exercises/0-docs-template`. Use this as a base point when creating new materials. Add items to the sidebar on the homepage by updating the `_sidebar`

To run and serve the docs:

1. `npm i -g docsify-cli`
2. `cd exercises && docsify serve -p 8085 -P 35727` and open your browser to 8085

## Publishing

The `exercises` folder is served as the root of the gitpages site from master branch. To update the published content run:

1. `git checkout master`
2. `git subtree push --prefix exercises origin gh-pages`

## Contributing & Issues

For tracking of feature development and task management add the ZenHub plugin extension to [Chrome](https://chrome.google.com/webstore/detail/zenhub-for-github/ogcgkffhplmphkaahpmffcafajaocjbd) or [Firefox](https://www.zenhub.com/extension). 

To contribute raise an issue and submit a PR to correspond to that feature.
