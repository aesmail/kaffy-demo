defmodule Bakery.URLField do
  use Ecto.Type
  def type, do: :string

  # casting input from the form and making it "storable" inside the database column (:string)
  def cast(url) when is_map(url) do
    IO.inspect(url)
    name = Map.get(url, "one")
    link = Map.get(url, "two")
    {:ok, ~s(<a href="#{link}">#{name}</a>)}
  end

  # if the input is not a string, return an error
  def cast(_), do: :error

  # loading the raw value from the database and turning it into a expected data type for the form
  def load(data) when is_binary(data) do
    [[_, link]] = Regex.scan(~r/href="(.*)"/, data)
    [[_, name]] = Regex.scan(~r/>(.*)</, data)

    {:ok, %{"one" => name, "two" => link}}
  end

  # this takes whatever the cast function gives it.
  # since we're only returning a string, which is the database field type, just save it as it is.
  def dump(url) when is_binary(url), do: {:ok, url}
  def dump(_), do: :error

  # this function should return the HTML related to rendering the customized form field.
  def render_form(_conn, changeset, form, field, _options) do
    [
      {:safe, ~s(<div class="form-group">)},
      Phoenix.HTML.Form.label(form, field, "Web URL"),
      Phoenix.HTML.Form.text_input(form, field,
        placeholder: "This is a custom field",
        class: "form-control",
        name: "#{form.name}[#{field}][one]",
        id: "#{form.name}_#{field}_one",
        value: get_field_value(changeset, field, "one")
      ),
      Phoenix.HTML.Form.text_input(form, field,
        placeholder: "This is a custom field",
        class: "form-control",
        name: "#{form.name}[#{field}][two]",
        id: "#{form.name}_#{field}_two",
        value: get_field_value(changeset, field, "two")
      ),
      {:safe, ~s(</div>)}
    ]
  end

  # this is how the field should be rendered on the index page
  def render_index(resource, field, _options) do
    case Map.get(resource, field) do
      nil ->
        ""

      details ->
        name = details["one"]
        link = details["two"]
        {:safe, ~s(<a href="#{link}">#{name}</a>)}
    end
  end

  defp get_field_value(changeset, field, subfield) do
    field_value = Map.get(changeset.data, field)
    Map.get(field_value || %{}, subfield, "")
  end
end
