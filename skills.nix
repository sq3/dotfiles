{ lib, inputs, ... }:
let
  # flake input -> { skill name = path inside the repo }
  skills = {
    mattpocock-skills = {
      ask-matt = "skills/engineering/ask-matt";
      code-review = "skills/engineering/code-review";
      codebase-design = "skills/engineering/codebase-design";
      diagnosing-bugs = "skills/engineering/diagnosing-bugs";
      domain-modeling = "skills/engineering/domain-modeling";
      grill-with-docs = "skills/engineering/grill-with-docs";
      implement = "skills/engineering/implement";
      improve-codebase-architecture = "skills/engineering/improve-codebase-architecture";
      prototype = "skills/engineering/prototype";
      research = "skills/engineering/research";
      setup-matt-pocock-skills = "skills/engineering/setup-matt-pocock-skills";
      tdd = "skills/engineering/tdd";
      to-spec = "skills/engineering/to-spec";
      to-tickets = "skills/engineering/to-tickets";
      triage = "skills/engineering/triage";
      wayfinder = "skills/engineering/wayfinder";
      grill-me = "skills/productivity/grill-me";
      grilling = "skills/productivity/grilling";
      handoff = "skills/productivity/handoff";
      teach = "skills/productivity/teach";
    };
    anthropic-skills.skill-creator = "skills/skill-creator";
    jeffallan-skills.kubernetes-specialist = "skills/kubernetes-specialist";
    vercel-skills.find-skills = "skills/find-skills";
    orca.orchestration = "skills/orchestration";
  };

  flat = lib.concatLists (lib.mapAttrsToList
    (input: set: lib.mapAttrsToList (name: path: { inherit name; source = "${inputs.${input}}/${path}"; }) set)
    skills);

  # ~/.agents/skills is read by Codex, opencode and others; Claude Code reads ~/.claude/skills
  linkInto = dir: lib.listToAttrs (map (s: lib.nameValuePair "${dir}/${s.name}" { inherit (s) source; }) flat);
in
{
  home.file = linkInto ".agents/skills" // linkInto ".claude/skills";
}
