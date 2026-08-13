-- +micrate Up
-- Create snippets table
CREATE TABLE snippets (
  id INTEGER PRIMARY KEY,
  slug VARCHAR(255) NOT NULL UNIQUE,
  name VARCHAR(255) NOT NULL,
  content TEXT NOT NULL,
  crystal_version VARCHAR(255) NOT NULL,
  forked_from INTEGER REFERENCES snippets(id),
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE INDEX idx_snippets_created_at ON snippets(created_at DESC);
CREATE INDEX idx_snippets_forked_from ON snippets(forked_from);

-- +micrate Down
DROP TABLE IF EXISTS snippets;
