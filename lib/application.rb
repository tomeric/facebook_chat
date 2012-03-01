require 'rubygems' # disable this for a deployed application
require 'hotcocoa'

framework 'WebKit'

class FacebookChat
  include HotCocoa

  def start
    application name: 'FacebookChat' do |app|
      app.delegate = self
      window size: [500, 500], title: 'FacebookChat', style: [:titled, :closable, :miniaturizable] do |win|
        win.view.spacing = 0
        win.view.margin  = 0
        
        win.view = view()
        
        win << contacts_panel
        win << message_input
        win << chat_panel
        
        win.will_close { exit }
      end
    end
  end
  
  def contacts_panel_html
    <<-HTML
    <!DOCTYPE html>
    <html>
      <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <style type="text/css">
          html { background: #d6dde4; }
        </style>
      </head>
      <body>
        <ul>
          <li>Contact #1</li>
          <li>Contact #2</li>
          <li>Contact #3</li>
        </ul>
      </body>
    </html>
    HTML
  end
  
  def contacts_panel
    @contacts_panel ||= (
      view = web_view frame: [0, 0, 150, 500], url: "http://m.facebook.com/"
      view.mainFrame.loadHTMLString contacts_panel_html, baseURL: nil
      view
    )
  end
  
  def message_input
    @message_input ||= text_field frame: [150, 0, 350, 24]
  end
  
  def chat_panel_html
    <<-HTML
    <!DOCTYPE html>
    <html>
      <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <style type="text/css">
          html, body { font: ;}
        </style>
      </head>
      <body>
        <ul>
          <li>Lorem ipsum dolor sit amet</li>
          <li>Lorem ipsum dolor sit amet</li>
          <li>Lorem ipsum dolor sit amet</li>
          <li>Lorem ipsum dolor sit amet</li>
          <li>Lorem ipsum dolor sit amet</li>
          <li>Lorem ipsum dolor sit amet</li>
          <li>Lorem ipsum dolor sit amet</li>
          <li>Lorem ipsum dolor sit amet</li>
        </ul>
      </body>
    </html>
    HTML
  end
  
  def chat_panel
    @chat_panel ||= (
      view = web_view frame: [150, 24, 350, 476], url: "http://m.eat.io/"
      view.mainFrame.loadHTMLString chat_panel_html, baseURL: nil
      view
    )
  end

  # file/open
  def on_open(menu)
  end

  # file/new
  def on_new(menu)
  end

  # help menu item
  def on_help(menu)
  end

  # This is commented out, so the minimize menu item is disabled
  #def on_minimize(menu)
  #end

  # window/zoom
  def on_zoom(menu)
  end

  # window/bring_all_to_front
  def on_bring_all_to_front(menu)
  end
end

FacebookChat.new.start
