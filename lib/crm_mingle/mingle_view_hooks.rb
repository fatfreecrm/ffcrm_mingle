class MingleViewHooks < FatFreeCRM::Callback::Base

  # --------------------------------------------------------------------
  insert_before :show_account_bottom do |view, context|
    view.render(:partial => "mingle/list", :locals => {:related => view.instance_variable_get(:@account)
})
  end

  # --------------------------------------------------------------------
  insert_before :show_contact_bottom do |view, context|
    view.render(:partial => "mingle/list", :locals => {:related => view.instance_variable_get(:@contact)
})
  end

  # --------------------------------------------------------------------
  insert_before :show_opportunity_bottom do |view, context|
    view.render(:partial => "mingle/list", :locals => {:related => view.instance_variable_get(:@opportunity)
})
  end

end
