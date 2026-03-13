# CONTEXT-HUB

Versioned API/reference content hub for coding agents. Provides curated, language-specific documentation with local annotations and feedback loops to reduce hallucination and improve agent performance over time.

## OVERVIEW

Context Hub solves the problem of coding agents hallucinating APIs and forgetting learnings across sessions. It delivers curated, versioned documentation as markdown, supports local annotations that persist across sessions, and collects feedback to improve content quality. The CLI (`chub`) and MCP server (`chub-mcp`) enable agents to search, fetch, and annotate docs programmatically. All content is open and maintained in this repo.

**Tech stack**: Node.js >=18, Commander 12.0.0, Vitest 4.0.18, @modelcontextprotocol/sdk, JavaScript (ESM, no TypeScript compilation).

**Content**: 68 API documentation providers (openai, stripe, anthropic, github, slack, etc.) with language-specific variants (Python, JavaScript, TypeScript, Ruby, C#).

## STRUCTURE

context-hub/
├── cli/
│   ├── bin/
│   ├── skills/
│   ├── src/
│   ├── test/
│   ├── tests/
│   ├── README.md
│   └── package.json
├── content/
│   ├── airtable/
│   ├── amplitude/
│   ├── anthropic/
│   ├── asana/
│   ├── assemblyai/
│   ├── atlassian/
│   ├── auth0/
│   ├── aws/
│   ├── binance/
│   ├── braintree/
│   ├── chromadb/
│   ├── clerk/
│   ├── cloudflare/
│   ├── cockroachdb/
│   ├── cohere/
│   ├── datadog/
│   ├── deepgram/
│   ├── deepl/
│   ├── deepseek/
│   ├── directus/
│   ├── discord/
│   ├── elasticsearch/
│   ├── elevenlabs/
│   ├── firebase/
│   ├── gemini/
│   ├── github/
│   ├── google/
│   ├── hubspot/
│   ├── huggingface/
│   ├── intercom/
│   ├── jira/
│   ├── kafka/
│   ├── landingai-ade/
│   ├── launchdarkly/
│   ├── linear/
│   ├── livekit/
│   ├── mailchimp/
│   ├── meilisearch/
│   ├── microsoft/
│   ├── mongodb/
│   ├── notion/
│   ├── okta/
│   ├── openai/
│   ├── paypal/
│   ├── pinecone/
│   ├── plaid/
│   ├── playwright-community/
│   ├── postmark/
│   ├── prisma/
│   ├── qdrant/
│   ├── rabbitmq/
│   ├── razorpay/
│   ├── redis/
│   ├── replicate/
│   ├── resend/
│   ├── salesforce/
│   ├── sendgrid/
│   ├── sentry/
│   ├── shopify/
│   ├── slack/
│   ├── square/
│   ├── stripe/
│   ├── stytch/
│   ├── supabase/
│   ├── twilio/
│   ├── vercel/
│   ├── weaviate/
│   └── zendesk/
├── docs/
│   ├── features/
├── AGENTS.md
├── README.md
├── package.json

## WHERE TO LOOK

| Task | Path | Notes |
|------|------|-------|
| CLI entry point | `cli/src/index.js` | Commander setup, command registration |
| Search implementation | `cli/src/commands/search.js` | Fuzzy search, tag filtering |
| Fetch docs | `cli/src/commands/get.js` | Language variants, incremental fetch |
| Annotations | `cli/src/commands/annotate.js` | Local notes, persistence |
| Feedback | `cli/src/commands/feedback.js` | Upvote/downvote, labels |
| MCP server | `cli/src/mcp/` | Model Context Protocol integration |
| Content providers | `content/` | 68 API doc providers (markdown) |
| Agent skill template | `cli/skills/get-api-docs/SKILL.md` | Claude Code skill example |
| CLI reference | `docs/cli-reference.md` | Full command list, flags, piping |
| Content guide | `docs/content-guide.md` | Contribution format, structure |

## COMMANDS

```bash
# Install
npm install -g @aisuite/chub

# Search and fetch
chub search openai                      # fuzzy search
chub get openai/chat --lang py          # fetch Python variant
chub get stripe/api --lang js -o doc.md # save to file

# Annotations (local, persist across sessions)
chub annotate stripe/api "Webhook needs raw body"
chub annotate --list
chub annotate stripe/api --clear

# Feedback (sent to maintainers)
chub feedback openai/chat up
chub feedback stripe/api down --label outdated

# Cache and registry
chub update                             # refresh registry
chub cache status
chub cache clear

# Build (for maintainers)
chub build content/ -o dist/

# Development
npm install                             # install dependencies
npm test                                # run vitest
npm run test:coverage                   # coverage report
```

## CONVENTIONS

**Code style**: JavaScript ESM, Node.js >=18, strict mode, no TypeScript compilation.

**Commands**: Commander 12.0.0 for CLI, Vitest 4.0.18 for tests.

**Content format**: Markdown with YAML frontmatter, language-specific variants via `--lang` flag.

**Annotations**: Local-only, stored in `~/.chub/`, appear automatically on future fetches.

**Feedback**: Upvote/downvote with optional labels, sent to doc authors for quality improvement.

**MCP integration**: `chub-mcp` binary provides Model Context Protocol server for agent tooling.

**Commit format**: `type(scope): description` (e.g., `feat(cli): add --full flag`, `docs(content): update openai/chat`).

**Testing**: Vitest, colocated `*.test.js` files.

## ANTI-PATTERNS

| Forbidden | Why |
|-----------|-----|
| Hardcoded API keys in content | Security risk, use placeholders |
| Committing `node_modules/` | Bloat, use `npm install` |
| Skipping `--lang` for docs | Language-specific variants required |
| Editing `dist/` manually | Generated by `chub build`, overwritten |
| Using `any` in JSDoc types | Type safety required |
| Blocking I/O in async context | Use async/await patterns |
| Mixing static and dynamic imports | Causes module resolution issues |
| Annotations without user consent | Privacy, local-only by design |
| Feedback without user approval | Privacy, sent to maintainers |
| Listing all 68 providers in docs | Bloat, use `chub search` instead |
