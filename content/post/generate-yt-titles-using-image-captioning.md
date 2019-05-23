---
author: Darshan Crout
title: "Generate YouTube Titles Using Image Captioning"
date: 2019-05-11
draft: false
---

I watch a lot of [YouTube](https://www.youtube.com/). In fact, a lot of younger people [watch more YouTube](https://www.thinkwithgoogle.com/consumer-insights/video-trends-where-audience-watching/)
then they watch television. If you're like me, YouTube is not only an endless source of entertainment, but it also serves as a source of knowledge and information. The platform has videos on
just about anything, from from how to make your own [fermented food](https://www.youtube.com/watch?v=zx8pYMkkKXg), [cracking the Sega Saturn](https://www.youtube.com/watch?v=jOyfZex7B3E) or
[Joe Rogan interviewing himself](https://www.youtube.com/watch?v=-xY_D8SMNtE). However, if you have been on the platform for as long as I have, you have probably caught on by now
just how much [clickbait](https://en.wikipedia.org/wiki/Clickbait) YouTube creators use. For example, creators structure their video thumbnails a particular way to catch audiences'
attention. The same thing can be said with the titles. This helps their videos get picked up by the search engine optimization algorithm.

![Clickbait Example](/images/clickbait.png)

As a consequence of content creators engaging in these practices, YouTube and its community has unintentionally developed its own unique language.
Motivated by curiosity, I thought about what it would be like to train an image captioning model based on this strange internet subculture. Using LSTMs and an encoder-decoder model,
I trained an image caption model on YouTube thumbnails and their titles to generate new titles. The code can be found on [GitHub](https://github.com/dtcrout/yt-title-generator).

![They take time!](/images/koji.png)

## Getting the Data

If we want to get a good representation of what YouTube represents today, we look no further than the trending videos found on its homepage. The trending page is essentially the top
watched videos on the platform. YouTube does provide its own API to obtain metadata for its videos, but you're limited to making a limited number of requests. Doing a quick Google
search, I found an already compiled Kaggle dataset which has trending videos based on different regions. For this project, we used `US` videos which have a total of `40,949` records.

## Modelling and Results

To caption the images, we use LSTMs with an encoder-decoder model. Model architecture and generation code was adapted from
[Machine Learning Mastery](https://machinelearningmastery.com/develop-a-deep-learning-caption-generation-model-in-python/).

Image features were generated using VGG16 and the titles were minimal preprocessed by just removing symbols. The vocabulary size was `7,788 words`.
The dataset was split into a `70/30` test/train ratio and the model was trained for 10 epochs using `Adam` as our optimizer.

After training the model, captions were generated for all thumbnails and compared to the original titles. Immediately we notice
something strange...

![Model is generating repeating words]()

For a given thumbnail and starting word, we choose the next most probable following word. In our models case, we see that one word has a higher
probability of all other words. If we want to generate less non-sensical answers, we need to create some heuristics and hope for the best. Instead of choosing the next most
probable word, let's consider randomly choosing uniformly of all words. Another heuristic we can use is to eliminate words appearing twice.

![Model with better titles...]()

We definitely have titles now that have some structure, however it's not all good. Some things we do notice from the titles:

* A lot of titles have terminology found in movie trailers
* point 2
* point 3

## Further Work

It's no surprise why we have less than desirable results. A couple of reasons being a lack of data and an imbalance of different categories of videos. It certainly would be nice to
have more data, however this project was more of an indulgence of my curiosity than anything. Some other things we can consider in order to improve this model can be:

#### Getting better data

For this project, we want to consider only english videos, which are the United States (US), Canada (CA) and Great Britain (GB) regions. Below is a breakdown of the records
in each dataset:

* US videos: `40,949` records
* CA videos: `40,881` records
* GB videos: `38,916` records

Eliminating duplicates among all datasets, this gives us a total of `111,394` records. This isn't a bad number of videos, however not all of them have English only titles.
So for the sake of simplicity, we proceed with training on just US videos.

#### Adding more heuristics the text generation process

Specifically I'm talking about how to make the text generated appear as real titles. One possible way would be to incorporate part-of-speech tagging to the generation.
This can add some overall structure to the titles, therefore making them appear less nonsensical.

#### Use more sophisticated models
Attention models are big right now for image captioning. However your model is only as good as the data you train it on, and if we're only working with `41,000` records,
most of which are non-sensical in the first place, attention models might not give us fantastic results, but it would be interesting nonetheless.

Some other things we can do is to limit the categories of the videos used for training. If we happen to create a decent caption generation,
then we would like to validate our captions using something like a [BLEU score](https://en.wikipedia.org/wiki/BLEU).
