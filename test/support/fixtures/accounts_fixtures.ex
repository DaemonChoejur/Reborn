defmodule Reborn.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Reborn.Accounts` context.
  """

  def unique_user_email, do: "user#{System.unique_integer()}@example.com"
  def valid_user_password, do: "hello world!"

  def valid_user_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      email: unique_user_email(),
      password: valid_user_password()
    })
  end

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> valid_user_attributes()
      |> Reborn.Accounts.register_user()

    user
  end

  def extract_user_token(fun) do
    {:ok, captured} = fun.(&"[TOKEN]#{&1}[TOKEN]")

    # default code
    # [_, token, _] = String.split(captured.body, "[TOKEN]")
    # Running tests will result in error with invalid token if unchanged
    # update captured.body to captured.text_body as we have changes in reborn/accounts/user_notifier.ex
    [_, token, _] = String.split(captured.text_body, "[TOKEN]")
    token
  end
end
