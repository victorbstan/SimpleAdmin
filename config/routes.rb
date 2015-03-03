SimpleAdmin::Engine.routes.draw do
  # admin lib
  get    '/'                              => "admin#index",          as: :admin
  get    '/model_index/:model_name'       => "admin#model_index",    as: :admin_model_index
  get    '/model_edit/:model_name/:id'    => "admin#model_edit",     as: :admin_model_edit
  get    '/model_new/:model_name'         => "admin#model_new",      as: :admin_model_new
  post   '/model_create/:model_name'      => "admin#create",         as: :admin_model_create
  put    '/model_edit/:model_name/:id'    => "admin#update",         as: :admin_model_update
  delete '/model_destroy/:model_name/:id' => "admin#destroy",        as: :admin_model_destroy
  get    '/extension/:name'               => "admin#extension",      as: :admin_extension
  post   '/extension_post/:name'          => "admin#extension_post", as: :admin_extension_post
end
