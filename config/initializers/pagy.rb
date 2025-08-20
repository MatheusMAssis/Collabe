# Pagy initializer file (8.0.6)
# Customize only what you really need but notice that the core Pagy works also without any of the following lines.
# Should you just cherry-pick part of this file, please maintain the require-order and the basic structure.

# Pagy DEFAULT Variables
# See https://ddnexus.github.io/pagy/docs/api/pagy#variables
# All the Pagy::DEFAULT are set for all the Pagy instances but can be overridden per instance by just passing them to
# Pagy.new(count:..., ...) or the #pagy helper method
# See https://ddnexus.github.io/pagy/docs/how-to#global-and-instance-variables
Pagy::DEFAULT[:limit] = 10                                   # default
# Pagy::DEFAULT[:size]  = 9                                  # default
# Pagy::DEFAULT[:page_param] = :page                         # default
# The :params can be also set as a lambda e.g ->(params){ params.exclude('useless').merge!('custom' => 'useful') }
# Pagy::DEFAULT[:params] = {}                                # default
# Pagy::DEFAULT[:fragment] = '#fragment'                     # optional
# Pagy::DEFAULT[:link_extra] = 'data-remote="true"'          # optional
# Pagy::DEFAULT[:i18n_key] = 'pagy.item_name'                # default
# Pagy::DEFAULT[:cycle] = true                               # default
# Pagy::DEFAULT[:request_path] = "/foo"                      # optional

require "pagy/extras/bootstrap"
