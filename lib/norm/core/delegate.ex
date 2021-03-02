defmodule Norm.Core.Delegate do
  @moduledoc false

  defstruct [:fun]

  def build(fun) when is_function(fun, 0) do
    %__MODULE__{fun: fun}
  end

  defimpl Norm.Conformer.Conformable do
    def conform(%{fun: fun}, input, path) do
      Norm.Conformer.Conformable.conform(fun.(), input, path)
    end

    def valid?(%{fun: _fun} = spec, input, path) do
      {status, _} = conform(spec, input, path)
      status == :ok
    end
  end
end
