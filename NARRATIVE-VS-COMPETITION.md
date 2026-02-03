# Why curated docs beat auto-scraped snippets

Other tools in this space auto-scrape GitHub repos, chunk them into fragments, and serve disconnected code snippets through a multi-step resolution flow. The agent guesses the library name, the server returns a pick-list, the agent guesses again, and finally gets back a grab-bag of snippets it has to assemble into understanding. Each round-trip burns thousands of tokens. Users end up manually copying library IDs from a website to skip steps — a workaround for a broken flow.

Context Hub takes a different approach. Docs are curated by humans who understand the library. They're written as coherent documents — structured, complete, and optimized for how an LLM actually reads. One fetch, one document, one ID the agent already knows.

## Full documents, not fragments

A curated doc explains how pieces connect. It provides context, ordering, and narrative — not just scattered code blocks with titles. The agent reads it like a developer would read good documentation: top to bottom, concepts building on each other.

Auto-scraped snippets give you "PRAGMA table_list" next to a Rust worker example next to a raw API reference. The LLM has to guess how they relate. Sometimes it guesses wrong.

## Open and transparent

Our registry is open. Every doc is a markdown file you can read, fork, and modify. The quality pipeline is the content itself — you can see exactly what the agent will see before it sees it.

The alternative is a black box. Content goes into a proprietary pipeline: parsed, chunked, enriched by LLMs, stored in a vector database, reranked at query time. What comes out the other end? "Trust Score: 8." What does that mean? How was it computed? What scale? Nobody outside the company knows.

Documentation for open-source libraries should be open and transparent. Not locked behind opaque scoring systems and proprietary enrichment pipelines.

## Predictable, not probabilistic

`chub get docs cloudflare/durable-objects` — you know what you're getting. The ID is readable. The content is deterministic. The same fetch returns the same doc every time.

Compare: the agent sends "Cloudflare Durable Objects" to a resolve endpoint, gets back five options with auto-generated slugs like `/llmstxt/developers_cloudflare-durable-objects-llms-full.txt`, and picks the one with the highest trust score. Maybe it picks right. Maybe it doesn't. You won't know until you read the output.

## The right place to solve quality

Context7 solves quality at serving time — scoring, ranking, filtering after the fact. Context Hub solves it at authoring time — the doc is good because a human made it good. Curation at the source beats post-hoc ranking of auto-scraped content.
