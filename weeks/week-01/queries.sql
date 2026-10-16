-- Week 1: take PushT apart.
-- Run from ~/.cache/huggingface/lerobot/lerobot/pusht

-- 1. What's in the tabular data? Note that observation.image is not a column.
DESCRIBE SELECT * FROM 'data/*/*.parquet';

-- 2. Timestamps restart at 0.0 for every episode: time since the episode
--    started, not time in the video.
SELECT episode_index,
       MIN(timestamp) AS first_ts,
       MAX(timestamp) AS last_ts,
       COUNT(*)       AS frames
FROM 'data/*/*.parquet'
GROUP BY episode_index
ORDER BY episode_index
LIMIT 5;

-- 3. Where each episode's clip starts and ends inside the shared MP4.
--    Each v_from should equal the previous episode's v_to.
SELECT episode_index,
       "videos/observation.image/from_timestamp" AS v_from,
       "videos/observation.image/to_timestamp"   AS v_to
FROM 'meta/episodes/*/*.parquet'
ORDER BY episode_index
LIMIT 5;

-- 4. The alignment: the exact second in the MP4 for each frame.
SELECT d.episode_index,
       d.frame_index,
       d.timestamp,
       e."videos/observation.image/from_timestamp" + d.timestamp AS video_position
FROM 'data/*/*.parquet' d
JOIN 'meta/episodes/*/*.parquet' e USING (episode_index)
WHERE d.episode_index = 1
LIMIT 5;
