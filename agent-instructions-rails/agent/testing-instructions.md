# Testing Instructions — Rails

## Purpose
Verification is mandatory for every phase.

## Source of verification commands
- Each phase in `docs/TICKET-ID-plan.md` specifies its verification commands.
- Run those exact commands plus any additional checks below.

## Fast checks
- `bundle exec rspec <spec path>` for the files touched
- `bundle exec rubocop` for style

## Full checks (when required)
- `bundle exec rspec`
- Contract or swagger generation tasks if API changes were made

## Rails API changes (required)
- `bundle exec rake swagger:generate_modular`
- Verify swagger endpoint: `curl http://localhost:3000/api-docs/v1/swagger.json`

## Reporting format
- List commands executed
- Include pass/fail results
- If any command fails: stop and ask before continuing
