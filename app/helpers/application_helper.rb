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
  
  def feed_name(u, r)
    c = u.feed_entries_count('a', r.id.to_s).to_s
    if c.to_i != 0
      return truncate(r.entity_name, :length => 25, :omission => '..').to_s + " <span style='color: gray;'>(#{c})</span>".html_safe
    else
      return truncate(r.entity_name, :length => 25, :omission => '..')
    end
  end
  
  def feed_title(f)
    str = "&nbsp;&nbsp; "
    if f.app_key.entity_name.blank?
      i = 110 - (7)
    else
      i = 110 - (7 + f.app_key.entity_name.to_s.length)
      str = str + "<span class='f11 gray'>#{f.app_key.entity_name}</span> &nbsp;&nbsp;&nbsp;"
    end
    if !f.name.blank?
      if f.is_read
        if i < f.name.to_s.length
          str = str + "<span class='black'>#{f.name[0..i]}...</span>"
        else
          str = str + "<span class='black'>#{f.name[0..i]}</span>"
        end
      else
        if i < f.name.to_s.length
          str = str + "<span class='black' style='font-weight: bold;'>#{f.name[0..i]}...</span>"
        else
          str = str + "<span class='black' style='font-weight: bold;'>#{f.name[0..i]}</span>"
        end
      end
    end
    return str.html_safe
  end  
  
  def sd(i)
    if i.blank?
      return "" 
    else
      return i.strftime("%d-%b-%Y")
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
