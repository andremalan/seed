# README

## Worklog:

### 21: 13:30 - 14:30:

- Install RbEnv
- Rails new
- Connect github repo
- Generate all the models
- Test for all models (install rspec)
- Seeds and feature test to check the whole thing works end to end.

### 21: 14:30 - 15:00:

- Add GraphQL
- Add and test basic types.

### 22: 10 - 11:30:

- Add graphQL mutations.
- Add Rspec tests for the mutations.

## TODO:

- Add more basic fields to query?
- Deploy
- Add playwright test to check graphql is working
- CI?
- Some kind of auth?

# Getting started

- `bundle install`
- `rake db:migrate`
- `rails s`

# GraphQL endpoint

- visit http://localhost:3000/graphiql
- enter your query. Eg:

```
{
  menus {
    identifier,
    label,
    state,
    sections {
  		label,
      identifier,
      items {
        label,
        identifier,
        modifierGroups {
          label,
          modifiers {
            priceOverride,
            displayOrder
          }
        }
      }
    }
  },

  menu(id: 3) {
    startDate, label, identifier,
  }

}
```
