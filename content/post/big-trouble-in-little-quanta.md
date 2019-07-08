---
author: Darshan Crout
title: "Big Trouble in Little Quanta: A critique of complex-valued networks for NLP explainability"
date: 2019-07-05
draft: false
---

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.1/MathJax.js?config=TeX-AMS-MML_HTMLorMML">
</script>

What do you do on vacation? Do you relax on a nice, hot sunny beach sipping on an ice cool drink? Do you travel across South East Asia with a loved one eating new and delicious foods? Perhaps you enjoy adventuring and hiking in the great, beautiful Swiss Alps? Or maybe you're more like me, someone who is at home catching up on their machine learning papers. One paper in particular caught my full attention: [CNM: An Interpretable Complex-valued network for Matching](https://arxiv.org/abs/1904.05298) by Qiuchi Li, Benyou Wang and Massimo Melucci. In the paper, the authors propose a framework to model human language by the mathematical framework of quantum physics, specifically modelling language in [Hilbert space](https://en.wikipedia.org/wiki/Hilbert_space). Similar to methods such as [word2vec](https://en.wikipedia.org/wiki/Word2vec) or [GloVe](https://en.wikipedia.org/wiki/GloVe_(machine_learning)) which model words to a real-valued vector space, words and sentences are mapped to a complex-valued vector space. What makes the paper rather interesting however is that by using complex-valued vector spaces, (the authors suggest) phase and amplitude can relate to things like _polarity_, _ambiguity_ or _emotion_. Essentially the framework of quantum mechanics serves as a tool for [explainability](https://en.wikipedia.org/wiki/Explainable_artificial_intelligence) for the problem of natural language question and answering. It even won [Best Explainable NLP Paper](https://naacl2019.org/blog/best-papers/) at NAACL 2019.

Having studied physics in my undergrad, I was naturally drawn to the paper. The paper suggests that Hilbert space provides a good framework for model explainability and I certainly thought this was a very interesting and novel approach. However after reading the paper, I couldn't help but to feel a bit mislead. I felt not only was there a misuse of ideas from quantum mechanics, but also a lack of evidence and (ironically) explanation for a framework which would be ultimately used for explainability.

## What's the big deal with a little quanta?

Right off the bat, I began to feel uneasy with the author's analogies to quantum mechanics. I've always had an avid interest in science, so naturally misrepresentation of scientific theories bother me. What do I mean by this? One famous example is the concept of [quantum healing](https://en.wikipedia.org/wiki/Quantum_healing), a term coined by famous author and alternative medicine advocate [Deepak Chopra](https://en.wikipedia.org/wiki/Deepak_Chopra). Chopra suggests that phenomena such as sudden and dramatic healing relates to quantum mechanics and consciousness. Quantum mechanics is the framework in which we describe the physics of atoms and subatomic particles, and can only be applied to such systems. Not only is Chopra's use of quantum mechanics incorrect, but it's irresponsible to make claims like these, as unsavvy readers of his work who might be ill might put trust into nonsense which has no scientific basis, hoping that it will improve their health.

I want to make it clear that I don't claim to be an expert in quantum mechanics. However I believe I'm using the proper resources and tools to help me make educated conclusions. In regards to CNM, I saw ideas that could be construed incorrectly and I felt the need to write about it.

In the data science and machine learning community, we like to write blogs or tutorials on great new ideas, but I feel as if we don't write enough critical pieces. If we write about new ideas from more of a critical angle, I believe we can help cut through the noise, pushing forward the great ideas, in turn developing a healthy and trustworthy community. This is especially needed in a time when machine learning research is all the rage and new ideas and theories are put out faster than we can review them.

## Troubling trends in exciting times

After reading CNM, it was clear that there were a lot of things about the paper that bothered me. To help me identify issues within the CNM paper, I read another paper called [Troubling Trends in Machine Learning Scholarship](https://arxiv.org/abs/1807.03341) by Zachary C. Lipton and Jabob Steinhardt. The paper describes some troubling trends they've observed within the machine learning research community accompanied with some examples, in addition to proposing solutions. [Here](http://approximatelycorrect.com/2018/07/10/troubling-trends-in-machine-learning-scholarship/) is a blog post on the paper if you want to read more. In the paper, the authors outline four common trends within machine learning papers:

* Failure to distinguish between explanation and speculation
* Failure to identify the sources of empirical gains, e.g. emphasizing unnecessary modifications to neural architectures when gains actually stem from hyper-parameter tuning
* Mathiness: the use of mathematics that obfuscates or impresses rather than clarifies, e.g. by confusing technical and non-technical concepts
* Misuse of language, e.g. by choosing terms of art with colloquial connotations or by overloading established technical terms

The paper was very enlightening and I would highly recommend reading it. It should be noted that these trends are not unique to the field of machine learning. In fact, I've experienced these issues in my undergrad doing applied math research. As data scientists, machine learning researchers, or those who simply have an interest in the field, we should put some onus on ourselves to be critical of what we read. I understand though in a field like machine learning where new research is coming out at a great rate, we can sometimes mistake the rate of work being developed as actual progress in the field. To quote computer scientist Drew McDermott on the field of AI research [3]:

<center>_"If we can't criticize ourselves, someone else will save us the trouble."_</center>

### Explanation vs Speculation

In the Abstract of the paper [1], the authors state that "with well-contsrained complex-valued components, the network admits interpretations to explicit physical meanings". What does the author mean about _explicit physical meanings_? The authors are talking about the components of the complex values, i.e. amplitude and phase. They elaborate further in the introduction, stating that amplitudes correspond to the _lexical meaning_ and the phases implicitly reflect the higher-level semantic aspects such as _polarity_, _ambiguity_ or _emotion_.

In the paper however, there are no tests or experiments to back up these bold claims. The authors return to the explanation of complex phase and amplitude in Section 6.3 in the Discussion. In this section however, the authors still propose no evidence to suggest how complex phase can represent higher level aspects such as polarity, ambiguity or emotion nor how amplitudes can represent lexical meanings. Instead the authors only go into the mathematical definition of phase and amplitude for a complex number.

This claim is passed off as if it is intuitively obvious. For a model and framework which purpose is for explainability, there's a lack of explanation for these ideas.

### Mathiness

Using Hilbert spaces for machine learning is certainly novel and exotic and I can't help but to see it's _only_ that. I believe that there is a misunderstanding between the mathematical framework in which the authors are using and the _actual_ physics which the mathematical framework was developed for. For example, just because you can apply Hilbert spaces to your problem, it doesn't mean your system exhibits any quantum behaviour. It's like saying that your system exhibits relativistic properties because you use [Einstein notation](https://en.wikipedia.org/wiki/Einstein_notation).

This isn't to say that you can't use Hilbert spaces or complex number spaces for your problem, but by carrying around the quantum mechanics jargon which comes with it, readers might have an issue distinguishing the two.

It's certainly impressive to see [Bra-ket notation](https://en.wikipedia.org/wiki/Bra%E2%80%93ket_notation) throughout the paper, especially to those who have little to no familiarity with quantum mechanics. However bra-ket notation is simply a _convenience_ in notation rather than a new type of mathematics. To put it simply, it's another notation for linear algebra and formulas stated in the paper are simply standard mathematical definitions of linear algebra: dot-products or matrix products with a "different skin". I feel as if the use of bra-ket notation is more to attract the reader, to give the perception of technical depth rather to serve an actual purpose.

<!-- As an example, let's take the definition of measuring a state $\rho$: -->

<!-- \\[p_x(\rho) = \< x \| \rho \| x \> \\]

Remember thought that _bra_ and _ket_ vectors are _just_ vectors. What this equation is saying we're taking the projection of two vectors. Using more conventional notation found in common linear algebra litterature, we can re-write this equation as

\\[ p_x(\rho) = \vec{x} \cdot \rho \vec{x} \\]

<center>or</center>

\\[ p_x(\rho) = \textbf{x}^T \rho \textbf{x} \\] -->

<!-- Physicists use different notation as a matter of convenience. When we simply change the notation, all of a sudden things become more standard and (unfortunately) less impressive. -->

### Misuse of Language

I believe that the paper misuses the language and concepts of quantum mechanics to justify the use of complex-valued spaces. In the Introduction [1], the authors state: "Intuitively, a sentence can be treated as a physical system with multiple words (like particles), and these words are usually polysemous (superposed) and correlated (entangled) with each other."

Let's take a moment to think about this statement. How are words or sentences in the linguistic sense analogous to _physical_ particles like electrons? Similar to explanations from Deepak Chopra, the use of quantum mechanics is abused to fit a particular narrative. Quantum mechanics is simply used to explain physics of particles which are on the quantum scale. Making analogies like these are far-fetched and flat-out unreasonable. By using language to explain quantum physics, it implies that words exhibit quantum phenomena.

Again, I believe it's fine to propose a framework which uses a complex-valued vector space, but it seems as if there is a blending between the mathematical framework which is used and a physics which share that mathematical framework.

The authors even state in the Introduction how "complex values are crucial in the mathematical framework of characterizing quantum physics. [Therefore] to preserve physical properties, the linguistic units have to be represented as complex vectors or matrices". The issue is that linguistics is not a _physical_ property nor is it quantum, so why does it _need_ to preserve physical properties?

In defence of the authors, they reference two papers which suggest that human-cognition and language understanding exhibit quantum-like phenomena [4], [5], but I still believe it's a stretch to relate the cognitive science ideas of "consciousness" with a mathematical framework to model language.

## Final Remarks

I do appreciate the author's efforts in trying to create a tool for explainability. However in CNMs, there was too much of a focus on _how well_ the model worked compared to current methods instead of explainability: _why did it work_? We're drawn to the fancy and exotic bra-ket notation and the allure of quantum mechanics, taking our attention away from the real issues of the paper. Does it really make sense for language to behave as a system of elementary particles? What evidence do the authors provide to support such a claim?

Perhaps the use of complex vector spaces can be useful in that pursuit of explainability. Instead of complex numbers, maybe [quaternions](https://en.wikipedia.org/wiki/Quaternion) or [dual numbers](https://en.wikipedia.org/wiki/Dual_number) can help. As fancy as these things are, they are just mathematical frameworks. Quantum mechanics use Hilbert spaces to explain the physics, but that's all CNMs and quantum mechanics have in common: _the math_.

---

### References

[1] [CNM: An Interpretable Complex-valued network for Matching by Qiuchi Li, Benyou Wang and Massimo Melucci (2019)](https://arxiv.org/abs/1904.05298)

[2] [Troubling Trends in Machine Learning Scholarship by Zachary C. Lipton and Jabob Steinhardt (2018)](https://arxiv.org/abs/1807.03341)

[3] [Artificial Intelligence Meets Natural Stupidity by Drew McDermott (1976)](http://www.cs.yorku.ca/~jarek/courses/ai/F11/naturalstupidity.pdf)

[4] [Quantum Entanglement in Concept Combinations by Diederik Aerts and Sandro Sozzo (2013)](https://arxiv.org/abs/1302.3831)

[5] [Entangling Words and Meaning by Peter Bruza, Kirsty Kitto, Douglas Nelson and Cathy McEvoy (2008)](http://www.users.on.net/~kirsty.kitto/papers/qmWordExperiments.pdf)
