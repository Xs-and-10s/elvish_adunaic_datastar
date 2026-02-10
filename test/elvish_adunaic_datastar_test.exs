defmodule ElvishAdunaicDatastarTest do
  use ExUnit.Case
  doctest ElvishAdunaicDatastar

  test "pages module generates HTML" do
    html = ElvishAdunaicDatastar.Pages.index()
    assert html =~ "Hello Galaxy!"
    assert html =~ "Elvish"
    assert html =~ "Adûnaic"
    assert html =~ "Datastar"
  end
end
