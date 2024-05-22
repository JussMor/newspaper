defmodule NewspaperWeb.ChampionHTML do
  use NewspaperWeb, :html

  embed_templates "champion_html/*"

  @doc """
  Renders a champion form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def champion_form(assigns)
end
