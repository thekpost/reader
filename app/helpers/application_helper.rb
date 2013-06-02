module ApplicationHelper
  
  def remove_decimal(d)
    d.to_s.gsub(".0", "")
  end
  
  def n2h(d)
    begin
      return number_to_human(d, significant: false, precision: 1)
    rescue
      return d
    end
  end
    
  def title(page_title)
    content_for(:title) { page_title }
  end
  
  def d
    "<span style='font-size:13px'><i class='icon-trash'></i></span>".html_safe
  end
  
  def r
    "<i class='icon-repeat'></i>".html_safe
  end
  
  def dp(e, s, user=nil)
    Safai::Gravatar.dp(e, s)
  end
  
end
