# GraphQL Style Guide

This style is based on the rules from [RuboCop::GraphQL](https://github.com/DmitryTsepelev/rubocop-graphql) gem with a few differences.

## Table of contents

* [Style](#Style)

## Style

* <a name="graphql-argument-description"></a>
  Each argument should have a description.
  <sup>[[link](#graphql-argument-description)]</sup>

```ruby
# bad
class BanUser < BaseMutation
  argument :uuid, ID, required: true
end

# good
class BanUser < BaseMutation
  argument :uuid, ID, required: true, description: "UUID of the user to ban"
end
```

* <a name="graphql-argument-name"></a>
  All argument names should be snake_case.
  <sup>[[link](#graphql-argument-name)]</sup>

```ruby
# bad
class BanUser < BaseMutation
  argument :userId, ID, required: true
end

# good
class BanUser < BaseMutation
  argument :user_id, ID, required: true
end
```

* <a name="graphql-argument-uniqueness"></a>
  Avoid duplicate argument definitions.
  <sup>[[link](#graphql-argument-uniqueness)]</sup>

```ruby
# bad
class BanUser < BaseMutation
  argument :user_id, ID, required: true
  argument :user_id, ID, required: true
end

# good
class BanUser < BaseMutation
  argument :user_id, ID, required: true
end
```

* <a name="graphql-field-definitions"></a>
  All field definitions should be grouped together.
  <sup>[[link](#graphql-field-definitions)]</sup>

```ruby
# bad
class UserType < BaseType
  field :first_name, String, null: true

  def first_name
    object.contact_data.first_name
  end

  field :last_name, String, null: true

  def last_name
    object.contact_data.last_name
  end
end

# good
class UserType < BaseType
  field :first_name, String, null: true
  field :last_name, String, null: true

  def first_name
    object.contact_data.first_name
  end

  def last_name
    object.contact_data.last_name
  end
end
```

* <a name="graphql-field-description"></a>
  Each field should have a description.
  <sup>[[link](#graphql-field-description)]</sup>

```ruby
# bad
class UserType < BaseType
  field :name, String, null: true
end

# good
class UserType < BaseType
  field :name, String, "Name of the user", null: true
end
```

* <a name="graphql-field-hash-key"></a>
  Avoid unnecessary resolver methods in cases when :hash_key option can be used.
  <sup>[[link](#graphql-field-hash-key)]</sup>

```ruby
# bad
class Types::UserType < Types::BaseObject
  field :phone, String, null: true
   
  def phone
    object[:home_phone]
  end
end

# good
class Types::UserType < Types::BaseObject
  field :phone, String, null: true, hash_key: :home_phone
end
```

* <a name="graphql-field-mathod"></a>
  Avoid unnecessary resolver methods in cases when :method option can be used.
  <sup>[[link](#graphql-field-mathod)]</sup>

```ruby
# bad
class Types::UserType < Types::BaseObject
  field :phone, String, null: true
   
  def phone
    object.home_phone
  end
end

# good
class Types::UserType < Types::BaseObject
  field :phone, String, null: true, method: :home_phone
end
```

* <a name="graphql-field-name"></a>
  All field names should be snake_case.
  <sup>[[link](#graphql-field-name)]</sup>

```ruby
# bad
class UserType < BaseType
  field :firstName, String, null: true
end

# good
class UserType < BaseType
  field :first_name, String, null: true
end
```

* <a name="graphql-field-uniqueness"></a>
  Avoid duplicate field definitions.
  <sup>[[link](#graphql-field-uniqueness)]</sup>

```ruby
# bad
class UserType < BaseType
  field :name, String, null: true
  field :phone, String, null: true
  field :phone, String, null: true do
    argument :something, String, required: false
  end
end

# good
class UserType < BaseType
  field :name, String, null: true
  field :phone, String, null: true do
    argument :something, String, required: false
  end
end
```

* <a name="graphql-graphql-name"></a>
  Types and mutations should have graphql_name configured only if it's different from the default name.
  <sup>[[link](#graphql-graphql-name)]</sup>

```ruby
# bad
class UserType < BaseType
  graphql_name 'User'
end

# good
class UserType < BaseType
  graphql_name 'Viewer'
end
```

* <a name="graphql-max-complexity-schema"></a>
  Use max_complexity configuration in schema files.
  <sup>[[link](#graphql-max-complexity-schema)]</sup>

```ruby
# good
class AppSchema < BaseSchema
  max_complexity 42
end
```

* <a name="graphql-max-depth-schema"></a>
  Use max_depth configuration in schema files.
  <sup>[[link](#graphql-max-depth-schema)]</sup>

```ruby
# good
class AppSchema < BaseSchema
  max_depth 42
end
```

* <a name="graphql-multiple-field-definitions"></a>
  Fields with multiple definitions should be grouped together.
  <sup>[[link](#graphql-multiple-field-definitions)]</sup>

```ruby
# bad
class UserType < BaseType
  field :first_name, String, null: true

  def first_name
    object.contact_data.first_name
  end
  field :first_name, Name, null: true
end

# good
class UserType < BaseType
  field :first_name, String, null: true
  field :first_name, Name, null: true

  def first_name
    object.contact_data.first_name
  end
end
```

* <a name="graphql-not-authorized-node-type"></a>
  Types that implement Node interface should have `.authorized?` check. Such types can be fetched by ID and therefore should have type level check to avoid accidental information exposure.
  If `.authorized?` is defined in a parent class, you can add parent to the "SafeBaseClasses" to avoid offenses in children.
  This cop also checks the `can_can_action` or `pundit_role` methods that can be used as part of the Ruby GraphQL Pro.
  <sup>[[link](#graphql-not-authorized-node-type)]</sup>

```ruby
# bad
class UserType < BaseType
  implements GraphQL::Types::Relay::Node

  field :uuid, ID, null: false
end

# good
class UserType < BaseType
  implements GraphQL::Types::Relay::Node

  field :uuid, ID, null: false

  def self.authorized?(object, context)
    super && object.owner == context[:viewer]
  end
end

# good
class UserType < BaseType
  implements GraphQL::Types::Relay::Node

  pundit_role :staff

  field :uuid, ID, null: false
end

# good
class UserType < BaseType
  implements GraphQL::Types::Relay::Node

  can_can_action :staff

  field :uuid, ID, null: false
end
```

* <a name="graphql-object-description"></a>
  All types (objects, inputs, interfaces, scalars, unions, mutations, subscriptions, and resolvers) should have a description.
  <sup>[[link](#graphql-object-description)]</sup>

```ruby
# bad
class Types::UserType < Types::BaseObject
  ...
end

# good
class Types::UserType < Types::BaseObject
  description "Represents application user"
  ...
end
```

* <a name="graphql-ordered-arguments"></a>
  Arguments should be alphabetically sorted within groups.
  <sup>[[link](#graphql-ordered-arguments)]</sup>

```ruby
# bad
class UpdateProfile < BaseMutation
  argument :uuid, ID, required: true
  argument :email, String, required: false
  argument :name, String, required: false
end

# good
class UpdateProfile < BaseMutation
  argument :email, String, required: false
  argument :name, String, required: false
end

# good
class UpdateProfile < BaseMutation
  argument :uuid, ID, required: true

  argument :email, String, required: false
  argument :name, String, required: false
end
```

* <a name="graphql-ordered-fields"></a>
  Fields should be alphabetically sorted within groups.
  <sup>[[link](#graphql-ordered-fields)]</sup>

```ruby
# bad
class UpdateProfile < BaseMutation
  field :phone, String, null: true
  field :name, String, null: true
end

# good
class UpdateProfile < BaseMutation
  field :name, String, null: true
  field :phone, String, null: true
end

# good
class UpdateProfile < BaseMutation
  field :phone, String, null: true 

  field :name, String, null: true
end
```

* <a name="graphql-resolver-method-length"></a>
  The length of a resolver method should not exceed 10 lines.
  <sup>[[link](#graphql-resolver-method-length)]</sup>

* <a name="graphql-unnecessary-argument-camelize"></a>
  Avoid using :camelize option for arguments where it is unnecessary.
  <sup>[[link](#graphql-unnecessary-argument-camelize)]</sup>

```ruby
# bad
class UserType < BaseType
  argument :filter, String, required: false, camelize: false
end

# good
class UserType < BaseType
  argument :filter, String, required: false
end

# good
class UserType < BaseType
  argument :email_filter, String, required: false, camelize: true
end
```

* <a name="graphql-unnecessary-field-alias"></a>
  Avoid defining an unnecessary alias, method, or resolver_method.
  <sup>[[link](#graphql-unnecessary-field-alias)]</sup>

```ruby
# bad
field :name, String, "Name of the user", null: true, alias: :name
field :name, String, "Name of the user", null: true, method: :name
field :name, String, "Name of the user", null: true, resolver_method: :name
field :name, String, "Name of the user", null: true, hash_key: :name

# good
field :name, String, "Name of the user", null: true, alias: :real_name
field :name, String, "Name of the user", null: true, method: :real_name
field :name, String, "Name of the user", null: true, resolver_method: :real_name
field :name, String, "Name of the user", null: true, hash_key: :real_name
```

* <a name="graphql-unnecessary-field-camelize"></a>
  Avoid using :camelize option for fields where it is unnecessary.
  <sup>[[link](#graphql-unnecessary-field-camelize)]</sup>

```ruby
# bad
class UserType < BaseType
  field :name, "Name of the user", String, null: true, camelize: true
end

# good
class UserType < BaseType
  field :name, String, "Name of the user", null: true
end

# good
class UserType < BaseType
  field :first_name, "Name of the user", String, null: true, camelize: true
end
```

* <a name="graphql-unused-argument"></a>
  Arguments should either be listed explicitly or **rest should be in the resolve signature (and similar methods, such as #authorized?).
  <sup>[[link](#graphql-unused-argument)]</sup>

```ruby
# bad
class SomeResolver < Resolvers::Base
  type SomeType, null: false

  argument :arg1, String, required: true
  argument :arg2, String, required: true

  def authorized?; end
  def resolve(arg1:); end
end

# bad
class SomeResolver < Resolvers::Base
  type SomeType, null: false

  argument :arg1, String, required: true
  argument :arg2, String, required: true

  def resolve; end
end

# good
class SomeResolver < Resolvers::Base
  argument :arg1, String, required: true
  argument :user_id, String, required: true, loads: Types::UserType
  argument :post_id, String, loads: Types::PostType, as: :article
  argument :comment_ids, String, loads: Types::CommentType

  def authorized?(arg1:, user:, article:, comments:); end
  def resolve(arg1:, user:, article:, comments:); end
end

# good
class SomeResolver < Resolvers::Base
  argument :arg1, String, required: true
  argument :user_id, String, required: true, loads: Types::UserType
  argument :comment_ids, String, loads: Types::CommentType

  def resolve(arg1:, **rest); end
end

# good
class SomeResolver < Resolvers::Base
  type SomeType, null: false

  argument :arg1, String, required: true
  argument :arg2, String, required: true

  def resolve(args); end
end
```
