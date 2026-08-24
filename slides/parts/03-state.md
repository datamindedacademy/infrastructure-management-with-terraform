---
layout: section
---

# Terraform State

---
layout: default
label: State
---

# How to remove infrastructure? Easy, just <span class="dm-accent">delete the code</span>!

```hcl
resource "aws_sagemaker_notebook_instance" "notebook-Jane" {
  name          = "notebook-Jane"
  role_arn      = "arn:aws:iam::338791806049:role/notebook_role"
  instance_type = "ml.t2.medium"

  tags = {
    Name = "foo"
  }
}
```

---
layout: default
label: State
---

# State: what is it, and <span class="dm-accent">why</span> do we need it?

<DmColumns class="mt-4">
<DmColumn>

<v-clicks>

- <span class="emoji">🤔</span> How does Terraform know which resources it has to manage? Use Tags? Not every provider has them
- <span class="emoji">🤔</span> How does Terraform know in which order objects depend on each other if it has to delete them?

</v-clicks>

<v-click>

<span class="emoji">💡</span> **State uniquely links resources in code to objects in the Cloud**

</v-click>

</DmColumn>
<DmColumn divider>

<img src="/images/state-what-is-it.png" class="fig fig-sm" alt="State" />

</DmColumn>
</DmColumns>

---
layout: default
label: State
---

# State: <span class="dm-accent">where</span> to store it?

<DmColumns class="mt-4">
<DmColumn header="Locally?" tone="navy">

- OK-ish for quick experimentation <span class="emoji">🧪</span>
- What about security? Passwords?
- What if you accidentally corrupt the file?
- How do you collaborate on infrastructure? State should be single source of truth…

</DmColumn>
<DmColumn divider>

<img src="/images/state-local.png" class="fig fig-sm" alt="Local state" />

</DmColumn>
</DmColumns>

---
layout: default
label: State
---

# State: <span class="dm-accent">where</span> to store it?

<DmColumns class="mt-4">
<DmColumn header="Remotely!" tone="violet">

- More difficult to alter manually
- No sensitive information on local machine
- Optional security features of backend
  - Versioning
  - Encryption
  - Locking for concurrent operations

… To the docs! <span class="emoji">🦇</span>

</DmColumn>
<DmColumn divider>

<img src="/images/state-remote.png" class="fig fig-sm" alt="Remote state" />

</DmColumn>
</DmColumns>

---
layout: default
label: State
---

# Remote backend: <span class="dm-accent">S3</span>

<img src="/images/remote-state-s3.png" class="fig fig-xl" alt="Terraform remote state in an S3 bucket with DynamoDB locking" />
