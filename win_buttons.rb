
require_relative 'people/priem'

module ModuleButtons

def people_priem_click = Proc.new {
   u = Priem.new
   say u.main
}

def lb_menu_1_click = Proc.new {
   index =  @list_box1.curselection()[0]
   say @list_box_names[index]
}

def get_text = Proc.new {
   say @text.get(0.1, 'end')
}

def menu_click = Proc.new {
   Tk.messageBox(
      'type'    => "ok",
      'icon'    => "info",
      'title'   => "Title",
      'message' => "Message"
   )
}



end
