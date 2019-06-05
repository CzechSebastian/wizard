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

def set_score(score_type)
  sorted_score = District.all.sort_by { |district| self[score_type] }
  sorted = sorted_score.find_index { |x| x.id == self.id }
  District.count - sorted
end

def get_color_score(score_type)
  if score_type == "park_score"
    score = self.park_score
  elsif score_type == "school_score"
    score = self.school_score
  elsif score_type == "restaurant_score"
    score = self.restaurant_score
  elsif score_type == "bixi_score"
    score = self.bixi_score
  elsif score_type == "subway_score"
    score = self.subway_score
  elsif score_type == "dog_score"
    score = self.dog_score
  elsif score_type == "quiet_score"
    score = self.quiet_score
  elsif score_type == "parking_score"
    score = self.parking_score
  end

  if score > 4
    color_score = "green"
  elsif score <= 4 && score > 1
    color_score = "yellow"
  else
    color_score = "orange"
  end
  return color_score
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
