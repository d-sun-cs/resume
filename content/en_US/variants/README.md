# English resume variants

Each version entry in `versions/en_US/*.tex` sets `\ResumeVariant`.

By default, the build uses files from `content/en_US/shared/`. To override one section for a specific version, create a matching file under `content/en_US/variants/<variant>/`, for example:

- `content/en_US/variants/research/papers.tex`
- `content/en_US/variants/industry/experience.tex`

Current section names:

- `header`
- `education`
- `papers`
- `experience`
- `certificates`
- `awards-skills-community`
