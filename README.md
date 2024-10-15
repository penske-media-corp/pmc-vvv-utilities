# PMC VVV Utilities

> ⚠️
>
> **This repository is deprecated.** PMC no longer supports VVV, but this
> repository persists as a reference.

Custom system-level features and software for [VVV](https://github.com/varying-vagrant-vagrants/vvv/).

## What's included

### coretech

Creates a local cache of Core Tech to expedite provisioning of individual sites.

Included are `pmc-plugins`, `pmc-vip-go-plugins`, and any theme used by multiple
sites.

Unlike in previous `pmc-vvv` iterations, these caches are not symlink targets 
due to limitations in PHP's symlink support, which interfere with WordPress
functions that we rely on.

### dev-tools

**Optional**

Installs assorted developer tools not included with VVV, such as `awscli`, `jq`,
and `yaml2json`.

### http-concat

Adds the necessary nginx configuration to enable VIP Go's CSS and JS 
concatenation library.

### phpcs

Installs PMC's [PHCPS standards](https://bitbucket.org/penskemediacorp/pmc-codesniffer) and sets `PmcWpVip` as the default standard. 

## Using

If you're using [pmc-vvv](https://github.com/penske-media-corp/pmc-vvv), the
following configurations are already present in `config.yml`, though optional
utilities may be omitted.

Otherwise, these are leveraged by these additions to `config.yml`:

```yaml
utilities:
  pmc:
    - coretech      # Speed provisioning of shared code
    # - dev-tools   # Various utilities developers may find handy (optional)
    - http-concat   # VIP Go's nginx concatenation
    - phpcs         # PMC's PHPCS rules

utility-sources:
  pmc:
    repo: git@github.com:penske-media-corp/pmc-vvv-utilities.git
    branch: main
```

For more information about utilities, [read the utilities chapter on the documentation site](https://varyingvagrantvagrants.org/docs/en-US/utilities/).
