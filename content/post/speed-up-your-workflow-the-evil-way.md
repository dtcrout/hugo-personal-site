---
author: Darshan Crout
title: "Speed Up Your Workflow the Evil Way"
date: 2019-10-13
draft: false
---

Like all developers, something which helps me get my work done quickly are [keyboard shortcuts](https://en.wikipedia.org/wiki/Keyboard_shortcut). Everyone is familiar with _some_ set of shortcuts, `ctrl + c`, `ctrl + v`, and `ctrl + s` to name a few. These common shortcuts are quite convenient since they (typically) work across all applications on your operating system.

But now, suppose you want to navigate trough your tabs in your web browser. Which shortcuts do you use? Unlike `ctrl + c`, these shortcuts aren't immediately obvious. If they're application specific, are they even worth learning? What if you want to "click" on links on a webpage using the keyboard? Are there even shortcuts for that? As your workflow gets more complex, there seems to be a lot of shortcuts one needs to memorize in order to get work done _quickly_ and _effectively_.

My coding workflow involves me switching between my _editor_, _terminal_ and _browser_. If I wanted to memorize the shortcuts for all these applications, it could get overwhelming. The list would just be too long and I would forget them over time. Instead of memorizing shortcuts on an application basis, what if there existed a set of "standard" shortcuts, like `ctrl + c` and `ctrl + v`? Does there exist a set of shortcuts which apply to the editor, terminal, and browser (and possibly the OS)?

On my journey to increase productivity, I familiarized myself with [Vim](https://en.wikipedia.org/wiki/Vim_(text_editor)) and [Emacs](https://en.wikipedia.org/wiki/Emacs) shortcuts. Believe it or not, learning these shortcuts provide a "framework" of sorts for _navigation_ and _text editing_ which work across all my apps. In this tutorial, I'll talk about _why_ it's worth learning these shortcuts and _what_ tools you can use to get them working in your editor and browser.

## Let's play a game!

When developing, I'm always playing a simple game:

> Keep your hands on the keyboard as much as possible, a.k.a the mouse and trackpad are hot lava.

To accomplish this, I use tools which allow me to interact with my applications only using keyboard shortcuts. Why would you want to play such a game? During development, when switching through hundreds of [Stack Overflow](https://stackoverflow.com/) questions and [Python](https://www.python.org/) documentation tabs, you realize the mouse _isn't_ the most efficient way to navigate through this mess. Combine this probelm with switching back and fourth to your editor and the terminal. You soon realize how much time is wasted switching between the keyboard and mouse.

Another reason why you would want to play such a game is that it's more _ergonomic_. In fact, I play the ergonomic version of the game mentioned above:

> Keep your hands to the [**home row**](https://en.wikipedia.org/wiki/Touch_typing#Home_row) as much as possible, a.k.a the mouse, trackpad, modifier keys and arrow keys are hot lava.

When considering ergonomics, there are are certain keys which I refrain from using. These keys are the modifier keys near the `spacebar` (`ctrl`, `command`,  and `option`) and the arrow keys. A lot of shortcuts depend on either the `ctrl` or `option` key. Having to move between these keys puts strain on your fingers and writs. You can stick to the home row by remapping a modifier key to the `caps lock`. Since most Emacs shortcuts rely on `ctrl`, I remapped `caps lock` to `ctrl`.

Now that we've laid out the objective of our game, what shortcuts do we use to navigate through our code, or even _outside_ of our code, like in our browser? What shortcuts do we learn to stop us from putting strain on our hands when reaching for the arrow or modifier keys? We need to get [evil](https://www.emacswiki.org/emacs/Evil) - we need to familiarize ourselves with Vim and Emacs.

## Getting evil with Vim and Emacs

To many new developers, Emacs and Vim are text editors which can be accessed via the terminal. People typically use them when either they need to view a file in the terminal, or when working in an environment which doesn't have a GUI (e.g. [ssh](https://en.wikipedia.org/wiki/Secure_Shell)-ing into a remote server). I believe both editors offer more than that: both editors have a philosophy on _how_ one should interact with text or code. While there have been [endless debates](https://en.wikipedia.org/wiki/Editor_war) on which one is better, I believe both editors serve their _own_ purposes. Vim offers a framework for _navigation_ and Emacs offers a framework for _editing_.

In this tutorial, I won't go over _how_ to use Vim or Emacs. Rather, I'll talk about tools and other tips which you can use once familiarizing yourself with them. There are endless resources online which can help you to get started. Once you have become familiar with them, here's how you can use them in your editor, web browser, and OS:

### Extensions and editors

If you don't want to use the Vim or Emacs editors themselves, modern editors like [Atom](https://atom.io/) or [VS Code](https://code.visualstudio.com/) have extensions which bring these shortcuts to the editor. If you want to use Emacs bindings for example, you can use extensions like [emacs-plus](https://atom.io/packages/emacs-plus) for Atom and [Emacs Keymap](https://marketplace.visualstudio.com/items?itemName=hiro-sun.vscode-emacs) for VS Code.

There are also editors which have _evil_ mode by default, like [Spacemacs](http://spacemacs.org/) or [Doom Emacs](https://github.com/hlissner/doom-emacs). These editors however are just configuration files for Emacs, giving them a nicer interface and more functionality. Personally, I've been using Spacemacs for over a year, and find it much nicer than any other modern editor.

Now that we've established how you can use these shortcuts in your editor, how do you use them _outside_ your editor and into the browser?

### Enhance browser navigation using Vimium

<center><img src="/post/images/evil_mode/vimium_demo.gif" alt="drawing" width="600"/></center>

Vim controls are perfect for navigation, which is why it adapts to the browser so well. To bring Vim controls to the browser, I use an extension called [Vimium](https://vimium.github.io/). If you're not using Chrome/Chromium, other extensions like [Vimperator](http://vimperator.org/vimperator) or [Pentadactyl](https://github.com/5digits/dactyl) bring the same functionality.

After installing the extension, you can scroll through a webpage using `j` or `k` like in Vim. You can even access links on a page through shortcuts. Pressing `f` creates a shortcut overlay for all links on the page. You can also navigate through tabs using `shift + j` or `shift + k`. The gif above shows a demo of this. As mentioned in our problem earlier, these shortcuts allow you to quickly navigate through all of them without having to use a mouse.

Switching between the editor and browser is more of a seamless experience now that you don't have to use a mouse. Not to mention that the controls that you are using in your editor are the same in the browser. No need to memorize an extra set of shortcuts!

What if I were to tell you that you can go beyond the editor and browser, and transcend into the OS? Would you be amazed if I told you that there exists Emacs shortcuts in your OS? If you use [macOS](https://en.wikipedia.org/wiki/MacOS), you can!

### Emacs in macOS

<center><img src="/post/images/evil_mode/macos_demo.gif" alt="drawing" width="600"/></center>

I didn't learn until a couple of years ago that macOS has emacs-like shortcuts already built into it. In your web browser, go ahead and click on the url bar and do the following:

1. Press `ctrl + e`
2. Press `ctrl + b` a couple of times
3. Press `crtl + a`
4. Press `ctrl + k`

You should of noticed that _step 1_ moves the cursor to the beginning, _step 2_ moves your cursor back two characters, _step 3_ moves your cursor to the beginning of the url and _step 4_ deletes the string.

Try playing around with this in other field boxes and be amazed. The gif above demos this ability in [TextEdit](https://en.wikipedia.org/wiki/TextEdit). No longer will you have to use the arrow keys or the mouse when interacting with text.

## Conclusion

Like `ctrl + c` and `ctrl + v`, we've learned that Vim and Emacs shortcuts are a set of "universal" shortcuts in a sense. When using the right tools like an extension in your editor and a browser extension like Vimium, you're able to use the same set of shortcuts across the editor, browser and OS. I realized I forgot to talk about the terminal, but when you've learned how they apply to the OS, they also apply to the terminal.

Once you familiarize yourself with these tools, you'll notice a major speed increase in your workflow and wonder how you even used a computer before. This will become more apparent when you try using another machine that isn't yours and get frustrated that it doesn't have an Emacs extension or Vimium. (When I'm using another machine, I try to convince the individual to use these tools... 😛)

Some other great tools which I use to improve my workflow are [window tiling](https://en.wikipedia.org/wiki/Tiling_window_manager) and [tmux](https://github.com/tmux/tmux/wiki). Perhaps I'll do a tutorial on these topics in the future. Until then, I hoped this tutorial has helped you on your journey to become a better developer. What are some tools you use to get your work done faster? Leave a comment or [tweet](https://twitter.com/durshmallow/status/1183551317094096898), I'm curious to know!
