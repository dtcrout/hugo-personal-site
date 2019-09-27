---
author: Darshan Crout
title: "Meditations on First Contributions"
date: 2019-09-26
draft: false
---

<center><img src="/post/images/misc/ferris.png" alt="drawing" width="800"/></center>

<center>"Life moves pretty fast. If you don't stop and look around once in a while, you could miss it."</center>

In [Ferris Buller's Day Off](https://en.wikipedia.org/wiki/Ferris_Bueller%27s_Day_Off), our young philosopher turns to the audience and tells us we should stop and take a moment to reflect on what's going on around us. He wants us to ask ourselves: are we living [_authentically_](https://en.wikipedia.org/wiki/Authenticity_%28philosophy%29)? ...And he's right. When was the last time you took a moment to reflect on what was going on in your life? Are you becoming the best version of yourself? Are you living life to the fullest? We could learn a lot from the [Albert Camus](https://en.wikipedia.org/wiki/Albert_Camus) of the 1980's.

As this year comes to an end, I find myself reflecting on everything that has happened thus far. I look back at all the goals I set for myself and how I have accomplished them. These purpose of the goals being to help me live my best life - an _authentic_ one. One of those goals in particular was to make a contribution to an [open source](https://en.wikipedia.org/wiki/Open_source) project.

Open source software is a philosophy I strongly believe in. So much in fact, I wanted to go a step further than just using it - I wanted to contribute to it. The problem is that I haven't been a programmer for very long. I started my data science journey two years ago, and the year after that I started developing software. Contributing to a major project this year was probably out of reach. Even contributing to a smaller project was still very intimidating.

Knowing where to begin is an issue for a lot of newcommers such as myself. Thankfully there are resources to find projects which you can contribute to. [Up-for-Grabs](https://up-for-grabs.net/#/) and [First Timers Only](https://www.firsttimersonly.com/) are fantastic resources to help you get started contributing to open source projects. Despite the available resources, I still faced struggles. I found it difficult to find projects I found interesting. When I did find projects, I found it difficult to make an impact. There was something that was still out of reach, but I couldn't put my finger on it.

In the meantime, I continued to work on personal projects. One of the projects I worked on this year was [Spotitude](https://spotitude.me), which has both a [Python](https://github.com/dtcrout/spotitude) version and a [JS webapp](https://github.com/dtcrout/spotitude-webapp). Spotitude is a simple tool. It connects to your Spotify account, finds the top 25 tracks you've listened to and returns a visualization of the album art of the tracks in a grid.

The implementation was simple enough. However, there were features that always came to mind that would of been _nice-to-have_. It _would be nice_ to include an `argparse` to give the user more control. It _would be nice_ to make a playlist out of the tracks you collect. Like every project, if you work on it too long, you'll eventually burn out.

That's when it dawned on me: "why not allow others to add the functionality for you?" Instead of leaving the project as is, I opened it up to the community via Up-for-Grabs. I created all the features I wanted as issues, labeled them for newcommers and included a detailed description how I would prefer the implementation to be done and what would be the acceptance criteria. These projects were now becomming a learning tool for other newcommers.

Adding an `argparse`, extra functionality in the `Makefile` or improving documentation are great problems for first timers. I discovered that open source development is not just about contributing to projects. It's about providing a learning experience for others, to get them familiar with proper code collaboration in return giving them a foundation which they can take on their open source journey. By guiding others through my pull requests, I also got to learn from the contributors themselves. You start to learn from other people's perspectives and experiences, which in turn makes _you_ a better developer.

At the time of writing this post, Spotitude has 16 stars on GitHub. While some people might think that's not a lot, I'm amazed that my little project has gained so much attention. It's unbelievable to see the project grow into something more than what I envisioned, and it's all thanks to the people who contributed.

Throughout the Ferris Buller's Day Off, we start to uncover just how much of an influence Ferris has on others. Not only is he the most popular kid at school, but even the adults in his town love him. We learn that he's helped almost everyone in one way or another. And while the audience knows he's faking, when others hear that he's sick, they do everything they can to help him because he has helped them. That's how I see the open source community. We help each other _to_ make great things. It goes beyond just contributing lines of code: it's about providing an accessible environment so anyone can contribute, no matter what your background.

We should be like Ferris and help others. Even Grace, Mr. Rooney's secretary gets it: “The sportsos, the motorheads, geeks, sluts, bloods, wastoids, dweebies, dickheads – they all adore him. They think he’s a righteous dude."
