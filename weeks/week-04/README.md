# Week 4: Two Robot Datasets, One Format, Zero Shared Schemas

Open two RLDS datasets and read their real structure. The notebook dissects Columbia PushT (an Open X-Embodiment subset) and DROID. Both use RLDS. Their step schemas share almost nothing.

This week does not convert data. Full ingestion moved to Week 10, where a training workload needs it.

## What you need

- macOS or Linux
- [uv](https://docs.astral.sh/uv/)
- [Claude Code](https://claude.com/claude-code)
- Disk space for the Columbia PushT test split (it downloads on first run)

No robot needed. No GPU needed.

## Setup

In your projects folder, start Claude Code and paste this prompt:

```
Clone https://github.com/snudurupati/physical-ai-data-architect into ~/Projects/paida-wk04.
Check out the tag week-04.
Run uv sync to build the environment from the lockfile.
Check that TensorFlow imports: uv run python -c "import tensorflow_datasets as tfds; print(tfds.__version__)"
Do not change any files in the repo.
```

You should see `4.9.10` or newer. This environment pins TensorFlow 2.21.0.

## Run it

Open `notebooks/01_rlds_dissect.ipynb` in VS Code. Pick the `.venv` kernel. Run top to bottom.

The notebook follows six steps:

1. Find the two builders in the tfds catalog.
2. Read the builder metadata: splits, features, dtypes.
3. Open one episode from the Columbia PushT test split.
4. Open one step and print the real values.
5. Check the camera image.
6. Compare the DROID schema. This step reads metadata only. No DROID episodes download.

## Expected outputs

- Columbia PushT: 136 episodes (122 train, 14 test).
- First test episode: 223 steps.
- Step keys: `observation`, `action`, `reward`, `is_first`, `is_last`, `is_terminal`.
- Action: `world_vector (3,)`, `rotation_delta (3,)`, `gripper_closedness_action ()`, `terminate_episode ()`.
- `world_vector` at step 0 is about 2e-5. These are motion deltas, not pixel targets.
- Images: (240, 320, 3) uint8, cameras `image` and `wrist_image`.
- DROID train split: 95,658 episodes, 3 cameras at 180x320.
- DROID action: `action (7,)` plus `action_dict` with six redundant representations.

## Finding

RLDS standardizes storage. It does not standardize schema.

- Cameras differ: two in Columbia PushT, three in DROID.
- Actions differ: end-effector deltas in Columbia PushT, a 7-vector plus `action_dict` in DROID.
- States differ: a 2-vector in Columbia PushT, joint and Cartesian positions in DROID.
- Label fields differ across the two datasets.

A converter must map each source by hand.

## Notes

- The tfds catalog lists these datasets as community builders. Pass `with_community_datasets=True`.
- The README of RLDS says images are stored as encoded bytes. tfds decodes them while reading.
- The RLDS library is archived. Existing datasets still load. Pin the tfds version.
- Next week: episode quality scoring on `pusht_sim` and the two SO-101 datasets.
