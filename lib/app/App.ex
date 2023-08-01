defmodule App do
  use Lenra.Application,
    otp_app: :app,
    manifest_mod: App.Manifest

  @moduledoc """
    Define and config the App.
  """
end
