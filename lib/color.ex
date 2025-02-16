defmodule Color do
  alias Vec3

  def to_ppm(%Vec3{x: r, y: g, z: b}) do
    r = trunc(255.999 * clamp(r, 0.0, 1.0))
    g = trunc(255.999 * clamp(g, 0.0, 1.0))
    b = trunc(255.999 * clamp(b, 0.0, 1.0))

    "#{r} #{g} #{b}\n"
  end

  defp clamp(value, min, _max) when value < min, do: min
  defp clamp(value, _min, max) when value > max, do: max
  defp clamp(value, _min, _max), do: value
end
