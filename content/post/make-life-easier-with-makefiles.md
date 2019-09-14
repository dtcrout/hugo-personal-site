---
author: Darshan Crout
title: "Make life easier with Makefiles"
date: 2019-08-28
draft: false
---

_Imagine the following scenario:_

You're at work one day, when your boss approaches you with a peculiar task.

"Open your email. I sent you a piece of code", he says. "There's another team who wrote it and they say it takes days to run... They have no idea why though".

You go to your terminal and open the file in your text editor. The file opens and you take a quick glimpse of the code. Java is known to be ugly, but this is different. Something isn't quite right. You can't help but to feel a bit disturbed.

Glancing over the code a bit more, you realize that there are no comments. There's not one docstring that is in sight. All the variables and functions have generic names like `array1` or `x`. There are no references, no signals to _what_ anything does, or what _purpose_ they serve.

You look more into the code and to your disbelief the author wrote their own casting function. Given a number in a string, the function checks if it's zero, else if it's one, else if it's two, else if it's three... You scroll down further and suddenly the _unhandiness_ of the code shows itself.

"It looks like this triple nested for loop is the problem" you tell him, pointing at the screen.

"Can you re-write it in Python?" he asks.

Don't we want to make the code faster? How does this solve the problem?

"Sure."

---

I recently had to re-write legacy Java code into Python. Despite the frustrating, non-sensical task itself, I learned a lot from the process:

1. **Profilers are really handy.** Using profilers are really handy when you want to identify bottlenecks within your code.
2. **Always create unit tests.** When working only your code, having unit tests along the way will help to see if your changes have made affects anywhere else.
3.  **Write a Makefile for your project.**

In this post, we will talk about Makefiles, why they're _handy_ and how they can speed up your workflow making you a more efficient developer.

## What is a Makefile?

Makefiles help you automate your development workflow, make the installation of your project simple and help standardization of working environments for other contributors. You see them when installing packages from source, or for C development, but they can be used for a lot of other things.

In essence, they are a wrapper or an alias for commands or a series of commands. This can be very handy for example when you're debugging code and need to execute test cases and check those test cases every time you make a change. This is what I did when I was porting the Java code over to Python, needing to check whether or not the output remained the same after every change I made.

I use them for just about everything now. Take my blog as another example. Whenever I come back to writing a new post, I typically don't have my development environment set up. I need to download my theme and I need to start up a server to preview my site locally. Because I always forget these commands I made a Makefile to make the setup easier.

## How do I _make_ a Makefile?

Consider the following example: you're developing a Python web server. When developing the application, you need a command to run the application, and another command to execute some `curl` commands to test your endpoints. The output of the `curl` command will be compared to an expected output like `diff`.

Adding a `Makefile` in the root of the directory of your project, we can make a command to execute your Python app:

```
make run:
    python app.py
```

Typing `make run` in the terminal will simply execute the lines you've assigned the alias _or_ task to. In this case it will run the command `python app.py`.

This is a trivial example, but now what if you want to test your endpoints? Curl commands can be lengthy people typically use another piece of software like [Yarc](https://chrome.google.com/webstore/detail/yet-another-rest-client/ehafadccdcdedbhcbddihehiodgcddpl) or [Postman](https://www.getpostman.com/) to help you with this. But everytime you make a change to the code, you need to re-run these commands. You can see how tedious this can get. Instead, just add the test cases to the `Makefile` and then run some more commands to compare the output to a test case.

```
make run:
    python app.py
    
make test:
    curl -X POST http://localhost:8080/my_endpoint > output.txt
    diff output.txt test.txt
```

Running `make test` will execute all those lines in one command, allowing you to move back to coding or take action if differences arise. No need to switch terminals, copy/paste commands, or use other applications.

## I still don't know what to _make_ of Makefiles

For a more elaborate example, take this Makefile from my [Spotitude](https://github.com/dtcrout/spotitude) project on GitHub:

```
# META ]------------------------------------------------------------------------
help:
	@echo "test				Return status of source files."
	@echo "config				Make config file for Spotify API."
	@echo "deps				Make dependencies."
	@echo "server				Create server to view visualization."
	@echo "clean				Remove artifacts and standardize repo."

# CORE ]------------------------------------------------------------------------
test: deps
	. venv/bin/activate ;\
	black --check . --exclude venv

config:
	touch spotitude.config && \
	printf "[DEFAULT]\nUSERNAME=\nSCOPE=user-top-read playlist-modify-private\nREDIRECT_URI=http://localhost:8080\nCLIENT_ID=\nCLIENT_SECRET=" > spotitude.config

deps: requirements.txt
	test -d venv || (python3 -m venv venv && \
	venv/bin/pip3 install -r requirements.txt && \
	touch venv/bin/activate)

server:
	python3 -m http.server 8080

clean: deps
	. venv/bin/activate ;\
	black . --exclude venv && \
	rm -rf *.html *.csv .cache-* __pycache__ venv/
```

In this Makefile, we have a `help` target. Typing `make help` in the terminal will provide some documentation on what each other task in the Makefile does.

[Spotitude](https://github.com/dtcrout/spotitude) is an open-source project. Having a Makefile included in the project makes it simple for contributors to install the dependencies (`make deps`) and standardize the repo (`make clean`).

`make deps` installs all required dependencies for the project. It will first create a Python virtual environment and install all the dependencies in that. That way when someone is contributing to the project, they will always have the same environment as everyone else. Why tell the user _what_ to install through the `README.md` when all they need to do is run `make deps`!

`make clean` helps standardize and reformat the code base and removes temporary files that might be lingering. You should (try) to have contributing guides in your project, but running this command makes it easy for someone to push their commit.

## _Make_ a change to your workflow!

Makefiles make developing faster and much more efficient, allowing you to focus on what really matters. No longer will you have to store all your commands in a separate text file, copy and pasting them into the terminal one by one.

[A whole philosophical work](https://en.wikipedia.org/wiki/Tractatus_Logico-Philosophicus) is on how misunderstandings arise through language. Why bother telling users how to set up a project when they can just run one command with a Makefile? One command to set up everything, and they're already developing on your project.

In case you were wondering with the outcome of my task, I'll leave it to you to figure out what happened. Porting code is a forensic endeavour and you might not get very far with re-writing everything. Documentation helps and test cases do too. Knowing just how bad it can get, I'll be adding test cases and Makefiles in all my projects from now on so no one has to experience the horror I experienced. Automating my testing and code profiling was very useful, just going to show how a Makefile can _make_ all the difference.
