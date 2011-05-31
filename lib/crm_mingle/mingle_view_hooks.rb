class MingleViewHooks < FatFreeCRM::Callback::Base

  # --------------------------------------------------------------------
  insert_before :show_contact_bottom do |view, context|
    view.render(:partial => "mingle/list")
  end

end
