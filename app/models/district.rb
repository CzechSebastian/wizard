class District < ApplicationRecord
	def contains_point?(point)

		polygon = self.coordinates
	  contains_point = false
	  i = -1
	  j = polygon.size - 1
	  while (i += 1) < polygon.size
	    a_point_on_polygon = polygon[i]
	    trailing_point_on_polygon = polygon[j]
	    if point_is_between_the_ys_of_the_line_segment?(point, a_point_on_polygon, trailing_point_on_polygon)
	      if ray_crosses_through_line_segment?(point, a_point_on_polygon, trailing_point_on_polygon)
	        contains_point = !contains_point
	      end
	    end
	    j = i
	  end
	  return contains_point
	end

	private

	def point_is_between_the_ys_of_the_line_segment?(point, a_point_on_polygon, trailing_point_on_polygon)
	  (a_point_on_polygon[1] <= point[1] && point[1] < trailing_point_on_polygon[1]) || 
	  (trailing_point_on_polygon[1] <= point[1] && point[1] < a_point_on_polygon[1])
	end

	def ray_crosses_through_line_segment?(point, a_point_on_polygon, trailing_point_on_polygon)
	  (point[0] < (trailing_point_on_polygon[0] - a_point_on_polygon[0]) * (point[1] - a_point_on_polygon[1]) / 
	             (trailing_point_on_polygon[1] - a_point_on_polygon[1]) + a_point_on_polygon[0])
	end
end
