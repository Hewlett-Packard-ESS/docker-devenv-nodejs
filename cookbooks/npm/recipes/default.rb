def default_value(val, default)
  if val.nil?
    return default
  end
  if val.is_a? Numeric
    return BigDecimal.new(val).to_i
  elsif val.downcase === 'true'
    return true
  elsif val.downcase === 'false'
    return false
  else
    return val
  end
end


npmrcConfig = {
  :registry => ENV['npm_registry'],
  :sslVerify => default_value(ENV['npm_ssl_verify'], true)
}

template '/home/docker/.npmrc' do
  source '.npmrc.erb'
  user 'docker'
  group 'docker'
  variables ({ :confvars => npmrcConfig })
  action :create_if_missing
end
