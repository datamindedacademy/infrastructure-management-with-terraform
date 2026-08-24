---
layout: section
---

# Terraform development

---
layout: default
label: Workflow
---

# The Holy <span class="dm-accent">Trinity</span>

<DmComparison :rows="['What it does']" :cols="['Init', 'Plan', 'Apply']" class="mt-4">
<template #r0c0>

- Fetches local copy of provider binary (`!.gitignore`)
- Initialize backend (and change/migrate if needed)
- Fetch child modules (might need to use `-upgrade` flag)

</template>
<template #r0c1>

- Refreshes resources / state
- Linting, static analysis
- Creates an execution plan (can be stored)
- Safety check

</template>
<template #r0c2>

- Refreshes resources / state
- Linting, static analysis
- Creates an execution plan
- Asks to apply or deny changes

</template>
</DmComparison>

<DmBanner class="mt-4"><span class="emoji">💡</span> <code>alias t='terraform/opentofu'</code></DmBanner>

---
layout: default
label: Workflow
---

# … other development <span class="dm-accent">CLI</span> commands

<DmImpact class="mt-6">
<DmImpactRow icon="i-mdi-console" label="console">

REPL (functions, transformations of static input data) <span class="emoji">🧐</span>

</DmImpactRow>
<DmImpactRow icon="i-mdi-broom" label="fmt">

Auto-format your code <span class="emoji">🧹</span>

</DmImpactRow>
<DmImpactRow icon="i-mdi-check-circle-outline" label="validate">

Validate syntax correctness <span class="emoji">✅</span>

</DmImpactRow>
<DmImpactRow icon="i-mdi-export-variant" label="output">

Show terraform outputs of root module <span class="emoji">✅</span>

</DmImpactRow>
</DmImpact>

---
layout: statement
---

# IDEtour

---
layout: default
label: Structure
---

# Repo <span class="dm-accent">structure</span>

<DmColumns class="mt-4">
<DmColumn>

<img src="/images/repo-structure.png" class="fig fig-sm" alt="stage / prod / global environments beside a modules folder" />

</DmColumn>
<DmColumn divider>

<v-clicks>

- Each environment should have its own state(s)
- Environments can be in a single (mono-)repo, or separated in multiple repos
- Modules are (ideally) in a separate repo, where they are versioned separately from the envs

</v-clicks>

<v-click>

If you are just starting/unsure about the scale of your platform, a mono-repo architecture (modules included) is often a solid approach

</v-click>

</DmColumn>
</DmColumns>

---
layout: default
label: Structure
---

# State of the Nation: <span class="dm-accent">Big</span> States vs. <span class="dm-accent">Small</span> states

<img src="/images/us-election-map.png" class="fig fig-xl" alt="Big states versus small states" />

---
layout: default
label: Structure
---

# Medium <span class="dm-accent">blog post</span>

<img src="/images/blog-monostate.png" class="fig" alt="Slaying the Terraform Monostate Beast, by Robbert" />

<div class="credit">Slaying the Terraform Monostate Beast — Dataminded on Medium</div>

---
layout: default
label: Workspaces
---

# Terraform <span class="dm-accent">workspaces</span> are excellent for small experiments

<DmColumns class="mt-4">
<DmColumn>

<v-clicks>

- Basically renames your state file, still use single backend
- Multiple copies in parallel, independent of each other
- Test changes without impacting other infrastructure
- Delete when merging changes

</v-clicks>

</DmColumn>
<DmColumn divider>

<img src="/images/workspaces.jpg" class="fig fig-sm" alt="Pouring concrete" />

</DmColumn>
</DmColumns>

---
layout: statement
---

# IDEtour

---
layout: default
label: State
---

# Passing information between two <span class="dm-accent">states</span>?

<DmColumns class="mt-4">
<DmColumn>

Two common options:

- `terraform_remote_state` data source
- provider-specific data source (e.g. for AWS, `aws_ssm_parameter` is often used)

<v-click>

<span class="emoji">⚠️</span> Remote state can contain sensitive information, so other data source is preferred

</v-click>

</DmColumn>
<DmColumn divider>

<img src="/images/passing-state.jpg" class="fig fig-sm" alt="Handing over a box" />

</DmColumn>
</DmColumns>

---
layout: default
label: Testing
---

# Untested code is <span class="dm-accent">broken</span> code?

<DmColumns class="mt-4">
<DmColumn>

<v-clicks>

- **Junior developer:** here is my code <span class="emoji">😇</span>
- **Senior developer:** did you write tests?
- **Junior developer:** ...
- **Senior developer:**

</v-clicks>

</DmColumn>
<DmColumn divider>

<img src="/images/untested-code.gif" class="fig fig-sm" alt="You shall not pass" />

</DmColumn>
</DmColumns>

---
layout: default
label: Testing
---

# Yeah... but no ... but <span class="dm-accent">yeah</span>

<DmColumns class="mt-6">
<DmColumn header="Terraform / OpenTofu" tone="navy">

- Declarative language for immutable infrastructure ⇒ limited logic
- Static analysis of `terraform plan`
- Integration testing: `terratest`, `kitchen-terraform` (slow, $$$)

</DmColumn>
<DmColumn header="Pulumi" tone="violet" divider>

- Use general programming language of choice for testing logic
- Mocking support for fast unit tests
- Integration testing

</DmColumn>
</DmColumns>

---
layout: default
label: Testing
---

# New since Terraform/OpenTofu <span class="dm-accent">v1.6.0</span>: testing framework

```hcl
# valid_string_concat.tftest.hcl

variables {
  bucket_prefix = "test"
}

run "valid_string_concat" {

  command = plan

  assert {
    condition     = aws_s3_bucket.bucket.bucket == "test-bucket"
    error_message = "S3 bucket name did not match expected"
  }

}
```

---
layout: default
label: Tooling
---

# Other <span class="dm-accent">development</span> tools

<v-clicks>

- Terraform language-server (VSCode), IDE plugin (JetBrains)
- `tfswitch`/`tfenv`: terraform version manager
- [checkov](https://github.com/bridgecrewio/checkov/): static code analyzer (security)
- [tfsec](https://github.com/aquasecurity/tfsec): same purpose as checkov, check for misconfigurations
- [driftctl](https://github.com/cloudskiff/driftctl): check for resources not managed by Terraform
- [terraform-docs](https://github.com/terraform-docs/terraform-docs): create documentation for modules
- [infracost](https://github.com/infracost/infracost): estimate cost of infrastructure

</v-clicks>

---
layout: default
label: Destroy
---

# Finally: <span class="dm-accent">terraform destroy</span>

<img src="/images/terraform-destroy.jpg" class="fig fig-xl" alt="Mushroom cloud" />

---
layout: default
label: Destroy
---

# Cleaning up: <span class="dm-accent">terraform destroy</span>

<img src="/images/cleaning-up.jpg" class="fig fig-xl" alt="Cleaning up" />

---
layout: statement
---

# IDEtour

---
layout: default
label: State surgery
---

# Terraform state manipulation / <span class="dm-accent">surgery</span>

<img src="/images/state-surgery.jpg" class="fig fig-xs" alt="Surgery" />

<DmImpact class="mt-4">
<DmImpactRow icon="i-mdi-transfer" label="state rm">

Transfer management of resource to another team → different state file, **WITHOUT destroying it** — `terraform state rm ref1`

</DmImpactRow>
<DmImpactRow icon="i-mdi-import" label="import">

Click something together in the Console, and manage it afterwards with Terraform — `terraform import ref unique_id`

</DmImpactRow>
<DmImpactRow icon="i-mdi-rename-box" label="state mv">

Refactor your code, **WITHOUT destroying and recreating** resources — `terraform state mv ref1 ref2`

</DmImpactRow>
</DmImpact>

---
layout: statement
---

# IDEtour
