defmodule ExtEcto do
  @spec build_for_update([struct()], [struct()]) :: [struct()]
  @doc """
  Iterate over the current struct and updates them
  The final result is a list with the current values updated, and the new values added

  # TODO: handle diferente unique keys
  ## Examples
      iex> struct = [
      ...>   %{
      ...>     field_a: "test",
      ...>     field_b: nil,
      ...>     id: "0d1158af-b6b9-46bd-b532-77afe76f44d7",
      ...>     # ...
      ...>   }
      ...> ]
      ...> params = [
      ...>   %{
      ...>     field_b: "NEW",
      ...>     id: "0d1158af-b6b9-46bd-b532-77afe76f44d7"
      ...>   }
      ...> ]
      ...> ExtEcto.build_for_update(requirements, params)
      [
        %{
          field_a: "test",
          field_b: "NEW",
          id: "0d1158af-b6b9-46bd-b532-77afe76f44d7"
          # ...
        }
      ]
  """
  def build_for_update(current, new) do
    # Transform struct into sets
    set1 = MapSet.new(current, & &1.id)
    set2 = MapSet.new(new, & &1.id)
    # Find the items they hold in common
    common = MapSet.intersection(set1, set2)
    # Find values to create
    list_values_to_create = Enum.filter(new, &(!MapSet.member?(common, &1.id)))
    # Find the values to update
    set_values_to_update =
      Enum.filter(new, &MapSet.member?(common, &1.id))
      |> Map.new(&{&1.id, &1})

    # Iterate over the old values and update them
    # The final list is a list with current values updated
    # And new values added
    (list_values_to_create ++ current)
    |> Enum.map(&Map.merge(&1, Map.get(set_values_to_update, &1.id, %{})))

    # TODO: Make a to_params of convert to struct
  end
end
