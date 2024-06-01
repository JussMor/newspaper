# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Newspaper.Repo.insert!(%Newspaper.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Newspaper.Repo
alias Newspaper.Categories.Category
alias Newspaper.Accounts.User
alias Newspaper.Roles.Role
alias Newspaper.UserRoles.UserRole
alias Newspaper.Permissions.Permission
alias Newspaper.RolPermissions.RolPermission
alias Newspaper.SocialMedias.SocialMedia
alias Newspaper.Contents.Article
alias Newspaper.Seos.Seo
alias Newspaper.PermissionCategories.PermissionCategory
require Bcrypt

# Create and insert users
hashed_password = Bcrypt.hash_pwd_salt("mypasswordis12345")

users = [
  %User{email: "user1@example.com", hashed_password: hashed_password, confirmed_at: ~N[2024-01-01 00:00:00]},
  %User{email: "user2@example.com", hashed_password: hashed_password, confirmed_at: ~N[2024-01-01 00:00:00]},
  %User{email: "user3@example.com", hashed_password: hashed_password, confirmed_at: ~N[2024-01-01 00:00:00]},
  %User{email: "user4@example.com", hashed_password: hashed_password, confirmed_at: ~N[2024-01-01 00:00:00]}
]

inserted_users = for user <- users do
  case Repo.insert(user) do
    {:ok, user} ->
      IO.puts("Inserted user #{user.email} with ID #{user.id}")
      user
    {:error, changeset} ->
      IO.inspect(changeset.errors, label: "Error inserting user #{user.email}")
      nil
  end
end
|> Enum.filter(& &1) # Filter out nil values



# Create and insert roles
roles = [
  %Role{name: "Editor", description: "Responsible for editing articles"},
  %Role{name: "Reporter", description: "Responsible for reporting news"},
  %Role{name: "Photographer", description: "Responsible for taking photos"},
  %Role{name: "Administrator", description: "Responsible for managing the system"}
]

inserted_roles = for role <- roles do
  case Repo.insert(role) do
    {:ok, role} -> role
    {:error, changeset} ->
      IO.inspect(changeset.errors, label: "Error inserting role #{role.name}")
      nil
  end
end
|> Enum.filter(& &1) # Filter out nil values

# Assign roles to users
user_roles = [
  %UserRole{user_id: Enum.at(inserted_users, 0).id, role_id: Enum.at(inserted_roles, 0).id},
  %UserRole{user_id: Enum.at(inserted_users, 1).id, role_id: Enum.at(inserted_roles, 1).id},
  %UserRole{user_id: Enum.at(inserted_users, 2).id, role_id: Enum.at(inserted_roles, 2).id},
  %UserRole{user_id: Enum.at(inserted_users, 3).id, role_id: Enum.at(inserted_roles, 3).id}
]

for user_role <- user_roles do
  case Repo.insert(UserRole.changeset(%UserRole{}, Map.from_struct(user_role))) do
    {:ok, _user_role} -> IO.puts("Assigned role #{user_role.role_id} to user #{user_role.user_id}")
    {:error, changeset} -> IO.inspect(changeset.errors, label: "Error assigning role")
  end
end

# Step 1: Define and insert permission categories
permission_categories = [
  %PermissionCategory{name: "user_settings", description: "Permissions related to user settings"},
  %PermissionCategory{name: "article_management", description: "Permissions related to article management"}
]

inserted_permission_categories = for category <- permission_categories do
  case Repo.insert(category) do
    {:ok, category} -> category
    {:error, changeset} ->
      IO.inspect(changeset.errors, label: "Error inserting permission category #{category.name}")
      nil
  end
end
|> Enum.filter(& &1) # Filter out nil values

# Step 2: Map category names to their IDs
category_id_map = Enum.into(inserted_permission_categories, %{}, fn %PermissionCategory{id: id, name: name} -> {name, id} end)

# Step 3: Define permissions with their categories and insert them
permissions = [
  %Permission{name: "update_user", description: "Update user", permission_category_id: category_id_map["user_settings"]},
  %Permission{name: "delete_user", description: "Delete user", permission_category_id: category_id_map["user_settings"]},
  %Permission{name: "insert_user", description: "Insert user", permission_category_id: category_id_map["user_settings"]},
  %Permission{name: "user_read_only", description: "Read-only user", permission_category_id: category_id_map["user_settings"]},
  %Permission{name: "update_article", description: "Update article", permission_category_id: category_id_map["article_management"]},
  %Permission{name: "delete_article", description: "Delete article", permission_category_id: category_id_map["article_management"]},
  %Permission{name: "insert_article", description: "Insert article", permission_category_id: category_id_map["article_management"]},
  %Permission{name: "article_read_only", description: "Read-only article", permission_category_id: category_id_map["article_management"]}
]


inserted_permissions = for permission <- permissions do
  case Repo.insert(permission) do
    {:ok, permission} -> permission
    {:error, changeset} ->
      IO.inspect(changeset.errors, label: "Error inserting permission #{permission.name}")
      nil
  end
end
|> Enum.filter(& &1) # Filter out nil values

# Assign permissions to roles
rol_permissions = [
  %RolPermission{role_id: Enum.at(inserted_roles, 0).id, permission_id: Enum.at(inserted_permissions, 0).id}, # Editor -> update_user
  %RolPermission{role_id: Enum.at(inserted_roles, 0).id, permission_id: Enum.at(inserted_permissions, 1).id}, # Editor -> delete_user
  %RolPermission{role_id: Enum.at(inserted_roles, 1).id, permission_id: Enum.at(inserted_permissions, 4).id}, # Reporter -> update_article
  %RolPermission{role_id: Enum.at(inserted_roles, 1).id, permission_id: Enum.at(inserted_permissions, 5).id}, # Reporter -> delete_article
  %RolPermission{role_id: Enum.at(inserted_roles, 2).id, permission_id: Enum.at(inserted_permissions, 6).id}, # Photographer -> insert_article
  %RolPermission{role_id: Enum.at(inserted_roles, 2).id, permission_id: Enum.at(inserted_permissions, 7).id}, # Photographer -> article_read_only
  %RolPermission{role_id: Enum.at(inserted_roles, 3).id, permission_id: Enum.at(inserted_permissions, 2).id}, # Administrator -> insert_user
  %RolPermission{role_id: Enum.at(inserted_roles, 3).id, permission_id: Enum.at(inserted_permissions, 3).id}  # Administrator -> user_read_only
]

for rol_permission <- rol_permissions do
  case Repo.insert(RolPermission.changeset(%RolPermission{}, Map.from_struct(rol_permission))) do
    {:ok, _rol_permission} -> IO.puts("Assigned permission #{rol_permission.permission_id} to role #{rol_permission.role_id}")
    {:error, changeset} -> IO.inspect(changeset.errors, label: "Error assigning permission")
  end
end

# Define and insert categories
categories = [
  %Category{name: "Technology", description: "Articles about technology"},
  %Category{name: "Health", description: "Articles about health"},
  %Category{name: "Science", description: "Articles about science"},
  %Category{name: "Sports", description: "Articles about sports"}
]

inserted_categories = for category <- categories do
  case Repo.insert(category) do
    {:ok, category} -> category
    {:error, changeset} ->
      IO.inspect(changeset.errors, label: "Error inserting category #{category.name}")
      nil
  end
end
|> Enum.filter(& &1) # Filter out nil values

# Define and insert articles
articles = [
  %Article{title: "Article 1", content: "Content 1", user_id: Enum.at(inserted_users, 0).id, category_id: Enum.at(inserted_categories, 0).id},
  %Article{title: "Article 2", content: "Content 2", user_id: Enum.at(inserted_users, 1).id, category_id: Enum.at(inserted_categories, 1).id},
  %Article{title: "Article 3", content: "Content 3", user_id: Enum.at(inserted_users, 2).id, category_id: Enum.at(inserted_categories, 2).id},
  %Article{title: "Article 4", content: "Content 4", user_id: Enum.at(inserted_users, 3).id, category_id: Enum.at(inserted_categories, 3).id}
]

inserted_articles = for article <- articles do
  case Repo.insert(Article.changeset(%Article{}, Map.from_struct(article))) do
    {:ok, article} -> article
    {:error, changeset} ->
      IO.inspect(changeset.errors, label: "Error inserting article #{article.title}")
      nil
  end
end
|> Enum.filter(& &1) # Filter out nil values

# Define and insert SEO records associated with articles
seos = [
  %Seo{title: "SEO Title 1", description: "Description 1", keywords: "keyword1, keyword2", article_id: Enum.at(inserted_articles, 0).id},
  %Seo{title: "SEO Title 2", description: "Description 2", keywords: "keyword3, keyword4", article_id: Enum.at(inserted_articles, 1).id},
  %Seo{title: "SEO Title 3", description: "Description 3", keywords: "keyword5, keyword6", article_id: Enum.at(inserted_articles, 2).id},
  %Seo{title: "SEO Title 4", description: "Description 4", keywords: "keyword7, keyword8", article_id: Enum.at(inserted_articles, 3).id}
]

for seo <- seos do
  case Repo.insert(Seo.changeset(%Seo{}, Map.from_struct(seo))) do
    {:ok, _seo} -> IO.puts("Inserted SEO #{seo.title} for article #{seo.article_id}")
    {:error, changeset} -> IO.inspect(changeset.errors, label: "Error inserting SEO #{seo.title}")
  end
end


# Define and insert social media
social_medias = [
  %SocialMedia{platform: "Twitter", url: "https://twitter.com/user1", user_id: Enum.at(inserted_users, 0).id},
  %SocialMedia{platform: "Facebook", url: "https://facebook.com/user2", user_id: Enum.at(inserted_users, 1).id},
  %SocialMedia{platform: "Instagram", url: "https://instagram.com/user3", user_id: Enum.at(inserted_users, 2).id},
  %SocialMedia{platform: "LinkedIn", url: "https://linkedin.com/user4", user_id: Enum.at(inserted_users, 3).id}
]



for social_media <- social_medias do
  case Repo.insert(SocialMedia.changeset(%SocialMedia{}, Map.from_struct(social_media))) do
    {:ok, _social_media} -> IO.puts("Inserted social media #{social_media.platform} for user #{social_media.user_id}")
    {:error, changeset} -> IO.inspect(changeset.errors, label: "Error inserting social media")
  end
end
