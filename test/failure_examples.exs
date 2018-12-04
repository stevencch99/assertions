defmodule Assertions.FailureExamples do
  @moduledoc """
  This module is not run when running `mix test` because the file name doesn't
  follow the `*_test.exs` pattern. This is intentional. All of these examples
  fail, and this is to show how the diff is generated when using the
  `ExUnit.Console` formatter.
  """

  use Assertions.Case, async: true

  defmodule User do
    defstruct [:id, :name, :age, :address]
  end

  describe "assert_lists_equal/2" do
    test "fails" do
      assert_lists_equal([1, 2, 3], [1, 4, 2])
    end
  end

  describe "assert_lists_equal/3" do
    test "fails when the third argument is a custom message" do
      assert_lists_equal([1, 2, 3], [1, 4, 2], "Didn't match!")
    end

    test "fails when the third argument is a custom function" do
      assert_lists_equal(["cat"], ["lion"], &(String.length(&1) == String.length(&2)))
    end
  end

  describe "assert_lists_equal/4" do
    test "fails" do
      assert_lists_equal(
        ["cat"],
        ["lion"],
        &(String.length(&1) == String.length(&2)),
        "Not the same length!"
      )
    end
  end

  describe "assert_map_in_list/3" do
    test "fails" do
      list = [%{first: :first, second: :third, third: :fourth}]
      assert_map_in_list(%{first: :first, second: :second}, list, [:first, :second])
    end
  end

  describe "assert_maps_equal/3" do
    test "fails" do
      assert_maps_equal(
        %{first: :first, second: :second},
        %{first: :second, third: :third},
        [:first]
      )
    end
  end

  describe "assert_struct_in_list/3" do
    test "fails" do
      assert_struct_in_list(DateTime.utc_now(), [Date.utc_today()], [:year, :month, :second])
    end
  end

  describe "assert_structs_equal/3" do
    test "fails" do
      assert_structs_equal(
        DateTime.utc_now(),
        DateTime.utc_now(),
        [:year, :month, :millisecond, :microsecond]
      )
    end
  end
end
