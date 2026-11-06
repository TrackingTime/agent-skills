#!/usr/bin/env python3
"""Checks every skill: frontmatter, description length, reference links and orphans."""
import re, sys, pathlib
root = pathlib.Path(__file__).resolve().parent.parent
skills = sorted((root / "plugins/trackingtime/skills").glob("tt-*"))
errors = []
for skill in skills:
    text = (skill / "SKILL.md").read_text()
    m = re.match(r"^---\n(.*?)\n---\n", text, re.S)
    if not m:
        errors.append(f"{skill.name}: no frontmatter"); continue
    fm = m.group(1)
    name = re.search(r"^name: (.+)$", fm, re.M)
    desc = re.search(r"^description: (.+)$", fm, re.M)
    if not name or name.group(1).strip() != skill.name:
        errors.append(f"{skill.name}: frontmatter name is {name.group(1) if name else 'missing'}")
    if not desc:
        errors.append(f"{skill.name}: no description")
    elif len(desc.group(1)) >= 1024:
        errors.append(f"{skill.name}: description has {len(desc.group(1))} characters (limit 1024)")
    refs = skill / "references"
    existing = {p.name for p in refs.glob("*.md")}
    body = text + "".join(p.read_text() for p in refs.glob("*.md"))
    mentioned = set(re.findall(r"`?(?:references/)?([a-z0-9-]+\.md)`?", body))
    for ref in re.findall(r"references/([a-z0-9-]+\.md)", text):
        if ref not in existing:
            errors.append(f"{skill.name}: SKILL.md points to references/{ref}, which doesn't exist")
    for f in sorted(existing):
        if f not in set(re.findall(r"([a-z0-9-]+\.md)", text)) and f not in {x for x in mentioned}:
            errors.append(f"{skill.name}: references/{f} is orphaned (nobody points to it)")
# Old agent name must not survive outside intentional places.
allowed = {"README.md", "scripts/check-skills.py"}
for path in root.rglob("*"):
    if path.is_file() and ".git" not in path.parts and "dist" not in path.parts and path.suffix in {".md", ".json", ".sh", ".py"}:
        rel = str(path.relative_to(root))
        for line in path.read_text(errors="ignore").splitlines():
            if re.search(r"office[ -]manager", line, re.I) and rel not in allowed:
                errors.append(f"{rel}: mentions Office Manager: {line.strip()[:90]}")
if errors:
    print("\n".join(errors)); sys.exit(1)
print(f"skills OK ({len(skills)} skills)")
