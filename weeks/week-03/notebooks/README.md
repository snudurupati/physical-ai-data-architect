# Week 3 notebooks

Setup and run instructions live in `../README.md`.

- `sim_pushTV2.ipynb`: the video demo. Explains the physics and each policy; all cells run in seconds.
- `sim_pushT.ipynb`: the working rollouts and the cells that generate `data/pusht_sim` (~89 min for the diffusion half).
- `01_profiler.ipynb`: the Week 2 profiler, upgraded with per-task statistics and support for videoless datasets and the `is_success` label.
- `results/*.json`: one profiler summary per dataset. The comparison cell reads this folder.
