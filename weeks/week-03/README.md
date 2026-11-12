# Week 3: I Generated 1,000 Robot Episodes Because I Could Not Write a Policy

Write your own robot dataset. We roll three policies in the PushT simulator (gym_pusht, Pymunk), write the episodes as a LeRobot dataset with ground-truth success labels, and profile the result with the nine checks from Week 2. The generated dataset holds 1,050 episodes: 1,000 from a random policy (0 successes) and 50 from a published diffusion checkpoint (36 successes).

## What you need

- macOS or Linux
- [uv](https://docs.astral.sh/uv/)
- [Claude Code](https://claude.com/claude-code)
- Java 17 or newer (Spark runs on Java)

No robot needed. The simulator is the robot.

## Setup

In your projects folder, start Claude Code and paste this prompt:

```
Clone https://github.com/snudurupati/physical-ai-data-architect into ~/Projects/paida-wk03.
Check out the tag week-03.
Run uv sync to build the environment from the lockfile.
Check that Java 17 or newer is installed (java -version) and print the path JAVA_HOME points to. If Java is missing, do not install anything, just tell me.
Download the checkpoint: uv run hf download lerobot/diffusion_pusht --local-dir weeks/week-03/model/diffusion_pusht
Migrate it for 0.4.4: uv run python -m lerobot.processor.migrate_policy_normalization --pretrained-path weeks/week-03/model/diffusion_pusht --output-dir weeks/week-03/model/diffusion_pusht_migrated
Do not change any files in the repo.
```

You should see `model/diffusion_pusht_migrated/` with `policy_preprocessor.json` and `policy_postprocessor.json`. Those two files are the fix for a silent failure: the checkpoint predates the 0.4.4 processor system, so without them `select_action` drops the normalization buffers and every rollout scores zero.

The generated dataset is not in git (`data/` and model weights are gitignored). You rebuild it by running the notebooks below.

## Run it

Three notebooks, all in `notebooks/`. Open one in VS Code, pick the `.venv` kernel, run top to bottom. Set `WEEK` in each setup cell to your checkout path.

- `sim_pushTV2.ipynb`: the demo from the video. Environment facts, random baseline, cowboy policy, the dataset schema, and the dataset totals. Everything runs in seconds except the two generation cells, whose outputs are printed for reference.
- `sim_pushT.ipynb`: the working rollouts. This is where the dataset is actually generated. Budget ~436 s for 1,000 random episodes and ~89 minutes for 50 diffusion episodes (~106 s each). Lower `N_DIFFUSION` if time is tight.
- `01_profiler.ipynb`: the Week 2 profiler, upgraded. Checks now run per task (percentiles, IQR, fences per generator, not pooled), checks D and H skip cleanly on videoless datasets, and check I reads the simulator's `is_success`. Point `REPO_ID`/`ROOT` at your generated dataset; the summary writes `notebooks/results/pusht_sim.json`, and the comparison cell puts it beside the two SO-101 profiles.

Expected outputs:

- random policy: `0/100 successes, mean failure length 300`
- cowboy policy margin 40: `0/100`, block never moves; margin 10: `0/100`, the T spins (torque, no friction)
- official eval (`lerobot_eval`, 5 episodes, ~8 min): `pc_success: 60.0` — the checkpoint README reports 65.4 on 500 episodes
- profiler: random 1,000 eps / 300,000 frames / 0 successes; diffusion 50 eps / 10,759 frames / 36 successes

## Notes

- Pre-run the generation cells. Do not record a 89-minute cell.
- `task` in the dataset records which policy produced each frame. Profiling by `task` is the whole lesson: pooled percentiles over both generators describe neither (random is a spike at the 300-step limit; diffusion spreads 80 to 300, and the short tail is the successes).
- The SO-101 recordings from the first half of Week 3 profile to `notebooks/results/*.json`. Both carry `success_episodes: null`. That empty column is why this dataset exists.
- Next week: Open X-Embodiment and DROID ingest. The promised follow-up on this dataset: drop the 1,000 random episodes, re-profile, train before and after.
