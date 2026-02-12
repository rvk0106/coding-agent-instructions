# Context retrieval (vector DB / reduced structure)

> **Goal:** Give the agent more and better context without sending more tokens. Use retrieval or a compact index so only relevant chunks are loaded per task.

When the project has a **vector store** or a **reduced context index**, use that first. Fall back to file-by-file loading via `context-router.md` when retrieval is not available.

---

## Why use retrieval or reduced structure?

- **Token limit:** Full knowledge files (architecture, infrastructure, features) can exceed context windows.
- **Relevance:** Only the slices relevant to the current task need to be in context.
- **Scale:** As docs grow, retrieval keeps context size bounded while still allowing "more" knowledge.

---

## Option A: Vector DB (embeddings + semantic search)

### How it works
1. **Index:** Chunk the knowledge files (`architecture/`, `infrastructure/`, `features/`, and key `workflow/` content). Embed each chunk; store chunks + metadata in a vector store.
2. **Query:** For each task (planning, execution, etc.), form a short query (e.g. task type + ticket title or summary). Retrieve the top-k most relevant chunks.
3. **Context:** Send only the retrieved chunks to the agent instead of whole files.

### What to store
- **Source:** Same content as the markdown knowledge files (after onboarding/maintenance).
- **Chunks:** By section or by semantic boundary (e.g. 300-600 tokens, overlap optional). Preserve headings so the agent knows the topic.
- **Metadata (per chunk):** `source` (e.g. `architecture/public-api.md`), `section`, optional `task_types` (e.g. `["new_feature", "bug_fix"]`) for hybrid filter + vector search.

### When to re-index
- After **project onboarding** (initial fill of knowledge files).
- After **maintenance** updates (any change to `architecture/`, `infrastructure/`, or `features/` per `workflow/maintenance.md`).

### Agent behavior when vector store is available
- **Do not** load full files from the context-router list.
- **Do** use the retrieval API or tool provided (e.g. "query project knowledge with: task type + ticket summary").
- Use the **returned chunks** as the "Context loaded" for the current step; cite source and section in the plan or reply.
- If retrieval returns nothing for a critical topic, fall back to loading that file once or ask the user.

### Typical setup (implementation-agnostic)
- **Embeddings:** Any embedding API or model (OpenAI, Cohere, local model, etc.).
- **Vector store:** Chroma, Pinecone, pgvector, LanceDB, or similar (local or hosted).
- **Location:** Index can live under `agent/vector_store/` (e.g. Chroma DB on disk), or in a separate service; document the query interface in `agent-config.md` or README.

---

## Option B: Reduced structure (compact index)

### How it works
1. **Index file:** Maintain a single compact file (e.g. `agent/context-index.yaml` or `agent/context-index.json`) that lists every knowledge unit with:
   - **id** (e.g. `architecture.public-api.exports`)
   - **summary** (1-3 sentences)
   - **file** + **section** or **line range**
   - optional **task_types** or **tags**
2. **Two-step load:** Agent (or the system) reads the small index first. For the current task type and ticket, select relevant ids; then load only those sections (or files) instead of everything.
3. **Context:** Send only the selected sections to the agent.

### When to regenerate
- After **onboarding** and after **maintenance** updates, regenerate the index from the current knowledge files (script or manual pass).

### Agent behavior when reduced index is available
- **Do** load the **index file** first (it is small).
- **Do** select entries relevant to the current task type and ticket (by summary/tags).
- **Do** load only the **pointed sections or files** for those entries; use them as "Context loaded".
- Fall back to context-router file list if the index is missing or stale.

---

## Single source of truth

- The **markdown knowledge files** remain the source of truth (filled in onboarding, updated in maintenance).
- Vector store or reduced index are **derived** from those files and must be refreshed when they change.
- Do not edit the vector DB or index as the primary store; always edit the markdown files, then re-index or regenerate.

---

## When retrieval is not available

If the project has no vector store and no reduced index:
- Use **`workflow/context-router.md`** as today: read the router, then load only the files it lists for the current task type and workflow state.
- Keep knowledge in the markdown files under `architecture/`, `infrastructure/`, `features/`, and `workflow/`.

---

## Summary

| Setup              | Agent behavior |
|--------------------|----------------|
| Vector DB present  | Query by task + ticket; use returned chunks as context; cite source/section. |
| Reduced index only | Load index -> select relevant entries -> load only those sections/files. |
| Neither            | Use context-router.md and load only the files it specifies for the task. |

This keeps the same workflow (plan -> execute -> verify -> maintain) while allowing more context to be available to the agent without proportionally increasing tokens.
