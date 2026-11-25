# physical-ai-data-architect

An open-source data engine for robot learning. Built in public by a data engineer learning robotics, one week at a time.

## Why this exists

I have spent 18+ years moving data around for a living. Started with dashboards, moved into data warehouses, then Spark, then 5 years at Databricks helping companies build lakehouses. However, the thing that got me into computer science in the first place was never dashboards. It was robots, and the film 2001, A.I. Artificial Intelligence.

So over the last two decades I tried building robots many times. Every time, I ended up tweaking servos, calibrating LIDAR and chasing loose wires, and never got anywhere near the part I cared about: the brain.

Then something changed. Robots stopped being programmed and started being trained. Models like ACT, SmolVLA and the foundation policies coming out of Figure and Tesla learn from demonstrations, and demonstrations are data. Camera frames, joint positions, actions, timestamps, millions of episodes of it, in a dozen different formats.

That's a data engineering problem. And that's the part I know how to do.

## The idea

Think of a robot policy as an apprentice cook learning by watching videos. Show it 1,000 videos where half the cooks pause for 30 seconds, drop the knife, or burn the onions, and it learns to do exactly that. Show it the 500 good ones and it cooks better, with half the footage.

So this repo is about the footage. Specifically:

1. **Ingest:** pull open robot datasets (LeRobot Hub, Open X-Embodiment, DROID) and my own recordings into one schema
2. **Score:** measure every episode for idle frames, jerky actions, dropped frames, timestamp drift and task success
3. **Curate:** filter and weight episodes by quality
4. **Prove it:** train the same policy on all the data vs. the curated data, and compare success rates

## The setup

| Piece | What I'm using |
|---|---|
| Robot arm | Yantra, a Seeed SO-ARM101 Pro leader + follower, pre-assembled ($399) |
| Camera | UGREEN 2K webcam on an 11" magic arm, recording at 640x480, 30fps |
| Simulation | MuJoCo (gym-pusht, gym-aloha) on a MacBook Pro M5 Pro |
| Onboard compute | Raspberry Pi 5, 16GB |
| Data | LeRobot Hub, Open X-Embodiment, DROID |
| Data tooling | Polars, DuckDB, Parquet |
| Policies | ACT (trains on the Mac), SmolVLA (fine-tuned on a rented GPU) |

No custom hardware. Everything is off the shelf, on purpose.

## Status

Weeks 1 to 4 are done (as of November 25, 2026). Week 1 explained what a LeRobot dataset is. Week 2 built the nine-check PySpark profiler and found that community datasets carry empty success labels. Week 3 generated its own dataset: 1,050 PushT episodes on a laptop, 36 of them success-labeled by the physics engine. Week 4 dissected Open X-Embodiment and DROID in their RLDS format and found that the format standardizes storage, not schema. Full ingestion of those sources moved to Week 10, where a training workload needs it. Week 5 starts episode quality scoring.

| Weeks | Focus |
|---|---|
| 1 to 3 | Understand robot data, generate sim data on a laptop |
| 4 to 7 | Ingest, quality scoring, first policy, the curation experiment |
| 8 to 9 | Record real data on Yantra, deploy, watch it fail |
| 10 to 11 | Scale up, run the policy on the Pi 5 |
| 12 to 13 | An LLM planner on top, then a v0.1 release |

Each week has its own folder under [weeks/](weeks/), with a setup prompt and the code from that week's video.

- [Week 1: Modern Robotics is a Data Engineering Problem](weeks/week-01/) — [video](https://youtu.be/l39jyk14hJA)
- [Week 2: Rediscovering the Joy of Data Engineering with Robotics](weeks/week-02/) — [video](https://youtu.be/VwRug6vfmGI)
- [Week 3: I Generated 1,000 Robot Episodes Because I Could Not Write a Policy](weeks/week-03/)
- [Week 4: Two Robot Datasets, One Format, Zero Shared Schemas](weeks/week-04/)

## What this is not

I am not a roboticist. I don't have a robotics degree, and I have never shipped a robot to production. This is not a framework for training policies, and it won't compete with what the big labs have built internally.

It's a data engineer applying what he knows to a field he has wanted to be part of for 20 years, in public, with you as my witness. If the curation experiment shows nothing, I'll say so here.

## License

MIT
