module ApplicationHelper
 
 def controller?(*controller)
    controller.include?(params[:controller])
  end 

  def action?(*action)
    @current_action = action.include?(params[:action])
  end

  def current_page
  	current_page?(params[:action]) 
  end

end