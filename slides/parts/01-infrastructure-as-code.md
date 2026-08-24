---
layout: section
---

# Infrastructure-as-Code

---
layout: default
label: IaC
---

# The pain of the <span class="dm-accent">Console</span>

<img src="/images/console-pain.gif" class="fig" alt="Clicking through the AWS Console" />

---
layout: default
label: IaC
---

# Creating infrastructure with the <span class="dm-accent">AWS CLI / SDK</span>

<DmColumns class="mt-4">
<DmColumn>

```sh
#!/bin/sh
for i in {1..10}
do
    aws sagemaker create-notebook-instance \
    --instance-type=ml.t2.medium \
    --role-arn=... \
    --notebook-instance-name="notebook-user-$i"
done
```

</DmColumn>
<DmColumn divider>

```py
import boto3

sess = boto3.session.Session()
sm_client = sess.client('sagemaker')

for i in range(10):
    sm_client.create_notebook_instance(
        NotebookInstanceName=f"notebook-user{i}",
        InstanceType="ml.t2.medium",
        RoleArn="...")
```

</DmColumn>
</DmColumns>

---
layout: default
label: IaC
---

# But… what if <span class="dm-accent">something changes</span>?

<DmColumns class="mt-4">
<DmColumn>

<v-clicks>

- Another 20 Data Scientists need an instance
- Some want a more beefy instance type
- A few instances were deleted (by accident?)
- …

</v-clicks>

<v-click>

**… logic easily becomes convoluted**

</v-click>

</DmColumn>
<DmColumn divider>

<img src="/images/what-if-changes.png" class="fig fig-sm" alt="Spaghetti" />

</DmColumn>
</DmColumns>

---
layout: default
label: IaC
---

# The <span class="dm-accent">What</span>, not the How

<DmColumns class="mt-4">
<DmColumn>

- **Declarative** instead of Imperative
- Higher level of abstraction:
  - Easier to reason about (sometimes)
  - Less verbose
- Idempotency <span class="emoji">🤓</span>
- Internal optimization (e.g. SQL, Spark)

</DmColumn>
<DmColumn divider>

<img src="/images/what-not-how.gif" class="fig fig-sm" alt="The what, not the how" />

</DmColumn>
</DmColumns>

---
layout: default
label: IaC
---

```hcl
resource "aws_sagemaker_notebook_instance" "notebook-instance" {
  count         = 10
  name          = "notebook-jan-${count.index}"
  role_arn      = "arn:aws:iam::221917812138:role/dqs-iam-spark-sagemaker-execution-dev"
  instance_type = "ml.t2.medium"

  tags = {
    User = "Jan"
  }
}
```

---
layout: default
label: IaC
---

# Benefits of using <span class="dm-accent">Code</span>...

<DmColumns class="mt-4">
<DmColumn>

- Enables automation...
- … which allows you to scale
- … which is less error prone, faster feedback
- … can serve as documentation

**<span class="emoji">❤️</span> version control:**

- Async collaboration on infrastructure
- Easily roll back to previous versions
- Auditability (`git blame`!) <span class="emoji">🕵️‍♀️</span>

</DmColumn>
<DmColumn divider>

<img src="/images/benefits-of-code.png" class="fig fig-sm" alt="Benefits of code" />

</DmColumn>
</DmColumns>

---
layout: section
---

# Infrastructure-as-Code landscape

---
layout: default
label: Landscape
---

# <span class="dm-accent">Mutable</span> vs <span class="dm-accent">Immutable</span> infrastructure

<img src="/images/mutable-immutable.gif" class="fig fig-xl" alt="Mutable infrastructure deploys v2 to the same machines; immutable provisions new ones" />

---
layout: default
label: Landscape
---

# ... or configuration <span class="dm-accent">management</span> vs. <span class="dm-accent">Cloud Native</span>

<DmColumns class="mt-6">
<DmColumn header="Provision / Provide" tone="navy">

<div class="fig-row mt-4">
  <img src="/images/logos/saltstack.png" alt="SaltStack" />
  <img src="/images/logos/ansible.png" alt="Ansible" />
  <img src="/images/logos/puppet.png" alt="Puppet" />
  <img src="/images/logos/chef.png" alt="Chef" />
</div>

</DmColumn>
<DmColumn header="Provision / Provide" tone="violet" divider>

<div class="fig-row mt-4">
  <img src="/images/logos/docker.png" alt="Docker" />
  <span class="emoji text-3xl">➕</span>
  <img src="/images/logos/terraform.png" alt="Terraform" />
</div>

</DmColumn>
</DmColumns>

---
layout: default
label: Landscape
---

# New (and older) Kids on the <span class="dm-accent">Infrastructure-as-Code</span> Block

<DmComparison
  :rows="['Scope', 'Drift', 'License', 'Language']"
  :cols="[
    '<span class=\'cmp-logos\'><img src=\'/images/logos/terraform-mark.png\'><img src=\'/images/logos/opentofu.png\'></span>Terraform / OpenTofu',
    '<span class=\'cmp-logos\'><img src=\'/images/logos/cloudformation.png\'></span>CloudFormation',
    '<span class=\'cmp-logos\'><img src=\'/images/logos/pulumi.png\'></span>Pulumi',
    '<span class=\'cmp-logos\'><img src=\'/images/logos/crossplane.png\'></span>Crossplane',
  ]"
  class="mt-4 cmp-compact">
<template #r0c0>Multi-cloud</template>
<template #r0c1>AWS</template>
<template #r0c2>Multi-cloud</template>
<template #r0c3>Multi-cloud (k8s)</template>
<template #r1c0>Manual drift detection</template>
<template #r1c1>Manual drift detection</template>
<template #r1c2>Manual drift detection</template>
<template #r1c3>Auto drift reconciliation</template>
<template #r2c0>Open Source</template>
<template #r2c1>Proprietary</template>
<template #r2c2>Open Source</template>
<template #r2c3>Open Source</template>
<template #r3c0>HCL / JSON</template>
<template #r3c1>JSON / YAML<br/><span class="opacity-70">CDK: Python, JS, Java, C#</span></template>
<template #r3c2>Python, Go, .NET, JS</template>
<template #r3c3>Kubernetes manifests (YAML)</template>
</DmComparison>

---
layout: default
label: Landscape
---

# Popularity <span class="dm-accent">contest</span>

<img src="/images/star-history.png" class="fig fig-xl" alt="GitHub star history: terraform, opentofu, crossplane, pulumi, aws-cdk" />

<div class="credit">star-history.com</div>

---
layout: default
label: Background
---

# The <span class="dm-accent">rugpull</span>

<DmColumns class="mt-2">
<DmColumn>

<DmSteps dir="vertical">
<DmStep n="1" label="August 2023">Rugpull by Hashicorp: Mozilla Public License → Business Source License.</DmStep>
<DmStep n="2" label="OpenTofu">A community fork of Terraform, with financial support from Spacelift, env0, Terragrunt, Harness &amp; others, was created.</DmStep>
<DmStep n="3" label="apparentlymart">Joins the OpenTofu project.</DmStep>
<DmStep n="4" label="February 2025">Acquisition of Hashicorp by IBM.</DmStep>
</DmSteps>

</DmColumn>
<DmColumn divider>

<img src="/images/rugpull.gif" class="fig fig-sm" alt="Rugpull" />

</DmColumn>
</DmColumns>
