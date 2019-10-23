---
author: Darshan Crout
title: "Create a Web Scraper Using Go"
date: 2019-10-22
draft: false
---

<center><img src="/post/images/go_web_scrapper/Golang.png" alt="drawing" width="800"/></center>

_Web scrapers hold a dear place in my heart_. During my undergrad, I had the opportunity to present some research at the [Canadian Undergraduate Math Conference](https://cumc.math.ca/), that being numerical solutions to biological aggregation differential equations [1]. In other words, I simulated animal and insect swarming behaviour and presented some visualizations [2]. Going to that conference changed my life as it exposed me to [Python](https://www.python.org/) and [web scraping](https://en.wikipedia.org/wiki/Web_scraping), which eventually led me to the path of data science and machine learning.

The math conference was held at the same time as the [computer science conference](http://www.cucsc.ca/), so I had the chance to sit in on some neat machine learning talks. One talk in particular which amazed me was on sports analytics. It wasn't the analytics that amazed me, more so it was the student who scraped the data from the web himself. I didn't know you could do such a thing [3], so after the talk I asked him how he did it. He dropped some names that would eventually send me down the _gopher_ hole:

<center>"Use [BeautifulSoup](https://www.crummy.com/software/BeautifulSoup/) and Python!"</center>

Wanting to learn more, I googled _how to web scrape_ and I came across Greg Reda's post on [using Python for web scraping](http://www.gregreda.com/2013/03/03/web-scraping-101-with-python/). His posts helped me create my own web scraper using Python and it was my very first experience with the language itself. I owe it to both the helpful individual at the conference and Greg Reda, as they were in my life at the right time.

On my journey towards learning a new language this year, I'm keeping up with tradition by creating a web scraper using [Go](https://golang.org/) (or Golang). Like those individuals who have helped me before, I want to do the same by writing a post about making it. In this post, I will show you how to make a simple web scraper using Go. We will be scrapping the [Pitchfork 500](https://en.wikipedia.org/wiki/The_Pitchfork_500) which is a list of alternative, punk, electronic and hip-hop songs from 1977 to 2006, and saving those tracks to a CSV file. Our web scraper will involve the following steps:

1. **Get the Go app running (a.k.a the "Hello, world!")**
2. **Get the HTML from the page**
3. **Parse the tracks from the HTML using [Goquery](https://github.com/PuerkitoBio/goquery)**
4. **Save the data to a CSV**

One thing to keep in mind when creating a web scraper is to research the site's policy on data gathering and to follow those guidelines. This tutorial will be aimed towards those who are familiar with Python but who want to learn Go. The source code used in this tutorial can be found on [GitHub](https://github.com/dtcrout/pitchfork-500-scraper).

## $ go install go

Let's begin by first installing Go! You can check if you have it installed on your system by running `which go` in the terminal. If a path is returned you have it installed already.

If you don't have Go installed, you can grab it from the main site [here](https://golang.org/dl/). A simpler way to install it, if you are using a [\*nix](https://en.wikipedia.org/wiki/Unix-like) based system, would be to use your OS' package manager (e.g. [apt](https://wiki.debian.org/Apt) for [Debian](https://www.debian.org/)/[Ubuntu](https://ubuntu.com/) or [Homebrew](https://brew.sh/) for macOS). Using a package manager keeps the installation to one line and it will automatically configure everything. For example in macOS, you can install Go by running:

```
$ brew install go
```

Once Go has been installed, it's time to make the app.

## Hello, World!

Create a directory for your scraper called (not surprisingly) `scraper`. Inside the folder, create two files:

```
scraper
├── Makefile
└── main.go
```

`main.go` will hold our scraper code. `Makefile` will hold command shortcuts which will make running and debugging your code easier. To learn more, see my [post](/post/make-life-easier-with-makefiles) on Makefiles.

Inside `main.go`, add the following:

```
package main

import fmt

func main() {
        // Print "Hello, world!" to the terminal
        fmt.Println("Hello, world!")
}
```

What's shown here is typical boilerplate for a Go app. In our `main()` function, we are calling the `Println` method from the `fmt` library and printing the string `Hello, World` from the terminal. To run this code in the terminal, use the command:

```
$ go run main.go
```

If all is well, you should see `"Hello, world!"` printed in the terminal!

### Type less, code more!

This will make more sense later on in the tutorial, but to avoid typing this long command into the terminal I would suggest using the `Makefile` and adding that command as the default instruction. In the `Makefile`, add the following:

```
make:
    go run main.go
```

Running `make` in the terminal will now run the code.

## Get HTML from the page

One thing that makes Go unique compared to Python is its native [http](https://golang.org/pkg/net/http/) library. This library allows you to make http requests, build [REST](https://en.wikipedia.org/wiki/Unix-like) apis and other fun internet stuff. Compare this to Python where you need to use external libraries like [requests](https://requests.kennethreitz.org/en/master/) or [Flask](https://www.fullstackpython.com/flask.html) to build these things.

Create a function called `MakeRequest()`:

```
func MakeRequest(url string) str {
        // Make Get request to a url
        resp, _ := http.Get(url)

        // Close the request
        defer resp.Body.Close()

        // Read the request body
        body, _ := ioutil.ReadAll(resp.Body)

        return string(body)
}
```

`MakeRequest()` takes in a URL, grabs the HTML from the URL using a [GET](https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol#Request_methods) method, and returns the HTML back as a string. Some things that stand out if you're only familiar with Python are the `_`'s and the manipulation of response `resp`. The `Get()` method returns two outputs, the response and an error. If we're calling this method, we need to assign the outputs to two variables, however we're not interested in the error [4]. In Go, we're not allowed to declare _unused_ variables, therefore the `_` is used to indicate to the compiler to _discard_ that output. As for the response, we need to first close our request, read the request to a byte array, then convert that byte array to a string.

Adding this method to our code, importing the libraries and adding the URL, we have the following:

```
package main

import (
        "fmt"
        "io/ioutil"
)

func MakeRequest(url string) str {
        // Make Get request to a url
        resp, _ := http.Get(url)

        // Close the request
        defer resp.Body.Close()

        // Read the request body
        body, _ := ioutil.ReadAll(resp.Body)

        return string(body)
}

func main() {
        // The Pitchfork 500 wiki page url
        url := "https://en.wikipedia.org/wiki/The_Pitchfork_500"

        // Get the HTML from the URL
        body := MakeRequest(url)

        // Print the HTML to the terminal
        fmt.Println(body)
}
```

If you run this code now (remember use `make` instead of `go run main.go`), you should see the HTML dumped to the terminal.

## Parse the HTML using Goquery

Web scraping is a [`R E L A X I N G`](https://www.youtube.com/watch?v=hHW1oY26kxQ) activity. A typical web scraping _sesh_ involves going through the web page's source, _identifying_ the HTML tags which are wrapped around the data you want, _coding_ your parser to find those tags, and running the code. If it works, great! In practice however, you will be repeating this process over and over again until you get what you want (this is why I mentioned the Makefile earlier in this post). Good thing for you that I'll be telling you where to look!

On the Pitchfork 500 page, right click and select "View Page Source". On the wiki page, we want to grab the listed tracks. In the source, we should try to find where this content lies. A picture is given below showing the tracks on the page (left) and where they are in the source (right).

<center><img src="/post/images/go_web_scrapper/page_html.png" alt="drawing" width="1000"/></center>

In the wiki page, we see that the tracks are listed by years. In the HTML, we see that they are identified by the `<div class="div-col ...">` tags. Within these sections, the tracks are wrapped in `<li>` tags. Our parser should first find all the sections which are wrapped in the `div-col` tags, then iterate through every `<li>` element, extracting the track from them.

We will modify our `MakeRequest()` method to parse through the HTML code using Goquery and return to us the tracks in a special type of array called a [slice](https://gobyexample.com/arrays). This new modified method looks like this:

```
func ParseWiki(url string) []string {
        // Make Get request to a url
        resp, _ := http.Get(url)

        // Close the request
        defer resp.Body.Close()

        // Create a goquery doc
        doc, _ := goquery.NewDocumentFromReader(resp.Body)

        // Create array for tracks
        var tracks []string
        var track string

        tracks = append(tracks, "artist,song\n")

        // Find all songs on page and parse string into artist and song
        doc.Find(".div-col").Each(func(_ int, s *goquery.Selection) {
                s.Find("li").Each(func(_ int, t *goquery.Selection) {
                        // Split string by "-" to separate artist and track
                        text := strings.Split(t.Text(), " –")

                        // Grab the artist and song
                        artist := text[0]
                        song := strings.Trim(text[1], " \"")

                        // Create track
                        track = artist + "," + song + "\n"

                        tracks = append(tracks, track)
                })
        })

        return tracks
}
```

Now that our method parses HTML and returns the tracks, it's best practice to rename it to `ParseWiki()`. The first few lines are what we had in the original function, but now we put the request into the `NewDocumentFromReader()` method in Goquery. The `doc` object is something we can now manipulate to find and extract the data we want.

In `doc`, we first find all `.div-col` objects which are the sections which hold our tracks. For each section, we iterate trough all `li` tags which contain our track names. We grab the text from those tags and parse the artist and track name using the [strings](https://golang.org/pkg/strings/) library.

In the code snippet above, some lines might seem strange. Some heuristics and assumptions are added about the text, in particular splitting the tracks by " -" instead of "-" and trimming " \"'s (e.g. `strings.Split(t.Text(), " –")` and `strings.Trim(text[1], " \"")` respectively). This is the nature of scraping - we repeatedly change our code until we get the data that we want in the format we want.

## Save the data in CSV format

Now that we have the tracks, it's time to save them to a CSV file. Let's modify our `main()` function by creating the CSV file, iterating through the track slice and writing the track to the file.

```
func main() {
        // The Pitchfork 500 wiki page url
        url := "https://en.wikipedia.org/wiki/The_Pitchfork_500"

        // Output filename
        out_filename := "tracks.csv"

        // Grab the tracks from the parser
        tracks := ParseWiki(url)

        // Create the CSV to save the tracks
        file, _ := os.Create(out_filename)

        defer file.Close()

        var err error

        // Iterate through tracks in slice, writing them to the CSV
        for _, track := range tracks {
                _, err = io.WriteString(file, track)

                if err != nil {
                        log.Fatal(err)
                }

                file.Sync()
        }
}
```

## Put it all together

Putting everything together, we should have something like this:

```
package main

import (
        "github.com/PuerkitoBio/goquery"
        "io"
        "log"
        "net/http"
        "os"
        "strings"
)

func ParseWiki(url string) []string {
        // Make Get request to a url
        resp, _ := http.Get(url)

        // Close the request
        defer resp.Body.Close()

        // Create a goquery doc
        doc, _ := goquery.NewDocumentFromReader(resp.Body)

        // Create array for tracks
        var tracks []string
        var track string

        tracks = append(tracks, "artist,song\n")

        // Find all songs on page and parse string into artist and song
        doc.Find(".div-col").Each(func(_ int, s *goquery.Selection) {
                s.Find("li").Each(func(_ int, t *goquery.Selection) {
                        // Split string by "-" to separate artist and track
                        text := strings.Split(t.Text(), " –")

                        // Grab the artist and song
                        artist := text[0]
                        song := strings.Trim(text[1], " \"")

                        // Create track
                        track = artist + "," + song + "\n"

                        tracks = append(tracks, track)
                })
        })

        return tracks
}

func main() {
        // The Pitchfork 500 wiki page url
        url := "https://en.wikipedia.org/wiki/The_Pitchfork_500"

        // Output filename
        out_filename := "tracks.csv"

        // Grab the tracks from the parser
        tracks := ParseWiki(url)

        // Create the CSV to save the tracks
        file, _ := os.Create(out_filename)

        defer file.Close()

        var err error

        // Iterate through tracks in slice, writing them to the CSV
        for _, track := range tracks {
                _, err = io.WriteString(file, track)

                if err != nil {
                        log.Fatal(err)
                }

                file.Sync()
        }
}
```

## Final thoughts

Go is a _cool_, _fun_ and _powerful_ language. As someone who doesn't use [low-level programming languages](https://en.wikipedia.org/wiki/Low-level_programming_language) a whole lot, Go seems to be a good entry point as it has abstractions when you just want to get something up and running, but allows for more control when you want it. [Fork this code](https://github.com/dtcrout/pitchfork-500-scraper) and modify it to scrape other sites! In the future I hope to create more apps using Go as an alternative to Python. Until then, let me know what you think and if this was helpful!

---

[1] That was a mouthful.

[2] That sounds like a dope post... Stay tuned.

[3] After all, the only programming I knew of was MATLAB.

[4] In practice, you should be!
