# THIS MODULE IS NOT REQUIRED.

# defmodule Newspaper.Accounts.UserHelpers do
#   alias Newspaper.Accounts


#   def user_has_role?(%Accounts.User{} = user, roles) when is_list(roles) do
#     Enum.any?(user.roles, fn role -> role.name in roles end)
#   end

#   def user_has_role?(%Accounts.User{} = user, role_name) when is_binary(role_name) do
#     Enum.any?(user.roles, fn role -> role.name == role_name end)
#   end

#   def user_has_permission?(%Accounts.User{} = user, permissions) when is_list(permissions) do
#     Enum.any?(user.roles, fn role ->
#       Enum.any?(role.permissions, fn permission -> permission.name in permissions end)
#     end)
#   end

#   def user_has_permission?(%Accounts.User{} = user, permission_name) when is_binary(permission_name) do
#     Enum.any?(user.roles, fn role ->
#       Enum.any?(role.permissions, fn permission -> permission.name == permission_name end)
#     end)
#   end

# end
