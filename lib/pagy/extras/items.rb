# See the Pagy documentation: https://ddnexus.github.io/pagy/extras/items

class Pagy

  # Default variable for this extra
  VARS[:items_param] = :items
  VARS[:max_items]   = 100

  # Handle a custom number of :items from params
  module Backend ; private

    alias_method :built_in_pagy_get_vars, :pagy_get_vars

    def pagy_get_vars(collection, vars)
      vars[:items] ||= (items = params[ vars[:items_param] || VARS[:items_param] ]) &&                     # items from :items_param
                       [ items, vars.key?(:max_items) ? vars[:max_items] : VARS[:max_items] ].compact.min  # capped to :max_items
      built_in_pagy_get_vars(collection, vars)
    end

  end
end
