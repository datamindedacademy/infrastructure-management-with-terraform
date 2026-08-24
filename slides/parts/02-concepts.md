---
layout: section
---

# Terraform/OpenTofu concepts

---
layout: default
label: Providers
---

# <span class="dm-accent">Providers</span>

<DmColumns class="mt-4">
<DmColumn>

... provide the *what*, in two flavors:
**Resources & Data Sources**

Plugin system, many providers:

- AWS
- GCP
- Azure
- OpenStack
- …

You can (easily) write your own!

<a href="https://github.com/datamindedacademy/terraform-provider-dataminded" target="_blank"
   class="inline-flex items-center gap-2 mt-3 no-underline">
  <span class="i-mdi-github text-2xl"></span>
  <span>Developing a Terraform provider</span>
</a>

</DmColumn>
<DmColumn divider>

<img src="/images/provider-plugins.png" class="fig" alt="Terraform core talks to provider plugins, which talk to upstream APIs" />

</DmColumn>
</DmColumns>

---
layout: default
label: Providers
---

# <span class="dm-accent">Resources</span> &amp; <span class="dm-accent">Data Sources</span>

<DmColumns class="mt-4">
<DmColumn header="Resources" tone="violet">

Managed by Terraform.

```hcl
resource "aws_s3_bucket" "this" {
  bucket = "my-bucket"
}
```

<img src="/images/crud.png" class="fig fig-xs mt-2" alt="Create, read, update, delete" />

</DmColumn>
<DmColumn header="Data Sources" tone="navy" divider>

**Read-only.** Resource not necessarily managed by Terraform.

```hcl
data "aws_s3_bucket" "existing" {
  bucket = "some-other-bucket"
}
```

<div class="mt-6 text-center text-sm opacity-70">Read, and nothing else.</div>

</DmColumn>
</DmColumns>

---
layout: default
label: API Economy
---

# API <span class="dm-accent">Economy</span>

<img src="/images/api-economy.jpg" class="fig" alt="The API universe across industries" />

<div class="credit">https://www.swyx.io/api-economy/</div>

---
layout: default
label: Docs
---

# To the <s class="opacity-50">Batmobile</s> <span class="dm-accent">Terraform Docs</span>!

<img src="/images/to-the-docs.jpg" class="fig" alt="To the Batmobile" />

---
layout: statement
---

# IDEtour

---
layout: default
label: Workflow
---

<img src="/images/terraform-workflow.png" class="fig fig-xl" alt="Terraform workflow: init, plan, apply, destroy" />
