---
title: Items
---
# Items Extra

The `items` extra handles the page `:items` passed with the params. It is useful with APIs, or higly user-customizable apps in order to allow the client to request a custom number of `:items`.

## Synopsys

See [extras](../extras.md) for general usage info.

```ruby
# in the Pagy initializer
require 'pagy/extra/items'

Pagy::VARS[:items_param] = :my_items  # default :items
Pagy::VARS[:max_items]   = 100        # default nil
```

## Files

This extra is composed of 1 small file:

- [items.rb](https://github.com/ddnexus/pagy/blob/master/lib/pagy/extras/items.rb)

## Variables

| Variable       | Description                                                       | Default  |
| -------------- | ----------------------------------------------------------------- | -------- |
| `:items_param` | the name of the items param used in the url.                      | `:items` |
| `:max_items`   | the max items allowed to be requested. Set it to `nil` for no limit. | `100`    |

This extra uses the `:items_param` variable to determine the param it should get the number of `:items` from.

The `:max_items` is used to cap the number of items to that max. It is set to `100` by default. If you don't want to limit the max requested number of items per page, you can set it to `nil`.

You may want to customize the variables. Depending on the scope of the customization, you have a couple of options:

As a global default:

```ruby
Pagy::VARS[:items_param] = :custom_param
Pagy::VARS[:max_items]   = 50
```

For a single instance (overriding the global default):

```ruby
pagy(scope, items_param: :custom_param, max_items: 50)
Pagy.new(count:100, items_param: :custom_param, max_items: 50)
```
**Notice**: you can override items that the client send with the params by passing the `:items` explicitly. For example:

```ruby
# this will ignore the params[:item] (or any custom :param_name)
# from the client for this instance, and serve 30 items
pagy(scope, items: 30)
```


## Methods

This extra overrides the `pagy_get_vars` method in order to add the `:items` variable, pulled from the params.

The built-in `pagy_get_vars` method is aliased as `built_in_pagy_get_vars` and is still available.
