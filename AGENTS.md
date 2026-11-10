# AGENTS.md

Working notes for AI coding agents in this repo. Single source of truth for agent instructions; per-tool instruction files (CLAUDE.md and friends) are retired deliberately.

## What this repo is

A 13-week public build (Oct–Dec 2026) of a robot-learning **data engine**: ingest, profile, curate, and prove that curating data improves policy training. Read `README.md` for the thesis. The author is a senior data engineer new to robotics, learning in public.

## Environment

- Python 3.11 via `uv`. Setup is `uv sync`; run everything with `uv run ...`.
- `uv.lock` deliberately excludes TorchCodec (its macOS wheel breaks on Homebrew FFmpeg moves). LeRobot falls back to PyAV. Do not "fix" this by adding TorchCodec.
- PySpark notebooks need Java 17+. If Java is missing, report it; do not install anything.
- `lerobot==0.4.4` (with `[feetech]`). Do not upgrade it mid-week; weekly videos are pinned to it.

## Layout and conventions

- One folder per week: `weeks/week-NN/` with a `README.md` (setup prompt + how to run) and `notebooks/`.
- The week's setup prompt clones a **tag** (`week-NN`) and expects `Do not change any files in the repo`. Tags are append-only history: never move, re-point, or delete a `week-*` tag.
- `weeks/week-02/notebooks/01_profiler.ipynb` is the canonical reusable profiler (nine checks A–I, PySpark). Later weeks build on it, they don't fork it.
- Per-dataset profiler summaries land in `notebooks/results/<dataset>.json`; the comparison cell reads that folder.

## Writing style (mandatory, all output)

- Write in ASD-STE100 Simplified Technical English. Short sentences. One idea per sentence.
- Active voice only. Name the actor: "You set fps", not "fps should be set" or "fps is chosen".
- Plain technical words. No idioms, no metaphor, no figurative language, no rhetorical flourishes.
- No decorative adjectives or adverbs ("fiction", "wastes days", "demystifies"). No jokes.
- Use the exact term from the tool or API. Define a term the first time it appears in a message.
- Imperative for instructions: "Run this.", "Print the shape."
- Numbers and units plain and explicit.
- This rule overrides any instinct to sound natural or engaging. It applies to every session.
- Be brief. Answer in the fewest sentences that stay correct. No restating the question, no summary paragraphs of what was just said, no tables unless comparison is the content.

## Working with the author

- The author is learning robotics by doing. Default to coaching: short, interactive guidance, one step at a time, questions that make them reason. Do not write exercise or build code unless they explicitly ask.
- Never skip a step they have not done before. They have no gym, MuJoCo, or pygame background. Name every object before using it. Show the full line, not `...`.
- Their private vault (Obsidian "Buddhi" → `Projects/Mara-Manishi`) holds the real Plan.md and the living Status.md. Status.md overrides Plan.md on any conflict. Never edit vault files unless they explicitly ask.
- Lead with the answer. Short bullets. One question at a time. Push back honestly when they are wasting time.
- Never ask them a question the repo already answers. Before asking about a dataset fact, read the profiler JSON in `weeks/week-NN/results/<dataset>.json` and the notebook that produced it. The JSON is the record of what they measured. If the record does not support a claim, state the fact once, in one sentence, and move on. Never repeat that question.
- Do not assume the author's gender. Use they/them in all notes, comments, and logs unless they state otherwise.
