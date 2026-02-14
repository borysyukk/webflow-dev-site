# Webflow Dev Site

Astro site with a backup workflow optimized for fast iteration and safe rollback.

## Run Locally

```sh
npm install
npm run dev
```

## Backup Workflow (Recommended)

Professional setup used here:
- meaningful manual checkpoints when you accept changes
- optional autosave snapshots every 10 minutes
- safe restore to a separate branch (no destructive reset)

### 1) Manual checkpoint (best default)

Create a commit at any accepted state:

```sh
npm run checkpoint -- "hero polish approved"
```

Without a message:

```sh
npm run checkpoint
```

### 2) Autosave every 10 minutes (optional)

Install Windows Task Scheduler job:

```sh
npm run autosave:install
```

Remove it:

```sh
npm run autosave:remove
```

Run one autosave manually:

```sh
npm run autosave:once
```

### 3) Restore safely to an older version

Create a new branch from any commit hash:

```sh
npm run restore:branch -- a1b2c3d
```

If you run without a hash, the script shows recent commits:

```sh
npm run restore:branch
```

This restore flow is safe because it does not rewrite your current branch.

## Scripts

- `npm run dev` - start local server
- `npm run build` - production build
- `npm run preview` - preview build
- `npm run checkpoint` - manual backup commit
- `npm run autosave:once` - one autosave commit
- `npm run autosave:install` - schedule autosave every 10 minutes
- `npm run autosave:remove` - remove autosave schedule
- `npm run restore:branch` - open old state in a new branch
