# Frontend Mentor - Space tourism website solution

This is a solution to the [Space tourism website challenge on Frontend Mentor](https://www.frontendmentor.io/challenges/space-tourism-multipage-website-gRWj1URZ3). Frontend Mentor challenges help you improve your coding skills by building realistic projects.

## Table of contents

- [Overview](#overview)
  - [The challenge](#the-challenge)
  - [Screenshot](#screenshot)
  - [Links](#links)
- [My process](#my-process)
  - [Built with](#built-with)
  - [What I learned](#what-i-learned)
  - [Useful resources](#useful-resources)
- [Author](#author)
- [Acknowledgments](#acknowledgments)

## Overview

### The challenge

Users should be able to:

- View the optimal layout for each of the website's pages depending on their device's screen size
- See hover states for all interactive elements on the page
- View each page and be able to toggle between the tabs to see new information

### Screenshot

![Design preview for the Space tourism website coding challenge](./preview.jpg)

### Links

- [Frontend Mentor](https://www.frontendmentor.io/solutions/space-tourism-site-using-elm-stL2xTncq5)
- [Live Site](https://adorable-druid-ba30df.netlify.app/)

## My process

### Built with

- Semantic HTML5 markup
- SASS
- Elm

### What I learned

#### Theme-ing

I tried changing up the way I create my colour schemes. Essentially, all the colours that would change between themes went within my `:root` and I separated them between pages. This method seemed to end up with quite a few duplicated content across pages but everything is located in one place, any changes to the theme only needs to be done in one file

```scss
// home page
--bg-homepage-body: url('../assets/home/background-home-mobile.jpg');
--clr-homepage-body-text: hsl(var(--clr-fog));
--clr-homepage-header-text: hsl(var(--clr-white));
```

#### Handling Browser Refreshes

How to make the page load the correct route on browser refresh. Since this is a frontend only _Single Page Application_, the route `https://www.websiteName.com/other-page` doesn't exist so if someone navigated from the homepage to another page and refreshed the browser, they would get something like `Cannot GET /destination`. The way I got around this was by using a feature of my hosting platform, _Netlify_.

I had Netlify map all requests to the index.html route by creating a \_redirects file and re-directing my routes to the home route and then in netlify, I set the publish directory to my home route

#### General Observations

- Sometimes things aren't currently a part of the core elm packages such as the picture element, in cases like these we reach for other elm-packages. These packages though, will give different types which are incompatible with the core types thus these packages will come with _to_ functions, such as `toAttribute` in order to convert them to compatible types

- Setting a height using `grid-template-rows` can really mess things up, even if only use the `fr` unit

### Useful resources

- [Accessible Hamburger Menu](https://www.accede-web.com/en/guidelines/rich-interface-components/hamburger-menu/)

- [How to redirect routes on reload](https://docs.netlify.com/configure-builds/overview/#basic-build-settings)

- [How to redirect routes on reload #2](https://github.com/eberfreitas/pelmodoro/blob/main/_redirects)

- [Elm Course](https://www.udemy.com/course/elm-the-complete-guide/)

## Author

- [My portfolio](https://daniel-arzani-portfolio.netlify.app/index.html)
- [FrontEnd Mentor Profile](https://www.frontendmentor.io/profile/DanielArzani)

## Acknowledgments

The Elm Slack community was very helpful. Elm itself doesn't have many guided tutorials or blog posts and understanding the documentation can be difficult, especially since this is a functional programming language that also has some gaurantees such as _zero run time exceptions_ thus it comes with quite a few constraints, so being able to ask others any questions and receive answers was quite helpful.
