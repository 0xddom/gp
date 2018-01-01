# coding: utf-8
module Gp
  module UI
    class NewEvoForm < Gtk::Builder
      def initialize(parent)
        super

        @parent = parent

        init_ui
      end

      private
      def init_ui
        add_from_file File.join(File.dirname(__FILE__), 'evo_form.ui')

        @new_evo_form = get_object :new_evolution_form
        @cancel_new_evo_button = get_object :cancel_button
        @population_size_button = get_object :population_size
        @generations_number_button = get_object :generations_number
        @infinite_generations_toggle = get_object :infinite_generations
        @number_instructions_button = get_object :number_instructions
        @report_to_file_toggle = get_object :report_to_file
        @report_path_chooser = get_object :report_path
        @original_image_path = get_object :original_image_path
        @image_preview = get_object :image_preview
        @image_info_label = get_object :image_info_label
        @run_evo_button = get_object :run_new_evo_button

        @cancel_new_evo_button.signal_connect :clicked, &method(:cancel_new_evo)
        @report_to_file_toggle.signal_connect :toggled, &method(:toggle_report_to_file)
        @infinite_generations_toggle.signal_connect :toggled, &method(:toggle_generations_form)
        @original_image_path.signal_connect :"file-set", &method(:set_preview_image)
        @run_evo_button.signal_connect :clicked, &method(:start_new_evo)

        @new_evo_form.show
        
      end

      def cancel_new_evo(e)
        @new_evo_form.destroy
      end

      def toggle_report_to_file(e)
        @report_path_chooser.sensitive = e.active?
      end

      def toggle_generations_form(e)
        @generations_number_button.sensitive = !e.active?
      end

      def set_preview_image(e)
        @image_preview.from_file = e.filename
        @image_info_label.text = "Tamaño: #{@image_preview.pixbuf.width}x#{@image_preview.pixbuf.height}"
      end

      def start_new_evo(e)
        unless @original_image_path.filename
          dialog = Gtk::MessageDialog.new(parent: @new_evo_form,
                                          flags: :destroy_with_parent,
                                          type: :error,
                                          buttons: :ok,
                                          message: "Debe seleccionar una imagen")
          dialog.run
          dialog.destroy
        else
          options = {
            population: @population_size_button.value,
            generations: (if @infinite_generations_toggle.active?
                          -1
                         else
                           @generations_number_button.value
                          end),
            instructions: @number_instructions_button.value,
            report_path: (if @report_to_file_toggle.active?
                          nil
                         else
                           @report_path_chooser.filename
                          end),
            image: @original_image_path.filename
          }
          @new_evo_form.destroy
          @parent.on_new_evo_run options
        end
      end
    end
  end
end
