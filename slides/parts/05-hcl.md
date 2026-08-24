---
layout: section
---

# Hashicorp Configuration Language (HCL)

---
layout: default
label: HCL
---

# Hashicorp Configuration Language <span class="dm-accent">(HCL)</span>

<DmColumns class="mt-4">
<DmColumn header="Types" tone="navy">

- Primitive: `number`, `string`, `bool`, `null`
- Complex: `map`, `list`, `set`, `object`, `tuple`

**Conditionals**

```hcl
condition ? true_val : false_val
```

</DmColumn>
<DmColumn header="Iteration" tone="navy" divider>

- `count` (`count.index`) → resources, data sources
- `for_each` (`each.key`, `each.value`) → resources, data sources
- List comprehensions → variables, locals, outputs

</DmColumn>
</DmColumns>

<DmBanner class="mt-6">Provider-defined Functions v1.8</DmBanner>

---
layout: statement
---

# IDEtour

---
layout: default
label: HCL
---

# Cheat sheet in <span class="dm-accent">repo</span>!

<img src="/images/cheatsheet.png" class="fig" alt="CHEATSHEET.md in the exercise repository" />

---
layout: default
label: HCL
---

# Intermezzo: <span class="dm-accent">meta-arguments</span>

= resource / data source arguments that look like normal arguments, but are Terraform-specific

<DmColumns class="mt-4">
<DmColumn header="Common" tone="violet">

- `count` / `for_each`: iterations

</DmColumn>
<DmColumn header="Rare" tone="navy" divider>

- `depends_on`: explicit dependencies
- `provider`: multiple instances of same provider (e.g. different region)
- `lifecycle`: create-before-destroy, prevent destroy, ignore changes

</DmColumn>
</DmColumns>

---
layout: default
label: HCL
---

# Medium <span class="dm-accent">blog post</span>

<img src="/images/blog-iterables.png" class="fig" alt="Terra-Do's and Terra-Don'ts — a few common issues with Terraform iterables and how to avoid them, by Jan Vanbuel" />

<div class="credit">Terra-Do's and Terra-Don'ts — Jan Vanbuel, Dataminded on Medium</div>

---
layout: default
label: HCL
---

# <span class="dm-accent">Provisioners</span>

<img src="/images/provisioners-docs.png" class="fig" alt="Terraform docs: Provisioners are a Last Resort" />
