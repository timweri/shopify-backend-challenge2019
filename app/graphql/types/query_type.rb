Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  description "The query root for this schema"

  field :carts do
    type types[Types::CartType]
    resolve -> (obj, args, ctx) {
      Cart.all
    }
  end

  field :allProducts, types[Types::ProductType] do
    argument :onlyShowAvailable, types.Boolean, default_value: false
    resolve -> (obj, args, ctx) {
      if args[:onlyShowAvailable]
        Product.where('inventory_count > 0')
      else
        Product.all
      end
    }
  end
end
