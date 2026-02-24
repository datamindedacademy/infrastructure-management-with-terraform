# Feature Gap Analysis: Terraform & OpenTofu

This document lists notable features added to Terraform (1.10–1.14) and OpenTofu (1.7–1.12) that are **not currently covered** by the exercises, and proposes new exercises for the most impactful ones.

## Current Exercise Coverage

| # | Topic | Key Concepts |
|---|-------|-------------|
| 00 | Provider config | Provider blocks, credentials |
| 01 | Provider version | Version constraints, lock files |
| 02 | Remote backend | S3 backend, state locking |
| 03 | Refactoring | Code organization, file splitting |
| 04 | Modules | Module authoring, inputs/outputs |
| 05 | Count / for_each | Iteration over resources and modules |
| 06 | Existing infra | Debugging brownfield projects |
| 07 | Conditional infra | Ternary operator, conditional deployment |
| 08 | Passing state | Remote state data source, SSM parameters |
| 09 | State manipulation | `removed`, `import`, `moved` blocks; CLI state commands |
| 10 | Seek and destroy | `tofu destroy`, cleanup |
| Extra | CI/CD | GitHub Actions pipeline |

---

## Notable New Features Not Covered

### Tier 1 — High Impact (recommended for new exercises)

#### 1. Native Testing Framework (`tofu test` / `terraform test`)
**Available since:** Terraform 1.6, OpenTofu 1.6+
**What it is:** Write tests in HCL (`.tftest.hcl` files) that validate your modules using `plan` (unit tests) or `apply` (integration tests). Supports assertions, helper modules, mocking/overrides (OpenTofu), and JUnit XML output for CI.
**Why it matters:** Testing is a fundamental software practice and completely absent from the exercises. The native framework requires no external tools (unlike Terratest or Kitchen-Terraform) and uses the same HCL syntax students already know. Since 1.11, Terraform also supports `state_key`, `override_during = plan`, and `-junit-xml` for CI integration.

#### 2. Ephemeral Values (Variables, Outputs, Resources)
**Available since:** Terraform 1.10, OpenTofu 1.11
**What it is:** A new category of values that exist only in memory during a single plan/apply phase and are **never persisted** in state or plan files. Includes ephemeral input variables, ephemeral output values, and ephemeral resource types (e.g. `ephemeral "aws_secretsmanager_secret_version"`).
**Why it matters:** Directly addresses the long-standing security concern of secrets in state files. Providers like AWS and Azure already ship ephemeral resource types for secrets managers and key vaults. Write-only arguments (Terraform 1.11, OpenTofu 1.11) extend this to managed resources.

#### 3. State Encryption (OpenTofu-exclusive)
**Available since:** OpenTofu 1.7
**What it is:** Client-side encryption of state files using configurable key providers (PBKDF2, AWS KMS, GCP KMS, external programs). Configured directly in the `terraform` block.
**Why it matters:** State files often contain sensitive data (database passwords, access keys). State encryption is one of OpenTofu's flagship differentiating features and a major reason organizations adopt it.

#### 4. Early Variable/Local Evaluation (OpenTofu-exclusive)
**Available since:** OpenTofu 1.8
**What it is:** Variables and locals can now be used in `backend` configurations and `module` source/version arguments — contexts that were previously hardcoded.
**Why it matters:** This was the most-requested feature in the OpenTofu community for years. It enables truly DRY multi-environment setups (e.g. `tofu init -var-file=prod.tfvars` pointing to different backends) and centralized module version management.

#### 5. The `enabled` Meta-Argument (OpenTofu-exclusive)
**Available since:** OpenTofu 1.11
**What it is:** A `lifecycle { enabled = <bool> }` meta-argument that offers a cleaner alternative to the `count = condition ? 1 : 0` pattern for conditional resource creation.
**Why it matters:** Exercise 07 teaches the ternary `count` trick. The `enabled` meta-argument is the modern, more readable replacement. Covering both in the same exercise lets students compare approaches.

---

### Tier 2 — Medium Impact (good additions when expanding the course)

#### 6. Provider-Defined Functions
**Available since:** Terraform 1.8, OpenTofu 1.7
**What it is:** Providers can now expose custom functions callable as `provider::providername::function_name()`. For example, `provider::aws::arn_parse()` or `provider::terraform::encode_expr()`.
**Why it matters:** Extends HCL's built-in function library with provider-specific logic. Useful in real-world projects for parsing ARNs, encoding expressions, etc.

#### 7. Provider `for_each`
**Available since:** OpenTofu 1.9
**What it is:** The `for_each` meta-argument can be used on `provider` blocks, enabling dynamic multi-region or multi-account deployments.
**Why it matters:** A common real-world pattern. Previously required manual duplication of provider blocks.

#### 8. Native S3 State Locking (OpenTofu)
**Available since:** OpenTofu 1.10
**What it is:** S3 backend now supports native state locking without requiring a DynamoDB table.
**Why it matters:** Exercise 02 sets up an S3 backend. Mentioning native locking (no DynamoDB) would be a simple but valuable update for OpenTofu users.

#### 9. `terraform query` / List Resources
**Available since:** Terraform 1.14
**What it is:** A new `terraform query` command that executes list operations against existing infrastructure using `.tfquery.hcl` files. Allows querying and filtering real cloud resources outside of state.
**Why it matters:** A new paradigm for exploring existing infrastructure, complementary to `data` sources.

#### 10. Import Improvements
**Available since:** Terraform 1.12 (identity-based import), OpenTofu 1.7 (loopable `for_each` import blocks)
**What it is:** Import blocks can now use `for_each` to bulk-import resources, and Terraform 1.12 adds identity-based import as an alternative to string IDs.
**Why it matters:** Exercise 09 already covers import, but the `for_each` enhancement is a significant workflow improvement for brownfield adoption.

---

### Tier 3 — Niche / Advanced (optional enrichment)

| Feature | Source | Since | Notes |
|---------|--------|-------|-------|
| Stacks (`terraform stacks`) | Terraform 1.13 | Aug 2025 | Multi-deployment orchestration; HCP Terraform dependent |
| `-exclude` flag | OpenTofu 1.9 | Late 2024 | Inverse of `-target` |
| OCI registry support | OpenTofu 1.10 | Jun 2025 | Distribute providers/modules via container registries |
| Deprecation support for module I/O | OpenTofu 1.10 | Jun 2025 | Mark variables/outputs as deprecated |
| `moved` block cross-type migration | OpenTofu 1.9 | Late 2024 | Move from `null_resource` → `terraform_data` |
| Deferred actions (experimental) | Terraform 1.9+ | 2024 | `count`/`for_each` with unknown values |
| `destroy` lifecycle meta-argument | OpenTofu 1.12 | 2026 | Control resource destruction behavior |

---

## Suggested New Exercises

### Exercise 11: Testing Your Infrastructure (`tofu test`)

**Concept:** Native HCL testing framework
**Prerequisites:** Exercises 04 (modules) and 07 (conditional infrastructure)

**Instructions:**

> Your team lead wants to ensure that the `secure_notebook` module from exercise 04 works correctly before anyone deploys it. Write tests for this module using the native testing framework.
>
> 1. Create a `tests/` directory with a `secure_notebook.tftest.hcl` file.
> 2. Write a **unit test** (using `command = plan`) that asserts:
>    - The notebook instance type matches the input variable
>    - The security group allows SSH (port 22) from the specified IP
> 3. Write a second run block that tests the module with different input values.
> 4. **(Bonus — OpenTofu only):** Use `mock_provider` or `override_resource` to run the tests without needing real AWS credentials.
> 5. **(Bonus):** Add the `-junit-xml` flag to produce a test report, and integrate it into the CI/CD pipeline from the extra exercise.
>
> Run your tests with `tofu test` and verify they pass.

**Why this exercise:** Testing is a foundational practice absent from the current curriculum. It reinforces module authoring (ex 04) and naturally ties into CI/CD (extra exercise).

---

### Exercise 12: Secrets That Don't Stick (Ephemeral Values & Write-Only Arguments)

**Concept:** Ephemeral variables, ephemeral resources, write-only arguments
**Prerequisites:** Exercise 02 (remote backend), exercise 07 (conditional infra)

**Instructions:**

> In exercise 07, the S3 bucket used a KMS key for encryption. But what about the database password your team uses for the RDS instance? Currently it's stored in plaintext in the state file. Let's fix that.
>
> 1. Create an AWS Secrets Manager secret (via the console or CLI) containing a database password.
> 2. Use an **ephemeral resource** (`ephemeral "aws_secretsmanager_secret_version"`) to read the password at plan/apply time without persisting it in state.
> 3. Declare an **ephemeral variable** for the database master password and mark an output as ephemeral.
> 4. Pass the ephemeral value to an `aws_db_instance` resource using a **write-only argument** (available since Terraform 1.11 / OpenTofu 1.11).
> 5. Run `tofu apply`, then inspect the state file (`tofu state show`). Verify that the password is **not** stored in state.
> 6. **(Discussion):** What are the trade-offs of ephemeral values? What happens if the secret is rotated?

**Why this exercise:** Secrets in state is one of the most common real-world security concerns. This exercise teaches the modern solution.

---

### Exercise 13: Encrypt Your State (OpenTofu State Encryption)

**Concept:** Client-side state encryption
**Prerequisites:** Exercise 02 (remote backend)
**Note:** OpenTofu only

**Instructions:**

> Your security team requires that all state files are encrypted at rest using keys your organization controls — not just the server-side encryption provided by S3. OpenTofu's state encryption feature lets you do this.
>
> 1. Start with the S3 backend from exercise 02.
> 2. Add a `terraform` block with state encryption using the **PBKDF2 key provider** and **AES-GCM** encryption method:
>    ```hcl
>    terraform {
>      encryption {
>        key_provider "pbkdf2" "my_passphrase" {
>          passphrase = var.state_passphrase
>        }
>        method "aes_gcm" "my_method" {
>          keys = key_provider.pbkdf2.my_passphrase
>        }
>        state {
>          method = method.aes_gcm.my_method
>        }
>      }
>    }
>    ```
> 3. Apply a simple resource and verify that the state file in S3 is encrypted (download and try to read it).
> 4. **(Bonus):** Migrate from PBKDF2 to an **AWS KMS** key provider, using the `fallback` block to decrypt the old state and re-encrypt with KMS.
> 5. **(Discussion):** What are the operational trade-offs of client-side encryption? What happens if you lose the key?

**Why this exercise:** State encryption is a flagship OpenTofu feature and a strong selling point vs Terraform. It's also a practical security requirement in regulated industries.

---

### Exercise 14: DRY Backends with Early Variable Evaluation (OpenTofu)

**Concept:** Early variable/local evaluation in backend and module sources
**Prerequisites:** Exercise 02 (remote backend), exercise 04 (modules)
**Note:** OpenTofu only

**Instructions:**

> In exercise 02, you hardcoded the S3 backend bucket name and region. In a real project, you'd have `dev`, `staging`, and `prod` environments each with their own backend. OpenTofu 1.8+ lets you use variables in backend configuration.
>
> 1. Create a `variables.tf` with variables for `environment`, `aws_region`, and `state_bucket_name`.
> 2. Create two `.tfvars` files: `dev.tfvars` and `prod.tfvars`, each pointing to different S3 bucket/key combinations.
> 3. Update the `backend "s3"` block to use `var.state_bucket_name`, `var.aws_region`, and interpolate `var.environment` into the state key:
>    ```hcl
>    terraform {
>      backend "s3" {
>        bucket = var.state_bucket_name
>        key    = "state/${var.environment}/terraform.tfstate"
>        region = var.aws_region
>      }
>    }
>    ```
> 4. Initialize with `tofu init -var-file=dev.tfvars` and verify it works.
> 5. **(Bonus):** Also parameterize a module's `version` using a local:
>    ```hcl
>    locals {
>      vpc_module_version = "5.0.0"
>    }
>    module "vpc" {
>      source  = "terraform-aws-modules/vpc/aws"
>      version = local.vpc_module_version
>    }
>    ```
> 6. **(Discussion):** What are the restrictions of early evaluation? Why can't you use resource attributes here?

**Why this exercise:** Directly extends exercise 02. Solves a pain point every student will encounter in real multi-environment projects.

---

### Updating Existing Exercise 07: The `enabled` Meta-Argument

Rather than a standalone exercise, this is a natural extension to **exercise 07 (Conditional Infrastructure)**:

> **Additional task for exercise 07 (OpenTofu 1.11+):**
>
> In the previous steps, you used `count = condition ? 1 : 0` to conditionally create resources. OpenTofu 1.11 introduces a cleaner alternative: the `enabled` meta-argument.
>
> Refactor one of your conditional resources to use `lifecycle { enabled = var.is_production }` instead of the count trick. Compare the two approaches:
> - How does the resource address differ? (no `[0]` index needed with `enabled`)
> - What happens when you toggle the value?
> - Which approach is more readable?

---

### Updating Existing Exercise 09: Loopable Import Blocks

A natural extension to **exercise 09 (State Manipulation)**, scenario 2:

> **Additional task for exercise 09 (OpenTofu 1.7+):**
>
> Your colleague created not one but **five** SQS queues via the console. Instead of writing five separate `import` blocks, use `for_each` on the import block:
> ```hcl
> import {
>   for_each = var.legacy_queue_names
>   to       = aws_sqs_queue.imported[each.key]
>   id       = each.value
> }
> ```
> This mirrors the bulk-import workflow common in brownfield adoption.

---

## Summary & Prioritization

| Priority | Exercise | Feature(s) | TF / OT | Effort |
|----------|----------|-----------|---------|--------|
| **1** | 11 — Testing | `tofu test`, assertions, mocks | Both | Medium |
| **2** | 12 — Ephemeral Values | Ephemeral vars/resources, write-only args | Both | Medium |
| **3** | 13 — State Encryption | Client-side encryption, key providers | OT only | Low-Medium |
| **4** | 14 — Early Variable Eval | Variables in backends & module sources | OT only | Low |
| **5** | 07 update — `enabled` | `lifecycle { enabled }` meta-argument | OT only | Low |
| **6** | 09 update — Loopable Import | `for_each` on import blocks | OT only | Low |

Exercises 11 and 12 work with both Terraform and OpenTofu. Exercises 13 and 14 are OpenTofu-exclusive features but align well with the course's recommendation of OpenTofu.

---

## Sources

- [Terraform 1.11: Ephemeral Values & Write-Only Arguments](https://www.hashicorp.com/en/blog/terraform-1-11-ephemeral-values-managed-resources-write-only-arguments)
- [Terraform 1.10: Ephemeral Values for Secret Management](https://www.infoq.com/news/2024/11/terraform-1-10-ephemeral-values/)
- [Terraform 1.13 Features Overview](https://modul8.dev/terraform-1-13-features-overview-key-updates-and-usability-tips/)
- [Terraform Releases](https://github.com/hashicorp/terraform/releases)
- [Terraform CHANGELOG](https://github.com/hashicorp/terraform/blob/main/CHANGELOG.md)
- [OpenTofu 1.10.0 Release](https://opentofu.org/blog/opentofu-1-10-0/)
- [OpenTofu 1.11.0 Release](https://opentofu.org/blog/opentofu-1-11-0/)
- [What's New in OpenTofu 1.11](https://opentofu.org/docs/intro/whats-new/)
- [OpenTofu Guide: Features & Installation (2026)](https://stategraph.com/blog/what-is-opentofu)
- [OpenTofu Releases](https://github.com/opentofu/opentofu/releases)
- [The Complete Guide to the OpenTofu Native Test Framework](https://scalr.com/learning-center/the-complete-guide-to-the-opentofu-native-test-framework/)
- [Terraform Test Docs](https://developer.hashicorp.com/terraform/language/tests)
- [OpenTofu Early Evaluation](https://scalr.com/learning-center/opentofu-early-evaluation/)
- [OpenTofu Early Variable Evaluation RFC](https://github.com/opentofu/opentofu/blob/main/rfc/20240513-static-evaluation.md)
