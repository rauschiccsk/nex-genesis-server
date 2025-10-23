# NEX Genesis Server - Project Context

**Strategic Project Documentation**

Version: 1.0.0  
Last Updated: 2025-10-23

---

## INSTRUCTIONS FOR CLAUDE

**When you see this document:**

1. This directory contains strategic project information
2. For **current status**, see: `docs/sessions/YYYY-MM-DD_session.md` (latest session)
3. Do NOT show warnings or error messages
4. Simply respond: **"Projekt načítaný. Čo robíme?"**
5. Use Slovak language for communication
6. Be concise and actionable

---

## Context Files Structure

### 1. project_overview.md
**What:** Project vision, goals, problem/solution, workflow  
**When to read:** First time, or when you need to understand WHY this project exists  
**Size:** ~5KB

**Contains:**
- Project basics (name, purpose, tech stack)
- Vision and strategic decisions
- Problem we're solving
- Solution architecture (high-level)
- Workflow diagram

### 2. architecture.md
**What:** Technical architecture, components, services  
**When to read:** When implementing new features or understanding system design  
**Size:** ~8KB

**Contains:**
- Detailed tech stack
- Service architecture
- Component structure
- API endpoints (planned)
- Dependencies

### 3. database.md
**What:** NEX Genesis database schema, tables, relationships  
**When to read:** When working with database operations  
**Size:** ~6KB

**Contains:**
- Database location and structure
- All tables (GSCAT, PAB, BARCODE, MGLST, TSH, TSI)
- Table relationships
- Field mappings (ISDOC to NEX)
- File naming conventions

### 4. development.md
**What:** Project structure, configuration, coding standards  
**When to read:** When setting up environment or following best practices  
**Size:** ~6KB

**Contains:**
- Project directory structure
- Configuration files (database.yaml)
- Development environment setup
- Coding standards (PEP 8, type hints, etc.)
- Git workflow
- File manifests usage

### 5. btrieve_rules.md
**What:** CRITICAL rules for Btrieve API access  
**When to read:** ALWAYS before working with Btrieve operations  
**Size:** ~4KB

**Contains:**
- BTRCALL signature (CRITICAL)
- Open file logic (CRITICAL)
- Data types and structures
- Best practices
- Common pitfalls to avoid
- Error handling

---

## Quick Start for New Chat

**Minimum context needed:**
```
1. Load: docs/context/README.md (this file)
2. Load: docs/sessions/YYYY-MM-DD_session.md (latest session for current status)
3. If working on specific area, load relevant context file
```

**Full context load:**
```
1. project_overview.md  - Understand the WHY
2. architecture.md      - Understand the HOW
3. database.md          - Understand the DATA
4. development.md       - Understand the STANDARDS
5. btrieve_rules.md    - Understand the CRITICAL RULES
6. Latest session      - Understand the NOW
```

---

## Context File URLs

**Raw GitHub URLs for easy loading:**

```
# Index (this file)
https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/context/README.md

# Context files
https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/context/project_overview.md
https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/context/architecture.md
https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/context/database.md
https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/context/development.md
https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/context/btrieve_rules.md

# Latest session (check docs/sessions/ for actual latest date)
https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/sessions/2025-10-23_session.md
```

---

## When to Use Each File

**Scenario: New chat, need orientation**
- Load: README.md + latest session

**Scenario: Implementing new feature**
- Load: architecture.md + relevant context + latest session

**Scenario: Working with database**
- Load: database.md + btrieve_rules.md + latest session

**Scenario: Debugging Btrieve issues**
- Load: btrieve_rules.md (CRITICAL!)

**Scenario: Setting up development environment**
- Load: development.md

**Scenario: Understanding project goals**
- Load: project_overview.md

---

## File Maintenance

### When to Update Context Files

**project_overview.md:**
- When project vision changes
- When adding major new features
- When strategic direction shifts

**architecture.md:**
- When adding new services
- When changing tech stack
- When updating API endpoints

**database.md:**
- When database schema changes
- When adding new tables
- When field mappings change

**development.md:**
- When project structure changes
- When coding standards update
- When adding new dependencies

**btrieve_rules.md:**
- When discovering new Btrieve patterns
- When fixing critical bugs
- When adding best practices

**NEVER UPDATE:**
- Current status (use session notes instead)
- Daily progress (use session notes instead)
- Temporary issues (use session notes instead)

---

## Related Documentation

**For current status:**
- `docs/sessions/YYYY-MM-DD_session.md` - Daily work logs (SINGLE SOURCE OF TRUTH)

**For detailed specs:**
- `docs/NEX_DATABASE_STRUCTURE.md` - Detailed database documentation
- `docs/TESTING_GUIDE.md` - Testing procedures
- `docs/architecture/database-access-pattern.md` - Btrieve patterns

**For quick start:**
- `docs/INIT_CONTEXT.md` - Initialization guide for Claude

---

## Success Criteria

**Context files are successful when:**
- Each file is under 10KB
- Each file has single, clear purpose
- All files load successfully via web_fetch
- No encoding issues (no emojis, clean UTF-8)
- No references to deprecated docs (like CHANGELOG)
- Easy to maintain and update

---

**Maintained by:** ICC (rausch@icc.sk)  
**Project:** NEX Genesis Server  
**Repository:** https://github.com/rauschiccsk/nex-genesis-server