# Red Hat Open Innovation Labs Enablement Materials
This repo will house all the slides and lab exercises for the Enablement course. It will also be used to track issues, features and new additions to the course.


## Slides
Use the [Open Innovation Labs reveal.js template](https://github.com/rht-labs/slides-template) to create new content. Add your slides and commit them to the `slides` dir

## Exercises
Exercises are created using [Docsify](https://docsify.js.org/#/). Write docs in Markdown and use [Docsify](https://github.com/QingWei-Li/docsify-cli) cli to serve them. Store your lab exercises in the `exercises/<lab-number>` dir.

A template layout for the lab exercise with headings and what should be included is stored in `exercises/0-docs-template`. Use this as a base point when creating new materials. Add items to the sidebar on the homepage by updating the `_sidebar`

To run and serve the docs
1. `npm i -g docsify-cli`
2. `cd exercises && docsify serve -p 8085 -P 35727` and open your browser to 8085

## Contributing & Issues
For tracking of feature development and task management add the ZenHub plugin extension to [Chrome](https://chrome.google.com/webstore/detail/zenhub-for-github/ogcgkffhplmphkaahpmffcafajaocjbd) or [Firefox](https://www.zenhub.com/extension). 
To contribute raise an issue and submit a PR to correspond to that feature.