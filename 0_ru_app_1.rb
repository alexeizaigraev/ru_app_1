require 'tk'
require_relative 'win_buttons'

class MainWindow

  include ModuleButtons

  def clear_me
    @text.delete 0.1, 'end'
  end

def say txt
  clear_me
  @text.insert 'end', txt
end



def main
  @root = TkRoot.new
  @root.geometry("1600x800")
  @root.title = "Window"


  people_menu = TkMenu.new(@root)


people_menu.add('command',
              'label'     => "приём",
              'font'     => ('veranda 24'),
              'background' => 'cyan',
              'foreground' => 'darkblue',
              'command'   => people_priem_click,
              'underline' => 0)

listbox_menu = TkMenu.new(@root)
listbox_menu.add('command',
              'label'     => "choise",
              'font'     => ('veranda 24'),
              'background' => 'cyan',
              'foreground' => 'darkblue',
              'command'   => lb_menu_1_click,
              'underline' => 0)

text_menu = TkMenu.new(@root)
text_menu.add('command',
              'label'     => "get_text",
              'font'     => ('veranda 24'),
              'background' => 'cyan',
              'foreground' => 'darkblue',
              'command'   => get_text,
              'underline' => 0)


menu_bar = TkMenu.new
menu_bar.add('cascade',
             'font'     => ('veranda 24'),
             'menu'  => people_menu,
             'label' => "люди")
menu_bar.add('cascade',
            'font'     => ('veranda 24'),
            'menu'  => listbox_menu,
            'label' => "listbox_menu")
menu_bar.add('cascade',
            'font'     => ('veranda 24'),
            'menu'  => text_menu,
            'label' => "text_menu")


@root.menu(menu_bar)


  @text = TkText.new(@root) do
    width 70
    borderwidth 1
    foreground 'darkmagenta'
    background 'cyan'
    font TkFont.new('veranda 24')
    pack("side" => "left", "fill" => 'y',  "padx" => "10", "pady" => "10")
  end

  @list_box_names = %w{ yellow gray green
              blue red black white cyan
              pink yellow orange gray}
$colornames = TkVariable.new(@list_box_names)

  @list_box1 = TkListbox.new(@root) do
     #width 150
     #height 10
     selectmode  'single'
     listvariable $colornames
     foreground 'darkmagenta'
     background 'cyan'
     setgrid 1
     font TkFont.new('consolas 24')
     pack('side' => 'left', 'fill' => 'y')
  end



#@list_box1.insert 0, "yellow", "gray", "green",
#  "blue", "red", "black", "white", "cyan",
#  "pink", "yellow", "orange", "gray"


  Tk.mainloop

  end





end

u = MainWindow.new
u.main
