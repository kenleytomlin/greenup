defmodule Greenup.AshDomain do
  use Ash.Domain

  resources do
    resource(Greenup.Ash.Resources.User)
    resource(Greenup.Ash.Resources.BotConfig)
    resource(Greenup.Ash.Resources.TradeLog)
  end
end
