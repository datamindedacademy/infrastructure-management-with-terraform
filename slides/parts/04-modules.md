---
layout: section
---

# Modules

---
layout: default
label: Modules
---

# Modules allow you to create new <span class="dm-accent">abstractions</span> out of existing resources

<DmColumns class="mt-4">
<DmColumn>

<v-clicks>

- A module contains a collection of data structures (resources and data sources) that you want to combine and reuse
- A module is nothing more than a folder of terraform (`.tf`) files. Subfolders are not included (unless used as child modules)

</v-clicks>

</DmColumn>
<DmColumn divider>

<img src="/images/modules.png" class="fig fig-sm" alt="Modules" />

</DmColumn>
</DmColumns>

---
layout: default
label: Modules
---

# <span class="dm-accent">variable</span>, <span class="dm-accent">locals</span>, <span class="dm-accent">output</span>

<img src="/images/inputs-process-outputs.png" class="fig fig-xs" alt="Inputs, process, outputs" />

<DmImpact class="mt-4">
<DmImpactRow icon="i-mdi-import" label="variable">

Inputs to module. For root module, can be passed via CLI or env variables.

</DmImpactRow>
<DmImpactRow icon="i-mdi-function-variant" label="locals">

Local to module. Commonly used for simple transformations of input variables.

</DmImpactRow>
<DmImpactRow icon="i-mdi-export" label="output">

Outputs of module. Can be used as inputs / locals of other modules.

</DmImpactRow>
</DmImpact>

---
layout: statement
---

# IDEtour
