module Gp
  module Commands
    class Art
      def initialize(options)
        @options = options
      end

      def execute
        Gp::UI::MainWindow.new
        Gtk.main
      end
    end
  end
end
