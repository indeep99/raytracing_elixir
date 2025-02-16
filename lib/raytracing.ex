defmodule Raytracing do
  alias Vec3
  alias Color
  alias Ray

  def main do
    aspect_ratio = 16.0 / 9.0
    image_width = 400
    image_height = trunc(image_width / aspect_ratio)

    # Viewport
    focal_length = 1.0
    viewport_height = 2.0
    viewport_width = viewport_height * (image_width / image_height)
    camera_center = Vec3.new(0, 0, 0)

    # Horizontal and vertical port
    viewport_u = Vec3.new(viewport_width, 0, 0)
    viewport_v = Vec3.new(0, -viewport_height, 0)

    # Pixel movement
    pixel_delta_u = Vec3.divide(viewport_u, image_width)
    pixel_delta_v = Vec3.divide(viewport_v, image_height)

    # Upper left corner viewport
    viewport_upper_left =
      camera_center
      |> Vec3.subtract(Vec3.new(0, 0, focal_length))
      |> Vec3.subtract(Vec3.scale(viewport_u, 0.5))
      |> Vec3.subtract(Vec3.scale(viewport_v, 0.5))

    pixel00_loc =
      Vec3.add(viewport_upper_left, Vec3.scale(Vec3.add(pixel_delta_u, pixel_delta_v), 0.5))

    filename = "output.ppm"

    File.write!(
      filename,
      ppm_header(image_width, image_height) <>
        ppm_body(
          image_width,
          image_height,
          camera_center,
          pixel00_loc,
          pixel_delta_u,
          pixel_delta_v
        )
    )
  end

  defp ppm_header(width, height) do
    "P3\n#{width} #{height}\n255\n"
  end

  defp ppm_body(width, height, camera_center, pixel00_loc, pixel_delta_u, pixel_delta_v) do
    for y <- 0..(height - 1), into: "" do
      print_progress(height - y)

      for x <- 0..(width - 1), into: "" do
        pixel_center =
          pixel00_loc
          |> Vec3.add(Vec3.scale(pixel_delta_u, x))
          |> Vec3.add(Vec3.scale(pixel_delta_v, y))

        ray_direction = Vec3.subtract(pixel_center, camera_center)

        ray = Ray.new(camera_center, ray_direction)

        pixel_color = ray_color(ray)

        Color.to_ppm(pixel_color)
      end
    end
  end

  defp ray_color(ray) do
    sphere_center = Vec3.new(0, 0, -1)
    t = hit_sphere(sphere_center, 0.5, ray)

    case t > 0 do
      true ->
        hit_point = Ray.at(ray, t)

        normal = Vec3.normalize(Vec3.subtract(hit_point, sphere_center))

        Vec3.scale(Vec3.add(normal, Vec3.new(1, 1, 1)), 0.5)

      false ->
        unit_dir = Vec3.normalize(ray.direction)
        t = 0.5 * (unit_dir.y + 1.0)

        Vec3.add(
          Vec3.scale(Vec3.new(1.0, 1.0, 1.0), 1.0 - t),
          Vec3.scale(Vec3.new(0.5, 0.7, 1.0), t)
        )
    end
  end

  defp print_progress(scanlines_remaining) do
    IO.puts("Scanlines remaining: #{scanlines_remaining}")
  end

  defp hit_sphere(center, radius, %Ray{origin: orig, direction: dir}) do
    oc = Vec3.subtract(orig, center)
    a = Vec3.dot(dir, dir)
    b = 2.0 * Vec3.dot(oc, dir)
    c = Vec3.dot(oc, oc) - radius * radius
    discriminant = b * b - 4 * a * c

    case discriminant do
      x when x < 0 -> -1.0
      _ -> (-b - :math.sqrt(discriminant)) / (2.0 * a)
    end
  end
end
