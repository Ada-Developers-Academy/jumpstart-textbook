# Ada Developer Academy "Textbook"

This project is a platform for organizing and distributing the _Jump Start_ curriculum for [Ada Developers Academy](http://adadevelopersacademy.org) in Seattle, WA, USA. This is not the primary classroom curriculum; Jump Start is a prepatory exercise for folks preparing to enter Ada.

The [Ada Classroom Curriculum](https://github.com/Ada-Developers-Academy/textbook) is also available on Github.

This is a [Middleman](https://middlemanapp.com/) project; the [built, static-site is available on GitHub Pages](http://ada-developers-academy.github.io/jumpstart-textbook) or by browsing the [gh-pages branch of this repo](https://github.com/Ada-Developers-Academy/jumpstart-textbook/tree/gh-pages).

## Textbook Structure

Each portion of the Jump Start curriciulum is broken into units. Each unit into chapters, and each chapter into lectures. Every unit, chapter, and lecture is represented by a markdown file, organized in the `/units` directory as described by the table of contents located in `/data/toc.json`.

## Creating New Textbook Content

To generate new lectures/chapters/units, add the appropriate structure to the `toc.json`, then run `rake toc` from the project root. That rake task will parse the table of contents, then create any missing directories or files in the appropriate paths. After that, add the lecture/notes/exercises/whatevs to the generated markdown file. There's no need to alter the Middleman config or reference the new content; everything is automatically generated/proxied/routed based on the table of contents.

Run `middleman server` from the project root to fire up a local web server. By pointing your browser to [http://localhost:4567/](http://localhost:4567/) you can navigate to your new content to verify its layout and appearance before committing or deploying.

## Deploying the Textbook

Run `middleman deploy` from the project root to automatically clean, build, and deploy the project. Deployment is a force-push of the built static site to the `gh-pages` branch of GitHub repo. Once pushed to that branch, GitHub pushes the new content live, typically within a minute. You may need to force-refresh your browser to see the updated content.

Please be aware that every deploy force-pushes over the existing deploy. __The gh-pages branch is for deployments only. No content, markup, styles, or anything else should be manually committed/pushed to that branch. It will be overwritten and lost on the next deploy. All development should happen in forks or branches that are then pull-requested into master.__

## License

This project is released under the MIT License. Please see the accompanying [LICENSE.md](https://github.com/Ada-Developers-Academy/textbook/blob/master/LICENSE.md) file for more details.

[Ada Developers Academy](http://adadevelopersacademy.org)'s Jump Start Curriculum is licensed [Creative Commons Attribution-ShareAlike 4.0](http://creativecommons.org/licenses/by-sa/4.0/).
![Creative Commons License](http://i.creativecommons.org/l/by-sa/4.0/80x15.png)
