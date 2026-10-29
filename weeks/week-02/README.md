# Week 2: Rediscovering the Joy of Data Engineering with Robotics

Profile a robot dataset with nine checks (A to I), form a hunch, and let the data answer. We run one PySpark notebook on two simulated datasets: `lerobot/pusht` and `lerobot/aloha_sim_insertion_human`.

## What you need

- macOS or Linux
- [uv](https://docs.astral.sh/uv/)
- [Claude Code](https://claude.com/claude-code)
- Java 17 or newer (Spark runs on Java)

No robot needed. Both datasets are simulations.

## Setup

In your projects folder, start Claude Code and paste this prompt:

```
Clone https://github.com/snudurupati/physical-ai-data-architect into ~/Projects/paida-wk02.
Check out the tag week-02.
Run uv sync to build the environment from the lockfile.
Check that Java 17 or newer is installed (java -version) and print the path JAVA_HOME points to. If Java is missing, do not install anything, just tell me.
Load lerobot/pusht and then lerobot/aloha_sim_insertion_human with LeRobotDataset (from lerobot.datasets.lerobot_dataset import LeRobotDataset) so both download. Print num_episodes and num_frames for each.
Do not change any files in the repo.
```

You should see `206 25650` for PushT and `50 25000` for aloha.

## Run it

Two notebooks, both in `notebooks/`:

- `profiler.ipynb`: the demo from the video. Runs top to bottom with a config cell per dataset, so there is nothing to edit.
- `02_profiler.ipynb`: the reusable profiler. This is the one to use on other datasets in later weeks. Change `REPO_ID` in the config cell.

Open one in VS Code, pick the `.venv` kernel, and run top to bottom.

Demo parts:

- Part 4: the nine checks on PushT
- Part 5: a hunch about reward
- Part 6: the same checks on ALOHA
- Part 7: a hunch about the end of each episode
- Part 8: summary table (reads `notebooks/results/*.json`)

## Notes

- Both datasets are simulations. The real SO-101 arm is next week.
- Older profiler drafts (v1 and v3) are in `../week-01/notebooks/archive/`.
