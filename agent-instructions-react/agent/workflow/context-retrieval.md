# Context retrieval (vector DB / reduced structure)

> **Goal:** Give the agent more and better context without sending more tokens.

When the project has a **vector store** or a **reduced context index**, use that first. Fall back to file-by-file loading via `context-router.md` when retrieval is not available.

## Option A: Vector DB (embeddings + semantic search)
1. **Index** knowledge files into vector store (chunk by section, ~300-600 tokens)
2. **Query** by task type + ticket summary
3. **Use** retrieved chunks as context

### When to re-index
- After project onboarding (initial fill)
- After maintenance updates to knowledge files

## Option B: Reduced structure (compact index)
1. Maintain `agent/context-index.yaml` listing each knowledge unit with id, summary, file, section
2. Agent reads index → selects relevant entries → loads only those sections

## When retrieval is not available
Use `workflow/context-router.md` as the fallback.

## Summary
| Setup | Agent behavior |
|-------|----------------|
| Vector DB present | Query by task + ticket; use returned chunks |
| Reduced index only | Load index → select → load sections |
| Neither | Use context-router.md |
