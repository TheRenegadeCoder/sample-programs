---
title: Job Sequencing with Deadlines in Every Language
layout: default
date: 2018-11-03
last-modified: 2018-11-03
featured-image:
tags: [job-sequencing]
authors:
  - the_renegade_coder
---

Job sequencing is an optimization problem where the goal is to maximize the
profit earned by completing jobs. In this particular rendition of the problem,
jobs have both a profit and a deadline, and all jobs can be completed in the
same amount of time:

| Job      | J1  | J2  | J3  | J4  |
| -------- | --- | --- | --- | --- |
| Profit   | 25  | 15  | 10  | 5   |
| Deadline | 3   | 1   | 2   | 2   |

In this example, we have four jobs sorted by largest profit first.
Using the greedy method, we can come up with the best sequence by
choosing the job with the current highest profit and scheduling it
at the last possible moment. In this case, we would end up with the
following sequence:

> J2, J3, J1

Because the last possible job we can choose has a deadline of 3, we can
only select 3 jobs at most for our sequence. As a result, we cannot
complete J4. In total, we can make a profit of 40.
