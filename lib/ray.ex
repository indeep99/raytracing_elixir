defmodule Ray do
  alias Vec3

  defstruct origin: %Vec3{}, direction: %Vec3{}

  def new(origin, direction), do: %Ray{origin: origin, direction: direction}

  def at(%Ray{origin: orig, direction: dir}, t) do
    Vec3.add(orig, Vec3.scale(dir, t))
  end
end
