defmodule GreenupWeb.CoreComponentsTest do
  use ExUnit.Case, async: true
  use Phoenix.Component
  import Phoenix.LiveViewTest
  import GreenupWeb.CoreComponents

  test "ui_button renders" do
    html = render_component(&ui_button/1, %{inner_block: fn -> "Click" end})
    assert html =~ "Click"
  end

  test "ui_table renders" do
    html = render_component(&ui_table/1, %{inner_block: fn -> "<div>rows</div>" end})
    assert html =~ "rows"
  end
end
