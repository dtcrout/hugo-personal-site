---
author: Darshan Crout
title: "Prevent Data Leakage in Your Data Science Project"
date: 2019-09-20
draft: false
---

Data leaks happen. With the ever-growing multitude of software-based services we use in the _everydayness_, our usage of [Internet of Things](https://en.wikipedia.org/wiki/Internet_of_things)-_things_, to the _ready-to-hand_ rewards systems on our phones, our personal data is out there in the _world_. As such, our data has a greater chance of leaking and getting into places we don't want it to end up.

As data scientists and machine learning developers, we should be taking measures to prevent sensitive information (such as credentials or customer data) from leaking out of our projects. When collaborating with others, we sometimes encounter shortcuts such as hard-coded keys throughout the code. Unfortunately, I've seen such things in industry. It can be difficult to fix, and it could lead to others accidentally pushing sensitive information into the repo.

Whether you're working on a work project or a personal one, how do you prevent leaking sensitive information? In this tutorial, we will create several files to help with data leakage. We will look at:

**(tl;dr)**

1. **Separating sensitive information like credentials using a `config` file and loading them using a `Config()` class**
2. **Preventing sensitive information from being committed and uploaded using the `.gitignore` file**
3. **Automating the creation of a `config` file and the removal of sensitive information using a `Makefile`**

The tips provided in this tutorial are meant as an introduction; to familiarize yourself with some best practices which you can incorporate into your own project. We will be focusing on a `Python`-based project, however you can apply these tips to whatever language you use. It also goes without saying that when working with sensitive information, you should always follow your company's policies and guidelines first (they might even advise against the tips in this tutorial 😜).

## Tip #1: Configure a `config` file

As a data scientist, I work with data which I need to fetch from a remote server (often a SQL database), requiring me to use credentials to access that database. For my project, I could be making a script or a notebook which I would use as a proof-of-concept. One can be tempted to hard-core the credentials in the code, thinking that you can remove or mask those values before pushing to the repo.

Now imagine the case where you would require the credentials in multiple files. You can imagine the problem of keeping track of _where_ these credential variables are when having to delete or mask them.

`config` files fortunately solves this problem! Using the [`configparser`](https://docs.python.org/3/library/configparser.html) package in Python, you can keep your credentials in one single file. We can then create a class which will store these variables and then can be called in your code.

Typically a config file will be contained in the root of your project directory. To see how this is can be done, create a file called `config` in the root of your project with your credentials. It can look something like the following:

```
[SQL_SERVER]
DATABASE=my.sql.database
USERNAME=my_username
PASSWORD=my_password
```

Here we have credentials for the database we are fetching our data from. Next, we can create a Python class to load those credentials from the `config` file. Create a file called `config.py` with the following contents:

```
import configparser

config = configparser.ConfigParser("./config")

class Config:
    def __init__(self):
        self.sql_config = config["SQL_SERVER"]
        self.database = sql_config["DATABASE"]
        self.username = sql_config["USERNAME"]
        self.password = sql_config["PASSWORD"]
```

So what's going on here? We've created a new class called `Config()` to _hold_ our credentials, parsing them from the `config` file. If you require your config credentials in your code now, you can load in the `Config()` class, and get the variables from there:

```
from config import Config
from sql_library import connect

if __name__ == "__main__":

# Initiate the config class
config = Config()

# Get the credentials
uname = config.username
pass = config.password

# Use the credentials for what you need them for
sql_connector = connect(uname, pass)

# do
# stuff
# here
# ...
```

You can see now our credentials are just obtained from the `Config()` class and never _explicitly_ stated anywhere in the code. As your code gets more complex and the more instances of your credentials you need, you can be rest assured that your credentials won't be exposed explicitly in the code.

You might have been thinking now, "Okay, the credentials are not hard-coded, but what if I upload the config file?" Good question! That brings us to the next tip!

## Tip #2: Don't ignore the `.gitignore`

When working in a Git project, the `.gitignore` file is (not surprisingly) a list of files you would like Git to _ignore_. The `.gitignore` file is typically created when you create a new Git repo, however if it's not present, you can create one by running:

```
$ touch .gitignore
```

Next, open the file using your text editor and add the name of the config file:

```
# config files
config
some_file
some_other_file

# directories
data/
```

In the code snippet above, we have the `config` file added, in addition to a directory called `data/`. The `.gitignore` file can contain files in addition to directories you don't want to be pushed to Git. This is handy when you have a directory for data files (of which may contain sensitive information) which you don't want to push to your repo.

At this point, you're pretty much covered from leaking credentials or other sensitive information by accident when pushing code to Git!

Suppose now that your code has lingering files such as output files that you want to remove every time when pushing your code. What if someone uses your code, but they need to create a `config` file? You can provide instructions on how to make a `config` file, _or_ automate the process with a `Makefile`.

## Tip #3: Make it happen with a `Makefile`

[In another post of mine](/post/make-life-easier-with-makefiles/), I talked specifically about `Makefiles`, what they are and how to use them. You can think of a `Makefile` as a file containing a set of rules or commands which can be used via the `make` command on `*nix` systems. We will look at two scenarios, create the `make` rules around those scenarios and explain how to use them.

### Automating `config` generation and removing unwanted files

As mentioned, we would like to do two things to keep our project secured for us and other users and contributors. Specifically:

1. We would like to remove lingering output files, cache files and/or config files.
2. We would like to automatically create a `config` file

For these two tasks, we can create a `Makefile` which contains the following code:

```
make clean:
    rm -rf data/* cache_file config

make config:
    printf "[SQL_SERVER]\nDATABASE=\nUSERNAME=\nPASSWORD=" > config
```

What we're doing here is creating two sets of instructions: `clean` and `config`. For each instruction, we have a series of shell commands to run whenever we call the rule. For example, running `$ make config` will crate a file called `config` and write the required fields in that file. A new contributor coming into the project can simply run this command, open the `config` file and input their credentials.

`Makefiles` make it easy for others to work with your project and to automate things such as removing lingering data and cache files.

## Some other useful tips

Here are some other things to consider when working on your project:

### Use `git status`; Be cautious using `git add -A`

Always look at what you're committing before you commit it. You can check what files have been modified in your project by using the `git status` command. Try not to use the `git add -A` command unless you're sure of what you will be committing.

### Familiarize yourself with Git's `config` command

If you're using one machine for you work and personal projects, be sure to configure as well as check your `git config` in your project, specifically your `name` and `email`. You can obtain your `name` and `email` with the following commands:

```
$ git config user.name
$ git config user.email
```

And you can change the values with the following:

```
$ git config user.name "My Name"
$ git config user.email "my.name@email.com"
```

More information on how to configure this can be found [here](https://help.github.com/en/articles/set-up-git).

### Be careful of what values you're printing to `stdout` and `stderr`

If you're serving your model through an API on the cloud for example, you can accidentally leak data through the logs via lingering `print` statements in your code. Just be sure to mute these statements in your code, or switch to using a [`logger`](https://docs.python.org/3.5/library/logging.html).

### Encrypt sensitive information using `gitcrypt`

In the chance that you have to provide sensitive files in your repo, consider using a tool like [`gitcrypt`](https://github.com/AGWA/git-crypt) which can encrypt sensitive files before pushing them to Git. Perhaps I'll write a future post on this... 😉

## Be safe out there!

I hope that covers some of the basics when working with sensitive information in your data science project. In this tutorial we covered the following:

1. **Separating sensitive information like credentials using a `config` file and loading them using a `Config()` class**
2. **Preventing sensitive information from being committed and uploaded using the `.gitignore` file**
3. **Automating the creation of a `config` file and the removal of sensitive information using a `Makefile`**

This is of course not an exhaustive list on how to make your project more secure, but I believe it is a good starting point. Incorporating these practices can save you some headaches with variable book keeping, give you some peace of mind and make your project more accessible to others!
