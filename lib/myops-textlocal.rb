class MyopsTextlocal < ::Rails::Railtie
  initializer 'myops.textlocal.initialize' do
    require 'my_ops/sms_providers/text_local'
  end
end
