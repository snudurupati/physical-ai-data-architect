# Week 1: Modern Robotics is a Data Engineering Problem

A first look inside a real robot dataset. We download PushT from the Hugging Face Hub, watch an episode in Rerun, then take it apart with DuckDB to see how a row in a Parquet table finds its picture inside an MP4.

## What you need

- macOS or Linux
- [uv](https://docs.astral.sh/uv/)
- [Claude Code](https://claude.com/claude-code)
- The [DuckDB command line](https://duckdb.org/docs/installation/)

No robot needed. PushT is a simulation.

## Setup

In your projects folder, start Claude Code and paste this prompt:

```
Clone https://github.com/snudurupati/physical-ai-data-architect into ~/Projects/paida-wk01.
Check out the tag week-01.
Run uv sync to build the environment from the lockfile.
Confirm that lerobot imports, and print its version.
Do not change any files in the repo.
```

You should see LeRobot 0.4.4.

A note on video decoding: the lockfile excludes TorchCodec on purpose. Its macOS wheel looks for Homebrew's FFmpeg at a fixed path, and breaks when Homebrew moves to a version it doesn't support. Without it, LeRobot falls back to PyAV, which bundles its own FFmpeg. Slower, but the environment is fully defined by `uv.lock`.

## 1. See the data

From the repo folder:

```
uv run lerobot-dataset-viz --repo-id lerobot/pusht --episode-index 0
```

This downloads PushT (first run only) and opens episode 0 in Rerun. Press play, it doesn't autoplay. Watch the `action` and `observation.state` lines: they sit on top of each other until the pusher presses against the block.

## 2. Take it apart

```
cd ~/.cache/huggingface/lerobot/lerobot/pusht
find . -type f
cat meta/info.json
duckdb
```

Then run the queries in [queries.sql](queries.sql), one at a time. Or all at once:

```
duckdb < ~/Projects/paida-wk01/weeks/week-01/queries.sql
```

The LeRobot format splits a dataset into three parts:

| Part | Folder | Format | What's in it |
|---|---|---|---|
| Metadata | `meta/` | JSON, Parquet | The schema, stats, and one row per episode |
| Tabular data | `data/` | Parquet | One row per frame: state, action, timestamp, episode |
| Visual data | `videos/` | MP4 | Camera frames, many episodes packed into one file |

The camera image is listed in `info.json` but is not a Parquet column. A row finds its picture by joining to the episode metadata:

```
video position = episode's from_timestamp + row's timestamp
```

## What this week does not cover

Training a policy, real robot data, or data quality. Those come later. PushT is the easy case: one camera, 10 frames per second, perfect clocks.
