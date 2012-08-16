require "oembed"
module StoriesHelper
  def return_video(url,source)
    begin
      if source == "Vimeo"
        OEmbed::Providers::Vimeo.get(url, {autoplay: 1})
      elsif source == "Youtube"
        OEmbed::Providers::Youtube.get(url, {autoplay: 1})
      end
    rescue
      return false
    end 
  end
  
  def adjust_video(video)
    width_adjusted = video.html.gsub(/width="\d+"/,"width=\"576\"")
    all_adjusted = width_adjusted.gsub(/height="\d+"/,"height=\"462\"")
    all_adjusted
  end
  
  def year_helper(year_name)
    stories_in_that_year = Story.all.select {|story| story.event_year == year_name }
    motnhly_grouped_hash = stories_in_that_year.group_by {|story| story.event_month}
    monthly_ordered_hash = motnhly_grouped_hash.sort_by {|story| story[1].first.event_date }
    monthly_ordered_hash
  end
end
